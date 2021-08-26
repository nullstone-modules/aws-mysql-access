# aws-mysql-access

Nullstone capability to grant access for a mysql database to an app.

### Secrets

- `MYSQL_PASSWORD`
- `MYSQL_URL`

### Env Vars

- `MYSQL_USER`
- `MYSQL_DB`

### Security Group Rules

- `tcp:3306` <=> `mysql` connection
