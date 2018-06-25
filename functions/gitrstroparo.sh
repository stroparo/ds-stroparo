gitrpmm () { gitr.sh -f -p -v push mirror master | egrep -v "fatal:|make sure|repository exists|^$" ; }
gitrpmms () { gitr.sh -f -v push mirror master | egrep -v "fatal:|make sure|repository exists|^$" ; }
lps () { rpul ; rpus ; gitrpmm ; rss ; }
lpss () { rpuls ; rpuss ; gitrpmms ; rsss ; }
rpa () { rpus; gitrpmm ; rss ; }
rpas () { rpus; gitrpmms ; rsss ; }
