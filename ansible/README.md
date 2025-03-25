# Ansible Playbook for Django Event Locator

This Ansible playbook automates the deployment and configuration of the Django Event Locator application using Infrastructure as Code (IaC) principles.

## Prerequisites

- Ansible 2.9 or higher installed on your local machine
- Target servers running Ubuntu 20.04 or higher
- SSH access to the target servers
- Required Ansible collections:
  ```bash
  ansible-galaxy collection install community.docker
  ```

## Directory Structure

```
ansible/
├── inventory/
│   └── hosts                  # Inventory file with server definitions
├── roles/
│   ├── common/                # Common server setup tasks
│   ├── docker/                # Docker installation and configuration
│   ├── web/                   # Django application deployment
│   ├── database/              # PostgreSQL database setup and backups
│   ├── redis/                 # Redis setup and monitoring
│   └── caddy/                 # Caddy web server configuration
└── site.yml                   # Main playbook file
```

## Configuration

1. Edit the `inventory/hosts` file to specify your server details:

```ini
[production]
production_server ansible_host=your_production_server_ip ansible_user=your_production_user

[staging]
staging_server ansible_host=your_staging_server_ip ansible_user=your_staging_user
```

2. Create a variables file for your environment (e.g., `vars/production.yml`):

```yaml
---
# Django settings
django_secret_key: "your-secure-secret-key"
django_debug: "0"
django_allowed_hosts: "yourdomain.com,www.yourdomain.com"

# Database settings
postgres_db: "django_db"
postgres_user: "django"
postgres_password: "secure-password"

# Email settings
email_host: "smtp.gmail.com"
email_port: "587"
email_use_tls: "True"
email_host_user: "your-email@gmail.com"
email_host_password: "your-app-password"

# Domain settings
domain_name: "yourdomain.com"
admin_email: "admin@yourdomain.com"

# Security settings
csrf_trusted_origins: "https://yourdomain.com,https://www.yourdomain.com"
```

## Usage

### Deploy to Production

```bash
ansible-playbook -i inventory/hosts site.yml --limit production --extra-vars "@vars/production.yml" --ask-become-pass
```

### Deploy to Staging

```bash
ansible-playbook -i inventory/hosts site.yml --limit staging --extra-vars "@vars/staging.yml" --ask-become-pass
```

The `--ask-become-pass` flag will prompt you for the sudo password, which is required for tasks that need elevated privileges.

## What This Playbook Does

1. **Common Role**: Updates the system, installs common packages, and configures firewall
2. **Docker Role**: Installs Docker and Docker Compose
3. **Web Role**: Deploys the Django application using Docker
4. **Database Role**: Sets up database backup
5. **Redis Role**: Configures Redis monitoring
6. **Caddy Role**: Sets up Caddy as a reverse proxy with automatic HTTPS

## Maintenance Tasks

### Database Backups

Database backups are automatically created daily at 3:00 AM and stored in `/opt/django-event-locator/backups/`. Backups older than 30 days are automatically deleted.

### Redis Monitoring

Redis is monitored every 15 minutes, and the status is logged to `/opt/django-event-locator/redis-monitoring/redis_monitoring.log`. If Redis is down, the script will attempt to restart it.

### SSL Certificate Renewal

Caddy automatically handles SSL certificate renewal. The playbook also sets up a weekly restart of Caddy to ensure certificates are properly renewed.
