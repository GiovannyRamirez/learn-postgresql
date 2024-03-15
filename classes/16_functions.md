# Functions

As in other programming languages, you can create functions to execute some task, you can pass parameters and return some value, PostgreSQL is not an exception and you can create a function considering

CREATE OR REPLACE FUNCTION _<function_name>(<param_name> <param_type>)_  
RETURNS _<return_type>_ AS _<double_dollar_sign>_  
DECLARE _<return_name> <return_type>_;  
BEGIN  
 _<function_declaration>_ INTO _<return_name>_  
RETURN _<return_name>_;  
END;  
_<double_dollar_sign>_ LANGUAGE plpgsql;

Also, following [documentation](https://www.postgresql.org/docs/current/sql-createfunction.html), there are, other ways to create a function, nevertheless, we will work with mentioned here

Here we will use _plpgsql language_, but, there are other languages too

## Example

For this example we can create the function to get json_agg and json_build_object shown in [Example Exercises # 11](../example_exercises/02_exercises.md)

```sql
CREATE OR REPLACE FUNCTION get_comment_replies (id integer)
RETURNS JSON AS $$
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
$$ LANGUAGE plpgsql;
```

You can use multiple variables in _DECLARE_ statement, and to save the data desired you do not do _INTO ..., INTO ..._, you use just one _INTO_ and order variables as columns

Also, you can execute multiple queries into function

## Example

Consider you have _employees_ and _jobs_, in _employees_, you have job*id, salary, ..., and in \_jobs* you have job_id, min_salary, max_salary, ...

You want to determine max_raise for an employee, so, you can do a function to calculate it and return the job_id

You have to consider if the current_salary is less than 0, when for example, employee has upper salary than max

To solve this, you can use _IF THEN_ clause

```sql
CREATE OR REPLACE FUNCTION max_raise (emp_id integer)
RETURNS NUMERIC(8,2) AS $$
DECLARE
    employee_job_id int;
    current_salary NUMERIC(8,2);
    job_max_salary NUMERIC(8,2);
    possible_raise NUMERIC(8,2);
BEGIN
    SELECT
        job_id,
        salary
        INTO employee_job_id, current_salary -- INTO in same order as columns from SELECT
    FROM employees
    WHERE employee_id = emp_id;

    SELECT
        max_salary
        INTO job_max_salary
    FROM jobs
    WHERE job_id = employee_job_id;

    possible_raise = job_max_salary - current_salary;

    IF (possible_raise < 0) THEN
        possible_raise = 0; -- To assign a value to return
        -- RAISE EXCEPTION 'Person with max_salary: %', emp_id; -- To throw an exception
    END IF;

    RETURN possible_raise;
END;
$$ LANGUAGE plpgsql;
```

Now, if you use a lot of variables, you can use a _rowtype_, that is like an object, and you can access of attributes with _dot (.)_, is commonly used to save all columns from a table, lets go to transform last function to use it

_<var_name> <table_name>%rowtype_;

```sql
CREATE OR REPLACE FUNCTION max_raise (emp_id integer)
RETURNS NUMERIC(8,2) AS $$
DECLARE
    selected_employee employees%rowtype;
    selected_job jobs%rowtype;

    possible_raise NUMERIC(8,2);
BEGIN
    SELECT * FROM employees INTO selected_employee -- Save into rowtype var
    WHERE employee_id = emp_id;

    SELECT * FROM jobs INTO selected_job -- Save into rowtype var
    WHERE job_id = selected_employee.job_id; -- Comparing with other rowtype var

    possible_raise = selected_job.max_salary - selected_employee.salary;

    IF (possible_raise < 0) THEN
        possible_raise = 0; -- To assign a value to return
        -- RAISE EXCEPTION 'Person with max_salary: %', emp_id; -- To throw an exception
    END IF;

    RETURN possible_raise;
END;
$$ LANGUAGE plpgsql;
```
