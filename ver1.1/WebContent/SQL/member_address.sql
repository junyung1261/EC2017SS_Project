create table member_address(
ma_id int(255) not null primary key auto_increment,
ma_mem_id int(255) not null,
ma_name_recipient varchar(255),
ma_phone_recipient varchar(255),
ma_addr_zipcode varchar(255),
ma_addr_base varchar(255)
)