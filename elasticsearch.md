### Check to see if Elasticsearch is running.
```bash
sudo lsof -i TCP | grep 9200
sudo lsof -iTCP -sTCP:LISTEN | grep elasticsearch
curl -IGET http://localhost:9200
```
