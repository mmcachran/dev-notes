# ElasticPress

### Bash loop to reindex a list of sites
``` bash
for i in $(cat ~/sitelist); do echo "Entering site ""$i"; wp elasticpress index --posts-per-page=10 --url="<url>""$i"; done
```

