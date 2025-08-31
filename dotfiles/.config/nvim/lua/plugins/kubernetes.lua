-- Kubernetes development tools
return {
  -- Kubernetes YAML support
  {
    'someone-stole-my-name/yaml-companion.nvim',
    ft = { 'yaml', 'yml' },
    dependencies = {
      'neovim/nvim-lspconfig',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      local cfg = require('yaml-companion').setup({
        lspconfig = {
          cmd = { 'yaml-language-server', '--stdio' },
          settings = {
            yaml = {
              keyOrdering = false,
            },
          },
        },
      })
      require('lspconfig')['yamlls'].setup(cfg)
      require('telescope').load_extension('yaml_schema')
      
      vim.keymap.set('n', '<leader>ks', '<cmd>Telescope yaml_schema<cr>', { desc = '[K]ubernetes [S]chema' })
    end,
  },
}
