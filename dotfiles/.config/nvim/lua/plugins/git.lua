-- Git integration plugins
return {
  -- Lazygit integration
  {
    'kdheepak/lazygit.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      vim.keymap.set('n', '<leader>lg', '<cmd>LazyGit<cr>', { desc = '[L]azy[g]it' })
    end,
  },
  
  -- Enhanced git blame and diff features
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup({
        signs = {
          add          = { text = '┃' },
          change       = { text = '┃' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
          untracked    = { text = '┆' },
        },
        signs_staged = {
          add          = { text = '┃' },
          change       = { text = '┃' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
          untracked    = { text = '┆' },
        },
        signs_staged_enable = true,
        signcolumn = true,
        numhl = false,
        linehl = false,
        word_diff = false,
        watch_gitdir = {
          interval = 1000,
          follow_files = true
        },
        auto_attach = true,
        attach_to_untracked = false,
        current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
          ignore_whitespace = false,
          virt_text_priority = 100,
        },
        current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil,
        max_file_length = 40000,
        preview_config = {
          border = 'single',
          style = 'minimal',
          relative = 'cursor',
          row = 0,
          col = 1
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, {expr=true, desc = 'Next hunk'})

          map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, {expr=true, desc = 'Previous hunk'})

          -- Actions
          map('n', '<leader>hs', gs.stage_hunk, { desc = 'Stage hunk' })
          map('n', '<leader>hr', gs.reset_hunk, { desc = 'Reset hunk' })
          map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = 'Stage hunk' })
          map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = 'Reset hunk' })
          map('n', '<leader>hS', gs.stage_buffer, { desc = 'Stage buffer' })
          map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'Undo stage hunk' })
          map('n', '<leader>hR', gs.reset_buffer, { desc = 'Reset buffer' })
          map('n', '<leader>hp', gs.preview_hunk, { desc = 'Preview hunk' })
          map('n', '<leader>hb', function() gs.blame_line{full=true} end, { desc = 'Blame line' })
          map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'Toggle line blame' })
          map('n', '<leader>hd', gs.diffthis, { desc = 'Diff this' })
          map('n', '<leader>hD', function() gs.diffthis('~') end, { desc = 'Diff this ~' })
          map('n', '<leader>td', gs.toggle_deleted, { desc = 'Toggle deleted' })

          -- Text object
          map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'Select hunk' })
        end
      })
    end,
  },
  
  -- Git worktree support
  {
    'ThePrimeagen/git-worktree.nvim',
    config = function()
      require('git-worktree').setup()
      
      -- Telescope integration for git worktrees
      local telescope = require('telescope')
      telescope.load_extension('git_worktree')
      
      vim.keymap.set('n', '<leader>gwt', telescope.extensions.git_worktree.git_worktrees, { desc = '[G]it [W]ork[t]rees' })
      vim.keymap.set('n', '<leader>gwc', telescope.extensions.git_worktree.create_git_worktree, { desc = '[G]it [W]orktree [C]reate' })
    end,
  },
  
  -- Advanced git diff viewing
  {
    'sindrets/diffview.nvim',
    config = function()
      require('diffview').setup({
        diff_binaries = false,
        enhanced_diff_hl = false,
        git_cmd = { 'git' },
        hg_cmd = { 'hg' },
        use_icons = true,
        show_help_hints = true,
        watch_index = true,
        icons = {
          folder_closed = '',
          folder_open = '',
        },
        signs = {
          fold_closed = '',
          fold_open = '',
          done = '✓',
        },
        view = {
          default = {
            layout = 'diff2_horizontal',
            winbar_info = false,
          },
          merge_tool = {
            layout = 'diff3_horizontal',
            disable_diagnostics = true,
            winbar_info = true,
          },
          file_history = {
            layout = 'diff2_horizontal',
            winbar_info = false,
          },
        },
        file_panel = {
          listing_style = 'tree',
          tree_options = {
            flatten_dirs = true,
            folder_statuses = 'only_folded',
          },
          win_config = {
            position = 'left',
            width = 35,
            win_opts = {}
          },
        },
        file_history_panel = {
          log_options = {
            git = {
              single_file = {
                diff_merges = 'combined',
              },
              multi_file = {
                diff_merges = 'first-parent',
              },
            },
          },
          win_config = {
            position = 'bottom',
            height = 16,
            win_opts = {}
          },
        },
        commit_log_panel = {
          win_config = {
            win_opts = {},
          }
        },
        default_args = {
          DiffviewOpen = {},
          DiffviewFileHistory = {},
        },
        hooks = {},
        keymaps = {
          disable_defaults = false,
          view = {
            { 'n', '<tab>',      require('diffview.actions').select_next_entry,         { desc = 'Open the diff for the next file' } },
            { 'n', '<s-tab>',    require('diffview.actions').select_prev_entry,         { desc = 'Open the diff for the previous file' } },
            { 'n', 'gf',         require('diffview.actions').goto_file,                 { desc = 'Open the file in the previous tabpage' } },
            { 'n', '<C-w><C-f>', require('diffview.actions').goto_file_split,           { desc = 'Open the file in a new split' } },
            { 'n', '<C-w>gf',    require('diffview.actions').goto_file_tab,             { desc = 'Open the file in a new tabpage' } },
            { 'n', '<leader>e',  require('diffview.actions').focus_files,               { desc = 'Bring focus to the file panel' } },
            { 'n', '<leader>b',  require('diffview.actions').toggle_files,              { desc = 'Toggle the file panel.' } },
            { 'n', 'g<C-x>',     require('diffview.actions').cycle_layout,              { desc = 'Cycle through available layouts.' } },
            { 'n', '[x',         require('diffview.actions').prev_conflict,             { desc = 'In the merge-tool: jump to the previous conflict' } },
            { 'n', ']x',         require('diffview.actions').next_conflict,             { desc = 'In the merge-tool: jump to the next conflict' } },
            { 'n', '<leader>co', require('diffview.actions').conflict_choose('ours'),   { desc = 'Choose the OURS version of a conflict' } },
            { 'n', '<leader>ct', require('diffview.actions').conflict_choose('theirs'), { desc = 'Choose the THEIRS version of a conflict' } },
            { 'n', '<leader>cb', require('diffview.actions').conflict_choose('base'),   { desc = 'Choose the BASE version of a conflict' } },
            { 'n', '<leader>ca', require('diffview.actions').conflict_choose('all'),    { desc = 'Choose all the versions of a conflict' } },
            { 'n', 'dx',         require('diffview.actions').conflict_choose('none'),   { desc = 'Delete the conflict region' } },
            { 'n', '<leader>cO', require('diffview.actions').conflict_choose_all('ours'),   { desc = 'Choose the OURS version of a conflict for the whole file' } },
            { 'n', '<leader>cT', require('diffview.actions').conflict_choose_all('theirs'), { desc = 'Choose the THEIRS version of a conflict for the whole file' } },
            { 'n', '<leader>cB', require('diffview.actions').conflict_choose_all('base'),   { desc = 'Choose the BASE version of a conflict for the whole file' } },
            { 'n', '<leader>cA', require('diffview.actions').conflict_choose_all('all'),    { desc = 'Choose all the versions of a conflict for the whole file' } },
            { 'n', 'dX',         require('diffview.actions').conflict_choose_all('none'),  { desc = 'Delete the conflict region for the whole file' } },
          },
          file_panel = {
            { 'n', 'j',              require('diffview.actions').next_entry,           { desc = 'Bring the cursor to the next file entry' } },
            { 'n', '<down>',         require('diffview.actions').next_entry,           { desc = 'Bring the cursor to the next file entry' } },
            { 'n', 'k',              require('diffview.actions').prev_entry,           { desc = 'Bring the cursor to the previous file entry' } },
            { 'n', '<up>',           require('diffview.actions').prev_entry,           { desc = 'Bring the cursor to the previous file entry' } },
            { 'n', '<cr>',           require('diffview.actions').select_entry,         { desc = 'Open the diff for the selected entry' } },
            { 'n', 'o',              require('diffview.actions').select_entry,         { desc = 'Open the diff for the selected entry' } },
            { 'n', 'l',              require('diffview.actions').select_entry,         { desc = 'Open the diff for the selected entry' } },
            { 'n', '<2-LeftMouse>',  require('diffview.actions').select_entry,         { desc = 'Open the diff for the selected entry' } },
            { 'n', '-',              require('diffview.actions').toggle_stage_entry,   { desc = 'Stage / unstage the selected entry' } },
            { 'n', 'S',              require('diffview.actions').stage_all,            { desc = 'Stage all entries' } },
            { 'n', 'U',              require('diffview.actions').unstage_all,          { desc = 'Unstage all entries' } },
            { 'n', 'X',              require('diffview.actions').restore_entry,        { desc = 'Restore entry to the state on the left side' } },
            { 'n', 'L',              require('diffview.actions').open_commit_log,      { desc = 'Open the commit log panel' } },
            { 'n', 'zo',             require('diffview.actions').open_fold,            { desc = 'Expand fold' } },
            { 'n', 'h',              require('diffview.actions').close_fold,           { desc = 'Collapse fold' } },
            { 'n', 'zc',             require('diffview.actions').close_fold,           { desc = 'Collapse fold' } },
            { 'n', 'za',             require('diffview.actions').toggle_fold,          { desc = 'Toggle fold' } },
            { 'n', 'zR',             require('diffview.actions').open_all_folds,       { desc = 'Expand all folds' } },
            { 'n', 'zM',             require('diffview.actions').close_all_folds,      { desc = 'Collapse all folds' } },
            { 'n', '<c-b>',          require('diffview.actions').scroll_view(-0.25),   { desc = 'Scroll the view up' } },
            { 'n', '<c-f>',          require('diffview.actions').scroll_view(0.25),    { desc = 'Scroll the view down' } },
            { 'n', '<tab>',          require('diffview.actions').select_next_entry,    { desc = 'Open the diff for the next file' } },
            { 'n', '<s-tab>',        require('diffview.actions').select_prev_entry,    { desc = 'Open the diff for the previous file' } },
            { 'n', 'gf',             require('diffview.actions').goto_file,            { desc = 'Open the file in the previous tabpage' } },
            { 'n', '<C-w><C-f>',     require('diffview.actions').goto_file_split,      { desc = 'Open the file in a new split' } },
            { 'n', '<C-w>gf',        require('diffview.actions').goto_file_tab,        { desc = 'Open the file in a new tabpage' } },
            { 'n', 'i',              require('diffview.actions').listing_style,        { desc = 'Toggle between \'list\' and \'tree\' views' } },
            { 'n', 'f',              require('diffview.actions').toggle_flatten_dirs,  { desc = 'Flatten empty subdirectories in tree listing style' } },
            { 'n', 'R',              require('diffview.actions').refresh_files,        { desc = 'Update stats and entries in the file list' } },
            { 'n', '<leader>e',      require('diffview.actions').focus_files,          { desc = 'Bring focus to the file panel' } },
            { 'n', '<leader>b',      require('diffview.actions').toggle_files,         { desc = 'Toggle the file panel' } },
            { 'n', 'g<C-x>',         require('diffview.actions').cycle_layout,         { desc = 'Cycle through available layouts' } },
            { 'n', '[x',             require('diffview.actions').prev_conflict,        { desc = 'Go to the previous conflict' } },
            { 'n', ']x',             require('diffview.actions').next_conflict,        { desc = 'Go to the next conflict' } },
          },
          file_history_panel = {
            { 'n', 'g!',            require('diffview.actions').options,              { desc = 'Open the option panel' } },
            { 'n', '<C-A-d>',       require('diffview.actions').open_in_diffview,     { desc = 'Open the entry under the cursor in a diffview' } },
            { 'n', 'y',             require('diffview.actions').copy_hash,            { desc = 'Copy the commit hash of the entry under the cursor' } },
            { 'n', 'L',             require('diffview.actions').open_commit_log,      { desc = 'Show commit details' } },
            { 'n', 'zR',            require('diffview.actions').open_all_folds,       { desc = 'Expand all folds' } },
            { 'n', 'zM',            require('diffview.actions').close_all_folds,      { desc = 'Collapse all folds' } },
            { 'n', 'j',             require('diffview.actions').next_entry,           { desc = 'Bring the cursor to the next file entry' } },
            { 'n', '<down>',        require('diffview.actions').next_entry,           { desc = 'Bring the cursor to the next file entry' } },
            { 'n', 'k',             require('diffview.actions').prev_entry,           { desc = 'Bring the cursor to the previous file entry.' } },
            { 'n', '<up>',          require('diffview.actions').prev_entry,           { desc = 'Bring the cursor to the previous file entry.' } },
            { 'n', '<cr>',          require('diffview.actions').select_entry,         { desc = 'Open the diff for the selected entry.' } },
            { 'n', 'o',             require('diffview.actions').select_entry,         { desc = 'Open the diff for the selected entry.' } },
            { 'n', '<2-LeftMouse>', require('diffview.actions').select_entry,         { desc = 'Open the diff for the selected entry.' } },
            { 'n', '<c-b>',         require('diffview.actions').scroll_view(-0.25),   { desc = 'Scroll the view up' } },
            { 'n', '<c-f>',         require('diffview.actions').scroll_view(0.25),    { desc = 'Scroll the view down' } },
            { 'n', '<tab>',         require('diffview.actions').select_next_entry,    { desc = 'Open the diff for the next file' } },
            { 'n', '<s-tab>',       require('diffview.actions').select_prev_entry,    { desc = 'Open the diff for the previous file' } },
            { 'n', 'gf',            require('diffview.actions').goto_file,            { desc = 'Open the file in the previous tabpage' } },
            { 'n', '<C-w><C-f>',    require('diffview.actions').goto_file_split,      { desc = 'Open the file in a new split' } },
            { 'n', '<C-w>gf',       require('diffview.actions').goto_file_tab,        { desc = 'Open the file in a new tabpage' } },
            { 'n', '<leader>e',     require('diffview.actions').focus_files,          { desc = 'Bring focus to the file panel' } },
            { 'n', '<leader>b',     require('diffview.actions').toggle_files,         { desc = 'Toggle the file panel' } },
            { 'n', 'g<C-x>',        require('diffview.actions').cycle_layout,         { desc = 'Cycle through available layouts' } },
          },
          option_panel = {
            { 'n', '<tab>', require('diffview.actions').select_entry,          { desc = 'Change the current option' } },
            { 'n', 'q',     require('diffview.actions').close,                 { desc = 'Close the panel' } },
            { 'n', '<cr>',  require('diffview.actions').select_entry,          { desc = 'Change the current option' } },
          },
          help_panel = {
            { 'n', 'q',     require('diffview.actions').close,                 { desc = 'Close help menu' } },
            { 'n', '<esc>', require('diffview.actions').close,                 { desc = 'Close help menu' } },
          },
        },
      })
      
      -- Diffview keymaps
      vim.keymap.set('n', '<leader>do', '<cmd>DiffviewOpen<cr>', { desc = '[D]iffview [O]pen' })
      vim.keymap.set('n', '<leader>dc', '<cmd>DiffviewClose<cr>', { desc = '[D]iffview [C]lose' })
      vim.keymap.set('n', '<leader>dh', '<cmd>DiffviewFileHistory<cr>', { desc = '[D]iffview File [H]istory' })
      vim.keymap.set('n', '<leader>dm', '<cmd>DiffviewOpen HEAD~1<cr>', { desc = '[D]iffview [M]aster' })
    end,
  },
  
  -- Custom function to copy commit hash (7 characters)
  {
    'nvim-lua/plenary.nvim',
    config = function()
      -- Function to copy abbreviated commit hash
      local function copy_commit_hash()
        local Job = require('plenary.job')
        Job:new({
          command = 'git',
          args = { 'rev-parse', '--short=7', 'HEAD' },
          on_exit = function(j, return_val)
            if return_val == 0 then
              local hash = j:result()[1]
              if hash then
                vim.fn.setreg('+', hash)
                vim.notify('Copied commit hash: ' .. hash, vim.log.levels.INFO)
              end
            else
              vim.notify('Failed to get commit hash', vim.log.levels.ERROR)
            end
          end,
        }):start()
      end
      
      -- Function to copy commit hash for a specific line (git blame)
      local function copy_line_commit_hash()
        local Job = require('plenary.job')
        local current_line = vim.fn.line('.')
        local current_file = vim.fn.expand('%:p')
        
        Job:new({
          command = 'git',
          args = { 'blame', '--porcelain', '-L', current_line .. ',' .. current_line, current_file },
          on_exit = function(j, return_val)
            if return_val == 0 then
              local result = j:result()[1]
              if result then
                local hash = result:match('^(%x+)')
                if hash then
                  local short_hash = hash:sub(1, 7)
                  vim.fn.setreg('+', short_hash)
                  vim.notify('Copied commit hash: ' .. short_hash, vim.log.levels.INFO)
                end
              end
            else
              vim.notify('Failed to get commit hash for line', vim.log.levels.ERROR)
            end
          end,
        }):start()
      end
      
      -- Register keymaps for commit hash copying
      vim.keymap.set('n', '<leader>yc', copy_commit_hash, { desc = '[Y]ank [C]ommit hash' })
      vim.keymap.set('n', '<leader>yl', copy_line_commit_hash, { desc = '[Y]ank [L]ine commit hash' })
    end,
  }
}
