FROM alpine:3.18

RUN apk add --no-cache openssh bash

# Copies the entrypoint.sh file from the repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Make the bash script executable
RUN chmod +x /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
