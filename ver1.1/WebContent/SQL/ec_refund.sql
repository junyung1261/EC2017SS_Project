create table ec_refund(
er_id int(255) not null primary key auto_increment,
er_mem_id int(255) not null,
er_why int(255) not null,
er_value int(255) not null,
er_state int(255) not null,
er_time varchar(255) not null

)