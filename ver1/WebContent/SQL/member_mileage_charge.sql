create table member_mileage_charge(
mmc_id int(255) not null primary key auto_increment,
mmc_mem_id int(255) not null,
mmc_how int(255),
mmc_value int(255),
mmc_time varchar(255)
)
