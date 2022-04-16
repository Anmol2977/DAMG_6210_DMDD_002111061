set serveroutput on;

begin
    begin
    execute immediate 'create sequence customer_pk';
    exception when others then null;
    end;
    dbms_output.put_line('sequence customer_pk created');
end;
/

----creating tables and establishing constraints

--zoo_info table
begin
  begin
   execute immediate 'alter table ticket_pricing_pr drop constraint ticket_pricing_fk';
   exception when others then null;
   end;
   begin 
   execute immediate 'alter table zoo_department_pr drop constraint zoo_department_fk';
   exception when others then null;
   end;
   begin 
   execute immediate 'alter table animal_pr drop constraint animal_fk';
   exception when others then null;
   end;
   begin 
   execute immediate 'alter table department_pr drop constraint department_fk';
   exception when others then null;
   end;
   begin
     execute immediate 'drop table zoo_info_pr';
  exception when others then NULL;
  end;
  execute immediate 'CREATE TABLE zoo_info_pr(zoo_id int,
                        zoo_name varchar(30) not null,
                        city varchar(30),
                        state varchar(30),
                        zip_code int,
                        constraint zoo_info_pk primary key (zoo_id))';
    dbms_output.put_line('table zoo_info_pr created');
end;
/

-- ticket_pricing table
begin
  begin
  execute immediate 'alter table transaction_pr drop constraint transaction_fk2';
  exception when others then null;
  end;
  begin
   execute immediate 'drop table ticket_pricing_pr';
  exception when others then
   NULL;
  end;
  execute immediate 'create table ticket_pricing_pr(ticket_id int,
                                ticket_type varchar(30),
                                price int not null,
                                tp_zoo_id int,
                                constraint ticket_pricing_pk primary key (ticket_id),
                                constraint ticket_pricing_fk foreign key(tp_zoo_id) references zoo_info_pr(zoo_id),
                                constraint ticket_pricing_uk unique (tp_zoo_id,ticket_type))';
     dbms_output.put_line('table ticket_pricing_pr created');
end;
/

                                                               
--customer table
begin
    begin
  execute immediate 'alter table transaction_pr drop constraint transaction_fk1';
  exception when others then null;
  end;
  begin
   execute immediate 'drop table customer_pr';
  exception when others then
   NULL;
  end;
  execute immediate 'create table customer_pr(customer_id int default customer_pk.nextval,
                        first_name varchar(30) not null,
                        last_name varchar(30) not null,
                        sex varchar(30),
                        constraint customer_pk primary key(customer_id))';
    dbms_output.put_line('table customer_pr created');
end;
/


--transaction table
begin
  begin
   execute immediate 'drop table transaction_pr';
  exception when others then
   NULL;
  end;
  execute immediate 'create table transaction_pr(transaction_id int,
                            date_of_transaction date,
                            ticket_id int,
                            ticket_count int,
                            total_amount int,
                            customer_id int,
                            constraint transaction_pk primary key (transaction_id),
                            constraint transaction_fk1 foreign key (customer_id) references customer_pr(customer_id),
                            constraint transaction_fk2 foreign key (ticket_id) references ticket_pricing_pr(ticket_id))';
    dbms_output.put_line('table transaction_pr created');
end;
/


--department table
begin
    begin 
   execute immediate 'alter table zoo_department_pr drop constraint zoo_department_fk';
   exception when others then null;
   end;
   begin 
   execute immediate 'alter table employee_pr drop constraint employee_fk';
   exception when others then null;
   end;
  begin
   execute immediate 'drop table department_pr';
  exception when others then
   NULL;
  end;
  execute immediate 'create table department_pr(department_id int,
                            department_name varchar(30),
                            constraint department_pk primary key(department_id))';
    dbms_output.put_line('table department_pr created');
end;
/


--zoo_department table
begin
  begin
   execute immediate 'drop table zoo_department_pr';
  exception when others then
   NULL;
  end;
  execute immediate 'create table zoo_department_pr(zoo_dept_id int,
                                zoo_id int,
                                department_id int,
                                constraint zoo_department_pk primary key (zoo_dept_id),
                                constraint zoo_department_fk foreign key (department_id) references department_pr(department_id),
                                constraint zoo_department_uk unique(zoo_id,department_id))';
    dbms_output.put_line('table zoo_department_pr created');
end;
/

--employee table
begin
  begin
   execute immediate 'drop table employee_pr';
  exception when others then
   NULL;
  end;
  execute immediate 'create table employee_pr(employee_id int,
                                first_name varchar(30),
                                last_name varchar(30),
                                date_of_birth date,
                                department_id int,
                                constraint employee_pk primary key (employee_id),
                                constraint employee_fk foreign key (department_id) references department_pr(department_id))';
    dbms_output.put_line('table employee_pr created');
end;
/


--animal table
begin
    begin
    execute immediate 'alter table habitat_pr drop constraint habitat_fk';
    exception when others then null;
    end;
    begin 
    execute immediate 'alter table animal_kingdom_pr drop constraint animal_kingdom_fk';
    exception when others then null;
    end;
    begin
    execute immediate 'alter table nutrition_pr drop constraint nutrition_fk';
    exception when others then null;
    end;
  begin
   execute immediate 'drop table animal_pr';
  exception when others then
   NULL;
  end;
  execute immediate 'create table animal_pr(animal_id int,
                                animal_name varchar(30),
                                zoo_id int,
                                category varchar(30),
                                endangered_category varchar(30),
                                life_expectency int,
                                constraint animal_pk  primary key (animal_id),
                                constraint animal_fk foreign key (zoo_id) references zoo_info_pr(zoo_id),
                                constraint animal_uk unique(zoo_id,animal_name))';
    dbms_output.put_line('table animal_pr created');
end;
/

--habitat table 
begin
  begin
   execute immediate 'drop table habitat_pr';
  exception when others then
   NULL;
  end;
  execute immediate 'create table habitat_pr(habitat_id int,
                                habitat_name varchar(30),
                                animal_id int,
                                constraint habitat_pk primary key (habitat_id),
                                constraint habitat_fk foreign key (animal_id) references animal_pr(animal_id))';
    dbms_output.put_line('table habitat_pr created');
end;
/

--animal_kingdom table
begin
  begin
   execute immediate 'drop table animal_kingdom_pr';
  exception when others then
   NULL;
  end;
  execute immediate 'create table animal_kingdom_pr(animal_kingdom_id int,
                                kingdom_name varchar(30),
                                animal_id int,
                                constraint animal_kingdom_pk primary key (animal_kingdom_id),
                                constraint animal_kingdom_fk foreign key (animal_id) references animal_pr(animal_id))';
    dbms_output.put_line('table animal_kingdom_pr created');
end;
/

--nutrition table
begin
  begin
   execute immediate 'drop table nutrition_pr';
  exception when others then
   NULL;
  end;
  execute immediate 'create table nutrition_pr(nutrition_id int,
                                nutrition_type varchar(30),
                                nutrition_cost int,
                                animal_id int,
                                constraint nutrition_pk primary key (nutrition_id),
                                constraint nutrition_fk foreign key (animal_id) references animal_pr(animal_id))';
    dbms_output.put_line('table nutrition_pr created');
end;
/


----inserting values into tables

--inserting into zoo_info_pr

