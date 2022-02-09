CREATE TABLE IF NOT EXISTS Campus(
	campus_id INT PRIMARY KEY,
	name VARCHAR NOT NULL,
	address VARCHAR NOT NULL
);

CREATE TABLE IF NOT EXISTS Person(
	utorid VARCHAR PRIMARY KEY,
	last_name VARCHAR NOT NULL,
	first_name VARCHAR NOT NULL,
	date_of_birth DATE NOT NULL,
	sin INT UNIQUE
);

CREATE TABLE IF NOT EXISTS Employee(
	eid INT PRIMARY KEY,
	personnel_number INT NOT NULL UNIQUE，
	status VARCHAR NOT NULL,
	role VARCHAR NOT NULL.
	sin INT UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS Faculty(
	campus_id INT,
	name VARCHAR NOT NULL,
	phone_number VARCHAR NOT NULL,
	dean INT NOT NULL,	
	CONSTRAINT FACULTY_CAMPUS FOREIGN KEY (campus_id) REFERENCES Campus(campus_id),
	CONSTRAINT FACULTY_DEAN FOREIGN KEY (dean) REFERENCES Employee(eid),
	PRIMARY KEY (campus_id, name)
);

CREATE TABLE IF NOT EXISTS Department(
	department_id INT PRIMARY KEY，
	name VARCHAR NOT NULL,
	phone_number VARCHAR NOT NULL,
	chair INT NOT NULL,
	CONSTRAINT DEPARTMENT_CHAIR FOREIGN KEY (chair) REFERENCES Employee(eid),
	
);

CREATE TABLE IF NOT EXISTS Manage(
	--还要有faculty name
	campus_id INT,
	name VARCHAR,
	department_id INT,
	CONSTRAINT MANAGE_CAMPUS FOREIGN KEY (campus_id) REFERENCES Campus(campus_id),
	CONSTRAINT MANAGE_FACULTY FOREIGN KEY (name) REFERENCES Faculty(name),
	CONSTRAINT MANAGE_DEPARTMENT FOREIGN KEY (department_id) REFERENCES Department(department_id),
);

CREATE TABLE IF NOT EXISTS Course(
	course_code VARCHAR NOT NULL,
	session VARCHAR NOT NULL,
	PRIMARY KEY (course_code, session)
);

CREATE TABLE IF NOT EXISTS Offer(
	department_id INT,
	course_code VARCHAR,
	session VARCHAR,
	CONSTRAINT OFFER_DEPARTMENT FOREIGN KEY (department_id) REFERENCES Department(department_id);
	CONSTRAINT OFFER_COURSE FOREIGN KEY (course_code) REFERENCES Course(course_code);
	CONSTRAINT OFFER_SESSEION FOREIGN KEY (session) REFERENCES Course(session)
);

CREATE TABLE IF NOT EXISTS Professor(
	type VARCHAR NOT NULL,
	rank VARCHAR NOT NULL
);

CREATE TABLE IF NOT EXISTS Coordinate(
	eid INT REFERENCES Professor(eid),
	course_code VARCHAR,
	session VARCHAR,
	FOREIGN KEY (course_code, session) REFERENCES Course(course_code, session)
);

CREATE TABLE IF NOT EXISTS Teach(
	--不会写了 有些复杂啊
	eid INT REFERENCES Professor(eid),
	section VARCHAR NOT NULL UNIQUE,
	course_code VARCHAR,
	session VARCHAR,
	FOREIGN KEY (course_code, session) REFERENCES Course(course_code, session)
);

CREATE TABLE IF NOT EXISTS Student(
	student_id INT PRIMARY KEY,
	status VARCHAR,
	emergency_contact_name VARCHAR NOT NULL,
	emergency_contact_number VARCHAR NOT NULL
);

CREATE TABLE IF NOT EXISTS TeachingAssisstant(
	contract_hours INT NOT NULL	
);






CREATE TABLE IF NOT EXISTS (
	
);


CREATE TABLE IF NOT EXISTS (
	
);

