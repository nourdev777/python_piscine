# python_piscine/Dockerfile

FROM python:3.10-slim

WORKDIR /app

COPY . .

CMD ["python"]