insert into zoo_info_pr 
with name as (select 1,'Audubon Zoo', 'New Orleans','Louisiana',70118 from dual union all
                select 2,'Bronx Zoo','New York City','New York ',10460 from dual union all
                select 3,'Brookfield Zoo','Chicago','Illinois',60513 from dual union all
                select 4,'Cheyenne Mountain Zoo','Colorado Springs','Colorado',80906 from dual union all
                select 5, 'Cincinnati Zoo','Cincinnati','Ohio ',45220 from dual union all
                select 6, 'Columbus Zoo','Delaware County','Ohio ', 43065 from dual union all
                select 7,'Dallas Zoo','Dallas', 'Texas', 75203 from dual union all
                select 8, 'Denver Zoo', 'Denver', 'Coolorad', 80205 from dual union all
                select 9, 'Henry Doorly Zoo','Omaha','Nebraska',68107 from dual union all
                select 10, 'Zoo Miami', 'Miami', 'Florida', 33177 from dual union all
                select 11, 'National Zoo','Washington','DC', 20008 from dual union all
                select 12, 'Philadelphia Zoo','Centennial District','Philadelphia', 19104 from dual union all
                select 13, 'Saint Louis Zoo','St. Louis','Missouri',63110 from dual union all
                select 14, 'San Diego Zoo','San Diego',' California',92101 from dual) select * from name;


--inserting into ticket_pricing_pr
insert into ticket_pricing_pr values (1  , 'Adult', 25, 1 );
insert into ticket_pricing_pr values (2  , 'Adult', 40, 2);
insert into ticket_pricing_pr values (3  , 'Adult', 18, 3);
insert into ticket_pricing_pr values (4  , 'Adult', 25, 4);
insert into ticket_pricing_pr values (5 , 'Adult', 28, 5);
insert into ticket_pricing_pr values (6  , 'Adult', 22, 6);
insert into ticket_pricing_pr values (7  , 'Adult', 21, 7);
insert into ticket_pricing_pr values (8  , 'Adult', 20, 8);
insert into ticket_pricing_pr values (9  , 'Adult', 19, 9);
insert into ticket_pricing_pr values (10  , 'Adult', 23, 10);
insert into ticket_pricing_pr values (11  , 'Adult', 28, 11);
insert into ticket_pricing_pr values (12  , 'Adult', 24, 12);
insert into ticket_pricing_pr values (13  , 'Adult', 25, 13);
insert into ticket_pricing_pr values (14  , 'Adult', 62, 14);
insert into ticket_pricing_pr values (15  , 'Child', 20, 1 );
insert into ticket_pricing_pr values (16  , 'Child', 30, 2);
insert into ticket_pricing_pr values (17  , 'Child', 12, 3);
insert into ticket_pricing_pr values (18  , 'Child', 15, 4);
insert into ticket_pricing_pr values (19  , 'Child', 22, 5);
insert into ticket_pricing_pr values (20  , 'Child', 17, 6);
insert into ticket_pricing_pr values (21  , 'Child', 16, 7);
insert into ticket_pricing_pr values (22 , 'Child', 14, 8);
insert into ticket_pricing_pr values (23  , 'Child', 13, 9);
insert into ticket_pricing_pr values (24  , 'Child', 19, 10);
insert into ticket_pricing_pr values (25  , 'Child', 23, 11);
insert into ticket_pricing_pr values (26  , 'Child', 19, 12 );
insert into ticket_pricing_pr values (27  , 'Child', 20, 13);
insert into ticket_pricing_pr values (28  , 'Child', 52, 14);


--inserting into department_pr
insert all
 into department_pr values (1,'Veterinarian')

 into department_pr values ( 2, 'Animal Curator')

 into department_pr values ( 3, 'Zoologist')

 into department_pr values ( 4, 'Keeper')

 into department_pr values ( 5, 'Registrar')
 
 into department_pr values ( 6, 'Finance')
 
 into department_pr values ( 7, 'Gift Shop')
 
 into department_pr values ( 8, 'Visitor Services')
 
 into department_pr values ( 9, 'Security')

 into department_pr values ( 10, 'Food Court')
 
 into department_pr values ( 11, 'House Keeping')
 
 into department_pr values ( 12, 'IT')

 select 1 from dual;

--inserting into customer_pr
insert all
    into customer_pr values ( 1,'Meghan', 'Bower','F')
    into customer_pr values ( 2,'Melanie','Avery','F')
    into customer_pr values ( 3,'Abigail', 'Abraham','F')
    into customer_pr values ( 4, 'Adam' , 'Allan', 'M')
    into customer_pr values ( 5, 'Alexander', 'Alsop', 'M')
    into customer_pr values ( 6, 'Andrew', 'Anderson','M')
    into customer_pr values ( 7, 'Anthony', 'Bailey','M')
    into customer_pr values ( 8, 'Carolyn', 'Bower','F')
    into customer_pr values ( 9, 'Clarie', 'Bell', 'F')
    into customer_pr values ( 10, 'Carl', 'Buckland', 'F')
    into customer_pr values ( 11, 'Charles', 'Carr', 'M')
    into customer_pr values ( 12, 'Harry', 'Gibson', 'M')
    into customer_pr values ( 13, 'Zoe', 'Lawrance', 'F')
    into customer_pr values ( 14, 'John', 'Rutherford', 'M')
    into customer_pr values ( 15, 'Kevin', 'Sharp', 'M')
    into customer_pr values ( 16, 'Will', 'Young', 'M')
    into customer_pr values ( 17, 'Micheal', 'Jackson', 'M')
    into customer_pr values ( 18, 'Adien', 'Smith', 'M')
    into customer_pr values ( 19, 'Chris', 'Gayle', 'M')
    into customer_pr values ( 20, 'Kane', 'Willianson', 'M')
    into customer_pr values ( 21, 'Ellise', 'Perry', 'F')
    into customer_pr values ( 22, 'Racheal', 'Mackay', 'F')
    into customer_pr values ( 23, 'Mitchel', 'Marsh', 'M')
    into customer_pr values ( 24, 'Sanjay', 'Gandhi', 'M')
    into customer_pr values ( 25, 'Sanjay', 'Dutt', 'M')
    into customer_pr values ( 26, 'Natalie', 'MacDonald', 'F')
    into customer_pr values ( 27, 'Olivia', 'Manning','F')
    into customer_pr values ( 28, 'Sophie','Miller','F')
    into customer_pr values ( 29, 'Pippa', 'Dowd','F')
    into customer_pr values ( 30, 'Ricky', 'Ponting', 'M')
    into customer_pr values ( 31, 'Priyanka', 'Gandhi', 'F')
    into customer_pr values ( 32, 'Shane', 'Warne', 'M')
    into customer_pr values ( 33, 'Adam', 'Gilchrist', 'M')
    into customer_pr values ( 34, 'Lesllie', 'Winkle', 'F')
    into customer_pr values ( 35, 'Gavin', 'Jones', 'M')
    into customer_pr values ( 36, 'Jake', 'Keller', 'M')
    into customer_pr values ( 37, 'Isaac', 'Newton', 'M')
    into customer_pr values ( 38, 'Mitchel', 'Johnson', 'M')
    into customer_pr values ( 39, 'Sarah', 'Randling', 'M')
    into customer_pr values ( 40, 'Samantha', 'Paterson', 'M')
    into customer_pr values ( 41, 'Stuart', 'Anderson', 'M')
    into customer_pr values ( 42, 'Mary', 'Peters', 'F')
    into customer_pr values ( 43, 'Meghan', 'Powel', 'F')
    into customer_pr values ( 44, 'Olivia', 'Henderson', 'F')
    into customer_pr values ( 45, 'James', 'Anderson', 'M')
    into customer_pr values ( 46, 'Joe', 'Root', 'M')
    into customer_pr values ( 47, 'Sophie', 'Bell', 'F')
    into customer_pr values ( 48, 'Sanath', 'Jayasurya', 'M')
    into customer_pr values ( 49, 'Wendy', 'Lee', 'F')
    into customer_pr values ( 50, 'Maria', 'Martin', 'F')
    into customer_pr values ( 51, 'Jennier', 'Lopez', 'F')
    into customer_pr values ( 52, 'Grace', 'Swift', 'F')
    into customer_pr values ( 53, 'Theresa', ' Payne', 'F')
    select 1 from dual;


