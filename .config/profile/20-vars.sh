set_env_var "LC_ALL" "en_US.UTF-8"
set_env_var "LANG"  "en_US.UTF-8"

set_env_var "EDITOR" "$(command -v nvim)"
set_env_var "PAGER" "$(command -v less)"

set_env_var "PROFILE" "${XDG_CONFIG_HOME}/profile"
set_env_var "MAN_DISABLE_SECCOMP" "1"

set_env_var "QT_QPA_PLATFORMTHEME" "qt5ct"
