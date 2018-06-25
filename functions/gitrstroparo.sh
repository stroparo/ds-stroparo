alias lps='rpul ; rpus ; gitrpmm ; rss'
alias lpss='rpuls ; rpuss ; gitrpmms ; rsss'
alias rpa='rpus; gitrpmm'
alias rpas='rpus; gitrpmms'
gitrpmm () { gitr -f -p -v push mirror master | egrep -v "fatal:|make sure|repository exists|^$" ; }
gitrpmms () { gitr -f -v push mirror master | egrep -v "fatal:|make sure|repository exists|^$" ; }
