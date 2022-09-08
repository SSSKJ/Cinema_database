use Final;
show tables;

create table if not exists vip (
card_number varchar(7) not null primary key,
first_name varchar(100) not null,
last_name varchar(100) not null,
phone_number varchar(10) not null,
address varchar(100) not null,
balance double not null,
credits double not null
);

create table if not exists room (
room_number varchar(2) not null primary key,
`type` enum('S', 'M', 'L') not null default 'S', 
capacity long not null
);

create table if not exists seat (
seat_number varchar(3) not null,
room_number varchar(2) not null,
occupied enum('0', '1') not null default '0',
primary key (seat_number, room_number),
constraint foreign key seat(room_number) references room(room_number) on delete cascade
);

create table if not exists film (
film_code varchar(3) not null primary key,
`name` varchar(100) not null,
director varchar(100),
leadingrole varchar(100),
nationality varchar(100),
release_date year not null
);

create table if not exists play_on (
film_code varchar(3) not null,
room_number varchar(2) not null,
`time` time not null,
`date` date not null,
constraint foreign key play_on(film_code) references film(film_code) on delete cascade,
constraint foreign key play_on(room_number) references room(room_number) on delete cascade,
primary	key (film_code, room_number, `time`, `date`)
);

create table if not exists staff (
id varchar(7) not null primary key,
first_name varchar(100) not null,
last_name varchar(100) not null,
age int not null,
address varchar(100) not null
);

create table if not exists ticket (
ticket_number varchar(7) not null primary key,
verification_code varchar(8) not null,
price long not null,
`time` time not null,
`date` date not null,
film_code varchar(3) not null,
room_number varchar(2) not null,
seat_number varchar(3) not null,
order_id varchar(7) not null,
constraint foreign key (film_code) references film(film_code),
constraint foreign key (room_number) references room(room_number),
constraint foreign key (order_id) references `order`(id)
);

create table if not exists snack (
id varchar(7) not null primary key,
`type` varchar(100) not null,
price long not null,
avaliable_amount long
);

create table if not exists `order` (
id varchar(7) not null primary key,
amount long not null,
`time` time not null,
`date` date not null
);

create table if not exists snack_order (
id varchar(7) not null primary key,
constraint foreign key snack_order(id) references `order`(id) on delete cascade
);

create table if not exists snack_detail (
snack_id varchar(7) not null,
order_id varchar(7) not null,
quantity long not null,
primary key (snack_id, order_id),
constraint foreign key snack_detail(order_id) references `order`(id) on delete cascade,
constraint foreign key snack_detail(snack_id) references snack(id) 
);

create table if not exists ticket_order (
id varchar(7) not null primary key,
ticket_amount long not null,
constraint foreign key ticket_order(id) references `order`(id) on delete cascade
);

create table if not exists order_info (
vip_id varchar(7),
staff_id varchar(7) not null,
order_id varchar(7) not null primary key,
order_type enum('ticket','snack') not null default 'ticket',
constraint foreign key (vip_id) references vip(card_number),
constraint foreign key (staff_id) references staff(id),
constraint foreign key (order_id) references `order`(id) on delete cascade
);

create trigger snack_amount
after insert on snack_detail
for each row
update snack
set avaliable_amount = avaliable_amount - new.quantity
where id = new.snack_id;

create trigger snack_amount_update
after delete on snack_detail
for each row
update snack
set avaliable_amount = avaliable_amount + old.quantity
where id = old.snack_id;

create trigger seat_status_update
after insert on ticket
for each row
update seat
set occupied = 1
where seat_number = new.seat_number and room_number = new.room_number;

create trigger seat_status_delete
before delete on ticket
for each row
update seat
set occupied = 0
where seat_number = old.seat_number and room_number = old.room_number;