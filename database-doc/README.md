# Cafe Management System - Database Documentation

This README provides a comprehensive overview of the **database design** for the Cafe Management System, including its schema, workflows, access control, and setup instructions.

## 📁 Database Name: `cafe_management`

This system is designed for managing a cafe chain with multiple branches. It powers operations related to branches, staff, menu, orders, payments, authentication, and customer memberships.
It includes:
- Clearly defined relationships
- Role-based access control
- Extendable functionality for full-stack integration

📌 View the ER Diagram: database-doc/ ERD-JPG.jpg
---

## 📌 Requirements
- MySQL Server version 8.0.42 or later
- MySQL Workbench or any SQL-compatible client for running queries and visualizing schema
- Required files:
    - create_tables.sql (located in backend/src/main/resources/database)
    - sample-values.sql (located in backend/src/main/resources/database)
---

## ⚙️ Setup Instructions
- Clone the Repository
- Ensure MySQL is Running
    - Start MySQL Server locally (check MySQL Workbench or services).
    - Make sure the default port 3306 is accessible.
- Run SQL Scripts in Order
    - Import using MySQL Workbench:
        - Open Workbench → Open SQL file → Run
            1. create_tables.sql
            2. sample-values.sql
    - Or use the terminal:
        - ```bash
                mysql -u <username> -p < create_tables.sql
                mysql -u <username> -p < sample-values.sql
---

## 📊 Database Tables Overview

### 1. `Branches`
Stores details about each cafe branch.

| Column Name   | Data Type    | Description                          |
|---------------|--------------|------------------------------------- |
| Branch_id     | VARCHAR(10)  | Unique identifier for the branch (PK)|
| Location      | VARCHAR(255) | Physical location of the branch      |
| Email         | VARCHAR(100) | Branch email address                 |
| Phone_number  | VARCHAR(20)  | Branch contact number                |
| Manager_id    | VARCHAR(10)  | FK to `Staff.Staff_id`               |

- The `Manager_id` links to a staff member.
- Can only be set after the `Staff` table is populated.


### 2. `Staff`
Stores all employees and their roles.

| Column Name    | Data Type    | Description                            |
|----------------|--------------|----------------------------------------|
| Staff_id       | VARCHAR(10)  | Unique identifier (PK)                 |
| Name           | VARCHAR(255) | Full name of the staff member          |
| National_ID_no | VARCHAR(255) | National ID (must be unique & not null)|
| Position       | VARCHAR(100) | Staff position                         |
| Email          | VARCHAR(100) | Staff email                            |
| Phone_number   | VARCHAR(20)  | Staff contact number                   |
| Branch_id      | VARCHAR(10)  | FK to `Branches.Branch_id`             |
| Address        | TEXT         | Address of the staff                   |

- Unique and not null constraint on `National_ID_no`.


### 3. `Staff_Auth`
Handles login credentials for staff.

| Column     | Type         | Description                          |
|------------|--------------|--------------------------------------|
| Staff_id   | VARCHAR(30)  | Part of (PK), FK to `Staff(Staff_id)`|
| Password   | VARCHAR(255) | Password (encrypted, required)       |


### 4. `Menu`
Menu items offered at each branch.

| Column      | Type         | Description               |
|-------------|--------------|---------------------------|
| item_id     | VARCHAR(10)  | Primary Key               |
| item_name   | VARCHAR(255) | Name of the menu item     |
| Description | TEXT         | Description of the item   |
| Picture     | VARCHAR(255) | Path/URL to item image    |
| Branch_id   | VARCHAR(10)  | FK → `Branches(Branch_id)`|
| Quantity    | INT          | Stock count               |
| Price       | DECIMAL(10,2)| Price per item            |


### 5. `Membership`
Customer loyalty program table.

| Column         | Type          | Description                 |
|----------------|---------------|-----------------------------|
| Phone_number   | VARCHAR(15)   | (PK)                        |
| Customer_name  | VARCHAR(255)  | Customer name (**Not Null**)|
| Email          | VARCHAR(100)  | Optional email              |
| National_ID_no | VARCHAR(255)  | **Unique, Not Null**        |
| Points         | INT           | Default: 0                  |
| Branch_id      | VARCHAR(10)   | FK → Branches(Branch_id)    |

- Can only be modified by a Manager.
- Useful for discounts and reward tracking.
- 1 point per 500 rupees spent
- Points reset to 0 on Dec 31 every year.

### 6. `Orders`
Stores all order records.

| Column          | Type          | Description                               |
|-----------------|---------------|-------------------------------------------|
| order_id        | VARCHAR(15)   | (PK)                                      |
| Staff_id        | VARCHAR(30)   | FK → Staff(Staff_id)                      |
| Order_time      | TIMESTAMP     | Defaults to current timestamp             |
| Total_amount    | DECIMAL(10,2) | Total before any points                   |
| Phone_number    | VARCHAR(15)   | **Optional** FK → Membership(Phone_number)|
| Order_Completed | BOOLEAN       | Default: `FALSE`                          |

- `Ordered_Items` are only populated after payment is marked as `'Paid'`.
- Once **all ordered items are marked as delivered**, the order `status` is updated to **'Completed'**.


### 7. `Ordered_Items`
Links menu items to orders and tracks delivery status.

| Column       | Type         | Description                                  |
|--------------|--------------|----------------------------------------------|
| order_id     | VARCHAR(15)  | Composite PK, FK → Orders(order_id)          |
| item_id      | VARCHAR(10)  | Composite PK, FK → Menu(item_id)             |
| Quantity     | INT          | Quantity of that item in the order           |
| Delivered    | BOOLEAN      | Whether this specific item has been delivered|

- Composite Primary Key: `(order_id, item_id)`
- Once all items in an order are delivered, the parent order's status becomes `'Completed'`.
    - This update is typically handled via backend logic after checking all `Delivered = TRUE`.


### 8. `Payments`
Tracks payment transactions for orders.

| Column Name    | Data Type     | Description                         |
|----------------|---------------|-------------------------------------|
| payment_id     | VARCHAR(15)   | Unique payment ID (PK)              |
| order_id       | VARCHAR(15)   | FK to Orders(order_id)              |
| Amount         | DECIMAL(10,2) | Total order amount before deductions|
| Paid_on        | TIMESTAMP     | Date and time of payment            |
| Payment_method | VARCHAR(50)   | Method used (e.g., Cash, Card)      |
| Used_Points    | INT           | Points redeemed                     |
| Final_Amount   | DECIMAL(10,2) | Final amount after point deductions |

---


## ✅ Workflow Summary

1. Staff logs in via `Staff_Auth`
2. Creates an `Order`
3. Enters `Payment` → system checks status
4. If `Success`, data entered into `Ordered_Items`
5. If loyalty member, points updated in `Membership`
6. Membership changes (edit/delete) require manager authentication
7. Delivery status of each item tracked via `Ordered_Items`  
   → When all items are delivered, the `Orders.status` is updated to `"Completed"`
---


## 🔐 Access Control & Role-Based Permissions

- **Managers:**
  - Full access to **all tables**.
  - Can **view, add, edit, and delete** entries in:
    - `Branches`, `Staff`, `Staff_Auth`, `Menu`, `Orders`, `Ordered_Items`, `Payments`, and `Membership`.
  - Assist staff with privileged operations by authenticating (e.g., `Membership` edits).
  - View and reset loyalty points at the end of the year (**December 31st**).

- **Staff:**
  - Can **view and update** their own records in:
    - `Staff`, `Staff_Auth`.
  - Staff in roles such as **Cashier** can:
    - Add entries to `Orders`, `Ordered_Items`, `Payments`, and `Membership`.
    - However, **manager authentication is required** to:
      - Edit any `Membership` data.
      - Finalize membership redemptions or changes.

> ⚠️ All actions on sensitive tables like `Membership` require a manager to input their password as a form of confirmation.
---

## 📆 Loyalty Points Policy

- Earning Rate: Customers earn 1 point per LKR 250 spent (rounded down).
- Points are stored in the `Membership` table.
- Redemption Policy:
  - Loyalty points can be used to pay for future purchases.
  - 1 point = LKR 1 value.
- Usage Rules:
  - If the customer wants to redeem points, the system checks available balance.
  - Maximum redeemable points = bill total in LKR.
  - Points are deducted after a successful redemption.
- Points **expire on December 31st** each year and reset to `0`.
---

## 📱 Member Verification During Order Placement

When placing an order, the following logic applies if the customer is a member:

- 🔍 Step-by-Step Logic

    1. **Check for Membership:**
    - The system prompts the staff to enter the **customer's phone number**.
    - The number is validated against the `Membership` table.
    - If matched, the customer is treated as a **member**, and their details (e.g., Points) are retrieved.

    2. **Save Member Info (If Applicable):**
    - The `Phone_number` is saved in the `Orders` table as a foreign key reference to `Membership`.

    3. **If the Customer Wants to Use Membership Points:**
    - An **OTP (One-Time Password)** is generated and sent to the member's **registered phone number**.
    - **Only a Manager** can **trigger** this OTP request.
        - The system checks the currently logged-in staff's `Position` via the `Staff_Auth` table.
        - If not a Manager, OTP functionality is disabled.

    4. **OTP Verification:**
    - The customer provides the OTP received.
    - If valid:
        - Points are applied.
        - The `Used_Points` and `Final_Amount` are saved in the `Payments` table.
    - If invalid or expired:
        - Points cannot be redeemed.

    5. **Without OTP:**
    - The customer can still proceed with the order.
    - However, **membership points will not be applied**.

- ✅ Key Database Connections

    - `Orders.Phone_number` → (FK) `Membership.Phone_number`
    - `Payments.Used_Points` and `Final_Amount` are used **only if OTP verification is successful**.
    - `Staff_Auth` → used to check whether the logged-in user is a **Manager**.

- 🔐 Security Notes
    - OTPs expire after a short duration (e.g., 5 minutes).
    - Only users with `Position = 'Manager'` in the `Staff` table can initiate OTP flow.
---

## 🔁 Table Relationships

| From Table        | To Table           | Type              | Description                                 |
|-------------------|--------------------|-------------------|---------------------------------------------|
| `Branches`        | `Staff`            | One-to-Many       | A branch has many staff                     |
| `Branches`        | `Menu`             | One-to-Many       | A branch has many menu items                |
| `Branches`        | `Membership`       | One-to-Many       | A branch has many members                   |
| `Staff`           | `Branches`         | One-to-One        | A manager is linked back to branch          |
| `Staff`           | `Orders`           | One-to-Many       | Staff places many orders                    |
| `Orders`          | `Payments`         | One-to-One        | Each order has one payment                  |
| `Orders`          | `Ordered_Items`    | One-to-Many       | An order includes many items                |
| `Menu`            | `Ordered_Items`    | One-to-Many       | An item can appear in many orders           |
| `Staff` + `Position` | `Staff_Auth`    | One-to-One        | Staff has one login account                 |
---

## 🧪 Sample Data

Refer to `sample-values.sql` to populate two entries per table for testing.
- A staff logs in via `Staff_Auth`, then proceeds to create orders and manage payments based on their role.
- Payment is recorded in `Payments`.
- If successful, items are recorded in `Ordered_Items`.
- A Manager can register a new member in the Membership table.
- Primary keys are manually assigned and not auto-incremented.
- Passwords must be stored in hashed form for security.
- Staff and Members must provide a valid phone number, and optionally an email for members.
---

## ✅ Notes

- All `IF NOT EXISTS` used to avoid duplicate creation.
- Manager should be inserted first as staff, then linked in `Branches`.
- Composite Keys are used
- Passwords must be stored in hashed form for security.
- Foreign Keys enforce relationships and data integrity.
- Images are referenced via file paths using VARCHAR(255) in the Picture column.
- Create Database : CREATE DATABASE cafe_management;
- Use the Database : USE cafe_management; //It selects the database so that any subsequent SQL commands (like creating tables, inserting data, or querying) will apply to that specific database.
- Run the Table Creation Script : schema.sql, and execute it in MySQL Workbench or any SQL editor.
| Command                | Purpose                           |
| ---------------------- | --------------------------------- |
| `CREATE DATABASE ...;` | Creates a new database            |
| `USE cafe_management;` | Sets it as the current working DB |
| `CREATE TABLE ...;`    | Creates tables inside the DB      |
---

## 📌 Future Enhancements (Optional)

- Manager authentication pop-up for sensitive staff actions
- PDF bills and member transaction history
- Membership QR codes
- Dashboard analytics for managers
---

## 👩‍💻 Author

- **Venuja Shanmugarajah**  

--- 