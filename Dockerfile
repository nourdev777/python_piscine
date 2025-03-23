# python_piscine/Dockerfile

# image
FROM python:3.10-slim

# Working directory inside the container
WORKDIR /app

# Copy all project files to the container
COPY . .

# Set the command to run Python
CMD ["python"]