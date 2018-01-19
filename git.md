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
```bash
git log --since="6am" --author="Matt McAchran" --pretty=tformat: --numstat | awk '{ add += $1; subs += $2; loc += $1 - $2 } END { printf "added lines: %s, removed lines: %s, total lines: %s\n", add, subs, loc }' -
```

### Git stats for all branches
``` bash
git shortlog -s -n --all
```