--inserting into transaction_pr
insert all 
    into transaction_pr values (1, to_date('02-jan-21'), 8, 5, 100,1) 
    into transaction_pr values (2, to_date('14-jan-21'), 1,2, 50, 14)
    into transaction_pr values (3, to_date('19-jan-21'), 20, 2, 34, 3)
    into transaction_pr values (4, to_date('25-jan-21'), 14, 3, 186, 8)
    into transaction_pr values (5,to_date('27-jan-21'), 23, 3,39, 5)
    into transaction_pr values (6, to_date('31-jan-21'), 12, 10, 240,20)
    into transaction_pr values (7, to_date('04-feb-21'), 6, 1, 22, 13)
    into transaction_pr values (8, to_date('08-feb-21'), 9, 8, 152, 4)
    into transaction_pr values (9, to_date('13-feb-21'), 19, 5, 110, 12)
    into transaction_pr values (10, to_date('19-feb-21'), 20, 2, 34, 6)
    into transaction_pr values (11, to_date('24-feb-21'), 17, 5, 60, 13)
    into transaction_pr values (12, to_date('01-mar-21'), 8, 20, 400, 19)
    into transaction_pr values (13, to_date('04-mar-21'), 3, 2, 36, 5)
    into transaction_pr values (14, to_date('10-mar-21'), 16, 4, 120, 17)
    into transaction_pr values (15, to_date('12-mar-21'), 18, 10, 150, 15)
    into transaction_pr values (16, to_date('15-mar-21'), 9, 2, 38, 6)
    into transaction_pr values (17, to_date('18-mar-21'), 10, 9, 207, 10)
    into transaction_pr values (18, to_date('21-mar-21'), 24, 10, 190, 5)
    into transaction_pr values (19, to_date('25-mar-21'), 21, 5, 80, 14)
    into transaction_pr values (20, to_date('29-mar-21'), 10, 10, 230, 13)
    into transaction_pr values (21, to_date('01-apr-21'), 1, 5, 125, 11)
    into transaction_pr values (22, to_date('04-apr-21'), 5, 2, 56, 9)
    into transaction_pr values (23, to_date('10-apr-21'), 17, 5, 60, 1)
    into transaction_pr values (24, to_date('14-apr-21'), 14, 10, 620, 21)
    into transaction_pr values (25, to_date('16-apr-21'), 7, 1, 21, 9)
    into transaction_pr values (26, to_date('19-apr-21'), 16, 5, 150, 16)
    into transaction_pr values (27, to_date('23-apr-21'), 4, 5, 100, 2)
    into transaction_pr values (28, to_date('27-apr-21'), 23, 3, 39, 3)
    into transaction_pr values (29, to_date('30-apr-21'), 24, 10, 190, 18)
    into transaction_pr values (30, to_date('01-may-21'), 18, 1, 15, 13)
    into transaction_pr values (31, to_date('04-may-21'), 15, 4, 80, 5)
    into transaction_pr values (32, to_date('07-may-21'), 19, 10, 220, 22)
    into transaction_pr values (33, to_date('11-may-21'), 11, 3, 69, 3)
    into transaction_pr values (34, to_date('12-may-21'), 10, 1, 23, 7)
    into transaction_pr values (35, to_date('15-may-21'), 6, 3, 66, 18)
    into transaction_pr values (36, to_date('17-may-21'), 1, 4, 100, 23)
    into transaction_pr values (37, to_date('20-may-21'), 2, 3, 120, 24)
    into transaction_pr values (38, to_date('21-may-21'), 3, 2, 36, 25)
    into transaction_pr values (39, to_date('24-may-21'), 4, 1, 25, 24)
    into transaction_pr values (40, to_date('25-may-21'), 5, 2, 56, 26)
    into transaction_pr values (41, to_date('27-may-21'), 6, 3, 66, 27)
    into transaction_pr values (42, to_date('31-may-21'), 7, 4, 84, 28)
    into transaction_pr values (43, to_date('01-jun-21'), 8, 5, 100, 29)
    into transaction_pr values (44, to_date('04-jun-21'), 9, 4, 76, 28)
    into transaction_pr values (45, to_date('06-jun-21'), 10, 2, 46, 27)
    into transaction_pr values (46, to_date('08-jun-21'), 11, 1, 28, 26)
    into transaction_pr values (47, to_date('10-jun-21'), 12, 2, 48, 25)
    into transaction_pr values (48, to_date('12-jun-21'), 13, 3, 75, 24)
    into transaction_pr values (49, to_date('15-jun-21'), 14, 4, 248, 23)
    into transaction_pr values (50, to_date('17-jun-21'), 15, 3, 60, 22)
    into transaction_pr values (51, to_date('19-jun-21'), 16, 2, 60, 21)
    into transaction_pr values (52, to_date('22-jun-21'), 17, 1, 12, 20)
    into transaction_pr values (53, to_date('25-jun-21'), 18, 2, 30, 19)
    into transaction_pr values (54, to_date('26-jun-21'), 19, 3, 66, 18)
    into transaction_pr values (55, to_date('28-jun-21'), 20, 4, 68, 17)
    into transaction_pr values (56, to_date('30-jun-21'), 21, 5, 50, 16)
    into transaction_pr values (57, to_date('01-jul-21'), 22, 4, 56, 15)
    into transaction_pr values (58, to_date('03-jul-21'), 23, 3, 39, 14)
    into transaction_pr values (59, to_date('04-jul-21'), 24, 2, 39, 13)
    into transaction_pr values (60, to_date('07-jul-21'), 25, 1, 23, 12)
    into transaction_pr values (61, to_date('09-jul-21'), 26, 2, 38, 11)
    into transaction_pr values (62, to_date('10-jul-21'), 27, 3, 60, 10)
    into transaction_pr values (63, to_date('12-jul-21'), 28, 4, 208, 9)
    into transaction_pr values (64, to_date('15-jul-21'), 17, 2, 24, 8)
    into transaction_pr values (65, to_date('18-jul-21'), 13, 1, 25, 7)
    into transaction_pr values (66, to_date('20-jul-21'), 7, 5, 105, 6)
    into transaction_pr values (67, to_date('22-jul-21'), 5, 4, 112, 5)
    into transaction_pr values (68, to_date('23-jul-21'), 3, 3, 54, 4)
    into transaction_pr values (69, to_date('24-jul-21'), 2, 2, 80, 3)
    into transaction_pr values (70, to_date('28-jul-21'), 4, 1, 25, 2)
    into transaction_pr values (71, to_date('30-jul-21'), 6, 1, 22, 1)
    into transaction_pr values (72, to_date('02-aug-21'), 8, 2, 40, 40)
    into transaction_pr values (73, to_date('03-aug-21'), 10, 3, 69, 39)
    into transaction_pr values (74, to_date('05-aug-21'), 12, 2, 48, 38)
    into transaction_pr values (75, to_date('08-aug-21'), 14, 3, 186, 37)
    into transaction_pr values (76, to_date('11-aug-21'), 16, 4, 120, 36)
    into transaction_pr values (77, to_date('14-aug-21'), 18, 5, 125, 35)
    into transaction_pr values (78, to_date('17-aug-21'), 20, 4, 68, 34)
    into transaction_pr values (79, to_date('18-aug-21'), 22, 3, 42, 33)
    into transaction_pr values (80, to_date('21-aug-21'), 24, 2, 38, 32)
    into transaction_pr values (81, to_date('24-aug-21'), 26, 1, 19, 31)
    into transaction_pr values (82, to_date('26-aug-21'), 28, 3, 156, 30)
    into transaction_pr values (83, to_date('28-aug-21'), 27, 4, 80, 29)
    into transaction_pr values (84, to_date('31-aug-21'), 25, 2, 46, 28)
    into transaction_pr values (85, to_date('01-sep-21'), 8, 5, 100, 29)
    into transaction_pr values (86, to_date('04-sep-21'), 9, 4, 76, 28)
    into transaction_pr values (87, to_date('06-sep-21'), 10, 2, 46, 27)
    into transaction_pr values (88, to_date('08-sep-21'), 11, 1, 28, 26)
    into transaction_pr values (89, to_date('10-sep-21'), 12, 2, 48, 25)
    into transaction_pr values (90, to_date('12-sep-21'), 13, 3, 75, 24)
    into transaction_pr values (91, to_date('15-sep-21'), 14, 4, 248, 23)
    into transaction_pr values (92, to_date('17-sep-21'), 15, 3, 60, 22)
    into transaction_pr values (93, to_date('19-sep-21'), 16, 2, 60, 21)
    into transaction_pr values (94, to_date('22-sep-21'), 17, 1, 12, 20)
    into transaction_pr values (95, to_date('25-sep-21'), 18, 2, 30, 19)
    into transaction_pr values (96, to_date('26-sep-21'), 19, 3, 66, 18)
    into transaction_pr values (97, to_date('28-sep-21'), 20, 4, 68, 17)
    into transaction_pr values (98, to_date('30-sep-21'), 21, 5, 50, 16)
    into transaction_pr values (99, to_date('01-oct-21'), 22, 4, 56, 15)
    into transaction_pr values (100, to_date('03-oct-21'), 23, 3, 39, 14)
    into transaction_pr values (101, to_date('04-oct-21'), 24, 2, 39, 13)
    into transaction_pr values (102, to_date('07-oct-21'), 25, 1, 23, 12)
    into transaction_pr values (103, to_date('09-oct-21'), 26, 2, 38, 11)
    into transaction_pr values (104, to_date('10-oct-21'), 27, 3, 60, 10)
    into transaction_pr values (105, to_date('12-oct-21'), 28, 4, 208, 9)
    into transaction_pr values (106, to_date('15-oct-21'), 17, 2, 24, 8)
    into transaction_pr values (107, to_date('18-oct-21'), 13, 1, 25, 7)
    into transaction_pr values (108, to_date('22-oct-21'), 5, 4, 112, 5)
    into transaction_pr values (109, to_date('28-oct-21'), 4, 1, 25, 2)
    into transaction_pr values (110, to_date('30-oct-21'), 6, 1, 22, 1)
    into transaction_pr values (111, to_date('02-nov-21'), 8, 2, 40, 40)
    into transaction_pr values (112, to_date('08-nov-21'), 10, 3, 69, 39)
    into transaction_pr values (113, to_date('16-nov-21'), 12, 2, 48, 38)
    into transaction_pr values (114, to_date('20-nov-21'), 14, 3, 186, 37)
    into transaction_pr values (115, to_date('27-nov-21'), 16, 4, 120, 36)    
    into transaction_pr values (116, to_date('02-dec-21'), 8, 5, 100,1) 
    into transaction_pr values (117, to_date('14-dec-21'), 1,2, 50, 14)
    into transaction_pr values (118, to_date('19-dec-21'), 20, 2, 34, 3)
    into transaction_pr values (119, to_date('25-dec-21'), 14, 3, 186, 8)
    into transaction_pr values (120, to_date('02-feb-20'), 8, 5, 100,1) 
    into transaction_pr values (121, to_date('14-feb-20'), 1,2, 50, 14)
    into transaction_pr values (122, to_date('19-feb-20'), 20, 2, 34, 3)
    into transaction_pr values (123, to_date('25-feb-20'), 14, 3, 186, 8)
    into transaction_pr values (124, to_date('27-feb-20'), 23, 3,39, 5)
    into transaction_pr values (126, to_date('04-mar-20'), 6, 1, 22, 13)
    into transaction_pr values (127, to_date('08-mar-20'), 9, 8, 152, 4)
    into transaction_pr values (128, to_date('13-mar-20'), 19, 5, 110, 12)
    into transaction_pr values (129, to_date('19-mar-20'), 20, 2, 34, 6)
    into transaction_pr values (130, to_date('24-mar-20'), 17, 5, 60, 13)
    into transaction_pr values (131, to_date('01-apr-20'), 8, 20, 400, 19)
    into transaction_pr values (132, to_date('04-apr-20'), 3, 2, 36, 5)
    into transaction_pr values (133, to_date('10-apr-20'), 16, 4, 120, 17)
    into transaction_pr values (134, to_date('12-apr-20'), 18, 10, 150, 15)
    into transaction_pr values (135, to_date('15-apr-20'), 9, 2, 38, 6)
    into transaction_pr values (136, to_date('18-apr-20'), 10, 9, 207, 10)
    into transaction_pr values (137, to_date('21-apr-20'), 24, 10, 190, 5)
    into transaction_pr values (138, to_date('25-apr-20'), 21, 5, 80, 14)
    into transaction_pr values (139, to_date('29-apr-20'), 10, 10, 230, 13)
    into transaction_pr values (140, to_date('01-may-20'), 1, 5, 125, 11)
    into transaction_pr values (141, to_date('04-may-20'), 5, 2, 56, 9)
    into transaction_pr values (142, to_date('10-may-20'), 17, 5, 60, 1)
    into transaction_pr values (143, to_date('14-may-20'), 14, 10, 620, 21)
    into transaction_pr values (144, to_date('16-may-20'), 7, 1, 21, 9)
    into transaction_pr values (145, to_date('19-may-20'), 16, 5, 150, 16)
    into transaction_pr values (146, to_date('23-may-20'), 4, 5, 100, 2)
    into transaction_pr values (147, to_date('27-may-20'), 23, 3, 39, 3)
    into transaction_pr values (148, to_date('30-may-20'), 24, 10, 190, 18)
    into transaction_pr values (149, to_date('01-jun-20'), 18, 1, 15, 13)
    into transaction_pr values (150, to_date('04-jun-20'), 15, 4, 80, 5)
    into transaction_pr values (151, to_date('07-jun-20'), 19, 10, 220, 22)
    into transaction_pr values (152, to_date('11-jun-20'), 11, 3, 69, 3)
    into transaction_pr values (156, to_date('12-jun-20'), 10, 1, 23, 7)
    into transaction_pr values (153, to_date('15-jun-20'), 6, 3, 66, 18)
    into transaction_pr values (154, to_date('17-jun-20'), 1, 4, 100, 23)
    into transaction_pr values (155, to_date('20-jun-20'), 2, 3, 120, 24)
    into transaction_pr values (157, to_date('21-jun-20'), 3, 2, 36, 25)
    into transaction_pr values (158, to_date('24-jun-20'), 4, 1, 25, 24)
    into transaction_pr values (159, to_date('25-jun-20'), 5, 2, 56, 26)
    into transaction_pr values (160, to_date('27-jun-20'), 6, 3, 66, 27)
    into transaction_pr values (161, to_date('30-jun-20'), 7, 4, 84, 28)
    into transaction_pr values (162, to_date('01-jul-20'), 8, 5, 100, 29)
    into transaction_pr values (163, to_date('04-jul-20'), 9, 4, 76, 28)
    into transaction_pr values (164, to_date('06-jul-20'), 10, 2, 46, 27)
    into transaction_pr values (165, to_date('08-jul-20'), 11, 1, 28, 26)
    into transaction_pr values (166, to_date('10-jul-20'), 12, 2, 48, 25)
    into transaction_pr values (167, to_date('12-jul-20'), 13, 3, 75, 24)
    into transaction_pr values (168, to_date('15-jul-20'), 14, 4, 248, 23)
    into transaction_pr values (169, to_date('17-jul-20'), 15, 3, 60, 22)
    into transaction_pr values (170, to_date('19-jul-20'), 16, 2, 60, 21)
    into transaction_pr values (171, to_date('22-jul-20'), 17, 1, 12, 20)
    into transaction_pr values (172, to_date('25-jul-20'), 18, 2, 30, 19)
    into transaction_pr values (173, to_date('26-jul-20'), 19, 3, 66, 18)
    into transaction_pr values (174, to_date('28-jul-20'), 20, 4, 68, 17)
    into transaction_pr values (175, to_date('30-jul-20'), 21, 5, 50, 16)
    into transaction_pr values (176, to_date('01-aug-20'), 22, 4, 56, 15)
    into transaction_pr values (177, to_date('03-aug-20'), 23, 3, 39, 14)
    into transaction_pr values (178, to_date('04-aug-20'), 24, 2, 39, 13)
    into transaction_pr values (179, to_date('07-aug-20'), 25, 1, 23, 12)
    into transaction_pr values (180, to_date('09-aug-20'), 26, 2, 38, 11)
    into transaction_pr values (181, to_date('10-aug-20'), 27, 3, 60, 10)
    into transaction_pr values (182, to_date('12-aug-20'), 28, 4, 208, 9)
    into transaction_pr values (183, to_date('15-aug-20'), 17, 2, 24, 8)
    into transaction_pr values (184, to_date('18-aug-20'), 13, 1, 25, 7)
    into transaction_pr values (185, to_date('20-aug-20'), 7, 5, 105, 6)
    into transaction_pr values (186, to_date('22-aug-20'), 5, 4, 112, 5)
    into transaction_pr values (187, to_date('23-aug-20'), 3, 3, 54, 4)
    into transaction_pr values (188, to_date('24-aug-20'), 2, 2, 80, 3)
    into transaction_pr values (189, to_date('28-aug-20'), 4, 1, 25, 2)
    into transaction_pr values (190, to_date('30-aug-20'), 6, 1, 22, 1)
    into transaction_pr values (191, to_date('02-sep-20'), 8, 2, 40, 40)
    into transaction_pr values (192, to_date('03-sep-20'), 10, 3, 69, 39)
    into transaction_pr values (193, to_date('05-sep-20'), 12, 2, 48, 38)
    into transaction_pr values (194, to_date('08-sep-20'), 14, 3, 186, 37)
    into transaction_pr values (195, to_date('11-sep-20'), 16, 4, 120, 36)
    into transaction_pr values (196, to_date('14-sep-20'), 18, 5, 125, 35)
    into transaction_pr values (197, to_date('17-sep-20'), 20, 4, 68, 34)
    into transaction_pr values (198, to_date('18-sep-20'), 22, 3, 42, 33)
    into transaction_pr values (199, to_date('21-sep-20'), 24, 2, 38, 32)
    into transaction_pr values (200, to_date('24-sep-20'), 26, 1, 19, 31)
    into transaction_pr values (201, to_date('26-sep-20'), 28, 3, 156, 30)
    into transaction_pr values (202, to_date('28-sep-20'), 27, 4, 80, 29)
    into transaction_pr values (203, to_date('30-sep-20'), 25, 2, 46, 28)
    into transaction_pr values (204, to_date('01-oct-20'), 8, 5, 100, 29)
    into transaction_pr values (205, to_date('04-oct-20'), 9, 4, 76, 28)
    into transaction_pr values (206, to_date('06-oct-20'), 10, 2, 46, 27)
    into transaction_pr values (207, to_date('08-oct-20'), 11, 1, 28, 26)
    into transaction_pr values (208, to_date('10-oct-20'), 12, 2, 48, 25)
    into transaction_pr values (209, to_date('12-oct-20'), 13, 3, 75, 24)
    into transaction_pr values (210, to_date('15-oct-20'), 14, 4, 248, 23)
    into transaction_pr values (211, to_date('17-oct-20'), 15, 3, 60, 22)
    into transaction_pr values (212, to_date('19-oct-20'), 16, 2, 60, 21)
    into transaction_pr values (213, to_date('22-oct-20'), 17, 1, 12, 20)
    into transaction_pr values (214, to_date('25-oct-20'), 18, 2, 30, 19)
    into transaction_pr values (215, to_date('26-oct-20'), 19, 3, 66, 18)
    into transaction_pr values (216, to_date('28-oct-20'), 20, 4, 68, 17)
    into transaction_pr values (217, to_date('30-oct-20'), 21, 5, 50, 16)
    into transaction_pr values (218, to_date('01-nov-20'), 22, 4, 56, 15)
    into transaction_pr values (219, to_date('03-nov-20'), 23, 3, 39, 14)
    into transaction_pr values (220, to_date('04-nov-20'), 24, 2, 39, 13)
    into transaction_pr values (221, to_date('07-nov-20'), 25, 1, 23, 12)
    into transaction_pr values (222, to_date('09-nov-20'), 26, 2, 38, 11)
    into transaction_pr values (223, to_date('10-nov-20'), 27, 3, 60, 10)
    into transaction_pr values (224, to_date('12-nov-20'), 28, 4, 208, 9)
    into transaction_pr values (225, to_date('15-nov-20'), 17, 2, 24, 8)
    into transaction_pr values (226, to_date('18-nov-20'), 13, 1, 25, 7)
    into transaction_pr values (227, to_date('22-nov-20'), 5, 4, 112, 5)
    into transaction_pr values (228, to_date('28-nov-20'), 4, 1, 25, 2)
    into transaction_pr values (229, to_date('30-nov-20'), 6, 1, 22, 1)
    into transaction_pr values (230, to_date('02-dec-20'), 8, 2, 40, 40)
    into transaction_pr values (231, to_date('08-dec-20'), 10, 3, 69, 39)
    into transaction_pr values (232, to_date('16-dec-20'), 12, 2, 48, 38)
    into transaction_pr values (233, to_date('20-dec-20'), 14, 3, 186, 37)
    into transaction_pr values (234, to_date('27-dec-20'), 16, 4, 120, 36)    
    into transaction_pr values (235, to_date('02-jan-20'), 8, 5, 100,1) 
    into transaction_pr values (236, to_date('14-jan-20'), 1,2, 50, 14)
    into transaction_pr values (237, to_date('19-jan-20'), 20, 2, 34, 3)
    into transaction_pr values (238, to_date('25-jan-20'), 14, 3, 186, 8)
