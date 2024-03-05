# ORDER BY

You can organize results ordering by specific condition

- _ASC_: Ascending
- _DESC_: Descending

## Example

```sql
SELECT
    first_name, last_name, followers
FROM
    users
WHERE
    followers BETWEEN 4600 AND 4700
ORDER BY
    followers ASC;
```

# GROUP BY

Allows to group values when for example you want to count total of every value in a column, when you use an aggregate function and a column name, you need to use GROUP BY

## Example

```sql
SELECT
    COUNT(*), followers
FROM USERS
WHERE followers BETWEEN 4500 and 4999
GROUP BY followers;
```

# HAVING

Is used as a filter when we use aggregate functions, is used after GROUP BY and before ORDER BY

## Example

```sql
SELECT
    COUNT(*), country
FROM USERS
GROUP BY country
HAVING COUNT(*) > 5
ORDER BY count(*) ASC;
```

HAVING allow use of BETWEEN and other comparison operators.
