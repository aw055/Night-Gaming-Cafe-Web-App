/* 
    Night Gaming Cafe Web Application
    Setup Database 'Night_Gaming_Cafe'
*/

/* Drop Night_Gaming_Cafe Database if it exist */
drop database if exists Night_Gaming_Cafe;
/* Create Night_Gaming_Cafe Database */
create database Night_Gaming_Cafe;

/* Use Night_Gaming_Cafe Database */
use Night_Gaming_Cafe;

/* Create Tables for Night_Gaming_Cafe Database */
/* Create Account Table */
drop table if exists Account;
create table Account (
    ID int auto_increment primary key,
    UserName varchar(50) not null,
    Password varchar(100) not null, /* store sha1('password') */
    Email varchar(255) not null,
    Active enum('Y','N') not null default 'Y',
    /* Check for duplicates */
    unique key (UserName, Password, Email),
    unique key (UserName), 
    unique key (Email)
);

/* Insert Data into Account Table */
insert into Account (UserName, Password, Email) values 
('000000001', sha1('pass1'), 'email1'),
('000000002', sha1('pass2'), 'email2'),
('000000003', sha1('pass3'), 'email3'),
('000000004', sha1('pass4'), 'email4'),
('000000005', sha1('pass5'), 'email5'),
('000000006', sha1('pass6'), 'email6'),
('000000007', sha1('pass7'), 'email7'),
('000000008', sha1('pass8'), 'email8'),
('000000009', sha1('pass9'), 'email9'),
('000000010', sha1('pass10'), 'email10');

/* Create Member Table */
drop table if exists Member;
create table Member (
    ID int auto_increment primary key,
    MemNum varchar(9) not null,
    FirstName varchar(50) not null,
    LastName varchar(50) not null,
    DOB date not null,
    Phone varchar(15) not null,
    CardBalance decimal(5,2) not null default 0,
    RegisterDate date not null default (current_date),
    AcctID int not null,
    constraint foreign key (AcctID) references Account(ID),
    /* Check for duplicates */
    unique key (MemNum, FirstName, LastName, DOB, Phone, CardBalance, RegisterDate, AcctID),
    unique key (MemNum), 
    unique key (Phone),
    unique key (AcctID)
);

/* Insert Data into Member Table */
insert into Member (MemNum, FirstName, LastName, DOB, Phone, CardBalance, RegisterDate, AcctID) values 
('000000001', 'Maria', 'Anders', '2005-01-18', '111-111-1111', 50.00, '2023-12-30', 1),
('000000002', 'Ana', 'Trujillo', '2000-02-23', '111-111-1112', 75.00, '2023-12-30', 2),
('000000003', 'Antonio', 'Moreno', '2003-03-20', '111-111-1113', 100.00, '2023-12-30', 3),
('000000004', 'Thomas', 'Hardy', '1991-04-30', '111-111-1114', 200.00, '2023-12-30', 4),
('000000005', 'Christina', 'Berglund', '1995-05-28', '111-111-1115', 20.00, '2023-12-30', 5),
('000000006', 'Hanna', 'Moos', '2001-06-22', '111-111-1116', 150.00, '2023-12-30', 6),
('000000007', 'Frederique', 'Citeaux', '1999-07-24', '111-111-1117', 30.00, '2023-12-30', 7),
('000000008', 'Martin', 'Sommer', '1997-08-26', '111-111-1118', 110.00, '2023-12-30', 8),
('000000009', 'Laurence', 'Jebojams', '1989-09-14', '111-111-1119', 5.00, '2023-12-30', 9),
('000000010', 'Elizabeth', 'Lincoln', '1993-10-30', '111-111-1110', 75.00, '2023-12-30', 10);

/* Create Cafe Table */
drop table if exists Cafe;
create table Cafe (
    ID int auto_increment primary key,
    Name varchar(255) not null,
    Address varchar(255) not null,
    Postcode varchar(7) not null,
    City varchar(50) not null,
    Prov varchar(50) not null,
    Country varchar(50) not null,
    NumRooms smallint not null,
    Phone varchar(15) not null,
    /* Check for duplicates */
    unique key (Name, Address, Postcode, City, Prov, Country, NumRooms, Phone),
    unique key (Name),
    unique key (Address),
    unique key (Postcode),
    unique key (Phone)
);

