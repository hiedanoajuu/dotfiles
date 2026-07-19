-- An custom for a vimrc file.
--
-- Maintainer:	The Vim Project <https://github.com/vim/vim>
-- Last Change:	2023 Aug 10
-- Former Maintainer:	Bram Moolenaar <Bram@vim.org>
-- User: Hiedano Ajuu
-- Last Edited:  2025-09-14
--
-- To use it, copy it to
--	       for Unix:  ~/.vimrc
--	      for Amiga:  s:.vimrc
--	 for MS-Windows:  $VIM\_vimrc
--	      for Haiku:  ~/config/settings/vim/vimrc
--	    for OpenVMS:  sys$login:.vimrc

-- When started as "evim", evim.vim will already have done these settings, bail
-- out.

local progname = vim.v.progname
if string.find(progname:lower(), "evim") then
  return
end

-- Get the defaults that most users want.
-- source $VIMRUNTIME/defaults.vim

if vim.fn.has("vms") == 1 then
  vim.opt.backup = false
else
  vim.opt.backup = true
  if vim.fn.has('persistent_undo') == 1 then
    vim.opt.undofile = true
  end
end

vim.opt.backupdir = vim.fn.stdpath("cache") .. "/backup//"
vim.opt.directory = vim.fn.stdpath("cache") .. "/swap//"
vim.opt.undodir = vim.fn.stdpath("cache") .. "/undo//"

vim.opt.hlsearch = true

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local vimrcEx = augroup('vimrcEx', {})

autocmd('FileType', {
  group = vimrcEx,
  pattern = 'text',
  callback = function()
    vim.opt_local.textwidth = 78
  end
})

if vim.fn.has('syntax') == 1 and vim.fn.has('eval') == 1 then
  vim.cmd('packadd! matchit')
end

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.cmd('syntax on')
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Search
vim.opt.incsearch = true
vim.keymap.set('n', '<esc><esc>', ':nohlsearch<CR>', { silent = true })

-- Buffer
vim.opt.hidden = true
vim.cmd('filetype on')
vim.cmd('filetype plugin on')
vim.cmd('filetype indent on')
vim.opt.backspace = 'indent,eol,start'

-- Display
vim.opt.number = true
vim.opt.ruler = true
vim.opt.encoding = 'utf-8'
vim.opt.autoread = true
vim.opt.history = 1000
vim.opt.confirm = true

vim.opt.wildmenu = true
vim.opt.wildmode = 'list:longest,full'

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  vim.notify("Packer not found! Installing...")
  return
end

local packer = require("packer")
packer.init({
  git = {
    default_url_format = "git@github.com:%s.git",
  },
})

packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  
  use 'tpope/vim-surround'
  
  use 'tpope/vim-commentary'
  use 'tpope/vim-repeat'
  use 'folke/tokyonight.nvim'
  
  if packer_bootstrap then
    packer.sync()
  end
end)

vim.opt.termguicolors = true
vim.opt.background = 'dark'
vim.cmd('colorscheme tokyonight-storm')

require("tokyonight").setup({
  style = "night",
})

vim.cmd([[
  set showmatch
  set matchtime=2
]])

vim.cmd([[
  highlight Normal guibg=NONE
  highlight NormalNC guibg=NONE
  highlight SignColumn guibg=NONE
  highlight LineNr guibg=NONE
  highlight CursorLineNr guibg=NONE
  highlight EndOfBuffer guibg=NONE
  highlight VertSplit guibg=NONE
]])
