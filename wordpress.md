## Documentation
* Reference: https://developer.wordpress.org/reference/
* https://codex.wordpress.org/Plugin_API/Action_Reference


#### Disable WP Obj Caching - subsequent calls will directly read from DB
```php
wp_using_ext_object_cache(false);
wp_cache_flush();
wp_cache_init();
```
