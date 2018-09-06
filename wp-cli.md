# WP CLI

### Update meta for a CPT
```wp post list --post_type=<cpt-name> --field=ID | xargs -I % wp post meta update % _yoast_wpseo_meta-robots-nofollow 1```

### List active themes in multisite.
```wp site list --field=url | xargs -I % bash -c "echo 'URL:' % && wp theme list --url=% --status=active"```
