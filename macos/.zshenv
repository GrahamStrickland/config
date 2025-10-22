# Rust
. "$HOME/.cargo/env"

# uv
export PATH="/Users/graham/.local/bin:$PATH"

# JDK
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# LLVM
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

# PostgreSQL
export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"

# GHC
[ -f "/Users/graham/.ghcup/env" ] && . "/Users/graham/.ghcup/env" # ghcup-env
export PATH="$PATH:$HOME/.ghcup/bin"

# Harbour
export PATH="/Users/graham/dev/harbour-3.2.0core/bin/darwin/clang:$PATH"

# Qt
export PATH="/opt/homebrew/opt/qt/bin:$PATH"
