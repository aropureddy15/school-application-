# School Application - Spring Boot + MySQL RDS

## Project structure

school-app/
├── pom.xml
├── Dockerfile
├── .dockerignore
├── .gitignore
├── README.md
├── database/
│   └── schooldb.sql
└── src/
    └── main/
        ├── java/com/example/school/
        │   ├── SchoolApplication.java
        │   ├── controller/StudentController.java
        │   ├── entity/Student.java
        │   └── repository/StudentRepository.java
        └── resources/
            ├── application.properties
            └── application-local.properties

## 1. Create the database

Connect to your AWS RDS MySQL instance and run:

    source database/schooldb.sql

Or execute the SQL manually from the file.

## 2. Set environment variables

Linux:

    export DB_HOST="YOUR-RDS-ENDPOINT"
    export DB_PORT="3306"
    export DB_NAME="schooldb"
    export DB_USERNAME="admin"
    export DB_PASSWORD="YOUR_PASSWORD"

Windows PowerShell:

    $env:DB_HOST="YOUR-RDS-ENDPOINT"
    $env:DB_PORT="3306"
    $env:DB_NAME="schooldb"
    $env:DB_USERNAME="admin"
    $env:DB_PASSWORD="YOUR_PASSWORD"

Do not commit your real password to GitHub.

## 3. Build

    mvn clean package

## 4. Run

    mvn spring-boot:run

Or:

    java -jar target/school-app-0.0.1-SNAPSHOT.jar

Application:

    http://localhost:8080

## 5. APIs

GET all students:

    GET /api/students

GET one student:

    GET /api/students/1

Create:

    POST /api/students

Example JSON:

    {
      "name": "Krishna",
      "age": 15,
      "grade": "10th",
      "email": "krishna@example.com"
    }

Update:

    PUT /api/students/1

Delete:

    DELETE /api/students/1

## 6. RDS security group

The RDS security group should allow:

    TCP 3306
    Source: Application Server Security Group

Avoid:

    0.0.0.0/0

for production database access.

## 7. Docker

Build:

    mvn clean package
    docker build -t school-app:1.0 .

Run:

    docker run -d       --name school-app       -p 8080:8080       -e DB_HOST="YOUR-RDS-ENDPOINT"       -e DB_PORT="3306"       -e DB_NAME="schooldb"       -e DB_USERNAME="admin"       -e DB_PASSWORD="YOUR_PASSWORD"       school-app:1.0

## Architecture

User
  |
  v
Load Balancer / API
  |
  v
Spring Boot Java Application
  |
  | JDBC / TCP 3306
  v
AWS RDS MySQL

For a DevOps deployment:

GitHub
  |
  v
Jenkins CI
  |
  +--> Maven Build/Test
  +--> SonarQube
  +--> Trivy
  +--> Docker Build
  +--> Push to ECR
  |
  v
Jenkins CD / Argo CD
  |
  v
AWS EKS
  |
  v
Spring Boot Application
  |
  v
AWS RDS MySQL
