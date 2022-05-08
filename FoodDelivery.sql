create database Food_Delivery;
use Food_Delivery;
create table Customer(
	customer_id varchar(15) not null,
    customer_first_name varchar(20) not null,
    customer_last_name varchar(20) not null,
    customer_phone varchar(15) not null,
    customer_email varchar(50) not null,
    customer_address varchar(100) not null,
    customer_username varchar(30) NOT NULL,
	customer_password varchar(30) NOT NULL,
    PRIMARY KEY (customer_id)
);
select * from customer;
select COLUMN_NAME, CONSTRAINT_NAME, REFERENCED_COLUMN_NAME, REFERENCED_TABLE_NAME
from information_schema.KEY_COLUMN_USAGE
where TABLE_NAME = 'customer';
desc customer;
show create table customer;
create table Restaurant(
	restaurant_id varchar(15) not null,
    restaurant_name varchar(20) not null,
    restaurant_phone varchar(15) not null,
	restaurant_address varchar(100) not null,
    cuisine varchar(20) not null,
    PRIMARY KEY (restaurant_id),
    FOREIGN KEY	(customer_id) references Customer(customer_id)
);
select * from Restaurant;
select COLUMN_NAME, CONSTRAINT_NAME, REFERENCED_COLUMN_NAME, REFERENCED_TABLE_NAME
from information_schema.KEY_COLUMN_USAGE
where TABLE_NAME = 'Restaurant';

alter table restaurant drop constraint restaurant_ibfk_1;
alter table restaurant drop column customer_id;
alter table restaurant drop column food_id;
alter table restaurant add column cuisine varchar(20);

CREATE TABLE menu(
	
	restaurant_id varchar(15) not null,
	price int NOT NULL,
	cuisine varchar(15) NOT NULL,
    restaurant_name varchar(100) not null,
	food_id varchar(15) NOT NULL,
    food_name varchar(100) NOT NULL,
	PRIMARY KEY (restaurant_id,food_id),
	FOREIGN KEY (restaurant_id) references Restaurant(restaurant_id)
);
select * from menu;
select COLUMN_NAME, CONSTRAINT_NAME, REFERENCED_COLUMN_NAME, REFERENCED_TABLE_NAME
from information_schema.KEY_COLUMN_USAGE
where TABLE_NAME = 'menu';


alter table menu add column restaurant_name varchar(20) not null;
alter table menu drop column food_id;
alter table menu add column food_id varchar(10) not null;
alter table menu drop column food_name;
alter table menu add column food_name varchar(100) not null;

drop table menu;

create table employee(
	employee_id varchar(20) not null,
    employee_name varchar(20) not null,
    employee_lastname varchar(20),
    employee_phone varchar(15) not null,
	employee_birth_date date not null,
	employee_address varchar(100) not null,
    employee_job_role varchar(50) not null,
    employee_salary integer(30) not null,
    employee_joining_date date not null,
    primary key (employee_id)
);
select * from employee;
select COLUMN_NAME, CONSTRAINT_NAME, REFERENCED_COLUMN_NAME, REFERENCED_TABLE_NAME
from information_schema.KEY_COLUMN_USAGE
where TABLE_NAME = 'employee';


alter table employee add column employee_lastname varchar(20);

select * from employee;

Create table delivery_partner(
	employee_id varchar(20) not null,
    order_id integer not null,
    customer_id varchar(15) not null,
    time_slot varchar(50) not null,
    rating integer not null,
    tip integer,
    availability_status varchar(50) not null,
    PRIMARY KEY(employee_id, order_id, customer_id),
    FOREIGN KEY	(employee_id) references employee(employee_id),
    FOREIGN KEY	(customer_id) references Customer(customer_id),
    FOREIGN KEY	(order_id) references order_table(order_id)
);
select * from delivery_partner;
ALTER TABLE delivery_partner ADD PRIMARY KEY(employee_id, order_id, customer_id);

select COLUMN_NAME, CONSTRAINT_NAME, REFERENCED_COLUMN_NAME, REFERENCED_TABLE_NAME
from information_schema.KEY_COLUMN_USAGE
where TABLE_NAME = 'delivery_partner';
desc delivery_partner;

alter table delivery_partner drop column time_slot;
alter table delivery_partner add column time_slot varchar(10);
drop table delivery_partner;

CREATE TABLE IF NOT EXISTS order_table(
	order_id int(15) NOT NULL AUTO_INCREMENT,
	customer_id varchar(15) not null,
	employee_id varchar(20) not null,
	restaurant_id varchar(15) not null,
    food_name varchar(100) not null,
	order_time datetime default current_timestamp,
    order_quantity int(20) NOT NULL,
	order_status varchar(10) not null,
	order_price int(10) NOT NULL,
	order_location varchar(100),
	PRIMARY KEY (order_id),
	FOREIGN KEY	(employee_id) references employee(employee_id),
	FOREIGN KEY	(customer_id) references Customer(customer_id),
	FOREIGN KEY	(restaurant_id) references Restaurant(restaurant_id)
) AUTO_INCREMENT=1 ;
select * from order_table;
select COLUMN_NAME, CONSTRAINT_NAME, REFERENCED_COLUMN_NAME, REFERENCED_TABLE_NAME
from information_schema.KEY_COLUMN_USAGE
where TABLE_NAME = 'order_table';
alter table order_table drop column order_status;
alter table order_table add column order_status varchar(10) not null;


alter table order_table drop column order_location;
alter table order_table add column order_location varchar(100);
alter table order_table add column food_name varchar(100) not null;
alter table order_table drop column order_date;
alter table order_table drop column order_time;
alter table order_table add column order_time datetime default current_timestamp;


select * from order_table;

create table payment(
	transaction_id integer(15) not null,
    order_id int(15) NOT NULL,
	customer_id varchar(15) NOT NULL,
	employee_id varchar(20) NOT NULL,
    order_price int(10) NOT NULL,
    tip integer(5) not null,
    taxes integer(5) not null,
    discount int(5) not null,
    total_amount float not null,
    payment_mode varchar(50) not null,
    PRIMARY KEY (transaction_id),
	FOREIGN KEY	(order_id) references order_table(order_id),
	FOREIGN KEY	(customer_id) references Customer(customer_id),
	FOREIGN KEY	(employee_id) references employee(employee_id)
);
select * from payment;
select COLUMN_NAME, CONSTRAINT_NAME, REFERENCED_COLUMN_NAME, REFERENCED_TABLE_NAME
from information_schema.KEY_COLUMN_USAGE
where TABLE_NAME = 'payment';

alter table payment drop column invoice;
alter table payment drop column payment_mode;
alter table payment add column payment_mode varchar(50) not null;

select * from restaurant for update;
select * from restaurant;

select * from order_table for update;
select * from order_table;

select * from menu for update;
select * from menu;

select * from delivery_partner for update;
select * from delivery_partner;

delete from delivery_partner where employee_id = 'FOO_EMP_2' and order_id = 1;

select * from payment for update;

select distinct(food_name), sum(order_quantity) as total_count from order_table group by food_name;

select * from order_table;

select distinct(restaurant_name), count(*) as total_count 
from order_table join restaurant on order_table.restaurant_id = restaurant.restaurant_id group by order_table.restaurant_id;

select * from menu;
select restaurant_id, food_name, restaurant_name, max(price) from menu group by restaurant_id;

select distinct(employee_id), count(*) as Total_Orders_Delivered from delivery_partner group by employee_id;

select * from payment;

select distinct(payment_mode), count(*) from payment group by payment_mode;

select distinct(restaurant_name) from menu where cuisine = 'Italian';
select * from menu;
