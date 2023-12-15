/* 
    Night Gaming Cafe Web Application
    System Operations of 'NightGamingCafe'
*/

/* Registration */
/* Member making an Online and Customer Account */
insert into Account (UserName, Password, Email) values ('000000011', sha1('pass11'), 'email11');
insert into Member (MemNum, FirstName, LastName, DOB, Phone, CardBalance, RegisterDate, AcctID) values 
('000000011', 'John', 'Doe', '1993-10-30', '111-111-1121', 40.00, '2023-12-30', 11);

/* Authentication */
/* check if online account exist */
select count(*) from Member inner join Account on Member.AcctID = Account.ID
where UserName = '000000011' and Password = sha1('pass11');

/* Retrieve member profile upon logging in */
select MemNum, FirstName, LastName, DOB, Phone, CardBalance, RegisterDate from Member inner join Account on Member.AcctID = Account.ID
where UserName = '000000011' and Password = sha1('pass11');

/* Booking Management */
/* Make a booking */
insert into Booking (BkNum, Date, Type, NumPeople, StartTime, EndTime, MemID, RmID, CafeID) values
('G2024010801', '2024-01-08', 'Gaming Room', '5', '17:00', '22:00', (select ID from Member where MemNum = '000000003'), 1, 1);

/* Look up all upcoming Booking for the year and month of 2024-01 order by date and start time in ascending order */
select BkNum, Date, Type, NumPeople, time_format(StartTime, "%h:%i %p") as StartTime, 
if (EndTime = 'Not Sure', 'Not Sure', time_format(EndTime, "%h:%i %p")) as EndTime from Booking 
where year(Date) = '2024' and month(Date) = 1 order by Date, if (StartTime = '12:00', '12:00', StartTime) asc;

/* Look up all upcoming Booking with member first and last name for the year and month of 2024-01 order 
by reservation date and start time in ascending order */
select Booking.BkNum, Booking.Date, Booking.Type, Booking.NumPeople, time_format(Booking.StartTime, "%h:%i %p") as StartTime, 
if (Booking.EndTime = 'Not Sure', 'Not Sure', time_format(Booking.EndTime, "%h:%i %p")) as EndTime, Member.MemNum, Member.FirstName, Member.LastName
from Booking inner join Member on Booking.MemID = Member.ID
where year(Booking.Date) = '2024' and month(Booking.Date) = 1 order by Booking.Date, if (Booking.StartTime = '12:00', '12:00', Booking.StartTime) asc;

/* Look up all upcoming Booking for Lobby Seating in Lounge Room for the month of 2024-01 in ascending order */
select BkNum, Date, Type, NumPeople, time_format(StartTime, "%h:%i %p") as StartTime, 
if (EndTime = 'Not Sure', 'Not Sure', time_format(EndTime, "%h:%i %p")) as EndTime
from Booking where Type like '%Lobby' and year(Date) = '2024' and month(Date) = 1 order by Date, if (StartTime = '12:00', '12:00', StartTime) asc;

/* Look up all Booking on 2024-02-01 between certain start times */
select BkNum, Date, Type, NumPeople, time_format(StartTime, "%h:%i %p") as StartTime, 
if (EndTime = 'Not Sure', 'Not Sure', time_format(EndTime, "%h:%i %p")) as EndTime from Booking 
where Date = '2024-02-01' order by Date, if (StartTime = '12:00', '12:00', StartTime) asc;
/* between 12:00 PM and 05:00 PM */
select BkNum, Date, Type, NumPeople, time_format(StartTime, "%h:%i %p") as StartTime, 
if (EndTime = 'Not Sure', 'Not Sure', time_format(EndTime, "%h:%i %p")) as EndTime from Booking 
where Date = '2024-02-01' and StartTime between '12:00' and '17:00' order by Date, if (StartTime = '12:00', '12:00', StartTime) asc;
/* between 06:00 PM and 12:00 AM */
select BkNum, Date, Type, NumPeople, time_format(StartTime, "%h:%i %p") as StartTime, 
if (EndTime = 'Not Sure', 'Not Sure', time_format(EndTime, "%h:%i %p")) as EndTime from Booking 
where Date = '2024-02-01' and StartTime between '18:00' and '24:00' order by Date, if (StartTime = '12:00', '12:00', StartTime) asc;

/* Check a Booking based on date and membership number */
select Booking.BkNum, Booking.Date, Booking.Type, Booking.NumPeople, time_format(Booking.StartTime, "%h:%i %p") as StartTime, 
if (Booking.EndTime = 'Not Sure', 'Not Sure', time_format(Booking.EndTime, "%h:%i %p")) as EndTime, 
Member.MemNum, Member.FirstName, Member.LastName from Booking inner join Member on Booking.MemID = Member.ID 
where Booking.Date = '2024-01-22' and Member.ID = '000000006';

