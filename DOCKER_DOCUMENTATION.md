# Docker Configuration Explained for Beginners

## Dockerfile Explained

A Dockerfile is a script that contains instructions for building a Docker image. Think of it as a recipe for creating a container that will run your application.

```dockerfile
# get base image
FROM python:3.12
```
- **What it does**: Starts with an official Python 3.12 image as the foundation
- **Why**: This gives us a pre-configured environment with Python already installed

```dockerfile
# set working directory
WORKDIR /app
```
- **What it does**: Creates and sets `/app` as the directory where our application will live
- **Why**: This keeps our application files organized in one place inside the container

```dockerfile
# copy requirements first to leverage Docker cache
COPY requirements.txt .
```
- **What it does**: Copies just the requirements.txt file from your computer to the container
- **Why**: Docker uses caching to speed up builds. By copying and installing requirements first, we avoid reinstalling all packages when only application code changes

```dockerfile
# install dependencies
RUN pip install --no-cache-dir -r requirements.txt
```
- **What it does**: Installs all Python packages listed in requirements.txt
- **Why**: Our application needs these packages to run properly
- **--no-cache-dir**: Reduces the image size by not storing the pip cache

```dockerfile
# copy all files from current directory to working directory
COPY . .
```
- **What it does**: Copies all your application files from your computer to the container
- **Why**: Now the container has your complete application code

```dockerfile
# create static and media directories
RUN mkdir -p /app/staticfiles /app/media
```
- **What it does**: Creates directories for static files (CSS, JS, images) and media files (user uploads)
- **Why**: Django needs these directories to store and serve these files

```dockerfile
# collect static files
RUN python manage.py collectstatic --noinput
```
- **What it does**: Runs Django's command to gather all static files into the staticfiles directory
- **Why**: This prepares static files to be served efficiently in production

```dockerfile
EXPOSE 8000
```
- **What it does**: Tells Docker that the container will listen on port 8000
- **Why**: This is documentation for users of the image, showing which port the application uses

```dockerfile
# Use gunicorn for production
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "--workers", "3", "DjangoEventLocator.wsgi:application"]
```
- **What it does**: Specifies the command to run when the container starts
- **Why**: Gunicorn is a production-ready web server for Python applications
- **--bind 0.0.0.0:8000**: Makes the server accessible from outside the container on port 8000
- **--workers 3**: Creates 3 worker processes to handle requests in parallel
- **DjangoEventLocator.wsgi:application**: Points to the WSGI application entry point

## Docker Compose File Explained

A docker-compose.yml file defines and configures multiple containers that work together as a complete application.

```yaml
version: "3.8"
```
- **What it does**: Specifies the docker-compose file format version
- **Why**: Different versions support different features

### Web Service (Django Application)

```yaml
services:
  web:
    build:
      context: .
      dockerfile: Dockerfile
```
- **What it does**: Defines a service named "web" that will be built using the Dockerfile in the current directory
- **Why**: This is your Django application container

```yaml
    expose:
      - "8000"
```
- **What it does**: Exposes port 8000 only to other containers, not to the host
- **Why**: We'll access the application through Caddy, not directly

```yaml
    volumes:
      - .:/app
      - static_volume:/app/staticfiles
      - media_volume:/app/media
```
- **What it does**: Maps directories between your computer and the container
- **Why**:
  - `.:/app`: Changes to your code are immediately available in the container
  - `static_volume:/app/staticfiles`: Persists static files and shares them with Caddy
  - `media_volume:/app/media`: Persists media files and shares them with Caddy

```yaml
    depends_on:
      db:
        condition: service_healthy
      redis:
        condition: service_healthy
      mailhog:
        condition: service_started
```
- **What it does**: Ensures the web service only starts after other services are ready
- **Why**: Your application needs the database and Redis to be fully operational before it starts

```yaml
    env_file:
      - .env
    environment:
      - DOCKER_ENVIRONMENT=true
      - POSTGRES_HOST=db
      - REDIS_HOST=redis
      - REDIS_PORT=6379
      - EMAIL_HOST=mailhog
      - EMAIL_PORT=1025
      - EMAIL_USE_TLS=False
```
- **What it does**: Provides environment variables to the container
- **Why**: These variables configure your application to connect to the other services