/* Insert Data into Cafe Table */
insert into Cafe (Name, Address, Postcode, City, Prov, Country, NumRooms, Phone) values
('Night Gaming Cafe', '123 Temp Placeholder St', 'ABC 456', 'Toronto', 'Ontario', 'Canada', 16, '123-456-7890');

/* Create Room_Type Table */
drop table if exists Room_Type;
create table Room_Type (
    ID int auto_increment primary key,
    Type enum('Lounge','Gaming Room','VIP Room','EC Room','None','Nonexistent') not null,
    FloorNum varchar(7) not null,
    Capacity smallint not null,
    Price decimal(5,2) not null,
    DefaultPrice decimal(5,2) not null,
    Description varchar(100),
    /* Check for duplicates */
    unique key (Type, FloorNum, Capacity, Price, DefaultPrice, Description)
);

/* Insert Data into Room_Type Table */
insert into Room_Type (Type, FloorNum, Capacity, Price, DefaultPrice, Description) values
/* default base case */
('None', 'None', 0, 0, 0, 'Not Selected'),
/* case deletion of a room */
('Nonexistent', 'None', 0, 0, 0, 'Nonexistent Room'),
('Lounge', 'Floor 1', 90, 0, 0, 'Lounge Room charge by seat price depending on section of where the seat is located'),
('Gaming Room', 'Floor 1', 4, 40, 40, 'Have 4 Mid Tier Gaming PC'),
('Gaming Room', 'Floor 1', 6, 60, 60, 'Have 6 Mid Tier Gaming PC'),
('Gaming Room', 'Floor 1', 8, 80, 80, 'Have 8 Mid Tier Gaming PC'),
('Gaming Room', 'Floor 1', 10, 100, 100, 'Have 10 Mid Tier Gaming PC'),
('VIP Room', 'Floor 1', 4, 50, 50, 'Have 4 High-End Gaming PC'),
('VIP Room', 'Floor 1', 6, 70, 70, 'Have 6 High-End Gaming PC'),
('VIP Room', 'Floor 2', 8, 90, 90, 'Have 8 High-End Gaming PC'),
('VIP Room', 'Floor 2', 10, 110, 110, 'Have 10 High-End Gaming PC'),
('EC Room', 'Floor 2', 4, 60, 60, 'Have 4 High-End Gaming PC, One large Projector Screen, Ideal for eSport team meetings'),
('EC Room', 'Floor 2', 6, 80, 80, 'Have 6 High-End Gaming PC, One large Projector Screen, Ideal for eSport team meetings'),
('EC Room', 'Floor 2', 8, 100, 100, 'Have 8 High-End Gaming PC, One large Projector Screen, Ideal for eSport team meetings'),
('EC Room', 'Floor 2', 10, 120, 120, 'Have 10 High-End Gaming PC, One large Projector Screen, Ideal for eSport team meetings');

/* Create Room Table */
drop table if exists Room;
create table Room (
    ID int auto_increment primary key,
    RmNum varchar(15) not null,
    Available enum('Y','N','None') not null,
    Reserve enum('Y','N') not null default 'N',
    RmTypeID int not null,
    CafeID int not null,
    constraint foreign key (RmTypeID) references Room_Type(ID),
    constraint foreign key (CafeID) references Cafe(ID),
    /* Check for duplicates */
    unique key (RmNum, Available, Reserve, RmTypeID, CafeID),
    unique key (RmNum)
);

/* Insert Data into Room Table */
insert into Room (RmNum, Available, RmTypeID, CafeID) values
/* default base case */
('Not Selected', 'None', 1, 1),
/* case deletion of a room */
('Nonexistent', 'None', 2, 1),
('Main Lounge', 'Y', 3, 1),
('GR 01', 'Y', 4, 1),
('GR 02', 'Y', 4, 1),
('GR 03', 'Y', 5, 1),
('GR 04', 'Y', 6, 1),
('GR 05', 'Y', 7, 1),
('VR 01', 'Y', 8, 1),
('VR 02', 'Y', 8, 1),
('VR 03', 'Y', 9, 1),
('VR 04', 'Y', 10, 1),
('VR 05', 'Y', 11, 1),
('CR 01', 'Y', 12, 1),
('CR 02', 'Y', 12, 1),
('CR 03', 'Y', 13, 1),
('CR 04', 'Y', 14, 1),
('CR 05', 'Y', 15, 1);

