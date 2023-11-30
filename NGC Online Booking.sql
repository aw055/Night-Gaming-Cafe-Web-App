/* 
    Night Gaming Cafe Web Application
    Online Booking Database
*/

/* Create Online Booking Database */
drop database if exists NGC_Online_Booking;
create database NGC_Online_Booking;

use NGC_Online_Booking;

/* Create Tables for Online Booking Database */
/* Create Member Table */
drop table if exists Member;
create table Member (
    MemID int not null auto_increment,
    MemNum varchar(9) not null default '',
    FirstName varchar(50) not null default '',
    LastName varchar(50) not null default '',
    UserName varchar(50) not null default '',
    Password varchar(50) not null default '',
    DateOfBirth date not null,
    Email varchar(255) not null default '',
    Phone varchar(15) not null default '',
    CardBalance decimal(5,2) not null default '0',
    Active enum('Y', 'N') not null default 'Y',
    primary key (MemID),
    constraint unique (MemID, MemNum)
) engine=InnoDB default charset=utf8mb4;

/* Create Cafe Table */
drop table if exists Cafe;
create table Cafe (
    CafeID int not null auto_increment,
    Name varchar(255) not null default '',
    Address varchar(255) not null default '',
    Phone varchar(15) not null default '',
    primary key (CafeID),
    constraint unique (CafeID)
) engine=InnoDB default charset=utf8mb4;

/* Create Room Type Table */
drop table if exists Room_Type;
create table Room_Type (
    RmTypeID int not null auto_increment,
    Type enum('Gaming Room', 'VIP Room', 'eSports Conference Room', 'None') not null default 'None',
    Name varchar(50) not null default '',
    Capacity enum('4', '6', '8', '10', 'None') not null default 'None',
    Description text,
    primary key (RmTypeID),
    constraint unique (RmTypeID, Name)
) engine=InnoDB default charset=utf8mb4;

/* Create Room Table */
drop table if exists Room;
create table Room (
    RmID int not null auto_increment,
    RmNum varchar(5) not null default '',
    FloorNum enum('Floor 1', 'Floor 2', 'None') not null default 'None',
    Available enum('Y', 'N', 'Nonexistent') not null default 'Y',
    RmTypeID int not null default 1,
    CafeID int not null default 1,
    primary key (RmID),
    constraint foreign key (RmTypeID) references Room_Type(RmTypeID),
    constraint foreign key (CafeID) references Cafe(CafeID),
    constraint unique (RmID, RmNum)
) engine=InnoDB default charset=utf8mb4;

/* Create Room Reservation Table */
drop table if exists Room_Reservation;
create table Room_Reservation (
    RmResID int not null auto_increment,
    ResNum varchar(11) not null default '',
    Date date not null,
    Type enum('Gaming Room', 'VIP Room', 'eSports Conference Room') not null,
    NumPeople enum('4', '5', '6', '7', '8', '9', '10') not null,
    StartTime enum('12:00', '13:00', '14:00', '15:00', '16:00', '17:00', '18:00', '19:00', '20:00', '21:00') not null,
    EndTime enum('Not Sure', '13:00', '14:00', '15:00', '16:00', '17:00', '18:00', '19:00', '20:00', '21:00', '22:00', '23:00', '24:00', '01:00', '02:00') not null default 'Not Sure',
    MemID int not null,
    RmID int not null default 1,
    primary key (RmResID),
    constraint foreign key (MemID) references Member(MemID),
    constraint foreign key (RmID) references Room(RmID),
    constraint unique (RmResID, ResNum)
) engine=InnoDB default charset=utf8mb4;

/* Create Section Type Table */
drop table if exists Section_Type;
create table Section_Type (
    SectionTypeID int not null auto_increment,
    Type enum('Lobby', 'eSports', 'Stage', 'None') not null default 'None',
    Name varchar(50) not null default '',
    Description text,
    primary key (SectionTypeID),
    constraint unique (SectionTypeID, Name)
) engine=InnoDB default charset=utf8mb4;

/* Create Lounge Seating Table */
drop table if exists Lounge_Seating;
create table Lounge_Seating (
    LoungeSeatID int not null auto_increment,
    SeatNum varchar(5) not null default '',
    Available enum('Y', 'N', 'Nonexistent') not null default 'Y',
    SectionTypeID int not null default 1,
    CafeID int not null default 1,
    primary key (LoungeSeatID),
    constraint foreign key (SectionTypeID) references Section_Type(SectionTypeID),
    constraint foreign key (CafeID) references Cafe(CafeID),
    constraint unique (LoungeSeatID, SeatNum)
) engine=InnoDB default charset=utf8mb4;

/* Create Seat Reservation Table */
drop table if exists Seat_Reservation;
create table Seat_Reservation (
    SeatResID int not null auto_increment,
    ResNum varchar(11) not null default '',
    Date date not null,
    Type enum('Lobby', 'eSports', 'Stage') not null,
    NumResSeats enum('1', '2', '3', '4', '5', '6', '7', '8', '9', '10') not null,
    StartTime enum('12:00', '13:00', '14:00', '15:00', '16:00', '17:00', '18:00', '19:00', '20:00', '21:00') not null,
    EndTime enum('Not Sure', '13:00', '14:00', '15:00', '16:00', '17:00', '18:00', '19:00', '20:00', '21:00', '22:00', '23:00', '24:00', '01:00', '02:00') not null default 'Not Sure',
    MemID int not null,
    LoungeSeatID int not null default 1,
    primary key (SeatResID),
    constraint foreign key (MemID) references Member(MemID),
    constraint foreign key (LoungeSeatID) references Lounge_Seating(LoungeSeatID),
    constraint unique (SeatResID)
) engine=InnoDB default charset=utf8mb4;

/* Create Staff Table */
drop table if exists Staff;
create table Staff (
    StaffID int not null auto_increment,
    StaffNum varchar(9) not null default '',
    FirstName varchar(50) not null default '',
    LastName varchar(50) not null default '',
    UserName varchar(50) not null default '',
    Password varchar(50) not null default '',
    Position enum('Front Desk', 'Supervisor') not null,
    Salary decimal(10,2) not null default '0',
    DateOfBirth date not null,
    Email varchar(255) not null default '',
    Phone varchar(15) not null default '',
    HireDate date not null,
    Active enum('Y', 'N') not null default 'Y',
    CafeID int not null default 1,
    primary key (StaffID),
    constraint foreign key (CafeID) references Cafe(CafeID),
    constraint unique (StaffID, StaffNum)
) engine=InnoDB default charset=utf8mb4;

