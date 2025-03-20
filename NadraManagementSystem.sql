create schema nadramanagementsystem;
create database NadraManagementSystem;
use NadraManagementSystem;
create table Citizens(
CitizenId int primary key not null auto_increment,
FirstName varchar(25),
LastName varchar(25),
DateOfBirth date,
Gender varchar(1),
NICNumber varchar(20) unique,
FatherName varchar(25),
MotherName varchar(25),
CurrentAddress varchar(255),
FingerprintData blob,
MaritalStatus varchar(20),
SpouseName varchar(100),
SpouceNic varchar(20),
Religion varchar(50),
Nationality varchar(50)
);
alter table Citizens
rename column SpouceNic TO SpouseNic;
create table BirthRecords(
BirthId int primary key,
CitizenId int,
BirthPlace varchar(255),
BirthDate date,
foreign key(CitizenId) references Citizens(CitizenId)
);
create table DeathRecords(
DeathId int primary key,
CitizenId int,
DeathPlace varchar(100),
DeathDate Date,
CauseOfDeath varchar(255),
foreign key(CitizenId) references Citizens(CitizenId)
);
create table FamilyDetails(
FamilyId int primary key,
CitizenId int,
Relationship varchar(20),
FullName varchar(20),
DateOfBirth date,
NicNumber varchar(20),
foreign key(CitizenId) references Citizens(CitizenId)
);
create table AddressRecords(
AddressId int primary key,
CitizenId int,
AddressLine1 varchar(255),
AddressLine2 varchar(255),
City varchar(100),
State varchar(100),
PostalCode varchar(50),
Country varchar(100),
foreign key(CitizenId) references Citizens(CitizenId)
);
create table MarriageRecords (
MarriageId int primary key,
Spouse1Id int,
Spouse2Id int,
MarriageDate date,
MarriagePlace varchar(255),
foreign key (Spouse1Id) references Citizens(CitizenId),
foreign key (Spouse2Id) references Citizens(CitizenId)
);
create table DivorceRecords (
DivorceId int primary key,
Spouse1Id int,
Spouse2Id int,
DivorceDate date,
ReasonForDivorce varchar(255),
foreign key (Spouse1Id) references Citizens(CitizenId),
foreign key (Spouse2Id) references Citizens(CitizenId)
);
create table EmploymentRecords (
EmploymentId int primary key,
CitizenId int,
EmployerName varchar(255),
JobTitle varchar(100),
StartDate date,
EndDate date,
foreign key (CitizenId) references Citizens(CitizenId)
);


