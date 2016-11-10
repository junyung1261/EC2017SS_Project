create table member_bankaccount(
mb_id int(255) not null primary key auto_increment,
mb_mem_id int(255) not null,
mb_name varchar(255),
mb_bank varchar(255),
mb_account varchar(255),
mb_reg varchar(255)
)