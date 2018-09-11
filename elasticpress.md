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

### Deleting Indices on-by-one
``` bash 
# 1. Go to <elasticsearch endpoint>/_cat/indices/<prefix>*

# 2. Copy this into a text file.

# 3. Paste clipboard contents after the following command into text file.
cat remove_indices.txt| awk '{ print $3 }' | pbcopy

# 4. Remove the indices.
do echo "Deleting Index ""$i";  curl -XDELETE https://<username>:<password>@<elasticsearch endpoint>/$i; done;
```