/* Create Section Table */
drop table if exists Section;
create table Section (
    ID int auto_increment primary key,
    Type enum('Lobby','eSports','Stage') not null,
    Name varchar(11) not null,
    Description varchar(100),
    RmID int not null,
    constraint foreign key (RmID) references Room(ID),
    /* Check for duplicates */
    unique key (Type, Name, Description, RmID),
    unique key (Name)
);

/* Insert Data into Section Table */
insert into Section (Type, Name, Description, RmID) values
('Lobby', 'Lobby A', 'This section have Mid Tier Gaming PC', 3),
('Lobby', 'Lobby B', 'This section have Mid Tier Gaming PC', 3),
('Lobby', 'Lobby C', 'This section have Mid Tier Gaming PC', 3),
('Lobby', 'Lobby D', 'This section have Mid Tier Gaming PC', 3),
('Lobby', 'Lobby E', 'This section have Mid Tier Gaming PC', 3),
('eSports', 'eSports A', 'This section have High-End Gaming PC', 3),
('eSports', 'eSports B', 'This section have High-End Gaming PC', 3),
('eSports', 'eSports C', 'This section have High-End Gaming PC', 3),
('Stage', 'Stage A', 'This section have High-End Gaming PC', 3),
('Stage', 'Stage B', 'This section have High-End Gaming PC', 3);

/* Create Seat_Type Table */
drop table if exists Seat_Type;
create table Seat_Type (
    ID int auto_increment primary key,
    Type enum('Lobby','eSports','Stage') not null,
    Price decimal(4,2) not null,
    DefaultPrice decimal(4,2) not null,
    Description varchar(100),
    /* Check for duplicates */
    unique key (Type, Price, DefaultPrice, Description),
    unique key (Type)
);

/* Insert Data into Seat_Type Table */
insert into Seat_Type (Type, Price, DefaultPrice, Description) values
('Lobby', 6.50, 6.50, 'Uses Mid Tier Gaming PC'),
('eSports', 11, 11, 'Uses High-End Gaming PC'),
('Stage', 13, 13, 'Mainly used for eSports competition between teams, tournaments and events');

/* Create Seat Table */
drop table if exists Seat;
create table Seat (
    ID int auto_increment primary key,
    SeatNum varchar(5) not null default '',
    Available enum('Y', 'N') not null,
    Reserve enum('Y', 'N') not null default 'N',
    RmID int not null,
    SeatTypeID int not null,
    SectionID int not null,
    constraint foreign key (RmID) references Room(ID),
    constraint foreign key (SeatTypeID) references Seat_Type(ID),
    constraint foreign key (SectionID) references Section(ID),
    /* Check for duplicates */
    unique key (SeatNum, Available, Reserve, RmID, SeatTypeID, SectionID),
    unique key (SeatNum)
);

