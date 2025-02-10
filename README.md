# Mock Amazon Linux 2023 EC2-like Docker Setup

This repository provides a Docker-based setup that closely mimics an Amazon Linux 2023 EC2 instance. It includes configurations to add an `ec2-user`, enable passwordless `sudo`, and set up an SSH server with key-based authentication.

## Features
- Amazon Linux 2023 base image
- `ec2-user` with `sudo` privileges (similar to EC2 instances)
- SSH server setup with key-based authentication
- Custom `entrypoint.sh` for initialization
- Docker Compose configuration for easy deployment

## Prerequisites
- [Docker](https://www.docker.com/get-started) installed
- [Docker Compose](https://docs.docker.com/compose/) installed
- SSH key pair (`id_rsa.pub`) in the build context for authentication

## Setup & Usage
### 1. Generate a new key-pair
The provided keypair is meant as a placeholder and should be replaced when using this repository. A new keypair can be generated with the following command:
```sh
rm ./id_rsa* && ssh-keygen -t rsa -b 4096 -C "mock-ec2-instance" -f id_rsa
```
For quick testing, the default password is `ReplaceMe`.

### 2. Build the Docker Image
Run the following command to build the image:
```sh
 docker compose build
```
This will create an image named `mh_amazon_linux_2023_docker`.

### 3. Run the Container
Start the container using:
```sh
 docker compose up -d
```
This runs the container in detached mode (`-d`), making it persist in the background.

### 4. Connect via SSH
To connect using SSH, use:
```sh
ssh -i id_rsa ec2-user@<container-ip>
```
Find the container IP using:
```sh
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' <container_id>
```
Alternatively, if you expose the SSH port (`-p 2222:22` in `compose.yaml`), connect using:
```sh
ssh -i id_rsa -p 2222 ec2-user@localhost
```

## File Breakdown

### `Dockerfile`
- Uses `amazonlinux:2023` as the base image
- Creates `ec2-user` with sudo privileges
- Sets up an SSH server with key-based authentication
- Copies and executes `entrypoint.sh`

### `entrypoint.sh`
- Runs initialization tasks before starting the main process
- Executes the command passed to the container

### `compose.yaml`
- Defines the service `mock-ec2-instance`
- Builds from `Dockerfile`
- Exposes SSH port for remote access

## Customization
- Modify `entrypoint.sh` to add extra initialization tasks
- Change `compose.yaml` to expose a custom SSH port
- Update the Dockerfile to install additional packages

## Cleanup
To stop and remove the container:
```sh
docker compose down
```

To remove the image:
```sh
docker rmi mh_amazon_linux_2023_docker
```

## Notes
This setup does **not** include cloud-init since it is designed for EC2 VMs, not containers. Instead, the entrypoint script can be used for initialization tasks.

## License
This project is provided under an open-source license. Modify and use it as needed.

