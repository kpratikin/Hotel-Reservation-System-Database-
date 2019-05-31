#***********************************
# Queries for Managers
#***********************************
# Case 1
-- check 5 most booked hotels in the chain in a period
USE hotel; 

select count(Room_Availability.Room_ID) as 'Number of Rooms Booked', Hotel_Name
from Room_Availability left join Rooms on Room_Availability.Room_ID = Rooms.Room_ID
left join Hotels on Hotels.Hotel_ID = Rooms.Hotel_ID
where Room_Availability_Status = 'Booked'
and Day_Date between '2019/02/01' and '2019/02/07'
group by 2
order by 1 desc
limit 5;

# Case 2 
-- The managers can check the number of rooms available by hotel in a specific day 
select count(Room_Availability.Room_ID) as 'Number of Rooms Available', Hotel_Name
from Room_Availability left join Rooms on Room_Availability.Room_ID = Rooms.Room_ID
left join Hotels on Hotels.Hotel_ID = Rooms.Hotel_ID
where Room_Availability_Status = 'Available'
and Day_Date = '2019/02/07'
group by 2
order by 2;

# Case 3
-- check the number of bookings in a period and by hotel
select count(Booking_ID) as 'Number of Bookings', Hotel_Name
from Bookings left join Rooms on Bookings.Room_ID = Rooms.Room_ID 
left join Hotels on Rooms.Hotel_ID = Hotels.Hotel_ID
and Date_From between '2019/02/01' and '2019/02/07'
group by 2
order by 2;

#***********************************
# Queries for Customer
#***********************************
# Case 1. - Commenting this case as ID is not auto-increment. (will give error if the customer_id already exists).
## Register customer to the system.
INSERT INTO Customers (`Customer_Lastname`,`Customer_Firstname`,`Address`,`Country_Code`,`City_Code`,`Age`) 
VALUES ( 'James', 'Bond', 'Cherry Avenue', 'USA', 'SC', '25');


# Case 2.
## Modify Customer information. 
#Update age of customer with id =19 to 26.
UPDATE Customers SET Age = 26 
WHERE Customer_ID =19;

# Case 3,
# Check booking history of a Customer.
SELECT * FROM Bookings Where Customer_ID = 1;

# Case 4.
## Can canceled reservation before the order is confirmed. 
#Delete booking for customer with id =10
DELETE FROM Bookings 
WHERE Booking_ID = '10'
AND Booking_Status_Code IN
(SELECT Booking_Status_Code FROM Booking_Status BS
WHERE BS.Booking_Status_Description = 'Processing');

#***********************************
# Queries for Reservation Staff (Salesperson)
#***********************************
# Case 1.
# Reservation staff can check how many rooms are available for a specific day or a specific period by keyin the date and the hotel ID.
select count(room_availability.Room_ID), room_availability.Day_Date
from  rooms inner join room_availability on rooms.Room_ID = room_availability.Room_ID
where (room_availability.Room_Availability_Status='Available') and (rooms.Hotel_ID = '1') and (room_availability.Day_Date = '2019-02-07');


#Case 2.
# Reservation staff can check the room rates for specific day , room type and a specific room type by keyin the date and the hotel ID.
select daily_room_rate, Day_Date
from daily_room_rates
where  Day_Date = '2019-06-12' and Hotel_ID = '2';

# Case 3
#Front desk staff can use the customer reservation number and customer ID to check-in the customers to correct room.
select rooms.Room_Number 
from bookings inner join rooms on  bookings.Room_ID = rooms.Room_ID
where bookings.Booking_ID = '10' and bookings.Customer_ID = '4';


###########################################################################################
# TRIGGERS AND STORED PROCEDURES
###########################################################################################

-- -----------------------------------------------------
-- Create Triggers 1 - After Insert 
-- -----------------------------------------------------

# Create a new table Booking_Insert 
 drop table if exists Booking_Insert;
 
 CREATE TABLE `hotel`.`Booking_Insert` (
  `Booking_ID` INT NOT NULL,
  `Room_ID` VARCHAR(45) NULL,
  `Date_From` DATE NULL,
  `Date_To` DATE NULL);

Drop trigger if exists `hotel`.`Bookings_AFTER_INSERT`; 

