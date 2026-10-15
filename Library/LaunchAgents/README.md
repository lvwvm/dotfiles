# ~/Library/LaunchAgents

macOS port of `.config/systemd/user`. launchd loads every `.plist` here at GUI
login, so these files sit at their real path in the repo, the same way the
systemd units do.

The Linux units stay where they are; this is the `$P3_OS = Darwin` half of the
same set.

## Mapping

| systemd unit | launchd agent |
| --- | --- |
| `gpg-agent.service` | `org.gnupg.gpg-agent.plist` |
| `gpg-agent.socket`, `gpg-agent-{ssh,extra,browser}.socket` | folded into the agent (see below) |
| `gpg-agent-ssh.socket` — `ExecStartPost` half | `org.gnupg.gpg-agent-ssh.plist` |
| `dirmngr.service`, `dirmngr.socket` | `org.gnupg.dirmngr.plist` |
| `emacs.service` | `org.gnu.emacs.plist` |
| `emacs-doom.service` | `org.gnu.emacs.doom.plist` |
| `editors.target`, `editor-services.target` | no equivalent |
| `geoclue-agent.service` | not ported (Linux-only) |

## What does not port

**Socket activation.** launchd has socket activation, but the handshake is
`launch_activate_socket(3)`, and GnuPG only implements systemd's `LISTEN_FDS`
protocol — under an option GnuPG 2.5 has renamed to
`--deprecated-supervised`. So the four socket units have no counterpart. Nothing is lost functionally:
`gpg-agent --daemon` creates `S.gpg-agent`, `.extra` and `.browser` itself, and
`--enable-ssh-support` adds `.ssh`. The paths differ from the units' hardcoded
`%t/gnupg/d.4dofe5jn3r6ymw9kfcyt4eei/...` because macOS has no
`$XDG_RUNTIME_DIR`; gnupg puts the sockets in `$GNUPGHOME` instead — which on
Darwin is under `~/Library/Application Support`. Ask
`gpgconf --list-dir socketdir` rather than assuming any of the three layouts.

**Supervision, for the gnupg pair.** `--no-detach` is documented as keeping the
process in the foreground, and does not: gpg-agent 2.5.21 forks and exits 0
either way, in both argument orders, leaving the agent reparented to init.
launchd then SIGTERMs that orphan as ordinary job cleanup — so the first cut of
these plists started an agent and killed it seconds later.

Both gnupg jobs are therefore launchers, not supervisors:

- `AbandonProcessGroup` stops launchd from killing the forked agent.
- `KeepAlive` is off. A job that exits by design cannot be kept alive; with it
  on, launchd spawns a fresh agent every `ThrottleInterval`, forever.

`Restart=on-failure` has no counterpart in that arrangement. gnupg covers it
itself — `gpg`, `gpgsm` and `gpg-connect-agent` each launch an agent on demand
when the socket does not answer, verified by killing the agent and watching the
next client bring one back.

The Emacs jobs keep `KeepAlive`/`SuccessfulExit`, since `--fg-daemon` genuinely
does stay in the foreground. That is the one path not exercised here: Emacs is
not installed on this machine.

**Targets.** launchd has no dependency graph and no ordering between agents —
everything is started in parallel and expected to tolerate it. The editor
targets existed to group and order; the group survives only as the shared
`org.gnu.emacs` label prefix, which is enough for `launchctl print` but not for
bulk enable/disable. `After=`/`Wants=` on the gpg sockets is dropped for the
same reason.

**geoclue.** geoclue feeds redshift a location over D-Bus. macOS has neither;
its equivalent, Night Shift, is part of the OS and needs no agent.

## Environment

The agents run their command through `/bin/sh -lc` so that `$GNUPGHOME`,
`$GNUPG_AGENT_CONF`, `$DIRMNGR_CONF`, `$DOOM_DATA_DIR` and a `PATH` that finds
Homebrew come from p3 — the same dependency the units had on the systemd user
environment, and the reason no `$HOME` or `/opt/homebrew` is spelled out here.
launchd gives a job `/usr/bin:/bin:/usr/sbin:/sbin` and nothing else, and its
plists cannot expand variables.

If Emacs is installed as `Emacs.app` rather than a Homebrew formula, put its
`Contents/MacOS/bin` on `PATH` in p3 — these agents resolve `emacs` by lookup.

`StandardOutPath` has the same no-variables limitation, so each supervised job
redirects to `$XDG_VAR_HOME/log/<label>.log` itself. That is the journald
replacement: without it launchd sends daemon output to `/dev/null`.

## Guards

Every job opens with the launchd spelling of p3's `has`:

```sh
command -v emacs >/dev/null 2>&1 || exit 0
```

Exit 0 reads to `KeepAlive`/`SuccessfulExit` as "finished, do not restart", so
an Emacs daemon whose binary is not installed goes quiet instead of failing
every `ThrottleInterval` forever. The gnupg jobs add a second such guard, which
keeps them idempotent: `gpg` auto-spawns an agent on demand, and a duplicate
start is a hard error ("a gpg-agent is already running - not starting a new
one"). With it, `launchctl kickstart` on a live agent is a no-op — verified,
PID unchanged, still exactly one agent. That guard is `pgrep -x -U "$(id -u)"`,
not `gpg-connect-agent --no-autostart /bye`, which exits 0 whether or not an
agent answers and so cannot decide anything.

They also create `$GNUPGHOME` at 0700 if it is missing. gpg-agent does not
create its own homedir — it fails to bind the socket and exits. On Darwin
`10-xdg.sh` roots `XDG_DATA_HOME` at `~/Library/Application Support`, so
`$GNUPGHOME` is `~/Library/Application Support/gnupg`: the parent always
exists, the gnupg directory under it does not. Both jobs do the check, since
launchd starts agents in parallel and neither can assume the other went first.

The space in that path is load-bearing for the wrappers — every expansion of
`$GNUPGHOME` in them is quoted. Socket paths stay well inside the 104-character
`sun_path` limit (`S.gpg-agent.browser` lands at 66).

## Operating

```sh
launchctl bootstrap gui/$UID ~/Library/LaunchAgents/org.gnupg.gpg-agent.plist
launchctl bootout    gui/$UID/org.gnupg.gpg-agent   # ~ systemctl --user stop
launchctl kickstart -k gui/$UID/org.gnupg.gpg-agent # ~ systemctl --user restart
launchctl print       gui/$UID/org.gnupg.gpg-agent  # ~ systemctl --user status
```

`ExecReload` has no counterpart; reload in place with
`gpgconf --reload gpg-agent` (or `dirmngr`), which is what the units invoked
anyway.

`launchctl print` reports `state = not running` with `last exit code = 0` for
all five, and that is success here, not failure: four of them are one-shots by
design, and the fifth (`org.gnu.emacs`) has guarded itself off. Look for the
daemon with `pgrep`, not in the job table.

One caveat found while testing: an agent that gnupg auto-relaunches is started
as `gpg-agent --homedir ... --daemon`, without the `--options` these jobs pass.
It therefore reads `$GNUPGHOME/gpg-agent.conf`, which does not exist — the
config lives at `$XDG_CONFIG_HOME/gnupg/gpg-agent.conf`. Nothing breaks today
(ssh support is on by default in 2.5), but a `pinentry-program` or cache-TTL
set there would apply only to a launchd-started agent. Putting the file where
gnupg looks by default would close that gap.
