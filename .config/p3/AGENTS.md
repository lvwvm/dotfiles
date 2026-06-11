# AGENTS.md

## What This Repo Is

**p3** is a modular POSIX-sh environment configuration system. Each `NN-name.sh` file is a "module" that sets environment variables for a specific tool or language. A separate loader (external to this repo) sources all modules in numeric order, providing helper functions at runtime.

## Runtime-Injected Helpers

The scripts **cannot run standalone** — they rely on three functions injected by the loader:

| Helper | Purpose |
|--------|---------|
| `var "KEY" "value"` | Export an environment variable |
| `has "cmd"` | Return true if `cmd` is on PATH |
| `err "msg"` | Print an error message |

Never define or redefine these in a module. Never use `export KEY=value` — always use `var`.

## Load Order Convention

Files are sourced in ascending numeric order. The prefixes encode dependency layers:

| Range | Layer |
|-------|-------|
| `00` | Core baseline (locale, TZ, PAGER, EDITOR) |
| `10` | Foundation: XDG dirs, C compiler, awk |
| `12–17` | System tools (awk, arch, bat, man, openssl, Qt) |
| `20` | Common dev tools (git, gpg, mu, ssh) |
| `25–30` | User/shell infrastructure (pass, colors, zsh) |
| `40–45` | Language toolchains (Go, Java, Lua, Node, OCaml, Python, Ruby, Rust, Vim, Bun, LLM keys) |
| `50` | Security tools (talisman) |
| `60` | Cloud/containers (GitHub, minikube, Wine) |
| `70–75` | Domain tools (cookiecutter, pro-audio, direnv) |
| `80` | Misc tools (ledger, mise) |
| `98–99` | High-level apps (Emacs distributions, tmux, Terraform, Vultr) |

**Choosing a number for a new module:** Pick a number in the appropriate layer. Modules later in the sequence can depend on variables set by earlier ones (e.g., `$XDG_DATA_HOME` is only available after `10-xdg.sh`).

## Critical Gotchas

- **Use `return`, never `exit`** — modules are sourced, not executed. `exit` would kill the parent shell.
- **Boolean variables must be tested with `[ -n "$VAR" ]`**, not `if $VAR`. The bug pattern `if $HAS_CLANG` is wrong; correct is `if [ -n "$HAS_CLANG" ]`.
- **`cut` delimiter must have a space**: `cut -d' ' -f3`, not `cut -d' '-f3`.
- **All directories should be created if missing**: follow the pattern `[ ! -d "$DIR" ] && mkdir "$DIR"` immediately after setting the variable.
- **`PATH` is built incrementally**: `10-xdg.sh` prepends `~/.local/bin`. Later modules extend `$PATH` by prepending to it via `var "PATH" "new:${PATH}"`.

## XDG Shorthand Variables

`10-xdg.sh` defines shorter aliases used throughout the codebase:

| Alias | Expands to |
|-------|------------|
| `$XDH` | `$XDG_DATA_HOME` (`~/.local/share`) |
| `$XBH` | `$XDG_BIN_HOME` (`~/.local/bin`) |
| `$XCH` | `$XDG_CONFIG_HOME` (`~/.config`) |
| `$XCA` | `$XDG_CACHE_HOME` (`~/.cache`) |

`$XDG_BUILD_HOME` (`~/.local/build`), `$XDG_LIB_HOME`, `$XDG_INCLUDE_HOME`, and `$XDG_VAR_HOME` are also defined but have no shorthand.

## Module Structure Pattern

```sh
#!/usr/bin/env sh

# Optional: define and call helper functions for complex setup
install_foo() { ... }
config_foo() {
  var "FOO_HOME" "${XDG_DATA_HOME}/foo"
  [ ! -d "${FOO_HOME}" ] && mkdir "${FOO_HOME}"
}

if ! has "foo"; then
  install_foo
fi

config_foo

# Clean up helpers — they pollute the environment otherwise
unset install_foo config_foo
```

Always `unset` any locally defined functions at the end of the module.

## Secrets

`45-llm.sh` contains API keys in plaintext. Do not add secrets to new modules without considering the security implications. The existing pattern is intentional for this personal config repo but should not be extended casually.
