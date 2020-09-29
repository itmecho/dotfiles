call plug#begin('~/.config/nvim/plugged')
Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-rooter'
Plug 'tpope/vim-commentary'
Plug 'vimwiki/vimwiki'
Plug 'junegunn/goyo.vim'

" IDE
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'jiangmiao/auto-pairs'
Plug 'mileszs/ack.vim'
Plug 'junegunn/fzf.vim'
Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Language specific
Plug 'rust-lang/rust.vim'
Plug 'hashivim/vim-terraform'
Plug 'cespare/vim-toml'
Plug 'jvirtanen/vim-hcl'
Plug 'dag/vim-fish'

" Color Scheme
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

let mapleader = ' '

let g:ackprg = 'rg --vimgrep --type-not sql --smart-case'
let g:ack_autoclose = 1
let g:ack_use_cword_for_empty_search = 1

let g:ale_set_highlights = 0
let g:ale_rust_cargo_use_check = 1

let g:coc_global_extensions = []
let g:coc_global_extensions += ['coc-json']
let g:coc_global_extensions += ['coc-rust-analyzer']
let g:coc_global_extensions += ['coc-yaml']
let g:coc_global_extensions += ['coc-eslint']
let g:coc_global_extensions += ['coc-prettier']
let g:coc_global_extensions += ['coc-sql']
let g:coc_global_extensions += ['coc-tsserver']

let g:fzf_action = {
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
let g:fzf_layout = {'window': { 'width': 1, 'height': 1, 'highlight': 'Normal', 'border': 'sharp' } }
let $FZF_DEFAULT_OPTS = '--layout=reverse --inline-info'
let $FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git/**'"

let g:lightline = {
      \ 'colorscheme': 'dracula',
      \ }

let NERDTreeQuitOnOpen = 1
let NERDTreeWinSize = 55

let g:terraform_fmt_on_save = 1

if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
    let g:fzf_tags_command = 'rg --files | ctags --links=no -R -L-'
endif

" Functions
function! RemoveTrailingWhiteSpace()
    :normal mw
    :%s/\s\+$//e
    :normal `w
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

source /home/iain/.config/nvim/rnr.vim

" Autocommands
autocmd FileType make setlocal noexpandtab
autocmd FileType yaml,hcl setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd BufNewFile,BufRead *.j2 set ft=jinja
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
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
inoremap <C-P> <Esc>:Files<CR>
inoremap <A-t> <Esc>:call RnrTermToggle()<CR>

" File Open
nnoremap <leader>fo :Files<CR>
" File Buffers
nnoremap <leader>fb :Buffers<CR>
" File Tree
nnoremap <leader>ft :NERDTreeToggle<CR>

" Search Project
nnoremap <leader>sp :Ack<Space>
" Search Tags
nnoremap <leader>st :Tags<CR>

" Terminal Toggle
nnoremap <silent> <leader>tt :call RnrToggle()<CR>


nnoremap <silent> <esc> :noh<CR><esc>
nnoremap <leader>st :Tags<CR>
nnoremap <leader>gy :Goyo 50%<cr>
nnoremap <leader>S :set spell!<CR>
nnoremap <leader>wh :split<cr>
nnoremap <leader>wv :vs<cr>
nnoremap <leader><left> <C-w>h
nnoremap <leader><right> <C-w>l
nnoremap <leader><up> <C-w>k
nnoremap <leader><down> <C-w>j
nnoremap n nzzzv

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> K :call <SID>show_documentation()<CR>
nmap <leader>rn <Plug>(coc-rename)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

vnoremap > >gv
vnoremap < <gv
vnoremap <leader>f y:Ack<Space><C-R>0<CR>
