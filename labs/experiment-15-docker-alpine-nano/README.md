# Experiment 15: Alpine Image with Nano

## Aim
Build an Alpine Docker image with the Nano text editor installed.

## Run

```powershell
.\run.ps1
```

## Try Nano Interactively

```powershell
docker run -it --rm exp15-alpine-nano
```

Inside the container:

```sh
nano --version
exit
```

## Expected Result
Nano version details are displayed.
