# Dates

There are many types of date types, like:

- _TIMESTAMPS_
- _DATE_

## Functions

- _NOW()_: Full date of database
- _CURRENT_DATE_: Returns current date
- _CURRENT_TIME_: Returns current time
- _DATE_PART('timePart', NOW())_: Extract timePart of NOW(), timePart like: _(hours, seconds, months, ...)_

```sql
SELECT NOW(), CURRENT_DATE, CURRENT_TIME, DATE_PART('hours', NOW());

now                          |current_date|current_time  |date_part|
-----------------------------+------------+--------------+---------+
2024-03-07 14:57:18.788 -0500|  2024-03-07|14:57:18 -0500|     19.0|
```

You can apply aggregation functions like MAX(), MIN() and other operations like BETWEEN

- _INTERVAL_: Allows to operate with dates

```sql
SELECT NOW(), NOW() + INTERVAL '1 month' + INTERVAL '1 days';

now                          |now+1m+1d                    |
-----------------------------+-----------------------------+
2024-03-07 15:10:15.284 -0500|2024-04-08 15:10:15.284 -0500|
```

- _MAKE_INTERVAL('PART' := DATE_PART('timePart', 'DATE'))_: Allows to make an interval calculating dinamically a value

```sql
SELECT
    NOW(),
    MAKE_INTERVAL(MONTHS := DATE_PART('months', NOW())::integer) AS interval,
    NOW() + MAKE_INTERVAL(MONTHS := DATE_PART('months', NOW())::integer) AS sumInterval;

now                          |interval|suminterval                  |
-----------------------------+--------+-----------------------------+
2024-03-07 15:20:41.245 -0500|  3 mons|2024-06-07 15:20:41.245 -0500|
```

- _EXTRACT('PART' FROM 'DATE')_: Allows to susbtract a value from a date

```sql
SELECT
    NOW(),
    EXTRACT(YEARS FROM NOW());

now                          |extract|
-----------------------------+-------+
2024-03-07 15:37:17.231 -0500|   2024|
```
