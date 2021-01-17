# Load functions
autoload -Uz compinit promptinit up-line-or-beginning-search down-line-or-beginning-search

# Prompt
promptinit
PROMPT='%F{blue}%~ %#%f '

# Tab completion
compinit
zstyle ':completion:*' menu select

# History
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Set proper keybinds
typeset -g -A key
key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"      beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"       end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"    overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}" backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"    delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"        up-line-or-beginning-search
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"      down-line-or-beginning-search
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"      backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"     forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"    beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"  end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}" reverse-menu-complete
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

# Aliases
alias ls='ls --color=auto --group-directories-first'
alias startx='startx ~/.xinitrc &> /dev/null'
alias mk='sudo make install'
alias chbg='feh --bg-scale'
alias ten='trans de:en -b'
alias tde='trans en:de -b'
alias mkv6='/home/rensenware/.local/share/VVVVVV/mkv6.sh'
alias sortmirrors="sudo reflector --latest 30 --protocol http --protocol https --sort rate --country 'United States' --save /etc/pacman.d/mirrorlist --verbose"
alias dragon="dragon-drag-and-drop"

# TTY color scheme
if [ "$TERM" = "linux" ]; then
    echo -en "\e]P0282a36" #black
    echo -en "\e]P84d4d4d" #darkgrey
    echo -en "\e]P1ff5555" #darkred
    echo -en "\e]P9ff6e67" #red
    echo -en "\e]P250fa7b" #darkgreen
    echo -en "\e]PA5af78e" #green
    echo -en "\e]P3f1fa8c" #brown
    echo -en "\e]PBf4f99d" #yellow
    echo -en "\e]P4bd93f9" #darkblue
    echo -en "\e]PCcaa9fa" #blue
    echo -en "\e]P5ff79c6" #darkmagenta
    echo -en "\e]PDff92d0" #magenta
    echo -en "\e]P68be9fd" #darkcyan
    echo -en "\e]PE9aedfe" #cyan
    echo -en "\e]P7dedede" #lightgrey
    echo -en "\e]PFf8f8f2" #white
    clear #for background artifacting
fi
