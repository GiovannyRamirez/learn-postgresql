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
