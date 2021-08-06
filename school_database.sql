CREATE SCHEMA school_database;

CREATE TABLE school_database.admin ( 
	username             varchar(50)  NOT NULL    PRIMARY KEY,
	first_name           varchar(20)  NOT NULL    ,
	middle_name          varchar(20)  NOT NULL    ,
	last_name            varchar(20)      ,
	email                varchar(100)      
 ) engine=InnoDB;

ALTER TABLE school_database.admin COMMENT 'System administrator';

ALTER TABLE school_database.admin MODIFY username varchar(50)  NOT NULL   COMMENT 'admin username';

ALTER TABLE school_database.admin MODIFY first_name varchar(20)  NOT NULL   COMMENT 'admin''s first name';

ALTER TABLE school_database.admin MODIFY middle_name varchar(20)  NOT NULL   COMMENT 'admin''s middle name';

ALTER TABLE school_database.admin MODIFY last_name varchar(20)     COMMENT 'admin''s last name';

ALTER TABLE school_database.admin MODIFY email varchar(100)     COMMENT 'admin''s email';

CREATE TABLE school_database.teacher ( 
	teacher_matricule    varchar(20)  NOT NULL    PRIMARY KEY,
	first_name           varchar(20)      ,
	middle_name          varchar(20)      ,
	last_name            varchar(20)      ,
	email                varchar(100)      ,
	mark_id              int UNSIGNED NOT NULL    
 ) engine=InnoDB;

ALTER TABLE school_database.teacher COMMENT 'Lecturer or tutor of a course';

ALTER TABLE school_database.teacher MODIFY teacher_matricule varchar(20)  NOT NULL   COMMENT 'Teacher''s matricule';

ALTER TABLE school_database.teacher MODIFY first_name varchar(20)     COMMENT 'Teacher''s first name';

ALTER TABLE school_database.teacher MODIFY middle_name varchar(20)     COMMENT 'Teacher''s middle name';

ALTER TABLE school_database.teacher MODIFY last_name varchar(20)     COMMENT 'Teacher''s last name';

ALTER TABLE school_database.teacher MODIFY email varchar(100)     COMMENT 'Teacher''s email address';

ALTER TABLE school_database.teacher MODIFY mark_id int UNSIGNED NOT NULL   COMMENT 'Id number of mark allocated by teacher';

CREATE TABLE school_database.course ( 
	course_code          varchar(10)  NOT NULL    PRIMARY KEY,
	course_title         varchar(50)  NOT NULL    ,
	credit_value         int UNSIGNED NOT NULL    ,
	teacher_matricule    varchar(20)  NOT NULL    
 ) engine=InnoDB;

ALTER TABLE school_database.course COMMENT 'Subject taught by a teacher and studied by a student';

ALTER TABLE school_database.course MODIFY course_code varchar(10)  NOT NULL   COMMENT 'code that identitfies course';

ALTER TABLE school_database.course MODIFY course_title varchar(50)  NOT NULL   COMMENT 'Title of the course';

ALTER TABLE school_database.course MODIFY credit_value int UNSIGNED NOT NULL   COMMENT 'Number x10 of learning hours of the course';

ALTER TABLE school_database.course MODIFY teacher_matricule varchar(20)  NOT NULL   COMMENT 'Matricule of teacher';

CREATE TABLE school_database.student ( 
	student_matricule    varchar(20)  NOT NULL    PRIMARY KEY,
	first_name           varchar(20)  NOT NULL    ,
	middle_name          varchar(20)  NOT NULL    ,
	last_name            varchar(20)      ,
	email                varchar(100)      ,
	dob                  date  NOT NULL    ,
	teacher_matricule    varchar(20)  NOT NULL    ,
	mark_id              int UNSIGNED NOT NULL    
 ) engine=InnoDB;

ALTER TABLE school_database.student COMMENT 'Table holding student data';

ALTER TABLE school_database.student MODIFY student_matricule varchar(20)  NOT NULL   COMMENT 'matricule number of student';

ALTER TABLE school_database.student MODIFY first_name varchar(20)  NOT NULL   COMMENT 'Student''s first name';

ALTER TABLE school_database.student MODIFY middle_name varchar(20)  NOT NULL   COMMENT 'Student''s middle name';

ALTER TABLE school_database.student MODIFY last_name varchar(20)     COMMENT 'Student''s last name';

ALTER TABLE school_database.student MODIFY email varchar(100)     COMMENT 'student''s email address';

ALTER TABLE school_database.student MODIFY dob date  NOT NULL   COMMENT 'student''s date of birth';

ALTER TABLE school_database.student MODIFY teacher_matricule varchar(20)  NOT NULL   COMMENT 'Teacher''s matricule';

ALTER TABLE school_database.student MODIFY mark_id int UNSIGNED NOT NULL   COMMENT 'id number of student''s mark';

CREATE TABLE school_database.student_course ( 
	student_matricule    varchar(20)  NOT NULL    PRIMARY KEY,
	course_code          varchar(20)  NOT NULL    
 ) engine=InnoDB;

ALTER TABLE school_database.student_course COMMENT 'intermediary table to link student and course M:N relationship';

ALTER TABLE school_database.student_course MODIFY student_matricule varchar(20)  NOT NULL   COMMENT 'Matricule of student';

ALTER TABLE school_database.student_course MODIFY course_code varchar(20)  NOT NULL   COMMENT 'Course code of a course';

CREATE TABLE school_database.marks ( 
	mark_id              int UNSIGNED NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	student_matricule    varchar(20)  NOT NULL    ,
	teacher_matricule    varchar(20)  NOT NULL    ,
	course_code          varchar(50)  NOT NULL    
 ) engine=InnoDB;

ALTER TABLE school_database.marks COMMENT 'Mark allocated to students';

ALTER TABLE school_database.marks MODIFY mark_id int UNSIGNED NOT NULL  AUTO_INCREMENT COMMENT 'id number of student''s mark';

ALTER TABLE school_database.marks MODIFY student_matricule varchar(20)  NOT NULL   COMMENT 'Student''s matricule';

ALTER TABLE school_database.marks MODIFY teacher_matricule varchar(20)  NOT NULL   COMMENT 'Teacher''s matricule number';

ALTER TABLE school_database.marks MODIFY course_code varchar(50)  NOT NULL   COMMENT 'Course code of course';

ALTER TABLE school_database.course ADD CONSTRAINT fk_course_teacher FOREIGN KEY ( teacher_matricule ) REFERENCES school_database.teacher( teacher_matricule ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE school_database.marks ADD CONSTRAINT fk_marks_student FOREIGN KEY ( student_matricule ) REFERENCES school_database.student( student_matricule ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE school_database.marks ADD CONSTRAINT fk_marks_teacher FOREIGN KEY ( teacher_matricule ) REFERENCES school_database.teacher( teacher_matricule ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE school_database.marks ADD CONSTRAINT fk_marks_course FOREIGN KEY ( course_code ) REFERENCES school_database.course( course_code ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE school_database.student ADD CONSTRAINT fk_student_teacher FOREIGN KEY ( teacher_matricule ) REFERENCES school_database.teacher( teacher_matricule ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE school_database.student_course ADD CONSTRAINT fk_student_course_student FOREIGN KEY ( student_matricule ) REFERENCES school_database.student( student_matricule ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE school_database.student_course ADD CONSTRAINT fk_student_course_course FOREIGN KEY ( course_code ) REFERENCES school_database.course( course_code ) ON DELETE NO ACTION ON UPDATE NO ACTION;