/* Insert Data into Seat Table */
insert into Seat (SeatNum, Available, RmID, SeatTypeID, SectionID) values
('LA 01', 'Y', 3, 1, 1), ('LA 02', 'Y', 3, 1, 1), ('LA 03', 'Y', 3, 1, 1), ('LA 04', 'Y', 3, 1, 1), ('LA 05', 'Y', 3, 1, 1),
('LA 06', 'Y', 3, 1, 1), ('LA 07', 'Y', 3, 1, 1), ('LA 08', 'Y', 3, 1, 1), ('LA 09', 'Y', 3, 1, 1), ('LA 10', 'Y', 3, 1, 1),
('LB 01', 'Y', 3, 1, 2), ('LB 02', 'Y', 3, 1, 2), ('LB 03', 'Y', 3, 1, 2), ('LB 04', 'Y', 3, 1, 2), ('LB 05', 'Y', 3, 1, 2),
('LB 06', 'Y', 3, 1, 2), ('LB 07', 'Y', 3, 1, 2), ('LB 08', 'Y', 3, 1, 2), ('LB 09', 'Y', 3, 1, 2), ('LB 10', 'Y', 3, 1, 2),
('LC 01', 'Y', 3, 1, 3), ('LC 02', 'Y', 3, 1, 3), ('LC 03', 'Y', 3, 1, 3), ('LC 04', 'Y', 3, 1, 3), ('LC 05', 'Y', 3, 1, 3),
('LC 06', 'Y', 3, 1, 3), ('LC 07', 'Y', 3, 1, 3), ('LC 08', 'Y', 3, 1, 3), ('LC 09', 'Y', 3, 1, 3), ('LC 10', 'Y', 3, 1, 3),
('LD 01', 'Y', 3, 1, 4), ('LD 02', 'Y', 3, 1, 4), ('LD 03', 'Y', 3, 1, 4), ('LD 04', 'Y', 3, 1, 4), ('LD 05', 'Y', 3, 1, 4),
('LD 06', 'Y', 3, 1, 4), ('LD 07', 'Y', 3, 1, 4), ('LD 08', 'Y', 3, 1, 4), ('LD 09', 'Y', 3, 1, 4), ('LD 10', 'Y', 3, 1, 4),
('LE 01', 'Y', 3, 1, 5), ('LE 02', 'Y', 3, 1, 5), ('LE 03', 'Y', 3, 1, 5), ('LE 04', 'Y', 3, 1, 5), ('LE 05', 'Y', 3, 1, 5),
('LE 06', 'Y', 3, 1, 5), ('LE 07', 'Y', 3, 1, 5), ('LE 08', 'Y', 3, 1, 5), ('LE 09', 'Y', 3, 1, 5), ('LE 10', 'Y', 3, 1, 5),
('EA 01', 'Y', 3, 2, 6), ('EA 02', 'Y', 3, 2, 6), ('EA 03', 'Y', 3, 2, 6), ('EA 04', 'Y', 3, 2, 6), ('EA 05', 'Y', 3, 2, 6),
('EA 06', 'Y', 3, 2, 6), ('EA 07', 'Y', 3, 2, 6), ('EA 08', 'Y', 3, 2, 6), ('EA 09', 'Y', 3, 2, 6), ('EA 10', 'Y', 3, 2, 6),
('EB 01', 'Y', 3, 2, 7), ('EB 02', 'Y', 3, 2, 7), ('EB 03', 'Y', 3, 2, 7), ('EB 04', 'Y', 3, 2, 7), ('EB 05', 'Y', 3, 2, 7),
('EB 06', 'Y', 3, 2, 7), ('EB 07', 'Y', 3, 2, 7), ('EB 08', 'Y', 3, 2, 7), ('EB 09', 'Y', 3, 2, 7), ('EB 10', 'Y', 3, 2, 7),
('EC 01', 'Y', 3, 2, 8), ('EC 02', 'Y', 3, 2, 8), ('EC 03', 'Y', 3, 2, 8), ('EC 04', 'Y', 3, 2, 8), ('EC 05', 'Y', 3, 2, 8),
('EC 06', 'Y', 3, 2, 8), ('EC 07', 'Y', 3, 2, 8), ('EC 08', 'Y', 3, 2, 8), ('EC 09', 'Y', 3, 2, 8), ('EC 10', 'Y', 3, 2, 8),
('SA 01', 'Y', 3, 3, 9), ('SA 02', 'Y', 3, 3, 9), ('SA 03', 'Y', 3, 3, 9), ('SA 04', 'Y', 3, 3, 9), ('SA 05', 'Y', 3, 3, 9),
('SB 01', 'Y', 3, 3, 10), ('SB 02', 'Y', 3, 3, 10), ('SB 03', 'Y', 3, 3, 10), ('SB 04', 'Y', 3, 3, 10), ('SB 05', 'Y', 3, 3, 10);

/* Create Booking Table */
drop table if exists Booking;
create table Booking (
    ID int auto_increment primary key,
    BkNum varchar(11) not null,
    Date date not null,
    Type enum('Gaming Room','VIP Room','EC Room','Lounge Lobby','Lounge eSports','Lounge Stage') not null,
    NumPeople enum('1','2','3','4','5','6','7','8','9','10') not null,
    StartTime enum('12:00','13:00','14:00','15:00','16:00','17:00','18:00','19:00','20:00','21:00') not null,
    EndTime enum('Not Sure','13:00','14:00','15:00','16:00','17:00','18:00','19:00','20:00','21:00','22:00','23:00','24:00','01:00','02:00') not null default 'Not Sure',
    EmplNotes varchar(100) default '',
    MemID int not null,
    RmID int not null default 1,
    CafeID int not null,
    constraint foreign key (MemID) references Member(ID),
    constraint foreign key (RmID) references Room(ID),
    constraint foreign key (CafeID) references Cafe(ID),
    /* Check for duplicates */
    unique key (BkNum, Date, Type, NumPeople, StartTime, EndTime, EmplNotes, MemID, RmID, CafeID),
    unique key (BkNum)
);

