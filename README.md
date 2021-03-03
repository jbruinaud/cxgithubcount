# cxgithubcount
bash script to count LOC for a given list of github clone URLs


Runs cloc on a list of repos provided in a file

Pre-requisites: git, cloc-1.88.pl (https://github.com/AlDanial/cloc/releases/download/1.88/cloc-1.88.pl)

Repo list format: one git clone URL per line, e.g:
<pre>
https://github.com/MY_ORG/REPO1.git
https://github.com/MY_ORG/REPO2.git 
https://github.com/MY_ORG/REPO3.git
</pre>

Tested on Amazon EC2 linux 4.14.121-109.96.amzn2.x86_64

# Usage

First, update cxgithubcount.sh with your GitHub org and your GitHub token, then create your repo_list. Make sure that you have git installed and cloc-1.88.pl is present in the same directory. 

<pre>
$ chmod +x ./cloc-1.88.pl
$ chmod +x ./cxgithubcount.sh
$ ./cxgithubcount.sh
</pre>

# Output example

<pre>
$ cat results.csv
Repo,Languages,Count
DSVW,Python,93
bodgeit,JSP / Java / JavaScript,1983
</pre>
