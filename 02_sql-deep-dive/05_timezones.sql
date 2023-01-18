-- Display DB timezone resolution based on our location
SHOW TIMEZONE;

-- Set temporary standard time ( for the time DBMS is not closed  )
-- SET TIME ZONE 'UTC';


-- Permanently change and set the timezone for all users
-- For windows
-- ALTER USER postgres SET timezone='UTC';

-- For Mac Users
-- ALTER USER laurelineparis SET timezone='UTC';

-- ❗️ Make sure to create that query on localhost:5432 to avoid
-- having an issue "Alter command should specify what object to alter"