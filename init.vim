set rnu
set number
set expandtab
set encoding=utf-8
set foldmethod=marker
set shiftwidth=4
set softtabstop=4
set fileencodings =ucs-bom,utf-8,chinese


call plug#begin()

Plug 'luochen1990/rainbow'
Plug 'Yggdroot/indentLine'
Plug 'vim-airline/vim-airline'
Plug 'RRethy/vim-illuminate'
Plug 'vim-airline/vim-airline-themes'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'puremourning/vimspector', {'do': './install_gadget.py --enable-python --enable-c'}

call plug#end()

"--------
"---------------------------------      Packer插件管理    ---------------------------------
"--------
 
lua require('plugins')
lua require('plugin-config/nvim-treesitter')

"--------
"---------------------------------      Packer插件管理    ---------------------------------
"--------

"--------
"---------------------------------      basic    ---------------------------------
"--------

inoremap ( ()<ESC>i
inoremap [ []<ESC>i
inoremap { {}<ESC>i
inoremap ' ''<ESC>i
inoremap " ""<ESC>i
inoremap jj <ESC>
let mapleader = " "

nnoremap <C-h> :bp<CR>
nnoremap <C-l> :bn<CR>
nnoremap <C-^> :bd<CR>

hi Pmenu ctermfg=Black ctermbg=gray  
hi PmenuSel ctermfg=25 ctermbg=15 


" - 行首行尾切换
nnoremap <silent> - :call <SID>move()<cr>
nnoremap 0 %
vnoremap 0 %
fun! s:move()
    let [l:first, l:head] = [1, len(getline('.')) - len(substitute(getline('.'), '^\s*', '', 'g')) + 1]
    let l:before = col('.')
    exe l:before == l:first && l:first != l:head ? 'norm! ^' : 'norm! $'
    let l:after = col('.')
    if  l:before == l:after
        exe 'norm! 0'
    endif
endf

"set cursorline
"highlight CursorLine  cterm=NONE ctermbg=999999 ctermfg=NONE guibg=NONE guifg=NONE

"---------------------------------      basic    ---------------------------------

"--------
"---------------------------------    cilluminate   ------------------------------
"--------

augroup illuminate_augroup
    autocmd!
    autocmd VimEnter * hi illuminatedWord cterm=underline  gui=italic 
augroup END

"---------------------------------    cilluminate   ------------------------------

"--------
"---------------------------------    coc.nvim   ---------------------------------
"--------

set shortmess+=c                                       
set updatetime=300
nmap <leader>rn <Plug>(coc-rename)
let g:coc_git_status = 1
let b:coc_git_status = 1

nnoremap tt :CocCommand explorer<CR>

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
nmap <silent> <LEADER>p <Plug>(coc-diagnostic-prev)
nmap <silent> <LEADER>n <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


"---------------------------------    coc.nvim   ---------------------------------


"--------
"---------------------------------    airline    ---------------------------------
"--------

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#keymap#enabled = 1
let g:airline#extensions#tabline#formatter = 'default'
let g:airline#extensions#tabline#buffer_idx_mode = 1

if !exists('g:airline_symbols')
let g:airline_symbols = {}
endif

"---------------------------------    airline    ---------------------------------


"--------
"---------------------------------    rainbow    ---------------------------------
"--------

let g:rainbow_active = 1
let g:rainbow_conf = {
\   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
\   'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
\   'operators': '_,_',
\   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
\   'separately': {
\       '*': {},
\       'tex': {
\           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
\       },
\       'lisp': {
\           'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
\       },
\       'vim': {
\           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
\       },
\       'html': {
\           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
\       },
\       'css': 0,
\   }
\}


"---------------------------------    rainbow    ---------------------------------


"--------
"---------------------------------   vimspector  ---------------------------------
"--------
 
let g:vimspector_enable_mappings = 'HUMAN'
function! s:read_template_into_buffer(template)
	" has to be a function to avoid the extra space fzf#run insers otherwise
	execute '0r ~/.config/nvim/vimspector_json/'.a:template
endfunction
command! -bang -nargs=* LoadVimSpectorJsonTemplate call fzf#run({
			\   'source': 'ls -1 ~/.config/nvim/vimspector_json',
			\   'down': 20,
			\   'sink': function('<sid>read_template_into_buffer')
			\})
noremap <leader>vs :tabe .vimspector.json<CR>:LoadVimSpectorJsonTemplate<CR>
sign define vimspectorBP text=☛  texthl=Normal
sign define vimspectorBPDisabled text=☞ texthl=Normal
sign define vimspectorPC text=  texthl=SpellBad 

"---------------------------------   vimspector  ---------------------------------


