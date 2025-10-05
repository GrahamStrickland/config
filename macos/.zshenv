# Rust
. "$HOME/.cargo/env"

# uv
export PATH="/Users/graham/.local/bin:$PATH"

# JDK
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# LLVM
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

# Ruby
export PATH="/opt/homebrew/Cellar/ruby/3.4.6/bin/:$PATH"

# PostgreSQL
export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"

# GHC
[ -f "/Users/graham/.ghcup/env" ] && . "/Users/graham/.ghcup/env" # ghcup-env
export PATH="$PATH:$HOME/.ghcup/bin"
