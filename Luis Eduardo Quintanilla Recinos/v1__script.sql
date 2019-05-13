create schema authentication_1;

create table authentication_1.cli_client_information
(
  cli_code serial not null,
  cli_user Varchar(15) not null unique,
  cli_password varchar(500) not null,
  cli_name varchar(25) not null,
  cli_last_name varchar(25),
  cli_email varchar(25) not null,
  cli_count_session_fail integer,
  cli_status char(1),
  cli_create_user varchar(15),
  cli_create_date date,
  cli_modify_user varchar(10),
  cli_modify_date date,
  constraint cli_code primary key (cli_code)
);

create table authentication_1.to_token_session
(
  to_code serial not null,
  to_cli_code Integer not null,
  to_token varchar(500) not null,
  to_expiration_date timestamp not null,
  constraint to_code_pk primary key (to_code),
  constraint to_code_fk foreign key (to_cli_code) references authentication_1.cli_client_information(cli_code)
);

create table authentication_1.pro_product
(
  pro_code serial primary key,
  pro_user integer not null,
  pro_type_product varchar(25) not null,
  constraint pro_code_fk foreign key (pro_user) references authentication_1.cli_client_information(cli_code)
);

create table authentication_1.dpro_detalle_product
(
  dpro_code serial primary key,
  dpro_pro_code integer not null,
  dpro_id varchar(15),
  dpro_name varchar(25),
  constraint dpro_code_fk foreign key (dpro_pro_code) references authentication_1.pro_product(pro_code)
  
);

create table authentication_1.acc_accound_client(
	acc_cod serial primary key,
	acc_cli_code int null,
	acc_accound_number varchar(15) null,
	acc_accound_limit numeric(10,2),
	acc_amount numeric(10,2),
	CONSTRAINT acc_cli_code_fkey FOREIGN KEY (acc_cli_code) REFERENCES authentication_1.cli_client_information(cli_code)
);

create table authentication_1.trac_client_transaction(
	trac_cod serial primary key,
	trac_pro_code integer not null,
	trac_acc_accound_cod int not null,
	trac_account_origin varchar(15) null,
	trac_account_destination varchar(15) null,
	trac_description varchar(100),
	trac_fecha_transaction timestamptz,
	trac_amount numeric(10,2),
	CONSTRAINT tra_cli_code_fkey FOREIGN KEY (trac_cod) REFERENCES authentication_1.cli_client_information(cli_code),
	CONSTRAINT tra_acc_cod_fkey FOREIGN KEY (trac_acc_accound_cod) REFERENCES authentication_1.acc_accound_client(acc_cod),
	CONSTRAINT tra_pro_code_fkey FOREIGN KEY (trac_pro_code) REFERENCES authentication_1.pro_product(pro_code)
);