select 1 from dual;
    


--insert into animal_pr
insert all
    into animal_pr values( 1, 'Lion', 1, 'Mammals', 'N', 15)
    into animal_pr values( 2, 'Elephant', 1, 'Mammals', 'N', 55)
    into animal_pr values( 3, 'Rabbit', 1, 'Mammals', 'N', 10)
    into animal_pr values( 4, 'Porcupine', 1, 'Mammals', 'N', 18)
    into animal_pr values( 5, 'Eagle', 1, 'Birds', 'N', 23)
    into animal_pr values( 6, 'Wild Turkey', 1, 'Birds', 'N', 4)
    into animal_pr values( 7, 'Desert Box Turtle', 1, 'Reptiles', 'N', 30)
    into animal_pr values( 8, 'Black Bear', 1, 'Mammals', 'N', 30)
    into animal_pr values( 9, 'American Aligator', 1, 'Reptiles', 'N', 30)
    into animal_pr values( 10, 'Thick Billed Parrot', 1, 'Birds', 'N', 33)
    into animal_pr values( 11, 'Road Runner', 1, 'Birds', 'N', 7)
    into animal_pr values( 12, 'Zebra', 1, 'Mammals', 'N', 25)
    into animal_pr values( 13, 'Banded Leporinus', 1, 'Fish', 'N', 8)
    into animal_pr values( 14, 'Crocodile Monitor', 1, 'Reptiles', 'N', 55)
    into animal_pr values( 15, 'Eastern Indigo Snake', 1, 'Reptiles', 'N', 11)
    into animal_pr values( 16, 'Goat', 1, 'Mammals', 'N', 12)
    into animal_pr values( 17, 'Guam Kingfisher', 1, 'Bird', 'N', 13)
    into animal_pr values( 18, 'Lion', 2, 'Mammals', 'N', 15)
    into animal_pr values( 19, 'Tiger', 2, 'Mammals', 'N', 11)
    into animal_pr values( 20, 'Giraffe', 2, 'Mammals', 'N', 25)
    into animal_pr values( 21, 'Porcupine', 2, 'Mammals', 'N', 18)
    into animal_pr values( 22, 'Spiny Lizard', 2, 'Reptiles', 'N', 3)
    into animal_pr values( 23, 'Black Bear', 2, 'Mammals', 'N', 30)
    into animal_pr values( 24, 'Zebra', 2, 'Mammals', 'N', 25)
    into animal_pr values( 25, 'Bobcat', 2, 'Mammals', 'N', 10)
    into animal_pr values( 26, 'Chuckwalla', 2, 'Reptiles', 'N', 15)
    into animal_pr values( 27, 'Common Peafowl', 2, 'Birds', 'N', 20)
    into animal_pr values( 28, 'Eastern Indigo Snake', 2, 'Reptiles', 'N', 11)
    into animal_pr values( 29, 'Cobra', 2, 'Reptiles', 'N', 20)
    into animal_pr values( 30, 'Elephant', 3, 'Mammals', 'N', 55)
    into animal_pr values( 31, 'Giraffe', 3, 'Mammals', 'N', 25)
    into animal_pr values( 32, 'Owl', 3, 'Birds', 'N', 9)
    into animal_pr values( 33, 'Eagle', 3, 'Birds', 'N', 23)
    into animal_pr values( 34, 'Thick Billed Parrot', 3, 'Birds', 'N', 33)
    into animal_pr values( 35, 'Monkey', 3, 'Mammals', 'N', 18)
    into animal_pr values( 36, 'Green Tree Pyhton', 3, 'Reptiles', 'N', 20)
    into animal_pr values( 37, 'Eagle', 4, 'Birds', 'N', 23)
    into animal_pr values( 38, 'Desert Box Turtle', 4, 'Reptiles', 'N', 30)
    into animal_pr values( 39, 'Thick Billed Parrot', 4, 'Birds', 'N', 33)
    into animal_pr values( 40, 'Bobcat', 4, 'Mammals', 'N', 10)
    into animal_pr values( 41, 'Chuckwalla', 4, 'Reptiles', 'N', 15)
    into animal_pr values( 42, 'Banded Leporinus', 4, 'Fish', 'N', 8)
    into animal_pr values( 43, 'Crocodile Monitor', 4, 'Reptiles', 'N', 50)
    into animal_pr values( 44, 'Eagle', 5, 'Birds', 'N', 23)
    into animal_pr values( 45, 'Lion', 5, 'Mammals', 'N', 15)
    into animal_pr values( 46, 'Desert Box Turtle', 5, 'Reptiles', 'N', 30)
    into animal_pr values( 47, 'Roadrunner', 5, 'Birds', 'N', 7)
    into animal_pr values( 48, 'Monkey', 5, 'Mammals', 'N', 20)
    into animal_pr values( 49, 'Cobra', 5, 'Reptiles', 'N', 20)
    into animal_pr values( 50, 'Rabbit', 6, 'Mammals', 'N', 10)
    into animal_pr values( 51, 'Porcupine', 6, 'Mammals', 'N', 18)
    into animal_pr values( 52, 'Spiny Lizard', 6, 'Reptiles', 'N', 5)
    into animal_pr values( 53, 'Black Bear', 6, 'Mammals', 'N', 30)
    into animal_pr values( 54, 'Zebra', 6, 'Mammals', 'N', 25)
    into animal_pr values( 55, 'Common Peafowl', 6, 'Birds', 'N', 20)
    into animal_pr values( 56, 'Guam Kingfisher', 6, 'Birds', 'N', 15)
    into animal_pr values( 57, 'Banded Leporinus', 7, 'Fish', 'N', 8)
    into animal_pr values( 58, 'Crocodile Monitor', 7, 'Reptiles', 'N', 50)
    into animal_pr values( 59, 'Eagle', 7, 'Birds', 'N', 23)
    into animal_pr values( 61, 'Lion', 7, 'Mammals', 'N', 15)
    into animal_pr values( 60, 'Desert Box Turtle', 7, 'Reptiles', 'N', 30)
    into animal_pr values( 62, 'Roadrunner', 7, 'Birds', 'N', 7)
    into animal_pr values( 63, 'Owl', 8, 'Birds', 'N', 9)
    into animal_pr values( 64, 'Eagle', 8, 'Birds', 'N', 23)
    into animal_pr values( 65, 'Thick Billed Parrot', 8, 'Birds', 'N', 33)
    into animal_pr values( 66, 'Monkey', 8, 'Mammals', 'N', 18)
    into animal_pr values( 67, 'Green Tree Pyhton', 8, 'Reptiles', 'N', 20)
    into animal_pr values( 69, 'Desert Box Turtle', 8, 'Reptiles', 'N', 30)
    into animal_pr values( 71, 'Bobcat', 8, 'Mammals', 'N', 10)
    into animal_pr values( 72, 'Eagle', 9, 'Birds', 'N', 23)
    into animal_pr values( 73, 'Wild Turkey', 9, 'Birds', 'N', 4)
    into animal_pr values( 74, 'Desert Box Turtle', 9, 'Reptiles', 'N', 30)
    into animal_pr values( 75, 'Black Bear', 9, 'Mammals', 'N', 30)
    into animal_pr values( 76, 'American Aligator', 9, 'Reptiles', 'N', 30)
    into animal_pr values( 77, 'Thick Billed Parrot', 9, 'Birds', 'N', 33)
    into animal_pr values( 78, 'Road Runner', 9, 'Birds', 'N', 7)
    into animal_pr values( 79, 'Zebra', 9, 'Mammals', 'N', 25)
    into animal_pr values( 80, 'Banded Leporinus', 9, 'Fish', 'N', 8)
    into animal_pr values( 81, 'Crocodile Monitor', 10, 'Reptiles', 'N', 55)
    into animal_pr values( 82, 'Eastern Indigo Snake', 10, 'Reptiles', 'N', 11)
    into animal_pr values( 83, 'Goat', 10, 'Mammals', 'N', 12)
    into animal_pr values( 84, 'Guam Kingfisher', 10, 'Bird', 'N', 13)
    into animal_pr values( 85, 'Lion', 10, 'Mammals', 'N', 15)
    into animal_pr values( 86, 'Tiger', 10, 'Mammals', 'N', 11)
    into animal_pr values( 87, 'Giraffe', 10, 'Mammals', 'N', 25)
    into animal_pr values( 88, 'Porcupine', 11, 'Mammals', 'N', 18)
    into animal_pr values( 89, 'Spiny Lizard', 11, 'Reptiles', 'N', 3)
    into animal_pr values( 90, 'Black Bear', 11, 'Mammals', 'N', 30)  
    into animal_pr values( 91, 'Zebra', 11, 'Mammals', 'N', 25)
    into animal_pr values( 92, 'Bobcat', 11, 'Mammals', 'N', 10)
    into animal_pr values( 93, 'Chuckwalla', 11, 'Reptiles', 'N', 15)
    into animal_pr values( 94, 'Eagle', 11, 'Birds', 'N', 23)
    into animal_pr values( 95, 'Lion', 11, 'Mammals', 'N', 15)
    into animal_pr values( 96, 'Desert Box Turtle', 12, 'Reptiles', 'N', 30)
    into animal_pr values( 97, 'Roadrunner', 12, 'Birds', 'N', 7)
    into animal_pr values( 98, 'Monkey', 12, 'Mammals', 'N', 20)
    into animal_pr values( 99, 'Cobra', 12, 'Reptiles', 'N', 20)
    into animal_pr values( 100, 'Rabbit', 12, 'Mammals', 'N', 10)
    into animal_pr values( 101, 'Porcupine', 13, 'Mammals', 'N', 18)
    into animal_pr values( 102, 'Spiny Lizard', 13, 'Reptiles', 'N', 5)
    into animal_pr values( 103, 'Black Bear', 13, 'Mammals', 'N', 30)
    into animal_pr values( 104, 'Zebra', 13, 'Mammals', 'N', 25)
    into animal_pr values( 105, 'Common Peafowl', 13, 'Birds', 'N', 20)
    into animal_pr values( 106, 'Guam Kingfisher', 13, 'Birds', 'N', 15)
    into animal_pr values( 108, 'Banded Leporinus', 14, 'Fish', 'N', 8)
    into animal_pr values( 109, 'Crocodile Monitor', 14, 'Reptiles', 'N', 50)
    into animal_pr values( 110, 'Eagle', 14, 'Birds', 'N', 23)
    into animal_pr values( 111, 'Lion', 14, 'Mammals', 'N', 15)
    into animal_pr values( 113, 'Roadrunner', 14, 'Birds', 'N', 7)
    into animal_pr values( 115, 'Owl', 14, 'Birds', 'N', 9)
    into animal_pr values( 116, 'Thick Billed Parrot', 14, 'Birds', 'N', 33)
    into animal_pr values( 117, 'Monkey', 14, 'Mammals', 'N', 18)
    into animal_pr values( 118, 'Green Tree Pyhton', 14, 'Reptiles', 'N', 20)
    into animal_pr values( 120, 'Desert Box Turtle', 14, 'Reptiles', 'N', 30)
    into animal_pr values( 121, 'African Forest Elephant', 6, 'Mammals', 'Y', 43)
    into animal_pr values( 122, 'African Forest Elephant', 12, 'Mammals', 'Y', 43)
    into animal_pr values( 123, 'African Forest Elephant', 9, 'Mammals', 'Y', 43)
    into animal_pr values( 124, 'Black Rhino', 14, 'Mammals', 'Y', 30)
    into animal_pr values( 125, 'Black Rhino', 13, 'Mammals', 'Y', 30)
    into animal_pr values( 129, 'Black Rhino', 4, 'Mammals', 'Y', 30)
    into animal_pr values( 126, 'Sunda Tiger', 6, 'Mammals', 'Y', 16)
    into animal_pr values( 127, 'Sunda Tiger', 14, 'Mammals', 'Y', 16)
    into animal_pr values( 128, 'Sunda Tiger', 12, 'Mammals', 'Y', 16)
    into animal_pr values( 130, 'Giant Panda', 14, 'Mammals', 'Y', 16)
    into animal_pr values( 131, 'Brown Bear', 13, 'Mammals', 'Y', 20)
    into animal_pr values( 132, 'Brown Bear', 9, 'Mammals', 'Y', 20)
    into animal_pr values( 133, 'Cheetah', 14, 'Mammals', 'Y', 12)
    into animal_pr values( 134, 'Cheetah', 3, 'Mammals', 'Y', 12)
    into animal_pr values( 135, 'Cheetah', 6, 'Mammals', 'Y', 12)
    into animal_pr values( 136, 'Cheetah', 12, 'Mammals', 'Y', 12)
    into animal_pr values( 137, 'Cheetah', 13, 'Mammals', 'Y', 12)
