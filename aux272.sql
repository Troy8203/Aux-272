--crear una tabla
CREATE TABLE usuarios (
    ID INT PRIMARY KEY,
    USERNAME VARCHAR(50),
    PASSWORD VARCHAR(200)
);

--add column email
ALTER TABLE usuarios
	ADD EMAIL VARCHAR(200);

--modify column username
ALTER TABLE usuarios
	MODIFY USERNAME VARCHAR(70) NOT NULL UNIQUE;

--delete column email
ALTER TABLE usuarios
	DROP COLUMN email;

--delete tabla usuario
DROP TABLE usuarios

--Insert new user
INSERT INTO users VALUES(1, 'Carlo', 'hasudhau');
--*Alternative
INSERT INTO users (USERNAME, ID) VALUES('Juan23', 2);

--Update a password where id's user is 1
UPDATE users SET PASSWORD = '98765' WHERE ID = 1

--Delete user with id 2
DELETE FROM users WHERE id = 2;

--Delete all users
DELETE FROM users;
--*Alternative
TRUNCATE TABLE users



