SHOW DATABASES;

CREATE DATABASE IF NOT EXISTS example;

USE example;

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS `tutorials_tbl` (
  `tutorial_id` int(11) NOT NULL AUTO_INCREMENT,
  `tutorial_title` varchar(100) NOT NULL,
  `tutorial_author` varchar(40) NOT NULL,
  `submission_date` date DEFAULT NULL,
  PRIMARY KEY (`tutorial_id`)
)

-- CREATE USER 'user1'@'%' IDENTIFIED BY 'Tibco@123';

-- GRANT ALL PRIVILEGES ON *.* TO 'user1'@'%' WITH GRANT OPTION;


CREATE USER 'onewayssl'@'%' IDENTIFIED by 'Tibco@123' REQUIRE SSL;
GRANT ALL PRIVILEGES on *.* TO 'onewayssl'@'%';


CREATE USER 'twowayssl'@'%' IDENTIFIED BY 'Tibco@123' REQUIRE X509;
GRANT ALL PRIVILEGES on *.* TO 'twowayssl'@'%';