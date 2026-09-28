# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

# 提示符由 Starship 提供（Catppuccin Mocha），故关闭 oh-my-zsh 自带主题
ZSH_THEME=""

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	zsh-syntax-highlighting
        zsh-autosuggestions
	vi-mode
	fzf
)

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#7a8478"


source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

alias python="/usr/bin/python3"

source $ZSH_CUSTOM/plugins/incr/incr.zsh

JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk-21.jdk/Contents/Home"
export JAVA_HOME
PATH=$PATH:$JAVA_HOME/bin
export PATH
export CLASS_PATH

GRADLE_USER_HOME="$HOME/.gradle"
export GRADLE_USER_HOME

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$($HOME/anaconda3/bin/conda 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/anaconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
export PATH="/opt/homebrew/opt/libressl/bin:$PATH"
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-L/opt/homebrew/opt/llvm/lib -Wl,-rpath,/opt/homebrew/opt/llvm/lib"
export LLVM_HOST_TRIPLE=x86_64-apple-darwin22

export PATH="/opt/homebrew/opt/python/libexec/bin:$PATH"
alias python="/opt/homebrew/bin/python3"
alias pip="pip3"

export LDFLAGS="-L/opt/homebrew/opt/openblas/lib"
export CPPFLAGS="-I/opt/homebrew/opt/openblas/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/openblas/lib/pkgconfig"
eval "$(starship init zsh)"
eval $(thefuck --alias)

eval "$(zoxide init zsh --cmd z)"
export PATH="/opt/homebrew/opt/curl/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/curl/lib"
export CPPFLAGS="-I/opt/homebrew/opt/curl/include"
export PATH="/opt/homebrew/opt/git/bin:/opt/homebrew/opt/curl/bin:$PATH"
export PATH="/opt/homebrew/Cellar/node/24.10.0_1/bin:$PATH"

if [[ -n "${GHOSTTY_RESOURCES_DIR:-}" ]]; then
    ghostty_set_title() {
        local dir="${PWD/#$HOME/~}"
        printf '\033]2;%s\033\\' "$dir"
    }

    autoload -Uz add-zsh-hook
    add-zsh-hook chpwd ghostty_set_title
    add-zsh-hook precmd ghostty_set_title
    add-zsh-hook preexec ghostty_set_title
    ghostty_set_title
fi

function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

# Cangjie
source "$HOME/Documents/cangjie/envsetup.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Hermes Agent / cua-driver-rs — ensure ~/.local/bin is on PATH
export PATH="$HOME/.local/bin:$PATH"

# ── fzf: Catppuccin Mocha ──────────────────────────────
export FZF_DEFAULT_OPTS=" \
  --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
  --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
  --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
  --color=border:#45475a,label:#cdd6f4,query:#f5c2e7 \
  --preview-window='border-left'"

# ── LS_COLORS: Catppuccin Mocha (vivid; 供 lsd / GNU ls / 补全菜单使用) ──
if [ -r "$HOME/.config/vivid/ls_colors_mocha" ]; then
  export LS_COLORS="$(<"$HOME/.config/vivid/ls_colors_mocha")"
fi
# 注意：新版 eza 也会读 LS_COLORS，会覆盖其 theme.yml 的文件类型配色。
# 这里包一层：运行 eza 时临时屏蔽 LS_COLORS，让它专走 ~/.config/eza/theme.yml
# （theme.yml 是更精细的官方 Mocha 配色），lsd 则继续用上面的 LS_COLORS。
eza() { (unset LS_COLORS; command eza "$@") }

# ── Rust / Cargo 工具链 (rustup, Homebrew 安装) ──
# Homebrew 的 rustup 是 keg-only（与 rust 冲突），编译器代理在 opt/rustup/bin。
# 放在 ~/.cargo/bin 之前，使 rustc/cargo/rustfmt/clippy/rust-analyzer 走 rustup 管理。
export PATH="$HOME/.cargo/bin:/opt/homebrew/opt/rustup/bin:$PATH"

# ── Everforest Dark 高亮（zsh-syntax-highlighting / autosuggestions）──
# 与 starship / ghostty / tmux / nvim 统一 everforest 色板
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#7a8478"

ZSH_HIGHLIGHT_STYLES[default]=fg=#d3c6aa
ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=#e67e80,bold
ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=#d699b6
ZSH_HIGHLIGHT_STYLES[alias]=fg=#a7c080
ZSH_HIGHLIGHT_STYLES[builtin]=fg=#7fbbb3
ZSH_HIGHLIGHT_STYLES[function]=fg=#a7c080
ZSH_HIGHLIGHT_STYLES[command]=fg=#7fbbb3
ZSH_HIGHLIGHT_STYLES[precommand]=fg=#e69875,underline
ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=#d699b6
ZSH_HIGHLIGHT_STYLES[hashed-command]=fg=#7fbbb3
ZSH_HIGHLIGHT_STYLES[path]=fg=#83c092,underline
ZSH_HIGHLIGHT_STYLES[path_pathseparator]=fg=#83c092
ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]=fg=#83c092
ZSH_HIGHLIGHT_STYLES[globbing]=fg=#d699b6
ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=#d699b6
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=#dbbc7f
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=#dbbc7f
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=fg=#d3c6aa
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=#dbbc7f
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=#dbbc7f
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=#e69875
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=#e69875
ZSH_HIGHLIGHT_STYLES[assign]=fg=#dbbc7f
ZSH_HIGHLIGHT_STYLES[comment]=fg=#7a8478,italic
ZSH_HIGHLIGHT_STYLES[autodirectory]=fg=#83c092,underline
