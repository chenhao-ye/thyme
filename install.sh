if ! [ -d ~/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
cp thyme.zsh-theme $ZSH_CUSTOM/themes/
sed 's/\(^ZSH_THEME=.*$\)/ZSH_THEME="thyme"/g' ~/.zshrc
