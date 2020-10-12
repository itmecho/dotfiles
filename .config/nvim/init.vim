call plug#begin('~/.config/nvim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-rooter'
Plug 'tpope/vim-commentary'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/diagnostic-nvim'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'dense-analysis/ale'

" Language plugins
Plug 'rust-lang/rust.vim'
Plug 'hashivim/vim-terraform'
Plug 'cespare/vim-toml'
Plug 'jvirtanen/vim-hcl'
Plug 'dag/vim-fish'

" Color Schemes
Plug 'dracula/vim', {'as': 'dracula'}
Plug 'arcticicestudio/nord-vim'
call plug#end()

" Config
set cmdheight=2
set completeopt=noinsert,menuone,noselect
set cursorline
set expandtab
set hidden
set ignorecase
set incsearch
set mouse=""
set number
set relativenumber
set scrolloff=50
set shiftwidth=4
set shortmess+=c
set signcolumn=yes
set smartcase
set softtabstop=0
set spelllang=en_gb
set splitbelow
set splitright
set tabstop=4
set termguicolors
set updatetime=300
set wildignore=.git/*,.venv/*,*.pyc

filetype plugin indent on
syntax on
colorscheme dracula

" LSP config
lua require'init'

let mapleader = ' '

" Plugin configuration
let g:airline_theme = 'dracula'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

let g:ale_set_highlights = 0
let g:ale_rust_cargo_use_check = 1

let g:diagnostic_enable_underline = 1
let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_show_sign = 1

let g:fzf_layout = { 'down': '40%' }

let g:netrw_banner = 0
let g:netrw_liststyle = 3

if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
    let g:fzf_tags_command = 'rg --files | ctags --links=no -R -L-'
    let $FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git/**'"
endif

" Functions
function! RemoveTrailingWhiteSpace()
    :normal mw
    :%s/\s\+$//e
    :normal `w
endfunction

source $HOME/.config/nvim/rnr.vim

autocmd BufWritePre * call RemoveTrailingWhiteSpace()

" Abbreviations
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qa! qa!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qa qa
cnoreabbrev Qall qall
cnoreabbrev Ack Ack!

" Key bindings
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <C-P> <Esc><cmd>Files<CR>
inoremap <A-t> <Esc><cmd>call RnrTermToggle()<CR>

" File Open
nnoremap <C-p> <cmd>Files<CR>
" File Buffers
nnoremap <leader>; <cmd>Buffers<CR>

" Search Project
nnoremap <leader>sp <cmd>Rg<CR>
" Search Tags
nnoremap <leader>st <cmd>Tags<CR>

" Terminal Toggle
nnoremap <silent> <leader>tt <cmd>call RnrToggle()<CR>
tnoremap <silent> <leader>tt <C-\><C-n><cmd>call RnrToggle()<CR>

" LSP Bindings
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>

" Hard Mode
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>

" Esc clears search highlights
nnoremap <silent> <esc> <cmd>noh<CR><esc>
nnoremap <leader>S <cmd>set spell!<CR>
nnoremap <leader>h <C-w>h
nnoremap <leader>l <C-w>l
nnoremap <leader>k <C-w>k
nnoremap <leader>j <C-w>j

" Center search result
nnoremap n nzzzv

vnoremap > >gv
vnoremap < <gv
