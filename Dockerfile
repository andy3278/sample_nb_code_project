# Use the official Python image as a base image
FROM python:3.9-slim

# Set a working directory
WORKDIR /app

RUN apt-get update --yes && \
    apt-get upgrade --yes && \
    apt-get install --yes --no-install-recommends \
    # - apt-get upgrade is run to patch known vulnerabilities in apt-get packages as
    #   the python base image may be rebuilt too seldom sometimes (less than once a month)
    # required for psutil python package to install
    python3-dev \
    gcc && \
    apt-get clean 
# Copy the requirements file into the container
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt 

# Copy the src directory and other necessary files into the container
COPY src/ ./src/

# Expose port 8050 for the Dash app (based on the Makefile content)
EXPOSE 8050

# Specify the default command to run the Dash app
CMD ["python", "src/app.py"]
