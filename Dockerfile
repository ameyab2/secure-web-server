# Use the official Python image from the Docker Hub
FROM python:3.9-slim

# Install OpenSSL
RUN apt-get update && apt-get install -y openssl

# Create a non-root user
RUN useradd -ms /bin/bash nonrootuser

# Set the working directory
WORKDIR /app

# Copy the server script and certificates into the container
COPY server.py /app/
COPY cert.pem /app/
COPY key.pem /app/

# Change the ownership of the application files to the non-root user
RUN chown -R nonrootuser:nonrootuser /app

# Switch to the non-root user
USER nonrootuser

# Expose the required port
EXPOSE 4443

# Run the application
CMD ["python", "server.py"]
