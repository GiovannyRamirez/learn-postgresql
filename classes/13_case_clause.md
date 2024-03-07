# CASE

Allows to set a value depending condition defined by WHEN

CASE WHEN _(condition)_ THEN 'Some text' ELSE 'Other text' END AS _<column_name>_

## Example

```sql
SELECT
    first_name,
    hire_date,
    CASE
        WHEN hire_date > NOW() - INTERVAL '1 year' THEN 'A Range'
        WHEN hire_date > NOW() - INTERVAL '3 year' THEN 'B Range'
        WHEN hire_date > NOW() - INTERVAL '5 year' THEN 'C Range'
        ELSE 'D Range'
    END AS anitiquity_range
FROM employees
ORDER BY hire_date DESC;
```
