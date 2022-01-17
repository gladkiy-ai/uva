select * from department;


SET PASSWORD FOR 'root'@'localhost' = 'Password!!!!';
SELECT CURRENT_USER();

CREATE USER 'admin'@'localhost'
  IDENTIFIED BY 'new_password';

select  p.name as FIO, 
		(select ts.Number 
        from timesheet ts
        where ts.id_pers=p.id
        limit 1) as TabNum,
        p.sal as Salary, d.name as Department, 
	   ph.name as Chief, ph.sal as Chief_sal		
from department d
join personal p on p.id_dep=d.id
join personal ph on ph.id=p.id_head
where p.sal > ph.sal
order by p.sal desc;

select ts.id_pers, ts.type, count(ts.id_pers)
from timesheet ts 
where ts.type='явка'
group by ts.id_pers
order by ts.type asc;

drop procedure insertTimeS;

delimiter $$  
  create procedure insertTimeS(IN n int)
    begin
      declare i int Default 0 ;
      declare r_id_pers int(5) ;
      declare r_number int(5) ;
      declare r_inDT datetime;
      declare r_outDT datetime;
      declare r_type char(20);
      declare t int(5);
      myloop: loop
      set r_id_pers=rand()*(select count(*) from personal)+1;
      set r_number=rand()*9999;
      set r_inDT=FROM_UNIXTIME(UNIX_TIMESTAMP('2018-09-11 14:53:27') + FLOOR(0 + (RAND() * 63072000)));
      set r_outDT=FROM_UNIXTIME(UNIX_TIMESTAMP(r_inDT) + FLOOR(0 + (RAND() * 28800)));
      set t=rand()*5;
      set r_type='явка';
      if t=1 then set r_type='выходной';
      elseif t=2 then set r_type='больничный';
      elseif t=3 then set r_type='отпуск';
      elseif t=4 then set r_type='отгул';
      end if;
      insert into `timesheet` (`id_pers`,`number`,`inDT`,`outDT`,`type`) VALUES (r_id_pers,r_number,r_inDT,r_outDT,r_type) ;
      set i=i+1;
      if i>n-1 then
        leave myloop;
	end if;
    end loop myloop;
  end $$
delimiter ;

call insertTimeS(5000);

select * from timesheet order by 1 desc;


drop procedure insertPers;

delimiter $$  
  create procedure insertPers(IN n int)
    begin
      declare i int Default 0 ;
      declare r_id_head int(5) ;
      declare r_id_dep int(5) ;
      declare r_name char(50) ;
      declare r_sal float(10,2) ;
      myloop: loop
      set r_id_head=rand()*(select count(*) from personal)+1;
      set r_id_dep=rand()*(select count(*)-1 from department);
      set r_name=concat('FIO_',conv(floor(rand() * 999999999999999), 20, 36));
      set r_sal=FLOOR(RAND()*9999999);
      insert into `personal` (`id_head`,`id_dep`,`name`,`sal`) VALUES (r_id_head,r_id_dep,r_name,r_sal) ;
      set i=i+1;
      if i>n-1 then
        leave myloop;
	end if;
    end loop myloop;
  end $$
delimiter ;

call insertPers(400);

select * from personal order by 1 desc;




drop procedure insertDep;

delimiter $$  
  create procedure insertDep(IN n int)
    begin
      declare i int Default 0 ;
      declare r_name char(50) ;
      declare r_address char(50) ;
      declare r_phone char(10) ;
      declare r_email char(50) ;
      myloop: loop
      set r_name=concat('NAME_',conv(floor(rand() * 99999999999999), 20, 36));
      set r_address=concat('ADDR_',conv(floor(rand() * 999999999999999), 20, 36));
      set r_phone=FLOOR(RAND()*99999999);
      set r_email=concat('email_',conv(floor(rand() * 9999999999), 10, 20),'@',
                         conv(floor(rand() * 9999999999), 10, 20) , '.' , conv(floor(rand() * 99999), 10, 20));
      insert into `department` (`name`,`address`,`phone`,`email`) VALUES (r_name,r_address,r_phone,r_email) ;
      set i=i+1;
      if i>n-1 then
        leave myloop;
	end if;
    end loop myloop;
  end $$
delimiter ;

call insertDep(10);

select * from department order by 1 desc;


select * from department d
join personal p on p.id_dep=d.id
#where p.id=p.id_head
order by p.id_dep; 


 select * from personal;  
 select * from department;                                           



