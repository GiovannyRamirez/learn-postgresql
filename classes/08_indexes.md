# Indexes

Indexes are a way to improve performance of query, consider that an index is the way that you can find determinate value in a better way.
For example, if you want to find a register that starts with 'A', is better if you first organize all register ascending, and, if the register is unique, query ends, preventing execution with the rest of values.

Indexes consumes space in DB

CREATE _UNIQUE if is UNIQUE, if not, skip it_ INDEX _<index_name>_ ON _<table_name> (columns)_;

```sql
CREATE UNIQUE INDEX unique_country_name ON country (name);
CREATE INDEX country_continent ON country (continent);
```

Consider create indexes in columns that will be highly consulted
