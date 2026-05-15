-- Leader Key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Function Shortens
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- NeoVim Keymaps --
-- Navigate windows
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize splits
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
keymap("n", "<S-j>", ":m .+1<CR>==", opts)
keymap("n", "<S-k>", ":m .-2<CR>==", opts)

keymap("v", "<S-j>", ":m .+1<CR>==", opts)
keymap("v", "<S-k>", ":m .-2<CR>==", opts)

keymap("x", "<S-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<S-k>", ":move '<-2<CR>gv-gv", opts)

-- Insert mode exit
keymap("i", "jk", "<ESC>", opts)
keymap("i", "kj", "<ESC>", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Modify pasting
keymap("v", "p", '"_dP', opts)

-- Change mode without copy
keymap("n", "cc", '"_cc', opts)
keymap("v", "c", '"_c', opts)

-- Close current buffer
keymap("n", "<C-w>", "<cmd>bd<CR>", opts)

-- Select entire word
keymap("n", "<S-w>", "viw", opts)

-- Clear filter
keymap("n", "<C-c>", "<cmd>noh<CR>", opts)

-- Reload Buffer
keymap("n", "<C-e>", "<cmd>e!<CR>", opts)

-- Delete word as out of NeoVim
keymap("i", "<C-BS>", "<C-W>", opts)
keymap("i", "<C-Del>", "<C-O>dE", opts)

-- Plugins Keymaps --
-- File Explorer (Carbon)
keymap("n", "<C-f>", "<cmd>Carbon<CR>", opts)

-- SnipRun
keymap("v", "x", "<Plug>SnipRun", opts)

-- Cmdline
-- keymap("n", ":", "<cmd>FineCmdline<CR>", opts)
-- keymap("v", ":", "<cmd>FineCmdline<CR>", opts)

-- Format code
keymap("n", "<C-b>", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", opts)
keymap("i", "<C-b>", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", opts)

-- visual mode (only formats selection)
vim.keymap.set("v", "<C-b>", function()
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  vim.lsp.buf.format({
    async = true,
    range = {
      ["start"] = { start_pos[2], start_pos[3] - 1 },
      ["end"] = { end_pos[2], end_pos[3] - 1 },
    },
  })
end, opts)

-- Copy all matching lines
vim.keymap.set('v', '<leader>a', ':CopyMatchedLines<CR>', {
  noremap = true,
  silent = true,
  desc = "Copy all lines containing visual selection"
})