/* Check a Booking based on date and first name */
select Booking.BkNum, Booking.Date, Booking.Type, Booking.NumPeople, time_format(Booking.StartTime, "%h:%i %p") as StartTime, 
if (Booking.EndTime = 'Not Sure', 'Not Sure', time_format(Booking.EndTime, "%h:%i %p")) as EndTime, 
Member.MemNum, Member.FirstName, Member.LastName from Booking inner join Member on Booking.MemID = Member.ID 
where Booking.Date = '2024-02-01' and Member.FirstName = 'Thomas';

/* Check a Booking based on booking number */
select Booking.BkNum, Booking.Date, Booking.Type, Booking.NumPeople, time_format(Booking.StartTime, "%h:%i %p") as StartTime, 
if (Booking.EndTime = 'Not Sure', 'Not Sure', time_format(Booking.EndTime, "%h:%i %p")) as EndTime, 
Member.MemNum, Member.FirstName, Member.LastName from Booking inner join Member on Booking.MemID = Member.ID 
where Booking.BkNum = 'G2024010801';

/* Update a Booking date from 2024-01-13 to 2024-01-15 */
update Booking set Date = '2024-01-15' where (MemID = (select ID from Member where MemNum = '000000007')) and (BkNum = 'L2024011302');
select BkNum, Date, Type, NumPeople, time_format(StartTime, "%h:%i %p") as StartTime, 
if (EndTime = 'Not Sure', 'Not Sure', time_format(EndTime, "%h:%i %p")) as EndTime from Booking 
where (MemID = (select ID from Member where MemNum = '000000007')) and BkNum = 'L2024011302';

/* Update a Booking start time to 01:00 PM from 03:00 PM */ 
update Booking set StartTime = '15:00' where (MemID = (select ID from Member where MemNum = '000000006')) and (BkNum = 'L2024012201');
select BkNum, Date, Type, NumPeople, time_format(StartTime, "%h:%i %p") as StartTime, 
if (EndTime = 'Not Sure', 'Not Sure', time_format(EndTime, "%h:%i %p")) as EndTime from Booking 
where (MemID = (select ID from Member where MemNum = '000000006')) and (BkNum = 'L2024012201');

/* Update a Booking type to Gaming Room from Lounge Lobby */ 
update Booking set Type = 'Gaming Room' where (MemID = (select ID from Member where MemNum = '000000001')) and (BkNum = 'L2024010602');
select BkNum, Date, Type, NumPeople, time_format(StartTime, "%h:%i %p") as StartTime, 
if (EndTime = 'Not Sure', 'Not Sure', time_format(EndTime, "%h:%i %p")) as EndTime from Booking 
where (MemID = (select ID from Member where MemNum = '000000001')) and (BkNum = 'L2024010602');

/* Canceling/Delete a Booking */
delete from Booking where (MemID = (select ID from Member where MemNum = '000000005')) and (BkNum = 'L2024011901');
select BkNum, Date, Type, NumPeople, time_format(StartTime, "%h:%i %p") as StartTime, 
if (EndTime = 'Not Sure', 'Not Sure', time_format(EndTime, "%h:%i %p")) as EndTime from Booking 
where (MemID = (select ID from Member where MemNum = '000000005')) and (BkNum = 'L2024011901');

/* Count how many Booking where made for the year and month of 2024-01 */
select count(*) from Booking where year(Date) = '2024' and month(Date) = 1;

/* Room Management */
/* Check a person booking */
select Booking.BkNum, Booking.Date, Booking.Type, Booking.NumPeople, time_format(Booking.StartTime, "%h:%i %p") as StartTime, 
if (Booking.EndTime = 'Not Sure', 'Not Sure', time_format(Booking.EndTime, "%h:%i %p")) as EndTime, Room.RmNum, Member.MemNum, Member.FirstName, Member.LastName 
from (Booking inner join Member on Booking.MemID = Member.ID) inner join Room on Booking.RmID = Room.ID
where BkNum = 'G2024010801';

/* Check VIP Room availability where Capacity is equal or more than 5 people */
select Room.RmNum, Room.Available, RoomType.Type, RoomType.Capacity, RoomType.Description
from Room inner join RoomType on Room.RmTypeID = RoomType.ID
where RoomType.Type = 'Gaming Room' and RoomType.Capacity >= 5 and Room.Available = 'Y';

/* Update Booking  */
update Booking set RmID = (select ID from Room where RmNum = 'GR 03') where BkNum = 'G2024010801';
/* Update Room availability */
update Room set Available = 'N', Reserve = 'Y' where RmNum = 'GR 03';

/* Show all unavailable rooms in Room */
select Room.RmNum, Room.Available, Room.Reserve, RoomType.Type, RoomType.Capacity, RoomType.Description
from Room inner join RoomType on Room.RmTypeID = RoomType.ID where Room.Available = 'N' ;

