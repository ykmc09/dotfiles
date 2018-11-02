fpath=(/usr/local/share/zsh-completions $fpath)

autoload -U compinit
compinit

autoload -U colors
colors

PROMPT="%F{blue}%~%k%f> "

# 入力したコマンドが存在せず、かつディレクトリ名と一致するなら、ディレクトリに cd1
setopt auto_cd

# cd した先のディレクトリをディレクトリスタックに追加
setopt auto_pushd
setopt pushd_ignore_dups

alias ..='cd ..'
alias ll='ls -laFG --color=always'
alias showpath='echo $PATH'
alias diff='colordiff'
alias tailf='tail -f'

alias vim='mvim'
alias v='vim'

alias g='git'
alias gs='git status --short --branch'
alias gd='git diff'
alias gcm='git checkout master'
alias gpr='git pull --rebase upstream master'
alias hc='hub checkout'

export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

# rbenv
[[ -d ~/.rbenv  ]] && \
  export PATH="$HOME/.rbenv/bin:$PATH" && \
  eval "$(rbenv init -)"

# nodenv
[[ -d ~/.nodenv  ]] && \
  export PATH="$HOME/.nodenv/bin:$PATH" && \
  eval "$(nodenv init -)"

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