insert into Citizens (
    CitizenId, FirstName, LastName, DateOfBirth, Gender, NICNumber, FatherName, 
    MotherName, CurrentAddress, FingerprintData, MaritalStatus, SpouseName, 
    SpouseNic, Religion, Nationality
) 
values
    (1, 'Ahmad', 'Khan', '1985-02-10', 'M', '12345-1234567-1', 'Mohammad Khan', 
    'Fatima Bibi', 'House No. 123, Street XYZ, City A', NULL, 'Married', 
    'Ayesha Khan', '12345-1234568-2', 'Islam', 'Pakistani'),
    (2, 'Ayesha', 'Khan', '1988-05-15', 'F', '12345-1234568-2', 'Ali Ahmed', 
    'Sara Bibi', 'House No. 123, Street XYZ, City A', NULL, 'Married', 
    'Ahmad Khan', '12345-1234567-1', 'Islam', 'Pakistani'),

    (3, 'Ali', 'Khan', '2010-08-20', 'M', '12345-1234569-3', 'Ahmad Khan', 
    'Ayesha Khan', 'House No. 123, Street XYZ, City A', NULL, 'Single', 
    NULL, NULL, 'Islam', 'Pakistani'),

    (4, 'Zainab', 'Hussain', '1990-09-05', 'F', '98765-5432109-8', 'Jamal Hussain', 
    'Nida Hussain', 'House No. 77, Street ABC, City B', NULL, 'Married', 
    'Ibrahim Ali', '98765-5432101-9', 'Islam', 'Pakistani'),

    (5, 'Ibrahim', 'Ali', '1987-11-23', 'M', '98765-5432101-9', 'Irfan Ali', 
    'Saira Bibi', 'House No. 77, Street ABC, City B', NULL, 'Married', 
    'Zainab Hussain', '98765-5432109-8', 'Islam', 'Pakistani'),

    (6, 'Fatima', 'Khan', '1975-03-14', 'F', '12345-1111111-2', 'Mohammad Ali', 
    'Aisha Bibi', 'House No. 300, Street XYZ, City A', NULL, 'Widowed', 
    NULL, NULL, 'Islam', 'Pakistani'),

    (7, 'Bilal', 'Ahmed', '1995-06-19', 'M', '54321-7654321-4', 'Salim Ahmed', 
    'Nargis Bibi', 'House No. 19, Block X, City C', NULL, 'Single', 
    NULL, NULL, 'Islam', 'Pakistani'),

    (8, 'Mariam', 'Shah', '2001-12-01', 'F', '55555-6666666-0', 'Yasir Shah', 
    'Bushra Bibi', 'House No. 58, Street XYZ, City D', NULL, 'Single', 
    NULL, NULL, 'Islam', 'Pakistani'),

    (9, 'Umar', 'Farooq', '1982-07-04', 'M', '44444-7777777-5', 'Farooq Ahmed', 
    'Nasreen Bibi', 'House No. 120, Block Y, City E', NULL, 'Married', 
    'Hina Farooq', '44444-8888888-3', 'Islam', 'Pakistani'),

    (10, 'Hina', 'Farooq', '1984-10-22', 'F', '44444-8888888-3', 'Noman Ali', 
    'Fahmida Bibi', 'House No. 120, Block Y, City E', NULL, 'Married', 
    'Umar Farooq', '44444-7777777-5', 'Islam', 'Pakistani'),

    (11, 'Rashid', 'Hassan', '1970-02-15', 'M', '22222-9999999-1', 'Hassan Ali', 
    'Shamim Bibi', 'House No. 50, Block Z, City F', NULL, 'Married', 
    'Saba Hassan', '22222-1111111-0', 'Islam', 'Pakistani'),

    (12, 'Saba', 'Hassan', '1973-04-25', 'F', '22222-1111111-0', 'Tariq Ali', 
    'Jameela Bibi', 'House No. 50, Block Z, City F', NULL, 'Married', 
    'Rashid Hassan', '22222-9999999-1', 'Islam', 'Pakistani'),

    (13, 'Arif', 'Khan', '1999-08-10', 'M', '33333-2222222-9', 'Jamal Khan', 
    'Nazia Bibi', 'House No. 70, Street M, City G', NULL, 'Single', 
    NULL, NULL, 'Islam', 'Pakistani'),

    (14, 'Asma', 'Tariq', '1996-05-16', 'F', '33333-3333333-8', 'Tariq Mehmood', 
    'Salma Bibi', 'House No. 80, Block H, City H', NULL, 'Single', 
    NULL, NULL, 'Islam', 'Pakistani'),

    (15, 'Zahid', 'Iqbal', '1983-11-09', 'M', '55555-4444444-6', 'Iqbal Hussain', 
    'Rabia Bibi', 'House No. 35, Street P, City I', NULL, 'Married', 
    'Amna Zahid', '55555-5555555-7', 'Islam', 'Pakistani');
