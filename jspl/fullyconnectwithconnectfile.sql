create table fuser(user_id integer not null, user_name text , email text);
insert into fuser(user_id, user_name, email) values (101, 'Rajat' , 'rajatsoni@gmail.com');
select * from fuser;

CREATE TABLE user_auto (
        user_id INT NOT NULL,
		user_name TEXT NOT NULL,
        user_mail TEXT NOT NULL,
		audit_timestamp TIMESTAMP DEFAULT NOW()
        );

CREATE OR REPLACE FUNCTION user_auto_filled_data()
RETURNS trigger AS $$
BEGIN
    INSERT INTO user_auto(user_id, user_name, user_mail) 
    VALUES (NEW.user_id, NEW.user_name, NEW.email);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trigger_for_user_auto
    AFTER INSERT on fuser
    FOR EACH ROW
    EXECUTE FUNCTION user_auto_filled_data();


insert into fuser(user_id, user_name, email) values (102, 'Rajatsoni' , 'rajatsoniswm@gmail.com');
insert into fuser(user_id, user_name, email) values (103, 'Raja' , 'rajatsoni123@gmail.com');
insert into fuser(user_id, user_name, email) values (104, 'Raj' , 'rajatsoni321@gmail.com');


select * from fuser;
select * from user_auto;
drop trigger trigger_for_user_auto on users;
drop function user_auto_filled_data();

truncate fuser;


select user_mail , user_name ,  audit_timestamp from user_auto
where audit_timestamp > NOW()-INTERVAL '12 hours';

SELECT
	now(),
	now() - INTERVAL '12 hours'
             AS "12 hours ";

insert into fuser(user_id, user_name, email) values (102, 'Bikash' , 'bikash.maharana@jindalsteel.com');
insert into fuser(user_id, user_name, email) values (105, 'Rajatsoni123' , 'rajat123@gmail.com');
insert into fuser(user_id, user_name, email) values (106, 'Rajatsoni12' , 'rajat12@gmail.com');
insert into fuser(user_id, user_name, email) values (107, 'Rajatsoni111' , 'rajat111@gmail.com');
s