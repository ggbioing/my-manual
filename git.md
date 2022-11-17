[git](#git)

[gitlab](#gitlab)

# GIT

[beginning](http://www.linux.com/learn/tutorials/796387-beginning-git-and-github-for-linux-users/)

Frequently Used Commands
```bash
git add <newfile>
git commit -m <message>
git push
```


## Configuration

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

Config file `.gitconfig` on a Windows Based Machine:
```
[filter "lfs"]
        clean = git-lfs clean -- %f
        smudge = git-lfs smudge -- %f
        process = git-lfs filter-process
        required = true
[user]
        name = Luigi Antelmi
        email = luigi.antelmi@gmail.com
[init]
        defaultBranch = main
[push]
        default = simple
[core]
        editor = vim
        whitespace = blank-at-eol, blank-at-eof, space-before-tab
        autocrlf = true
        attributesfile = C:/Users/Luigi.Antelmi/.gitattributes
[credential]
        helper = cache --timeout=3600
[http]
        postBuffer = 524288000
[gui]
        fontui = -family Tahoma -size 8 -weight normal -slant roman -underline 0 -overstrike 0
        fontdiff = -family Consolas -size 8 -weight normal -slant roman -underline 0 -overstrike 0
[color]
        ui = auto
        branch = auto
        diff = auto
        status = auto
[diff]
        tool = p4merge
[diff "pandoc"]
        textconv = pandoc --wrap=preserve --to=markdown
[diff "strings"]
        textconv = strings -a
        prompt = false
[diff "exif"]
        textconv = exiftool
[difftool "p4merge"]
        path = "C:\\Program Files\\Perforce\\p4merge.exe"
[merge]
        tool = p4merge
[mergetool "p4merge"]
        path = "C:\\Program Files\\Perforce\\p4merge.exe"
[alias]
        dc = diff --check
        history = log --graph --full-history --pretty=format:'%C(red)%h%Creset -%C(bold yellow)%d%C(bold cyan) %s %Creset %C(bold green)(%cr)%Creset - %C(white) %cn %Creset' --abbrev-commit --date=relative
        historyheads = log --graph --all --decorate --simplify-by-decoration
        ha = history --all
        hh = historyheads
        wdiff = diff --word-diff=color --unified=1
[status]
        submoduleSummary = true
```

Atribute file `.gitattributes`:
```
*.png diff=exif
*.jpg diff=exif
*.jpeg diff=exif
*.doc diff=pandoc
*.docx diff=pandoc
```


## Branching

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


## Submodules

Read carefully:
- https://git-scm.com/book/en/v2/Git-Tools-Submodules
- https://medium.com/@porteneuve/mastering-git-submodules-34c65e940407 (https://archive.ph/IrtMt)

Add configuration option for a verbose git output when dealing with submodules
```bash
git config --global status.submoduleSummary true
```

Add a submodule to your primary repository:
```bash
git submodule add [-b <branch-of-secondary-repo>] <remote-[absolute|relative]-path-to-secondary-repo.git> [<local-path>]
```

To clone the primary repository with all the submodules:
```bash
git clone --recursive <remote-repo-with-submodules.git>
```

**Going to a specific point in time**
```bash
# In the super-repository run:
git checkout <commit|tag>
git submodule update
```

**Pull latest changes in sub-modules**

If the submodules are in *detached* state,
checkout the sub-modules branches you want to update (example with `Stable` and `main` branches):
```bash
# In the super-repository run:
git submodule foreach 'git checkout Stable || git checkout main || :'
```

Update the sub-modules
```bash
# In the super-repository run:
git submodule foreach 'git pull'
```

Run `git status` in the super-repo to check if it is aligned with the sub-modules.


## Pushing

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


## Tagging

```bash
git tag <tag_name> <commit_sha>
# With message
git tag -a <tag_name> <commit_sha> -m "message"
# Push to origin
git push --tags
# Check tags
git tag -n
# remove local tag
git tag -d <tag_name>
# remove remote tag
git push --delete origin <tag-name>
```


## Miscellanea

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

# GitLab

to be filled
