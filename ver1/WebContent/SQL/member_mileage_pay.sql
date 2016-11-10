create table member_mileage_pay(
mmp_id int(255) not null primary key auto_increment,
mmp_mem_id int(255) not null,
mmp_where int(255),
mmp_value int(255),
mmp_time varchar(255)
)
