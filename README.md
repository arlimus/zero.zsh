# zero's zsh

Consists of a theme and a plugin. They can be used independently. Both have to be activated explicitly.

### theme

* simple clean design
* support for git and hg repositories

![Preview in themes/zero.zsh-theme.png](master/themes/zero.zsh-theme.png)

references:

* prose theme + guide (see: http://stevelosh.com/blog/2010/02/my-extravagant-zsh-prompt/)
* the many preexisting themes (see: https://github.com/robbyrussell/oh-my-zsh/tree/master/themes)

### plugin

Please see [plugins/zero/zero.plugin.zsh](master/plugins/zero/zero.plugin.zsh). All changes are well documented.


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
