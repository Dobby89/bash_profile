TERM=xterm-color

export CLICOLOR=1
export LSCOLORS=Gxfxcxdxbxegedabagacad

export PATH=/usr/local/share/npm/bin:$PATH
export PATH=/Applications/Sublime\ Text.app/Contents/SharedSupport/bin:$PATH
export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export PATH=/Applications/Xcode.app/Contents/Developer/usr/bin:$PATH
export PATH=/usr/local/Cellar/ruby/1.9.3-p327/bin:$PATH
export ANDROID_HOME=/usr/local/opt/android-sdk


export GIT_EDITOR="subl -n -w"
export NODE_PATH=/usr/local/lib/node_modules:$NODE_PATH

export DEV=/Users/robin/Documents/workspace

export GREP_OPTIONS='--color=auto'
# export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--system-site-packages'
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'

# aliases
alias ll='ls -lh'
alias la='ls -Alh'
alias l='ls -CF'
alias tarara='exit'

alias cleansql="perl -p -i -e 's/DEFINER=\`.+?\`@\`.+?\`//g'"

#alias subl="/Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl"
alias flushmc="echo 'flush_all' | nc localhost 11211"
alias flushredis="echo 'FLUSHALL' | nc localhost 6379"
alias flushdns="dscacheutil -flushcache; sudo killall -HUP mDNSResponder"
alias stripsvn="find . -type d -name '.svn' -exec rm -rf {} \;"
alias stripmac="find . -type d -name '__MACOSX' -exec rm -rf {} \;"
alias stripds="find . -type f -name '.DS_Store' -exec rm -rf {} \;"
alias strippyc="find . -type f -name '*.pyc' -exec rm -rf {} \;"

alias fixopenwith='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user; killall Finder'

alias start_apache="sudo apachectl start"
alias stop_apache="sudo apachectl stop"
alias restart_apache="sudo apachectl restart"

alias start_mysql="mysql.server start"
alias stop_mysql="mysql.server stop"
alias restart_mysql="mysql.server restart"

alias start_nginx="sudo nginx"
alias stop_nginx="sudo kill \$(cat /usr/local/var/run/nginx.pid)"
alias restart_nginx="stop_nginx; start_nginx"

alias start_redis="redis-server /usr/local/etc/redis.conf"

alias update_project="git pull; pip install -r requirements.txt; python manage.py syncdb; python manage.py migrate"

edithosts () {
    if [ -e "/etc/hosts.ac" ] ; then
        echo "Removing Cisco AnyConnect hosts file"
        sudo rm /etc/hosts.ac
    fi
    # subl /etc/apache2/extra/httpd-vhosts.conf /usr/local/etc/nginx/nginx.conf /etc/hosts
    subl /etc/apache2/extra/httpd-vhosts.conf /etc/hosts
}

# alias cddev="cd $DEV"
dev () {
    typeset dir="$1"
    cd $DEV
    if [ ! "$dir" = "" ] ; then
        cd $dir

        # activate the virtualenv
        if [ -d "$WORKON_HOME/$dir" ] ; then
            workon "$dir"
        fi
    fi
}
#
# Set up tab completion.  (Adapted from Arthur Koziel's version at
# http://arthurkoziel.com/2008/10/11/virtualenvwrapper-bash-completion/)
#
cddev_show_options () {
    # NOTE: DO NOT use ls here because colorized versions spew control characters
    #       into the output list.
    # echo seems a little faster than find, even with -depth 3.
    # (for f in `ls -l $DEV| egrep '^d' | awk '{ print $9 }'`; do echo $f; done) 2>/dev/null | \sed 's|^\./||' | \sed 's|/bin/activate||' | \sort | (unset GREP_OPTIONS; \egrep -v '^\*$')
    (cd "$DEV"; for f in */; do echo $f; done) 2>/dev/null | \sed 's|^\./||' | \sed 's|/||' | \sort | (unset GREP_OPTIONS; \egrep -v '^\*$')
}
if [ -n "$BASH" ] ; then
    _cddev_dirs () {
        local cur="${COMP_WORDS[COMP_CWORD]}"
        COMPREPLY=( $(compgen -W "`cddev_show_options`" -- ${cur}) )
    }
    complete -o default -o nospace -F _cddev_dirs dev
elif [ -n "$ZSH_VERSION" ] ; then
    compctl -g "`cddev_show_options`" dev
fi

# Virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
source virtualenvwrapper.sh

export PATH=/Users/robin/bin/Sencha/Cmd/4.0.4.84:$PATH

export SENCHA_CMD_3_0_0="/Users/robin/bin/Sencha/Cmd/4.0.4.84"
