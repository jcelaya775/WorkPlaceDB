CREATE TABLE employee (
    empname VARCHAR(25),
    city VARCHAR(20),
    salary INT,
    PRIMARY KEY (empname)
);
  
INSERT INTO employee VALUES
    ("Steve", "Chicago", 45000),
    ("Jonathan", "Newark", 50000),
    ("Angela", "Brooklyn", 65000),
    ("Nick", "Jersey City", 85000),
    ("Mark", "Jersey City", 55000),
    ("Pat", "New York City", 60000),
    ("Rochelle", "Jersey City", 55000),
    ("Jamie", "Manhattan", 60000),
    ("Dennis", "San Jose", 50000),
    ("Brianna", "Boston", 85000);

CREATE TABLE unit (
    unitname VARCHAR(25),
    city VARCHAR(20),
    PRIMARY KEY (unitname)
);

INSERT INTO unit VALUES 
    ("Development", "Brooklyn"),
    ("Analytics", "Manhattan"),
    ("Marketing", "Chicago"),
    ("Communications", "San Francisco"),
    ("Network Security", "Boston"),
    ("something", "Alabama");

CREATE TABLE works (
    empname VARCHAR(10),
    unitname VARCHAR(25),
    PRIMARY KEY (empname, unitname),
    FOREIGN KEY (empname) REFERENCES employee(empname),
    FOREIGN KEY (unitname) REFERENCES unit(unitname)
);

INSERT INTO works VALUES
    ("Steve", "Marketing"),
    ("Jonathan", "Analytics"),
    ("Angela", "Development"),
    ("Nick", "Analytics"),
    ("Mark", "Network Security"),
    ("Pat", "Analytics"),
    ("Rochelle", "Development"),
    ("Jamie", "Development"),
    ("Dennis", "Communications"),
    ("Brianna", "Network Security"),
    ("Brianna", "Development");
    
CREATE TABLE manages (
    empname VARCHAR(25),
    mgrname VARCHAR(25),
    PRIMARY KEY (empname, mgrname),
    FOREIGN KEY (empname) REFERENCES employee(empname),
    FOREIGN KEY (mgrname) REFERENCES employee(empname)
);

INSERT INTO manages VALUES 
    ("Jonathan", "Nick"), -- analytics
    ("Pat", "Nick"), -- analytics
    ("Angela", "Brianna"), -- development
    ("Rochelle", "Brianna"), -- development
    ("Jamie", "Brianna"), -- development
    ("Steve", "Dennis"); -- communications/marketing

-- Prolem 1a)
SELECT e.empname, e.salary, w.unitname
    FROM employee e, works w
    WHERE e.empname = w.empname;

-- Problem 1b)
SELECT e.empname, e.salary, w.unitname
    FROM employee e JOIN works w
        ON e.empname = w.empname;

-- Problem 1c)
SELECT empname, salary
    FROM employee e 
    WHERE empname IN
        (SELECT empname
            FROM works w);

-- Problem 1d)
SELECT empname, salary
    FROM employee e
    WHERE EXISTS 
        (SELECT * 
            FROM works w
            WHERE e.empname = w.empname);

-- Problem 2)
CREATE VIEW employee_units as 
    SELECT e.empname, city, salary, w.unitname
        FROM employee e JOIN works w
            ON e.empname = w.empname;

-- Problem 3)
SELECT empname, city, salary 
	FROM employee_units
    WHERE unitname = "Development"
        AND salary > 50000;

-- Problem 4)
SELECT empname
    FROM employee_units e JOIN unit u
        ON e.unitname = u.unitname
        WHERE e.city = u.city;

-- Problem 5)
SELECT empname, city, salary * 1.10, unitname
    FROM employee_units 
    WHERE unitname = "Development";

-- Problem 6)
SELECT empname
    FROM employee_units e
    WHERE not EXISTS
        (SELECT city
            FROM unit u
            WHERE city like "A%"
         EXCEPT
            SELECT city 
                FROM unit u
                    WHERE u.unitname = e.unitname);

-- Problem 7)
SELECT unitname, count(*)
    FROM works 
    GROUP BY unitname
    HAVING count(*) < 5;

-- Problem 8)
SELECT empname
	FROM employee
    WHERE empname NOT IN 
    (SELECT empname
     	FROM works);

-- Problem 9)
SELECT mgrname, empname
    FROM manages m
    where exists
    (SELECT mgrname, city as mgrcity
            FROM employee_units e
            where m.empname = e.empname
       UNION 
            SELECT m.empname, city as empcity
                FROM employee_units e
				where m.empname = e.empname);

SELECT distinct *
    FROM manages m join employee_units eu
    	on m.mgrname = eu.empname
        	or m.empname = eu.empname
    and exists
    (SELECT mgrname, city as mgrcity
            FROM employee_units e
            where m.empname = e.empname
       UNION 
            SELECT m.empname, city as empcity
                FROM employee_units e
				where m.empname = e.empname);

-- Problem 10)
-- only selects one max
SELECT unitname, max(num_emps)
    FROM (SELECT unitname,  count(*) as num_emps
            FROM employee_units
            GROUP BY unitname);

-- only works on MySQL
SELECT unitname, count(*)
    FROM employee_units 
    GROUP BY unitname
    having count(*) >= ALL
        (SELECT count(*)
            FROM employee_units
            GROUP BY unitname);