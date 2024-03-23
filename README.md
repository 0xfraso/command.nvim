# command.nvim

Easily select and launch commands directly from neovim

It uses [`toggleterm.nvim`](https://github.com/akinsho/toggleterm.nvim) as backend

![image](https://github.com/0xfraso/command.nvim/assets/116293603/2d8cc2c5-585e-41ca-b65d-16549bfb44c6)

## 📦 Installation

### Lazy (recommended)

#### With defaults

```lua
{
  "0xfraso/command.nvim",
  opts = {}, -- see section below for configuration options
  dependencies = {
    "akinsho/toggleterm.nvim",
  }
}
```
## ⚙️ Configuration

### Defaults

```lua
{
  cache_file = vim.fn.stdpath("cache") .. "/commands", -- path to cache file
  sort = 'asc' -- Can be "asc", "desc" or "none"
```

## ⚡ Commands

`command.nvim` exposes the following user commands:

```
:CommandSelect
:CommandExecLast
:CommandPrompt
:CommandPromptLast
:CommandEdit
```

For example, you can map commands using `lazy.nvim`:

```lua
{
  "0xfraso/command.nvim",
  opts = {
    cache_file = vim.fn.stdpath("cache") .. "/commands", -- path to cache file
  },
  dependencies = {
    "akinsho/toggleterm.nvim",
    "stevearc/dressing.nvim", -- optional, but recommended
  },
  keys = {
    { "<leader>tl", ":CommandSelect<CR>",     desc = "Select command" },
    { "<leader>tp", ":CommandPrompt<CR>",     desc = "Prompt command" },
    { "<leader>tP", ":CommandPromptLast<CR>", desc = "Prompt last command" },
    { "<leader>tc", ":CommandExecLast<CR>",   desc = "Exec last command" },
    { "<leader>te", ":CommandEdit<CR>",       desc = "Edit commands file" },
  }
}
```
