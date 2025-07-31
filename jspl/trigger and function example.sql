CREATE TABLE users (
        user_id SERIAL PRIMARY KEY,
        username TEXT NOT NULL
    );


CREATE TABLE user_audits (
        audit_id SERIAL PRIMARY KEY,
        event_type TEXT NOT NULL,
        user_id INT NOT NULL,
        audit_timestamp TIMESTAMP DEFAULT NOW(),
        old_data JSONB, -- Store previous values in JSON format
        new_data JSONB, -- Store new values in JSON format
        CONSTRAINT fk_user_audits_user_id FOREIGN KEY(user_id) REFERENCES users(user_id)
    );

CREATE OR REPLACE FUNCTION audit_user_changes()
    RETURNS TRIGGER AS $$
    BEGIN
        -- For INSERT events, record the new data
        IF (TG_OP = 'INSERT') THEN
            INSERT INTO user_audits (event_type, user_id, audit_timestamp, new_data)
            VALUES ('INSERT', NEW.user_id, NOW(), json_build_object('user_id', NEW.user_id, 'username', NEW.username));
        -- For UPDATE events, record both old and new data
        ELSIF (TG_OP = 'UPDATE') THEN
            INSERT INTO user_audits (event_type, user_id, audit_timestamp, old_data, new_data)
            VALUES ('UPDATE', NEW.user_id, NOW(), json_build_object('user_id', OLD.user_id, 'username', OLD.username), json_build_object('user_id', NEW.user_id, 'username', NEW.username));
        -- For DELETE events, record the old data
        ELSIF (TG_OP = 'DELETE') THEN
            INSERT INTO user_audits (event_type, user_id, audit_timestamp, old_data)
            VALUES ('DELETE', OLD.user_id, NOW(), json_build_object('user_id', OLD.user_id, 'username', OLD.username));
        END IF;
        RETURN NEW; -- For UPDATE/INSERT triggers, return the new row (or NULL for BEFORE triggers)
    END;
    $$ LANGUAGE plpgsql;

CREATE TRIGGER audit_user_trigger
    AFTER INSERT OR UPDATE OR DELETE ON users
    FOR EACH ROW
    EXECUTE FUNCTION audit_user_changes();

insert into users(user_id , username) values(101 ,  'rajatsoni')
insert into users(user_id , username) values(102 ,  'rajat')
select * from users; 
select * from user_audits; 


