# USER_DOC

## 1) Services provided by the stack
This project deploys a multi-container web infrastructure.

Core services:
- **Nginx**: HTTPS endpoint and reverse proxy.
- **WordPress (PHP-FPM)**: website/CMS.
- **MariaDB**: persistent database.

Optional bonus services (if enabled):
- **Adminer** for DB administration
- **Redis** for cache/session acceleration
- **FTP server** for file transfer
- **Static website** endpoint
- **Monitoring stack** (Prometheus, Grafana, exporters)

---

## 2) How to start and stop the project

From repository root:

### Start
```bash
make up
```
(`make` also works because default target calls `up`.)

### Stop containers
```bash
make stop
```

### Stop and remove containers/network
```bash
make down
```

### Stop and remove containers + volumes
```bash
make vdown
```

### Full cleanup (including images)
```bash
make fclean
```

---

## 3) Accessing website and administration panels

### Website
Open:
- `https://jguelen.42.fr`

If it does not resolve, check `/etc/hosts` contains:
- `127.0.0.1 jguelen.42.fr`

### Administration
Depending on enabled services/routes:
- WordPress admin: `https://jguelen.42.fr/wp-admin`
- Adminer: `https://jguelen.42.fr/adminer/`
- Grafana: `https://jguelen.42.fr/monitoring/`

---

## 4) Locating and managing credentials

Credentials are stored in:
- `srcs/.env` for runtime variables:
    - DOMAIN_NAME for the name of the domain (here jguelen.42.fr)
    - DB_USER for the normal mariadb user's name
    - DB_NAME for the name of the mariadb database
    - WP_TITLE for the WordPress title
- secret files for more important credentials:
    - db_password: password for $DB_USER in a single line
    - db_ro_user_credentials: 
        - first line for mysqld-exporter's user name
        - second line for mysqld-exporter's user password
    - db_root_password: password for mariadb's root user in a single line
    - ftp_credentials: 
        - first line for ftp's user name
        - second line for ftp's user password
    - grafana-admin-password:  password for grafana's admin user in a single line
    - wp_admin_credentials:
        - first line for WordPress's administrator's actual login
        - second line for WordPress's administrator's password
        - third line for WordPress's administrator's email
    - wp_user_credentials:
        - first line for WordPress's normal user's actual login
        - second line for WordPress's normal user's password
        - third line for WordPress's normal user's email

After credential changes:
```bash
make down && make up
```
or
```
make re
```
(Or recreate only impacted services.)

---

## 5) Verifying services are running correctly

### Check stack status
```bash
docker compose -f srcs/docker-compose.yml ps
```

### Check logs
```bash
docker compose -f srcs/docker-compose.yml logs [service name] -f
```

### Functional checks
- Main page loads over HTTPS.
- WordPress login/admin reachable.
- Database service running.
- Bonus service endpoints reachable

### Quick troubleshooting
- Domain issue → verify `/etc/hosts`.
- HTTPS issue → inspect Nginx logs and cert paths.
- DB connection issue → inspect WordPress and MariaDB logs.
- Reverse proxy issue → verify upstream service name and internal port.