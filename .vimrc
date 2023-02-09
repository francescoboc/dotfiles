" Francesco Boccardo's VIM configuration file 
" Based on http://vim.wikia.com/wiki/Example_vimrc
"------------------------------------------------------------
"
" ---- VUNDLE PLUGIN MANAGER ----
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" " The following are examples of different formats supported.
" " Keep Plugin commands between vundle#begin/end.
 Plugin 'itchyny/lightline.vim'
 Plugin 'nanotech/jellybeans.vim'
 Plugin 'scrooloose/nerdtree'
 Plugin 'tpope/vim-commentary'
 Plugin 'romainl/vim-cool'
 Plugin 'christoomey/vim-tmux-navigator'
 Plugin 'djoshea/vim-autoread'
 Plugin 'unblevable/quick-scope'
 Plugin 'wincent/scalpel'
 Plugin 'mbbill/undotree'
 Plugin 'christoomey/vim-tmux-runner'
 Plugin 'kshenoy/vim-signature'

" All of your Plugins must be added before the following line
call vundle#end()            " required
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" ---- END OF VUNDLE ----

" Features 
"
" These options and commands enable some very useful features in Vim, that
" no user should have to live without.

" fixes entering in replace mode at startup
set t_u7=

" for mouse compatibility
set ttymouse=sgr

" if the terminal variable contains 'screen' (i.e. we are using tmux), then 
" override the ttymouse variable. this ensures correct mouse integration in tmux
if &term =~ '^screen' && exists('$TMUX')
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
    " tmux will send xterm-style keys when xterm-keys is on
    " this is needed to have the C-arrow keys work when vim is running in tmux
    " NB not needed if we set -g xterm-keys on in .xterm.conf and
    " TERM='xterm-256colors' in .bashrc
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
    execute "set <xHome>=\e[1;*H"
    execute "set <xEnd>=\e[1;*F"
    execute "set <Insert>=\e[2;*~"
    execute "set <Delete>=\e[3;*~"
    execute "set <PageUp>=\e[5;*~"
    execute "set <PageDown>=\e[6;*~"
    execute "set <xF1>=\e[1;*P"
    execute "set <xF2>=\e[1;*Q"
    execute "set <xF3>=\e[1;*R"
    execute "set <xF4>=\e[1;*S"
    execute "set <F5>=\e[15;*~"
    execute "set <F6>=\e[17;*~"
    execute "set <F7>=\e[18;*~"
    execute "set <F8>=\e[19;*~"
    execute "set <F9>=\e[20;*~"
    execute "set <F10>=\e[21;*~"
    execute "set <F11>=\e[23;*~"
    execute "set <F12>=\e[24;*~"
endif

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on

" Enable syntax highlighting
syntax on

" Change color scheme
colorscheme jellybeans

" Set terminal colors to 256. Not needed if we have set -g default-terminal "screen-256color"
" in .tmux.config and TERM=xterm-256color in .bashrc or in the terminal options
" set t_Co=256

" Disable background color erase (needed with xterm-256colors)
set t_ut=

" Override colors of search highliting
hi Search cterm=none ctermbg=24 ctermfg=white

" set the style of splits the same as tmux
set fillchars=vert:│
hi VertSplit ctermbg=none

" Change clorscheme of lightline plugin
" let g:lightline = { 'colorscheme': 'jellybeans' }

" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" To better support the whitespace in vim-tmux-runner
let g:VtrStripLeadingWhitespace = 0
let g:VtrClearEmptyLines = 0
let g:VtrAppendNewline = 1

" Disable tmux navigator when zooming the Vim pane
let g:tmux_navigator_disable_when_zoomed = 1

" Marks bar plugin disabled at startup
let g:SignatureEnabledAtStartup=0

"------------------------------------------------------------
" Must have options 
"
" These are highly recommended options.

" Vim with default settings does not allow easy switching between multiple files
" in the same editor window. Users can use multiple split windows or multiple
" tab pages to edit multiple files, but it is still best to enable an option to
" allow easier switching between files.
"
" One such option is the 'hidden' option, which allows you to re-use the same
" window and switch from an unsaved buffer without saving it first. Also allows
" you to keep an undo history for multiple files when re-using the same window
" in this way. Note that using persistent undo also lets you undo in multiple
" files even in the same window, but is less efficient and is actually designed
" for keeping undo history after closing Vim entirely. Vim will complain if you
" try to quit without saving, and 23 files will keep you safe if your computer
" crashes.
set hidden

" Note that not everyone likes working this way (with the hidden option).
" Alternatives include using tabs or split windows instead of re-using the same
" window as mentioned above, and/or either of the following options:
" set confirm
" set autowriteall
 
" Better command-line completion
set wildmenu
  
" Show partial commands in the last line of the screen
set showcmd
   
" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set hlsearch
 
