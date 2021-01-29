CREATE DATABASE IF NOT EXISTS beginner_example_database;
DROP TABLE IF EXISTS  beginner_example_database.board;
create table beginner_example_database.board(
	id bigint unsigned auto_increment primary key,
    title varchar(200) not null,
    content varchar(3000) not null,
    user_id varchar(50) not null,
	updated_at timestamp default current_timestamp,
    created_at timestamp default current_timestamp
);

create table beginner_example_database.user(
    id bigint unsigned auto_increment primary key,
    account_id varchar(100) unique not null,
    password varchar(100) not null,
    name varchar(50) not null,
    nickname varchar(50) not null,
    updated_at timestamp default current_timestamp,
    created_at timestamp default current_timestamp
);
<!-- FIX 정수현 :: token sql 삭제-->