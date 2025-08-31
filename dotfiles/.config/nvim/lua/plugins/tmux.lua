-- TMux integration
return {
  -- TMux navigation integration
  {
    'christoomey/vim-tmux-navigator',
    config = function()
      -- TMux Navigator keymaps (overrides the default window navigation)
      vim.keymap.set('n', '<C-h>', '<cmd>TmuxNavigateLeft<cr>', { desc = 'TMux navigate left' })
      vim.keymap.set('n', '<C-j>', '<cmd>TmuxNavigateDown<cr>', { desc = 'TMux navigate down' })
      vim.keymap.set('n', '<C-k>', '<cmd>TmuxNavigateUp<cr>', { desc = 'TMux navigate up' })
      vim.keymap.set('n', '<C-l>', '<cmd>TmuxNavigateRight<cr>', { desc = 'TMux navigate right' })
      vim.keymap.set('n', '<C-\\>', '<cmd>TmuxNavigatePrevious<cr>', { desc = 'TMux navigate previous' })
    end,
  },
}
