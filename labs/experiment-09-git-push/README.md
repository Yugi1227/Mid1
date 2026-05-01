# Experiment 09: Push Local Repository to GitHub

## Objective
Push committed changes from a local Git repository to a remote GitHub repository.

## Prerequisites
- Git installed
- GitHub account

## Runnable Local Demo

This demo creates a local bare repository and pushes to it. It proves the same Git workflow without needing GitHub credentials.

```powershell
.\run.ps1
```

## Commands (Windows PowerShell)

```powershell
# 1) Configure Git (first time only)
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# 2) Create local project and initialize git
mkdir MyProject
cd MyProject
git init

# 3) Create file and commit
"Hello, Git!" | Out-File -FilePath file.txt -Encoding utf8
git add file.txt
git commit -m "Initial commit"

# 4) Create repository on GitHub and copy URL, then add remote
git remote add origin https://github.com/<your-username>/<your-repo>.git

# 5) Push to GitHub
git branch -M main
git push -u origin main
```

## Expected Result
- Repository appears on GitHub.
- file.txt is visible in the main branch.
- Local demo prints a clean `main...origin/main` status after push.
