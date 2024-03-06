# Constraints

Constraints are restrictions/conditions, like unique values, field types, null types, indexes, etc.

# Relations

- **_One to One_**: A register in a table can be in another table related by an id, and, its exclusively one register, ie: _Students - ContactInfo_
- **_One to Many_**: A register in a table can be related by and id in another table, one can be many times in other, ie: _Customers - ServiceOrders_
- **_Self Joining_**: For example, when in a table we save the data of a last time other user changes info in same table.
- **_Many to Many_**: For example many students are in many classes, but, the way to solve this is with an intermediate table built with studentId and classId keys, generating basically two relations:

  - One To Many: _Students - Enrollments_
  - Many To One: _Enrollments - Classes_

# Keys

Keys allows to generate relations between tables, allows to guarantee data integrity.

- _Primary Key_: Identifies a register in an unique way, a table can have mutiple unique ids (user identification, passport, license, etc), but, primary keys is defined by requirements
- _Candidate Key_: An attribute or a attributes set that identifies in an unique way a register, like, user identification and name
- _Super Key_: Is a set of primary key and other candidate key
- _Foreign Key_: Is a primary key of other table, used to create a relation between both tables, should share key constraints, considering, are the same key
- _Composite Key_: When a primary key is a set of others keys inside same table

# Check

Used to verify fields in table, is an ALTER operation, so, you can do it as follows:

ALTER TABLE _<table_name>_ ADD CHECK(_condition_);

## Example

```sql
ALTER TABLE country ADD CHECK(surfacearea >= 0);
```

You can add multiple conditions into CHECK constraint

## Example

```sql
ALTER TABLE country ADD CHECK(continent IN ('Africa', 'Europe' ));
```

If you want to modify a constraint, first, you need to DROP it, and, after that create it again including modification

ALTER TABLE _<table_name>_ DROP CONSTRAINT _<constraint_name>_;

If you do not know the constraint name, you can go to DB GUI and generate DDL from table, in the sql file generated, you can see table schema with constraints

```sql
ALTER TABLE country DROP CONSTRAINT country_continent_check;
```