select 1 from dual;


--insert into employee_pr
insert all 
    into employee_pr values ( 54, 'Taylor', 'Swift', to_date('12-Jun-88'), 1)
    into employee_pr values ( 55, 'Chris', 'Evans', to_date('11-jul-89'), 2)
    into employee_pr values ( 56, 'Chris', 'Hemsworth', to_date('10-aug-87'), 3)
    into employee_pr values ( 57, 'Rita', 'Vere' , to_date('09-sep-86'), 4)
    into employee_pr values ( 58, 'Anitha', 'Bath', to_date('08-oct-85'), 5)
    into employee_pr values ( 59, 'Sachin', 'Tendulkar',to_date('07-nov-84'), 6)
    into employee_pr values ( 60, 'Dale', 'Styen', to_date('06-dec-83'), 7)
    into employee_pr values ( 61, 'Adbul', 'Kalam', to_date('05-jan-82'), 8)
    into employee_pr values ( 62, 'Shikar', 'Dhawan', to_date('04-feb-80'), 9)
    into employee_pr values ( 63, 'Mahesh', 'Babu', to_date('03-mar-79'), 10)
    into employee_pr values ( 64, 'Aishwarya', 'Rai', to_date('24-apr-78'), 11)
    into employee_pr values ( 65, 'Alisa', 'Pullman', to_date('23-Jun-77'), 12)
    into employee_pr values ( 66, 'Afro', 'Jack',to_date('22-jul-65'), 1)
    into employee_pr values ( 67, 'Stephen', 'McGuire',to_date('21-aug-66'), 2)
    into employee_pr values ( 68, 'Drake', 'Ramoray', to_date('20-sep-67'), 3)
    into employee_pr values ( 69, 'Pawan', 'Kalyan', to_date('19-oct-68'), 4)
    into employee_pr values ( 70, 'Alia', 'Bhatt', to_date('18-nov-69'), 5)
    into employee_pr values ( 71, 'Indira', 'Gandhi', to_date('17-dec-70'), 6)
    into employee_pr values ( 72, 'Nikola', 'Tesla', to_date('16-jan-71'), 7)
    into employee_pr values ( 73, 'Guru', 'Teja', to_date('15-feb-72'), 8)
    into employee_pr values ( 74, 'Ian', 'Bell' ,to_date('14-mar-73'), 9)
    into employee_pr values ( 75, 'Alexandar' ,'Grahambell', to_date('13-apr-74'), 10)
    into employee_pr values ( 76, 'Dwayne', 'Johnson',to_date('12-Jun-75'), 11)
    into employee_pr values ( 77, 'Peter', 'Parker', to_date('11-jul-76'), 12)
    into employee_pr values ( 78, 'Wonder', 'Woman', to_date('10-aug-77'), 1)
    into employee_pr values ( 79, 'Ranbir', 'Singh', to_date('09-sep-78'), 2)
    into employee_pr values ( 80, 'Matt', 'Paterson', to_date('08-oct-79'), 3)
    into employee_pr values ( 81, 'Sean', 'Parker', to_date('07-nov-80'), 4)
    into employee_pr values ( 82, 'Max', 'Short', to_date('06-dec-81'), 5)
    into employee_pr values ( 83, 'Tony', 'Stark', to_date('05-jan-82'), 6)
