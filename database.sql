CREATE TABLE employee (
    empname VARCHAR(25),
    city VARCHAR(20),
    salary INT,
    PRIMARY KEY (empname)
);
  
INSERT INTO employee VALUES
    ("Steve", "Los Angeles", 45000),
    ("Jonathan", "Chicago", 50000),
    ("Angela", "Brooklyn", 65000),
    ("Nick", "Naperville", 35000),
    ("Mark", "New Jersey", 55000);

CREATE TABLE works (
    empname VARCHAR(10),
    unitname VARCHAR(25),
    PRIMARY KEY (empname, unitname),
    FOREIGN KEY (empname) REFERENCES employee(empname),
    FOREIGN KEY (unitname) REFERENCES unit(unitname)
);

INSERT INTO works VALUES
    ("Angela", "development"),
    ("Jonathan", "business analytics"),
    ("Nick", "marketing"),
    ("Steve", "marketing"),
    ("Mark", "d
    evelopment");

CREATE TABLE unit (
    unitname VARCHAR(25),
    city VARCHAR(20),
    PRIMARY KEY (unitname)
);

INSERT INTO unit VALUES 
    ("Development", "Brooklyn"),
    ("Business Analytics", "Chicago"),
    ("Marketing", "Chicago");

CREATE TABLE manages (
    empname VARCHAR(25),
    mgrname VARCHAR(25),
    PRIMARY KEY (empname, mgrname)
    FOREIGN KEY (empname) REFERENCES employee(empname)
    FOREIGN KEY (mgrname) REFERENCES employee(mgrname)
);

INSERT INTO manages VALUES 
    ("Angela", "Boe"),
    ("Jonathan", "Ed"),
    ("Nick", "Anna"),
    ("Steve", "Marissa"),
    ("Mark", "Kevin");

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