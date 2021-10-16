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
    ("Angela", "Development"),
    ("Jonathan", "Business Analytics"),
    ("Nick", "Marketing"),
    ("Steve", "Marketing"),
    ("Mark", "Development");

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
    FOREIGN KEY (mrname) REFERENCES employee(mgrname)
);

INSERT INTO manages VALUES 
    ("Angela", "Boe"),
    ("Jonathan", "Ed"),
    ("Nick", "Anna"),
    ("Steve", "Marissa"),
    ("Mark", "Kevin");

-- Prolem 1a)
SELECT empname, salary, unitname
    FROM employee e, works w
    WHERE e.empname = w.empname;

-- Problem 1b)