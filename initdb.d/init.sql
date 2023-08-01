SET GLOBAL innodb_status_output=ON;
SET GLOBAL innodb_status_output_locks=ON;

CREATE TABLE users
(
    id         INT AUTO_INCREMENT PRIMARY KEY,
    name       VARCHAR(50)  NOT NULL,
    email      VARCHAR(100) NOT NULL,
    birth_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO users(name, email, birth_date) VALUES ("Alice", "alice.cooper@test.com", "1987-07-05");
INSERT INTO users(name, email, birth_date) VALUES ("Bob", "bob.dylan@test.com", "1975-03-19");
