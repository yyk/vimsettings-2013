# put this to prompt if you want host name
# %{$fg[green]%}%n@%m: %{$reset_color%}
PROMPT=$'%{$fg[yellow]%}%/%{$reset_color%}\ @%m
%'
#\u25B6 %'
RPS1='$(git_prompt_info)'

PROMPT2="%{$fg_blod[black]%}%_> %{$reset_color%}"
