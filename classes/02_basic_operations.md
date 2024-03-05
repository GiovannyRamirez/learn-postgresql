# CREATE tables

Use CREATE TABLE _<table_name>_ command followed by schema inside parenthesis _(field-name TYPE constraints (optional))_, _(comma if has more fields or table constraints)_, and end the command with semicolon _;_

## Example

```sql
CREATE TABLE users (
    id SERIAL,
    name VARCHAR(100) UNIQUE
);
```

You can create a table if not exists replacing

```sql
CREATE TABLE ...
```

with

```sql
CREATE TABLE IF NOT EXISTS ...
```

# INSERT values

Use INSERT INTO _<table_name>_ command followed by columns inside parenthesis _(field-name)_ VALUES followed by values inside parenthesis (in the same order of columns) and end the command with semicolon _;_

## Example

```sql
INSERT INTO users ( name ) VALUES ( 'Name' );
```

Also, you can insert multiple values at same time, repeating parenthesis after VALUES command separated by commas

```sql
INSERT INTO users ( name ) VALUES ('Other'), ('Last');
```

If you want to add data in all columns, you can remove column parenthesis, but, you have to do it in same column order definition, in example case, only have a _name_ column, so, we can do the query like this

```sql
INSERT INTO users VALUES ('Other Name'), ('Last Name');
```

# UPDATE values

To update a row in a column, you need an identificator, i.e: an id, primaryKey, etc.

Use UPDATE _<table_name>_ SET command followed by columns and the new value separated by equal (=) WHERE id value, and end the command with semicolon _;_

## Example

```sql
UPDATE users SET name = 'Name Changed' WHERE name = 'Other Name';
```

# SELECT values

Use SELECT command followed by desired columns FROM _<table_name>_ and end the command with semicolon _;_

## Example

```sql
SELECT name FROM users;
```

If you want to select all columns, you can replace desired columns with _\*_ and end the command with semicolon _;_

Also, you can add filters, limits, aggregations.

## Example

```sql
SELECT * FROM users LIMIT 2 OFFSET 2;
```

# WHERE clause

Its important to get correct desired information from a table, you can use it to get conditions from columns like startsWith, endsWith, equalsTo, and, also you can build the condition with _AND, OR_.

## Example

```sql
SELECT * FROM users WHERE name = 'Name Changed'; --(equalsTo)
SELECT * FROM users WHERE name LIKE 'Na%'; --(startsWith)
SELECT * FROM users WHERE name LIKE '%ed'; --(endsWith)
```

_percentage %_ is related to unknown characters, also, you can use \_underscore \_\_ to determine quantity of characters, and, even, you can combine it.

## Example

```sql
SELECT * FROM users WHERE name LIKE '__st'; --(2 characters before st)
SELECT * FROM users WHERE name LIKE '_a%'; --(1 character before a, and ends with any other characters)
SELECT * FROM users WHERE name LIKE '%a%'; --(contains a);
```

# DELETE values

DELETE command is similar with SELECT, be careful with the use of DELETE without WHERE clause, with that, you delete all content form the table, to DELETE specific value, use WHERE clause.

```sql
DELETE FROM users WHERE name LIKE '__st'; --(2 characters before st rows will be deleted)
DELETE FROM users; --(all rows will be deleted);
```
