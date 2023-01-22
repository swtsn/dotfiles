"""""
" Vundle setup
"""""
set nocompatible       " no compatibility with vi
filetype off           " recognize syntax by file extension
au! FileType python setl nosmartindent    " Don't use smartindent for python files
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'nvie/vim-flake8'
Plugin 'elzr/vim-json'
Plugin 'kaicataldo/material.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'hashivim/vim-terraform'
Plugin 'fatih/vim-go'
Plugin 'nathanaelkane/vim-indent-guides'
call vundle#end()            " required
filetype plugin indent on    " required

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                      .vimrc -- the way it ought to be                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Configure `material.vim`
let g:material_theme_style = 'default'
colorscheme material

" Configure json
let g:vim_json_syntax_conceal = 0

syntax on              " syntax highlighting
hi clear search        " do not highlight all search matches

set ai
set si

set background=light  " background light, so foreground not bold
set backspace=2       " allow <BS> to go past last insert
set gdefault          " assume :s uses /g
set ignorecase        " ignore case in search patterns
set smartcase         " searches are case-sensitive if caps used
set incsearch         " immediately highlight search matches
set noerrorbells      " no beeps on errors
set nomodeline        " prevent others from overriding this .vimrc
set number            " display line numbers
set ruler             " display row, column and % of document
set showcmd           " show partial commands in the status line
set showmatch         " show matching () {} etc.
set showmode          " show current mode
set expandtab         " expand tabs with spaces
set tabstop=4         " <Tab> move four characters
set shiftwidth=4      " >> and << shift 4 spaces
set nowrap            " don't soft wrap
"set textwidth=89      " hard wrap at 89 characters
set modeline          " check for a modeline
set softtabstop=4     " see spaces as tabs
set scrolloff=5       " start scrolling when cursor is N lines from edge
set laststatus=2      " always show the bottom status bar
"set tags=~/.python-tags;~/dev     " set tag location

" Custom status bar
set statusline=%<%f\ %m\ %h%r%=%b\ 0x%B\ \ %l,%c%V\ %P

noremap <Ins> 2<C-Y>   " <Ins> defaults like i
noremap <Del> 2<C-E>   " <Del> defaults like x

" Highlight long lines
highlight OverLength ctermfg=red
match OverLength /\%161v.\+/

highlight LineNr ctermfg=grey
highlight Statement ctermfg=lightmagenta

"""""""""""""""""""
"     Toggles     "
"""""""""""""""""""
" Toggle line numbers
:nnoremap <C-N><C-N> :set invnumber<CR>
" Toggle paste mode
:nnoremap <C-p><C-p> :set invpaste<CR>
" Toggle text wrap
:nnoremap <C-w><C-w> :set invwrap<CR>

" Use the space key to open and close code folds
:vnoremap <space> zf<CR>
:nnoremap <space> zd<CR>

" Tabs!
:nnoremap ,. :tabnew<CR>
:nnoremap ., :tabclose<CR>

" Navigating tabs and splits
:nnoremap ,q :tabp<CR>
:nnoremap ,e :tabn<CR>
:nnoremap ,w <c-w><Up><CR>
:nnoremap ,s <c-w><Down><CR>
:nnoremap ,a <c-w><Left><CR>
:nnoremap ,d <c-w><Right><CR>

" Show and hide extra whitespace
:highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
:nnoremap ,z :match ExtraWhitespace /\s\+$/<CR>
:nnoremap ,x :match<CR>

" Set up autocommands
" augroup black_on_save
"   autocmd!
"   autocmd BufWritePre *.py Black
" augroup end

" Makefile sanity
autocmd FileType make set noexpandtab ts=8 sw=8
autocmd BufEnter */debian/rules set noexpandtab ts=8 sw=8

" Tab stops
autocmd FileType bash,scala,perl,css,javascript,java,xs,xml set tabstop=8 shiftwidth=4 smarttab expandtab softtabstop=4 autoindent
autocmd FileType python,ruby,rakefile,c,cpp,html,eruby,vim  set tabstop=8 shiftwidth=4 smarttab expandtab softtabstop=4 autoindent
autocmd FileType avro-idl,json,rest                         set tabstop=8 shiftwidth=4 smarttab expandtab softtabstop=4 autoindent
autocmd FileType go                                         set tabstop=4 shiftwidth=4 smarttab softtabstop=4 autoindent
