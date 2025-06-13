-- Use the database
USE cafe_management;

-- BRANCHES 
INSERT INTO Branches (Branch_id, Location, Email, Phone_number, Manager_id)
VALUES
  ('BR001', 'Colombo', 'colombo@cafe.com', '0111234567', NULL),
  ('BR002', 'Trincomalee', 'trinco@cafe.com', '0267654321', NULL);

-- STAFF
INSERT INTO Staff (Staff_id, Name, National_ID_no, Position, Email, Phone_number, Branch_id, Address)
VALUES
  -- Colombo Branch Staff
  ('SManager001', 'Manager A', 'NIC001', 'Manager', 'manager.a@cafe.com', '0711111111', 'BR001', '123 A Street'),
  ('SCashier001', 'Cashier A', 'NIC002', 'Cashier', 'cashier.a@cafe.com', '0722222222', 'BR001', '456 B Street'),
  ('SChef001', 'Chef A', 'NIC003', 'Chef', 'chef.a@cafe.com', '0733333333', 'BR001', '789 C Street'),
  ('SWaiter001', 'Waiter A', 'NIC004', 'Waiter', 'waiter.a@cafe.com', '0744444444', 'BR001', '101 D Street'),

  -- Trincomalee Branch Staff
  ('SManager002', 'Manager B', 'NIC005', 'Manager', 'manager.b@cafe.com', '0755555555', 'BR002', '111 E Street'),
  ('SCashier002', 'Cashier B', 'NIC006', 'Cashier', 'cashier.b@cafe.com', '0766666666', 'BR002', '222 F Street'),
  ('SChef002', 'Chef B', 'NIC007', 'Chef', 'chef.b@cafe.com', '0777777777', 'BR002', '333 G Street'),
  ('SWaiter002', 'Waiter B', 'NIC008', 'Waiter', 'waiter.b@cafe.com', '0788888888', 'BR002', '444 H Street');

-- Update Branch to assign manager
UPDATE Branches
SET Manager_id = 'SManager001'
WHERE Branch_id = 'BR001';

UPDATE Branches
SET Manager_id = 'SManager002'
WHERE Branch_id = 'BR002';

-- STAFF_AUTH
INSERT INTO Staff_Auth (Staff_id, Password)
VALUES
  ('SManager001', 'pass001'),
  ('SCashier001', 'pass002'),
  ('SChef001', 'pass003'),
  ('SWaiter001', 'pass004'),
  ('SManager002', 'pass005'),
  ('SCashier002', 'pass006'),
  ('SChef002', 'pass007'),
  ('SWaiter002', 'pass008');

-- MENU
INSERT INTO Menu (item_id, item_name, Description, Picture, Branch_id, Quantity, Price)
VALUES
  -- Colombo Menu
  ('M001', 'Chocolate Cake', 'Rich chocolate sponge with fudge frosting', 'uploads/cakes/chocolate.png', 'BR001', 20, 1500.00),
  ('M002', 'Vanilla Cupcake', 'Soft vanilla cupcake with buttercream', 'uploads/cakes/vanilla_cupcake.jpg', 'BR001', 35, 450.00),
  ('M003', 'Red Velvet Slice', 'Red velvet cake with cream cheese frosting', 'uploads/cakes/red_velvet_slice.jpg', 'BR001', 15, 600.00),

  -- Trincomalee Menu
  ('M004', 'Blueberry Muffin', 'Moist muffin with real blueberries', 'uploads/cakes/blueberry_muffin.jpg', 'BR002', 25, 500.00),
  ('M005', 'Cheese Sandwich', 'Toasted sandwich with melted cheese', 'uploads/cakes/cheese_sandwich.jpg', 'BR002', 30, 700.00),
  ('M006', 'Iced Coffee', 'Chilled coffee with milk and sugar', 'uploads/drinks/latte.png', 'BR002', 40, 300.00);


-- MEMBERSHIP
INSERT INTO Membership (Customer_name, Phone_number, Email, National_ID_no, Points, Branch_id)
VALUES
  ('Customer 01', '0711111111', 'cust01@gmail.com', 'CNIC001', 120, 'BR001'),
  ('Customer 02', '0722222222', 'cust02@gmail.com', 'CNIC002', 250, 'BR001'),
  ('Customer 03', '0733333333', NULL, 'CNIC003', 0, 'BR002');

-- ORDERS
INSERT INTO Orders (order_id, Staff_id, Order_time, Total_amount, Phone_number, Order_Completed)
VALUES
  ('ORD001', 'SCashier001', '2025-05-25 10:30:00', 1500.00, '0711111111', TRUE),
  ('ORD002', 'SWaiter002', '2025-05-25 12:15:00', 1800.00, NULL, FALSE),
  ('ORD003', 'SChef001', '2025-05-26 09:45:00', 1200.00, '0722222222', TRUE);

-- ORDERED_ITEMS
INSERT INTO Ordered_Items (order_id, item_id, Quantity, Delivered)
VALUES
  ('ORD001', 'M001', 1, TRUE),
  ('ORD001', 'M002', 1, TRUE),
  ('ORD002', 'M004', 2, FALSE);

-- PAYMENTS
INSERT INTO Payments (payment_id, order_id, Amount, Paid_on, Payment_method, Used_Points, Final_Amount)
VALUES
  ('PAY001', 'ORD001', 1500.00, '2025-05-25 10:35:00', 'Cash', 100, 1490.00),
  ('PAY002', 'ORD002', 1800.00, '2025-05-25 12:20:00', 'Card', 0, 1800.00),
  ('PAY003', 'ORD003', 1200.00, '2025-05-26 09:50:00', 'Cash', 200, 1180.00);
