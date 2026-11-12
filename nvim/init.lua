-- Plugins ================================================================
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if kind ~= 'install' and kind ~= 'update' then return end
    if name == 'telescope-fzf-native.nvim' then
      vim.system({ 'make' }, { cwd = ev.data.path }):wait()
    elseif name == 'nvim-treesitter' and kind == 'update' then
      if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
      vim.cmd('TSUpdate')
    end
  end,
})

local gh = function(x) return 'https://github.com/' .. x end
vim.pack.add({
  -- UI
  gh('craftzdog/solarized-osaka.nvim'),
  gh('nvim-lualine/lualine.nvim'),
  gh('nvim-tree/nvim-web-devicons'),
  gh('alvarosevilla95/luatab.nvim'),
  gh('lewis6991/gitsigns.nvim'),
  gh('lukas-reineke/indent-blankline.nvim'),
  gh('folke/noice.nvim'),
  gh('MunifTanjim/nui.nvim'),
  gh('rcarriga/nvim-notify'),
  gh('psliwka/vim-smoothie'),
  gh('lfv89/vim-interestingwords'),
  -- Finder
  gh('nvim-lua/plenary.nvim'),
  gh('nvim-telescope/telescope.nvim'),
  gh('nvim-telescope/telescope-fzf-native.nvim'),
  gh('nvim-telescope/telescope-file-browser.nvim'),
  -- Syntax
  { src = gh('nvim-treesitter/nvim-treesitter'), version = 'main' },
  gh('windwp/nvim-ts-autotag'),
  gh('mustache/vim-mustache-handlebars'),
  gh('sophacles/vim-bundle-mako'),
  -- LSP, completion, formatting
  gh('neovim/nvim-lspconfig'),
  gh('mason-org/mason.nvim'),
  gh('mason-org/mason-lspconfig.nvim'),
  { src = gh('saghen/blink.cmp'), version = vim.version.range('1') },
  gh('stevearc/conform.nvim'),
  gh('github/copilot.vim'),
  -- Editing
  gh('tpope/vim-abolish'),
  gh('tpope/vim-fugitive'),
  gh('tpope/vim-repeat'),
  gh('tpope/vim-surround'),
  gh('wellle/targets.vim'),
  gh('godlygeek/tabular'),
  gh('mattn/emmet-vim'),
  gh('janko/vim-test'),
})

-- UI =====================================================================
local scheme = vim.system({ 'gsettings', 'get', 'org.gnome.desktop.interface', 'color-scheme' }):wait().stdout or ''
vim.o.background = scheme:find('dark') and 'dark' or 'light'
-- Soften osaka's dark mode back towards classic Solarized: its near-black
-- background and brightened text are too contrasted.
require('solarized-osaka').setup({
  transparent = false,
  styles = { floats = 'normal' },
  on_colors = function(c)
    if vim.o.background ~= 'dark' then return end
    c.bg, c.bg_highlight = '#002b36', '#073642'
    c.bg_float = c.bg
    c.base0, c.base1 = '#839496', '#93a1a1'
  end,
  on_highlights = function(hl, c)
    hl.Delimiter = { fg = c.base01 }
    hl.TelescopeBorder = { fg = c.base01, bg = c.bg_float }
    if vim.o.background == 'dark' then
      hl.CursorLine = { bg = c.bg_highlight }
      hl.IblIndent = { fg = '#234650', nocombine = true }
    end
  end,
})
vim.cmd.colorscheme('solarized-osaka')
local attr = vim.api.nvim_get_hl(0, { name = '@tag.attribute', link = false })
vim.api.nvim_set_hl(0, '@tag.attribute', vim.tbl_extend('force', attr, { italic = true }))
vim.o.colorcolumn = '80'
vim.o.cursorline = true
vim.o.cmdheight = 0
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = ''

require('luatab').setup({ windowCount = function() return '' end })
require('lualine').setup({
  options = { theme = 'solarized-osaka' },
  sections = { lualine_b = { 'branch', 'diagnostics' } },
})
require('gitsigns').setup({ diff_opts = { ignore_whitespace = true } })
require('ibl').setup()
require('noice').setup()

-- Editor =================================================================
vim.g.mapleader = ','
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.wildmode = 'list:longest,full'
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.gdefault = true
vim.o.inccommand = 'split'
vim.o.undofile = true

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function() vim.hl.on_yank({ higroup = 'Visual' }) end,
})

vim.cmd([[
  ab calss class
  command! -bang W w<bang>
  command! -bang Q q<bang>
  command! -bang Qa qa<bang>
  command! -bang QA qa<bang>
  command! -bang Wq wq<bang>
  command! -bang WQ wq<bang>
]])

