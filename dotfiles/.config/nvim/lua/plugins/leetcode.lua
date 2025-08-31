-- LeetCode integration
return {
  -- LeetCode plugin for competitive programming
  {
    'kawre/leetcode.nvim',
    build = ':TSUpdate html',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'nvim-lua/plenary.nvim', -- required by telescope
      'MunifTanjim/nui.nvim',
      
      -- optional
      'nvim-treesitter/nvim-treesitter',
      'rcarriga/nvim-notify',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('leetcode').setup({
        -- configuration goes here
        arg = 'leet',
        lang = 'python3',
        cn = { -- leetcode.cn
          enabled = false,
          translator = true,
          translate_problems = true,
        },
        
        storage = {
          home = vim.fn.stdpath('data') .. '/leetcode',
          cache = vim.fn.stdpath('cache') .. '/leetcode',
        },
      })
      
      vim.keymap.set('n', '<leader>lq', '<cmd>Leet<cr>', { desc = '[L]eet [Q]uestion' })
    end,
  },
}
