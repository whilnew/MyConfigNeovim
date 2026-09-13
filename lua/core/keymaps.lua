local map = vim.keymap.set

-- Function to calculate 1/3 of the current window height
local function scroll_one_third(direction)
    local win_height = vim.api.nvim_win_get_height(0)
    local lines = math.floor(win_height / 3)
    if lines < 1 then lines = 1 end

    -- Execute the scroll command in Neovim
    vim.cmd("normal! " .. lines .. direction)
end

local function scroll_whole_buffer(direction)
    local buff_size = vim.api.nvim_buf_line_count(0)
    vim.cmd("normal! " .. buff_size .. direction)
end

-- Scroll DOWN 1/3 of the screen
map({ "n", "v", "i" }, "<A-J>", function() scroll_one_third("j") end, { desc = "Scroll down 1/3 of the screen lines" })

-- Scroll UP 1/3 of the screen
map({ "n", "v", "i" }, "<A-K>", function() scroll_one_third("k") end, { desc = "Scroll up 1/3 of the screen lines" })

-- Scroll to the top of the file
map({ "n", "v", "i" }, "<A-0>", function() scroll_whole_buffer("k") end, { desc = "Scroll to top of file" })

-- Scroll to the bottom of the file
map({ "n", "v", "i" }, "<A-9>", function() scroll_whole_buffer("j") end, { desc = "Scroll to bottom of file" })

-- Navigation
map({ "n", "v" }, "<A-h>", "h", { desc = "Left" })
map({ "n", "v" }, "<A-j>", "j", { desc = "Down" })
map({ "n", "v" }, "<A-k>", "k", { desc = "Up" })
map({ "n", "v" }, "<A-l>", "l", { desc = "Right" })

map({ "i" }, "<A-h>", "<C-o>h", { desc = "Left" })
map({ "i" }, "<A-j>", "<C-o>j", { desc = "Down" })
map({ "i" }, "<A-k>", "<C-o>k", { desc = "Up" })
map({ "i" }, "<A-l>", "<C-o>l", { desc = "Right" })

-- Alt+1 goes to the beginning of the line, Alt+2 goes to the end of the line
map({ "n", "v" }, "<A-2>", "$", { desc = "Jump to end of line" })
map({ "n", "v" }, "<A-1>", "^", { desc = "Jump to beginning of line" })
map("i", "<A-2>", "<C-o>$", { desc = "Jump to end of line while in Insert mode" })
map("i", "<A-1>", "<C-o>^", { desc = "Jump to beginning of line while in Insert mode" })
-- Note: In Insert Mode, prefer the Alt combo (A-1, A-2) so you don't lose the ability to type the digits 1 and 2
--map("i", "<A-1>", "<C-o>^", { desc = "Jump to beginning of line while in Insert" })
--map("i", "<A-2>", "<C-o>$", { desc = "Jump to end of line while in Insert" })

-- Open / Close File Explorer (Neo-tree)
map("n", "<leader>ex", "<cmd>Neotree toggle<cr>", { desc = "Toggle File Explorer" })

-- Open / Close the Markdown viewer
map({ "n", "v", "i" }, "<A-M>", "<cmd>MarkdownPreviewToggle<cr>", { desc = "Toggle Markdown viewer" })

-- Search with Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files in project" })
map("n", "<leader>fk", "<cmd>Telescope live_grep<cr>", { desc = "Search keyword across the project" })
map("n", "<leader>lb", "<cmd>Telescope buffers<cr>", { desc = "List open buffers" })

-- Buffer management (file tabs)
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
map({ "n", "v", "i" }, "<A-]>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map({ "n", "v", "i" }, "<A-[>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
map("n", "<A-|>", "<cmd>bp | bd #<cr>", { desc = "Close current buffer" })

-- LSP keymaps (only active once LSP attaches to the file)
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local opts = { buffer = args.buf }
        map({ "n", "v", "i" }, "<A-d>", vim.lsp.buf.definition, opts)          -- Jump to function/variable definition
        map({ "n", "v", "i" }, "<A-i>", vim.lsp.buf.hover, opts)                -- View documentation/type info
        map({ "n", "v", "i" }, "<A-r>", vim.lsp.buf.rename, opts)           -- Rename variable across the project
        map({ "n", "v", "i" }, "<A-a>", vim.lsp.buf.code_action, opts)      -- Quick fix (Code Action)
        map({ "n", "v", "i" }, "<A-v>", vim.lsp.buf.references, opts)          -- View all references to this function
        map({ "n", "v", "i" }, "<A-F>", function() vim.lsp.buf.format({ async = true }) end, opts) -- Format code
    end,
})

-- View error
map({ "n", "v", "i" }, "<A-e>", function() vim.diagnostic.open_float(nil, { focusable = false, scope = "line" }) end, opts)

-- Turn off search highlight with <Esc>
map("n", "<Esc>", "<cmd>nohlsearch<cr>")

-- Other shortcuts but in Insert Mode
map("i", "<A-o>", "<C-o>o", { desc = "New line and Insert while already insert mode" })
map({ "n", "v" }, "<A-o>", "o", { desc = "New line and Insert" })