/* Insert Data into Booking Table */
insert into Booking (BkNum, Date, Type, NumPeople, StartTime, EndTime, MemID, RmID, CafeID) values
('V2024010502', '2024-01-05', 'VIP Room', '4', '12:00', 'Not Sure', (select ID from Member where MemNum = '000000001'), 1, 1),
('V2024010504', '2024-01-05', 'VIP Room', '10', '12:00', '01:00', (select ID from Member where MemNum = '000000006'), 1, 1),
('G2024010601', '2024-01-06', 'Gaming Room', '7', '18:00', '24:00', (select ID from Member where MemNum = '000000004'), 1, 1),
('S2024010901', '2024-01-09', 'EC Room', '9', '12:00', '01:00', (select ID from Member where MemNum = '000000001'), 1, 1),
('S2024010301', '2024-01-03', 'EC Room', '9', '12:00', 'Not Sure', (select ID from Member where MemNum = '000000009'), 1, 1),
('V2024020105', '2024-02-01', 'VIP Room', '7', '19:00', 'Not Sure', (select ID from Member where MemNum = '000000006'), 1, 1),
('G2024020301', '2024-02-03', 'Gaming Room', '6', '14:00', '18:00', (select ID from Member where MemNum = '000000004'), 1, 1),
('V2024020303', '2024-02-03', 'VIP Room', '10', '13:00', 'Not Sure', (select ID from Member where MemNum = '000000002'), 1, 1),
('V2024020702', '2024-02-07', 'VIP Room', '9', '21:00', 'Not Sure', (select ID from Member where MemNum = '000000007'), 1, 1),
('V2024021002', '2024-02-10', 'VIP Room', '6', '12:00', 'Not Sure', (select ID from Member where MemNum = '000000010'), 1, 1),
('L2024010501', '2024-01-05', 'Lounge Lobby', '1', '12:00', 'Not Sure', (select ID from Member where MemNum = '000000003'), 3, 1),
('E2024010503', '2024-01-05', 'Lounge eSports', '2', '14:00', '22:00', (select ID from Member where MemNum = '000000007'), 3, 1),
('L2024010701', '2024-01-07', 'Lounge Lobby', '3', '16:00', 'Not Sure', (select ID from Member where MemNum = '000000002'), 3, 1),
('E2024010702', '2024-01-07', 'Lounge eSports', '5', '12:00', 'Not Sure', (select ID from Member where MemNum = '000000001'), 3, 1),
('L2024011001', '2024-01-10', 'Lounge Lobby', '1', '18:00', 'Not Sure', (select ID from Member where MemNum = '000000008'), 3, 1),
('S2024011101', '2024-01-11', 'Lounge Stage', '10', '12:00', 'Not Sure', (select ID from Member where MemNum = '000000010'), 3, 1),
('L2024011301', '2024-01-13', 'Lounge Lobby', '4', '14:00', '17:00', (select ID from Member where MemNum = '000000009'), 3, 1),
('L2024010602', '2024-01-06', 'Lounge Lobby', '7', '15:00', '23:00', (select ID from Member where MemNum = '000000001'), 3, 1),
('L2024011401', '2024-01-14', 'Lounge Lobby', '6', '16:00', 'Not Sure', (select ID from Member where MemNum = '000000004'), 3, 1),
('L2024011901', '2024-01-19', 'Lounge Lobby', '8', '12:00', '24:00', (select ID from Member where MemNum = '000000005'), 3, 1),
('L2024011302', '2024-01-13', 'Lounge Lobby', '1', '17:00', 'Not Sure', (select ID from Member where MemNum = '000000007'), 3, 1),
('L2024012201', '2024-01-22', 'Lounge Lobby', '2', '13:00', '20:00', (select ID from Member where MemNum = '000000006'), 3, 1),
('E2024012801', '2024-01-28', 'Lounge eSports', '6', '12:00', 'Not Sure', (select ID from Member where MemNum = '000000010'), 3, 1),
('L2024020101', '2024-02-01', 'Lounge Lobby', '1', '14:00', 'Not Sure', (select ID from Member where MemNum = '000000010'), 3, 1),
('E2024020102', '2024-02-01', 'Lounge eSports', '3', '16:00', 'Not Sure', (select ID from Member where MemNum = '000000009'), 3, 1),
('E2024020103', '2024-02-01', 'Lounge eSports', '2', '17:00', 'Not Sure', (select ID from Member where MemNum = '000000008'), 3, 1),
('E2024020104', '2024-02-01', 'Lounge eSports', '5', '18:00', 'Not Sure', (select ID from Member where MemNum = '000000007'), 3, 1),
('E2024020302', '2024-02-03', 'Lounge eSports', '4', '15:00', '23:00', (select ID from Member where MemNum = '000000003'), 3, 1),
('E2024020701', '2024-02-07', 'Lounge eSports', '3', '12:00', 'Not Sure', (select ID from Member where MemNum = '000000010'), 3, 1),
('L2024020106', '2024-02-01', 'Lounge Lobby', '3', '18:00', 'Not Sure', (select ID from Member where MemNum = '000000005'), 3, 1),
('E2024020703', '2024-02-07', 'Lounge eSports', '6', '15:00', '20:00', (select ID from Member where MemNum = '000000004'), 3, 1),
('E2024020801', '2024-02-08', 'Lounge eSports', '4', '14:00', '19:00', (select ID from Member where MemNum = '000000001'), 3, 1),
('L2024020107', '2024-02-01', 'Lounge Lobby', '1', '19:00', 'Not Sure', (select ID from Member where MemNum = '000000004'), 3, 1),
('L2024020108', '2024-02-01', 'Lounge Lobby', '2', '20:00', '24:00', (select ID from Member where MemNum = '000000003'), 3, 1),
('L2024020802', '2024-02-08', 'Lounge Lobby', '1', '18:00', 'Not Sure', (select ID from Member where MemNum = '000000002'), 3, 1),
('L2024021001', '2024-02-10', 'Lounge Lobby', '1', '14:00', '17:00', (select ID from Member where MemNum = '000000007'), 3, 1);

