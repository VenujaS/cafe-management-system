USE cafe_management;
-- Create Tables

-- Branches Table
CREATE TABLE IF NOT EXISTS Branches (
    Branch_id VARCHAR(10),
    Location VARCHAR(255),
    Email VARCHAR(100),
    Phone_number VARCHAR(20),
    Manager_id VARCHAR(30),
    PRIMARY KEY (Branch_id)
);

-- Staff Table (Updated: Staff_id is sole PK, FK includes ON DELETE/UPDATE)
CREATE TABLE IF NOT EXISTS Staff (
    Staff_id VARCHAR(30) PRIMARY KEY,
    Name VARCHAR(255),
    National_ID_no VARCHAR(255) UNIQUE NOT NULL,
    Position VARCHAR(100),
    Email VARCHAR(100),
    Phone_number VARCHAR(20),
    Branch_id VARCHAR(10),
    Address TEXT,
    FOREIGN KEY (Branch_id) REFERENCES Branches(Branch_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- Link Manager_id after Staff is defined (RUN ONCE)
ALTER TABLE Branches
ADD CONSTRAINT fk_manager
FOREIGN KEY (Manager_id) REFERENCES Staff(Staff_id);

-- Staff_Auth Table (Updated: matches new Staff PK)
CREATE TABLE IF NOT EXISTS Staff_Auth (
    Password VARCHAR(255) NOT NULL,
    Staff_id VARCHAR(30) PRIMARY KEY,
    FOREIGN KEY (Staff_id) REFERENCES Staff(Staff_id)
);

-- Menu Table
CREATE TABLE IF NOT EXISTS Menu (
    item_id VARCHAR(10),
    item_name VARCHAR(255),
    Description TEXT,
    Picture VARCHAR(255),
    Branch_id VARCHAR(10),
    Quantity INT,
    Price DECIMAL(10,2),
    PRIMARY KEY (item_id),
    FOREIGN KEY (Branch_id) REFERENCES Branches(Branch_id)
);

-- Membership Table (for customers, accessible only by managers)
CREATE TABLE IF NOT EXISTS Membership (
    Customer_name VARCHAR(255) NOT NULL,
    Phone_number VARCHAR(15) UNIQUE NOT NULL,
    Email VARCHAR(100),  -- Optional field
    National_ID_no VARCHAR(255) UNIQUE NOT NULL,
    Points INT DEFAULT 0,
    Branch_id VARCHAR(10),
    PRIMARY KEY (Phone_number),
    FOREIGN KEY (Branch_id) REFERENCES Branches(Branch_id)
);

-- Orders Table (Updated: Staff_id is now valid FK; Phone_number optional)
CREATE TABLE IF NOT EXISTS Orders (
    order_id VARCHAR(15),
    Staff_id VARCHAR(30),
    Order_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Total_amount DECIMAL(10, 2),
    Phone_number VARCHAR(15), -- Nullable; used only for members
    Order_Completed BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (order_id),
    FOREIGN KEY (Staff_id) REFERENCES Staff(Staff_id),
    FOREIGN KEY (Phone_number) REFERENCES Membership(Phone_number)
);

-- Ordered_Items Table
CREATE TABLE IF NOT EXISTS Ordered_Items (
    order_id VARCHAR(15),
    item_id VARCHAR(10),
    Quantity INT,
    Delivered BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (order_id, item_id),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (item_id) REFERENCES Menu(item_id)
);

-- Payments Table
CREATE TABLE IF NOT EXISTS Payments (
    payment_id VARCHAR(15),
    order_id VARCHAR(15),
    Amount DECIMAL(10,2),
    Paid_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Payment_method VARCHAR(50),
    Used_Points INT DEFAULT 0,
    Final_Amount DECIMAL(10,2),
    PRIMARY KEY (payment_id),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);
