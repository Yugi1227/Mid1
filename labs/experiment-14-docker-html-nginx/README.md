# Experiment 14: Deploy Simple HTML Page with Docker (Nginx)

## Step-by-step Commands (PowerShell)

```powershell
# 1) Move to this experiment folder
cd .\labs\experiment-14-docker-html-nginx

# 2) Build image
docker build -t my-html-app .

# 3) Run container and map localhost:8080 to container:80
docker run -d -p 8080:80 --name my-html-app-container my-html-app

# 4) Verify container is running
docker ps
```

Open http://localhost:8080

## Stop, Remove, and Optional Cleanup

```powershell
# Stop and remove container
docker stop my-html-app-container
docker rm my-html-app-container

# Optional: remove image
docker rmi my-html-app
```

## Expected Result
- Browser shows the page served by Nginx from inside Docker.
