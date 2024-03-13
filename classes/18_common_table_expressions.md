# Common Table Expressions (CTE)

Is used to:

- Make recursive queries
- Simplify complex queries

Basically, _CTE_ is a virtual table in memory, and, we can do queries over it

WITH _<desired_name>_ AS (_<DESIRED_QUERY>_) ...;

## Example (Simplifying)

```sql
WITH cte_example AS (
    SELECT * FROM users;
) SELECT * FROM cte_example WHERE email LIKE = '%mail.c%';
```

To build a recursive CTE, use reserved word RECURSIVE and you have to follow next stucture

WITH RECURSIVE _<cte_name> (<column_names>)_ AS (
_<initial_values>_
UNION ALL
_<recursive_query> FROM <cte_name> with break condition_
) _<normal_query> FROM <cte_name>_;

## Example (Recursive)

```sql
WITH RECURSIVE countdown (val) AS (
    VALUES(5) -- or SELECT 5 AS val
    UNION
    SELECT val - 1 FROM countdown WHERE val > 1
) SELECT * FROM countdown;

-- Returns
val|
---+
  5|
  4|
  3|
  2|
  1|

-- If you use SELECT syntax inside initial values, you do not need to use (val)
-- But, in SELECT you have to define aliases

WITH RECURSIVE counter AS (
    SELECT 1 AS val
    UNION
    SELECT val + 1 FROM counter WHERE val < 10
) SELECT * FROM counter;

-- Returns
val|
---+
  1|
  2|
  3|
  4|
  5|
  6|
  7|
  8|
  9|
 10|

WITH RECURSIVE multiply_table (base, num, result) AS (
    VALUES(5, 1, 5)
    UNION
    SELECT
        5, num + 1, (num + 1) * base
    FROM multiply_table
    WHERE num < 10
) SELECT * FROM multiply_table;

-- Returns
base|num|result|
----+---+------+
   5|  1|     5|
   5|  2|    10|
   5|  3|    15|
   5|  4|    20|
   5|  5|    25|
   5|  6|    30|
   5|  7|    35|
   5|  8|    40|
   5|  9|    45|
   5| 10|    50|
```
