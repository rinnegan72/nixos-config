-- Additional custom keymaps
-- This file contains extra keymaps that don't belong to specific plugins

-- Better indenting in visual mode
vim.keymap.set('v', '<', '<gv', { desc = 'Indent left and keep selection' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent right and keep selection' })

-- Move lines up and down
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

-- Better page up/down (keep cursor centered)
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Page down and center' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Page up and center' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search result and center' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous search result and center' })

-- Paste without overwriting register
vim.keymap.set('x', '<leader>p', '"_dP', { desc = 'Paste without overwriting register' })

-- Delete to void register
vim.keymap.set('n', '<leader>d', '"_d', { desc = 'Delete to void register' })
vim.keymap.set('v', '<leader>d', '"_d', { desc = 'Delete to void register' })

-- Save file
vim.keymap.set('n', '<C-s>', '<cmd>w<cr>', { desc = 'Save file' })
vim.keymap.set('i', '<C-s>', '<esc><cmd>w<cr>', { desc = 'Save file' })

-- Quit
vim.keymap.set('n', '<leader>qq', '<cmd>qa<cr>', { desc = 'Quit all' })

-- Clear search highlighting
vim.keymap.set('n', '<leader>h', '<cmd>nohlsearch<cr>', { desc = 'Clear search highlights' })

-- Ripgrep shortcuts
vim.keymap.set('n', '<leader>rg', function()
  local word = vim.fn.expand('<cword>')
  vim.cmd('grep! ' .. word)
  vim.cmd('copen')
end, { desc = '[R]ip[g]rep current word' })

vim.keymap.set('n', '<leader>rG', function()
  local word = vim.fn.input('Ripgrep: ')
  if word ~= '' then
    vim.cmd('grep! ' .. word)
    vim.cmd('copen')
  end
end, { desc = '[R]ip[G]rep search' })

-- Quickfix navigation
vim.keymap.set('n', '<leader>qn', '<cmd>cnext<cr>', { desc = '[Q]uickfix [n]ext' })
vim.keymap.set('n', '<leader>qp', '<cmd>cprev<cr>', { desc = '[Q]uickfix [p]revious' })
vim.keymap.set('n', '<leader>qo', '<cmd>copen<cr>', { desc = '[Q]uickfix [o]pen' })
vim.keymap.set('n', '<leader>qc', '<cmd>cclose<cr>', { desc = '[Q]uickfix [c]lose' })
vim.keymap.set('n', '<leader>qf', '<cmd>cfirst<cr>', { desc = '[Q]uickfix [f]irst' })
vim.keymap.set('n', '<leader>ql', '<cmd>clast<cr>', { desc = '[Q]uickfix [l]ast' })

-- Location list navigation
vim.keymap.set('n', '<leader>ln', '<cmd>lnext<cr>', { desc = '[L]ocation [n]ext' })
vim.keymap.set('n', '<leader>lp', '<cmd>lprev<cr>', { desc = '[L]ocation [p]revious' })
vim.keymap.set('n', '<leader>lo', '<cmd>lopen<cr>', { desc = '[L]ocation [o]pen' })
vim.keymap.set('n', '<leader>lc', '<cmd>lclose<cr>', { desc = '[L]ocation [c]lose' })
