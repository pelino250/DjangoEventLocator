# Django Event Locator

Django Event Locator is a web application that helps users discover, create, and attend local events. It provides a platform for event organizers to create and manage events while allowing regular users to find and participate in events that interest them.

## Features

- **User Management**
  - Custom user profiles with social media integration
  - User roles (regular users and event organizers)
  - Profile customization (bio, location, profile picture)

- **Event Management**
  - Create and manage events
  - Browse local events
  - Mark events as favorites
  - Track event attendance

- **Social Features**
  - Follow other users
  - Social media integration
  - Event sharing capabilities

## Technologies Used

- Django 5.1.6
- Bootstrap 5 (via crispy-bootstrap5)
- PostgreSQL database (SQLite for development)
- Redis for caching
- Caddy as a reverse proxy and static file server
- Mailhog for email testing
- Docker and docker-compose for containerization
- Gunicorn for production deployment
- Python 3.12

## Installation

You can install and run this application either using a traditional Python setup or using Docker.

### Option 1: Traditional Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/DjangoEventLocator.git
   cd DjangoEventLocator
   ```

2. Create a virtual environment and activate it:
   ```bash
   python -m venv .venv
   source .venv/bin/activate  # On Windows use: .venv\Scripts\activate
   ```

3. Install required packages:
   ```bash
   pip install -r requirements.txt
   ```

4. Configure environment variables:
   - Create a `.env` file in the project root based on `.env.example`
   - At minimum, add your email configuration:
     ```
     EMAIL_HOST_USER=your_email@gmail.com
     EMAIL_HOST_PASSWORD=your_email_password
     ```

5. Apply database migrations:
   ```bash
   python manage.py migrate
   ```

6. Create a superuser:
   ```bash
   python manage.py createsuperuser
   ```

7. Run the development server:
   ```bash
   python manage.py runserver
   ```

### Option 2: Docker Setup

For a complete containerized setup with PostgreSQL, Redis, Caddy, and Mailhog, see the [Docker Deployment](#docker-deployment) section below.

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/DjangoEventLocator.git
   cd DjangoEventLocator
   ```

2. Copy the `.env.example` file to `.env`:
   ```bash
   cp .env.example .env
   ```

3. Build and start the containers:
   ```bash
   docker-compose up -d
   ```

4. Create a superuser:
   ```bash
   docker-compose exec web python manage.py createsuperuser
   ```

5. Access the application at http://localhost

