/*
Sometimes, set times will change, artists may run late or get carried away singing 
one of their bangers. In order to account for these changes in set times and track
how close to schedule the festival was, management has asked to create a log that 
will update everytime the set_time changes
*/  
DROP TABLE set_time_log;

CREATE TABLE set_time_log (
User VARCHAR(255),
artist_id VARCHAR(255),
name VARCHAR(255),
stage VARCHAR(255),
old_set_time VARCHAR(8),
new_set_time VARCHAR(8),
LogDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
DROP TRIGGER set_time_after_update;

DELIMITER $$
CREATE TRIGGER set_time_after_update
	AFTER UPDATE ON selected_artists
	FOR EACH ROW
BEGIN
	INSERT INTO set_time_log 
	(user, artist_id, name, stage, old_set_time, new_set_time)
	VALUES 
	(USER(), OLD.artist_id, OLD.name, OLD.stage, OLD.set_time, NEW.set_time);
END$$
DELIMITER ;

UPDATE selected_artists
SET set_time = "11:05 PM"
WHERE name = "Justin Bieber";


SELECT *
FROM set_time_log;

/*
Now we are able to see all of the changes in set time that took place.
*/