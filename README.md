# :shit: Dotfiles :bomb:

Repo to store configuration files (AKA *dotfiles*) of:

- Bash (`.bashrc`)
- Vim (`.vimrc`)
- Tmux (`.tmux.conf`)
- Ssh (`.ssh/config`)
- Anaconda (`.condarc`)
- Git (`.gitconfig`)
- Matplotlib (`.config/matplotlib/matplotlibrc`)
   
# Clone the dotfiles on new system:

    echo ".dotfiles" >> .gitignore
    git clone --bare https://github.com/francescoboc/dotfiles $HOME/.dotfiles
    alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
    dotfiles checkout
    dotfiles config --local status.showUntrackedFiles no

# Recommended packages:
- Vim with clipboard support:

        sudo apt install vim-gtk3
        git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
        
- Latex (to be used in matplotlib):

        sudo apt install texlive-latex-extra --no-install-recommends 
        apt install cm-super dvipng
        tlmgr init-usertree
        (sudo apt install xzdec)
        tlmgr option repository ftp://tug.org/historic/systems/texlive/2021/tlnet-final
        tlmgr install <package>
        
- Qt5 dependencies (used by matplotlib):
   
        sudo apt install libgl1
        sudo apt install '^libxcb.*-dev' libx11-xcb-dev libglu1-mesa-dev libxrender-dev libxi-dev libxkbcommon-dev libxkbcommon-x11-dev

# WSL-specific options: 
- To enable changing file owners & permissions, edit (or create) `/etc/wsl.conf` and insert the following lines:

        [automount]
        options = "metadata"
        
- To enable `systemd` support, add:

        [boot]
        systemd = true
    
- To solve `Warning: No xauth data; using fake authentication data for X11 forwarding.`, run these commands in ~ folder of local machine:

        touch .Xauthority
        xauth add :0 . `mcookie`
