set rnu
set list
set mouse=
set number
set expandtab
set scrolloff=5
set shiftwidth=4
set softtabstop=4
set encoding=utf-8
set foldmethod=marker
set listchars=tab:>-,trail:▫
set fileencodings =ucs-bom,utf-8,chinese

call plug#begin('~/.config/nvim/plugged')

Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-startify'
Plug 'Yggdroot/indentLine'
Plug 'yaocccc/nvim-hlchunk'
Plug 'chentoast/marks.nvim'
Plug 'liuchengxu/vista.vim'
Plug 'RRethy/vim-illuminate'
Plug 'voldikss/vim-floaterm'
Plug 'airblade/vim-gitgutter'
Plug 'preservim/nerdcommenter'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'puremourning/vimspector', {'do': './install_gadget.py --enable-python --enable-c'}

call plug#end()

"--------
"---------------------------------      Packer插件配置管理
"--------

lua require('plugins')
lua require('plugin-config/nvim-lines')
lua require('plugin-config/nvim-marks')
lua require('plugin-config/nvim-treesitter')

"--------
"---------------------------------      Packer插件配置管理
"--------

"--------
"---------------------------------      basic
"--------
"

let mapleader = " "

inoremap ( ()<ESC>i
inoremap [ []<ESC>i
inoremap { {}<ESC>i
inoremap ' ''<ESC>i
inoremap " ""<ESC>i

nnoremap <silent> J 5j
nnoremap <silent> K 5k
nnoremap <silent> H 5h
nnoremap <silent> L 5l

vnoremap <silent> J 5j
vnoremap <silent> K 5k
vnoremap <silent> H 5h
vnoremap <silent> L 5l

vnoremap <silent> <tab>   >gv
vnoremap <silent> <s-tab> <gv

nnoremap <silent> <C-h> :bp<CR>
nnoremap <silent> <C-l> :bn<CR>
nnoremap <silent> <C-^> :bd<CR>

inoremap <silent> <C-k> <up>
inoremap <silent> <C-j> <down>
inoremap <silent> <C-h> <left>
inoremap <silent> <C-l> <right>

nnoremap <silent> <leader>h <C-w>h
nnoremap <silent> <leader>j <C-w>j
nnoremap <silent> <leader>k <C-w>k
nnoremap <silent> <leader>l <C-w>l
vnoremap <silent> <leader><PageUp>   "+y
nnoremap <silent> <leader><PageDown> "+p

nnoremap <silent> <leader><up>    :resize -5<CR>
nnoremap <silent> <leader><down>  :resize +5<CR>
nnoremap <silent> <leader><left>  :vertical resize -10<CR>
nnoremap <silent> <leader><right> :vertical resize +10<CR>

colorscheme mycolors

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

"--------
"---------------------------------      basic
"--------


"--------
"---------------------------------      markdown
"--------

"autocmd Filetype markdown map <leader>w yiWi[<esc>Ea](<esc>pa)
let g:mkdp_auto_start  =  0
autocmd Filetype markdown nnoremap <C-p> : MarkdownPreviewToggle<CR>
autocmd Filetype markdown inoremap ;f   <Esc>/<++><CR>:nohlsearch<CR>c4l
autocmd Filetype markdown inoremap ;n   ---<Enter><Enter>
autocmd Filetype markdown inoremap ;b   **** <++><Esc>F*hi
autocmd Filetype markdown inoremap ;s   ~~~~ <++><Esc>F~hi
autocmd Filetype markdown inoremap ;i   ** <++><Esc>F*i
autocmd Filetype markdown inoremap ;d   `` <++><Esc>F`i
autocmd Filetype markdown inoremap ;c   ```<Enter><++><Enter>```<Enter><Enter><++><Esc>4kA
autocmd Filetype markdown inoremap ;h   ====<Space><++><Esc>F=hi
autocmd Filetype markdown inoremap ;p   ![](<++>) <++><Esc>F[a
autocmd Filetype markdown inoremap ;a   [](<++>) <++><Esc>F[a
autocmd Filetype markdown inoremap ;1   #<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap ;2   ##<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap ;3   ###<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap ;4   ####<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap ;l   --------<Enter>

"--------
"---------------------------------      markdown
"--------

"--------
"---------------------------------      cilluminate
"--------

let g:Illuminate_useDeprecated = 1
augroup illuminate_augroup
    autocmd!
    autocmd VimEnter * hi illuminatedWord cterm=underline  gui=italic
augroup END

"--------
"---------------------------------      cilluminate
"--------

"--------
"---------------------------------      coc.nvim
"--------

hi! link CocPum Pmenu
hi! link CocMenuSel PmenuSel
set shortmess+=c
set updatetime=300
nmap <leader>rn <Plug>(coc-rename)
let g:coc_git_status = 1
let b:coc_git_status = 1
inoremap <silent><expr> <C-n> coc#pum#visible() ? coc#pum#next(1) : "<TAB>"
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
noremap <silent> <LEADER>p <Plug>(coc-diagnostic-prev)
noremap <silent> <LEADER>n <Plug>(coc-diagnostic-next)

noremap <silent> gd <Plug>(coc-definition)
noremap <silent> gy <Plug>(coc-type-definition)
noremap <silent> gi <Plug>(coc-implementation)
noremap <silent> gr <Plug>(coc-references)

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" Insert <tab> when previous text is space, refresh completion if not.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#_select_confirm()
                             \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
"--------
"---------------------------------      coc.nvim
"--------

"--------
"---------------------------------      vimspector
"--------

nnoremap <Leader>di <Plug>VimspectorBalloonEval
vnoremap <Leader>di <Plug>VimspectorBalloonEval
nnoremap <silent> <F7> : let &mouse=&mouse=="a"?"":"a"<CR>
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
nnoremap <leader>vs :tabe .vimspector.json<CR>:LoadVimSpectorJsonTemplate<CR>
sign define vimspectorBP            text=☛   texthl=Normal
sign define vimspectorBPDisabled    text=☞   texthl=Normal
sign define vimspectorPC            text=❯❯  texthl=Special  
sign define vimspectorPCBP          text=●   texthl=WarningMsg 
sign define vimspectorCurrentThread text=   texthl=Special  
sign define vimspectorCurrentFrame  text=ﰉ   texthl=Special 

"--------
"---------------------------------      vimspector
"--------

"--------
"---------------------------------      fzf
"--------

nnoremap <silent> <leader>r :Rg<CR>
nnoremap <silent> <leader>f :Files<CR>
let g:fzf_layout = { 'window' : { 'width' : 0.5, 'height' : 0.6, 'border' : 'sharp' } }
let g:fzf_colors = { 'fg':  ['fg', 'Normal' ], 'bg':  ['bg', 'Normal' ], 'border': [ 'fg', 'Pmenu'] }

"--------
"---------------------------------      fzf
"--------

"--------
"---------------------------------      gitgutter
"--------

highlight GitGutterAdd     ctermfg=2
highlight GitGutterChange  ctermfg=3
highlight GitGutterDelete  ctermfg=1

"--------
"---------------------------------      gitgutter
"--------

"--------
"---------------------------------      floaterm
"--------

nnoremap <silent> <F2> : call CompileRun()<CR>
nnoremap <silent> <leader><F2> : FloatermKill<CR>

function! CompileRun()

    if &filetype == 'cpp' 

        :FloatermNew --title=─ --autoclose=0 g++ % -g && ./a.out   

    elseif &filetype == 'python'

        :FloatermNew --title=─ --autoclose=0 python %<.py  

    endif

endfunction

"--------
"---------------------------------      floaterm
"--------

"--------
"---------------------------------      vista
"--------

nnoremap <silent> <leader>t :Vista!!<CR>
let g:vista_echo_cursor = 0
let g:vista_stay_on_open = 0
let g:vista_blink = [ 0, 0 ]
let g:vista_disable_statusline = 1
let g:vista_enable_centering_jump = 1
let g:vista_top_level_blink = [ 0, 0 ]
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\   "prototype": "\uf1fb"
\  }

"--------
"---------------------------------      vista
"--------

"--------
"---------------------------------      markers
"--------

nnoremap <silent> dm<space> :delm!<CR> 

"--------
"---------------------------------      markers
"--------

"--------
"---------------------------------      nerdcommenter
"--------

let g:NERDSpaceDelims = 0
let g:NERDToggleCheckAllLines = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDCustomDelimiters = { 'c': { 'left': '//' }, 'py': { 'left': '#' }, }

"--------
"---------------------------------      nerdcommenter
"--------

"--------
"---------------------------------      multi
"--------

let g:VM_theme              = 'ocean'
let g:VM_maps               = {}
let g:VM_highlight_matches  = 'underline'

"--------
"---------------------------------      multi
"--------

"--------
"---------------------------------      indentLine
"--------

let g:indentLine_fileTypeExclude = [ 'startify', 'floaterm', 'c', 'cpp', 'json' ]

"--------
"---------------------------------      indentLine
"--------

"--------
"---------------------------------      hlchunk
"--------

let g:hlchunk_files = '*.json,*.h,*.c,*.cpp'
let g:hlchunk_chars = [ '─', '─', '┌', '│','└', '─', '' ]

"--------
"---------------------------------      hlchunk
"--------