select 1 from dual;

--insert into zoo_department_pr
insert all
    into zoo_department_pr values (1, 1, 1)
    into zoo_department_pr values (2, 1, 2)
    into zoo_department_pr values (3, 1, 3)
    into zoo_department_pr values (4, 1, 4)
    into zoo_department_pr values (5, 1, 5)
    into zoo_department_pr values (6, 1, 6)
    into zoo_department_pr values (7, 1, 7)
    into zoo_department_pr values (8, 2, 8)
    into zoo_department_pr values (9, 2, 9)
    into zoo_department_pr values (10, 2, 10)
    into zoo_department_pr values (11, 3, 11)
    into zoo_department_pr values (12, 3, 12)
    into zoo_department_pr values (13, 3, 1)
    into zoo_department_pr values (14, 4, 2)
    into zoo_department_pr values (15, 4, 3)
    into zoo_department_pr values (16, 5, 4)
    into zoo_department_pr values (17, 5, 5)
    into zoo_department_pr values (18, 5, 6)
    into zoo_department_pr values (19, 7, 7)
    into zoo_department_pr values (20, 8, 8)
    into zoo_department_pr values (21, 9, 9)
    into zoo_department_pr values (22, 10, 10)
    into zoo_department_pr values (23, 10, 11)
    into zoo_department_pr values (24, 11, 12)
    into zoo_department_pr values (25, 11, 1)
    into zoo_department_pr values (26, 11, 2)
    into zoo_department_pr values (27, 11, 3)
    into zoo_department_pr values (28, 12, 5)
    into zoo_department_pr values (29, 14, 4)
    into zoo_department_pr values (30, 14, 6)
