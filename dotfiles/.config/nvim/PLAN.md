# Neovim configuration using nvim kickstarter with the lazy package manager


## 1. Main editor configuration.
        The editor should include basics:
            a. file tree: to see all the files in the directory
            b. relative numbering: line numbers to be based on the number of lines away it is from current line
            c. lazygit: lazy git integration for easy version control
            d. in-line git blame: git blame within open files to see commit, commit author and time stamp
            e. file git diff: check git difference for a file and also compare the file from one branch to another branch
            f. shortcut to copy current commit hash abbreviated to 7 characters
            g. ripgrep
            h. grep
        Debugger with dap and language servers/lsp with mason:
            a. rust
            b. python
            c. bash
            d. open tofu (hcl)
            e. yaml
## 2. Plugins
        Rustacenvim, dap ui, dap core, others if needed
