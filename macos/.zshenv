# Rust
. "$HOME/.cargo/env"

# uv
export PATH="/Users/graham/.local/bin:$PATH"

# JDK
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# LLVM
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

# Ruby
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="/opt/homebrew/lib/ruby/gems/3.3.0/bin:$PATH"

# PostgreSQL
export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"

# GHC
[ -f "/Users/graham/.ghcup/env" ] && . "/Users/graham/.ghcup/env" # ghcup-env
export PATH="$PATH:$HOME/.ghcup/bin"
