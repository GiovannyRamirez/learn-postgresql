# Math operations and functions

Some of the math operations and functions are:

- _+_: Addition
- _-_: Substraction
- _\*_: Multiplication
- _/_: Division (Truncates result)
- _%_: Module
- _ABS()_: Absolute value
- _ROUND()_: Rounds to nearest integer
- _SQRT()_: Square root
- _TRUNC()_: Truncates decimal positions
- _SIN()_: Sine
- _ACOS()_: Inverse cosine

# Aggregation Functions

- _MAX()_: Returns max value in all input values not null.
  It works for example to get max id from a table.

## Example

```sql
DELETE FROM users WHERE id = (SELECT MAX(id) FROM users); --(delete last row from users table)
```

Here, you can see a subquery into main query (Be careful with subqueries, it could be inefficient, you could do it with views or temporal tables, etc).

- _COUNT()_: Returns total rows in table
- _MIN()_: Returns min value in all input values not null
- _AVG()_: Returns average including all values
- _SUM()_: Return sum of all values

## Example

```sql
SELECT
    COUNT(*) as total_users,
    MIN(followers) as min_followers,
    MAX(followers) as max_followers,
    AVG(followers) as avg_followers,
    ROUND(AVG(followers)) as avg_followers_rounded,
    SUM(followers) / COUNT(followers) as avg_manual
FROM users;
```
