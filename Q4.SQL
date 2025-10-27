-- =====================================================
-- Q1: DATABASE AND TABLE CREATION
-- =====================================================

-- (a) Create database and use it
CREATE DATABASE Hotel_Booking;
USE Hotel_Booking;

-- (b) Create tables
CREATE TABLE HOTEL (
Hotel_id INT PRIMARY KEY,
Hotel_name VARCHAR(50) NOT NULL,
City VARCHAR(50),
Rating DECIMAL(2,1)
);

CREATE TABLE CUSTOMER (
Cust_id INT PRIMARY KEY,
First_name VARCHAR(50) NOT NULL,
Last_name VARCHAR(50),
Phone VARCHAR(15),
Email VARCHAR(100) UNIQUE NOT NULL,
City VARCHAR(50)
);

CREATE TABLE ROOM (
Room_id INT PRIMARY KEY,
Hotel_id INT,
Room_type VARCHAR(50),
Price DECIMAL(10,2),
FOREIGN KEY (Hotel_id) REFERENCES HOTEL(Hotel_id)
);

CREATE TABLE BOOKING (
Booking_id INT PRIMARY KEY,
Cust_id INT,
Room_id INT,
Booking_date DATE,
Check_in DATE,
Check_out DATE,
Total_amount DECIMAL(10,2),
FOREIGN KEY (Cust_id) REFERENCES CUSTOMER(Cust_id),
FOREIGN KEY (Room_id) REFERENCES ROOM(Room_id)
);

-- (c) Query: List customers who booked hotels in their own city
SELECT
c.Cust_id,
CONCAT(c.First_name, ' ', c.Last_name) AS Customer_Name,
c.City AS Customer_City,
h.Hotel_name,
h.City AS Hotel_City
FROM
CUSTOMER c
JOIN
BOOKING b ON c.Cust_id = b.Cust_id
JOIN
ROOM r ON b.Room_id = r.Room_id
JOIN
HOTEL h ON r.Hotel_id = h.Hotel_id
WHERE
c.City = h.City;

-- =====================================================
-- Q2: TRIGGERS
-- =====================================================

-- (a) Trigger: Log new bookings
CREATE TABLE BOOKING_LOG (
Log_id INT AUTO_INCREMENT PRIMARY KEY,
Booking_id INT,
Cust_id INT,
Action VARCHAR(20),
Action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //
DROP TRIGGER IF EXISTS booking_insert_trigger //
CREATE TRIGGER booking_insert_trigger
AFTER INSERT
ON BOOKING
FOR EACH ROW
BEGIN
INSERT INTO BOOKING_LOG (Booking_id, Cust_id, Action)
VALUES (NEW.Booking_id, NEW.Cust_id, 'INSERT');
END //
DELIMITER ;

-- (b) Trigger: Log room price changes
CREATE TABLE PRICE_CHANGE_LOG (
Log_id INT AUTO_INCREMENT PRIMARY KEY,
Room_id INT,
Old_price DECIMAL(10,2),
New_price DECIMAL(10,2),
Change_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //
DROP TRIGGER IF EXISTS room_price_update_trigger //
CREATE TRIGGER room_price_update_trigger
AFTER UPDATE
ON ROOM
FOR EACH ROW
BEGIN
IF OLD.Price <> NEW.Price THEN
INSERT INTO PRICE_CHANGE_LOG (Room_id, Old_price, New_price)
VALUES (OLD.Room_id, OLD.Price, NEW.Price);
END IF;
END //
DELIMITER ;

-- =====================================================
-- Q3: STORED PROCEDURE
-- =====================================================

DELIMITER //
DROP PROCEDURE IF EXISTS UpdateRoomPrice //
CREATE PROCEDURE UpdateRoomPrice(IN room_number INT, IN new_price DECIMAL(10,2))
BEGIN
DECLARE old_price DECIMAL(10,2);

-- Get old price
SELECT Price INTO old_price FROM ROOM WHERE Room_id = room_number;

-- Update room price
UPDATE ROOM SET Price = new_price WHERE Room_id = room_number;

-- Log the change
INSERT INTO PRICE_CHANGE_LOG (Room_id, Old_price, New_price)
VALUES (room_number, old_price, new_price);


END //
DELIMITER ;

-- =====================================================
-- Q4: VIEW CREATION
-- =====================================================

CREATE VIEW High_Value_Bookings AS
SELECT
b.Booking_id,
CONCAT(c.First_name, ' ', c.Last_name) AS Customer_Name,
h.Hotel_name,
r.Room_type,
b.Total_amount
FROM
BOOKING b
JOIN
CUSTOMER c ON b.Cust_id = c.Cust_id
JOIN
ROOM r ON b.Room_id = r.Room_id
JOIN
HOTEL h ON r.Hotel_id = h.Hotel_id
WHERE
b.Total_amount > 10000;
