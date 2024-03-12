# Exercises

Consider that your database has information based in [Mock data](./01_medium_mock_database.sql)

And solve next questions:

1. How many posts there are in DB
2. How many posts ther are published in DB
3. Which is most recent post
4. List 10 users _(id, #posts, name)_ with most posts
5. List 5 posts with most total claps
6. Top 5 users that more claps have done
7. Top 5 users that more claps have done accumulated
8. How many users do not have user_lists
9. Show comment with id = 1 and its replies
10. From query 9, including user_id generate a response line (json_agg, json_build_object)
11. List main comments and crate new column with its replies in json_format

# Solution

```sql
-- 1
SELECT COUNT(*) FROM posts;

-- 2
SELECT COUNT(*) FROM posts WHERE published = true;

-- 3
SELECT * FROM posts ORDER BY created_at DESC LIMIT 1;

-- 4
SELECT
    COUNT(*), u.user_id, u.name
    FROM posts p
    INNER JOIN users u ON p.created_by = u.user_id
    GROUP BY u.user_id, u.name
    ORDER BY COUNT(*) DESC
LIMIT 10;

-- 5
SELECT
    SUM(c.counter) AS total_claps, p.title
    FROM posts p
    INNER JOIN claps c ON p.post_id = c.post_id
    GROUP BY p.title
    ORDER BY SUM(c.counter) DESC
LIMIT 5;

-- 6
SELECT
    COUNT(*), u.name
    FROM claps c
    INNER JOIN users u ON c.user_id = u.user_id
    GROUP BY u.name
    ORDER BY COUNT(*) DESC
LIMIT 5;

-- 7
SELECT
    SUM(c.counter), u.name
    FROM claps c
    INNER JOIN users u ON c.user_id = u.user_id
    GROUP BY u.name
    ORDER BY SUM(c.counter) DESC
LIMIT 5;

-- 8
SELECT
    COUNT(*)
    FROM user_lists ul
    RIGHT JOIN users u ON u.user_id = ul.user_id
    WHERE ul.user_id IS NULL;

-- 9
SELECT * FROM comments WHERE comment_id = 1
UNION
SELECT * FROM comments WHERE comment_parent_id = 1;

-- 10
SELECT
    json_agg(
        json_build_object(
            'user', user_id,
            'comment', content
        )
    )
    FROM comments
    WHERE comment_parent_id = 1;

-- 11
SELECT
    cm.*,
    (
        SELECT
            json_agg(
                json_build_object(
                    'user', cms.user_id,
                    'comment', cms.content
                )
            )
            FROM comments cms
            WHERE cms.comment_parent_id = cm.comment_id
    ) AS replies
    FROM comments cm
    WHERE cm.comment_parent_id IS NULL;

```
