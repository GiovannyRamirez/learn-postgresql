# Triggers

Are like a functions that executes when some change occurs in a table, or in a specific column of a table

CREATE OR REPLACE TRIGGER _<trigger_name>_ _<when_event>_ ON _<table_name>_  
FOR EACH ROW EXECUTE PROCEDURE _<procedure_name> or <function_name> or <function_definition>_;

If you want to trigger when a condition is true, then, you use

CREATE OR REPLACE TRIGGER _<trigger_name>_ _<when_event>_ ON _<table_name>_  
FOR EACH ROW  
WHEN _condition_  
EXECUTE PROCEDURE _<procedure_name> or <function_name> or <function_definition>_;

_condition_ can contain _NEW_ and _OLD_ reserved words to compare new value and old value

## Example

```sql
-- It executes with any change on user table
CREATE OR REPLACE TRIGGER save_log AFTER UPDATE ON "user"
FOR EACH ROW EXECUTE PROCEDURE save_log_function();

-- It executes just when last_login column changes
CREATE OR REPLACE TRIGGER save_log AFTER UPDATE ON "user"
FOR EACH ROW
WHEN (OLD.last_login IS DISTINCT FROM NEW.last_login)
EXECUTE PROCEDURE save_log_function();
```
