create table member_ec_pay(

mep_id int(255) not null primary key auto_increment,
mep_mem_id int(255) not null,
mep_where int(255) not null,
mep_value int(255) not null,
mep_time varchar(255) not null

)