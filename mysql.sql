create table if not exists manager
(
    mid       int auto_increment
        primary key,
    mname     varchar(50)  null,
    mpassword varchar(300) null,
    mphone    varchar(50)  null
);

create table if not exists type
(
    ttype varchar(50) not null
        primary key
);

create table if not exists dish
(
    did     int auto_increment
        primary key,
    ttype   varchar(50) null,
    dname   varchar(50) null,
    dprice  decimal     null,
    dnumber int         null,
    dimage  varchar(50) null,
    constraint fk_include
        foreign key (ttype) references type (ttype)
);

create table if not exists user
(
    uid       int auto_increment
        primary key,
    uname     varchar(50)  null,
    upassword varchar(300) null,
    uphone    varchar(50)  null
);

create table if not exists address
(
    aid     int auto_increment
        primary key,
    uid     int          null,
    adetail varchar(100) null,
    aphone  varchar(50)  null,
    aname   varchar(50)  null,
    constraint fk_have
        foreign key (uid) references user (uid)
);

create table if not exists `order`
(
    oid     int auto_increment
        primary key,
    did     int null,
    uid     int null,
    aid     int null,
    onumber int null,
    constraint fk_buy
        foreign key (uid) references user (uid),
    constraint fk_对应
        foreign key (aid) references address (aid),
    constraint fk_构成
        foreign key (did) references dish (did)
);

create table if not exists comment
(
    cid   int auto_increment
        primary key,
    oid   int          null,
    uid   int          null,
    ctext varchar(500) null,
    ctime varchar(50)  null,
    constraint fk_publish
        foreign key (uid) references user (uid),
    constraint fk_relate
        foreign key (oid) references `order` (oid)
);

create or replace definer = reservation@`%` view vs_address as
select `reservation`.`address`.`aid`     AS `aid`,
       `reservation`.`address`.`uid`     AS `uid`,
       `reservation`.`address`.`adetail` AS `adetail`,
       `reservation`.`address`.`aphone`  AS `aphone`,
       `reservation`.`address`.`aname`   AS `aname`
from `reservation`.`address`
         join `reservation`.`user`
where (`reservation`.`user`.`uid` = `reservation`.`address`.`uid`);

create or replace definer = reservation@`%` view vs_comment as
select `reservation`.`user`.`uname`    AS `uName`,
       `reservation`.`comment`.`uid`   AS `uid`,
       `reservation`.`comment`.`oid`   AS `oid`,
       `reservation`.`comment`.`ctext` AS `ctext`,
       `reservation`.`comment`.`ctime` AS `ctime`,
       `reservation`.`dish`.`dname`    AS `dname`,
       `reservation`.`dish`.`did`      AS `did`
from `reservation`.`dish`
         join `reservation`.`order`
         join `reservation`.`comment`
         join `reservation`.`user`
where ((`reservation`.`comment`.`oid` = `reservation`.`order`.`oid`) and
       (`reservation`.`order`.`did` = `reservation`.`dish`.`did`) and
       (`reservation`.`comment`.`uid` = `reservation`.`user`.`uid`));

create or replace definer = reservation@`%` view vs_dish as
select `reservation`.`dish`.`did`     AS `dId`,
       `reservation`.`dish`.`ttype`   AS `tType`,
       `reservation`.`dish`.`dname`   AS `dName`,
       `reservation`.`dish`.`dprice`  AS `dPrice`,
       `reservation`.`dish`.`dnumber` AS `dNumber`,
       `reservation`.`dish`.`dimage`  AS `dImage`
from `reservation`.`dish`;

create or replace definer = reservation@`%` view vs_manager as
select `reservation`.`manager`.`mid`    AS `mid`,
       `reservation`.`manager`.`mname`  AS `mname`,
       `reservation`.`manager`.`mphone` AS `mphone`
from `reservation`.`manager`;

create or replace definer = reservation@`%` view vs_order as
select `reservation`.`order`.`uid`       AS `uId`,
       `reservation`.`order`.`oid`       AS `oId`,
       `reservation`.`address`.`aname`   AS `aName`,
       `reservation`.`dish`.`dname`      AS `dName`,
       `reservation`.`order`.`onumber`   AS `oNumber`,
       `reservation`.`dish`.`dprice`     AS `dPrice`,
       `reservation`.`address`.`adetail` AS `aDetail`
