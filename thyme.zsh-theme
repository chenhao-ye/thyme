# Based on bira, gnzh, bullet-train theme
# bira: https://github.com/ohmyzsh/ohmyzsh/blob/master/themes/bira.zsh-theme
# gnzh: https://github.com/ohmyzsh/ohmyzsh/blob/master/themes/gnzh.zsh-theme
# bullet-train: https://github.com/caiogondim/bullet-train.zsh/blob/master/bullet-train.zsh-theme

setopt prompt_subst

() {

local _USER _PROMPT _HOST

# set THYME_USER_AS if you want to show a name different from the user name
if [[ -z "$THYME_USER_AS" ]]; then
	_USER="%n"
else
	_USER="$THYME_USER_AS"
fi

if [[ "$THYME_NO_HOST" == "true" ]]; then
	_HOST=""
else
	_HOST="@%m"
fi

if [[ $UID -ne 0 ]]; then # normal user
	_USER="%F{green}${_USER}%f"
	_PROMPT="%f➤%f"
else # root
	_USER="%F{red}${_USER}%f"
	_PROMPT="%F{red}➤f"
fi

# Check if we are on SSH or not
if [[ -n "$SSH_CLIENT"  ||  -n "$SSH2_CLIENT" ]]; then
	_HOST="%F{cyan}${_HOST}%f" # SSH
else
	_HOST="%F{green}${_HOST}%f" # no SSH
fi

local _CWD=" %B%F{blue}%~%f%b"
local _NEWLINE='
'
local _GIT=''

if ! [[ "$THYME_NO_GIT" == "true" ]]; then
	ZSH_THEME_GIT_PROMPT_PREFIX=" %F{yellow}["
	ZSH_THEME_GIT_PROMPT_SUFFIX="]%f"

	# from bullet-train:
	ZSH_THEME_GIT_PROMPT_DIRTY="✘"
	ZSH_THEME_GIT_PROMPT_CLEAN="✔"
	ZSH_THEME_GIT_PROMPT_ADDED="✚"
	ZSH_THEME_GIT_PROMPT_MODIFIED="✹"
	ZSH_THEME_GIT_PROMPT_DELETED="✖"
	ZSH_THEME_GIT_PROMPT_UNTRACKED="✭"
	ZSH_THEME_GIT_PROMPT_RENAMED="➜"
	ZSH_THEME_GIT_PROMPT_UNMERGED="═"
	ZSH_THEME_GIT_PROMPT_AHEAD="⬆"
	ZSH_THEME_GIT_PROMPT_BEHIND="⬇"
	ZSH_THEME_GIT_PROMPT_DIVERGED="⬍"

	function THYME_git {
		local _GIT_CURR=$(git_current_branch)
		if [[ -z $_GIT_CURR ]] ; then return ; fi
		local _GIT_DIRTY=":$(parse_git_dirty)"
		local _GIT_STAT=''
		if ! [[ "$THYME_NO_GIT_STAT" == "true" ]] ; then
			_GIT_STAT=$(git_prompt_status)
			if [[ -n $_GIT_STAT ]] ; then
				_GIT_STAT=":$_GIT_STAT"
			fi
		fi

		echo -n $ZSH_THEME_GIT_PROMPT_PREFIX$_GIT_CURR$_GIT_DIRTY$_GIT_STAT$ZSH_THEME_GIT_PROMPT_SUFFIX
	}

	_GIT='$(THYME_git)'
fi

local _JOB='%(1j.%F{cyan}[⚙]%f.)'
local _RET='%(?..%F{red}%?↵%f )'
local _CLOCK='%F{green}[%D{%H:%M:%S}]%f'
local _TIMER=''

if ! [[ "$THYME_NO_TIMER" == "true" ]] ; then
	_TIMER='%F{yellow}$(THYME_timer)%f'
	# Based on http://stackoverflow.com/a/32164707/3859566
	function THYME_timer {
		if [[ -z "$THYME_TIMESTAMP" ]] ; then return ; fi

		local T=$(( $( date +%s ) - ${THYME_TIMESTAMP} ))
		local D=$((T/60/60/24))
		local H=$((T/60/60%24))
		local M=$((T/60%60))
		local S=$((T%60))
		echo -n '['
		if [[ $D > 0 ]] ; then printf '%dd' $D; fi
		if [[ $H > 0 ]] ; then printf '%dh' $H; fi
		if [[ $M > 0 ]] ; then printf '%dm' $M; fi
		printf '%ds]' $S
	}

	preexec() {
		THYME_TIMESTAMP=$(date +%s)
	}
fi

PROMPT="${_NEWLINE}╭─[${_USER}${_HOST}]${_JOB}${_CWD}${_GIT}${_NEWLINE}╰─$_PROMPT "
RPROMPT="${_RET}${_TIMER}${_CLOCK}"

function THYME_update {
	curl https://raw.githubusercontent.com/chenhao-ye/thyme/main/thyme.zsh-theme > $ZSH_CUSTOM/themes/
}

}
