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

# GHC/Haskell
[ -f "/Users/graham/.ghcup/env" ] && . "/Users/graham/.ghcup/env" # ghcup-env
export PATH="$PATH:$HOME/.ghcup/bin"
export PATH="$PATH:/Users/graham/.cabal/bin"

# Harbour
export PATH="/opt/harbour/bin:$PATH"

# Qt
export PATH="/opt/homebrew/opt/qt/bin:$PATH"

# .NET tools
export PATH="$PATH:/Users/graham/.dotnet/tools"
export DOTNET_ROOT="/opt/homebrew/opt/dotnet/libexec"

