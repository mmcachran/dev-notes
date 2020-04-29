### Check mysql capacity to handle traffic
```bash
mysqlslap  --query=/root/select_query_cp.sql --concurrency=10 --iterations=5  --create-schema=cvts1
```
