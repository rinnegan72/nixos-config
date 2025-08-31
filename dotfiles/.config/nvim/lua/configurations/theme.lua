-- Theme configuration and customizations
-- Additional theme-related settings beyond the main tokyo night setup

-- Ensure transparent background is properly applied
vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  callback = function()
    -- Make background transparent
    vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'EndOfBuffer', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'LineNr', { bg = 'none' })
    
    -- Make some specific highlights more visible on transparent background
    vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#1a1b26' })
    vim.api.nvim_set_hl(0, 'Visual', { bg = '#364A82' })
  end,
})

-- Set some theme preferences
vim.g.tokyonight_transparent_sidebar = true
vim.g.tokyonight_transparent = true
vim.g.tokyonight_enable_italic = false