-- Mappings ===============================================================
local map = vim.keymap.set
map('i', 'gq', '<Esc>')
map('t', '<Esc>', [[<C-\><C-n>]])
map('n', 'é', 'gT')
map('n', 'è', 'gt')
map('n', '<leader>r', ':e!<CR>')
map('n', '<leader>ew', ':e <C-R>=expand("%:p:h") . "/" <CR>')
map('n', '<leader>es', ':sp <C-R>=expand("%:p:h") . "/" <CR>')
map('n', '<leader>ev', ':vsp <C-R>=expand("%:p:h") . "/" <CR>')
map('n', '<leader>et', ':tabe <C-R>=expand("%:p:h") . "/" <CR>')
map('', '<leader><space>', ':noh<CR>:call clearmatches()<CR>')
map('n', ' ', '<C-w><C-w>')
map('n', '<leader>d', '<C-]>')
map('', '<leader>:', ':Tabularize /:<CR>')
map('', '<leader>=', ':Tabularize /=<CR>')
map('', '<leader>o', 'vi{:Tabularize /:<CR>')
map('n', '<leader>é', 'ysiw', { remap = true })
map('n', '<leader>x', ':%!xmllint --format --recover -<CR>')

local gitsigns = require('gitsigns')
map('n', '»', function() gitsigns.nav_hunk('next') end)
map('n', '«', function() gitsigns.nav_hunk('prev') end)

vim.g.user_emmet_leader_key = '<C-E>'

vim.g['test#strategy'] = 'neovim'
map('n', '<leader>t', ':TestNearest<CR>')

local telescope = require('telescope')
telescope.setup()
telescope.load_extension('fzf')
map('n', '<leader>c', '<cmd>Telescope find_files<CR>')
map('n', '<leader>g', '<cmd>Telescope live_grep<CR>')
map('n', '<leader>b', '<cmd>Telescope buffers<CR>')
map('n', 'à', '<cmd>Telescope buffers<CR>')
map('n', '<leader>n', '<cmd>Telescope notify<CR>')
map('n', '<leader>s', '<cmd>Telescope lsp_document_symbols<CR>')
map('n', '<leader>S', '<cmd>Telescope lsp_dynamic_workspace_symbols<CR>')

-- Treesitter =============================================================
local parsers = {
  'bash', 'css', 'dockerfile', 'html', 'javascript', 'jinja', 'jinja_inline', 'json',
  'lua', 'markdown', 'markdown_inline', 'python', 'scss', 'sql', 'svelte',
  'tsx', 'typescript', 'vim', 'vimdoc', 'vue', 'yaml',
}
require('nvim-treesitter').install(parsers)
vim.api.nvim_create_autocmd('FileType', {
  callback = function(ev)
    if pcall(vim.treesitter.start, ev.buf) then
      vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})
require('nvim-ts-autotag').setup()

-- LSP ====================================================================
-- Most servers are Node scripts; fall back to fnm's default Node when nvim is
-- started from an environment without it (GUI launcher, stale shell).
if vim.fn.executable('node') == 0 then
  vim.env.PATH = vim.fn.expand('~/.local/share/fnm/aliases/default/bin') .. ':' .. vim.env.PATH
end

local vue_plugin = vim.fn.stdpath('data') .. '/mason/packages/vue-language-server/node_modules/@vue/language-server'
vim.lsp.config('vtsls', {
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue' },
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          { name = '@vue/typescript-plugin', location = vue_plugin, languages = { 'vue' }, configNamespace = 'typescript' },
        },
      },
    },
  },
})
vim.lsp.config('pyright', {
  settings = {
    python = {
      analysis = { autoSearchPaths = true, diagnosticMode = 'workspace', useLibraryCodeForTypes = true },
    },
  },
})

require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = { 'vtsls', 'vue_ls', 'svelte', 'pyright', 'eslint', 'cssls', 'html' },
})

-- Formatters are not LSP servers, and mason-lspconfig still maps stylelint_lsp
-- to the old community server instead of the official one lspconfig expects.
local registry = require('mason-registry')
registry.refresh(function()
  for _, tool in ipairs({ 'prettier', 'black', 'stylelint-language-server' }) do
    if not registry.is_installed(tool) then registry.get_package(tool):install() end
  end
end)

vim.lsp.enable('stylelint_lsp')

map('n', 'gd', vim.lsp.buf.definition)
map('n', 'gy', vim.lsp.buf.type_definition)

-- Completion =============================================================
vim.g.copilot_no_tab_map = true
map('i', '<C-j>', 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })

local function copilot_accept()
  if vim.fn['copilot#GetDisplayedSuggestion']().text ~= '' then
    vim.api.nvim_feedkeys(vim.fn['copilot#Accept'](''), 'n', true)
    return true
  end
end

require('blink.cmp').setup({
  keymap = {
    preset = 'none',
    ['<Tab>'] = { 'select_next', copilot_accept, 'fallback' },
    ['<S-Tab>'] = { 'select_prev', 'fallback' },
    ['<CR>'] = { 'accept', 'fallback' },
    ['<C-Space>'] = { 'show', 'show_documentation', 'hide_documentation' },
  },
  completion = { documentation = { auto_show = true } },
})

-- Formatting =============================================================
local web = { 'prettier' }
require('conform').setup({
  formatters_by_ft = {
    javascript = web, typescript = web, html = web, less = web, scss = web,
    css = { 'stylelint' },
    python = { 'black' },
    svelte = { 'prettier', lsp_format = 'last' },
    vue = { 'prettier', lsp_format = 'last' },
  },
  format_on_save = function(buf)
    if vim.bo[buf].filetype == 'svelte' then return { timeout_ms = 2000 } end
  end,
})
map('n', '<leader>F', function() require('conform').format({ async = true }) end)