```yaml
    restart: unless-stopped
```
- **What it does**: Automatically restarts the container if it crashes
- **Why**: Keeps your application running without manual intervention

### Database Service (PostgreSQL)

```yaml
  db:
    image: postgres:15
```
- **What it does**: Uses the official PostgreSQL version 15 image
- **Why**: PostgreSQL is a powerful, open-source relational database

```yaml
    volumes:
      - postgres_data:/var/lib/postgresql/data/
```
- **What it does**: Stores database files in a persistent volume
- **Why**: Ensures your data isn't lost when containers are restarted

```yaml
    env_file:
      - .env
    environment:
      - POSTGRES_DB=${POSTGRES_DB}
      - POSTGRES_USER=${POSTGRES_USER}
      - POSTGRES_PASSWORD=${POSTGRES_PASSWORD}
```
- **What it does**: Configures the database with values from your .env file
- **Why**: Sets up the database name, user, and password

```yaml
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U ${POSTGRES_USER} -d ${POSTGRES_DB}"]
      interval: 10s
      timeout: 5s
      retries: 5
```
- **What it does**: Regularly checks if the database is ready to accept connections
- **Why**: Ensures other services only start when the database is fully operational

### Redis Service (Caching)

```yaml
  redis:
    image: redis:7
```
- **What it does**: Uses the official Redis version 7 image
- **Why**: Redis is an in-memory data store used for caching to speed up your application

```yaml
    volumes:
      - redis_data:/data
```
- **What it does**: Stores Redis data in a persistent volume
- **Why**: Preserves cache data between container restarts

```yaml
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
```
- **What it does**: Checks if Redis is responding to commands
- **Why**: Ensures Redis is operational before the web service starts

### Caddy Service (Web Server)

```yaml
  caddy:
    image: caddy:2
```
- **What it does**: Uses the official Caddy version 2 image
- **Why**: Caddy is a modern web server that handles HTTPS automatically

```yaml
    ports:
      - "80:80"
      - "443:443"
```
- **What it does**: Maps ports 80 (HTTP) and 443 (HTTPS) from your computer to the container
- **Why**: Allows users to access your application via a web browser

```yaml
    volumes:
      - ./Caddyfile:/etc/caddy/Caddyfile
      - caddy_data:/data
      - caddy_config:/config
      - static_volume:/static
      - media_volume:/media
```
- **What it does**: Maps configuration and data between your computer and the container
- **Why**:
  - `./Caddyfile`: Your custom Caddy configuration
  - `caddy_data` and `caddy_config`: Persistent storage for Caddy
  - `static_volume` and `media_volume`: Access to your application's static and media files

### Mailhog Service (Email Testing)

```yaml
  mailhog:
    image: mailhog/mailhog
```
- **What it does**: Uses the Mailhog image
- **Why**: Mailhog captures emails sent by your application for testing

```yaml
    ports:
      - "1025:1025"  # SMTP server
      - "8025:8025"  # Web UI
```
- **What it does**: Maps the SMTP port and web interface port
- **Why**:
  - Port 1025: Your application sends emails to this port
  - Port 8025: You can view captured emails in a web browser

### Volumes

```yaml
volumes:
  static_volume:
  media_volume:
  postgres_data:
  redis_data:
  caddy_data:
  caddy_config:
```
- **What it does**: Defines persistent storage areas
- **Why**: These volumes store data that should persist even when containers are removed
  - `static_volume`: Django static files (CSS, JS, images)
  - `media_volume`: User-uploaded files
  - `postgres_data`: Database files
  - `redis_data`: Cache data
  - `caddy_data` and `caddy_config`: Caddy server data and configuration

## How It All Works Together

1. When you run `docker-compose up`:
   - Docker creates all the containers, networks, and volumes
   - The database (PostgreSQL) and Redis start first
   - Once they're healthy, the web application (Django) starts
   - Caddy starts and acts as a reverse proxy, forwarding requests to the Django app
   - Mailhog starts to capture emails

2. When a user visits your website:
   - The request goes to Caddy (port 80/443)
   - Caddy serves static files directly
   - For dynamic content, Caddy forwards the request to the Django app
   - Django processes the request, possibly using the database and Redis
   - If Django sends an email, it goes to Mailhog in development

This architecture separates concerns, making your application more scalable and easier to maintain.
