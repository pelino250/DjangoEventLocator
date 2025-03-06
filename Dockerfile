# get base image
FROM python:3.12

# set working directory
WORKDIR /app

# copy all files from current directory to working directory
COPY . .

# install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# django commands to run when the container starts
#CMD ["python", "manage.py", "runserver",]
