# UNION

Allows to join results from different conditions in same table or different tables

_<query_one>_ UNION _<query_two>_;

Remeber that columns needs to be same type and needs to have same quantity

## Example

```sql
SELECT * FROM continent WHERE name LIKE '%America'
    UNION
SELECT * FROM continent WHERE code IN (3,5)
ORDER BY name ASC;
```

Youu can use it to match results from different tables using WHERE clause, but, this combination simulates JOIN, so, use JOIN instead, here, an example just to learn

```sql
SELECT c.name AS country, ct.name as continent
    FROM country c, continent ct
    WHERE c.continent = ct.code
ORDER BY c.name ASC;
```

Its important to set alias in columns and tables, and, to establish correct WHERE clause

**_Be careful with UNION WHERE combination_**