CREATE DEFINER = CURRENT_USER TRIGGER `hotel`.`Bookings_AFTER_INSERT` 
AFTER INSERT ON `Bookings` 
FOR EACH ROW
INSERT INTO Booking_Insert SELECT Booking_ID, Room_ID, Date_From, Date_To 
FROM Bookings WHERE Booking_ID = NEW.Booking_ID;

# Check if Booking_ID doesn't exists in Bookings, insert new values
INSERT INTO Bookings (Booking_ID, Room_ID, Date_From, Date_To)
SELECT * FROM (SELECT 25,2001,'2019/02/01','2019/02/03') as b1 
WHERE NOT EXISTS (
    SELECT Booking_ID FROM Bookings WHERE Booking_ID = 25
) LIMIT 1;	
	
INSERT INTO Booking_1 (Booking_ID, Room_ID, Date_From, Date_To)
SELECT * FROM (SELECT 5,1002,'2019/02/03','2019/02/05') as b1 
WHERE NOT EXISTS (
    SELECT Booking_ID FROM Booking_1 WHERE Booking_ID = 26
) LIMIT 1;	
   
INSERT INTO Bookings (Booking_ID, Room_ID, Date_From, Date_To)
SELECT * FROM (SELECT 6,1002,'2019/02/05','2019/02/06') as b1 
WHERE NOT EXISTS (
    SELECT Booking_ID FROM Bookings WHERE Booking_ID = 27
) LIMIT 1;	
   
select * from Bookings;
select * from Booking_Insert; # check whether the trigger works 

-- -----------------------------------------------------
-- Create Triggers 2 - After Update
-- -----------------------------------------------------

# Create a new table Booking_Room_Update
drop table if exists Booking_Room_Update; 

CREATE TABLE `hotel`.`Booking_Room_Update` (
  `Booking_ID` INT NOT NULL, 
  `Old_Room_ID` VARCHAR(45) NULL,
  `New_Room_ID` VARCHAR(45) NULL,
  `Date_Updated` DATE NULL);

Drop trigger if exists `hotel`.`Bookings_AFTER_UPDATE`;
DELIMITER $$
CREATE DEFINER = CURRENT_USER TRIGGER `hotel`.`Bookings_AFTER_UPDATE` 
AFTER UPDATE ON `Bookings`
FOR EACH ROW
BEGIN
# check value before and after update
If old.Room_ID <> NEW.Room_ID
then insert into Booking_Room_Update
values (old.Booking_ID, old.Room_ID, new.Room_ID, current_date());
end if;
END$$
DELIMITER ;
  
UPDATE Bookings
SET Room_ID = (CASE
		WHEN Booking_Status_Code = 'P' then 1002
        ELSE Room_ID
        END)
WHERE Booking_ID = 2;

select * from Bookings;
select * from Booking_Room_Update;

-- -----------------------------------------------------
-- Create Triggers 3 - Before Delete 
-- -----------------------------------------------------
# Create a new table Booking_Delete_History 
drop table if exists Booking_Delete_History;

CREATE TABLE `hotel`.`Booking_Delete_History` (
  `Booking_ID` INT NOT NULL, 
   `Room_ID` VARCHAR(45) NULL,
   `Customer_ID` INT NULL ); 

Drop trigger if exists `hotel`.`Bookings_BEFORE_DELETE`;

CREATE DEFINER = CURRENT_USER TRIGGER `hotel`.`Bookings_BEFORE_DELETE` 
BEFORE DELETE ON `Bookings` 
FOR EACH ROW
INSERT INTO Booking_Delete_History SELECT Booking_ID, Room_ID, Customer_ID
FROM Bookings WHERE Booking_ID = old.Booking_ID ; 

DELETE FROM Bookings 
WHERE Booking_ID = 10;  

select * from Bookings;
select * from Booking_Delete_History; 

-- -----------------------------------------------------
-- Create a Stored Procedure
-- -----------------------------------------------------
# Stored Procedure 1- Update Bookings 
DROP PROCEDURE if exists UpdateBookingRoom;
DELIMITER //
CREATE PROCEDURE UpdateBookingRoom(IN ID INT(11), IN N_Room_ID VARCHAR(45))
BEGIN
	UPDATE Bookings
	SET Room_ID = N_Room_ID
	WHERE Booking_ID = ID; 
