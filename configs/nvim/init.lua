--[[
--
--  init.lua
--  by Giovanni Santini
--
--  Clone this repository in .config/nvim
--
--]]

-- vim options
vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.clipboard      = "unnamedplus" -- system clipboard
vim.opt.expandtab      = true
vim.opt.spell          = true
vim.opt.shiftwidth     = 4
vim.opt.tabstop        = 4
vim.opt.colorcolumn    = '80'
vim.opt.textwidth      = 80   -- use 'gqip' to format a paragraph
vim.opt.tags           = "./tags;,tags"
vim.g.loaded_netrw       = 1  -- Disable default tree view for nvim-tree
vim.g.loaded_netrwPlugin = 1

-- Show whitespaces
vim.o.list = true
vim.o.listchars = 'tab:» ,lead:•,trail:•'
vim.api.nvim_set_hl(0, 'TrailingWhitespace', { bg='LightRed' })
vim.api.nvim_create_autocmd('BufEnter', {
	pattern = '*',
	command = [[
		syntax clear TrailingWhitespace |
		syntax match TrailingWhitespace "\_s\+$"
	]]}
)

-- I use plug
local Plug = vim.fn['plug#']

vim.call('plug#begin')

-- Modus themes from Prot
Plug('miikanissi/modus-themes.nvim')
Plug('nvim-lua/plenary.nvim')          -- dependency for telescope
Plug('nvim-telescope/telescope.nvim', { ['commit'] = '3333a52'})  -- fuzz strings
Plug('nvim-tree/nvim-web-devicons')    -- some icons
Plug('nvim-tree/nvim-tree.lua')        -- directory tree
-- From orgmode release 0.7.1, support for Neovim < 0.11.0 was dropped
Plug('nvim-orgmode/orgmode', { ['commit'] = '4da28a0' }) -- org view
Plug('nvim-mini/mini.icons', { ['branch'] = 'stable'})   -- some icons
Plug('goolord/alpha-nvim')             -- Cool startup screen
Plug('lewis6991/gitsigns.nvim')        -- Show modified lines
Plug('SirVer/ultisnips')               -- Completion snippets
Plug('f-person/git-blame.nvim')        -- Show git blame inline
Plug('folke/flash.nvim')               -- Jump around with overlay

vim.call('plug#end')

local modus = require('modus-themes')
modus.setup({
    style = "modus_vivendi",  -- modus_vivendi or modus_operandi (dark and light)
    variants = "default",      -- default, tinted, deuteranopia, and tritanopia
})
vim.cmd([[colorscheme modus]])

-- Shortcuts
-- ---------
--
-- Useful shortcuts:
--   - CTRL-]: jump to definition
--   - CTRL-T: go back to previous position

local telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope.find_files,
                { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', telescope.live_grep,
                { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', telescope.buffers,
                { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', telescope.help_tags,
                { desc = 'Telescope help tags' })

vim.g.UltiSnipsSnippetDirectories = { 'my-snippets' }
vim.g.UltiSnipsExpandTrigger = "<tab>"
vim.g.UltiSnipsJumpForwardTrigger = "<c-b>"
vim.g.UltiSnipsJumpBackwardTrigger = "<c-z>"

require('nvim-web-devicons').setup()
local tree = require('nvim-tree.api')
vim.keymap.set('n', '<C-n>', function() tree.tree.toggle() end,
                { desc = 'Toggle nvim-tree' })
require('nvim-tree').setup()
vim.cmd [[
  highlight link NvimTreeNormal Normal
  highlight link NvimTreeFolderName Directory
  highlight link NvimTreeIndentMarker LineNr
  highlight link NvimTreeVertSplit VertSplit
  highlight NvimTreeNormal guibg=NONE ctermbg=NONE
]]

require('orgmode').setup({
  org_agenda_files = '~/todo.org/todo.org',
  org_default_notes_file = '~/giovanni-diary/content/index.org',
})

require('mini.icons').setup()
require('alpha').setup(require('alpha.themes.startify').config)

require('gitblame').setup({
    enabled = true,
})

require('flash').setup({
    enabled = true,
})
require('flash').toggle()

local function toggle_modus_theme()
    -- Access the current style from the plugin's configuration
    local current_style = require('modus-themes.config').options.style

    if current_style == "modus_operandi" then
        modus.setup({ style = "modus_vivendi" })
    else
        modus.setup({ style = "modus_operandi" })
    end

    -- Reload the colorscheme to apply changes
    vim.cmd([[colorscheme modus]])
end

vim.api.nvim_create_user_command('ToggleTheme', toggle_modus_theme, {})

--[[
--
-- End of init.lua
--
--]]
