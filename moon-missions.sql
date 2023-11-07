USE laboration1;

--  Uppgift 1

CREATE TABLE
    successful_mission AS
SELECT *
FROM moon_mission
WHERE outcome = "Successful";

-- Uppgift 2

ALTER TABLE
    successful_mission MODIFY mission_id INT AUTO_INCREMENT PRIMARY KEY;

-- Uppgift 3

UPDATE successful_mission SET operator = REPLACE(operator, ' ', '');

UPDATE moon_mission SET operator = REPLACE(operator, ' ', '');

-- Uppgift 4

DELETE FROM successful_mission WHERE YEAR(launch_date) >= 2010;

-- Uppgift 5

SELECT
    user_id,
    CONCAT(first_name, ' ', last_name) AS name,
    password,
    CASE
        WHEN SUBSTR(ssn, CHAR_LENGTH(ssn) - 1, 1) % 2 = 0 THEN 'female'
        ELSE 'male'
    END AS gender,
    ssn
FROM `account`;

-- Uppgift 6

DELETE FROM `account`
WHERE
    SUBSTR(ssn, CHAR_LENGTH(ssn) - 1, 1) % 2 = 0
    AND SUBSTRING(ssn, 1, 2) > (YEAR(CURDATE()) - 2000)
    AND SUBSTRING(ssn, 1, 2) < 70;

-- Uppgift 7

-- v1 returns average year

SELECT
    CASE
        WHEN SUBSTR(ssn, CHAR_LENGTH(ssn) - 1, 1) % 2 = 0 THEN 'female'
        ELSE 'male'
    END AS gender,
    SUM(
        IF(
            SUBSTRING(ssn, 1, 2) > (YEAR(CURDATE()) - 2000)
            AND SUBSTRING(ssn, 1, 2) <= 99,
            CONCAT('19', SUBSTRING(ssn, 1, 2)),
            CONCAT('20', SUBSTRING(ssn, 1, 2))
        )
    ) / COUNT(*) AS average_age
FROM `account`
GROUP BY gender;

-- v2 returns actual age

SELECT
    CASE
        WHEN SUBSTR(ssn, CHAR_LENGTH(ssn) - 1, 1) % 2 = 0 THEN 'female'
        ELSE 'male'
    END AS gender,
    AVG(
        TIMESTAMPDIFF(
            YEAR,
            IF(
                SUBSTRING(ssn, 1, 2) > (YEAR(CURDATE()) - 2000)
                AND SUBSTRING(ssn, 1, 2) <= 99,
                STR_TO_DATE(
                    CONCAT(
                        '19',
                        SUBSTRING(ssn, 1, 2),
                        SUBSTRING(ssn, 3, 2),
                        SUBSTRING(ssn, 5, 2)
                    ),
                    '%Y%m%d'
                ),
                STR_TO_DATE(
                    CONCAT(
                        '20',
                        SUBSTRING(ssn, 1, 2),
                        SUBSTRING(ssn, 3, 2),
                        SUBSTRING(ssn, 5, 2)
                    ),
                    '%Y%m%d'
                )
            ),
            CURDATE()
        )
    ) AS average_age
FROM `account`
GROUP BY gender;