/* Insert Data for Online Booking Database */
/* Insert Data into Member Table */
insert into Member (MemNum, FirstName, LastName, UserName, Password, DateOfBirth, Email, Phone, CardBalance)
values ('000000001', 'Maria', 'Anders', '000000001', 'pass1', '2005-01-18', 'email1', '111-111-1111', 50.00);
insert into Member (MemNum, FirstName, LastName, UserName, Password, DateOfBirth, Email, Phone, CardBalance)
values ('000000002', 'Ana', 'Trujillo', '000000002', 'pass2', '2000-02-23', 'email2', '111-111-1112', 75.00);
insert into Member (MemNum, FirstName, LastName, UserName, Password, DateOfBirth, Email, Phone, CardBalance)
values ('000000003', 'Antonio', 'Moreno', '000000003', 'pass3', '2003-03-20', 'email3', '111-111-1113', 100.00);
insert into Member (MemNum, FirstName, LastName, UserName, Password, DateOfBirth, Email, Phone, CardBalance)
values ('000000004', 'Thomas', 'Hardy', '000000004', 'pass4', '1991-04-30', 'email4', '111-111-1114', 200.00);
insert into Member (MemNum, FirstName, LastName, UserName, Password, DateOfBirth, Email, Phone, CardBalance)
values ('000000005', 'Christina', 'Berglund', '000000005', 'pass5', '1995-05-28', 'email5', '111-111-1115', 20.00);
insert into Member (MemNum, FirstName, LastName, UserName, Password, DateOfBirth, Email, Phone, CardBalance)
values ('000000006', 'Hanna', 'Moos', '000000006', 'pass6', '2001-06-22', 'email6', '111-111-1116', 150.00);
insert into Member (MemNum, FirstName, LastName, UserName, Password, DateOfBirth, Email, Phone, CardBalance)
values ('000000007', 'Frederique', 'Citeaux', '000000007', 'pass7', '1999-07-24', 'email7', '111-111-1117', 30.00);
insert into Member (MemNum, FirstName, LastName, UserName, Password, DateOfBirth, Email, Phone, CardBalance)
values ('000000008', 'Martin', 'Sommer', '000000008', 'pass8', '1997-08-26', 'email8', '111-111-1118', 110.00);
insert into Member (MemNum, FirstName, LastName, UserName, Password, DateOfBirth, Email, Phone, CardBalance)
values ('000000009', 'Laurence', 'Jebojams', '000000009', 'pass9', '1989-09-14', 'email9', '111-111-1119', 5.00);
insert into Member (MemNum, FirstName, LastName, UserName, Password, DateOfBirth, Email, Phone, CardBalance)
values ('000000010', 'Elizabeth', 'Lincoln', '000000010', 'pass10', '1993-10-30', 'email10', '111-111-1110', 75.00);

/* Insert Data into Cafe Table */
/* Default */
insert into Cafe (Name, Address, Phone) values ('Nonexistent', 'Nonexistent', 'Nonexistent');

insert into Cafe (Name, Address, Phone) values ('Night Gaming Cafe', '123 Temp Placeholder St, Toronto, ON, ABC 456', '123-456-7890');

