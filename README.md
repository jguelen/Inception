_This project has been created as part of the 42 curriculum by jguelen._

# Inception

## Description
Inception is a system administration and containerization project from the 42 curriculum.  
Its objective is to build a small production-like web infrastructure using **Docker** and **Docker Compose**, with each service isolated in its own container.

The mandatory stack is centered around:
- **Nginx** (TLS entrypoint / reverse proxy),
- **WordPress** (PHP-FPM),
- **MariaDB** (database).

The project can also include bonus services (for example here: monitoring, cache, FTPserver, adminer and the serving of a simple static website not in PHP).

### Project description
This repository contains:
- Dockerfiles for service images,
- a `docker-compose.yml` file orchestrating all services,
- a `Makefile` for common lifecycle commands,
- environment/secrets configuration files.

Main design choices:
- **One service per container** for clear boundaries and easier debugging.
- **Custom network** for internal service communication.
- **Persistent storage** for database and WordPress content.
- **Infrastructure as code** for reproducibility and portability.

### Included sources and components
- Docker images built from project Dockerfiles.
- Nginx configuration for HTTPS and routing.
- WordPress + MariaDB runtime configuration.
- Optional bonus stack: monitoring exporters, Grafana/Prometheus, redis, a FTP server, Adminer, a tiny static website.

### Technical choices and comparisons

#### Virtual Machines vs Docker
- **Virtual Machines** emulate full machines with separate guest OS kernels through the use of an hypervisor process, which is heavier in RAM/CPU/storage.
- **Docker containers** simulate environments through the use of cgroups grouped by namnespaces and given certain superuser capabilities and therefore share the host kernel, start faster, and are lighter.
- For this project, Docker is better suited for fast reproducible multi-service deployment.

#### Secrets vs Environment Variables
- **Environment variables** are simple for non-sensitive configuration but can be exposed in logs/process inspection.
- **Secrets** are better for sensitive data (passwords, tokens, keys) and are mounted with tighter scope. One requires access to the file system inside the docker container itself to be able to access their value and therefore would already be in a position that compromises security anyways were that to happen.
- Recommended practice: keep general config in `.env`, sensitive values in secrets where possible.

#### Docker Network vs Host Network
- **Docker bridge/custom network** provides isolation, service discovery by name, and safer exposure control. Docker simulates DNS resolve and TCP/IP networks between containers separately from the host network.
- **Host network** removes isolation and can cause port collisions.
- Inception uses internal container networking to keep service-to-service traffic private.

_NOTE_: Bridging the gap between container and host can sometimes cause issues where firewall rules can be ignored.

#### Docker Volumes vs Bind Mounts
- **Volumes** are Docker-managed and designed for persistent container data. They are stored under docker's root directory under `volumes/`.
- **Bind mounts** directly map host paths, useful for development but more host-dependent.
- Persistent services (DB, CMS data) should use durable storage strategy (volumes and/or controlled host paths).

## Instructions

### Prerequisites
- Linux host or Docker Desktop which will simulate some of the next points
- Docker Engine
- Docker Compose plugin (`docker compose`)
- `make`
- Permission to modify `/etc/hosts` (or do it manually)

### Setup
1. Clone repository:
   ```bash
      git clone https://github.com/jguelen/Inception.git
      cd Inception
    ```
2. Create/configure your environment file:
   - `srcs/.env` (required by the Makefile consult `srcs/.env_example` to know precise requirements easily)
3. Ensure DNS mapping exists:
   - `127.0.0.1 jguelen.42.fr` in `/etc/hosts`

### Build and run
```bash
make up
```
(or simply `make`)

### Stop / cleanup
```bash
make stop     # stop containers
make down     # remove containers + network
make vdown    # remove containers + network + volumes
make clean    # remove local images used by compose
make viclean  # remove local images + volumes used by compose
make fclean   # remove all related images + stack
```

### Access
- Main website: `https://jguelen.42.fr`
- Depending on enabled routes/services:
  - WordPress admin: `https://jguelen.42.fr/wp-admin`
  - Adminer: `https://jguelen.42.fr/adminer/`
  - Grafana: `https://jguelen.42.fr/monitoring/`

## Resources

### References
- Docker documentation: https://docs.docker.com/
- Docker Compose documentation: https://docs.docker.com/compose/
- Nginx documentation: https://nginx.org/en/docs/
- WordPress documentation: https://wordpress.org/documentation/
- WordPress-CLI: https://developer.wordpress.org/cli/commands/
- MariaDB documentation: https://mariadb.com/kb/en/documentation/
- OpenSSL documentation: https://www.openssl.org/docs/
- FTP configuration:
   - https://www.linuxtricks.fr/wiki/vsftpd-le-fichier-de-configuration-vsftpd-conf
   - https://nfrappe.fr/doc/doku.php?id=logiciel:internet:ftp:vsftpd:config:start
   - https://manpages.debian.org/trixie/vsftpd/vsftpd.conf.5.en.html
   - https://wiki.debian.org/vsftpd
- Redis: 
   - https://wordpress.org/plugins/redis-cache/
   - https://github.com/rhubarbgroup/redis-cache/blob/develop/INSTALL.md
   - https://redis.io/docs/latest/operate/
- Adminer main website: https://www.adminer.org/
- Prometheus documentation: https://prometheus.io/docs/
- Grafana documentation: https://grafana.com/docs/
- DockerHub for inspiration: https://hub.docker.com/
- MySQL Reference Manual: https://dev.mysql.com/doc/refman/9.7/en/privileges-provided.html
- IBM documentation on the GRANT statement: https://www.ibm.com/docs/fr/i/7.5.0?topic=statements-grant-table-view-privileges
- PHP: https://www.php.net/
- Debian: https://www.debian.org/distrib/
- Linux Man Pages


### AI usage statement
AI tools were used as assistants for:
- debugging Docker build/runtime issues by summarizing logs and speed up web searches for related bugs when applicable (FTP container for example),
- monitoring stack setup guidance (Grafana/Prometheus/exporters) specifically identifying specific exporters for specific tasks and suggestion of metrics to use or dashboards to import,
- provide test ideas,
- drafting project documentation.

All outputs were reviewed, tested, and adapted manually before integration.