# dotfiles
Repo to store configuration files (AKA *dotfiles*) of:

- Bash (`.bashrc`)
- Vim (`.vimrc`)
- Tmux (`.tmux.conf`)
- Ssh (`.ssh/config`)
- Anaconda (`.condarc`)

WSL: To enable changing file owners & permissions, edit (or create) `/etc/wsl.conf` and insert the below config options:

    [automount]
    options = "metadata"