END //
DELIMITER ;

CALL UpdateBookingRoom(4,3001);

select * from Bookings;
select * from Booking_Room_Update; 


-- -----------------------------------------------------
-- Create Stored Procedure for customers table
-- -----------------------------------------------------
# Stored Procedure 2- Update Customer Record and Delete Customer 
DROP PROCEDURE IF EXISTS Customer_address_update_delete;
DELIMITER $$
CREATE PROCEDURE Customer_address_update_delete(IN act VARCHAR(10), IN id INT(11),IN addr VARCHAR(250))
BEGIN
	CASE
		WHEN (lower(act) = 'update') then UPDATE Customers SET Address = addr WHERE customer_id =id;
		WHEN (lower(act) = 'delete') then DELETE FROM Customers where customer_id = id; #delete the customer
	End case;
END $$
DELIMITER ;

#Test Stored procedure(Customer_update_delete) to UPdate and Delete Customer
CALL Customer_address_update_delete('UPDATE','19','738 Franklin St');
SELECT * FROM customers WHERE customer_ID =19;

-- -----------------------------------------------------

#***********************************
# Queries for Business Metrics
#***********************************
# Metric 1: What is the (Between)
#			1. Average daily revenue by hotel chain
#			2. Total bookings by hotel chain 
#			3. Total Revenue by hotel chain.
SELECT hc.hotel_Chain_Name 'Hotel Chain Name', count(*) 'Total Number of Bookings',AVG(rate.Daily_Room_Rate) 'Average Daily Revenue', SUM(rate.Daily_Room_Rate) 'Total Revenue'  FROM daily_room_rates rate 
	INNER JOIN hotels hot ON rate.Hotel_ID = hot.Hotel_ID 
    INNER JOIN hotel_chains hc ON hc.Hotel_Chain_Code =hot.Hotel_Chain_Code
    INNER JOIN rooms rom ON rom.hotel_id = hot.hotel_id
    INNER JOIN room_availability ra ON rom.room_ID = ra.room_ID
    WHERE (ra.room_availability_status = 'Booked') AND (ra.Day_Date between '2019/02/01' and '2019/02/07')
    GROUP by hc.hotel_chain_code
    ORDER BY  4 desc;


# Metrics 2: Average daily rates by room     
select Daily_Room_Rates.Room_ID, round(avg(Daily_Room_Rate),2) as 'Average_Daily_Room_Rate', Standard_Room_Rate,  round(avg(Daily_Room_Rate),2) - Standard_Room_Rate as 'Profit per room'
from Room_Types right join Rooms on Room_Types.Room_Type_Code = Rooms.Room_Type_Code 
right join Daily_Room_Rates on Rooms.Room_ID = Daily_Room_Rates.Room_ID
group by 1
order by 1;

# Metrics 3: Occupancy rate by hotel and date 
SELECT 
    r.Hotel_ID,
    ra.Day_Date,
    COUNT(DISTINCT (ra.Room_ID)) / (SELECT 
            COUNT(DISTINCT (Room_ID))
        FROM
            rooms
        WHERE
            Hotel_ID = r.Hotel_ID) * 100 as 'Occupancy Rate' 
FROM
    rooms r
        JOIN
    room_availability ra ON r.Room_ID = ra.Room_ID
WHERE
    ra.Room_Availability_Status = 'Booked'
GROUP BY ra.Day_Date , r.Hotel_ID;

# Metrics  4. Where our customer come from
SELECT C.Country_Code,count(C.Customer_ID) 
	FROM Customers C 
	INNER JOIN Bookings B ON B.Customer_ID = C.Customer_ID
	WHERE (B.Date_From between '2019/02/01' and '2019/02/07') OR (B.Date_To between '2019/02/01' and '2019/02/07')
	GROUP BY C.Country_Code
	ORDER BY 2 desc;

# Metrics  5. How long our customer plan to stay
SELECT DATEDIFF(B.Date_To,B.Date_From) as duration,count(B.Booking_ID) 
	FROM Bookings B 
	WHERE (B.Date_From between '2019/02/01' and '2019/02/07') OR (B.Date_To between '2019/02/01' and '2019/02/07')
	GROUP BY duration
	ORDER BY 1;
-- -----------------------------------------------------


