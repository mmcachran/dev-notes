#!/usr/bin/env bash

function homebrew_clear_cache() {
  brew cleanup --prune=all
}
