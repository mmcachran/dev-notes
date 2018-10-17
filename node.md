### Example Husky NPM package.json configuration.
``` json
{
  "husky": {
    "hooks": {
      "pre-commit": "git diff --diff-filter=ACM --cached --name-only | grep '.php' | xargs -I % php -l %"
    }
  },
  "dependencies": {},
  "devDependencies": {
    "husky": "^1.1.2"
  }
```
