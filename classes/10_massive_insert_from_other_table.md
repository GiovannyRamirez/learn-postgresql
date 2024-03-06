By using subqueries, you can insert values into table from other table, for example, you have a column with continent name in a main country table, but, you need to separate it and make a relation between them.
You could create a new table with desired fields and populate it with the information of main table

```sql
CREATE TABLE IF NOT EXISTS continent (
    code SERIAL NOT NULL,
    name text NOT NULL,
    PRIMARY KEY (code)
);

INSERT INTO continent (name)
    SELECT DISTINCT continent FROM country ORDER BY continent ASC;
```

When you want to do relation or modify the table, make a backup to prevent failures

# Make a copy and info dump

Create other table with same schema, and populate it using similar last subquery

```sql
CREATE TABLE IF NOT EXISTS country_old ...

INSERT INTO country_old
    SELECT * FROM country;
```

# DROP CHECK

Its important to DROP constraints that can difficult data migration, remeber DROP is an ALTER operation
ALTER TABLE _<table_name>_ DROP CONSTRAINT _<constraint_name>_;

## Example

```sql
ALTER TABLE country DROP CONSTRAINT country_continent_check;
```

# Massive UPDATE

1. Knowing new table origin id we can get the ids and execute the update

   ```sql
   UPDATE country c
       SET continent = (
           SELECT code FROM continent ct WHERE ct.name = c.continent
       );
   ```

2. Change field type in first table to build a relation

   - Is an UPDATE operation and may need a cast type

     - ALTER TABLE _<table_name>_ ALTER COLUMN _<column_name>_ TYPE _<new_type>_;
       ```sql
       ALTER TABLE country
           ALTER COLUMN continent TYPE int4;
       ```
     - ALTER TABLE _<table_name>_ ALTER COLUMN _<column_name>_ TYPE _<new_type>::<main_type>_ USING _<column_name>::<main_type>_;

       ```sql
       ALTER TABLE country
           ALTER COLUMN continent TYPE int4
           USING continent::integer;
       ```

3. Make the relation using foreign key

   ```sql
   ALTER TABLE country
       ADD CONSTRAINT fk_continent_code
       FOREIGN KEY (continent)
       REFERENCES continent(code);
   ```

4. DROP backup table
