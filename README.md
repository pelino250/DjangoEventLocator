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

- **Web Application**: http://localhost (served by Caddy)
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
- Configure ALLOWED_HOSTS in .env
- Set up proper SSL/TLS certificates (Caddy can handle this automatically)
- Consider using a managed database service instead of the containerized PostgreSQL