from `reservation`.`order`
         join `reservation`.`user`
         join `reservation`.`address`
         join `reservation`.`dish`
where ((`reservation`.`order`.`did` = `reservation`.`dish`.`did`) and
       (`reservation`.`order`.`uid` = `reservation`.`user`.`uid`) and
       (`reservation`.`order`.`aid` = `reservation`.`address`.`aid`));

create or replace definer = reservation@`%` view vs_showdish as
select `reservation`.`dish`.`dname`  AS `dname`,
       `reservation`.`dish`.`dprice` AS `dprice`,
       `reservation`.`dish`.`dimage` AS `dimage`
from `reservation`.`dish`;

create or replace definer = reservation@`%` view vs_type as
select `reservation`.`type`.`ttype` AS `tType`
from `reservation`.`type`;

create or replace definer = reservation@`%` view vs_user as
select `reservation`.`user`.`uid`       AS `uid`,
       `reservation`.`user`.`uname`     AS `uName`,
       `reservation`.`user`.`upassword` AS `uPassword`,
       `reservation`.`user`.`uphone`    AS `uPhone`
from `reservation`.`user`;

create
    definer = reservation@`%` procedure delete_address(IN addId int)
begin
    delete from address where aId=addId;
end;

create
    definer = reservation@`%` procedure delete_dish(IN diId varchar(50))
begin
    delete from dish where dId=diId;
end;

create
    definer = reservation@`%` procedure insert_address(IN adduId int, IN addDetail varchar(50), IN addPhone varchar(50),
                                                       IN addName varchar(50))
begin
    insert into address(uId,aDetail,aPhone,aName)
    values(adduId,addDetail,addPhone,addName);
end;

create
    definer = reservation@`%` procedure insert_comment(IN coId int, IN couId int, IN coText varchar(500), IN coTime date)
begin
    insert into comment(oId,uId,cText,cTime)
    values(coId,couId,coText,coTime);
end;

create
    definer = reservation@`%` procedure insert_dish(IN diType varchar(50), IN diName varchar(50), IN diPrice decimal,
                                                    IN diNumber int, IN diImage varchar(50))
begin
    insert into dish(tType,dName,dPrice,dNumber,dImage)
    values(diType,diName,diPrice,diNumber,diImage);
end;

create
    definer = reservation@`%` procedure insert_order(IN odId int, IN ouId int, IN oaId int, IN orDnumber int)
begin
    insert into `order`(dId,uId,aId,oNumber)
    values(odId,ouId,oaId,orDnumber);
end;

create
    definer = reservation@`%` procedure insert_user(IN usName varchar(50), IN usPassword varchar(300),
                                                    IN usPhone varchar(50))
begin
    insert into `user`(uName,uPassword,uPhone)
    values(usName,SHA2(usPassword,256),usPhone);
end;

create
    definer = reservation@`%` function manager_login_in(m_name varchar(50), m_password varchar(300)) returns int
    reads sql data
begin
    declare m_id int;
    select mId
    into m_id
    from manager
    where mName=m_name
      and mPassword = SHA2(m_password, 256);
    return m_id;
end;

create
    definer = reservation@`%` procedure update_address(IN addaId int, IN adduId int, IN addDetail varchar(50),
                                                       IN addPhone varchar(50), IN addName varchar(50))
begin
    update address set uid=adduid,adetail=addDetail,aPhone=addPhone,aName=addName
    where aId=addaId;
end;

create
    definer = reservation@`%` procedure update_dish(IN diId int, IN diType varchar(50), IN diName varchar(50),
                                                    IN diPrice decimal, IN diNumber int, IN diImage varchar(50))
begin
    update dish set ttype=diType,dName=diName,dPrice=diPrice,dNumber=diNumber,dImage=diImage
    where dId=diId;
end;

create
    definer = reservation@`%` procedure update_user(IN usId int, IN usName varchar(50), IN usPassword varchar(300),
                                                    IN usPhone varchar(50))
begin
    update `user` set uName=usName,uPassword=SHA2(usPassword,256),uPhone=usPhone
    where uId=usId;
end;

create
    definer = reservation@`%` function user_login_in(u_name varchar(50), u_password varchar(300)) returns int
    reads sql data
begin
    declare u_id int;
    select uId
    into u_id
    from `user`
    where uName=u_name
      and uPassword = SHA2(u_password, 256);
    return u_id;
end;

