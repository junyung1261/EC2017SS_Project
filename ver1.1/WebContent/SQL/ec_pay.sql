create table ec_pay(
ep_id int(255) not null primary key auto_increment,
ep_mem_id int(255) not null,
ep_where int(255) not null,
ep_value int(255) not null,
ep_time varchar(255) not null

)