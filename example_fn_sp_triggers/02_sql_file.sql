-- CREATION 
CREATE TABLE IF NOT EXISTS "user" (
    id INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    username VARCHAR(50),
    password TEXT,
    last_login TIMESTAMP
);

CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE IF NOT EXISTS "session_failed" (
    id INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    username VARCHAR(50),
    last_time TIMESTAMP
);

CREATE TABLE IF NOT EXISTS "user_update" (
    id INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    user_id INTEGER,
    prev_username TEXT,
    new_username TEXT,
    at TIMESTAMP,
    CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES "user"(id)
);

CREATE OR REPLACE PROCEDURE user_login (user_name VARCHAR, user_pwd VARCHAR) AS $$
DECLARE
    was_found BOOLEAN;

BEGIN
    SELECT COUNT(*) INTO was_found
    FROM "user"
        WHERE
            username = user_name
            AND
            password = crypt(user_pwd, password);

    IF (was_found = false) THEN
        INSERT INTO "session_failed" (username, last_time)
            VALUES(user_name, NOW());
        COMMIT;

        RAISE EXCEPTION 'User not found';
    END IF;

    UPDATE "user"
    SET last_login = NOW()
    WHERE username = user_name;

    COMMIT;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION save_update_log()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO "user_update" (user_id, prev_username, new_username, at)
        VALUES (NEW.id, OLD.username, NEW.username, NOW());

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER save_update_user AFTER UPDATE ON "user"
FOR EACH ROW
WHEN (OLD.username IS DISTINCT FROM NEW.username)
EXECUTE FUNCTION save_update_log();


-- INCORRECT LOGIN (USER NOT EXISTS)
CALL user_login('New User', '1234567');

INSERT INTO "user" (username, password)
	VALUES ('New User', crypt('123456', gen_salt('bf')));

-- CORRECT LOGIN
CALL user_login('New User', '1234567');

UPDATE "user"
SET username = 'New User Name'
WHERE username = 'New User';

SELECT * FROM "user";
SELECT * FROM session_failed;
SELECT * FROM user_update;
