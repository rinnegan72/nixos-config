-- Enhanced Rust development with Rustacenvim and additional tools
return {
  -- Rustacenvim - Enhanced Rust development
  {
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    lazy = false, -- This plugin is already lazy
    ft = { 'rust' },
    config = function()
      vim.g.rustaceanvim = {
        inlay_hints = {
          highlight = 'NonText',
        },
        tools = {
          hover_actions = {
            auto_focus = true,
          },
        },
        server = {
          on_attach = function(client, bufnr)
            -- you can also put keymaps in here
            vim.keymap.set('n', '<leader>cR', function()
              vim.cmd.RustLsp('codeAction')
            end, { desc = 'Code Action', buffer = bufnr })
            vim.keymap.set('n', '<leader>dr', function()
              vim.cmd.RustLsp('debuggables')
            end, { desc = 'Rust Debuggables', buffer = bufnr })
          end,
          default_settings = {
            ['rust-analyzer'] = {
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                buildScripts = {
                  enable = true,
                },
              },
              -- Add clippy lints for Rust
              checkOnSave = {
                allFeatures = true,
                command = 'clippy',
                extraArgs = { '--no-deps' },
              },
              procMacro = {
                enable = true,
                ignored = {
                  ['async-trait'] = { 'async_trait' },
                  ['napi-derive'] = { 'napi' },
                  ['async-recursion'] = { 'async_recursion' },
                },
              },
            },
          },
        },
      }
    end,
  },
  
  -- Crates.nvim for managing dependencies
  {
    'saecki/crates.nvim',
    ft = { 'rust', 'toml' },
    config = function()
      require('crates').setup {
        lsp = {
          enabled = true,
          on_attach = function(client, bufnr)
            -- the same on_attach function as for your other lsp's
          end,
          actions = true,
          completion = true,
          hover = true,
        },
        completion = {
          cmp = {
            enabled = true
          },
        },
      }
    end,
  },
  
  -- Enhanced syntax highlighting for Rust
  {
    'rust-lang/rust.vim',
    ft = 'rust',
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },
}