For more detailed Docker instructions, see the [Docker Deployment](#docker-deployment) section or the [DOCKER_DOCUMENTATION.md](DOCKER_DOCUMENTATION.md) file.

## Configuration

### Environment Variables

The application uses environment variables for configuration. Copy `.env.example` to `.env` and customize the values:

```bash
cp .env.example .env
# Edit .env with your preferred text editor
```

### Database Setup

#### SQLite (Development)
By default, the application uses SQLite in development mode. No additional configuration is needed.

#### PostgreSQL (Production/Docker)
When `DOCKER_ENVIRONMENT=true`, the application uses PostgreSQL:

1. Configure PostgreSQL settings in your `.env` file:
   ```
   POSTGRES_DB=django_db
   POSTGRES_USER=django
   POSTGRES_PASSWORD=your_secure_password
   POSTGRES_HOST=db  # Use 'db' for Docker, actual hostname for external PostgreSQL
   POSTGRES_PORT=5432
   ```

2. If using Docker, these settings are automatically applied to the PostgreSQL container.

### Redis Caching

When `DOCKER_ENVIRONMENT=true`, the application uses Redis for caching:

1. Configure Redis settings in your `.env` file:
   ```
   REDIS_HOST=redis  # Use 'redis' for Docker, actual hostname for external Redis
   REDIS_PORT=6379
   ```

2. If using Docker, these settings are automatically applied to the Redis container.

### Email Setup

#### Development with Mailhog
When using Docker, emails are captured by Mailhog and can be viewed at http://localhost:8025.

#### Production with Gmail SMTP
For production, the application can use Gmail SMTP for email notifications:

1. Enable 2-factor authentication in your Google account
2. Generate an App Password
3. Configure in your `.env` file:
   ```
   EMAIL_HOST=smtp.gmail.com
   EMAIL_PORT=587
   EMAIL_USE_TLS=True
   EMAIL_HOST_USER=your_email@gmail.com
   EMAIL_HOST_PASSWORD=your_app_password
   ```

### Static Files

Static files are configured to be served from the `static` directory. To collect static files:

```bash
python manage.py collectstatic
```

In Docker, static files are automatically collected during image build and served by Caddy.

### Color Palette

The application uses a consistent color scheme defined in `static/css/custom.css`:

#### Primary Colors
- `#1C6043` - Deep Green
- `#27865D` - Forest Green
- `#85D1B0` - Sage Green
- `#D1F3E4` - Mint Green
- `#F5FBF8` - Ice Green

#### Secondary Colors
- `#2C887C` - Teal
- `#7FC0B7` - Sea Green
- `#ACDCD5` - Light Teal
- `#DBFFFA` - Pale Teal
- `#E6FFFE` - Ice Teal

#### Grey Colors
- `#5A5A5A` - Dark Grey
- `#B3B3B3` - Medium Grey
- `#D0D2D6` - Light Grey
- `#E9E9EA` - Pale Grey
- `#F8F8F8` - Off White

#### Black Colors
- `#000000` - Pure Black
- `#242629` - Rich Black
- `#53555A` - Charcoal
- `#DBDBDC` - Light Charcoal
- `#F6F8F7` - Off White

These colors are implemented using CSS variables and can be accessed throughout the application using the `var(--color-name)` syntax.

## Usage

1. Access the application at `http://localhost:8000`
2. Register a new account or log in
3. Create your profile and start exploring events
4. To create events, request organizer status through your profile

## Contributing

1. Fork the repository
2. Create a new branch for your feature
3. Commit your changes
4. Push to your branch
5. Create a Pull Request

## Continuous Integration/Continuous Deployment (CI/CD)

This project uses GitHub Actions for CI/CD. The workflows are defined in the `.github/workflows` directory:

1. **Linting Workflow**: Runs code quality checks using Black and pre-commit.
2. **Build, Test, and Deploy Workflow**: Builds the Docker image, runs tests, and provides a template for deployment.

For more details about the CI/CD setup, see the [github_actions.md](github_actions.md) file.

### Local Development with Pre-commit

To ensure your code passes the same checks that run in CI, you can use pre-commit hooks locally:

```bash
pip install pre-commit
pre-commit install
```

This will automatically run the configured hooks on your commits.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Docker Deployment

The application can be easily deployed using Docker and docker-compose. The setup includes:

- Django web application with Gunicorn
- PostgreSQL database
- Redis for caching
- Caddy as a reverse proxy and static file server
- Mailhog for email testing in development

### Prerequisites

- Docker and docker-compose installed on your system
- Basic knowledge of Docker and containerization

### Setup

1. Copy the `.env.example` file to `.env` and configure the environment variables:
   ```bash
   cp .env.example .env
   # Edit .env with your preferred text editor
   ```

2. Build and start the containers:
   ```bash
   docker-compose up -d
   ```

3. Create a superuser:
   ```bash
   docker-compose exec web python manage.py createsuperuser
   ```

4. Apply migrations (if needed):
   ```bash
   docker-compose exec web python manage.py migrate
   ```

### Accessing Services

- **Web Application**: https://localhost or http://localhost (served by Caddy)
- **Mailhog Web Interface**: http://localhost:8025 (for viewing sent emails)
- **PostgreSQL**: localhost:5432 (accessible with database tools using credentials from .env)
- **Redis**: localhost:6379 (accessible with Redis tools)

### Common Commands

- View logs:
  ```bash
  docker-compose logs -f
  ```

- Restart services:
  ```bash
  docker-compose restart
  ```

- Stop all services:
  ```bash
  docker-compose down
  ```

- Stop all services and remove volumes (caution - this will delete all data):
  ```bash
  docker-compose down -v
  ```

### Production Considerations

For production deployment:
- Change the SECRET_KEY in .env
- Set DJANGO_DEBUG=0 in .env
- Configure proper email settings for a production mail server
- Update the Caddyfile with your domain name
- Configure ALLOWED_HOSTS in .env to include your domain
- SSL/TLS certificates are automatically handled by Caddy:
  - Replace `example.com` in the Caddyfile with your actual domain name
  - Update the admin email address provided as an argument to the `tls` directive for Let's Encrypt notifications
  - Ensure your security settings in .env are configured for HTTPS:
    ```
    CSRF_TRUSTED_ORIGINS=http://localhost,http://127.0.0.1,https://yourdomain.com
    SECURE_SSL_REDIRECT=True
    SESSION_COOKIE_SECURE=True
    CSRF_COOKIE_SECURE=True
    SECURE_HSTS_SECONDS=31536000
    SECURE_HSTS_INCLUDE_SUBDOMAINS=True
    SECURE_HSTS_PRELOAD=True
    ```
- Consider using a managed database service instead of the containerized PostgreSQL

### Troubleshooting SSL/HTTPS Issues

If you see "https" crossed out in your browser with a "not secure" warning, this could be due to one of the following reasons:

#### For Local Development:
- This is **normal and expected** when using a self-signed certificate for localhost
- Your browser will always show a security warning for self-signed certificates
- You can safely proceed past this warning for local development
- No action is required unless you want to disable SSL entirely (see "Local Development without SSL" section)

#### For Production:
1. **Using example.com instead of your actual domain:**
   - Make sure you've replaced `example.com` in the Caddyfile with your actual domain name
   - Make sure you've replaced `admin@example.com` with your actual email address
   - Restart Caddy after making these changes: `docker-compose restart caddy`

2. **Domain not properly configured:**
   - Ensure your domain's DNS records point to your server's IP address
   - Make sure ports 80 and 443 are open on your server and not blocked by a firewall
   - Caddy needs to be able to communicate with Let's Encrypt servers to obtain a certificate
   - Verify your domain is correctly pointing to your server using: `nslookup yourdomain.com`
   - Verify ports 80 and 443 are open using an online port checker or: `telnet yourdomain.com 80` and `telnet yourdomain.com 443`

3. **Let's Encrypt rate limits:**
   - If you've made too many certificate requests, you might hit rate limits
   - Wait at least an hour before trying again
   - Check Caddy logs for more information: `docker-compose logs caddy`

4. **Certificate not being generated:**
   - The Caddyfile includes an `on_demand` directive in the TLS configuration which forces certificate issuance/renewal
   - If certificates still aren't being generated, check the Caddy logs for specific errors: `docker-compose logs caddy`
   - Ensure your server is publicly accessible from the internet (Let's Encrypt needs to verify domain ownership)
   - Try temporarily disabling any firewalls or CDNs that might be blocking Let's Encrypt verification

5. **Verifying Let's Encrypt can reach your server:**
   - Let's Encrypt needs to verify domain ownership by making HTTP requests to your server
   - These requests are made to `http://yourdomain.com/.well-known/acme-challenge/`
   - Ensure this path is not blocked by any firewall, proxy, or CDN
   - You can test if your server is reachable by running: `curl -I http://yourdomain.com`

### Local Development with SSL

By default, the application is configured to use HTTPS on localhost with a self-signed certificate:
- The Caddyfile includes `tls internal` for localhost and 127.0.0.1, which generates a self-signed certificate
- When accessing https://localhost, your browser will show a security warning because the certificate is self-signed
- You can safely proceed past this warning for local development
- Ensure your .env file has the following settings:
  ```
  CSRF_TRUSTED_ORIGINS=http://localhost,https://localhost,http://127.0.0.1,https://127.0.0.1,https://example.com
  SECURE_SSL_REDIRECT=True
  SESSION_COOKIE_SECURE=True
  CSRF_COOKIE_SECURE=True
  ```

### Local Development without SSL

If you prefer to use HTTP instead of HTTPS for local development:
1. Modify the Caddyfile to remove the `tls internal` line from the localhost section
2. Set the following in your .env file:
  ```
  SECURE_SSL_REDIRECT=False
  SESSION_COOKIE_SECURE=False
  CSRF_COOKIE_SECURE=False
  ```
3. Restart the Caddy container:
  ```bash
  docker-compose restart caddy
  ```

## Ansible Deployment (Infrastructure as Code)

The application can be deployed using Ansible for Infrastructure as Code (IaC). This approach automates the deployment process and ensures consistent environments.

### Prerequisites

- Ansible 2.9 or higher installed on your local machine
- Target servers running Ubuntu 20.04 or higher
- SSH access to the target servers

### Setup

1. Configure the inventory file:
   ```bash
   cd ansible
   # Edit inventory/hosts with your server details
   ```

2. Create a variables file for your environment:
   ```bash
   # Copy the example file
   cp vars/production.example.yml vars/production.yml
   # Edit vars/production.yml with your configuration
   ```

3. Run the Ansible playbook:
   ```bash
   ansible-playbook -i inventory/hosts site.yml --limit production --extra-vars "@vars/production.yml"
   ```

### What the Ansible Playbook Does

The Ansible playbook automates the following tasks:

1. Updates the system and installs common packages
2. Installs Docker and Docker Compose
3. Deploys the Django application using Docker
4. Sets up database backup
5. Configures Redis monitoring
6. Sets up Caddy as a reverse proxy with automatic HTTPS

For more details, see the [ansible/README.md](ansible/README.md) file.
