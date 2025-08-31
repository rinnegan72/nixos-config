-- Enhanced Python development
return {
  -- Python-specific plugins and configurations
  {
    'linux-cultist/venv-selector.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
      'mfussenegger/nvim-dap',
      'mfussenegger/nvim-dap-python', -- Optional
      { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },
    },
    lazy = false,
    config = function()
      require('venv-selector').setup({
        settings = {
          search = {
            my_venvs = {
              command = 'find ~/.virtualenvs -maxdepth 1 -type d -name "*"'
            }
          }
        }
      })
    end,
    keys = {
      { '<leader>vs', '<cmd>VenvSelect<cr>' },
    },
  },
  
  -- DAP Python
  {
    'mfussenegger/nvim-dap-python',
    ft = 'python',
    dependencies = {
      'mfussenegger/nvim-dap',
      'rcarriga/nvim-dap-ui',
    },
    config = function()
      local path = '~/.local/share/nvim/mason/packages/debugpy/venv/bin/python'
      require('dap-python').setup(path)
      
      -- Add keymaps for Python debugging
      vim.keymap.set('n', '<leader>dpr', function() require('dap-python').test_method() end, { desc = 'Debug Python test method' })
      vim.keymap.set('n', '<leader>dpc', function() require('dap-python').test_class() end, { desc = 'Debug Python test class' })
      vim.keymap.set('v', '<leader>ds', function() require('dap-python').debug_selection() end, { desc = 'Debug Python selection' })
    end,
  },
}
