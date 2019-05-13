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


--insert

INSERT INTO authentication_1.cli_client_information (cli_code, cli_user, cli_password, cli_name, cli_last_name, cli_email, cli_count_session_fail, cli_status, cli_create_user, cli_create_date, cli_modify_user, cli_modify_date) VALUES(1, 'luquintanilla', '5588e2ca30a48b0b025f31cd35ebb948cfc7d372052ccbdd66234a75c88f65ca609be96bd4a7d8c61ead9633ba498f0a38aa47369ed3fe0969e09e5eafa2a54c', 'luis', 'quintanilla', 'luis@gmail.com', 5, 'A', 'luquintanilla', '2019-11-05', NULL, NULL);

INSERT INTO authentication_1.acc_accound_client (acc_cod, acc_cli_code, acc_accound_number, acc_accound_limit, acc_amount) VALUES(1, 1, '123456896', 2000.00, 500.00);

INSERT INTO authentication_1.pro_product (pro_code, pro_user, pro_type_product) VALUES(1, 1, 'loan');
INSERT INTO authentication_1.pro_product (pro_code, pro_user, pro_type_product) VALUES(2, 1, 'creditcard');
INSERT INTO authentication_1.pro_product (pro_code, pro_user, pro_type_product) VALUES(3, 1, 'prestamo');

INSERT INTO authentication_1.dpro_detalle_product (dpro_code, dpro_pro_code, dpro_id, dpro_name) VALUES(2, 1, '12316516511', 'Prestamo');
INSERT INTO authentication_1.dpro_detalle_product (dpro_code, dpro_pro_code, dpro_id, dpro_name) VALUES(3, 2, '46516513', 'CreditCard');
INSERT INTO authentication_1.dpro_detalle_product (dpro_code, dpro_pro_code, dpro_id, dpro_name) VALUES(4, 3, '87646516', 'Personal');

INSERT INTO authentication_1.trac_client_transaction (trac_cod, trac_pro_code, trac_acc_accound_cod, trac_account_origin, trac_account_destination, trac_description, trac_fecha_transaction, trac_amount) VALUES(1, 1, 1, '845313132132', '7984651351313', 'tranferencia cuentas propias', '2019-05-12 00:00:00.000', 25.00);
commit;
