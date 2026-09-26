" enable mouse support "
set mouse=a
"set ttymouse=sgr

" enable syntax "
syntax on

" enable line numbers "
set number
set relativenumber

" highlight current line "
set cursorline
:highlight Cursorline cterm=bold ctermbg=black

" enable highlight search pattern "
set hlsearch

" enable smartcase search sensitivity "
set ignorecase
set smartcase

filetype plugin indent on

" Indentation using spaces "
" tabstop:      width of tab character
" softtabstop:  fine tunes the amount of whitespace to be added
" shiftwidth:   determines the amount of whitespace to add in normal mode
" expandtab:    when on use space instead of tab
" textwidth:    text wrap width
" autoindent:   autoindent in new line
set tabstop     =4
set softtabstop =4
set shiftwidth  =4
set textwidth   =79
set expandtab
set autoindent

" dockerfile syntax match
autocmd BufRead,BufNewFile *Dockerfile* set syntax=dockerfile
autocmd BufRead,BufNewFile *dockerfile* set syntax=dockerfile

" visual block when matching begin/ends of blocks
"
noremap % v%

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

" show the matching part of pairs [] {} and () "
set showmatch

" remove trailing whitespace from Python and Fortran files "
"autocmd BufWritePre *.py :%s/\s\+$//e
"autocmd BufWritePre *.f90 :%s/\s\+$//e
"autocmd BufWritePre *.f95 :%s/\s\+$//e
"autocmd BufWritePre *.for :%s/\s\+$//e

" enable color themes "
"if !has('gui_running')
        set t_Co=256
"endif
" enable true colors support "
set termguicolors

" Lightline
set laststatus=1
set noshowmode

let g:lightline = { 'colorscheme': 'one', }

" Vim colorscheme "
"colorscheme catppuccin_mocha

let g:one_allow_italics = 1
colorscheme one
"set background=dark " for the dark version
"set background=light " for the light version
" Path to the theme file
command! ReloadTheme call <SID>LoadTheme()
function! s:LoadTheme()
  let s:theme_file = expand('$HOME') . '/SYSTEM_THEME'
  if filereadable(s:theme_file)
    let s:theme = trim(readfile(s:theme_file)[0])
    if s:theme ==# 'dark'
      set background=dark
    elseif s:theme ==# 'light'
      set background=light
    endif
  endif
endfunction
call <SID>LoadTheme()

augroup ThemeReload
  autocmd!
  autocmd Signal SIGUSR1 call <SID>LoadTheme()
augroup END

" Uncomment if color issue is there <--------------
hi Normal guibg=NONE ctermbg=NONE

" Netrw Customisations
let g:netrw_banner = 0
let g:netrw_liststyle = 3
"-------------------------------------------------------------"
"Bonus. " Find & Replace (if you use the ignorecase, smartcase these are mandatory) "
"            :%s/<find>/<replace>/g   "replace global (e.g. :%s/mass/grass/g)"
"            :%s/<find>/<replace>/gc  "replace global with confirmation"
"            :%s/<find>/<replace>/gi  "replace global case insensitive"
"            :%s/<find>/<replace>/gI  "replace global case sensitive"
"            :%s/<find>/<replace>/gIc "replace global case sensitive with confirmation"

"        " Vim (book)marks "
"            mn     "replace n with a word A-Z or number 0-9"
"            :'n     "go to mark n"
"            :`.     "go to the last change"
"            :marks  "show all declared marks"
"            :delm n "delete mark n"

"        " Delete range selection "
"            :<line_number>,<line_number>d "(e.g. :2,10d deletes lines 2-10)"

"        " LaTeX shortcuts "
"            nnoremap <F1> :! pdflatex %<CR><CR>
"            nnoremap <F2> :! bibtex $(echo % \| sed 's/.tex$//') & disown<CR><CR>
"            nnoremap <F3> :! evince $(echo % \| sed 's/tex$/pdf/') & disown<CR><CR>
"            nnoremap <F4> :! rm *.log *.aux *.out *.blg & disown<CR><CR>

