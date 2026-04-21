# INSTALL

## Homebrew

```sh
# 安装 Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 将 brew 添加到 PATH (针对 Apple Silicon Mac)
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ~/.zshrc
eval "$(/opt/homebrew/bin/brew shellenv)"
```

```sh
# 安装编译器和运行环境
# gcc/llvm 提供 C/C++ 开发环境，nvm 管理 node 版本，pyenv 管理 python 版本
brew install go python node llvm cmake ninja gcc
```

```sh
brew install \
  fzf \
  eza \
  zoxide \
  bat \
  ripgrep \
  fd \
  httpie \
  tldr \
  thefuck \
  starship \
  git-delta
```

```sh
brew install --cask \
  visual-studio-code \
  iterm2 \
  docker \
  postman \
  tableplus \
  rectangle \
  raycast
```

```sh
brew install yazi ffmpeg sevenzip jq poppler fd ripgrep fzf zoxide
```
