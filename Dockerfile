FROM python:3.9

# Set the working directory
WORKDIR /app

# Install nodejs
RUN apt update && \
    apt install -y nodejs npm && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Docker CLI using the official Docker installation script
RUN curl -fsSL https://get.docker.com -o get-docker.sh && \
    sh get-docker.sh

# Copy the application code
# Do this last to take advantage of the docker layer mechanism
COPY . /app

# Set environment variables
ENV LANGSMITH_API_KEY=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

# Install Python dependencies
RUN pip install -e '.'

# Install react dependencies ahead of time
RUN cd sweagent/frontend && npm install
