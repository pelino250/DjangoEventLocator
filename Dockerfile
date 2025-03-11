# get base image
FROM python:3.12

# set working directory
WORKDIR /app

# copy requirements first to leverage Docker cache
COPY requirements.txt .

# install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# copy all files from current directory to working directory
COPY . .

# create static and media directories
RUN mkdir -p /app/staticfiles /app/media

# collect static files
RUN python manage.py collectstatic --noinput

EXPOSE 8000

# Use gunicorn for production
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "--workers", "3", "DjangoEventLocator.wsgi:application"]
