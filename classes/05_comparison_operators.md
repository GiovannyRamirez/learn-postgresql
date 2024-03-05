# Comparisons

- _=_: Equals?
- _>_: Greater than?
- _<_: Lower than?
- _>=_: Greater or equal than?
- _<=_: Lower or equal than?
- _IN_: List contain value?
- _NOT IN_: List not contain value
- _<>_ or _!=_: Values are equal?
- _BETWEEN_: Between values?
- _NOT BETWEEN_: Not between values
- _IS NULL_: Value is null?
- _LIKE_: Value contains a pattern?
- _NOT LIKE_: Value not contains a pattern

This comparisons are used commonly with _WHERE_ clause to filter data to get.

Remember you can concatenate filters with AND, OR clauses.

## Example

```sql
SELECT
    first_name, last_name, last_connection
FROM
    users
WHERE last_connection LIKE '221.%';
--
SELECT
    first_name, last_name, followers
FROM
    users
WHERE followers > 4600;
--
SELECT
    first_name, last_name, followers
FROM
    users
WHERE
    followers >= 4600 AND followers <= 4700;
```

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

Note that we replace _>=_ and _<=_ with BETWEEN comparation to show that BETWEEN includes xtremes.
