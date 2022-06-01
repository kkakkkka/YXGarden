-- CREATE DATABASE boke18329015;
use boke18329015;

create table User (
	userID varchar(20) not null,
    password varchar(20) default null,
	userName varchar(26) DEFAULT NULL,
	isRoot BOOLEAN DEFAULT FALSE,
	speechStatus BOOLEAN DEFAULT TRUE,
    userAvatar varchar(255) default null,
    regTime timestamp not null default current_timestamp,
	motto text,
	homePage varchar(255) default null,
    primary key(userID)
) character set = utf8;

create table Ctable (
	ctableID varchar(20) not null,
    userID varchar(20) not null,
	catCount int DEFAULT 0,
    primary key (ctableID),
	foreign key(userID) references User(userID)
) character set = utf8;

create table Cat (
	catID varchar(20) not null,
	ctableID varchar(20) not null,
    catName varchar(20) not null,
    primary key (catID),
	foreign key(ctableID) references Ctable(ctableID)
) character set = utf8;

create table Ttable (
	ttableID varchar(20) not null,
    userID varchar(20) not null,
	tagCount int DEFAULT 0,
    primary key (ttableID),
	foreign key(userID) references User(userID)
) character set = utf8;

create table Tag (
	tagID varchar(20) not null,
	ttableID varchar(20) not null,
    tagName varchar(20) not null,
    primary key (tagID),
	foreign key(ttableID) references Ttable(ttableID)
) character set = utf8;

create table Blog (
	blogID varchar(20) not null,
    userID varchar(20) default null,
    catID varchar(20) default null,
	tagID varchar(20) default null,
    title text,
    content longtext,
    releaseTime timestamp not null default current_timestamp,
    updateTime timestamp not null default current_timestamp,
    articleLength int default 0,
    readDuration int default 0,
    commentCount int default 0,
	backgroundImg varchar(255) not null,
    primary key(blogID),
    foreign key(userID) references User(userID),
    foreign key(catID) references Cat(catID),
	foreign key(tagID) references Tag(tagID)
) character set = utf8;

create table Dtable (
	distID varchar(20) not null,
    userID varchar(20) not null,
	skillCount int DEFAULT 0,
    primary key (distID),
	foreign key(userID) references User(userID)
) character set = utf8;

create table Skill (
	skillID varchar(20) not null,
	distID varchar(20) not null,
    skillName varchar(20) not null,
    articleCount int DEFAULT 0,
    primary key (skillID),
	foreign key(distID) references Dtable(distID)
) character set = utf8;

create table Album (
	albumID varchar(20) not null,
    userID varchar(20) not null,
	picCount int DEFAULT 0,
    primary key (albumID),
	foreign key(userID) references User(userID)
) character set = utf8;

create table Pic (
	picID varchar(20) not null,
	albumID varchar(20) not null,
    name varchar(20) not null,
	content varchar(255) not null,
    uploadTime timestamp not null default current_timestamp,
    primary key (picID),
	foreign key(albumID) references Album(albumID)
) character set = utf8;

create table WebComment (
	msgID varchar(20) not null,
    userID varchar(20) default null,
    userPlace int default null,
    content text,
    time timestamp not null default current_timestamp,
    primary key(msgID),
    foreign key(userID) references User(userID)
) character set = utf8;

