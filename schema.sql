/**
* @author evilnapsis
* @brief Modelo de la base de datos
**/
create database smile;
use smile;

create table user(
	id int not null auto_increment primary key,
	name varchar(50) not null,
	lastname varchar(50) not null,
	username varchar(50),
	email varchar(255) not null,
	password varchar(60) not null,
	code varchar(20),
	is_active boolean not null default 0,
	is_admin boolean not null default 0,
	created_at datetime not null
);

/* insert into user(email,password,is_active,is_admin,created_at) value ("admin",sha1(md5("admin")),1,1,NOW()); */

create table recover (
	id int not null auto_increment primary key,
	user_id int not null,
	code varchar(20) not null,
	is_used boolean not null default 0,
	created_at datetime not null,
	foreign key(user_id) references user(id)
);

create table level(
	id int not null auto_increment primary key,
	name varchar(50)
);
insert into level (name) values ("Publico"), ("Solo amigos"), ("Amigos de mis amigos");


create table country(
	id int not null auto_increment primary key,
	name varchar(50),
	preffix varchar(50)
);

insert into country(name,preffix) values ("Mexico","mx"),("Argentina","ar"),("Espa~a","es"),("Estados Unidos","eu"),("Chile","cl"),("Colombia","co"),("Peru","pe");

create table sentimental(
	id int not null auto_increment primary key,
	name varchar(50)
);

insert into sentimental(name) values ("Soltero"),("Casado");

create table profile(
	day_of_birth date ,
	gender varchar(1) ,
	country_id int ,
	image varchar(255),
	image_header varchar(255),
	title varchar(255),
	bio varchar(255),
	likes text,
	dislikes text,
	address varchar(255) ,
	phone varchar(255) ,
	public_email varchar(255) ,
	user_id int ,
	level_id int ,
	sentimental_id int ,
	foreign key (sentimental_id) references sentimental(id),
	foreign key (country_id) references country(id),
	foreign key (level_id) references level(id),
	foreign key (user_id) references user(id)
);


create table album(
	id int not null auto_increment primary key,
	title varchar(200) not null,
	content varchar(500) not null,
	user_id int not null,
	level_id int not null,
	created_at datetime not null,
	foreign key (user_id) references user(id),
	foreign key (level_id) references level(id)
);

create table image(
	id int not null auto_increment primary key,
	src varchar(255) not null,
	title varchar(200) not null,
	content varchar(500) not null,
	user_id int not null,
	level_id int not null,
	album_id int,
	created_at datetime not null,
	foreign key (album_id) references album(id),
	foreign key (user_id) references user(id),
	foreign key (level_id) references level(id)
);

/**
* post_type_id
* 1.- status
* 2.- event
**/
create table post(
	id int not null auto_increment primary key,
	title varchar(500) ,
	content text not null,
	lat double ,
	lng double ,
	start_at datetime,
	finish_at datetime,
	wall_ref_id int not null default 1, /* 1.- user, 2.- group **/
	author_ref_id int not null,
	receptor_ref_id int not null,
	level_id int not null,
	post_type_id int default 1,
	created_at datetime not null,
	foreign key (level_id) references level(id)
);

create table post_image(
	post_id int not null,
	image_id int not null,
	foreign key (post_id) references post(id),
	foreign key (image_id) references image(id)
);

/**
* type_id:
* 1.- post
* 2.- image
**/
create table heart(
	id int not null auto_increment primary key,
	type_id int not null default 1,
	ref_id int not null,
	user_id int not null,
	created_at datetime not null,
	foreign key (user_id) references user(id)
);

create table comment(
	id int not null auto_increment primary key,
	type_id int not null,
	ref_id int not null,
	user_id int not null,
	content text not null,
	comment_id int,
	created_at datetime not null,
	foreign key (user_id) references user(id),
	foreign key (comment_id) references comment(id)
);

create table friend(
	id int not null auto_increment primary key,
	sender_id int not null,
	receptor_id int,
	is_accepted boolean not null default 0,
	is_readed boolean not null default 0,
	created_at datetime not null,
	foreign key (sender_id) references user(id),
	foreign key (receptor_id) references user(id)
);

create table conversation(
	id int not null auto_increment primary key,
	sender_id int not null,
	receptor_id int,
	created_at datetime not null,
	foreign key (sender_id) references user(id),
	foreign key (receptor_id) references user(id)
);

create table message(
	id int not null auto_increment primary key,
	content text not null,
	user_id int not null,
	conversation_id int,
	created_at datetime not null,
	is_readed boolean not null default 0,
	foreign key (user_id) references user(id),
	foreign key (conversation_id) references conversation(id)
);

/*
not_type_id: 
1.- like, 2.- comment
type:
1.- post, 2.- image
*/
create table notification(
	id int not null auto_increment primary key,
	not_type_id int not null,
	type_id int not null,
	ref_id int not null,
	receptor_id int not null,
	sender_id int not null,
	is_readed boolean not null default 0,
	created_at datetime not null,
	foreign key (sender_id) references user(id),
	foreign key (receptor_id) references user(id)
);

/* para grupos: no puedo usar la palabra reservada group, entonces uso team */
create table team (
	id int not null auto_increment primary key,
	image varchar(200),
	title varchar(200) not null,
	description varchar(500) ,
	user_id int not null,
	status int not null default 1 /* 1.- open, 2.- closed */,
	created_at datetime not null,
	foreign key (user_id) references user(id)
);
