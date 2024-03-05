# Create tables

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

# Insert values

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

# Update values

To update a row in a column, you need an identificator, i.e: an id, primaryKey, etc.

Use UPDATE _<table_name>_ SET command followed by columns and the new value separated by equal (=) WHERE id value, and end the command with semicolon _;_

## Example

```sql
UPDATE users SET name = 'Name Changed' WHERE name = 'Other Name';
```

# Select values

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
