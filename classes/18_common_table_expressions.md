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
UNION  
_<recursive_query> with break condition_  
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

# Real Example

Consider a table where you have employees with id, name and a column called _reports_to_, that references another employee, like a hierarchical relationship

```sql
id|name             |reports_to|
--+-----------------+----------+
 1|Chief Charles    |          |
 2|Subchief Susan   |         1|
 3|Subchief John    |         1|
 4|Manager Peter    |         3|
 5|Manager Melissa  |         3|
 6|Manager Carmen   |         2|
 7|Subchief Robert  |         5|
 8|Programmer Philip|         7|
 9|Programmer Edward|         7|
10|President Karla  |          |

-- Bring all people that reports to Chief Charles
-- Not only Subchiefs Susan and John

WITH RECURSIVE bosses AS (
    SELECT id, name, reports_to FROM employees WHERE id = 1
    UNION
    SELECT e.id, e.name, e.reports_to FROM employees e
    INNER JOIN bosses b ON b.id = e.reports_to
) SELECT * FROM bosses;

-- Returns
id|name             |reports_to|
--+-----------------+----------+
 1|Chief Charles    |          |
 2|Subchief Susan   |         1|
 3|Subchief John    |         1|
 4|Manager Peter    |         3|
 5|Manager Melissa  |         3|
 6|Manager Carmen   |         2|
 7|Subchief Robert  |         5|
 8|Programmer Philip|         7|
 9|Programmer Edward|         7|

 -- President Karla is not here because she does not reports to Chief Charles

 -- Now, bring just people that reports to Manager Melissa
 -- Just replace id 5 instead of 1cin initial values

WITH RECURSIVE bosses AS (
    SELECT id, name, reports_to FROM employees WHERE id = 5
    UNION
    SELECT e.id, e.name, e.reports_to FROM employees e
    INNER JOIN bosses b ON b.id = e.reports_to
) SELECT * FROM bosses;

-- Returns
id|name             |reports_to|
--+-----------------+----------+
 5|Manager Melissa  |         3|
 7|Subchief Robert  |         5|
 8|Programmer Philip|         7|
 9|Programmer Edward|         7|

 -- Now, consider you want to go to determinated depth, it means, limit recursivity
 -- For example, 3 levels of depth from Chief Charles
 -- It means, Chief -> SubChief -> Manager

WITH RECURSIVE bosses AS (
    SELECT
        id, name, reports_to, 1 AS depth
    FROM employees WHERE id = 1
    UNION
    SELECT
        e.id, e.name, e.reports_to, depth + 1
    FROM employees e
    INNER JOIN bosses b ON b.id = e.reports_to
    WHERE depth < 3
) SELECT * FROM bosses;

-- Returns
id|name           |reports_to|depth|
--+---------------+----------+-----+
 1|Chief Charles  |          |    1|
 2|Subchief Susan |         1|    2|
 3|Subchief John  |         1|    2|
 4|Manager Peter  |         3|    3|
 5|Manager Melissa|         3|    3|
 6|Manager Carmen |         2|    3|

 -- Now add the name of their chief
 -- Just add a join at the outside query

WITH RECURSIVE bosses AS (
    SELECT
        id, name, reports_to, 1 AS depth
    FROM employees WHERE id = 1
    UNION
    SELECT
        e.id, e.name, e.reports_to, depth + 1
    FROM employees e
    INNER JOIN bosses b ON b.id = e.reports_to
    WHERE depth < 3
) SELECT bs.*, em.name AS reports_to_name
FROM bosses bs
LEFT JOIN employees em ON em.id = bs.reports_to
ORDER BY depth;

-- Returns
id|name           |reports_to|depth|reports_to_name|
--+---------------+----------+-----+---------------+
 1|Chief Charles  |          |    1|               |
 3|Subchief John  |         1|    2|Chief Charles  |
 2|Subchief Susan |         1|    2|Chief Charles  |
 6|Manager Carmen |         2|    3|Subchief Susan |
 5|Manager Melissa|         3|    3|Subchief John  |
 4|Manager Peter  |         3|    3|Subchief John  |
```
