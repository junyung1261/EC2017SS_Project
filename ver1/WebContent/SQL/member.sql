create table member(
mem_id int(255) not null primary key auto_increment,
mem_method int(255) not null,
mem_user_id varchar(255) not null,
mem_password varchar(255) not null,
mem_birth varchar(255) not null,
mem_gender int(255) not null,
mem_msg_receive int(255) not null,
mem_phone varchar(255) not null,
mem_grade int(255) not null,
mem_reg varchar(255) not null
);
