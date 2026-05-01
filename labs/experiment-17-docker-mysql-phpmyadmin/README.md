# Experiment 17: MySQL with phpMyAdmin

## Aim
Run MySQL and phpMyAdmin together using Docker Compose.

## Run

```powershell
.\run.ps1
```

## Open

Visit `http://localhost:8081`.

Login:

- Username: `root`
- Password: `root`

## Stop

```powershell
docker compose down
```

## Expected Result
phpMyAdmin opens and shows the `mydb` database with a sample `students` table.
