[git](#git)

[gitlab](#gitlab)

### GIT
[beginning](http://www.linux.com/learn/tutorials/796387-beginning-git-and-github-for-linux-users/)

Frequently Used Commands
```bash
git add <newfile>
git commit -m <message>
git push
```

Global setup
```bash
git config --list
git config --global user.name "Luigi Antelmi"
git config --global user.email "luigi.antelmi@gmail.com"
git config --global push.default simple
git config --global http.proxy http://192.168.100.62:8080
git config --global https.proxy https://192.168.100.62:8080
git config --global url."https://".insteadOf git://
git config --global color.ui "auto"
git config --global core.editor "vim"
git config --global credential.helper cache
git config --global credential.helper 'cache --timeout=3600'
git config --global http.postBuffer 524288000 # for big files
```

Create a branch
```bash
# Before creating a new branch, pull the changes from upstream. Your master needs to be up to date.
git pull
# Create the branch on your local machine and switch in this branch
git checkout -b [name_of_your_new_branch]
# Push the branch on remote
git push origin [name_of_your_new_branch]
```

Rename a branch
```bash
git checkout $OLD_BRANCH_NAME
git branch -m $NEW_BRANCH_NAME
git push origin :$OLD_BRANCH_NAME $NEW_BRANCH_NAME
git push --set-upstream origin $NEW_BRANCH_NAME
```

Delete branch locally
```bash
git branch -d localBranchName
# delete branch remotely
git push origin --delete remoteBranchName
```

Submodules

Read carefully: https://git-scm.com/book/en/v2/Git-Tools-Submodules

- Add a submodule to your primary repository:
```bash
git submodule add [-b <branch-of-secondary-repo>] <secondary-repo.git> [<local-path>]
```
- To clone the primary repository with all the submodules:
```bash
git clone --recursive https://github.com/chaconinc/MainProject

```
Push to 2 remotes [[source]](https://gist.github.com/rvl/c3f156e117e22a25f242)
```bash
# Assume an "origin" remote already exists (it's the one you cloned from)
# 1. Create an empty repository on github
# 2. add it as a remote named "ggbioing" (the user of the account so you know to you will push
git remote add ggbioing git@github.com:ggbioing/our-secret-stash.git
# 3. Set up the push urls
git remote set-url --add --push origin https://gitlab.inria.fr/asclepios/our-secret-stash.git
git remote set-url --add --push origin git@github.com:ggbioing/our-secret-stash.git
# 4. check it out
git remote show origin
# to undo: remove origin push to new remote + remove remote
git remote set-url --delete origin git@github.com:ggbioing/our-secret-stash.git
git remote remove ggbioing
```

Tagging
```bash
git tag <tag_name> <commit_sha>
# With message
git tag -a <tag_name> <commit_sha> -m "message"
# Push 
git push --tags
# Check tags
# git tag -n
```

Miscellanea
```bash
unset SSH_ASKPASS # add to .bashrc

# Create a repo on github
# Connect github with local repo
git init
git remote add origin https://github.com/username/myproject.git

## Create a repo on bitbucket and connect local repo
#  Set up your local directory
mkdir /path/to/your/project
cd /path/to/your/project
git init
git remote add origin https://ggbioing@bitbucket.org/ggbioing/rete-ad.git
#  Create your first file, commit, and push
echo "Luigi Antelmi" >> contributors.txt
git add contributors.txt
git commit -m 'Initial commit with contributors'
git push -u origin master

# change remote url
git remote set-url origin git@gitlab.inria.fr:epione_ML/mcvae.git
```

### GitLab
```bash
# Command line instructions
# Git global setup
git config user.name "ANTELMI Luigi"
git config user.email "luigi.antelmi@inria.fr"

# Create a new repository
git clone https://lantelmi@gitlab.inria.fr/asclepios_ML/tutorials.git
cd tutorials
touch README.md
git add README.md
git commit -m "add README"
git push -u origin master

# Existing folder
cd existing_folder
git init
git remote add origin https://lantelmi@gitlab.inria.fr/asclepios_ML/tutorials.git
git add .
git commit
git push -u origin master

# Existing Git repository
cd existing_repo
git remote add origin https://lantelmi@gitlab.inria.fr/asclepios_ML/tutorials.git
git push -u origin --all
git push -u origin --tags
```
