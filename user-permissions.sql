-- Skapa utvecklarkonto

CREATE USER
    'developer' @'localhost' IDENTIFIED
WITH
    mysql_native_password BY 'developer_password';

GRANT ALL PRIVILEGES ON bookstore.* TO 'developer'@'localhost';

REVOKE CREATE, DROP ON *.* FROM 'developer' @'localhost';

-- Skapa webbserverkonto

CREATE USER
    'webserver' @'localhost' IDENTIFIED
WITH
    mysql_native_password BY 'webserver_password';

GRANT
SELECT,
INSERT,
UPDATE,
DELETE
    ON bookstore.* TO 'webserver' @'localhost';

REVOKE CREATE, DROP, ALTER ON *.* FROM 'webserver' @'localhost';

-- Ladda om ändrigarna för att de ska träda i kraft

FLUSH PRIVILEGES;