-- Editor configuration with file tree and additional features
return {
  -- File tree
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('nvim-tree').setup({
        sort_by = 'case_sensitive',
        view = {
          adaptive_size = true,
          centralize_selection = false,
          width = 30,
          side = 'left',
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = false,
        },
      })
      
      -- Keybindings for nvim-tree
      vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<cr>', { desc = 'Toggle file [E]xplorer' })
      vim.keymap.set('n', '<leader>E', '<cmd>NvimTreeFocus<cr>', { desc = 'Focus file [E]xplorer' })
    end,
  },
  
  -- Enhanced search and replace with ripgrep
  {
    'nvim-pack/nvim-spectre',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('spectre').setup({
        color_devicons = true,
        open_cmd = 'vnew',
        live_update = false, -- auto execute search again when you write to any file in vim
        line_sep_start = '┌─────────────────────────────────────────',
        result_padding = '¦  ',
        line_sep       = '└─────────────────────────────────────────',
        highlight = {
            ui = "String",
            search = "DiffChange",
            replace = "DiffDelete"
        },
        mapping={
          ['toggle_line'] = {
              map = "dd",
              cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
              desc = "toggle current item"
          },
          ['enter_file'] = {
              map = "<cr>",
              cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
              desc = "goto current file"
          },
          ['send_to_qf'] = {
              map = "<leader>q",
              cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
              desc = "send all items to quickfix"
          },
          ['replace_cmd'] = {
              map = "<leader>c",
              cmd = "<cmd>lua require('spectre.actions').replace_cmd()<CR>",
              desc = "input replace command"
          },
          ['show_option_menu'] = {
              map = "<leader>o",
              cmd = "<cmd>lua require('spectre').show_options()<CR>",
              desc = "show options"
          },
          ['run_current_replace'] = {
              map = "<leader>rc",
              cmd = "<cmd>lua require('spectre.actions').run_current_replace()<CR>",
              desc = "replace current line"
          },
          ['run_replace'] = {
              map = "<leader>R",
              cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
              desc = "replace all"
          },
          ['change_view_mode'] = {
              map = "<leader>v",
              cmd = "<cmd>lua require('spectre').change_view()<CR>",
              desc = "change result view mode"
          },
          ['change_replace_sed'] = {
            map = "trs",
            cmd = "<cmd>lua require('spectre').change_engine_replace('sed')<CR>",
            desc = "use sed to replace"
          },
          ['change_replace_oxi'] = {
            map = "tro",
            cmd = "<cmd>lua require('spectre').change_engine_replace('oxi')<CR>",
            desc = "use oxi to replace"
          },
          ['toggle_live_update']= {
            map = "tu",
            cmd = "<cmd>lua require('spectre').toggle_live_update()<CR>",
            desc = "update when vim writes to file"
          },
          ['toggle_ignore_case'] = {
            map = "ti",
            cmd = "<cmd>lua require('spectre').change_options('ignore-case')<CR>",
            desc = "toggle ignore case"
          },
          ['toggle_ignore_hidden'] = {
            map = "th",
            cmd = "<cmd>lua require('spectre').change_options('hidden')<CR>",
            desc = "toggle search hidden"
          },
          ['resume_last_search'] = {
            map = "<leader>l",
            cmd = "<cmd>lua require('spectre').resume_last_search()<CR>",
            desc = "repeat last search"
          },
        },
        find_engine = {
          -- rg is map with rg command
          ['rg'] = {
            cmd = "rg",
            -- default args
            args = {
              '--color=never',
              '--no-heading',
              '--with-filename',
              '--line-number',
              '--column',
              '--smart-case',
              '--hidden',
              '--glob=!.git/',
            },
            options = {
              ['ignore-case'] = {
                value= "--ignore-case",
                icon="[I]",
                desc="ignore case"
              },
              ['hidden'] = {
                value="--hidden",
                desc="hidden file",
                icon="[H]"
              },
              -- you can put any rg search option you want here it can toggle with
              -- show_option function
            }
          },
        },
        replace_engine = {
          ['sed'] = {
            cmd = "sed",
            args = nil,
            options = {
              ['ignore-case'] = {
                value = "--ignore-case",
                icon = "[I]",
                desc = "ignore case"
              },
            }
          },
        },
        default = {
            find = {
                --pick one of item in find_engine
                cmd = "rg",
                options = {"ignore-case"}
            },
            replace={
                --pick one of item in replace_engine
                cmd = "sed"
            }
        },
        replace_vim_cmd = "cdo",
        is_open_target_win = true, --open file on opener window
        is_insert_mode = false  -- start open panel on is_insert_mode
      })
      
      -- Enhanced keymaps for find and replace
      vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', {
        desc = 'Toggle [S]pectre (Find & Replace)'
      })
      vim.keymap.set('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
        desc = '[S]earch current [w]ord (ripgrep)'
      })
      vim.keymap.set('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
        desc = '[S]earch selected text (ripgrep)'
      })
      vim.keymap.set('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
        desc = '[S]earch in current file (ripgrep)'
      })
      -- Additional ripgrep-powered search keymaps
      vim.keymap.set('n', '<leader>sW', function()
        require('spectre').open({
          select_word = true,
          search_text = vim.fn.expand('<cword>'),
          path = vim.fn.getcwd()
        })
      end, { desc = '[S]earch [W]ord in project (ripgrep)' })
      vim.keymap.set('n', '<leader>sF', function()
        require('spectre').open({
          path = vim.fn.expand('%:p:h')
        })
      end, { desc = '[S]earch in current [F]older (ripgrep)' })
    end,
  },
  
  -- Better buffer management
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('bufferline').setup {
        options = {
          diagnostics = 'nvim_lsp',
          separator_style = 'slant',
          show_buffer_close_icons = false,
          show_close_icon = false,
        }
      }
      
      -- Buffer navigation keymaps
      vim.keymap.set('n', '<leader>bp', '<Cmd>BufferLineTogglePin<CR>', { desc = 'Toggle pin' })
      vim.keymap.set('n', '<leader>bP', '<Cmd>BufferLineGroupClose ungrouped<CR>', { desc = 'Delete non-pinned buffers' })
      vim.keymap.set('n', '<leader>bo', '<Cmd>BufferLineCloseOthers<CR>', { desc = 'Delete other buffers' })
      vim.keymap.set('n', '<leader>br', '<Cmd>BufferLineCloseRight<CR>', { desc = 'Delete buffers to the right' })
      vim.keymap.set('n', '<leader>bl', '<Cmd>BufferLineCloseLeft<CR>', { desc = 'Delete buffers to the left' })
      vim.keymap.set('n', '<S-h>', '<cmd>BufferLineCyclePrev<cr>', { desc = 'Prev buffer' })
      vim.keymap.set('n', '<S-l>', '<cmd>BufferLineCycleNext<cr>', { desc = 'Next buffer' })
    end,
  },
  
  -- Better terminal integration
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      require('toggleterm').setup({
        size = 20,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = 'float',
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = 'curved',
          winblend = 0,
          highlights = {
            border = 'Normal',
            background = 'Normal',
          },
        },
      })
      
      -- Terminal keymaps
      vim.keymap.set('n', '<leader>tt', '<cmd>ToggleTerm<cr>', { desc = 'Toggle [T]erminal' })
      vim.keymap.set('n', '<leader>tf', '<cmd>ToggleTerm direction=float<cr>', { desc = 'Toggle [T]erminal [F]loat' })
      vim.keymap.set('n', '<leader>th', '<cmd>ToggleTerm size=10 direction=horizontal<cr>', { desc = 'Toggle [T]erminal [H]orizontal' })
      vim.keymap.set('n', '<leader>tv', '<cmd>ToggleTerm size=80 direction=vertical<cr>', { desc = 'Toggle [T]erminal [V]ertical' })
    end,
  },
  
  -- Enhanced commenting
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end,
  },
  
  -- Auto pairs
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      require('nvim-autopairs').setup({
        check_ts = true,
      })
    end,
  },
  
  -- Indent guides
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    config = function()
      require('ibl').setup({
        indent = {
          char = '│',
          tab_char = '│',
        },
        scope = { enabled = false },
        exclude = {
          filetypes = {
            'help',
            'alpha',
            'dashboard',
            'nvim-tree',
            'Trouble',
            'trouble',
            'lazy',
            'mason',
            'notify',
            'toggleterm',
            'lazyterm',
          },
        },
      })
    end,
  },
}
