# Thyme

Thyme is a shell theme based on [Starship](https://starship.rs). Compared to an oh-my-zsh-based theme, a starship-based theme is faster and more portable.

![thyme-screenshot](img/thyme-v3.1-screenshot.png)

Thyme's prompt shows:

- current time and execution time of the last command
- return value of the last command and its meaning (e.g. killed by which signal) if not zero
- job control status if there is at least one job
- git info (current branch name, dirty or not, status, etc.) if in a git repository

To install for zsh, clone this repo and run

```shell
zsh ./install.sh
```

OR install without cloning the repo:

```shell
# install starship; skip if you have starship installed already
curl -sS https://starship.rs/install.sh | sudo sh -s -- -y
# copy thyme to the starship directory and enable it
mkdir -p ~/.config/starship
curl -LsSf https://raw.githubusercontent.com/chenhao-ye/thyme/refs/heads/main/thyme.toml > ~/.config/starship/thyme.toml
echo 'export STARSHIP_CONFIG="$HOME/.config/starship/thyme.toml"' >> ~/.zshrc
echo 'eval "$(starship init zsh)"' >> ~/.zshrc
```
