create database if not exists `teamf_twitter`;

create table teamf_twitter.users (
  `id`            int(30)      unsigned not null auto_increment,
  `uuid`          varchar(255) not null,
  `user_id`       varchar(255) not null,
  `password_hash` varchar(255) not null,
  `password_salt` varchar(255) not null
  primary key(`id`)
) engine=InnoDB default charset=utf8;

create table teamf_twitter.items (
  `id`         int(30)       unsigned not null auto_increment,
  `uuid`       varchar(255)  not null,
  `hex`        varchar(255)  not null,
  `content`    varchar(255)  not null,
  `created_at` varchar( 255) timestamp not null default 0,
  `updated_at` varchar(255)  not null default current_timestamp on update current_timestamp,
  primary key(`id`)
) engine=InnoDB default charset=utf8;
