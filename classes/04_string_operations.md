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

# SUBSTRING(), POSITION()

- _SUBSTRING()_: Allows to get a substring from string passed as argument, indicating start and end positions
- _POSITION()_: Allows to get the position of a determined substring from string passed as argument

## Example

```sql
SELECT name,
    SUBSTRING(name, 0, 5), --(From name column, char 0 to 5)
    POSITION(' ' in name) --(Find space in name column)
FROM users;
```

It can be used in combination to, for example separate name and last_name

## Example

```sql
SELECT
    SUBSTRING(name, 0, POSITION(' ' in name)) as first_name,
    SUBSTRING(name, POSITION(' ' in name) + 1) as last_name
FROM users;
--or
SELECT
    SUBSTRING(name, 0, POSITION(' ' in name)) as first_name,
    TRIM(SUBSTRING(name, POSITION(' ' in name))) as last_name
FROM users;
```

To update all values getting just a name, we can do next:

```sql
UPDATE users
    SET
        first_name = SUBSTRING(name, 0, POSITION(' ' in name)),
        last_name = SUBSTRING(name, POSITION(' ' in name) + 1);
```
