-- Terraform/HCL development tools
return {
  -- Terraform language support
  {
    'hashivim/vim-terraform',
    ft = { 'terraform', 'hcl' },
    config = function()
      vim.g.terraform_align = 1
      vim.g.terraform_fmt_on_save = 1
    end,
  },
  
  -- Enhanced Terraform/HCL syntax
  {
    'cappyzawa/telescope-terraform.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    ft = { 'terraform', 'hcl' },
    config = function()
      require('telescope').load_extension('terraform')
      
      vim.keymap.set('n', '<leader>tf', '<cmd>Telescope terraform<cr>', { desc = '[T]elescope [T]erraform' })
    end,
  },
}
