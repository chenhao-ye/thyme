#!/bin/zsh
set -e
if ! command -v starship >/dev/null 2>&1 ; then
    # if brew is available, use brew
    if command -v starship >/dev/null 2>&1 ; then
        brew install starship
    else
        curl -sS https://starship.rs/install.sh | sh
    fi
fi

mkdir -p "$HOME/.config/starship/"
cp thyme.toml "$HOME/.config/starship/thyme.toml"
echo 'export STARSHIP_CONFIG="$HOME/.config/starship/thyme.toml"' >> $HOME/.zshrc
echo 'eval "$(starship init zsh)"' >> $HOME/.zshrc

echo "Thyme is installed successfully!"
