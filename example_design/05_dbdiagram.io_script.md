# dbdiagram.io script

This example was developed using [dbdiagram.io](https://dbdiagram.io/home), and design is next

```
Table users {
  user_id integer [pk, increment]
  username varchar [not null, unique]
  email varchar [not null, unique]
  password varchar [not null]
  name varchar [not null]
  role varchar [not null]
  gender varchar [not null]
  created_at timestamp [default: 'now()']
  updated_at timestamp [default: 'now()']
}

Table posts {
  post_id integer [pk, increment]
  title varchar [default: '']
  body text [default: '']
  og_image varchar
  slug varchar [not null, unique]
  published boolean
  created_at timestamp [default: 'now()']
  updated_at timestamp [default: 'now()']
  created_by integer
}

Table claps {
  clap_id integer [pk, increment]
  created_at timestamp [default: 'now()']
  counter integer [default: 0]
  post_id integer
  user_id integer

  indexes {
    (post_id, user_id) [unique]
    (post_id)
  }
}

Table comments {
  comment_id integer [pk, increment]
  content text
  created_at timestamp [default: 'now()']
  visible boolean
  post_id integer
  user_id integer
  comment_parent_id integer

  indexes {
    (post_id)
    (visible)
  }
}

Table user_lists {
  user_list_id integer [pk, increment]
  title varchar
  user_id integer

  indexes {
    (user_id, title) [unique]
    (user_id)
  }
}

Table user_list_entry {
  user_list_entry_id integer [pk, increment]
  user_list_id integer
  post_id integer
}

Ref: "users"."user_id" < "posts"."created_by"

Ref: "users"."user_id" < "claps"."user_id"

Ref: "posts"."post_id" < "claps"."post_id"

Ref: "users"."user_id" < "comments"."user_id"

Ref: "posts"."post_id" < "comments"."post_id"

Ref: "comments"."comment_id" < "comments"."comment_parent_id"

Ref: "users"."user_id" < "user_lists"."user_id"

Ref: "posts"."post_id" < "user_list_entry"."post_id"

Ref: "user_lists"."user_list_id" < "user_list_entry"."user_list_id"
```
