# UNION

Allows to join results from different conditions in same table or different tables

_<query_one>_ UNION _<query_two>_;

Remember that columns needs to be same type and needs to have same quantity

## Example

```sql
SELECT * FROM continent WHERE name LIKE '%America'
    UNION
SELECT * FROM continent WHERE code IN (3,5)
ORDER BY name ASC;
```

You can use it to match results from different tables using WHERE clause, but, this combination simulates JOIN, so, use JOIN instead, here, an example just to learn

## Example

```sql
SELECT c.name AS country, ct.name as continent
    FROM country c, continent ct
    WHERE c.continent = ct.code
ORDER BY c.name ASC;
```

Its important to set alias in columns and tables, and, to establish correct WHERE clause

**_Be careful with UNION WHERE combination_**

# JOIN

## INNER JOIN

From tables _A_ and _B_ you want the rows that matches a condition _ON_

SELECT _<columns_names> using table aliases and also assign aliases to columns_ FROM _<table_a> A (alias)_ JOIN _<table_b> B (alias)_ ON _A.key_ = _B.key_;

```sql
SELECT c.name AS country, ct.name AS continent
    FROM country c
    JOIN continent ct
    ON c.continent = ct.code
ORDER BY c.name ASC;
--
SELECT c.name AS country, ct.name AS continent
    FROM country c
    INNER JOIN continent ct
    ON c.continent = ct.code
ORDER BY c.name ASC;
```

You can use JOIN or INNER JOIN clause, results will be the same

## FULL OUTER JOIN

From tables _A_ and _B_ you get all the rows when there is a match on any table, you could get rows that do not have a value in the other table as NULL, i.e, when you have defined continents but, still do not have countries related to them

SELECT _<columns_names> using table aliases and also assign aliases to columns_ FROM _<table_a> A (alias)_ FULL OUTER JOIN _<table_b> B (alias)_ ON _A.key_ = _B.key_;

```sql
SELECT c.name AS country, ct.name AS continent
    FROM country c
    FULL OUTER JOIN continent ct
    ON c.continent = ct.code
ORDER BY c.name DESC;
```

In this way, you can get information about what records are not used yet

## RIGHT OUTER JOIN (exclusive)

It works as FULL OUTER JOIN but, you have to add the exclusive condition with WHERE clause

```sql
SELECT c.name AS country, ct.name AS continent
    FROM country c
    RIGHT OUTER JOIN continent ct
    ON c.continent = ct.code
    WHERE c.name is NULL
ORDER BY c.name DESC;
```
