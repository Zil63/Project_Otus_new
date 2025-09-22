FROM python:3.12-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY app.py .
ENV DB_HOST=database \
    DB_USER=root \
    DB_PASS=${DB_ROOT_PASSWORD} \
    DB_NAME=${DB_NAME}
EXPOSE 8000
CMD ["gunicorn", "-b", "0.0.0.0:8000", "app:app"]
