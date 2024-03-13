# Views

Is like an _alias_ for a query, is also like a virtual table, it can be temporal or persistent

CREATE VIEW _<view_name>_ AS _<DESIRED_QUERY>_;

Then, you can call the view next time that yo need the query (it can be complex), and, query will be executed

## Example

```sql
CREATE VIEW example_view AS
    SELECT COUNT(*) FROM users;

-- Call it

SELECT * FROM example_view;
```

Be careful when you update the view with CREATE OR REPLACE VIEW, sometimes, depending the update, its not possible to update it, in some cases, is better drop it and recreate it

# Materialized Views

If a _view_ is an alias that represents a table, a _materialized view_ is this table created as a new one, but, data is not necessary updated, because, if some data changed after build the _materialized view_, this update do not appear in the _materialized view_

CREATE MATERIALIZED VIEW _<view_name>_ AS _<DESIRED_QUERY>_;

## Example

```sql
CREATE MATERIALIZED VIEW example_materialized_view AS
    SELECT name, last_name FROM users;

-- Call it

SELECT * FROM example_materialized_view;
```

_Materialized View_ is more efficient than _View_, consider that if you update rows of the table, changes do not appear when you call it

Nevertheless, you can update de information manually, but, consider, that execution of query and creation of the table could take more time, blocking processes, so, be careful updating _materialized views_

REFRESH MATERIALIZED VIEW _<materialized_view_name>_;

```sql
REFRESH MATERIALIZED VIEW example_materialized_view;
```

# Alter

You can _ALTER_ _views_ and _materialized views_, to rename it, or other _ALTER_ operations, (Check documentation of your PostgreSQL version), here, we will rename the views with

ALTER VIEW _<view_name>_ RENAME TO _<new_view_name>_;

ALTER MATERIALIZED VIEW _<materialized_view_name>_ RENAME TO _<new_materialized_view_name>_;

## Example

```sql
ALTER VIEW example_view RENAME TO example_view_renamed;

ALTER MATERIALIZED VIEW example_materialized_view RENAME TO example_materialized_view_renamed;
```
