# ElasticPress

### Bash loop to reindex a list of sites
``` bash
for i in $(cat ~/sitelist); do echo "Entering site ""$i"; wp elasticpress index --posts-per-page=10 --url="<url>""$i"; done
```

### Reindexing an entire network site by site:
``` bash 
for url in $(wp site list --field=url)
do
	echo "$url:"
	wp elasticpress index --keep-active --posts-per-page=100 --url=$url 
done
```
