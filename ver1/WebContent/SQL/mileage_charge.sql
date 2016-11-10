create table mileage_charge(
mc_id int(255) not null primary key auto_increment,
mc_mem_id int(255) not null,
mc_how int(255),
mc_value int(255),
mc_time varchar(255)
)
