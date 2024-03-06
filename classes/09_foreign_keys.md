# Foreign keys

Used to establish relations between tables
Is an ALTER operation

ALTER TABLE _<table_name>_ ADD CONSTRAINT _<fk_name>_ FOREIGN KEY _(column)_ REFERENCES _<referenced_table_name>_ _(column)_

## Example

```sql
ALTER TABLE city
    ADD CONSTRAINT fk_country_code
    FOREIGN KEY (countrycode)
    REFERENCES country(code);
```

## Considerations

When you have a foreign key and you want to delete registers from table, you can configure _onDelete_ and _onUpdate_ actions

- _CASCADE_: Update or Delete values related to that foreign key on every table that references it

```sql
ALTER TABLE city
    ADD CONSTRAINT fk_country_code
    FOREIGN KEY (countrycode)
    REFERENCES country(code)
    ON DELETE CASCADE;
```
