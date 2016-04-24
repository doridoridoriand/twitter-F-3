create database if not exists `teamf_twitter`;

create table teamf_twitter.users (
  `id`            int(30)       unsigned not null auto_increment,
  `uuid`          varchar(768)  not null,
  `user_id`       varchar(255)  not null,
  `screen_name`   varchar(255)  not null default 'no name',
  `user_icon`     varchar(255)  not null,
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
  `id`          int(30)      unsigned not null auto_increment,
  `uuid`        varchar(255) not null,
  `target_uuid` varchar(255) not null,
  primary key(`id`)
) engine=InnoDB default charset=utf8;

create table teamf_twitter.followers (
  `id`          int(30)      unsigned not null auto_increment,
  `uuid`        varchar(255) not null,
  `target_uuid` varchar(255) not null,
  primary key(`id`)
) engine=InnoDB default charset=utf8;

create table teamf_twitter.items (
  `id`            int(30)      unsigned not null auto_increment,
  `uuid`          varchar(255) not null,
  `hex`           varchar(255) not null,
  `content`       varchar(255) not null,
  `like_count`    int(20)      not null default 0,
  `retweet_count` int(20)      not null default 0,
  `created_at`    timestamp    not null default 0,
  `updated_at`    timestamp    not null default current_timestamp on update current_timestamp,
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
) engine=InnoDB default charset=utf8;

create table teamf_twitter.notifications (
  `id`           int(30)      unsigned not null auto_increment,
  `uuid`         varchar(255) not null,
  `entry_uuid`   varchar(255) not null,
  `entry_hex`    varchar(255) not null,
  `like_flag`    boolean      not null default 0,
  `retweet_flag` boolean      not null default 0,
  `reply_flag`   boolean      not null default 0,
  `created_at`   timestamp    not null default current_timestamp
  primary key(`id`)
) engine=InnoDB default charset=utf8;

create table teamf_twitter.recommend_users (
  `id`            int(30)       unsigned not null auto_increment,
  `uuid`          varchar(768)  not null,
  `user_id`       varchar(255)  not null,
  `screen_name`   varchar(255)  not null default 'no name',
  `user_icon`     varchar(255)  not null,
  primary key(`id`)
) engine=InnoDB default charset=utf8;
