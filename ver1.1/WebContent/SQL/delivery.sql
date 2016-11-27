create table delivery(
de_id INT(255) not null primary key auto_increment,
de_method INT(255) not null,
de_price INT(255),
de_price_exception INT(255),
de_price_condition INT(255)

);