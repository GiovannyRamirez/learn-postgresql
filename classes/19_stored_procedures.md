# Stored Procedures

Stored procedures are like functions, it executes queries to do something with information in database, allowing to isolate this task from backend

Has a similar structure than functions, just changes the _FUNCTION word_ to _PROCEDURE word_ and, is not necessary that you returns something

Also, you have to manually stablish the _COMMIT_ to confirm operation

To execute, you use _CALL_

## Example

```sql
CREATE OR REPLACE PROCEDURE insert_employee (id integer, name varchar) AS $$
BEGIN
   INSERT INTO employees (employee_id, employee_name)
   VALUES (id, name);

   COMMIT;
END;
$$ LANGUAGE plpgsql;

-- Execute
CALL insert_employee(1, 'New User Name');
```
