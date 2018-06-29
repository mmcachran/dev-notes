# Git

### Convert a submodule to regular files
``` bash
git rm --cached $submodule # Delete references to submodule HEAD
rm -rf $submodule/.git* # Remove submodule .git references to prevent confusion from main repo 
git add $submodule # Add the leftover files from the submodule to the main repo 
vim .gitmodules # Remove reference to the submodule 
git add .gitmodules  
git commit -m "Converting submodule $submodule to regular files" # Commit the new regular files!

# https://ben.lobaugh.net/blog/202883/bash-script-to-automatically-convert-git-submodules-to-regular-files
```

### Show lines of code committed to a repository for the day
``` bash
git log --since="6am" --author="mmcachran" --pretty=tformat: --numstat | awk '{ add += $1; subs += $2; loc += $1 - $2 } END { printf "added lines: %s, removed lines: %s, total lines: %s\n", add, subs, loc }' -
```

### Git stats for all branches
``` bash
git shortlog -s -n --all
```

### Log for function name/lines in a file:
``` bash
git log -L:<function>:<file>
git log -L150,+22:<file>
```

### Show all branches merged into a specific branch
``` bash
git branch -r --merged | grep origin | grep -v '>' | grep -v 'prod' | xargs -L1
```

### Show global git config
``` bash 
git config --global -l 
```

### Ignore case in global config
``` bash
git config --global core.ignorecase false
```