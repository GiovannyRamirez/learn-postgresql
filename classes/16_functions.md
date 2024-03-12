# Functions

As in other programming languages, you can create functions to execute some task, you can pass parameters and return some value, PostgreSQL is not an exception and you can create a function considering

CREATE OR REPLACE FUNCTION _<function_name>(<param_name> <param_type>)_
RETURNS _<return_type>_
AS
_<double_dollar_sign>_
DECLARE _<return_name> <return_type>_
BEGIN
_<function_declaration>_ INTO _<return_name>_
RETURN _<return_name>_;
END
_<double_dollar_sign>_
LANGUAGE plpgsql;

## Example

For this example we can create the function to get json_agg and json_build_object shown in [Example Exercises # 11](../example_exercises/02_exercises.md)

```sql
CREATE OR REPLACE FUNCTION get_comment_replies (id integer)
RETURNS JSON
AS
$$
DECLARE result JSON;
BEGIN
    SELECT
        json_agg(
            json_build_object(
                'user', cms.user_id,
                'comment', cms.content
            )
        ) INTO result
    FROM comments cms
    WHERE cms.comment_parent_id = id;

    RETURN result;
END;
$$
LANGUAGE plpgsql;
```
