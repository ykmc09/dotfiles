fpath=(/usr/local/share/zsh-completions $fpath)

autoload -U compinit
compinit

autoload colors
colors

PROMPT="%F{blue}%~%k%f> "

alias ll='ls -laFG'
alias vim='mvim'
alias dot='cd ~/dev/dotfiles'
alias v='vim'
alias g='git'
alias showpath='echo $PATH'
alias diff='colordiff'

export JAVA_HOME="/Library/Java/Home"

export PATH="/usr/local/bin:/usr/local/sbin:$PATH:$JAVA_HOME/bin"

# Enter入力時用処理定義
function do_enter() {
    if [ -n "$BUFFER" ]; then
        zle accept-line
        return 0
    fi
    echo
    #ls
    ls_abbrev
    if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = 'true' ]; then
        echo
        echo -e "\e[0;33m--- git status ---\e[0m"
        git status -sb
    fi
    zle reset-prompt
    return 0
}
zle -N do_enter
bindkey '^m' do_enter

# ディレクトリ移動後にls実行
chpwd() {
    ls_abbrev
}

# ファイル数が多い場合は省略表示するls
ls_abbrev() {
    # -a : Do not ignore entries starting with ..
    # -C : Force multi-column output.
    # -F : Append indicator (one of */=>@|) to entries.
    local cmd_ls='ls'
    local -a opt_ls
    opt_ls=('-aCF' '--color=always')
    case "${OSTYPE}" in
        freebsd*|darwin*)
            if type gls > /dev/null 2>&1; then
                cmd_ls='gls'
            else
                # -G : Enable colorized output.
                opt_ls=('-aCFG')
            fi
            ;;
    esac

    local ls_result
    ls_result=$(CLICOLOR_FORCE=1 COLUMNS=$COLUMNS command $cmd_ls ${opt_ls[@]} | sed $'/^\e\[[0-9;]*m$/d')

    local ls_lines=$(echo "$ls_result" | wc -l | tr -d ' ')

    if [ $ls_lines -gt 10 ]; then
        echo "$ls_result" | head -n 5
        echo '...'
        echo "$ls_result" | tail -n 5
        echo "$(command ls -1 -A | wc -l | tr -d ' ') files exist"
    else
        echo "$ls_result"
    fi
}
