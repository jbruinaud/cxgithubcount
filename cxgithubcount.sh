#!/bin/bash

##
## Runs cloc on a list of repos provided in a file
##
## Pre-requisites: git, cloc-1.88.pl (https://github.com/AlDanial/cloc/releases/download/1.88/cloc-1.88.pl)
##
## Tested on Amazon EC2 linux 4.14.121-109.96.amzn2.x86_64
##
## Repo list format: one git clone URL per line, e.g https://github.com/jbruinaud-cxflowgithub/DSVW.git
##

## variables
# github token
GH_TOKEN=#####your_token#####
# github org
GH_ORG=#####your_org#####
# github repo list file
GH_LF=./repo_list
# results file
RS_FILE=./results.csv

## initiating results file
echo "Repo,Languages,Count" > ${RS_FILE}

## repo list loop
for I in $(cat ./repo_list)
do
  echo "processing $I"
  ## cloning git repo and formating the URL to add authentication, e.g: https://orgname:pat@github.com/myorg/myrepo.git
  git clone $(echo $I | sed "s/\/\//\/\/${GH_ORG}:${GH_TOKEN}@/")
  ## calculating dir name
  CLONE_DIR=$(echo ${I##*/} | cut -d "." -f1)
  ## cloc execution (todo: check that cloc-1.88.pl is present)
  ./cloc-1.88.pl $CLONE_DIR | egrep "Apex Class |Apex Trigger |ASP |ASP.NET |C |C# |C++ |C/C++ Header |COBOL |Go |Groovy |HTML |Java |JavaScript |JSP |JSX |Kotlin |Objective-C |Perl |PHP |Python |Ruby |Scala |SQL |Swift |Visual Basic|Vuejs Component" | tr -s " " > ${CLONE_DIR}/cloc.out
  ## getting languages list from cloc output
  LANG_LIST=""
  CL=0
  for L in $(cat ${CLONE_DIR}/cloc.out | cut -d " " -f1)
  do
    if [ "$CL" -gt "0" ]
	then
      LANG_LIST="${LANG_LIST} / ${L}"
	else
	  LANG_LIST=${L}
	  CL=$((CL+1))
    fi
  done
  ## getting sum of LOCs from cloc output
  CNT=0
  for J in $(cat ${CLONE_DIR}/cloc.out | cut -d " " -f5)
  do
    CNT=$((CNT+J))
  done
  ## appending data to the results file
  echo ${CLONE_DIR},${LANG_LIST},${CNT} >> ${RS_FILE}
  ## removing clone dir
  rm -rf ${CLONE_DIR}  
done
## displaying the results
echo "--------------"
cat ${RS_FILE}
echo "--------------"
