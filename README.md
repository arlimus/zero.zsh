# zero's zsh

Consists of a theme and a plugin. They can be used independently. Both have to be activated explicitly.

### theme

* simple clean design
* support for git and hg repositories
* 256-color theme

Set theme to `zero` if you have a dark terminal:

![Preview in themes/zero.zsh-theme.png](https://raw.github.com/arlimus/zero.zsh/master/themes/zero.zsh-theme.png)

Set theme to `zero-light` if you have a light terminal:

![Preview in themes/zero-light.zsh-theme.png](https://raw.github.com/arlimus/zero.zsh/master/themes/zero-light.zsh-theme.png)

If you want to quickly change the theme, use the plugin (see below). This will provide these commands:

    dark_theme        # sets the theme for dark terminals
                      # (white text on black background)
    light_theme       # sets the theme for light terminals
                      # (black text on white background)
    zsh_reload_theme  # quickly reload zsh

References:

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

* grep all IPv4 and IPv6 addresses also works in global style via `,g_ip`, `,g_ip4`, `,g_ip6`

        grep_ip nmap_output.txt
        grep_ip4 nmap_output.txt
        grep_ip6 nmap_output.txt
        nmap 192.168.0.0/24 ,g_ip4

* if they are installed, use advcp utilities (coreutils' cp and mv with progress bar)

        cp -rv a /to/b                 # /usr/bin/acp -g " -rv a /to/b
        mv -v a /to/b                  # /usr/bin/amv -g " -v a /to/b

* misc global aliases

        cat huge.txt ,l                # cat huge.txt  | less
        ./stdout+stderr.sh ,la         # ./stdout+stderr.sh 2>&1 | less"
        cat my.html ,g "<h3" ,g "id="  # cat my.html  | grep  "<h3"  | grep  "id="
        cat ALLCAPS ,gi noncaps        # cat ALLCAPS  | grep --ignore-case  noncaps
        cat my.html ,go "href=[^ ]*"   # cat my.html  | grep --only  "href=[^ ]*"
        ./run.daemon ,nul              # ./run.daemon > /dev/null 2>&1
        ls -1 ,s                       # ls -1  | sort
        cat lines ,sr                  # cat lines  | sort --reverse
        du -hs * ,sh                   # du -hs *  | sort --human-numeric-sort
        du -hs * ,shr                  # du -hs *  | sort --human-numeric-sort --reverse
        ls -1 ,count                   # ls -1  | wc --lines
        ls -1 ,cl                      # ls -1  | wc --lines
        cat essay.txt ,cw              # cat essay.txt  | wc --words
        cat my.bin ,cb                 # cat my.bin  | wc --bytes


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