" Modelines have historically been a source of security vulnerabilities. As
" such, it may be a good idea to disable them and use the securemodelines
" script, <http://www.vim.org/scripts/script.php?script_id=1876>.
" set nomodeline
  
"------------------------------------------------------------
" Usability options 
"
" These are options that users frequently set in their .vimrc. Some of them
" change Vim's behaviour in ways which deviate from the true Vi way, but
" which are considered to add usability. Which, if any, of these options to
" use is very much a personal preference, but they are harmless.
 
" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase
  
" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start
   
" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent
    
" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline
 
" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler
  
" Always display the status line, even if only one window is displayed
set laststatus=2
   
" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm
    
" Use visual bell instead of beeping when doing something wrong
set visualbell
     
" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
set t_vb=
 
" Enable use of the mouse for all modes
set mouse=a
  
" Set the command window height to 2 lines, to avoid many cases of having to 
" press <Enter> to continue
set cmdheight=2
   
" Display line numbers on the left
set number

" Set relative numbering on
set relativenumber
   
" " Automatically toggle between line number modes when entering insert
" mode or when the buffer loses focus
" :augroup numbertoggle
" :  autocmd!
" :  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
" :  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
" :augroup END 

" Quickly time out on keycode
set ttimeout ttimeoutlen=200
" set notimeout ttimeout ttimeoutlen=200
" set timeout ttimeout ttimeoutlen=200  timeoutlen=1000
 
" Toggle between 'paste' and 'nopaste'
set pastetoggle=<F10>

" Set highlighting of current line
set cursorline

" Set incremental search
set incsearch

" Hide current mode (INSERT...) since we are using lightline plugin
set noshowmode

" Disable automatic commenting on newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Splits open at the bottom and right
set splitbelow splitright

" These below are not needed with the autoread plugin
" Trigger checktime when changing buffers or coming back to vim.
" au FocusGained,BufEnter * :checktime

" " Trigger checktime when the cursor stays still for updatetime milliseconds (default 4000)
" au CursorHold * :checktime

" Turning this on will make the file automatically refresh if it has changed
" set autoread

" Automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" Folds are defined by indentation
set foldmethod=indent
" Do not fold when opening a file
set nofoldenable
" Only fold 1 level of indentation (i.e. fold classes, not methods)
set foldnestmax=1

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid, when inside an event handler
" and for a commit message (it's likely a different one than last time).
autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
  \ |   exe "normal! g`\""
  \ | endif

"------------------------------------------------------------
" Indentation options 
"
" Indentation settings according to personal preference.
    
" Indentation settings for using 4 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
set shiftwidth=4
set softtabstop=4
set expandtab
 
" Indentation settings for using hard tabs for indent. Display tabs as
" four characters wide.
"set shiftwidth=4
"set tabstop=4

" Show number of matches in the command-line (feature of vim-cool plugin)
let g:CoolTotalMatches = 1
  
" Change the color of the highlighting of TODOs
:hi todo ctermfg=red

"------------------------------------------------------------
" Mappings 
"
" Useful mappings

" Disabe leader button (map it to something stupid)
let mapleader = 'ä'

" " Hitting space makes j and k move faster
" nmap <Space>j 10j<Space>
" nmap <Space>k 10k<Space>
" nmap <Space><Space> <Nop>

" Map shift-movement to 10 x movement
nnoremap <s-k> 10- 
nnoremap <s-j> 10+
noremap <s-l> 10l
nnoremap <s-h> 10h
" And remap join command (the only useful that was there) to M (Merge)
nnoremap <s-m> :join<CR> 
vnoremap <s-m> :join<CR> 

" Remap the jumplist commands (because c-i = tab is already used)
nnoremap <c-p> <c-o>
nnoremap <c-o> <c-i>

" Redo with U instead of Ctrl+R
nnoremap U <c-r>

" Spacebar to repeat last command (super useful!)
nnoremap <space> .

" Ctrl - F to Find occurencies of selected word
" nnoremap <c-f> /
" nnoremap <c-f> /<C-r><C-w>

" Ctrl - R to find and Replace occurencies of selected word
" nnoremap <c-r> :%s/<C-r><C-W>//gc<left><left><left>
" vnoremap <c-r> :s/<C-r><C-W>//gc<left><left><left>
" nnoremap <c-r> :%s/\<<C-r><C-w>\>//gc<left><left><left>
" vnoremap <c-r> :s/\<<C-r><C-w>\>//gc<left><left><left>
nmap <c-r> <Plug>(Scalpel)

" " Prevent the plugin vim-tmux-navigator from creating any mappings
" " this is to avoid overriding the C-\ mapping
" let g:tmux_navigator_no_mappings = 1

" " And redefine them
" nnoremap <silent> <c-h> :TmuxNavigateLeft<CR>
" nnoremap <silent> <c-j> :TmuxNavigateDown<CR>
" nnoremap <silent> <c-k> :TmuxNavigateUp<CR>
" nnoremap <silent> <c-l> :TmuxNavigateRight<CR>

