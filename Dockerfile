# 1. Use an official Python image
FROM python:3.12

# 2. Set the working directory inside the container
WORKDIR /app

# 3. Copy application files to the container
COPY . .

# 4. Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# 5. Expose the default Django port
EXPOSE 8000

# 6. Start the Django server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Make sure static files are copied into the container
VOLUME /app/static

# Copy static files
COPY ./static /app/static
