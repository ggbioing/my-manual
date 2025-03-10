[git](#git)

[gitlab](#gitlab)

# GIT


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
```.gitconfig
[user]
        name = MyName
        email = MyEmail
[init]
        defaultBranch = main
[push]
        default = simple
[core]
        editor = vim
        whitespace = blank-at-eol, blank-at-eof, space-before-tab
        autocrlf = true
        attributesfile = C:/Users/Luigi.Antelmi/.gitattributes
        excludesfile =
        symlinks = true
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
        tool = winmerge
[diff "pandoc"]
        textconv = pandoc --wrap=preserve --to=markdown
[diff "strings"]
        textconv = strings -a
        prompt = false
[diff "exif"]
        textconv = exiftool
[diff "sdf"]
        textconv = sdf2stdout.bat
        binary = true
[diff "xl"]
        command = excel_cmp --diff_format=unified
        binary = true
#[diff "exe"]
#       textconv = assemblyinfo.exe
#       binary = true
#[difftool "exe"]
#       prompt = false
#       cmd = assemblyinfodiff.sh $LOCAL $REMOTE
[difftool "p4merge"]
        path = "C:\\Program Files\\Perforce\\p4merge.exe"
[difftool "winmerge"]
        path = "C:\\Program Files (x86)\\WinMerge\\WinMergeU.exe"
[difftool "sdf"]
        prompt = false
        cmd = sdfdiff.sh $LOCAL $REMOTE
[difftool "pandoc"]
        prompt = false
        cmd = pandocdiff.sh $LOCAL $REMOTE
[merge]
        tool = p4merge
[mergetool "p4merge"]
        path = "C:\\Program Files\\Perforce\\p4merge.exe"
[mergetool "winmerge"]
        path = "C:\\Program Files (x86)\\WinMerge\\WinMergeU.exe"
[difftool "sourcetree"]
        cmd = "'' "
[mergetool "sourcetree"]
        cmd = "'' "
        trustExitCode = true
[alias]
        # see `git help log` for detailed help.
        #   %h: abbreviated commit hash
        #   %d: ref names, like the --decorate option of git-log(1)
        #   %cn: commiter name
        #   %ce: committer email
        #   %cr: committer date, relative
        #   %ci: committer date, ISO 8601-like format
        #   %an: author name
        #   %ae: author email
        #   %ar: author date, relative
        #   %ai: author date, ISO 8601-like format
        #   %s: subject
        dc = diff --check
        history = log --graph --full-history --pretty=format:'%C(red)%h%Creset -%C(bold yellow)%d%C(bold cyan) %s %Creset %C(bold green)[%ch (%cr)]%Creset %C(white)[%cn]%Creset' --abbrev-commit
        historyverbose = log --graph --full-history --pretty=format:'%C(red)%h%Creset -%C(bold yellow)%d%C(bold cyan) %s %Creset %C(bold green)[A: %ah (%ar) - C: %ch (%cr)]%Creset %C(white)[A: %an - C: %cn]%Creset' --abbrev-commit
        historyheads = log --graph --all --decorate --simplify-by-decoration
        ha = history --all
        hav = historyverbose --all
        hh = historyheads
        wdiff = diff --word-diff=color --unified=1
        sdfdiff = difftool -t sdf
        ss = submodule status
        su = submodule update
[status]
        submoduleSummary = true
[filter "lfs"]
        smudge = git-lfs smudge --skip -- %f
        process = git-lfs filter-process --skip
        required = true
        clean = git-lfs clean -- %f
[lfs]
        contenttype = 0
[safe]
        directory = *
```

Attribute file `.gitattributes`:
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
git submodule add [--name name_in_gitmodules_file] [-b <branch-of-secondary-repo>] <remote-[absolute|relative]-path-to-secondary-repo.git> [<local-path>]
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


## LFS: Handling Large Files

DO NOT USE LFS! It is a solution that won’t work to a problem that doesn’t exist.

Instead add your file extension to `.gitattributes`:
```.gitattributes
*.bin -diff -delta
```


[source](https://www.git-tower.com/learn/git/ebook/en/command-line/advanced-topics/git-lfs),
[permalink](http://web.archive.org/web/20231017084743/https://www.git-tower.com/learn/git/ebook/en/command-line/advanced-topics/git-lfs)
### Hints
**When to Track**

You can accuse Git of many things - but definitely not of forgetfulness:
things that you've committed to the repository are there to stay.
It's very hard to get things out of a project's commit history (and that's a good thing).

In the end, this means one thing:
**make sure to set your LFS tracking patterns as early as possible - ideally right after initializing a new repository**.
To change a file that was committed the usual way into an LFS-managed object, you would have to manipulate and rewrite your project's history.
And you certainly want to avoid this.

**Cloning a Git LFS Repository**

To clone an existing LFS repository from a remote server, you can simply use the standard "git clone" command that you already know.
After downloading the repository, Git will check out the default branch and then hand over to LFS:
if there are any LFS-managed files in the current revision, they'll be automatically downloaded for you.

That's all well and good - but if you want to speed up the cloning process, you can also use the "git lfs clone" command instead.
The main difference is that, after the initial checkout was performed, the requested LFS items are downloaded in parallel (instead of one after the other).
This could be a nice time saver for repositories with lots of LFS-tracked files.

### Useful commands
Run the "install" command once to complete the initialization:

```bash
git lfs install
git config --add lfs.url "file:////NAS/path_to.git"
```

Tracking steps
```bash
git lfs track "*.png"  # Don't forget the quotes around the file pattern
git add .gitattributes  # It should contain: *.png filter=lfs diff=lfs merge=lfs -text
git add *.png
git commit -m "Add *.png file"
```

Which files are we tracking?
```bash
git lfs ls-files
```

In order to properly pull the files managed by LFS you need to:

```bash
git config --add lfs.url "file:////FileServer/SharedFolder/path_to_LFS.git"
git lfs pull
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
