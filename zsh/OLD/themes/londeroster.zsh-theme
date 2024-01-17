# my awesome Londeroster Theme - which is inspired by oh-my-zsh's Agnoster
#
# define some variables
seperator=$'\ue0b0'
bgpath='#0d73cc'
bghost='#074642'
fgpath='#000000'
# define the prompt
PROMPT='%K{'$bghost'} %n@%m %k%K{'$bgpath'}%F{'$bghost'}'$seperator'%f%k%K{'$bgpath'} %F{'$fgpath'}%~%f %k%F{'$bgpath'}'$seperator'%f '
#
