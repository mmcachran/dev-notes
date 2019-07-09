# WP CLI

### Update meta for a CPT.
```wp post list --post_type=<cpt-name> --field=ID | xargs -I % wp post meta update % _yoast_wpseo_meta-robots-nofollow 1```

### List active themes in multisite.
```wp site list --field=url | xargs -I % bash -c "echo 'URL:' % && wp theme list --url=% --status=active"```

### Delete a term across all sites in the network.
```wp site list --field=url | xargs -I % bash -c "echo 'URL:' % && wp term delete category <category-slug> --by=slug --url=%"```

### Update option across all sites in the network.
```wp site list --field=url | xargs -I % bash -c "echo 'URL:' % && wp option update test_key test_value --url=%"```

### Flush rewrite rules for all sites in the network.
```wp site list --field=url | xargs -I % bash -c "echo 'URL:' % && wp rewrite flush --url=%"```

### CLI command to force the save_post hook to run on all published posts:
```wp post list --field=ID --post_type=post --post_status=publish | xargs -I % wp post update % --post_status=publish```

### List all taxonomies for a post.
```wp taxonomy list --fields=name | xargs -I % wp post term list <Post ID> %```

### Recount all taxonomies.
```wp taxonomy list --field=name | xargs wp term recount```

### Assign a term to all posts in a post type.
```wp post list --post_type=post --fields=ID | xargs -I % wp post term set % category "daily-briefing"```

### Swap a term from a category to a custom taxonomy (then delete the original category on the post) and assign all posts to the new custom taxonomy term.
```wp post list --field=ID --category=<category slug> | xargs -I % bash -c "wp post term add % <taxonomy> <term slug> --by=slug && wp post term remove % <taxonomy> <term slug>"```