select 1 from dual;

insert all
    into HABITAT_PR values (1,'Desert',96)
    into HABITAT_PR values (2,'Island',6)
    into HABITAT_PR values (3,'Mountains',131)
    into HABITAT_PR values (4,'Savanna',1)
    into HABITAT_PR values (5,'Tundra',130)
    into HABITAT_PR values (6,'Wetlands',14)
    into HABITAT_PR values (7,'Tropical RainForest',121)
    into HABITAT_PR values (8,'Prairie and Steppes',133)
    select 1 from dual;
  
insert all
    into Nutrition_PR values (1,'Insects',20,96)
    into Nutrition_PR values (2,'Spilled Birdseed ',18,6)
    into Nutrition_PR values (3,'Fish',32,131)
    into Nutrition_PR values (4,'Meat',45,1)
    into Nutrition_PR values (5,'Bamboo',28,130)
    into Nutrition_PR values (6,'Crustaceans',24,14)
    into Nutrition_PR values (7,'Bushes',16,121)
    into Nutrition_PR values (8,'Deer Meat',38,133)
    select 1 from dual;
    
insert all
    into animal_kingdom_pr values (1,'Eukaryota',96)
    into animal_kingdom_pr values (2,'Chordata',6)
    into animal_kingdom_pr values (3,'Ursidae',131)
    into animal_kingdom_pr values (4,'Linnaeus',1)
    into animal_kingdom_pr values (5,'Ailuropoda',130)
    into animal_kingdom_pr values (6,'Crocodyloidea',14)
    into animal_kingdom_pr values (7,'Elephantidae',121)
    into animal_kingdom_pr values (8,'Felidae',133)
    select 1 from dual;
    
