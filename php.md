### Search for errors in PHP files

```
find . -type f -iname "*.php" -not -path '*vendor*'  -exec php -l {}  \;
```
