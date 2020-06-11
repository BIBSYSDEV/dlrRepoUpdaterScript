#!/bin/bash

#reads and clones a list of DLR-repos to fix from file list.txt
#Then replaces a string in one file, commits, pushes and deletes repo locally.

while read REPO; do
    echo "using $REPO"
    git clone git@git.bibsys.no:dlr/$REPO.git
    cd $REPO
    #regexp replace. Remember to escape special chars
    OLD_STRING="https:\/\/artifactory.unit.no\/" 
    NEW_STRING="http:\/\/artifactory.bibsys.no\/"
    SED_STRING="s/$OLD_STRING/$NEW_STRING/g"
    echo $SED_STRING;
    sed -i -e $SED_STRING pom.xml
    #git commit -m "Updated pom.xml"
    #git push
    cd ..
    #rm -rf $REPO
done < dlr_repos.txt

echo "Script done"
