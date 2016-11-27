create table order_info(
ord_id	int(255) primary key not null auto_increment,
ord_pd_id	int(255)		not null		,
ord_opt_color	varchar(255)		not null		,
ord_opt_size	varchar(255)		not null		,
ord_opt_count	int(255)		not null		,
ord_mem_id	int(255)		not null		,
ord_delivery_pay	int(255)		not null		,
ord_delivery_pay_method	int(255)		not null		,
ord_name_recipient	varchar(255)		not null		,
ord_phone_recipient	varchar(255)		not null		,
ord_zipcode	varchar(255)		not null		,
ord_address	varchar(255)		not null		,
ord_mileage	int(255)		not null		,
ord_mileage_value	int(255)		not null		,
ord_account_method	int(255)		not null		,
ord_account_value	int(255)		not null		,
ord_account_time	varchar(255)		not null		,
ord_delivery_co	int(255)				,
ord_delivery_num	varchar(255)				,
ord_msg	varchar(255)				,
ord_send_time	varchar(255)				,
ord_receive_time	varchar(255)				,
ord_decision_time	varchar(255)				,
ord_exchange_time	varchar(255)				,
ord_refnd_time	varchar(255)				,
ord_status	int(255)		not null		,
ord_status_msg	varchar(255)				



)

