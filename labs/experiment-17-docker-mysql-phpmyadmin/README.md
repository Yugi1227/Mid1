# Experiment 17: Deploy MySQL with phpMyAdmin (Docker)

## Option A: Docker Compose (Recommended)

```powershell
# 1) Move to this experiment folder
cd .\labs\experiment-17-docker-mysql-phpmyadmin

# 2) Start services
docker compose up -d

# 3) Verify services
docker compose ps
```

Open http://localhost:8080

Login:
- Username: root
- Password: root

Run this SQL in phpMyAdmin (SQL tab):

```sql
USE mydb;
CREATE TABLE students (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50),
  age INT
);
INSERT INTO students (name, age) VALUES ('Alice', 21), ('Bob', 22);
SELECT * FROM students;
```

Stop and cleanup:

```powershell
docker compose down

# Optional: remove named volume too
docker compose down -v
```

## Option B: Manual docker commands

```powershell
# 1) Create network
docker network create mynetwork

# 2) Start MySQL container
docker run --name mysql-container --network mynetwork -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=mydb -d mysql:latest

# 3) Start phpMyAdmin container
docker run --name phpmyadmin-container --network mynetwork -d -e PMA_HOST=mysql-container -p 8080:80 phpmyadmin/phpmyadmin

# 4) Verify containers
docker ps

# 5) Open phpMyAdmin in browser
# http://localhost:8080
```

Manual cleanup:

```powershell
docker stop mysql-container phpmyadmin-container
docker rm mysql-container phpmyadmin-container
docker network rm mynetwork
```

## Expected Result
- MySQL and phpMyAdmin run together.
- You can create a table and query rows from phpMyAdmin.