" Disable Q to enter Ex mode (which I have no idea what it is)
nnoremap Q <Nop>

" Ctrl-S to Save file
noremap  <silent> <c-s>         :update<CR>
vnoremap <silent> <c-s>         <Esc>:update<CR>
inoremap <silent> <c-s>         <Esc>:update<CR> 

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy, which is the default
map Y y$

" " Map x to t to the black hole register, so it doesn't overwrite the register
" nnoremap x "_x
" xnoremap x "_x

" Don't need the following 2 anymore with vim-cool plugin!
" " Map Ctrl-L (redraw screen) to also turn off search highlighting until the
" " next search
" nnoremap <C-L> :nohl<CR><C-L>

" " Unset the last search pattern register by hitting return
" nnoremap <CR> :noh<CR>

" " Make split navigation faster (only need CTRL instead than CTRL-w)
" (not needed with vim-tmux-navigator plugin)
" map <C-h> <C-w>h
" map <C-Left> <C-w><Left>
" map <C-j> <C-w>j
" map <C-Down> <C-w><Down>
" map <C-k> <C-w>k
" map <C-Up> <C-w><Up>
" map <C-l> <C-w>l
" map <C-Right> <C-w><Right>

" Toggle on/off NERDtree
nnoremap <silent> <tab> :NERDTreeToggle<CR>

" Automatically close NERDtree when opening a file
let NERDTreeQuitOnOpen = 1
" Remap vertical and horizontal split shortcuts
let NERDTreeMapOpenVSplit='v'
let NERDTreeMapOpenSplit='s'

" Toggle undotree in normal mode
nnoremap <silent> ù :UndotreeToggle<cr>

" Open an ipython runner panel in tmux
nnoremap qo :VtrOpenRunner {'orientation': 'h', 'percentage': 25, 'cmd': 'ipy'}<cr>

" Kill the existing runner panel
nnoremap qk :VtrKillRunner<cr>
" Attach runner to existing panel
nnoremap qa :VtrAttachToPane<cr>
" Clear runner
nnoremap qc :VtrClearRunner<cr>
" Run current python script
nnoremap qr :VtrSendFile<cr>
let g:vtr_filetype_runner_overrides = {
    \ 'python': 'run {file}',
    \ }
" Send the current line or the current visual selection from the Vim buffer to the runner pane for execution
nnoremap qs :VtrSendLinesToRunner<cr>
vnoremap qs :VtrSendLinesToRunner<cr>

" Paste from system clipboard
nmap qp "+p
" Yank to system clipboard
nmap qy "+y

" Toggle fold under cursos
nnoremap zx za
" Close all
nnoremap zX zM
" Unfold all
nnoremap zU zR

" Invert behaviour of 0 (easier to press) and ^
nnoremap ^ 0
nnoremap 0 ^

" Toggle comment on line in normal mode
nmap ò gcc
" Toggle comment on selected lines in visual mode
vmap ò gc<cr>
" Toggle comment on current paragraph
nmap ç gcap

" Useful mappings for italian keyboard
nnoremap , ;
nnoremap ; ,
nnoremap g, g;
nnoremap g; g,
nnoremap \ ~

" Zoom / Restore window
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()

" Toggle zoom in tmux
nnoremap <silent> <C-w>z :ZoomToggle<CR>

" Show marks sidebar
nnoremap <silent> qm :SignatureToggle<CR>

" Map TAB to show list of matches for word autocompletion, when in insert mode
inoremap <TAB> <C-n>

" Quick mappings for 'buffer next' and 'buffer before'
nnoremap bn :bn<CR>
nnoremap bb :bp<CR>
cnoreabbrev <expr> bb 'bp'

" " Function to change keymappings between US and italian
" let keyboard_flag=0
" function! SwitchKeyboard()
"     if g:keyboard_flag==0
"         let g:keyboard_flag=1
"         nnoremap <silent> ù :UndotreeToggle<cr>
"         nmap ò gcc
"         vmap ò gc
"         nmap ç gcap
"         nnoremap , ;
"         nnoremap ; ,
"         nnoremap g, g;
"         nnoremap g; g,
"         nnoremap \ ~
"         echo 'Switched to Italian keyboard'
"     else
"         let g:keyboard_flag=0
"         nmap \ gcc
"         vmap \ gc
"         nmap <bar> gcap
"         echo 'Switched to US keyboard'
"     endif
" endfunction
" nnoremap <F12> :call SwitchKeyboard()<cr>

"------------------------------------------------------------
"Extra options

" Change the default commentstring for c,c++ and java to //
autocmd FileType c,cpp,java setlocal commentstring=//\ %s

" Remap the command :vert sb (vertical split buffer) to :vb
cnoreabbrev <expr> vb ((getcmdtype() is# ':' && getcmdline() is# 'vb')?('vert sb'):('vb'))
