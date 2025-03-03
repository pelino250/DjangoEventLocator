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
- SQLite database
- Python 3.x

## Installation

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
   - Create a `.env` file in the project root
   - Add your email configuration:
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

## Configuration

### Email Setup

The application uses Gmail SMTP for email notifications. To configure:

1. Enable 2-factor authentication in your Google account
2. Generate an App Password
3. Use these credentials in your `.env` file

### Static Files

Static files are configured to be served from the `static` directory. To collect static files:

```bash
python manage.py collectstatic
```

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

## Security Notes

For production deployment:
- Change the SECRET_KEY in settings.py
- Set DEBUG = False
- Configure proper database settings
- Set up proper email configuration
- Configure ALLOWED_HOSTS
