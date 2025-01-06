# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
#lf
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/debuser/.zshrc'
zstyle ':completion:*' menu select
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' file-list all
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

zmodload zsh/complist
autoload -Uz compinit
compinit
_comp_options+=(globdots)
# End of lines added by compinstall
bindkey ";5C" forward-word
bindkey ";5D" backward-word

source ~/powerlevel10k/powerlevel10k.zsh-theme
#source /usr/share/autojump/autojump.zsh
# enable color support of ls and also add handy aliases    
if [ -x /usr/bin/dircolors ]; then    
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"    
    alias ls='ls --color=auto'    
    #alias dir='dir --color=auto'    
    #alias vdir='vdir --color=auto'    
    
    alias grep='grep --color=auto'    
    alias fgrep='fgrep --color=auto'    
    alias egrep='egrep --color=auto'    
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#Zsh Auto Suggestions
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#Aliases
alias ll='ls -alF'    
alias la='ls -A'    
alias l='ls -CF'    
alias ds='~/Scripts/Bash/./DiskSpaceUsage.sh'
alias du='du -h -d 1'
#Nginx Test and Reload Alias Commands
alias nt='sudo nginx -t'
alias nr='sudo systemctl reload nginx.service' 
 
#PHP Service Reload Alias
alias phpr='sudo systemctl reload php8.2-fpm.service'

#Update Commands
alias sup='/home/debuser/./checksystemupdates'
alias up='sudo apt update; sudo apt upgrade'

#Trash CLI Alias (prevention of rm usage)
alias tp='sudo trash-put'
alias tl='sudo trash-list'
alias tr='sudo trash-restore'
alias te='sudo trash-empty'
alias rm='echo try using trash-cli commands instead! example: trash-put'
alias 'rm -rf'='echo try using trash-cli commands instead!'

# IDE Aliases
alias 'idea'="/home/debuser/IDEs/intellij-idea-community-edition/bin/idea"
alias 'charm'="/home/debuser/IDEs/pycharm-community/bin/pycharm"

# History Formatting
export HISTTIMEFORMAT="%d/%m/%y %T "

# Additional Path Values
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/home/debuser/.local/bin
export PYTHONBREAKPOINT="pudb.set_trace"

#BatCat
export BAT_THEME="Visual Studio Dark+"


#Java Location and Gradle   
export JAVA_HOME    
export JRE_HOME    
export PATH    
    
# lf icons
export LF_ICONS="\
tw=:\
st=:\
ow=:\
dt=:\
di=:\
fi=:\
ln=:\
or=:\
ex=:\
*.c=:\
*.cc=:\
*.clj=:\
*.coffee=:\
*.cpp=:\
*.css=:\
*.d=:\
*.dart=:\
*.erl=:\
*.exs=:\
*.fs=:\
*.go=:\
*.h=:\
*.hh=:\
*.hpp=:\
*.hs=:\
*.html=:\
*.java=:\
*.jl=:\
*.js=:\
*.json=:\
*.lua=:\
*.md=:\
*.php=:\
*.pl=:\
*.pro=:\
*.py=:\
*.rb=:\
*.rs=:\
*.scala=:\
*.ts=:\
*.vim=:\
*.cmd=:\
*.ps1=:\
*.sh=:\
*.bash=:\
*.zsh=:\
*.fish=:\
*.tar=:\
*.tgz=:\
*.arc=:\
*.arj=:\
*.taz=:\
*.lha=:\
*.lz4=:\
*.lzh=:\
*.lzma=:\
*.tlz=:\
*.txz=:\
*.tzo=:\
*.t7z=:\
*.zip=:\
*.z=:\
*.dz=:\
*.gz=:\
*.lrz=:\
*.lz=:\
*.lzo=:\
*.xz=:\
*.zst=:\
*.tzst=:\
*.bz2=:\
*.bz=:\
*.tbz=:\
*.tbz2=:\
*.tz=:\
*.deb=:\
*.rpm=:\
*.jar=:\
*.war=:\
*.ear=:\
*.sar=:\
*.rar=:\
*.alz=:\
*.ace=:\
*.zoo=:\
*.cpio=:\
*.7z=:\
*.rz=:\
*.cab=:\
*.wim=:\
*.swm=:\
*.dwm=:\
*.esd=:\
*.jpg=:\
*.jpeg=:\
*.mjpg=:\
*.mjpeg=:\
*.gif=:\
*.bmp=:\
*.pbm=:\
*.pgm=:\
*.ppm=:\
*.tga=:\
*.xbm=:\
*.xpm=:\
*.tif=:\
*.tiff=:\
*.png=:\
*.pp=:\
*.svg=:\
*.svgz=:\
*.mng=:\
*.pcx=:\
*.mov=:\
*.mpg=:\
*.mpeg=:\
*.m2v=:\
*.mkv=:\
*.webm=:\
*.ogm=:\
*.mp4=:\
*.m4v=:\
*.mp4v=:\
*.vob=:\
*.qt=:\
*.nuv=:\
*.wmv=:\
*.asf=:\
*.rm=:\
*.rmvb=:\
*.flc=:\
*.avi=:\
*.fli=:\
*.flv=:\
*.gl=:\
*.dl=:\
*.xcf=:\
*.xwd=:\
*.yuv=:\
*.cgm=:\
*.emf=:\
*.ogv=:\
*.ogx=:\
*.aac=:\
*.au=:\
*.flac=:\
*.m4a=:\
*.mid=:\
*.midi=:\
*.mka=:\
*.mp3=:\
*.mpc=:\
*.ogg=:\
*.ra=:\
*.wav=:\
*.oga=:\
*.opus=:\
*.spx=:\
*.xspf=:\
*.pdf=:\
*.nix=:\
"
export LC_ALL=en_US.UTF-8
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH=$PATH:/.vim/pack/plugins/start/fzf/bin
source ~/powerlevel10k/powerlevel10k.zsh-theme
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform
#export PATH=$PATH:/home/debuser/.dotnet