/* Insert Data into Staff Table */
insert into Staff (StaffNum, FirstName, LastName, UserName, Password, Position, Salary, DateOfBirth, Phone, Email, HireDate, CafeID)
values ('000001', 'Nancy', 'Davolio', '000001', 'pass1', 'Front Desk', 30000.00, '2005-07-12', '111-111-2221', 'emailA1', '2023-12-05', (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Staff (StaffNum, FirstName, LastName, UserName, Password, Position, Salary, DateOfBirth, Phone, Email, HireDate, CafeID)
values ('000002', 'Andrew', 'Fuller', '000002', 'pass2', 'Front Desk', 30000.00, '2000-05-22', '111-111-2222', 'emailA2', '2023-12-07', (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Staff (StaffNum, FirstName, LastName, UserName, Password, Position, Salary, DateOfBirth, Phone, Email, HireDate, CafeID)
values ('000003', 'Janet', 'Leverling', '000003', 'pass3', 'Front Desk', 30000.00, '2003-06-04', '111-111-2223', 'emailA3', '2023-12-10', (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Staff (StaffNum, FirstName, LastName, UserName, Password, Position, Salary, DateOfBirth, Phone, Email, HireDate, CafeID)
values ('000004', 'Steven', 'Buchanan', '000004', 'pass4', 'Front Desk', 30000.00, '1998-09-24', '111-111-2224', 'emailA4', '2023-12-22', (select CafeID from Cafe where Name = 'Night Gaming Cafe'));

insert into Staff (StaffNum, FirstName, LastName, UserName, Password, Position, Salary, DateOfBirth, Phone, Email, HireDate, CafeID)
values ('000005', 'Michael', 'Suyama', '000005', 'pass5', 'Supervisor', 30000.00, '1995-10-29', '111-111-2225', 'emailA5', '2023-12-14', (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Staff (StaffNum, FirstName, LastName, UserName, Password, Position, Salary, DateOfBirth, Phone, Email, HireDate, CafeID)
values ('000006', 'Robert', 'King', '000006', 'pass6', 'Supervisor', 30000.00, '1994-02-15', '111-111-2226', 'emailA6', '2023-12-16', (select CafeID from Cafe where Name = 'Night Gaming Cafe'));

/* Insert Data into Room Type Table */
/* Default */
insert into Room_Type (Type, Name, Capacity, Description) values ('None', 'None', 'None', 'Nonexistent Room');

insert into Room_Type (Type, Name, Capacity, Description) values ('Gaming Room', 'Gaming Room Small 4 People', '4', 'Have 4 Mid Tier Gaming PC');
insert into Room_Type (Type, Name, Capacity, Description) values ('Gaming Room', 'Gaming Room Medium 6 People', '6', 'Have 6 Mid Tier Gaming PC');
insert into Room_Type (Type, Name, Capacity, Description) values ('Gaming Room', 'Gaming Room Medium 8 People', '8', 'Have 8 Mid Tier Gaming PC');
insert into Room_Type (Type, Name, Capacity, Description) values ('Gaming Room', 'Gaming Room Large 10 People', '10', 'Have 10 Mid Tier Gaming PC');

insert into Room_Type (Type, Name, Capacity, Description) values ('VIP Room', 'VIP Room Small 4 People', '4', 'Have 4 High-End Gaming PC');
insert into Room_Type (Type, Name, Capacity, Description) values ('VIP Room', 'VIP Room Medium 6 People', '6', 'Have 6 High-End Gaming PC');
insert into Room_Type (Type, Name, Capacity, Description) values ('VIP Room', 'VIP Room Medium 8 People', '8', 'Have 8 High-End Gaming PC');
insert into Room_Type (Type, Name, Capacity, Description) values ('VIP Room', 'VIP Room Large 10 People', '10', 'Have 10 High-End Gaming PC');

insert into Room_Type (Type, Name, Capacity, Description) values ('eSports Conference Room', 'eSports Conference Room Small 4 People', '4', 'Have 4 High-End Gaming PC, One large Projector Screen, Ideal for eSport team meetings');
insert into Room_Type (Type, Name, Capacity, Description) values ('eSports Conference Room', 'eSports Conference Room Medium 6 People', '6', 'Have 6 High-End Gaming PC, One large Projector Screen, Ideal for eSport team meetings');
insert into Room_Type (Type, Name, Capacity, Description) values ('eSports Conference Room', 'eSports Conference Room Medium 8 People', '8', 'Have 8 High-End Gaming PC, One large Projector Screen, Ideal for eSport team meetings');
insert into Room_Type (Type, Name, Capacity, Description) values ('eSports Conference Room', 'eSports Conference Room Large 10 People', '10', 'Have 10 High-End Gaming PC, One large Projector Screen, Ideal for eSport team meetings');

/* Insert Data into Room Table */
/* Default */
insert into Room (RmNum, FloorNum, Available) values ('None', 'None', 'Nonexistent');

insert into Room (RmNum, FloorNum, RmTypeID, CafeID) 
values ('GR 01', 'Floor 1', (select RmTypeID from Room_Type where Type = 'Gaming Room' and Capacity = '4'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Room (RmNum, FloorNum, RmTypeID, CafeID) 
values ('GR 02', 'Floor 1', (select RmTypeID from Room_Type where Type = 'Gaming Room' and Capacity = '4'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Room (RmNum, FloorNum, RmTypeID, CafeID) 
values ('GR 03', 'Floor 1', (select RmTypeID from Room_Type where Type = 'Gaming Room' and Capacity = '6'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Room (RmNum, FloorNum, RmTypeID, CafeID) 
values ('GR 04', 'Floor 1', (select RmTypeID from Room_Type where Type = 'Gaming Room' and Capacity = '8'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Room (RmNum, FloorNum, RmTypeID, CafeID) 
values ('GR 05', 'Floor 1', (select RmTypeID from Room_Type where Type = 'Gaming Room' and Capacity = '10'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));

insert into Room (RmNum, FloorNum, RmTypeID, CafeID) 
values ('VR 01', 'Floor 1', (select RmTypeID from Room_Type where Type = 'VIP Room' and Capacity = '4'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Room (RmNum, FloorNum, RmTypeID, CafeID) 
values ('VR 02', 'Floor 1', (select RmTypeID from Room_Type where Type = 'VIP Room' and Capacity = '4'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Room (RmNum, FloorNum, RmTypeID, CafeID) 
values ('VR 03', 'Floor 2', (select RmTypeID from Room_Type where Type = 'VIP Room' and Capacity = '6'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Room (RmNum, FloorNum, RmTypeID, CafeID) 
values ('VR 04', 'Floor 2', (select RmTypeID from Room_Type where Type = 'VIP Room' and Capacity = '8'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Room (RmNum, FloorNum, RmTypeID, CafeID) 
values ('VR 05', 'Floor 2', (select RmTypeID from Room_Type where Type = 'VIP Room' and Capacity = '10'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));

insert into Room (RmNum, FloorNum, RmTypeID, CafeID) 
values ('CR 01', 'Floor 1', (select RmTypeID from Room_Type where Type = 'eSports Conference Room' and Capacity = '4'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Room (RmNum, FloorNum, RmTypeID, CafeID) 
values ('CR 02', 'Floor 1', (select RmTypeID from Room_Type where Type = 'eSports Conference Room' and Capacity = '4'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Room (RmNum, FloorNum, RmTypeID, CafeID) 
values ('CR 03', 'Floor 2', (select RmTypeID from Room_Type where Type = 'eSports Conference Room' and Capacity = '6'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Room (RmNum, FloorNum, RmTypeID, CafeID) 
values ('CR 04', 'Floor 2', (select RmTypeID from Room_Type where Type = 'eSports Conference Room' and Capacity = '8'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Room (RmNum, FloorNum, RmTypeID, CafeID) 
values ('CR 05', 'Floor 2', (select RmTypeID from Room_Type where Type = 'eSports Conference Room' and Capacity = '10'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));

/* Insert Data into Section Type Table */
/* Default */
insert into Section_Type (Type, Name, Description) values ('None', 'None', 'Nonexistent Section');

insert into Section_Type (Type, Name, Description) values ('Lobby', 'Lobby A', 'This section have Mid Tier Gaming PC');
insert into Section_Type (Type, Name, Description) values ('Lobby', 'Lobby B', 'This section have Mid Tier Gaming PC');
insert into Section_Type (Type, Name, Description) values ('Lobby', 'Lobby C', 'This section have Mid Tier Gaming PC');
insert into Section_Type (Type, Name, Description) values ('Lobby', 'Lobby D', 'This section have Mid Tier Gaming PC');
insert into Section_Type (Type, Name, Description) values ('Lobby', 'Lobby E', 'This section have Mid Tier Gaming PC');

insert into Section_Type (Type, Name, Description) values ('eSports', 'eSports A', 'This section have High-End Gaming PC');
insert into Section_Type (Type, Name, Description) values ('eSports', 'eSports B', 'This section have High-End Gaming PC');
insert into Section_Type (Type, Name, Description) values ('eSports', 'eSports C', 'This section have High-End Gaming PC');

insert into Section_Type (Type, Name, Description) values ('Stage', 'Stage A', 'This section have High-End Gaming PC');
insert into Section_Type (Type, Name, Description) values ('Stage', 'Stage B', 'This section have High-End Gaming PC');

/* Insert Data into Lounge Seating Table */
/* Default */
insert into Lounge_Seating (SeatNum, Available) values ('None', 'Nonexistent');

insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('LA 01', (select SectionTypeID from Section_Type where Type = 'Lobby' and Name = 'Lobby A'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('LA 02', (select SectionTypeID from Section_Type where Type = 'Lobby' and Name = 'Lobby A'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('LA 03', (select SectionTypeID from Section_Type where Type = 'Lobby' and Name = 'Lobby A'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('LA 04', (select SectionTypeID from Section_Type where Type = 'Lobby' and Name = 'Lobby A'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('LA 05', (select SectionTypeID from Section_Type where Type = 'Lobby' and Name = 'Lobby A'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('LA 06', (select SectionTypeID from Section_Type where Type = 'Lobby' and Name = 'Lobby A'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('LA 07', (select SectionTypeID from Section_Type where Type = 'Lobby' and Name = 'Lobby A'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('LA 08', (select SectionTypeID from Section_Type where Type = 'Lobby' and Name = 'Lobby A'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('LA 09', (select SectionTypeID from Section_Type where Type = 'Lobby' and Name = 'Lobby A'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('LA 10', (select SectionTypeID from Section_Type where Type = 'Lobby' and Name = 'Lobby A'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));

insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('LB 01', (select SectionTypeID from Section_Type where Type = 'Lobby' and Name = 'Lobby B'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('LB 02', (select SectionTypeID from Section_Type where Type = 'Lobby' and Name = 'Lobby B'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('LB 03', (select SectionTypeID from Section_Type where Type = 'Lobby' and Name = 'Lobby B'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('LB 04', (select SectionTypeID from Section_Type where Type = 'Lobby' and Name = 'Lobby B'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('LB 05', (select SectionTypeID from Section_Type where Type = 'Lobby' and Name = 'Lobby B'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('LB 06', (select SectionTypeID from Section_Type where Type = 'Lobby' and Name = 'Lobby B'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('LB 07', (select SectionTypeID from Section_Type where Type = 'Lobby' and Name = 'Lobby B'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('LB 08', (select SectionTypeID from Section_Type where Type = 'Lobby' and Name = 'Lobby B'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('LB 09', (select SectionTypeID from Section_Type where Type = 'Lobby' and Name = 'Lobby B'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('LB 10', (select SectionTypeID from Section_Type where Type = 'Lobby' and Name = 'Lobby B'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));

insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('LC 01', (select SectionTypeID from Section_Type where Type = 'Lobby' and Name = 'Lobby C'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('LC 02', (select SectionTypeID from Section_Type where Type = 'Lobby' and Name = 'Lobby C'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('LC 03', (select SectionTypeID from Section_Type where Type = 'Lobby' and Name = 'Lobby C'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('LC 04', (select SectionTypeID from Section_Type where Type = 'Lobby' and Name = 'Lobby C'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('LC 05', (select SectionTypeID from Section_Type where Type = 'Lobby' and Name = 'Lobby C'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('LC 06', (select SectionTypeID from Section_Type where Type = 'Lobby' and Name = 'Lobby C'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('LC 07', (select SectionTypeID from Section_Type where Type = 'Lobby' and Name = 'Lobby C'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('LC 08', (select SectionTypeID from Section_Type where Type = 'Lobby' and Name = 'Lobby C'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('LC 09', (select SectionTypeID from Section_Type where Type = 'Lobby' and Name = 'Lobby C'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('LC 10', (select SectionTypeID from Section_Type where Type = 'Lobby' and Name = 'Lobby C'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));

insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('LD 01', (select SectionTypeID from Section_Type where Type = 'Lobby' and Name = 'Lobby D'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('LD 02', (select SectionTypeID from Section_Type where Type = 'Lobby' and Name = 'Lobby D'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('LD 03', (select SectionTypeID from Section_Type where Type = 'Lobby' and Name = 'Lobby D'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('LD 04', (select SectionTypeID from Section_Type where Type = 'Lobby' and Name = 'Lobby D'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('LD 05', (select SectionTypeID from Section_Type where Type = 'Lobby' and Name = 'Lobby D'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('LD 06', (select SectionTypeID from Section_Type where Type = 'Lobby' and Name = 'Lobby D'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('LD 07', (select SectionTypeID from Section_Type where Type = 'Lobby' and Name = 'Lobby D'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('LD 08', (select SectionTypeID from Section_Type where Type = 'Lobby' and Name = 'Lobby D'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('LD 09', (select SectionTypeID from Section_Type where Type = 'Lobby' and Name = 'Lobby D'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('LD 10', (select SectionTypeID from Section_Type where Type = 'Lobby' and Name = 'Lobby D'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));

insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('LE 01', (select SectionTypeID from Section_Type where Type = 'Lobby' and Name = 'Lobby E'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('LE 02', (select SectionTypeID from Section_Type where Type = 'Lobby' and Name = 'Lobby E'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('LE 03', (select SectionTypeID from Section_Type where Type = 'Lobby' and Name = 'Lobby E'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('LE 04', (select SectionTypeID from Section_Type where Type = 'Lobby' and Name = 'Lobby E'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('LE 05', (select SectionTypeID from Section_Type where Type = 'Lobby' and Name = 'Lobby E'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('LE 06', (select SectionTypeID from Section_Type where Type = 'Lobby' and Name = 'Lobby E'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('LE 07', (select SectionTypeID from Section_Type where Type = 'Lobby' and Name = 'Lobby E'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('LE 08', (select SectionTypeID from Section_Type where Type = 'Lobby' and Name = 'Lobby E'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('LE 09', (select SectionTypeID from Section_Type where Type = 'Lobby' and Name = 'Lobby E'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('LE 10', (select SectionTypeID from Section_Type where Type = 'Lobby' and Name = 'Lobby E'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));

insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('EA 01', (select SectionTypeID from Section_Type where Type = 'eSports' and Name = 'eSports A'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('EA 02', (select SectionTypeID from Section_Type where Type = 'eSports' and Name = 'eSports A'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('EA 03', (select SectionTypeID from Section_Type where Type = 'eSports' and Name = 'eSports A'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('EA 04', (select SectionTypeID from Section_Type where Type = 'eSports' and Name = 'eSports A'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('EA 05', (select SectionTypeID from Section_Type where Type = 'eSports' and Name = 'eSports A'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('EA 06', (select SectionTypeID from Section_Type where Type = 'eSports' and Name = 'eSports A'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('EA 07', (select SectionTypeID from Section_Type where Type = 'eSports' and Name = 'eSports A'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('EA 08', (select SectionTypeID from Section_Type where Type = 'eSports' and Name = 'eSports A'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('EA 09', (select SectionTypeID from Section_Type where Type = 'eSports' and Name = 'eSports A'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('EA 10', (select SectionTypeID from Section_Type where Type = 'eSports' and Name = 'eSports A'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));

insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('EB 01', (select SectionTypeID from Section_Type where Type = 'eSports' and Name = 'eSports B'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('EB 02', (select SectionTypeID from Section_Type where Type = 'eSports' and Name = 'eSports B'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('EB 03', (select SectionTypeID from Section_Type where Type = 'eSports' and Name = 'eSports B'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('EB 04', (select SectionTypeID from Section_Type where Type = 'eSports' and Name = 'eSports B'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('EB 05', (select SectionTypeID from Section_Type where Type = 'eSports' and Name = 'eSports B'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('EB 06', (select SectionTypeID from Section_Type where Type = 'eSports' and Name = 'eSports B'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('EB 07', (select SectionTypeID from Section_Type where Type = 'eSports' and Name = 'eSports B'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('EB 08', (select SectionTypeID from Section_Type where Type = 'eSports' and Name = 'eSports B'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('EB 09', (select SectionTypeID from Section_Type where Type = 'eSports' and Name = 'eSports B'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('EB 10', (select SectionTypeID from Section_Type where Type = 'eSports' and Name = 'eSports B'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));

insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('EC 01', (select SectionTypeID from Section_Type where Type = 'eSports' and Name = 'eSports C'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('EC 02', (select SectionTypeID from Section_Type where Type = 'eSports' and Name = 'eSports C'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('EC 03', (select SectionTypeID from Section_Type where Type = 'eSports' and Name = 'eSports C'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('EC 04', (select SectionTypeID from Section_Type where Type = 'eSports' and Name = 'eSports C'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('EC 05', (select SectionTypeID from Section_Type where Type = 'eSports' and Name = 'eSports C'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('EC 06', (select SectionTypeID from Section_Type where Type = 'eSports' and Name = 'eSports C'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('EC 07', (select SectionTypeID from Section_Type where Type = 'eSports' and Name = 'eSports C'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('EC 08', (select SectionTypeID from Section_Type where Type = 'eSports' and Name = 'eSports C'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('EC 09', (select SectionTypeID from Section_Type where Type = 'eSports' and Name = 'eSports C'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('EC 10', (select SectionTypeID from Section_Type where Type = 'eSports' and Name = 'eSports C'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));

insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('SA 01', (select SectionTypeID from Section_Type where Type = 'Stage' and Name = 'Stage A'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('SA 02', (select SectionTypeID from Section_Type where Type = 'Stage' and Name = 'Stage A'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('SA 03', (select SectionTypeID from Section_Type where Type = 'Stage' and Name = 'Stage A'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('SA 04', (select SectionTypeID from Section_Type where Type = 'Stage' and Name = 'Stage A'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('SA 05', (select SectionTypeID from Section_Type where Type = 'Stage' and Name = 'Stage A'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));

insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('SB 01', (select SectionTypeID from Section_Type where Type = 'Stage' and Name = 'Stage B'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('SB 01', (select SectionTypeID from Section_Type where Type = 'Stage' and Name = 'Stage B'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('SB 01', (select SectionTypeID from Section_Type where Type = 'Stage' and Name = 'Stage B'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('SB 01', (select SectionTypeID from Section_Type where Type = 'Stage' and Name = 'Stage B'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));
insert into Lounge_Seating (SeatNum, SectionTypeID, CafeID) values ('SB 01', (select SectionTypeID from Section_Type where Type = 'Stage' and Name = 'Stage B'), (select CafeID from Cafe where Name = 'Night Gaming Cafe'));

/* Insert Data into Room Reservation Table */
/* Member make Room Reservation form request */
insert into Room_Reservation (ResNum, Date, Type, NumPeople, StartTime, EndTime, MemID)
values ('V2024010502', '2024-01-05', 'VIP Room', '4', '12:00', 'Not Sure', (select MemID from Member where MemNum = '000000001'));
insert into Room_Reservation (ResNum, Date, Type, NumPeople, StartTime, EndTime, MemID)
values ('V2024010504', '2024-01-05', 'VIP Room', '10', '12:00', '01:00', (select MemID from Member where MemNum = '000000006'));
insert into Room_Reservation (ResNum, Date, Type, NumPeople, StartTime, EndTime, MemID)
values ('G2024010601', '2024-01-06', 'Gaming Room', '7', '18:00', '24:00', (select MemID from Member where MemNum = '000000004'));
insert into Room_Reservation (ResNum, Date, Type, NumPeople, StartTime, EndTime, MemID)
values ('S2024010901', '2024-01-09', 'eSports Conference Room', '9', '12:00', '01:00', (select MemID from Member where MemNum = '000000001'));
insert into Room_Reservation (ResNum, Date, Type, NumPeople, StartTime, EndTime, MemID)
values ('G2024010801', '2024-01-08', 'Gaming Room', '5', '17:00', '22:00', (select MemID from Member where MemNum = '000000003'));
insert into Room_Reservation (ResNum, Date, Type, NumPeople, StartTime, EndTime, MemID)
values ('S2024010301', '2024-01-03', 'eSports Conference Room', '9', '12:00', 'Not Sure', (select MemID from Member where MemNum = '000000009'));
insert into Room_Reservation (ResNum, Date, Type, NumPeople, StartTime, EndTime, MemID)
values ('V2024020105', '2024-02-01', 'VIP Room', '7', '19:00', 'Not Sure', (select MemID from Member where MemNum = '000000006'));
insert into Room_Reservation (ResNum, Date, Type, NumPeople, StartTime, EndTime, MemID)
values ('G2024020301', '2024-02-03', 'Gaming Room', '6', '14:00', '18:00', (select MemID from Member where MemNum = '000000004'));
insert into Room_Reservation (ResNum, Date, Type, NumPeople, StartTime, EndTime, MemID)
values ('V2024020303', '2024-02-03', 'VIP Room', '10', '13:00', 'Not Sure', (select MemID from Member where MemNum = '000000002'));
insert into Room_Reservation (ResNum, Date, Type, NumPeople, StartTime, EndTime, MemID)
values ('V2024020702', '2024-02-07', 'VIP Room', '9', '21:00', 'Not Sure', (select MemID from Member where MemNum = '000000007'));
insert into Room_Reservation (ResNum, Date, Type, NumPeople, StartTime, EndTime, MemID)
values ('V2024021002', '2024-02-10', 'VIP Room', '6', '12:00', 'Not Sure', (select MemID from Member where MemNum = '000000010'));

/* Insert Data into Seat Reservation Table */
/* Member make Seat Reservation form request */
insert into Seat_Reservation (ResNum, Date, Type, NumResSeats, StartTime, EndTime, MemID)
values ('L2024010501', '2024-01-05', 'Lobby ', '1', '12:00', 'Not Sure', (select MemID from Member where MemNum = '000000003'));
insert into Seat_Reservation (ResNum, Date, Type, NumResSeats, StartTime, EndTime, MemID)
values ('E2024010503', '2024-01-05', 'eSports', '2', '14:00', '22:00', (select MemID from Member where MemNum = '000000007'));
insert into Seat_Reservation (ResNum, Date, Type, NumResSeats, StartTime, EndTime, MemID)
values ('L2024010701', '2024-01-07', 'Lobby', '3', '16:00', 'Not Sure', (select MemID from Member where MemNum = '000000002'));
insert into Seat_Reservation (ResNum, Date, Type, NumResSeats, StartTime, EndTime, MemID)
values ('E2024010702', '2024-01-07', 'eSports', '5', '12:00', 'Not Sure', (select MemID from Member where MemNum = '000000001'));
insert into Seat_Reservation (ResNum, Date, Type, NumResSeats, StartTime, EndTime, MemID)
values ('L2024011001', '2024-01-10', 'Lobby', '1', '18:00', 'Not Sure', (select MemID from Member where MemNum = '000000008'));
insert into Seat_Reservation (ResNum, Date, Type, NumResSeats, StartTime, EndTime, MemID)
values ('S2024011101', '2024-01-11', 'Stage', '10', '12:00', 'Not Sure', (select MemID from Member where MemNum = '000000010'));
insert into Seat_Reservation (ResNum, Date, Type, NumResSeats, StartTime, EndTime, MemID)
values ('L2024011301', '2024-01-13', 'Lobby', '4', '14:00', '17:00', (select MemID from Member where MemNum = '000000009'));
insert into Seat_Reservation (ResNum, Date, Type, NumResSeats, StartTime, EndTime, MemID)
values ('L2024010602', '2024-01-06', 'Lobby', '7', '15:00', '23:00', (select MemID from Member where MemNum = '000000001'));
insert into Seat_Reservation (ResNum, Date, Type, NumResSeats, StartTime, EndTime, MemID)
values ('L2024011401', '2024-01-14', 'Lobby', '6', '16:00', 'Not Sure', (select MemID from Member where MemNum = '000000004'));
insert into Seat_Reservation (ResNum, Date, Type, NumResSeats, StartTime, EndTime, MemID)
values ('L2024011901', '2024-01-19', 'Lobby', '8', '12:00', '24:00', (select MemID from Member where MemNum = '000000005'));
insert into Seat_Reservation (ResNum, Date, Type, NumResSeats, StartTime, EndTime, MemID)
values ('L2024011302', '2024-01-13', 'Lobby', '1', '17:00', 'Not Sure', (select MemID from Member where MemNum = '000000007'));
insert into Seat_Reservation (ResNum, Date, Type, NumResSeats, StartTime, EndTime, MemID)
values ('L2024012201', '2024-01-22', 'Lobby', '2', '13:00', '20:00', (select MemID from Member where MemNum = '000000006'));
insert into Seat_Reservation (ResNum, Date, Type, NumResSeats, StartTime, EndTime, MemID)
values ('E2024012801', '2024-01-28', 'eSports', '6', '12:00', 'Not Sure', (select MemID from Member where MemNum = '000000010'));
insert into Seat_Reservation (ResNum, Date, Type, NumResSeats, StartTime, EndTime, MemID)
values ('L2024020101', '2024-02-01', 'Lobby', '1', '14:00', 'Not Sure', (select MemID from Member where MemNum = '000000010'));
insert into Seat_Reservation (ResNum, Date, Type, NumResSeats, StartTime, EndTime, MemID)
values ('E2024020102', '2024-02-01', 'eSports', '3', '16:00', 'Not Sure', (select MemID from Member where MemNum = '000000009'));
insert into Seat_Reservation (ResNum, Date, Type, NumResSeats, StartTime, EndTime, MemID)
values ('E2024020103', '2024-02-01', 'eSports', '2', '17:00', 'Not Sure', (select MemID from Member where MemNum = '000000008'));
insert into Seat_Reservation (ResNum, Date, Type, NumResSeats, StartTime, EndTime, MemID)
values ('E2024020104', '2024-02-01', 'eSports', '5', '18:00', 'Not Sure', (select MemID from Member where MemNum = '000000007'));
insert into Seat_Reservation (ResNum, Date, Type, NumResSeats, StartTime, EndTime, MemID)
values ('E2024020302', '2024-02-03', 'eSports', '4', '15:00', '23:00', (select MemID from Member where MemNum = '000000003'));
insert into Seat_Reservation (ResNum, Date, Type, NumResSeats, StartTime, EndTime, MemID)
values ('E2024020701', '2024-02-07', 'eSports', '3', '12:00', 'Not Sure', (select MemID from Member where MemNum = '000000010'));
insert into Seat_Reservation (ResNum, Date, Type, NumResSeats, StartTime, EndTime, MemID)
values ('L2024020106', '2024-02-01', 'Lobby', '3', '18:00', 'Not Sure', (select MemID from Member where MemNum = '000000005'));
insert into Seat_Reservation (ResNum, Date, Type, NumResSeats, StartTime, EndTime, MemID)
values ('E2024020703', '2024-02-07', 'eSports', '6', '15:00', '20:00', (select MemID from Member where MemNum = '000000004'));
insert into Seat_Reservation (ResNum, Date, Type, NumResSeats, StartTime, EndTime, MemID)
values ('E2024020801', '2024-02-08', 'eSports', '4', '14:00', '19:00', (select MemID from Member where MemNum = '000000001'));
insert into Seat_Reservation (ResNum, Date, Type, NumResSeats, StartTime, EndTime, MemID)
values ('L2024020107', '2024-02-01', 'Lobby', '1', '19:00', 'Not Sure', (select MemID from Member where MemNum = '000000004'));
insert into Seat_Reservation (ResNum, Date, Type, NumResSeats, StartTime, EndTime, MemID)
values ('L2024020108', '2024-02-01', 'Lobby', '2', '20:00', '24:00', (select MemID from Member where MemNum = '000000003'));
insert into Seat_Reservation (ResNum, Date, Type, NumResSeats, StartTime, EndTime, MemID)
values ('L2024020802', '2024-02-08', 'Lobby', '1', '18:00', 'Not Sure', (select MemID from Member where MemNum = '000000002'));
insert into Seat_Reservation (ResNum, Date, Type, NumResSeats, StartTime, EndTime, MemID)
values ('L2024021001', '2024-02-10', 'Lobby', '1', '14:00', '17:00', (select MemID from Member where MemNum = '000000007'));

/* Main Queries */
/* Look up all upcoming Seat Reservation for the year and month of 2024-01 order by reservation date and start time in ascending order */
select ResNum, Date, Type, NumResSeats, time_format(StartTime, "%h:%i %p") as StartTime, 
if (EndTime = 'Not Sure', 'Not Sure', time_format(EndTime, "%h:%i %p")) as EndTime from Seat_Reservation 
where year(Date) = '2024' and month(Date) = 1 order by Date, if (StartTime = '12:00', '12:00', StartTime) asc;

/* Look up  all upcoming Room Reservation for the year and month of 2024-01 order by reservation date and start time in ascending order */
select ResNum, Date, Type, NumPeople, time_format(StartTime, "%h:%i %p") as StartTime, 
if (EndTime = 'Not Sure', 'Not Sure', time_format(EndTime, "%h:%i %p")) as EndTime from Room_Reservation 
where year(Date) = '2024' and month(Date) = 1 order by Date, if (StartTime = '12:00', '12:00', StartTime) asc;

/* Look up all upcoming Seat Reservation with member first and last name for the year and month of 2024-01 order 
by reservation date and start time in ascending order */
select Seat_Reservation.ResNum, Seat_Reservation.Date, Seat_Reservation.Type, Seat_Reservation.NumResSeats, time_format(Seat_Reservation.StartTime, "%h:%i %p") as StartTime, 
if (Seat_Reservation.EndTime = 'Not Sure', 'Not Sure', time_format(Seat_Reservation.EndTime, "%h:%i %p")) as EndTime, Member.MemNum, Member.FirstName, Member.LastName
from Seat_Reservation inner join Member on Seat_Reservation.MemID = Member.MemID
where year(Seat_Reservation.Date) = '2024' and month(Seat_Reservation.Date) = 1 order by Seat_Reservation.Date, if (Seat_Reservation.StartTime = '12:00', '12:00', Seat_Reservation.StartTime) asc;

/* Look up all upcoming Room Reservation with member first and last name for the year and month of 2024-01 order 
by reservation date and start time in ascending order */
select Room_Reservation.ResNum, Room_Reservation.Date, Room_Reservation.Type, Room_Reservation.NumPeople, time_format(Room_Reservation.StartTime, "%h:%i %p") as StartTime, 
if (Room_Reservation.EndTime = 'Not Sure', 'Not Sure', time_format(Room_Reservation.EndTime, "%h:%i %p")) as EndTime, Member.MemNum, Member.FirstName, Member.LastName
from Room_Reservation inner join member on Room_Reservation.MemID = Member.MemID
where year(Room_Reservation.Date) = '2024' and month(Room_Reservation.Date) = 1 order by Room_Reservation.Date, if (Room_Reservation.StartTime = '12:00', '12:00', Room_Reservation.StartTime) asc;

/* Look up all upcoming Seat Reservation for Lobby for the month of 2024-01 in ascending order */
select ResNum, Date, Type, NumResSeats, time_format(StartTime, "%h:%i %p") as StartTime, 
if (EndTime = 'Not Sure', 'Not Sure', time_format(EndTime, "%h:%i %p")) as EndTime
from Seat_Reservation where Type = 'Lobby' and year(Date) = '2024' and month(Date) = 1 order by Date, if (StartTime = '12:00', '12:00', StartTime) asc;

/* Look up all upcoming Seat Reservation for eSports for the month of 2024-01 in ascending order */
select ResNum, Date, Type, NumResSeats, time_format(StartTime, "%h:%i %p") as StartTime, 
if (EndTime = 'Not Sure', 'Not Sure', time_format(EndTime, "%h:%i %p")) as EndTime
from Seat_Reservation where Type = 'eSports' and year(Date) = '2024' and month(Date) = 1 order by Date, if (StartTime = '12:00', '12:00', StartTime) asc;

/* Look up all upcoming Seat Reservation for Stage for the month of 2024-01 in ascending order */
select ResNum, Date, Type, NumResSeats, time_format(StartTime, "%h:%i %p") as StartTime, 
if (EndTime = 'Not Sure', 'Not Sure', time_format(EndTime, "%h:%i %p")) as EndTime
from Seat_Reservation where Type = 'Stage' and year(Date) = '2024' and month(Date) = 1 order by Date, if (StartTime = '12:00', '12:00', StartTime) asc;

/* Look up all upcoming Room Reservation for VIP Room for the month of 2024-01 in ascending order */
select ResNum, Date, Type, NumPeople, time_format(StartTime, "%h:%i %p") as StartTime, 
if (EndTime = 'Not Sure', 'Not Sure', time_format(EndTime, "%h:%i %p")) as EndTime
from Room_Reservation where Type = 'VIP Room' and year(Date) = '2024' and month(Date) = 1 order by Date, if (StartTime = '12:00', '12:00', StartTime) asc;

/* Look up all upcoming Room Reservation for Gaming Room for the month of 2024-01 in ascending order */
select ResNum, Date, Type, NumPeople, time_format(StartTime, "%h:%i %p") as StartTime, 
if (EndTime = 'Not Sure', 'Not Sure', time_format(EndTime, "%h:%i %p")) as EndTime
from Room_Reservation where Type = 'Gaming Room' and year(Date) = '2024' and month(Date) = 1 order by Date, if (StartTime = '12:00', '12:00', StartTime) asc;

/* Look up all upcoming Room Reservation for eSports Conference Room for the month of 2024-01 in ascending order */
select ResNum, Date, Type, NumPeople, time_format(StartTime, "%h:%i %p") as StartTime, 
if (EndTime = 'Not Sure', 'Not Sure', time_format(EndTime, "%h:%i %p")) as EndTime
from Room_Reservation where Type = 'eSports Conference Room' and year(Date) = '2024' and month(Date) = 1 order by Date, if (StartTime = '12:00', '12:00', StartTime) asc;

/* Look up all Seat Reservation on a day say 2024-02-01 between certain start times */
select ResNum, Date, Type, NumResSeats, time_format(StartTime, "%h:%i %p") as StartTime, 
if (EndTime = 'Not Sure', 'Not Sure', time_format(EndTime, "%h:%i %p")) as EndTime from Seat_Reservation 
where Date = '2024-02-01' order by Date, if (StartTime = '12:00', '12:00', StartTime) asc;
/* between 12:00 PM and 05:00 PM */
select ResNum, Date, Type, NumResSeats, time_format(StartTime, "%h:%i %p") as StartTime, 
if (EndTime = 'Not Sure', 'Not Sure', time_format(EndTime, "%h:%i %p")) as EndTime from Seat_Reservation 
where Date = '2024-02-01' and StartTime between '12:00' and '17:00' order by Date, if (StartTime = '12:00', '12:00', StartTime) asc;
/* between 06:00 PM and 12:00 AM */
select ResNum, Date, Type, NumResSeats, time_format(StartTime, "%h:%i %p") as StartTime, 
if (EndTime = 'Not Sure', 'Not Sure', time_format(EndTime, "%h:%i %p")) as EndTime from Seat_Reservation 
where Date = '2024-02-01' and StartTime between '18:00' and '24:00' order by Date, if (StartTime = '12:00', '12:00', StartTime) asc;

/* Count how many Seat Reservation where made for the year and month of 2024-01 */
select count(*) from Seat_Reservation where year(Seat_Reservation.Date) = '2024' and month(Seat_Reservation.Date) = 1;

/* Count how many Room Reservation where made for the year and month of 2024-01 */
select count(*) from Room_Reservation where year(Room_Reservation.Date) = '2024' and month(Room_Reservation.Date) = 1;

/* Check a Seat Reservation based on date and membership number */
select Seat_Reservation.ResNum, Seat_Reservation.Date, Seat_Reservation.Type, Seat_Reservation.NumResSeats, time_format(Seat_Reservation.StartTime, "%h:%i %p") as StartTime, 
if (Seat_Reservation.EndTime = 'Not Sure', 'Not Sure', time_format(Seat_Reservation.EndTime, "%h:%i %p")) as EndTime, 
Member.MemNum, Member.FirstName, Member.LastName from Seat_Reservation inner join Member on Seat_Reservation.MemID = Member.MemID 
where Seat_Reservation.Date = '2024-01-22' and Member.MemNum = '000000006';

/* Check a Room Reservation based on date and membership number */
select Room_Reservation.ResNum, Room_Reservation.Date, Room_Reservation.Type, Room_Reservation.NumPeople, time_format(Room_Reservation.StartTime, "%h:%i %p") as StartTime, 
if (Room_Reservation.EndTime = 'Not Sure', 'Not Sure', time_format(Room_Reservation.EndTime, "%h:%i %p")) as EndTime, 
Member.MemNum, Member.FirstName, Member.LastName from Room_Reservation inner join Member on Room_Reservation.MemID = Member.MemID 
where Room_Reservation.Date = '2024-01-09' and Member.MemNum = '000000001';

/* Check a Seat Reservation based on date and first name */
select Seat_Reservation.ResNum, Seat_Reservation.Date, Seat_Reservation.Type, Seat_Reservation.NumResSeats, time_format(Seat_Reservation.StartTime, "%h:%i %p") as StartTime, 
if (Seat_Reservation.EndTime = 'Not Sure', 'Not Sure', time_format(Seat_Reservation.EndTime, "%h:%i %p")) as EndTime, 
Member.MemNum, Member.FirstName, Member.LastName from Seat_Reservation inner join Member on Seat_Reservation.MemID = Member.MemID 
where Seat_Reservation.Date = '2024-02-01' and Member.FirstName = 'Thomas';

/* Check a Room Reservation based on date and first name */
select Room_Reservation.ResNum, Room_Reservation.Date, Room_Reservation.Type, Room_Reservation.NumPeople, time_format(Room_Reservation.StartTime, "%h:%i %p") as StartTime, 
if (Room_Reservation.EndTime = 'Not Sure', 'Not Sure', time_format(Room_Reservation.EndTime, "%h:%i %p")) as EndTime, 
Member.MemNum, Member.FirstName, Member.LastName from Room_Reservation inner join Member on Room_Reservation.MemID = Member.MemID 
where Room_Reservation.Date = '2024-02-07' and Member.FirstName = 'Frederique';

/* Check a Seat Reservation based on reservation number */
select Seat_Reservation.ResNum, Seat_Reservation.Date, Seat_Reservation.Type, Seat_Reservation.NumResSeats, time_format(Seat_Reservation.StartTime, "%h:%i %p") as StartTime, 
if (Seat_Reservation.EndTime = 'Not Sure', 'Not Sure', time_format(Seat_Reservation.EndTime, "%h:%i %p")) as EndTime, 
Member.MemNum, Member.FirstName, Member.LastName from Seat_Reservation inner join Member on Seat_Reservation.MemID = Member.MemID 
where Seat_Reservation.ResNum = 'E2024020701';

/* Check a Room Reservation based on reservation number */
select Room_Reservation.ResNum, Room_Reservation.Date, Room_Reservation.Type, Room_Reservation.NumPeople, time_format(Room_Reservation.StartTime, "%h:%i %p") as StartTime, 
if (Room_Reservation.EndTime = 'Not Sure', 'Not Sure', time_format(Room_Reservation.EndTime, "%h:%i %p")) as EndTime, 
Member.MemNum, Member.FirstName, Member.LastName from Room_Reservation inner join Member on Room_Reservation.MemID = Member.MemID 
where Room_Reservation.ResNum = 'V2024020105';

/* Update a Seat Reservation date from 2024-01-13 to 2024-01-15 */
update Seat_Reservation set Date = '2024-01-15' where (MemID = (select MemID from Member where MemNum = '000000007')) and (ResNum = 'L2024011302');
select ResNum, Date, Type, NumResSeats, time_format(StartTime, "%h:%i %p") as StartTime, 
if (EndTime = 'Not Sure', 'Not Sure', time_format(EndTime, "%h:%i %p")) as EndTime from Seat_Reservation 
where (MemID = (select MemID from Member where MemNum = '000000007')) and ResNum = 'L2024011302';

/* Update a Room Reservation date from 2024-02-03 to 2024-02-10 */
update Room_Reservation set Date = '2024-02-10' where (MemID = (select MemID from Member where MemNum = '000000004')) and (ResNum = 'G2024020301');
select ResNum, Date, Type, NumPeople, time_format(StartTime, "%h:%i %p") as StartTime, 
if (EndTime = 'Not Sure', 'Not Sure', time_format(EndTime, "%h:%i %p")) as EndTime from Room_Reservation 
where (MemID = (select MemID from Member where MemNum = '000000004')) and (ResNum = 'G2024020301');

/* Update a Seat Reservation start time to 05:00 PM from 03:00 PM */ 
update Seat_Reservation set StartTime = '15:00' where (MemID = (select MemID from Member where MemNum = '000000006')) and (ResNum = 'L2024012201');
select ResNum, Date, Type, NumResSeats, time_format(StartTime, "%h:%i %p") as StartTime, 
if (EndTime = 'Not Sure', 'Not Sure', time_format(EndTime, "%h:%i %p")) as EndTime from Seat_Reservation 
where (MemID = (select MemID from Member where MemNum = '000000006')) and (ResNum = 'L2024012201');

/* Update a Room Reservation start time to 02:00 PM from 12:00 PM */ 
update Room_Reservation set StartTime = '14:00' where (MemID = (select MemID from Member where MemNum = '000000006')) and (ResNum = 'V2024010504');
select ResNum, Date, Type, NumPeople, time_format(StartTime, "%h:%i %p") as StartTime, 
if (EndTime = 'Not Sure', 'Not Sure', time_format(EndTime, "%h:%i %p")) as EndTime from Room_Reservation 
where (MemID = (select MemID from Member where MemNum = '000000006')) and (ResNum = 'V2024010504');

/* Canceling/Delete a Seat Reservation */
delete from Seat_Reservation where (MemID = (select MemID from Member where MemNum = '000000005')) and (ResNum = 'L2024011901');
select ResNum, Date, Type, NumResSeats, time_format(StartTime, "%h:%i %p") as StartTime, 
if (EndTime = 'Not Sure', 'Not Sure', time_format(EndTime, "%h:%i %p")) as EndTime from Seat_Reservation 
where (MemID = (select MemID from Member where MemNum = '000000005')) and (ResNum = 'L2024011901');

/* Canceling/Delete a Room Reservation */
delete from Room_Reservation where (MemID = (select MemID from Member where MemNum = '000000002')) and (ResNum = 'V2024020303');
select ResNum, Date, Type, NumPeople, time_format(StartTime, "%h:%i %p") as StartTime, 
if (EndTime = 'Not Sure', 'Not Sure', time_format(EndTime, "%h:%i %p")) as EndTime from Room_Reservation 
where (MemID = (select MemID from Member where MemNum = '000000002')) and (ResNum = 'V2024020303');

/* Staff Preparing a live service for the next day  */
/* 2024-01-05 example */
/* Check all up comming Seat Reservation */
select Seat_Reservation.ResNum, Seat_Reservation.Date, Seat_Reservation.Type, Seat_Reservation.NumResSeats, time_format(Seat_Reservation.StartTime, "%h:%i %p") as StartTime, 
if (Seat_Reservation.EndTime = 'Not Sure', 'Not Sure', time_format(Seat_Reservation.EndTime, "%h:%i %p")) as EndTime, Lounge_Seating.SeatNum, Member.MemNum, Member.FirstName, Member.LastName 
from (Seat_Reservation inner join Member on Seat_Reservation.MemID = Member.MemID) inner join Lounge_Seating on Seat_Reservation.LoungeSeatID = Lounge_Seating.LoungeSeatID
where Date = '2024-01-05' order by Date, if (StartTime = '12:00', '12:00', StartTime) asc;
/* Check seat availability for Lobby */
select Lounge_Seating.SeatNum, Lounge_Seating.Available, Section_Type.Type, Section_Type.Name, Section_Type.Description
from Lounge_Seating inner join Section_Type on Lounge_Seating.SectionTypeID = Section_Type.SectionTypeID
where Section_Type.Type = 'Lobby' and Lounge_Seating.Available = 'Y';
/* Update and add more records accordingly to the Number of Reserved Seats for Lobby Seat Reservation  */
update Seat_Reservation set LoungeSeatID = (select LoungeSeatID from Lounge_Seating where SeatNum = 'LA 01') where ResNum = 'L2024010501' and SeatResID > 0;
/* Update seat availability */
update Lounge_Seating set Available = 'N' where SeatNum = 'LA 01' and LoungeSeatID > 0;
/* Check seat availability for eSports */
select Lounge_Seating.SeatNum, Lounge_Seating.Available, Section_Type.Type, Section_Type.Name, Section_Type.Description
from Lounge_Seating inner join Section_Type on Lounge_Seating.SectionTypeID = Section_Type.SectionTypeID
where Section_Type.Type = 'eSports' and Lounge_Seating.Available = 'Y';
/* Update and add more records accordingly to the Number of Reserved Seats for eSports Seat Reservation  */
update Seat_Reservation set LoungeSeatID = (select LoungeSeatID from Lounge_Seating where SeatNum = 'EA 01') where ResNum = 'E2024010503' and SeatResID > 0;
insert into Seat_Reservation (ResNum, Date, Type, NumResSeats, StartTime, EndTime, LoungeSeatID, MemID)
values ('E2024010503', '2024-01-05', 'eSports', '2', '14:00', '22:00', (select LoungeSeatID from Lounge_Seating where SeatNum = 'EA 03'), (select MemID from Member where MemNum = '000000007'));
/* Update seat availability */
update Lounge_Seating set Available = 'N' where SeatNum = 'EA 01' and LoungeSeatID > 0;
update Lounge_Seating set Available = 'N' where SeatNum = 'EA 02' and LoungeSeatID > 0;
/* Show all unavailable seats in Lounge_Seating */
select Lounge_Seating.SeatNum, Lounge_Seating.Available, Section_Type.Type, Section_Type.Name, Section_Type.Description
from Lounge_Seating inner join Section_Type on Lounge_Seating.SectionTypeID = Section_Type.SectionTypeID
where Lounge_Seating.Available = 'N';
/* Check all up comming Room Reservation */
select Room_Reservation.ResNum, Room_Reservation.Date, Room_Reservation.Type, Room_Reservation.NumPeople, time_format(Room_Reservation.StartTime, "%h:%i %p") as StartTime, 
if (Room_Reservation.EndTime = 'Not Sure', 'Not Sure', time_format(Room_Reservation.EndTime, "%h:%i %p")) as EndTime, Room.RmNum, Member.MemNum, Member.FirstName, Member.LastName 
from (Room_Reservation inner join Member on Room_Reservation.MemID = Member.MemID) inner join Room on Room_Reservation.RmID = Room.RmID
where Date = '2024-01-05' order by Date, if (StartTime = '12:00', '12:00', StartTime) asc;
/* Check seat availability for VIP Room where Capacity is more than 4 people */
select Room.RmNum, Room.Available, Room_Type.Type, Room_Type.Capacity, Room_Type.Name, Room_Type.Description
from Room inner join Room_Type on Room.RmTypeID = Room_Type.RmTypeID
where Room_Type.Type = 'VIP Room' and cast(cast(Room_Type.Capacity as char) as signed) >= 4 and Room.Available = 'Y';
/* Update Room Reservation  */
update Room_Reservation set RmID = (select RmID from Room where RmNum = 'VR 01') where ResNum = 'V2024010502' and RmResID > 0;
/* Update Room availability */
update Room set Available = 'N' where RmNum = 'VR 01' and RmID > 0;
/* Check seat availability for VIP Room where Capacity is more than 10 people */
select Room.RmNum, Room.Available, Room_Type.Type, Room_Type.Capacity, Room_Type.Name, Room_Type.Description
from Room inner join Room_Type on Room.RmTypeID = Room_Type.RmTypeID
where Room_Type.Type = 'VIP Room' and cast(cast(Room_Type.Capacity as char) as signed) >= 10 and Room.Available = 'Y';
/* Update Room Reservation  */
update Room_Reservation set RmID = (select RmID from Room where RmNum = 'VR 05') where ResNum = 'V2024010504' and RmResID > 0;
/* Update Room availability */
update Room set Available = 'N' where RmNum = 'VR 05' and RmID > 0;
/* Show all unavailable rooms in Room */
select Room.RmNum, Room.Available, Room_Type.Type, Room_Type.Capacity, Room_Type.Name, Room_Type.Description
from Room inner join Room_Type on Room.RmTypeID = Room_Type.RmTypeID
where Room.Available = 'N';

/* Day of Reservation */
/* Member ask for their seat number upon arrival */
/* Confirm by Reservation Num */
select Lounge_Seating.SeatNum from Lounge_Seating inner join Seat_Reservation on Lounge_Seating.LoungeSeatID = Seat_Reservation.LoungeSeatID
where Seat_Reservation.ResNum = 'L2024010501';
select Room.RmNum from Room inner join Room_Reservation on Room.RmID = Room_Reservation.RmID
where Room_Reservation.ResNum = 'V2024010502';
select Room.RmNum from Room inner join Room_Reservation on Room.RmID = Room_Reservation.RmID
where Room_Reservation.ResNum = 'V2024010504';
/* Confirm by Name and Date */
select Lounge_Seating.SeatNum from (Lounge_Seating inner join Seat_Reservation on Lounge_Seating.LoungeSeatID = Seat_Reservation.LoungeSeatID) 
inner join Member on Seat_Reservation.MemID = Member.MemID where Seat_Reservation.Date = '2024-01-05' and Member.FirstName = 'Frederique';

/* Reset Seat availability for next day when cafe closes  */
update Lounge_Seating set Available = 'Y' where  LoungeSeatID > 0;
update Room set Available = 'Y' where  RmID > 0;

/* Change active status of a Staff and make the Staff account inactive */
update Staff set UserName = '', Password = '', DateOfBirth = '1000-10-10', Email = '', Phone = '', Active = 'N' where StaffNum = '000003' and StaffID > 0;
select * from Staff where Active = 'N';

/* Change active status of a Member and make member account inactive */
update Member set CardBalance = 0 where MemNum = '000000009' and MemID > 0;
update Member set UserName = '', Password = '', DateOfBirth = '1000-10-10', Email = '', Phone = '', Active = 'N' 
where MemNum = '000000009' and MemID > 0;
select * from Member where Active = 'N';
