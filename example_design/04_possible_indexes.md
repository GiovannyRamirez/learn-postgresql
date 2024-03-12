# Possible Indexes

Considering queries, we should to create indexes, remember that primary keys acts as an indexes by default.
Check other posibilities to create an index for tables

- _users_:

  - It could be necessary an index by username, even, add columns like email and password, considering authentication

- _posts_:

  - It could be necessary an index by slug

- _claps_:

  - We wish to know if an user already give a clap when read the post, so, we need a composite index with post_id and user_id
  - We also, wish to know claps by post_id

- _comments_:

  - We can load all comments by post_id, so, it will be an index
  - Same situation with visible column

- _user_lists_:

  - Combination of user_id and title must be unique, so, its a combined index
  - Also, we can check all lists from user_id
