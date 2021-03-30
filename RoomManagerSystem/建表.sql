USE roommanager;
DESC userlogin;
CREATE TABLE admin_user(
	admin_memberName VARCHAR(30) PRIMARY KEY NOT NULL,
	admin_memberPassword VARCHAR(30) NOT NULL,
	admin_memberSex ENUM('男','女') NOT NULL,
	admin_email VARCHAR(30) NOT NULL,
	admin_memberTel VARCHAR(20) NOT NULL,
	admin_level INT DEFAULT 0 NOT NULL
	)ENGINE=INNODB DEFAULT CHARSET=utf8;
	
/*	
ALTER TABLE admin_user CHANGE admin_menberTel admin_memberTel VARCHAR(20) NOT NULL;
ALTER TABLE admin_user ADD admin_level INT DEFAULT 0 NOT NULL;
ALTER TABLE admin_userLogin RENAME TO admin_user;
*/

CREATE TABLE normal_user(
	normal_memberName VARCHAR(30) PRIMARY KEY NOT NULL,
	normal_memberPassword VARCHAR(30) NOT NULL,
	normal_memberSex ENUM('男','女') NOT NULL,
	normal_email VARCHAR(30) NOT NULL,
	normal_memberTel VARCHAR(20) NOT NULL
	)ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE roomInfo(
	roomNum VARCHAR(10) PRIMARY KEY NOT NULL,
	roomSeats INT NOT NULL,
	roomClass VARCHAR(30) NOT NULL,			-- 教室类别
	roomDept VARCHAR(30) NOT NULL,			-- 所属单位
	roomRequire VARCHAR(30) NOT NULL 		-- 工作需求
 	)ENGINE=INNODB DEFAULT CHARSET=utf8;
 	
 /*	
 alter table roomInfo drop column roomStatus;
*/	

CREATE TABLE roomRentInfo(
	rent_roomNum VARCHAR(10) NOT NULL,
	rent_memberName VARCHAR(30) NOT NULL,
	rent_email VARCHAR(30) NOT NULL,
	rent_memberTel VARCHAR(20) NOT NULL,
	rent_period VARCHAR(30) NOT NULL,
	rent_verify INT DEFAULT 1 NOT NULL,		-- 是否已审核 1表示未审核 0表示审核通过 -1表示审核不通过
	rent_adminName VARCHAR(30) NULL,
	rent_time VARCHAR(20) NOT NULL,
	FOREIGN KEY(rent_memberName) REFERENCES normal_user(normal_memberName),
	FOREIGN KEY(roomNum) REFERENCES roomInfo(roomNum),
	FOREIGN KEY(rent_adminName) REFERENCES admin_user(admin_memberName)
	)ENGINE=INNODB DEFAULT CHARSET=utf8; 
	
/*	
ALTER TABLE roomRentInfo CHANGE roomNum rent_roomNum VARCHAR(10) NOT NULL;
AlTER TABLE roomRentInfo change rent_startTime rent_period varchar(30) not null;
AlTER TABLE roomRentInfo drop column rent_endTime;
alter table roomRentInfo add rent_time varchar(20) not null;
ALTER table roomRentInfo change rent_adminName rent_adminName VARCHAR(30) NULL;
*/
-- 添加自定义外键约束 解决级联删除和级联更新问题
ALTER TABLE normal_user ADD INDEX idx_email(normal_email);
ALTER TABLE roomRentInfo ADD CONSTRAINT idx_email FOREIGN KEY (rent_email) 
	REFERENCES normal_user(normal_email) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE normal_user ADD INDEX idx_normalTel(normal_memberTel);
ALTER TABLE roomRentInfo ADD CONSTRAINT idx_normalTel FOREIGN KEY(rent_memberTel) 
	REFERENCES normal_user(normal_memberTel) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE normal_user ADD INDEX idx_memberName(normal_memberName);
ALTER TABLE roomRentInfo ADD CONSTRAINT idx_memberName FOREIGN KEY(rent_memberName) 
	REFERENCES normal_user(normal_memberName) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE admin_user ADD INDEX idx_adminName(admin_memberName);
ALTER TABLE roomRentInfo ADD CONSTRAINT idx_adminName FOREIGN KEY(rent_adminName) 
	REFERENCES admin_user(admin_memberName) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE roomInfo ADD INDEX idx_roomNum(roomNum);
ALTER TABLE roomRentInfo ADD CONSTRAINT idx_roomNum FOREIGN KEY(rent_roomNum) 
	REFERENCES roomInfo(roomNum) ON DELETE CASCADE ON UPDATE CASCADE;

DESC normal_user;
DESC admin_user;
DESC roomInfo;
DESC roomRentInfo;


