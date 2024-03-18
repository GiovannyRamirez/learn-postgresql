# Extensions

- [uuid-ossp](https://www.postgresql.org/docs/current/uuid-ossp.html): USed to get universal unique identifiers (uuid) values
- [pgcrypto](https://www.postgresql.org/docs/current/pgcrypto.html): Used to provide cryptographhic functions

To use it, first, you need to create it:  
CREATE EXTENSION IF NOT EXISTS _<extension_name>_;

To delete, you need to drop it:  
DROP EXTENSION _<extension_name>_;

## Example

```sql
CREATE EXTENSION IF NOT EXISTS pgcrypto;
DROP EXTENSION pgcrypto;
```
