require("lazy").setup({
    -- UI / Colorscheme (Gruvbox)
{
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
        -- You can set background to "dark" or "light"
        vim.o.background = "dark"

        -- Configure soft/hard contrast as you like (optional)
        require("gruvbox").setup({
            contrast = "", -- Available modes: "hard", "soft" or "" (default)
        })

        vim.cmd.colorscheme("gruvbox")
    end,
    },

    -- File Explorer (Neo-tree)
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        opts = {
            filesystem = {
                filtered_items = { visible = true, hide_dotfiles = false },
                follow_current_file = { enabled = true },
            },
        },
    },

    -- Git integration (show changes in the sign column + blame)
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            current_line_blame = true, -- Show git commit info for the current line
        },
    },

    -- Syntax & Highlight (Treesitter, standard for Nvim 0.11+)
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
        vim.api.nvim_create_autocmd("FileType", {
            callback = function()
                pcall(vim.treesitter.start)
            end,
        })
        end,
    },

    -- LSP Config
    { "neovim/nvim-lspconfig" },

    -- Autocompletion
    {
        "saghen/blink.cmp",
        version = "*",
        opts = {
            keymap = { preset = "super-tab" }, -- Tab/Shift-Tab to select suggestions
            appearance = { use_nvim_cmp_as_default = true },
            sources = { default = { "lsp", "path", "snippets", "buffer" } },
        },
    },

    -- File & text search (Telescope)
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },

    -- This plugin still not work properly
    --[[
    {
    "vimpostor/vim-tpipeline",
    config = function()
    vim.g.tpipeline_autoembed = 1
    vim.g.tpipeline_restore = 1
    vim.g.tpipeline_statusline_side = 'right'
    end,
    },
    ]]

    -- markdown
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && npm install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    },
    -- Bufferline
    {
      "akinsho/bufferline.nvim",
      version = "*",
      dependencies = "nvim-tree/nvim-web-devicons",
      opts = {
        options = {
          mode = "buffers",
          diagnostics = "nvim_lsp",
          offsets = {
            {
              filetype = "neo-tree",
              text = "File Explorer",
              highlight = "Directory",
              text_align = "left",
            },
          },
        },
      },
    },
})
