# cafe-management-system

Full-stack Cafe Management System using Spring Boot and MySQL

---

## 🚀 Features

- 📋 Manage Menu (add/update/delete items)
- 🖼️ Upload images for menu items
- 📍 Manage Branches and Staff
- 📦 Track Orders and Ordered Items
- 👥 Membership system (points-based)
- 🔒 Role-based login (via `Staff_Auth` table)
- 📊 Optional: Admin dashboard and analytics

---

## ⚙️ Tech Stack

  ### 🔹 Backend (Java)
  - Java 21
  - Spring Boot
  - Spring Data JPA
  - REST API
  - File Upload (Image storage)
  - MySQL Connector

  ### 🔹 Frontend (React)
  - React.js
  - Axios for API calls
  - Component-based structure
  - Image preview and upload

  ### 🔹 Database
  - MySQL
  - SQL Scripts for schema & sample data

---
## 🛠️ Setup Instructions

  ### 1. Clone the Project

  ```bash
  git clone https://github.com/VenujaS/cafe-management-system.git
  ```

  ### 2. Backend Setup

  - Import into your preferred Java IDE.
  - Make sure **MySQL** is running.
  - Create database and run `schema.sql` + `sample-values.sql` (or let Spring Boot handle it).
  - Configure DB in `application.properties`:

  ```properties
  spring.datasource.url=jdbc:mysql://localhost:3306/cafe_db
  spring.datasource.username=root
  spring.datasource.password=your_password
  ```

  - Run the application:

  ```bash
  ./gradlew bootRun
  ```

  ### 3. Frontend Setup

  ```bash
  cd frontend
  npm install
  npm start
  ```

  Frontend runs on `http://localhost:3000` and connects to backend at `http://localhost:8080`.

---

## 📁 Folder Structure

```
cafe-management-system/
├── backend/                      # Spring Boot Application
│   ├── build.gradle
│   ├── src/main/
│   │   ├── java/com/venuja_cafe/cafe_management/
│   │   │   ├── controller/       # Handles REST API and file uploads
│   │   │   ├── model/            # Entity classes (e.g. Menu.java)
│   │   │   ├── repository/       # JPA Repositories
│   │   │   └── service/          # Business logic
│   │   └── resources/
│   │       ├── application.properties
│   │       └── database/
│   │           ├── create_database.sql
│   │           ├── create_tables.sql
│   │           └── sample-values.sql
│   └── uploads/                 # Uploaded images (e.g. cakes, drinks)
│       ├── cakes/
│       └── drinks/
│
├── frontend/                    # React Application
│   ├── public/
│   └── src/
│       ├── components/
│       │   └── Menu/            # MenuList & AddMenuItem with image upload
│       └── services/
│           └── api.js           # Axios-based API calls
│
├── database-docs/              
│   ├── ERD.mwb
│   ├── ERD-JPG.jpg
│   └── README.md
│
├── .gitignore
└── README.md
```
---

## 📷 Image Upload Logic

- Backend stores image **files** in `uploads/` folder.
- File **paths** are saved in the DB as `VARCHAR` fields.
- React form sends image via `multipart/form-data`.

---

## 📜 Sample SQL Files

Located at `backend/src/main/resources/database/`:
- `schema.sql` – Database schema
- `sample-values.sql` – Dummy values for testing

---

## 📄 License

MIT License.

---

## 👩‍💻 Author

- **Venuja Shanmugarajah**  
  Passionate about full-stack development | Sri Lanka 🇱🇰  
  💬 Let's connect: [LinkedIn](https://www.linkedin.com/in/venuja-shanmugarajah-432aa41ba)

---
