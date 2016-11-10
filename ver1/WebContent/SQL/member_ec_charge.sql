create table member_ec_charge(
mec_id int(255) not null primary key auto_increment,
mec_mem_id int(255) not null,
mec_how int(255) not null,
mec_value int(255) not null,
mec_time varchar(255) not null

)
