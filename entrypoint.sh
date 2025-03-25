#!/bin/bash

# Apply database migrations
echo "Applying database migrations..."
python manage.py migrate

# Start the application
echo "Starting application..."
exec "$@"