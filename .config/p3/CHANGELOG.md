# Changelog

## 2025-12-29

### Fixed

- **10-cc.sh**: Fixed `command not found: 1` error on line 42
  - Changed `if $HAS_CLANG` to `if [ -n "$HAS_CLANG" ]` for proper boolean check
  - Changed `if $HAS_GCC` to `if [ -n "$HAS_GCC" ]` for proper boolean check

- **10-cc.sh**: Fixed `cut: the delimiter must be a single character` error on line 48
  - Changed `cut -d' '-f3` to `cut -d' ' -f3` (added missing space)

- **42-bun.sh**: Fixed `unmatched "` error on line 7
  - Changed `var "BUN_INSTALL_CACHE_DIR "` to `var "BUN_INSTALL_CACHE_DIR"` (fixed missing quote)
