# DEV_DOC

## 1) Setup from scratch

### Prerequisites
- Linux environment or Docker Desktop
- Docker Engine installed and running
- Docker Compose plugin (`docker compose`)
- GNU Make
- Sudo rights (for automated `/etc/hosts` update from Makefile pre-step)

### Clone and enter project
```bash
git clone https://github.com/jguelen/Inception.git
cd Inception
```

### Configuration
Create and fill:
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

---

## 2) Build and launch using Makefile + Compose

Makefile uses:
- `docker compose -f srcs/docker-compose.yml`

Main commands:
```bash
make up      # build/start stack
make stop    # stop containers
make down    # remove containers/network
make vdown   # remove containers/network/volumes
make clean   # remove local images
make viclean # remove local images and volumes
make fclean  # aggressive cleanup
```

Rebuild flows:
```bash
make re      # clean then up
make revi    # viclean then up
make ref     # fclean then up
```

---

## 3) Useful developer operations

### Service status
```bash
docker compose -f srcs/docker-compose.yml ps
```

### Follow logs
```bash
docker compose -f srcs/docker-compose.yml logs [service name] -f
```

### Rebuild one service without cache
```bash
docker compose -f srcs/docker-compose.yml build --no-cache <service>
```

### Recreate one service
```bash
docker compose -f srcs/docker-compose.yml up -d --force-recreate <service>
```

### Volume inspection
```bash
docker volume ls
docker volume inspect <volume_name>
```

---

## 4) Data storage and persistence

From current Makefile:
- Base data path: `/home/jguelen/data`
- WordPress data: `/home/jguelen/data/docker/volumes/wordpress_files`
- MariaDB data: `/home/jguelen/data/docker/volumes/database`

Persistence behavior:
- `make down`: containers/network removed, persistent data remains.
- `make vdown`: volumes removed.
- If bind mounts are used, host files persist until manually deleted.

---

## 5) Troubleshooting for developers

- Ensure `srcs/.env` exists before startup.
- Verify `jguelen.42.fr` resolves to localhost/target host.
- If service crashes, inspect that service logs first.
- For Nginx proxy failures:
  - check upstream name equals compose service name,
  - check target internal port,
  - check TLS cert/key paths.
- For subpath apps (e.g. Grafana `/monitoring/`):
  - align Nginx location blocks with app base URL/root_url settings.
- For exporter auth errors:
  - verify DB user host grants and secret content (trailing newline mistakes are common).