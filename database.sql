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
    ("Brianna", "Boston", 85000),
    ("Robert", "Sacramento", 40000);

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
    ("Jonathan", "Development"),
    ("Angela", "Development"),
    ("Nick", "Analytics"),
    ("Mark", "Network Security"),
    ("Pat", "Analytics"),
    ("Rochelle", "Development"),
    ("Jamie", "Development"),
    ("Dennis", "Communications"),
    ("Brianna", "Network Security"),
    ("Brianna", "Development"),
    ("Robert", "Communications");

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
    ("Network Security", "Boston");

CREATE TABLE manages (
    empname VARCHAR(25),
    mgrname VARCHAR(25),
    PRIMARY KEY (empname, mgrname)
    FOREIGN KEY (empname) REFERENCES employee(empname)
    FOREIGN KEY (mgrname) REFERENCES employee(empname)
);

INSERT INTO manages VALUES 
    ("Jonathan", "Nick"), -- analytics
    ("Pat", "Nick"), -- analytics
    ("Jonathan", "Brianna"), -- development
    ("Angela", "Brianna"), -- development
    ("Rochelle", "Brianna"), -- development
    ("Jamie", "Brianna"), -- development
    ("Robert", "Dennis"), -- communications/marketing
    ("Steve", "Dennis"); -- communications/marketing

-- Prolem 1a)
SELECT e.empname, e.salary, w.unitname
    FROM employee e, works w
    WHERE e.empname = w.empname;

-- Problem 1b)
SELECT e.empname, e.salary, w.unitname
    FROM employee e JOIN works w
        on e.empname = w.empname;

-- Problem 1c)
SELECT empname, salary
    FROM employee e 
    WHERE empname in 
        (SELECT empname
            from works w);

-- Problem 1d)
SELECT empname, salary
    FROM employee e
    WHERE EXISTS 
        (SELECT * 
            FROM works w
                WHERE e.empname = w.empname);