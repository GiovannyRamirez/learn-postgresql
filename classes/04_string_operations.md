# UPPER(), LOWER(), TRIM(), LENGTH(), CONCAT()

- _UPPER()_: Converts to uppercase the string passed as argument
- _LOWER()_: Converts to lowercase the string passed as argument
- _TRIM()_: Removes start and end whitespaces of the string passed as argument
- _LENGTH()_: Returns length of a string passed as argument
- _CONCAT()_ or _||_: Concatenate strig passed as arguments

## Example

```sql
SELECT id, name,
    UPPER(name) as upper_name,
    LOWER(name) as lower_name,
    TRIM(name) as trim_name,
    LENGTH(name) as length_name,
    CONCAT('*', id, ' ', name) as concat,
    '*'||id||' '||name as concat_pipe
FROM users;
```
