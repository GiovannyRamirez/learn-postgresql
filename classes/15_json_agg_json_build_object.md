# json_agg

json_agg is a function supported in PostgreSQL that aggregates as a single line a result of a table, receiving desired column

## Example

```sql
SELECT json_agg(comment_id) FROM comments WHERE comment_parent_id = 1;
-- Returns
[3058, 4649, 4768]
```

# json_build_object

json_build_object is a function supported in PostgreSQL that allows to build an object by every row with a pair key: value defined by query

## Example

```sql
SELECT
    json_build_object(
        'user', user_id,
        'comment', content
    )
    FROM comments
    WHERE comment_parent_id = 1;

-- Returns
json_build_object                |
---------------------------------+
{"user" : 1797, "comment" : 3058}|
{"user" : 1842, "comment" : 4649}|
{"user" : 1447, "comment" : 4768}|
```
