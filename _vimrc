" <leader> is default set to \
set t_Co=256 " to be correctly displayed mainly in tmux

syntax enable
set background=dark
colorscheme badwolf " https://github.com/sjl/badwolf/
" badwolf background color is #111110 

set encoding=utf8

" replace each tab by 4 spaces
set tabstop=4 " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set expandtab       " tabs are spaces

" UI config
set number  " show line numbers
set showcmd " show command in bottom bar
set cursorline " highlight current line
set wildmenu " visual autocomplete for command menu
set showmatch           " highlight matching [{()}]

" SEARCHING
" to search use /, n to move to the next, N to move in backward direction
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
" turn off search highlight, where <leader> == \
nnoremap <leader><space> :nohlsearch<CR>

" moving through code
" move vertically by visual line
nnoremap j gj
nnoremap k gk

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col_num = col('.') - 1 " first character on current line indicator
    if !col_num  || getline('.')[col_num - 1] == ' '
        return "\<tab>"
    else
        return "\<c-x>\<c-f>"
    endif
endfunction
inoremap <expr> <tab> InsertTabWrapper()
