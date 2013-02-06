# zero's zsh

Consists of a theme and a plugin. They can be used independently. Both have to be activated explicitly.

### theme

* simple clean design
* support for git and hg repositories

![Preview in themes/zero.zsh-theme.png](https://raw.github.com/arlimus/zero.zsh/master/themes/zero.zsh-theme.png)

references:

* prose theme + guide (see: http://stevelosh.com/blog/2010/02/my-extravagant-zsh-prompt/)
* the many preexisting themes (see: https://github.com/robbyrussell/oh-my-zsh/tree/master/themes)

### plugin

Please see [plugins/zero/zero.plugin.zsh](zero.zsh/blob/master/plugins/zero/zero.plugin.zsh). All changes are well documented.

Short reference:

  * misc shorthands

        sizeof *                       # du -hs  *
        ..                             # cd ../
        .....                          # cd ../../../../
  * quickly go to root folder of git repository

        cdgit
  * grep all IPv4 and IPv6 addresses

        grep_ip nmap_output.txt
        grep_ip4 nmap_output.txt
        grep_ip6 nmap_output.txt
  * if they are installed, use advcp utilities (coreutils' cp and mv with progress bar)

        cp -rv a /to/b                 # /usr/bin/acp -g " -rv a /to/b
        mv -v a /to/b                  # /usr/bin/amv -g " -v a /to/b
  * misc global aliases

        cat huge.txt L                 # cat huge.txt  | less
        ./stdout+stderr.sh LL          # ./stdout+stderr.sh 2>&1 | less"
        cat my.html G "<h3" G "id="    # cat my.html  | grep  "<h3"  | grep  "id="
        ./run.daemon NUL               # ./run.daemon > /dev/null 2>&1
        du -hs * SH                    # du -hs *  | sort -h
        ls -1 LC                       # ls -1  | wc -l


## Requirments

* zsh
* oh-my-zsh

## Installation

Installation in home directory of current user:

    ./install.sh

Now edit `~/.zshrc` and:

    # set zero as the theme
    ZSH_THEME="zero"

    # add zero to the list of plugins
    plugins=(git zero)

Reload your zsh and you are ready to go.
