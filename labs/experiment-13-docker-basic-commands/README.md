# Experiment 13: Basic Docker Commands

## Objective
Practice pulling images, running containers, listing, stopping, removing, and building from Dockerfile.

## Step-by-step Commands (PowerShell)

```powershell
# 1) Check Docker installation
docker --version

# 2) Pull Ubuntu image
docker pull ubuntu

# 3) Verify images
docker images

# 4) Run Ubuntu container in interactive mode
docker run -it --name exp13-ubuntu ubuntu
# Inside container, run:
#   cat /etc/os-release
# Then exit:
#   exit

# 5) List containers
docker ps
docker ps -a

# 6) Restart and stop container
docker start exp13-ubuntu
docker stop exp13-ubuntu

# 7) Remove container
docker rm exp13-ubuntu

# 8) Build custom image from Dockerfile in this folder
cd .\labs\experiment-13-docker-basic-commands
docker build -t mycustomimage .

# 9) Run custom image
docker run --rm mycustomimage

# 10) Optional cleanup image
docker rmi mycustomimage
```

## Expected Result
- Ubuntu container starts and can be stopped/removed.
- Custom image runs and prints `Hello, Docker!`.