set directory=~/.vim/swapfiles//

" open terminal below all splits
cabbrev bterm bo term

inoremap <C-s> <Esc>:w<cr> i
nnoremap <C-s> :w<cr>

inoremap <C-z> <Esc>u<cr>i
nnoremap <C-z> u<cr>

inoremap <C-t> <Esc>:tabnew<cr>
nnoremap <C-t> :tabnew<cr>

"inoremap <C-n> <Esc>:enew<cr>
"nnoremap <C-n> :enew<cr>

inoremap <C-l> <Esc>:Lex 20<cr>
nnoremap <C-l> :Lex 20<cr>

" nnoremap _ <C-w>s
" nnoremap \| <C-w>v

nnoremap _ :new<cr>
nnoremap \| :vnew<cr>

inoremap <C-q> <Esc>:q<cr>
nnoremap <C-q> :q<cr>

" inoremap <C-e> <Esc>:bo term<cr>
" nnoremap <C-e> :bo term<cr>

inoremap <C-e> <Esc>:! tmux split-window -v bash<cr><cr>
nnoremap <C-e> :! tmux split-window -v bash<cr><cr>

inoremap <C-b> <Esc>:w<cr>:! tmux split-window -v bash -c "kirun %"<cr><cr>
nnoremap <C-b> :w<cr>:! tmux split-window -v bash -c "kirun %"<cr><cr>

inoremap <M-b> <Esc>:w<cr>:bo term bash -xc "kirun % -l"<cr>
nnoremap <M-b> :w<cr>:bo term bash -xc "kirun % -l"<cr>

nnoremap ts :source ~/.vimrc<cr>

tnoremap <Esc><Esc> <C-\><C-n>:setlocal nonumber<cr>:setlocal norelativenumber<cr>

"nnoremap <leader>/ :Commentary<cr>
"inoremap <leader>/ :Commentary<cr>

imap <C-_> <Esc>gcl<cr>i
nmap <C-_> gcl<cr>
vmap <C-_> gcl<cr>

" let &t_SI = "\<Esc>]50;CursorShape=1\x7"
" let &t_SR = "\<Esc>]50;CursorShape=2\x7"
" let &t_EI = "\<Esc>]50;CursorShape=0\x7"

"let &t_SI = "\<Esc>[6 q"
"let &t_SR = "\<Esc>[4 q"
"let &t_EI = "\<Esc>[2 q"

set textwidth=0
set wrapmargin=0
set wrap
set linebreak
set whichwrap+=<,>,[,]

if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color GNU screen.
  set t_ut=
endif

function! CheatSh(query) abort
  let q = substitute(a:query, '\s\+', '+', 'g')
  let url = 'https://cht.sh/' . q . '?T'

  new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
  execute '0read !curl -s ' . shellescape(url)
  1delete _
endfunction

function! CheatReplace(query) abort
  let q = substitute(a:query, '\s\+', '+', 'g')
  let url = 'https://cht.sh/' . q . '?TQ'

  let lines = split(system('curl -s ' . shellescape(url)), "\n")

  " keep first contiguous non-empty code block
  let out = []
  for l in lines
    if l =~# '^\s*$'
      if !empty(out)
        break
      endif
      continue
    endif
    call add(out, l)
  endfor

  if empty(out)
    echo "No cheat.sh result"
    return
  endif

  execute 'normal! "_dd'
  call append(line('.') - 1, out)
endfunction

" open in scratch buffer
nnoremap <leader>? :call CheatSh(expand('<cword>'))<CR>
vnoremap <leader>? y:call CheatSh(getreg('"'))<CR>

" replace current line
nnoremap <leader>r :call CheatReplace(getline('.'))<CR>

" replace visual se[<8;5;26mlection
vnoremap <leader>r y:call CheatReplace(getreg('"'))<CR>

