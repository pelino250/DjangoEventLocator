FROM python:3.13

WORKDIR /app

COPY ..

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 5000

CMD ["python", "manage.py", "runserver", "0.0.0.0.5000"]