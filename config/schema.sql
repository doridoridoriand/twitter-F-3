create database if not exists `teamf_twitter`;

create table teamf_twitter.users (
  `id`            int(30)       unsigned not null auto_increment,
  `uuid`          varchar(768)  not null,
  `user_id`       varchar(255)  not null,
  `screen_name`   varchar(255)  not null default 'no name',
  `password_hash` varchar(1024) not null,
  `password_salt` varchar(1024) not null,
  primary key(`id`)
) engine=InnoDB default charset=utf8;

create table teamf_twitter.user_tokens (
  `id`    int(30)      unsigned not null auto_increment,
  `uuid`  varchar(255) not null,
  `token` varchar(255) not null,
  primary key(`id`)
) engine=InnoDB default charset=utf8;

create table teamf_twitter.followings (
  `id`  int(30) unsigned not null auto_increment,
  `uuid` varchar(255) not null,
  `target_uuid` varchar(255) not null,
  primary key(`id`)
) engine=InnoDB default charset=utf8;

create table teamf_twitter.followers (
  `id`  int(30) unsigned not null auto_increment,
  `uuid` varchar(255) not null,
  `target_uuid` varchar(255) not null,
  primary key(`id`)
) engine=InnoDB default charset=utf8;

create table teamf_twitter.items (
  `id`         int(30)       unsigned not null auto_increment,
  `uuid`       varchar(255)  not null,
  `hex`        varchar(255)  not null,
  `content`    varchar(255)  not null,
  `created_at` timestamp     not null default 0,
  `updated_at` timestamp     not null default current_timestamp on update current_timestamp,
  primary key(`id`)
) engine=InnoDB default charset=utf8;

create table teamf_twitter.likes (
  `id`         int(30)      unsigned not null auto_increment,
  `liker_uuid` varchar(255) not null,
  `owner_uuid` varchar(255) not null,
  `entry_hex`  varchar(255) not null,
  primary key(`id`)
) engine=InnoDB default charset=utf8;

create table teamf_twitter.retweets (
)
