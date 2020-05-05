
DELIMITER $$

-- Remove prodcedure if it already exists
DROP PROCEDURE IF EXISTS create_set_list$$
DROP TABLE IF EXISTS set_list$$
CREATE TABLE set_list(
		track VARCHAR(255),
		start_time BIGINT(20),
		end_time BIGINT(20)
		);
-- Create procedure to accept artists
CREATE PROCEDURE create_set_list(in_artist_name VARCHAR(255), in_year VARCHAR(255))
-- Start the block of multiple statements
BEGIN 

  -- DECLARE variables
  -- Queried columns
  DECLARE track_name VARCHAR(255);
  DECLARE time_val BIGINT(20);

 	-- For LOOP termination flag
 	DECLARE starting_time BIGINT(20) DEFAULT 0;
	DECLARE ending_time BIGINT(20) DEFAULT 0;

  	-- DECLARE CURSOR
  	DECLARE track_cursor CURSOR FOR
  		SELECT track.name, track.duration_ms
  		FROM track 
  		JOIN album
  			ON album.album_id = track.album_id
  		JOIN artist
  			ON artist.artist_id = album.artist_id
  		WHERE artist.name = in_artist_name 
  			AND album.release_date > in_year
  		ORDER BY track.popularity DESC;

  -- Error Handling
  -- Execute when no row is found in the cursor (all rows read)
  DECLARE CONTINUE HANDLER FOR NOT FOUND
  	SET starting_time = 3600001;
  -- OPEN CURSOR to execute query
  OPEN track_cursor;

    -- Label and start LOOP
  	track_cursor_loop: LOOP
	    -- FETCH SELECT results into desired variables. Columns selected must match the # of variables.
	FETCH track_cursor INTO track_name, time_val;
	    -- Exit loop if no more rows to process
		IF ending_time > 3600000 THEN
			LEAVE track_cursor_loop;
		END IF;
	-- Increment the counter
	SET ending_time := ending_time + time_val;
	-- exit loop if total set time is longer than an hour
  	IF ending_time > 3600000 THEN
			LEAVE track_cursor_loop;
		END IF;
    -- Insert tracks into track table
	INSERT INTO set_list (track, start_time, end_time)
	VALUES (track_name, starting_time, ending_time);
    -- End LOOP
    SET starting_time := starting_time + time_val;
	END LOOP track_cursor_loop;
  -- CLOSE CURSOR to free up resources
  CLOSE track_cursor;
  -- Display the table created
  SELECT track,
  CONVERT(
        CONCAT(
            (FLOOR(start_time/ (1000 * 60*60)) % 60), 
                   ":", (FLOOR(start_time/ (1000 * 60)) % 60), 
                   ":", (FLOOR(start_time/ (1000) % 60))
        )
    , TIME) AS start_time,
    CONVERT(
        CONCAT(
            (FLOOR(end_time/ (1000 * 60*60)) % 60), 
                   ":", (FLOOR(end_time/ (1000 * 60)) % 60), 
                   ":", (FLOOR(end_time/ (1000) % 60))
        )
    , TIME) AS end_time
  FROM set_list;
-- End the block of multiple statements
END$$
-- Set DELIMITER back to ;
DELIMITER ;

-- Execute stored procedure
CALL create_set_list('Fisher', 2018);


