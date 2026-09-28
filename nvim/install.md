# nvim 安装说明

LazyVim 配置，依赖 [everforest.nvim](https://github.com/sainnhe/everforest) 主题插件（本地目录加载，未随仓库入库）。

## 步骤

```sh
# 1. 部署配置
git clone https://github.com/Marksagittarius/config.git
rsync -a --exclude 'everforest.nvim' config/nvim/ ~/.config/nvim/

# 2. clone 主题插件到配置引用的本地路径
# （lua/plugins/colorscheme.lua 中 dir = ~/.config/nvim/everforest.nvim）
git clone https://github.com/sainnhe/everforest ~/.config/nvim/everforest.nvim

# 3. 启动 nvim，lazy.nvim 会自动安装其余插件
nvim
```

## 说明

- 主题：everforest dark（`lua/plugins/colorscheme.lua` 可切换透明毛玻璃）
- 插件由 lazy.nvim 管理，锁定版本见 `lazy-lock.json`
- 语言支持：go / python / java / clangd / typescript（见 `lazyvim.json` extras）