CREATE DATABASE mdb;
commit;

         
CREATE TABLE `Department` (`id` INT(5) NOT NULL AUTO_INCREMENT, PRIMARY KEY(`id`),
							`name` VARCHAR(50),  `address` VARCHAR(50), `phone` VARCHAR(10), `email` VARCHAR(50),
                            INDEX(`name`,`phone`));
                            
                            
CREATE TABLE `Personal` (`id` INT(5) NOT NULL AUTO_INCREMENT PRIMARY KEY,
							`id_head` INT(5) NOT NULL, `id_dep` INT(5) NOT NULL, 
							`name` VARCHAR(50), `sal` FLOAT(10,2),  
                            INDEX(`name`,`sal`));

CREATE TABLE `TimeSheet` (`id` INT(5) NOT NULL AUTO_INCREMENT,PRIMARY KEY(`id`),
							`id_pers` INT(5) NOT NULL, `Number` INT(5), 
							`inDT` datetime, `outDT` datetime, `Type` VARCHAR(20), 
                            INDEX(`Number`,`Type`));
commit;
                            
show tables;


select * from department;
select * from personal;
select * from timesheet;

delete from department;
delete from personal;
delete from timesheet;



drop table Department;
                            

INSERT INTO Department(name,address,phone,email) VALUES ('Продажи','spb','','');
INSERT INTO Department(name,address,phone,email) VALUES ('Финансы','spb','','');
INSERT INTO Department(name,address,phone,email) VALUES ('Риски','spb','12345678','dd@good.ru');
INSERT INTO Department(name,address,phone,email) VALUES ('Розница','spb','','');
INSERT INTO Department(name,address,phone,email) VALUES ('Безопасность','spb','88888888','ee@good.ru');
INSERT INTO Department(name,address,phone,email) VALUES ('ДДК','spb','','');
INSERT INTO Department(name,address,phone,email) VALUES ('Блок Т','spb','','');
INSERT INTO Department(name,address,phone,email) VALUES ('President','spb','','');


INSERT INTO Department(name) VALUES ('Финансы');
INSERT INTO Department(name) VALUES ('Риски');
INSERT INTO Department(name) VALUES ('Розница');
INSERT INTO Department(name) VALUES ('Безопасность');
INSERT INTO Department(name) VALUES ('ДДК');
INSERT INTO Department(name) VALUES ('Блок Т');
INSERT INTO Department(name) VALUES ('President');

UPDATE Department SET name = 'Продажи' WHERE id = 5;   
UPDATE Personal  SET id_head = 17 WHERE id=id_head

INSERT INTO Personal(id_head,id_dep,name,sal) VALUES(1,5,'IvanovII',19876);
INSERT INTO Personal(id_head,id_dep,name,sal) VALUES(4,6,'PerivII',99339);
INSERT INTO Personal(id_head,id_dep,name,sal) VALUES(4,7,'TomovKK',136799);
INSERT INTO Personal(id_head,id_dep,name,sal) VALUES(2,5,'SidorovVV',3945);
INSERT INTO Personal(id_head,id_dep,name,sal) VALUES(2,8,'HazinMM',56557);
INSERT INTO Personal(id_head,id_dep,name,sal) VALUES(2,9,'PutinVB',69954);
INSERT INTO Personal(id_head,id_dep,name,sal) VALUES(1,10,'LevCB',79567);
INSERT INTO Personal(id_head,id_dep,name,sal) VALUES(2,5,'LashkoCC',23499);
INSERT INTO Personal(id_head,id_dep,name,sal) VALUES(4,6,'PetrovKK',45699);
INSERT INTO Personal(id_head,id_dep,name,sal) VALUES(8,8,'ChumovNN',50000);
UPDATE Personal SET name = 'BocharovDV' WHERE id = 5;  
UPDATE Personal SET id_head = 14 WHERE id_dep = 7; 
UPDATE Personal SET id_head = 8 WHERE id_dep = 8; 
UPDATE Personal SET id_head = 9 WHERE id_dep = 9; 
UPDATE Personal SET id_head = 10 WHERE id_dep = 10; 
INSERT INTO Personal(id_head,id_dep,name,sal) VALUES(12,12,'ChampionVV',5000000);

commit;

select * from department d
join personal p on p.id_dep=d.id
#where p.id=p.id_head
order by p.id_dep; 

                           
select d.name
from department d
join personal p on p.id_dep=d.id
group by d.id
order by count(*) desc 
limit 1;

select p.name, p.sal, d.name as dep, ph.name as head, ph.sal as head_sal
from department d
join personal p on p.id_dep=d.id
join personal ph on ph.id=p.id_head
where p.sal > ph.sal
order by p.sal desc