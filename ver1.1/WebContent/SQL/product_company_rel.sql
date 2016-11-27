create table product_company_rel(
pd_id int(255) not null,
co_id VARCHAR(255) not null,
primary key(pd_id, co_id)
);
