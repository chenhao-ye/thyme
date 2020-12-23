if ! [ -d ~/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
if [ -z $ZSH_CUSTOM ] || ! [ -d $ZSH_CUSTOM ]; then
    ZSH_CUSTOM=~/.oh-my-zsh/custom
fi
cp thyme.zsh-theme $ZSH_CUSTOM/themes/
sed -i 's/\(^ZSH_THEME=.*$\)/ZSH_THEME="thyme"/g' ~/.zshrc
