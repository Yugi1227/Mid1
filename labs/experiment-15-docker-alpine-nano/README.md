# Experiment 15: Build Alpine Image with Nano

## Step-by-step Commands (PowerShell)

```powershell
# 1) Move to this experiment folder
cd .\labs\experiment-15-docker-alpine-nano

# 2) Build image
docker build -t alpine-nano .

# 3) Run container interactively
docker run -it --name nano-container alpine-nano
```

## Commands Inside Container

```sh
# Verify nano installation
nano --version

# Create and edit file
nano testfile.txt

# Verify saved content
cat testfile.txt

# Exit container
exit
```

## Cleanup (PowerShell)

```powershell
docker rm nano-container
docker rmi alpine-nano
```

## Expected Result
- Nano is installed and usable in the Alpine-based container.
