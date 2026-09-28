# Config

Config files for DEV in MacOS. 使用本机配置管理，统一 **Everforest Dark** 主题风格。

## 目录结构

| 目录 | 工具 | 说明 |
|---|---|---|
| `nvim/` | Neovim | LazyVim 配置（lua/config + lua/plugins），everforest 主题、透明毛玻璃、动效增强 |
| `ghostty/` | Ghostty | 终端模拟器（Everforest Dark + 毛玻璃） |
| `zsh/` | Zsh | `.zshrc` + oh-my-zsh 安装脚本 |
| `tmux/` | tmux | TPM 插件管理 + Everforest 主题 + fzf 绑定 |
| `starship/` | Starship | 跨 shell 提示符（everforest_dark 色板） |
| `aerospace/` | AeroSpace | 平铺窗口管理器（含微信窗口浮动规则） |
| `yazi/` | Yazi | 终端文件管理器（flavors + git 插件） |
| `vim/` | Vim | amix/vimrc 配置 |
| `vscode/` | VSCode | 编辑器配置（Maple Mono、Catppuccin Mocha 图标） |
| `zed/` | Zed | 编辑器配置（Maple Mono、透明主题） |
| `btm/` | bottom | 系统监控（Everforest Dark） |
| `btop/` | btop | 系统监控（everforest / catppuccin 主题） |
| `cmux/` | cmux | 终端复用器配置 |
| `bat/` | bat | cat 增强（everforest 语法高亮主题） |
| `eza/` | eza | ls 增强（Everforest Dark 主题） |
| `vivid/` | vivid | LS_COLORS 生成器（catppuccin mocha） |
| `lazygit/` | lazygit | Git TUI（Catppuccin Mocha） |
| `neofetch/` | neofetch | 系统信息展示 |
| `opencode/` | opencode | AI 编码代理配置 |
| `fonts/` | Maple Mono | 字体（Nerd Font CN 版） |
| `wallpaper/` | — | 壁纸 |
| `cmd/` | — | 安装手册 |

## 快速开始

1. 按 `cmd/install.md` 安装 Homebrew 与工具链
2. 将各目录配置软链或复制到 `~/.config/<tool>/`（或对应位置）
3. nvim 需额外 clone everforest 主题插件，见 `nvim/install.md`
4. tmux 首次启动按 `prefix + I` 安装 TPM 插件
