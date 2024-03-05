# MAX()

Allows to get max value in all input values not null.
It works for example to get max id from a table.

## Example

```sql
DELETE FROM users WHERE id = (SELECT MAX(id) FROM users); --(delete last row from users table)
```

Here, you can see a subquery into main query.
