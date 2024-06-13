# Use the python:3.9-slim image as the base
FROM python:3.9-slim

# Set the working directory
WORKDIR /app

# Copy the requirements.txt file into the working directory
COPY requirements.txt .

# Install the dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the service package into the working directory
COPY service /app/service

# Switch to a non-root user
RUN useradd --uid 1000 theia && chown -R theia /app
USER theia

# Switch to the theia user
USER theia

# Expose port 8080
EXPOSE 8080

# Set the command to run the application
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "
