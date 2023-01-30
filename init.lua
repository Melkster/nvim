-- Remove once https://github.com/neovim/neovim/pull/15436 gets merged
require('impatient') -- Should be loaded before any other plugin
require('import') -- Better `require`

-- Lazy
local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazy_path) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazy_path,
  })
end
vim.opt.rtp:prepend(lazy_path)

-- General config
import('configs.options')
import('configs.keymaps')
import('configs.autocmds')
import('configs.commands')
import('configs.diagnostics')
import('configs.neovide')
vim.cmd.source('~/.config/nvim/config.vim')

--- Import plugin config from external module in `lua/configs/`
local function use(module)
  return require(string.format('configs.%s', module))
end

import('lazy', function(lazy) lazy.setup({
  { 'miversen33/import.nvim' },                   -- A better Lua 'require()'
  'folke/lazy.nvim',                              -- Package manager
  { 'tpope/vim-fugitive',                         -- :Git commands
    dependencies = 'tpope/vim-dispatch',          -- Asynchronous `:Gpush`, etc.
    cmd = {'G', 'Git', 'Gvdiffsplit'},
  },
  use 'eunuch',
  { 'tpope/vim-abolish', cmd = {'Abolish', 'S'} },
  { 'inkarkat/vim-visualrepeat', dependencies = 'inkarkat/vim-ingo-library' },
  { 'milkypostman/vim-togglelist',               -- Mapping to toggle QuickFix window
    fn = 'ToggleQuickfixList',
  },
  { 'kana/vim-niceblock',                        -- Improves visual mode
    event = 'ModeChanged *:[vV]',
  },
  { 'kana/vim-textobj-syntax' },
  { 'AndrewRadev/splitjoin.vim', keys = {'gS', 'gJ'} },
  { 'junegunn/vim-easy-align', keys = '<Plug>(EasyAlign)' },
  use 'autolist',                                -- Autocomplete lists
  { 'Julian/vim-textobj-variable-segment',       -- camelCase and snake_case text objects
    keys = {{'o', 'iv'}, {'x', 'iv'}, {'o', 'av'}, {'x', 'av'}},
  },
  { 'wsdjeg/vim-fetch' },                        -- Line and column position when opening file
  { 'meain/vim-printer', keys = 'gp' },
  use 'windows',                                 -- Automatic window resizing
  { 'Ron89/thesaurus_query.vim', cmd = 'ThesaurusQueryLookupCurrentWord' },
  use 'undotree',
  use 'smart-splits',                            -- Better resizing mappings
  { 'junegunn/vim-peekaboo' },                   -- Register selection window
  use 'cheat',                                   -- cheat.sh
  { 'RRethy/vim-hexokinase', build = 'make' },   -- Displays colour values
  use 'alpha',                                   -- Nicer start screen
  use 'beacon',                                  -- Flash cursor jump
  use 'indent-blankline',                        -- Indent markers
  { 'coreyja/fzf.devicon.vim',
    dependencies = {'junegunn/fzf.vim', 'kyazdani42/nvim-web-devicons'},
    cmd = 'FilesWithDevicons',
  },
  use 'scrollbar',
  use 'web-devicons',
  use 'nvim-tree',                               -- File explorer
  use 'barbar',                                  -- Sexiest buffer tabline
  use 'null-ls',                                 -- Autoformatting, etc.
  use 'neoscroll',                               -- Smooth scrolling animations
  use 'feline',                                  -- Statusline framework
  use 'barbecue',                                -- Treesitter breadcrumbs
  use 'fidget',                                  -- LSP progress indicator
  use 'gitsigns',                                -- Git status in sign column
  use 'mason',                                   -- LSP/DAP/etc. package manager
  use 'lsp',                                     -- Built-in LSP
  use 'luasnip',                                 -- Snippet engine
  { 'saadparwaiz1/cmp_luasnip',            dependencies = 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-nvim-lsp',                dependencies = 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-buffer',                  dependencies = 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-path',                    dependencies = 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-cmdline',                 dependencies = 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-nvim-lua',                dependencies = 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-nvim-lsp-signature-help', dependencies = 'hrsh7th/nvim-cmp' },
  use 'cmp-tabnine',
  use 'cmp',
  { 'mawkler/friendly-snippets' },               -- Snippet collection
  use 'treesitter',
  { 'JoosepAlviste/nvim-ts-context-commentstring' },
  { 'nvim-treesitter/playground',
    cmd = {'TSPlaygroundToggle', 'TSHighlightCapturesUnderCursor'},
  },
  use 'trouble',                                 -- Nicer list of diagnostics
  use 'telescope',                               -- Fuzzy finder
  use 'dressing',                                -- Improves `vim.ui` interfaces
  { 'MunifTanjim/nui.nvim' },                    -- UI component library
  { 'milisims/nvim-luaref' },                    -- Vim :help reference for lua
  use 'lastplace',                               -- Restore cursor position
  use 'dial',                                    -- Enhanced increment/decrement
  use 'comment',
  use 'rest',                                    -- Sending HTTP requests
  use 'dap',                                     -- UI for nvim-dap
  use 'overseer',                                -- Task runner
  -- { 'jbyuki/one-small-step-for-vimkind' }   -- Lua plugin debug adapter
  use 'onedark',
  use 'refactoring',
  use 'guess-indent',
  { 'lewis6991/impatient.nvim' },                -- Improve startup time for Neovim
  use 'yanky',                                   -- Cycle register history, etc.
  use 'surround',
  { 'tpope/vim-repeat', fn = 'repeat#set' },
  use 'quick-scope',
  use 'matchup',                                 -- Adds additional `%` commands
  use 'autopairs',                               -- Auto-close brackets, etc.
  { 'junegunn/fzf.vim', cmd = {'Ag', 'Rg'} },
  { 'vim-scripts/capslock.vim', event = 'InsertEnter' },
  { 'vim-scripts/StripWhiteSpaces', event = 'BufWrite' },
  use 'git-conflict',                            -- Git conflict mappings
  { 'kana/vim-textobj-user' },
  { 'kana/vim-textobj-function' },
  { 'kana/vim-textobj-line' },
  { 'kana/vim-textobj-entire' },
  { 'lervag/vimtex', ft = {'tex', 'latex'} },
  use 'indent-tools',
  use 'targets',
  { 'romainl/vim-cool' },                        -- Better search highlighting behaviour
  { 'plasticboy/vim-markdown', ft = 'markdown' },
  { 'coachshea/vim-textobj-markdown', ft = 'markdown' },
  use 'substitute',                              -- Replace/exchange operators
  use 'highlighturl',
  use 'messages',                                -- Floating :messages window
  use 'possession',                              -- Session manager
  { 'rhysd/vim-grammarous' },                    -- LanguageTool grammar checking
  use 'copilot',                                 -- GitHub Copilot
  { 'tvaintrob/bicep.vim', ft = 'bicep' },
  use 'diffview',                                -- Git diff and file history
  use 'leap',                                    -- Move cursor anywhere
  use 'winshift',                                -- Improved window movement
  use 'notify',                                  -- Floating notifications popups
  { 'NarutoXY/dim.lua' },                        -- Dim unused words
  use 'toggleterm',                              -- Toggleable terminal
  use 'term-edit',                               -- Better editing in :terminal
  use 'bqf',                                     -- Better quickfix
  use 'qf',
  use 'git',                                     -- Git wrapper
  use 'reloader',                                -- Hot reload Neovim config
  use 'template-string',                         -- Automatic template string
  use 'csv',                                     -- CSV highlighting, etc.
  use 'modicator',                               -- Line number mode indicator
  { 'jghauser/mkdir.nvim' },                     -- Create missing folders on :w
  use 'unception',                               -- Open files in Neovim from terminal
  use 'git-worktree',                            -- Manage git worktrees

  -- , config = {
  --   profile = { enable = false, },
  --   display = {
  --     keybindings = {
  --       quit = '<Esc>',
  --       toggle_info = '<Space>',
  --     },
  --   }
  -- }
}) end)
