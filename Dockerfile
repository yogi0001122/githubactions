# Use a more recent Ubuntu version
FROM ubuntu:20.04

# Avoid prompts during package installation
ARG DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
       software-properties-common \
       curl \
       build-essential \
       libpq-dev \
       libffi-dev \
       libxml2-dev \
       libxslt1-dev \
       zlib1g-dev \
       python3-pip \
       python3-dev \
       python3-setuptools \
    && add-apt-repository -y ppa:deadsnakes/ppa \
    && apt-get update -y \
    && apt-get install -y --no-install-recommends python3.6-dev \
    # Cleanup to reduce image size
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /flaskapp

# Copy only the requirements.txt initially to leverage Docker cache
COPY requirements.txt /flaskapp/

# Install Python dependencies
RUN python3 -m pip install --upgrade pip \
    && pip install -r requirements.txt

# Copy the rest of the application code
COPY. /flaskapp

# Create a symbolic link for python command if necessary
RUN rm -f /usr/bin/python \
    && ln -s /usr/bin/python3.6 /usr/bin/python

# The command to run the application
CMD ["python", "manage.py", "run"]