/* Reset Room availability */
update Room set Available = 'Y', Reserve = 'N';

/* Delete a Room */
update Booking set RmID = (select ID from Room where RmNum = 'Nonexistent') where RmID = (select ID from Room where RmNum = 'GR 03');
delete from Room where RmNum = 'GR 03';

/* Adding a Room */
insert into Room (RmNum, Available, RmTypeID, CafeID) values ('GR 08', 'Y', 4, 1);
select Room.RmNum, Room.Available, RoomType.Type, RoomType.Capacity, RoomType.Description
from Room inner join RoomType on Room.RmTypeID = RoomType.ID
where RoomType.Type = 'Gaming Room';

/* Seat Management */
/* Check a person booking */
select Booking.BkNum, Booking.Date, Booking.Type, Booking.NumPeople, time_format(Booking.StartTime, "%h:%i %p") as StartTime, 
if (Booking.EndTime = 'Not Sure', 'Not Sure', time_format(Booking.EndTime, "%h:%i %p")) as EndTime, Room.RmNum, Booking.EmplNotes, Member.MemNum, Member.FirstName, Member.LastName 
from (Booking inner join Member on Booking.MemID = Member.ID) inner join Room on Booking.RmID = Room.ID
where Booking.Date = '2024-02-01' and Member.FirstName = 'Thomas';

/* Check Seat availability */
select Room.RmNum, Seat.SeatNum , Seat.Available, SeatType.Type as SeatType, Section.Name, Section.Type as Section_Type
from ((((Room inner join Seat on Room.ID = Seat.RmID) inner join RoomType on Room.RmTypeID = RoomType.ID) 
inner join SeatType on Seat.SeatTypeID = SeatType.ID) inner join Section on Seat.SectionID = Section.ID)
where RoomType.Type = 'Lounge' and SeatType.Type = 'Lobby' and Seat.Available = 'Y';

/* Update Booking  */
update Booking set EmplNotes = 'Seat Number reserved LA 01' where BkNum = 'L2024020107';

/* Update Seat availability */
update Seat set Available = 'N', Reserve = 'Y' where SeatNum = 'LA 01';

/* Show all unavailable seats */
select Room.RmNum, Seat.SeatNum , Seat.Available, SeatType.Type as SeatType, Section.Name, Section.Type as Section_Type
from ((((Room inner join Seat on Room.ID = Seat.RmID) inner join RoomType on Room.RmTypeID = RoomType.ID) 
inner join SeatType on Seat.SeatTypeID = SeatType.ID) inner join Section on Seat.SectionID = Section.ID)
where Seat.Available = 'N';

/* Reset Seat availability */
update Seat set Available = 'Y', Reserve = 'N';

/* Delete a Seat */
delete from Seat where SeatNum = 'LA 01';

/* Adding a Seat */
insert into Seat (SeatNum, Available, RmID, SeatTypeID, SectionID) values ('LA 11', 'Y', 3, 1, 1);
select Room.RmNum, Seat.SeatNum , Seat.Available, SeatType.Type as SeatType, Section.Name, Section.Type as Section_Type
from ((((Room inner join Seat on Room.ID = Seat.RmID) inner join RoomType on Room.RmTypeID = RoomType.ID) 
inner join SeatType on Seat.SeatTypeID = SeatType.ID) inner join Section on Seat.SectionID = Section.ID)
where RoomType.Type = 'Lounge' and SeatType.Type = 'Lobby' and SeatNum like 'LA%';

/* System Support */
/* Add Role */
insert into Role (Name, Description) values
('Chef', 'Usually in charge cooking food requsted by the member of the cafe');
select * from Role;

/* Update Role */
update Role set Description = 'Usually in charge of member arrival, organize the room or seat that is going to be used, take food order request' where Name = 'Front Desk';
select * from Role where Name = 'Front Desk';

/* Add a new employee */
insert into Employee (EmplNum, FirstName, LastName, DOB, Phone, Email, Salary, HireDate, Active, RoleID, CafeID) value
('000007', 'Gordon', 'Frank', '2002-03-12', '111-111-2227', 'emailA7', 40000.00, '2023-12-20', 'Y', 3, 1);
select * from Employee;

/* Change active status of a Employee and make the Employee account inactive */
update Employee set Email = '', Phone = '', Active = 'N' where EmplNum = '000003';
select * from Employee where Active = 'N';

/* Change active status of a Member and make member account inactive */
update Member set CardBalance = 0 where MemNum = '000000009';
update Member inner join Account on Member.AcctID = Account.ID set Account.UserName = '', Account.Password = '', Account.Email = '', Member.Phone = '', Account.Active = 'N' 
where MemNum = '000000009';
select * from Member inner join Account on Member.AcctID = Account.ID where Active = 'N';