Commit;


select * from zoo_info_pr;
select * from ticket_pricing_pr;

---------------------------------------------------------------------------------------------------------

-- Scenarios for Fetching Different type of Data from Different tables !!

-- Scenario 1
Select a.zoo_name as Zoo_Name,
       a.city || ',' || a.state || ',' || a.zip_code as Zoo_Address,
       (Select SUM(b.price*c.ticket_count) 
        from 
        Zoo_INFO_PR a 
        join TICKET_PRICING_PR b 
        on a.zoo_id = b.tp_zoo_id 
        join TRANSACTION_PR c 
        on b.ticket_id = c.ticket_id 
        where a.Zoo_Id = 3) as Revenue
from
ZOO_INFO_PR a 
where a.zoo_id = 3;

-- Scenario 2
Select a.zoo_name as Zoo_Name,
       b.Animal_name || '-' ||  b.Life_Expectency || 'yrs' as Animal_and_Life_Expentency,
       b.category,
       a.city || ',' || a.state || ',' || a.zip_code as Zoo_Address
from 
Zoo_INFO_PR a 
join Animal_PR b 
on a.zoo_id = b.zoo_id 
where a.Zoo_Id = 2;

-- Scenario 3
Select a.zoo_name as Zoo_Name,
        b.Animal_name,
       (Select COUNT(b.endangered_category) 
        from 
        Zoo_INFO_PR a 
        join Animal_PR b 
        on a.zoo_id = b.zoo_id 
        where a.Zoo_Id = 12 
        and b.endangered_category = 'Y') as Endangered_Animal_Count
from 
Zoo_INFO_PR a 
join Animal_PR b 
on a.zoo_id = b.zoo_id
where a.Zoo_Id = 12
and b.endangered_category = 'Y';

-- Scenario 4
Select a.zoo_name as Zoo_Name,
       (Select SUM(c.ticket_count) 
        from 
        Zoo_INFO_PR a 
        join TICKET_PRICING_PR b 
        on a.zoo_id = b.tp_zoo_id 
        join TRANSACTION_PR c 
        on b.ticket_id = c.ticket_id 
        where a.Zoo_Id = 5 and b.Ticket_type = 'Adult') as Adult_Count,
        (Select SUM(c.ticket_count) 
        from 
        Zoo_INFO_PR a 
        join TICKET_PRICING_PR b 
        on a.zoo_id = b.tp_zoo_id 
        join TRANSACTION_PR c 
        on b.ticket_id = c.ticket_id 
        where a.Zoo_Id = 5 and b.Ticket_type = 'Child') as Child_Count,
        a.city || ',' || a.state || ',' || a.zip_code as Zoo_Address
from
ZOO_INFO_PR a 
where a.zoo_id = 5;