create table ec_charge(
ec_id int(255) not null primary key auto_increment,
ec_mem_id int(255) not null,
ec_how int(255) not null,
ec_value int(255) not null,
ec_time varchar(255) not null

)
