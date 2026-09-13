vim.g.mapleader = " "         -- Leader key is Space
vim.g.maplocalleader = " "

local opt = vim.opt
opt.laststatus = 0            -- Completely hide Neovim's statusline
opt.number = true             -- Show line numbers
opt.tabstop = 4               -- 1 Tab = 4 spaces
opt.shiftwidth = 4            -- Indent size = 4
opt.expandtab = true          -- Convert Tab to spaces
opt.smartindent = true        -- Smart auto-indent
opt.wrap = false              -- Don't wrap lines at the edge of the screen
opt.ignorecase = true         -- Case-insensitive search
opt.smartcase = true          -- Case-sensitive if uppercase letters are typed
opt.termguicolors = true      -- Enable 24-bit color (True Color)
opt.signcolumn = "yes"        -- Always show the left column for Git & LSP warnings
opt.updatetime = 250          -- Reduce response wait time (ms)
opt.guicursor = ""            -- Keep BLOCK cursor shape in ALL modes
