create table product(
pd_id int(255) not null primary key auto_increment,
co_id VARCHAR(255) not null,
cgp_id int(255) not null,
pd_name VARCHAR(255) not null,

pd_status int(255) not null,
pd_summary VARCHAR(255),
pd_main_img VARCHAR(255),
pd_detail_img VARCHAR(255),
pd_reg_date VARCHAR(255) not null,
pd_modify_date VARCHAR(255),
pd_sell_count int(255),
pd_wish_count int(255),
pd_review_count int(255),
pd_avg_rate float,

pd_keyword VARCHAR(255) not null,
pd_price int(255) not null,
pd_sale int(255) not null,
pd_sale_type int(255) not null,
pd_sale_value int(255)
);