insert into BirthRecords (BirthId, CitizenId, BirthPlace, BirthDate) 
values
(1, 1, 'City A', '1985-02-10'),
(2, 2, 'City A', '1988-05-15'),
(3, 3, 'City A', '2010-08-20'),
(4, 4, 'City B', '1990-09-05'),
(5, 5, 'City B', '1987-11-23'),
(6, 6, 'City A', '1975-03-14'),
(7, 7, 'City C', '1995-06-19'),
(8, 8, 'City D', '2001-12-01'),
(9, 9, 'City E', '1982-07-04'),
(10, 10, 'City E', '1984-10-22'),
(11, 11, 'City F', '1970-02-15'),
(12, 12, 'City F', '1973-04-25'),
(13, 13, 'City G', '1999-08-10'),
(14, 14, 'City H', '1996-05-16'),
(15, 15, 'City I', '1983-11-09');
insert into DeathRecords (DeathId, CitizenId, DeathPlace, DeathDate, CauseOfDeath)
values
(1, 1, 'City A', '2020-05-12', 'Heart Attack'),
(2, 2, 'City A', '2021-07-08', 'Natural Causes'),
(3, 6, 'City A', '2019-10-05', 'Stroke'),
(4, 4, 'City B', '2022-03-11', 'Accident'),
(5, 5, 'City B', '2020-12-23', 'COVID-19'),
(6, 7, 'City C', '2023-02-16', 'Lung Disease'),
(7, 8, 'City D', '2022-09-30', 'Cancer'),
(8, 9, 'City E', '2023-06-15', 'Natural Causes'),
(9, 10, 'City E', '2021-11-27', 'Accident'),
(10, 11, 'City F', '2020-08-12', 'Natural Causes'),
(11, 12, 'City F', '2023-01-19', 'Heart Failure'),
(12, 13, 'City G', '2022-05-10', 'Accident'),
(13, 14, 'City H', '2020-04-21', 'Cancer'),
(14, 15, 'City I', '2023-03-08', 'Diabetes'),
(15, 3, 'City A', '2022-12-05', 'Accident');
insert into AddressRecords (AddressId, CitizenId, AddressLine1, AddressLine2, City, State, PostalCode, Country) 
values
(1, 1, 'House No. 123', 'Street XYZ', 'City A', 'Province A', '12345', 'Pakistan'),
(2, 2, 'House No. 123', 'Street XYZ', 'City A', 'Province A', '12345', 'Pakistan'),
(3, 3, 'House No. 123', 'Street XYZ', 'City A', 'Province A', '12345', 'Pakistan'),
(4, 4, 'House No. 77', 'Street ABC', 'City B', 'Province B', '54321', 'Pakistan'),
(5, 5, 'House No. 77', 'Street ABC', 'City B', 'Province B', '54321', 'Pakistan'),
(6, 6, 'House No. 300', 'Street XYZ', 'City A', 'Province A', '12345', 'Pakistan'),
(7, 7, 'House No. 19', 'Block X', 'City C', 'Province C', '67890', 'Pakistan'),
(8, 8, 'House No. 58', 'Street XYZ', 'City D', 'Province D', '11223', 'Pakistan'),
(9, 9, 'House No. 120', 'Block Y', 'City E', 'Province E', '22334', 'Pakistan'),
(10, 10, 'House No. 120', 'Block Y', 'City E', 'Province E', '22334', 'Pakistan'),
(11, 11, 'House No. 50', 'Block Z', 'City F', 'Province F', '44556', 'Pakistan'),
(12, 12, 'House No. 50', 'Block Z', 'City F', 'Province F', '44556', 'Pakistan'),
(13, 13, 'House No. 70', 'Street M', 'City G', 'Province G', '55667', 'Pakistan'),
(14, 14, 'House No. 80', 'Block H', 'City H', 'Province H', '66778', 'Pakistan'),
(15, 15, 'House No. 35', 'Street P', 'City I', 'Province I', '77889', 'Pakistan');
insert into FamilyDetails (FamilyId, CitizenId, Relationship, FullName, DateOfBirth, NicNumber)
values
(1, 1, 'Father', 'Mohammad Khan', '1955-07-20', '11111-1111111-1'),
(2, 1, 'Mother', 'Fatima Bibi', '1960-08-15', '11111-1111111-2'),
(3, 1, 'Spouse', 'Ayesha Khan', '1988-05-15', '12345-1234568-2'),
(4, 2, 'Spouse', 'Ahmad Khan', '1985-02-10', '12345-1234567-1'),
(5, 3, 'Father', 'Ahmad Khan', '1985-02-10', '12345-1234567-1'),
(6, 3, 'Mother', 'Ayesha Khan', '1988-05-15', '12345-1234568-2'),
(7, 4, 'Father', 'Jamal Hussain', '1950-01-05', '22222-2222222-2'),
(8, 4, 'Mother', 'Nida Hussain', '1953-03-15', '22222-2222222-3'),
(9, 4, 'Spouse', 'Ibrahim Ali', '1987-11-23', '98765-5432101-9'),
(10, 5, 'Spouse', 'Zainab Hussain', '1990-09-05', '98765-5432109-8'),
(11, 6, 'Father', 'Mohammad Ali', '1945-04-10', '33333-4444444-3'),
(12, 6, 'Mother', 'Aisha Bibi', '1948-06-20', '33333-4444444-4'),
(13, 9, 'Spouse', 'Hina Farooq', '1984-10-22', '44444-8888888-3'),
(14, 10, 'Spouse', 'Umar Farooq', '1982-07-04', '44444-7777777-5'),
(15, 15, 'Spouse', 'Amna Zahid', '1985-11-10', '55555-5555555-7');
insert into MarriageRecords (MarriageId, Spouse1Id, Spouse2Id, MarriageDate, MarriagePlace)
values
(1, 1, 2, '2009-06-15', 'City A'),
(2, 4, 5, '2015-03-22', 'City B'),
(3, 3, 6, '2010-11-10', 'City E'),
(4, 7, 8, '1995-05-30', 'City F'),
(5, 9, 10, '2020-08-12', 'City G'),
(6, 11, 12, '2010-12-05', 'City I'),
(7, 2, 1, '2009-06-15', 'City A'), 
(8, 6, 3, '2010-11-10', 'City E'), 
(9, 5, 4, '2015-03-22', 'City B'), 
(10, 8, 7, '1995-05-30', 'City F'),
(11, 13, 14, '2023-01-15', 'City D'),
(12, 15, 13, '2020-08-12', 'City G'), 
(13, 9, 10, '2022-05-21', 'City A'),
(14, 11, 12, '2019-09-19', 'City C'),
(15, 15, 14, '2021-07-25', 'City H');

