gitrpmm () { gitr.sh -f -p -v push mirror master | egrep -v "fatal:|make sure|repository exists|^$" ; }
gitrpmms () { gitr.sh -f -v push mirror master | egrep -v "fatal:|make sure|repository exists|^$" ; }
pushall () { rpus; gitrpmm ; rss ; }
pushalls () { rpuss; gitrpmms ; rsss ; }
syncall () { rpul ; rpus ; gitrpmm ; rss ; }
syncalls () { rpuls ; rpuss ; gitrpmms ; rsss ; }