/* Create Role Table */
drop table if exists Role;
create table Role (
    ID int auto_increment primary key,
    Name varchar(15) not null,
    Description varchar(120),
    /* Check for duplicates */
    unique key (Name, Description),
    unique key (Name)
);

/* Insert Data into Role Table */
insert into Role (Name, Description) values
('Front Desk', 'Usually in charge of customer and member arrival as well as organize the room or seat that is going to be used'),
('Supervisor', 'Usually in charge of everything');

/* Create Employee Table */
drop table if exists Employee;
create table Employee (
    ID int auto_increment primary key,
    EmplNum varchar(9) not null,
    FirstName varchar(50) not null,
    LastName varchar(50) not null,
    DOB date not null,
    Phone varchar(15) not null,
    Email varchar(255) not null,
    Salary decimal(10,2) not null,
    HireDate date not null,
    Active enum('Y', 'N') not null default 'Y',
    RoleID int not null,
    CafeID int not null,
    constraint foreign key (RoleID) references Role(ID),
    constraint foreign key (CafeID) references Cafe(ID),
    /* Check for duplicates */
    unique key (EmplNum, FirstName, LastName, DOB, Phone, Email, Salary, HireDate, Active, RoleID, CafeID),
    unique key (EmplNum),
    unique key (Phone),
    unique key (Email)
);

/* Insert Data into Employee Table */
insert into Employee (EmplNum, FirstName, LastName, DOB, Phone, Email, Salary, HireDate, Active, RoleID, CafeID) value
('000001', 'Nancy', 'Davolio', '2005-07-12', '111-111-2221', 'emailA1', 30000.00, '2023-12-05', 'Y', 1, 1),
('000002', 'Andrew', 'Fuller', '2000-05-22', '111-111-2222', 'emailA2', 30000.00, '2023-12-07', 'Y', 1, 1),
('000003', 'Janet', 'Leverling', '2003-06-04', '111-111-2223', 'emailA3', 30000.00, '2023-12-10', 'Y', 1, 1),
('000004', 'Steven', 'Buchanan', '1998-09-24', '111-111-2224', 'emailA4', 30000.00, '2023-12-22', 'Y', 1, 1),
('000005', 'Michael', 'Suyama', '1995-10-29', '111-111-2225', 'emailA5', 45000.00, '2023-12-14', 'Y', 2, 1),
('000006', 'Robert', 'King', '1994-02-15', '111-111-2226', 'emailA6', 45000.00, '2023-12-16', 'Y', 2, 1);
