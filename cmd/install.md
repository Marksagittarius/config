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

## 新增工具

```sh
# 系统监控 / 终端复用
brew install btop bottom cmux

# 文件 / 命令增强
brew install bat eza vivid lazygit neofetch

# 编辑器
brew install neovim
# Zed (GUI, 可选)
brew install --cask zed
```

## 配置部署

- `nvim/` → `~/.config/nvim/`（需 clone everforest 插件，见 `nvim/install.md`）
- `ghostty/` → `~/.config/ghostty/`
- `starship/` → `~/.config/starship.toml`
- `tmux/` → `~/.tmux.conf`（需 TPM）
- `aerospace/` → `~/.aerospace.toml`
- `yazi/` → `~/.config/yazi/`
- `zsh/` → `~/.zshrc`
- `btm/ btop/ cmux/ bat/ eza/ vivid/ lazygit/ neofetch/ opencode/` → `~/.config/<name>/`
- `zed/` → `~/.config/zed/`
- `vscode/` → VSCode 用户 settings.json
