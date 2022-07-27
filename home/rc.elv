# prompt
# set edit:prompt = { tilde-abbr $pwd; put '❱ ' }
# set edit:rprompt = (constantly (styled (whoami)*(hostname) inverse))
use github.com/zzamboni/elvish-themes/chain
chain:init

# better cd
eval (zoxide init elvish | slurp)

# math
use math

# bangs
use github.com/zzamboni/elvish-modules/bang-bang

# alias
fn ls {|@a| e:exa $@a }
fn lsl {|@a| e:exa --tree --level=2 --header --git $@a }
# fn cd {|@a| e:z $@a }
