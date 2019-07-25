### Basic Config
```version: 2
jobs:
  build:
    docker:
      # Pick a base image which matches the version of Node you need for
      # building from https://hub.docker.com/r/circleci/node/tags/
      #
      # Note: If using a different container, make sure it contains at least
      # git 2.6.0. (Use -stretch for circleci/node containers.)
      - image: circleci/php:7.1.22-cli-stretch-node-browsers-legacy

    branches:
      # Don't build from a branch with the `-built` suffix, to
      # prevent endless loops of deploy scripts.
      # REQUIRED: If you're amended an existing config, the below are two
      # of the required lines you must add
      ignore:
        - /^.*-built$/

      only:
        - 'master'
        - 'preprod'
        - 'develop'

    steps:
      - add_ssh_keys:
          fingerprints:
            - <finger print>

      - checkout
       
      - run:
          name: "Setup custom environment variables"
          command: |
            if [ "${CIRCLE_BRANCH}" = "develop" ]; then
              echo 'export NODE_ENV="development"' >> $BASH_ENV
            fi

      - run:
          name: Syntax checker
          command: for file in $(find . -type f -iname "*.php" -not -path '*vendor*'); do php -l "$file"; done;

      # Project dependencies.
      - run:
          name: Build composer dependencies for the project
          command: composer install --no-dev && npm install

      # Main plugin dependencies.
      - restore_cache:
          name: Restore Client Plugin Yarn Package Cache
          keys:
            - client-plugin-yarn-packages-{{ checksum "plugins/client/yarn.lock" }}
            - client-plugin-yarn-packages

      - run:
          name: Build Client main plugin assets
          command: cd plugins/client && composer install --no-dev && yarn install && yarn build

      - run:
          name: Fix WP Content Connect Assets
          command: cd plugins/client/vendor/10up/wp-content-connect/ && rm .gitignore

      - run:
          name: Updating Client Theme version with commit hash
          command: sed -i "/CLIENT_PLUGIN_VERSION/s/'[^']*'/'${CIRCLE_SHA1}'/2" plugins/client/config.php

      - save_cache:
          name: Save Client Plugin Yarn Package Cache
          key: client-plugin-yarn-packages-{{ checksum "plugins/client/yarn.lock" }}
          paths:
            - ~/.cache/client-plugin-yarn

      # Theme.
      - restore_cache:
          name: Restore Client Theme Yarn Package Cache
          keys:
            -  client-plugin-npm-packages-{{ checksum "themes/client/package-lock.json" }}
            - client-plugin-npm-packages

      - run:
          name: Build Client Theme assets
          command: cd themes/clientt && composer install --no-dev && npm install && npm run build

      - save_cache:
          name: Save Client Theme Package Cache
          key: client-plugin-npm-packages-{{ checksum "themes/clkient/package-lock.json" }}
          paths:
            - ~/.cache/client-plugin-npm

      - run:
          name: Updating Client Theme version with commit hash
          command: sed -i "/CLIENT_VERSION/s/'[^']*'/'${CIRCLE_SHA1}'/2" themes/client/functions.php

      # Run the deploy:
      # REQUIRED: If you're amended an existing config, the below are two
      # of the required lines you must add
      # This will push the result to the {currentbranch}-built branch
      - deploy:
          name: Deploy -built branch to github
          command: bash <(curl -s "https://raw.githubusercontent.com/Automattic/vip-go-build/master/deploy.sh")```
