-- CREATE DATABASE boke18329015;
use boke18329015;

create table User (
	userID int not null AUTO_INCREMENT,
    password varchar(26) default null,
	userName varchar(26) DEFAULT NULL UNIQUE,
	isRoot BOOLEAN DEFAULT FALSE,
	speechStatus BOOLEAN DEFAULT TRUE,
    userAvatar varchar(255) default null,
    regTime timestamp not null default current_timestamp,
	motto text,
	homePage varchar(255) default null,
    primary key(userID)
) character set = utf8;

create table Cat (
	catID int not null AUTO_INCREMENT,
	userID int not null,
    catName varchar(20) not null,
    primary key (catID),
	foreign key(userID) references User(userID)
) character set = utf8;

create table Tag (
	tagID int not null AUTO_INCREMENT,
	userID int not null,
    tagName varchar(20) not null,
    primary key (tagID),
	foreign key(userID) references User(userID)
) character set = utf8;

create table Blog (
	blogID int not null AUTO_INCREMENT,
    userID int not null,
    catID int not null,
	tagID int not null,
    title text,
    content longtext,
    releaseTime timestamp not null default current_timestamp,
    updateTime timestamp not null default current_timestamp,
	backgroundImg varchar(255) not null,
    primary key(blogID),
    foreign key(userID) references User(userID),
    foreign key(catID) references Cat(catID),
	foreign key(tagID) references Tag(tagID)
) character set = utf8;

create table Pic (
	picID int not null AUTO_INCREMENT,
	userID int not null,
    name varchar(20) default null,
	content varchar(255) not null,
    uploadTime timestamp not null default current_timestamp,
    primary key (picID),
	foreign key(userID) references User(userID)
) character set = utf8;

create table WebComment (
	msgID int not null AUTO_INCREMENT,
    userID int default null,
    userPlace varchar(20) default null,
    content text,
    time timestamp not null default current_timestamp,
    primary key(msgID),
    foreign key(userID) references User(userID)
) character set = utf8;

create table likes (
	likeID int not null AUTO_INCREMENT,
	userID int not null,
	blogID int not null,
	likeOrNot BOOLEAN DEFAULT FALSE,
    primary key (likeID),
	foreign key(userID) references User(userID) ON DELETE CASCADE,
	foreign key(blogID) references Blog(blogID) ON DELETE CASCADE
) character set = utf8;

ALTER TABLE likes ADD CONSTRAINT onelike UNIQUE(userID, blogID);