insert into DivorceRecords (DivorceId, Spouse1Id, Spouse2Id, DivorceDate, ReasonForDivorce)
values
(1, 1, 2, '2015-06-10', 'Mutual Agreement'),
(2, 4, 5, '2020-01-20', 'Irreconcilable Differences'),
(3, 3, 6, '2018-03-15', 'Infidelity'),
(4, 7, 8, '2022-07-30', 'Financial Issues'),
(5, 9, 10, '2019-12-05', 'Communication Problems'),
(6, 11, 12, '2021-09-12', 'Lack of Commitment'),
(7, 2, 1, '2015-06-10', 'Mutual Agreement'), 
(8, 6, 3, '2018-03-15', 'Infidelity'), 
(9, 5, 4, '2020-01-20', 'Irreconcilable Differences'), 
(10, 8, 7, '2022-07-30', 'Financial Issues'), 
(11, 13, 14, '2023-02-10', 'Personal Growth'),
(12, 15, 13, '2023-03-15', 'Different Life Goals'),
(13, 11, 12, '2024-01-10', 'Misunderstandings'),
(14, 15, 14, '2024-04-01', 'Emotional Disconnect'),
(15, 9, 10, '2022-05-21', 'Growing Apart');

insert into EmploymentRecords (EmploymentId, CitizenId, EmployerName, JobTitle, StartDate, EndDate)
values
(1, 1, 'Tech Solutions Inc.', 'Software Engineer', '2010-01-15', '2015-05-20'),
(2, 2, 'Global Marketing Corp.', 'Marketing Manager', '2013-03-01', '2018-11-30'),
(3, 3, 'Creative Designs Ltd.', 'Graphic Designer', '2016-02-10', '2020-07-25'),
(4, 4, 'HealthCare Plus', 'Medical Practitioner', '2010-06-01', '2022-12-31'),
(5, 5, 'Finance Group', 'Financial Analyst', '2011-04-15', '2016-09-10'),
(6, 6, 'Green Energy Co.', 'Project Manager', '2015-01-20', NULL),  
(7, 7, 'Education First', 'Teacher', '2017-09-05', '2023-08-15'),
(8, 8, 'Fashion House', 'Fashion Designer', '2012-03-15', '2018-12-31'),
(9, 9, 'Tech Innovations', 'Systems Analyst', '2014-05-11', '2020-03-30'),
(10, 10, 'Build It Better', 'Civil Engineer', '2018-01-10', NULL), 
(11, 11, 'Culinary Delights', 'Chef', '2019-06-15', '2023-02-28'),
(12, 12, 'Consulting Experts', 'Consultant', '2020-09-01', NULL), 
(13, 13, 'Logistics Hub', 'Logistics Manager', '2015-10-20', '2021-11-10'),
(14, 14, 'Retail Giants', 'Sales Associate', '2016-01-05', '2022-05-20'),
(15, 15, 'Tech Support Co.', 'Customer Support', '2022-04-15', NULL); 




show tables;
select * from Citizens;
select * from BirthRecords;
select * from DeathRecords;
select * from FamilyDetails;
select * from AddressRecords;
select * from MarriageRecords;
select * from DivorceRecords;
select * from EmploymentRecords;


ALTER TABLE citizens MODIFY citizenid INT AUTO_INCREMENT;





