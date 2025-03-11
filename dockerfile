# Use the official Python image as a base image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt /app/

# Install any dependencies from the requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application files
COPY . /app/

# Expose port 8000 to access the app from outside the container
EXPOSE 8000

# Set environment variable to tell Django to not use the debug mode in production
ENV DJANGO_SETTINGS_MODULE=myproject.settings.production

# Run migrations and then start the Django application
CMD ["sh", "-c", "python manage.py migrate && python manage.py runserver 0.0.0.0:8000"]
