# Experiment 16: Run MySQL in Docker and Execute Queries

## Step-by-step Commands (PowerShell)

```powershell
# 1) Pull MySQL image
docker pull mysql:latest

# 2) Run MySQL container
docker run --name mysql-container -e MYSQL_ROOT_PASSWORD=root -d -p 3306:3306 mysql:latest

# 3) Verify container is running
docker ps

# 4) Check MySQL startup logs (optional)
docker logs mysql-container --tail 30
```

## Method A: Connect Interactively and Run SQL

```powershell
docker exec -it mysql-container mysql -uroot -proot
```

Then run this SQL inside MySQL shell:

```sql
SHOW DATABASES;
CREATE DATABASE student_db;
USE student_db;
CREATE TABLE students (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50),
  age INT
);
INSERT INTO students (name, age) VALUES ('John Doe', 22);
SELECT * FROM students;
```

## Method B: Run SQL from File (Non-interactive)

```powershell
docker exec -i mysql-container mysql -uroot -proot < .\labs\experiment-16-docker-mysql-queries\queries.sql
```

## Stop, Remove, and Optional Cleanup

```powershell
docker stop mysql-container
docker rm mysql-container

# Optional: remove image
docker rmi mysql:latest
```

## Expected Result
- MySQL container starts successfully.
- `students` table is created and query returns inserted row(s).
