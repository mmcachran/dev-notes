# Command line

### Check syntax on all PHP files in a directory
``` bash
for f in *.php; do php -l "$f"; done;
```

``` bash
find . -type f -iname "*.php" -not -path '*vendor*'  -exec php -l {}  \;
```

### Exit during syntax checking if parse error is found (ex: CircleCI)
``` bash
for file in $(find . -type f -iname "*.php" -not -path '*vendor*'); do php -l "$file"; done;
```

### Find base64 encoded strings in php code
``` bash
find . -name "*.php" -exec grep "base64" '{}' \; -print &> b64-detections.txt
find . -name "*.php" -exec grep "eval" '{}' \; -print &> eval-detections.txt
```
### Run PHPCS on directory and save output
``` bash
phpcs --report=full --report-file=~/Desktop/test.txt <dir>/
```

### Filter a text document for only lines that contain “failed”
``` bash
grep -E '[^ ]+ +Failed .*' logfile.txt > test.txt
```

### Database monitoring
``` bash
mysqladmin processlist -h <host> -u <user> --password=<mysql password>
```

### Apache Benchmarking with 20 concurrent users
``` bash
time ab -c 20 -n 1000 <url>
```

### Show External URL
``` bash
ip addr show eth0 | grep inet | awk '{ print $2; }' | sed 's/\/.*$//'
```

### rsync with port and ignore existing files
``` bash
rsync -rvz -e 'ssh -p <port>' --progress --ignore-existing <local dir> <user>@<host>:<remote dir>.
```

### Screen
``` bash
screen -S <nameofscreen> # creates a new screen session
<control>+a # and then d to detach from that session
screen -r <nameofscreen> # to jump back in
screen -x <nameofscreen> # to kill it
```

### MySQL Constraints
``` bash 
echo "show variables like 'max_allowed_packet';" | mysql
echo "show variables like 'max_connections';" | mysql
```

### Recursively Remove Subversion from Directory
``` bash
find . -name '.svn' | xargs rm -r

OR

find . -name ".svn" -type d -exec rm -rf {} \;
```

### Switch shell to use PHP7 by default for the current session
```scl enable php70 /bin/bash```

### Swith to using PHP7 
```cd ~ && mkdir ~/bin && cd ~/bin && ln -s /usr/bin/php70 php```

Then add `export PATH=~/bin:$PATH` to your `~/.bash_profile`
