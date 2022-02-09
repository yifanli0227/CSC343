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
	sin INT	
);

CREATE TABLE IF NOT EXISTS Student(
	student_id INT PRIMARY KEY,
	status VARCHAR CHECK (status in ('part-time','full-time')),
	emergency_contact_name VARCHAR NOT NULL,
	emergency_contact_number VARCHAR NOT NULL
) INHERITS (Person);

CREATE TABLE IF NOT EXISTS Employee(
	eid INT PRIMARY KEY,
	personnel_number INT NOT NULL,
	status VARCHAR CHECK (status in ('part-time','full-time')),
	sin INT NOT NULL,
	role VARCHAR CHECK (role in ('Professor', 'Staff', 'Librarian'))
) INHERITS (Person);

CREATE TABLE IF NOT EXISTS Professor(
	type VARCHAR NOT NULL,
	rank VARCHAR NOT NULL,
	eid INT PRIMARY KEY
) INHERITS (Employee);

CREATE TABLE IF NOT EXISTS Staff(
	eid INT PRIMARY KEY
) INHERITS (Employee);

CREATE TABLE IF NOT EXISTS Librarian(
	eid INT PRIMARY KEY
) INHERITS (Employee);

CREATE TABLE IF NOT EXISTS TeachingAssisstant(	
	contract_hours INT NOT NULL,
	eid INT PRIMARY KEY
) INHERITS (Staff);

CREATE TABLE IF NOT EXISTS Faculty(
	campus_id INT,
	name VARCHAR NOT NULL,
	phone_number VARCHAR NOT NULL,
	dean INT,	
	CONSTRAINT FACULTY_CAMPUS FOREIGN KEY (campus_id) REFERENCES Campus(campus_id),
	CONSTRAINT FACULTY_DEAN FOREIGN KEY (dean) REFERENCES Employee(eid),
	PRIMARY KEY (campus_id, name)
);

CREATE TABLE IF NOT EXISTS Department(
	department_id INT PRIMARY KEY,
	name VARCHAR NOT NULL,
	phone_number VARCHAR NOT NULL,
	chair INT,
	CONSTRAINT DEPARTMENT_CHAIR FOREIGN KEY (chair) REFERENCES Employee(eid)	
);

CREATE TABLE IF NOT EXISTS Manage(
	campus_id INT,
	name VARCHAR,
	department_id INT,	
	CONSTRAINT MANAGE_FACULTY FOREIGN KEY (campus_id, name) REFERENCES Faculty(campus_id, name),
	CONSTRAINT MANAGE_DEPARTMENT FOREIGN KEY (department_id) REFERENCES Department(department_id)
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
	CONSTRAINT OFFER_DEPARTMENT FOREIGN KEY (department_id) REFERENCES Department(department_id),
	CONSTRAINT OFFER_COURSE FOREIGN KEY (course_code, session) REFERENCES Course(course_code, session)
);

CREATE TABLE IF NOT EXISTS Belong(
	campus_id INT,
	utorid VARCHAR,
	CONSTRAINT BELONG_CAMPUS FOREIGN KEY (campus_id) REFERENCES Campus(campus_id),
	CONSTRAINT BELONG_PERSON FOREIGN KEY (utorid) REFERENCES Person(utorid),
	CONSTRAINT BELONG_UNIQUE UNIQUE (utorid)
);

CREATE TABLE IF NOT EXISTS GoTo(
	campus_id INT,
	utorid VARCHAR,
	CONSTRAINT GOTO_CAMPUS FOREIGN KEY (campus_id) REFERENCES Campus(campus_id),
	CONSTRAINT GOTO_PERSON FOREIGN KEY (utorid) REFERENCES Person(utorid)
); 

CREATE TABLE IF NOT EXISTS Coordinate(
	course_code VARCHAR,
	session VARCHAR,
	eid INT,
	CONSTRAINT COORDINATE_COURSE FOREIGN KEY (course_code, session) REFERENCES Course(course_code, session),
	CONSTRAINT COORDINATE_PROF FOREIGN KEY (eid) REFERENCES Professor(eid),
	CONSTRAINT COORDINATE_UNIQUE UNIQUE (course_code, session)
);

CREATE TABLE IF NOT EXISTS Support(
	eid INT,
	course_code VARCHAR,
	session VARCHAR,
	CONSTRAINT SUPPORT_COURSE FOREIGN KEY (course_code, session) REFERENCES Course(course_code, session),
	CONSTRAINT SUPPORT_TA FOREIGN KEY (eid) REFERENCES TeachingAssisstant(eid)	
);

CREATE TABLE IF NOT EXISTS Become(
	eid INT,
	personnel_number INT NOT NULL,
	sin INT NOT NULL,
	student_id INT,
	CONSTRAINT BECOME_TA FOREIGN KEY (eid) REFERENCES TeachingAssisstant(eid),
	CONSTRAINT BECOME_STUDENT FOREIGN KEY (student_id) REFERENCES Student(student_id)	
);

CREATE TABLE IF NOT EXISTS Grade(
	course_code VARCHAR NOT NULL,
	mark NUMERIC NOT NULL,
	letter_grade VARCHAR NOT NULL,
	student_id INT,
	eid INT,
	CONSTRAINT GRADE_STUDENT FOREIGN KEY (student_id) REFERENCES Student(student_id),
	CONSTRAINT GRADE_PROF FOREIGN KEY (eid) REFERENCES Professor(eid)
);

CREATE TABLE IF NOT EXISTS Teach(
	eid INT,	
	student_id INT,
	course_code VARCHAR,
	session VARCHAR,	
	section VARCHAR NOT NULL,
	CONSTRAINT TEACH_PROF FOREIGN KEY (eid) REFERENCES Professor(eid),
	CONSTRAINT TEACH_STUDENT FOREIGN KEY (student_id) REFERENCES Student(student_id),
	CONSTRAINT TEACH_COURSE FOREIGN KEY (course_code, session) REFERENCES Course(course_code, session)
);
