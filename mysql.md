### Check mysql capacity to handle traffic
```bash
mysqlslap  --query=/root/select_query_cp.sql --concurrency=10 --iterations=5  --create-schema=cvts1
```

### Generate statements to replace table prefixes
```bash
SELECT
	CONCAT ('rename table ',table_name,' to ',REPLACE( table_name, 'wp_', '<new prefix>' ) ,';')
FROM
	information_schema.tables
WHERE
	table_name LIKE 'wp_%'
  	AND table_schema='<table name>'
```
