# PRIMARY KEYS types

- _SERIAL_: Works as SEQUENCE, you can rewrite it

  ```sql
  CREATE TABLE IF NOT EXISTS users_serial (
      id SERIAL PRIMARY KEY,
      name VARCHAR
  );
  ```

- _IDENTITY_: Similar to SERIAL, but, allows other types, also, prevents manually insertion INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY

  ```sql
  CREATE TABLE IF NOT EXISTS users_identity_default (
      id INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY, --Similar to Serial, you can insert it manually
      name VARCHAR
  );
  --
  CREATE TABLE IF NOT EXISTS users_identity_always (
      id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, --You can not insert it manually
      name VARCHAR
  );
  --
  CREATE TABLE IF NOT EXISTS users_identity_config (
      id INTEGER GENERATED ALWAYS AS IDENTITY (START 100 INCREMENT BY 3) PRIMARY KEY, --You can not insert it manually and sets the start and increments
      name VARCHAR
  );
  ```

You can set a primary key combinating two fields, is not neccessary that both fields are unique, just the combination of them

```sql
CREATE TABLE IF NOT EXISTS combined_ids (
    id int4,
    name VARCHAR,
    PRIMARY KEY (id, name)
);
```

- _UUID_: Is an extension, you need to install it CREATE EXTENSION IF NOT EXISTS _<extension_name>_

  ```sql
  CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
  -- DROP EXTENSION "uuid-ossp"; --To remove it

  SELECT uuid_generate_v4(); --Shows an uuid string

  CREATE TABLE IF NOT EXISTS users_uuid (
      id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
      name VARCHAR
  );
  ```

- _SEQUENCE_: Similar to identity, you can controle it, get current and next, etc.

  ```sql
  CREATE SEQUENCE sequence_example; --Always set start with 1 and increments by 1
  -- DROP SEQUENCE sequence_example; --To remove it

  SELECT NEXTVAL('sequence_example'); --Shows next value in sequence
  SELECT CURRVAL('sequence_example'); --Shows current value

  CREATE TABLE IF NOT EXISTS users_sequence (
      id INTEGER PRIMARY KEY DEFAULT NEXTVAL('sequence_example'),
      name VARCHAR
  );
  ```