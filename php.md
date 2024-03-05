### Search for errors in PHP files

```
find . -type f -iname "*.php" -not -path '*vendor*'  -exec php -l {}  \;
```

## Finds all files ending with .php and checks them for syntax errors - only displays files with errors
```bash
 find . -iname '*.php' -exec php -l '{}' \; | grep '^No syntax errors' -v  | less
```
