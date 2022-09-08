use Final;
select * from film;
select * from `order`; 
select * from order_info;
select * from play_on;
select * from room;
select * from seat;
select * from snack;
select * from snack_detail;
select * from snack_order;
select * from staff;
select * from ticket;
select * from ticket_order;
select * from vip;

insert into snack_detail(snack_id, order_id, quantity) values ('2000000', '3000000', 6);
delete from snack_detail where snack_id = '2000000' and order_id = '3000000';
update vip set balance = 344.56 where card_number = '1000000'