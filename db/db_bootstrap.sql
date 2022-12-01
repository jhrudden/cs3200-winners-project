-- This file is to bootstrap a database for the CS3200 project. 

-- Create a new database.  You can change the name later.  You'll
-- need this name in the FLASK API file(s),  the AppSmith 
-- data source creation.
CREATE DATABASE `winnersDB`;

-- Via the Docker Compose file, a special user called webapp will 
-- be created in MySQL. We are going to grant that user 
-- all privilages to the new database we just created. 
-- TODO: If you changed the name of the database above, you need 
-- to change it here too.
grant all privileges on winnersDB.* to 'webapp'@'%';
flush privileges;

USE `winnersDB`;

CREATE TABLE Authors (
  id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  firstName VARCHAR(255),
  lastName VARCHAR(255)
);

CREATE TABLE Genre (
  id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL
);

CREATE TABLE Books (
  ISBN VARCHAR(255) PRIMARY KEY NOT NULL,
  year INT NOT NULL,
  writer_id INT NOT NULL,
  title VARCHAR(255) NOT NULL,
  img_url VARCHAR(255),
  publisher_name VARCHAR(255),
  genre_id INT NOT NULL,
  CONSTRAINT book_fk1 FOREIGN KEY (writer_id) REFERENCES Authors(id)
    ON UPDATE cascade ON DELETE restrict,
  CONSTRAINT book_fk2 FOREIGN KEY (genre_id) REFERENCES Genre(id)
    ON UPDATE cascade ON DELETE restrict
);


CREATE TABLE Readers (
  id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  email VARCHAR(255) UNIQUE NOT NULL,
  firstName VARCHAR(255),
  lastName VARCHAR(255),
  age INT,
  location VARCHAR(255)
);

CREATE TABLE Curators (
  id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  email VARCHAR(255) UNIQUE NOT NULL,
  firstName VARCHAR(255),
  lastName VARCHAR(255)
);

CREATE TABLE Sellers (
  id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  email VARCHAR(255) UNIQUE NOT NULL,
  firstName VARCHAR(255),
  lastName VARCHAR(255),
  location VARCHAR(255)
);

CREATE TABLE Ratings (
  book_id VARCHAR(255) NOT NULL,
  reader_id INT NOT NULL,
  score INT NOT NULL,
  comments TEXT,
  PRIMARY KEY (book_id, reader_id),
  CONSTRAINT scRange CHECK (score in (0, 1, 2, 3, 4, 5)),
  CONSTRAINT rating_fk1 FOREIGN KEY (book_id) REFERENCES Books(ISBN)
    ON UPDATE cascade ON DELETE restrict,
  CONSTRAINT rating_fk2 FOREIGN KEY (reader_id) REFERENCES Readers(id)
    ON UPDATE cascade ON DELETE restrict
);

CREATE TABLE Books_Bought (
  book_id VARCHAR(255) NOT NULL,
  reader_id INT NOT NULL,
  date_bought DATE NOT NULL,
  PRIMARY KEY (book_id, reader_id),
  CONSTRAINT bb_fk1 FOREIGN KEY (book_id) REFERENCES Books (ISBN)
    ON UPDATE cascade ON DELETE restrict,
  CONSTRAINT bb_fk2 FOREIGN KEY (reader_id) REFERENCES Readers (id)
    ON UPDATE cascade ON DELETE restrict
);

CREATE TABLE Book_Submissions (
  book_id VARCHAR(255) NOT NULL,
  seller_id INT NOT NULL,
  date_added DATE NOT NULL,
  accepted BOOLEAN NOT NULL,
  PRIMARY KEY (book_id, seller_id),
  CONSTRAINT bs_fk1 FOREIGN KEY (book_id) REFERENCES Books (ISBN)
    ON UPDATE cascade ON DELETE restrict,
  CONSTRAINT bs_fk2 FOREIGN KEY (seller_id) REFERENCES Sellers (id)
    ON UPDATE cascade ON DELETE restrict
);

CREATE TABLE Recommendations (
  book_id VARCHAR(255) NOT NULL,
  curator_id INT NOT NULL,
  PRIMARY KEY (book_id, curator_id),
  CONSTRAINT rec_fk1 FOREIGN KEY (book_id) REFERENCES Books (ISBN)
    ON UPDATE cascade ON DELETE restrict,
  CONSTRAINT rec_fk2 FOREIGN KEY (curator_id) REFERENCES Curators (id)
    ON UPDATE cascade ON DELETE restrict
);

CREATE TABLE Reading_List (
  book_id VARCHAR(255) NOT NULL,
  reader_id INT NOT NULL,
  PRIMARY KEY (book_id, reader_id),
  CONSTRAINT rl_fk1 FOREIGN KEY (book_id) REFERENCES Books (ISBN)
    ON UPDATE cascade ON DELETE restrict,
  CONSTRAINT rl_fk2 FOREIGN KEY (reader_id) REFERENCES Readers (id)
    ON UPDATE cascade ON DELETE restrict
);

INSERT INTO Authors
  (firstName, lastName)
VALUES
  ('Mark', 'Morford'),
  ('Richard', 'Wright'),
  ('Carlo', 'D\'este');

# ---------------- Curators ----------------
insert into Curators (firstName, lastName, email) values ('Stavros', 'Ashbey', 'sashbey0@mediafire.com');
insert into Curators (firstName, lastName, email) values ('Tedra', 'Bahlmann', 'tbahlmann1@webeden.co.uk');
insert into Curators (firstName, lastName, email) values ('Jard', 'Bernardy', 'jbernardy2@cbsnews.com');
insert into Curators (firstName, lastName, email) values ('Borden', 'Lake', 'blake3@ft.com');
insert into Curators (firstName, lastName, email) values ('Jobie', 'Hand', 'jhand4@sohu.com');

# ---------------- Sellers ----------------
insert into Sellers (firstName, lastName, email, location) values ('Gwenora', 'Heinicke', 'gheinicke0@webmd.com', '392 Waxwing Plaza');
insert into Sellers (firstName, lastName, email, location) values ('Sibyl', 'Pitcaithly', 'spitcaithly1@live.com', '72 Bartelt Plaza');
insert into Sellers (firstName, lastName, email, location) values ('Clemmy', 'Leguay', 'cleguay2@trellian.com', '6926 Erie Alley');
insert into Sellers (firstName, lastName, email, location) values ('York', 'Colcutt', 'ycolcutt3@techcrunch.com', '405 Summerview Drive');
insert into Sellers (firstName, lastName, email, location) values ('Bari', 'Seviour', 'bseviour4@furl.net', '11303 Del Mar Drive');

INSERT INTO Genre
  (name)
VALUES
  ('Fantasy'),
  ('Mythology'),
  ('History');

INSERT INTO Books
  (ISBN, year, writer_id, title, img_url, publisher_name, genre_id)
VALUES
  ('0195153448', 2002, 1, 'Classical Mythology', 'http://images.amazon.com/images/P/0195153448.01.MZZZZZZZ.jpg', 'Oxford University Press', 2),
  ('0002005018', 2001, 2, 'Clara Callan', 'http://images.amazon.com/images/P/0002005018.01.MZZZZZZZ.jpg', 'HarperFlamingo Canada', 1),
  ('0060973129', 1991, 3, 'Decision in Normandy', 'http://images.amazon.com/images/P/0060973129.01.MZZZZZZZ.jpg', 'HarperPerennial', 3);


INSERT INTO Readers
  (email, firstName, lastName, age, location)
VALUES
  ('jdoe@wmail.com', 'John', 'Doe', NULL, 'nyc, new york, usa'),
  ('afost@wmail.com', 'Ally', 'Fost', 18, 'stockton, california, usa'),
  ('vpopov@wmail.com', 'Vladimir', 'Popov', NULL, 'moscow, yukon territory, russia');

-- Ratings not accurate w/ dataset
INSERT INTO Ratings
  (book_id, reader_id, score, comments)
VALUES
  ('0195153448', 3, 0, 'terrible'),
  ('0002005018', 1, 5, 'superb'),
  ('0060973129', 3, 3, 'meh at best');

# ---------------- Books_Bought ----------------
insert into Books_Bought (book_id, reader_id, date_bought) values ('0195153448', 1, '2022-02-17');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0002005018', 2, '2022-08-29');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0060973129', 3, '2022-09-09');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0195153448', 2, '2022-11-04');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0002005018', 1, '2022-05-11');

# ---------------- BookSubmissions ----------------
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('0195153448', 1, '2022-02-17', true);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('0002005018', 3, '2022-08-29', false);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('0060973129', 2, '2022-09-09', false);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('0195153448', 2, '2022-11-04', false);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('0002005018', 2, '2022-05-11', false);

# ---------------- Recommendations  ----------------
insert into Recommendations (book_id, curator_id) values ('0195153448', 2);
insert into Recommendations (book_id, curator_id) values ('0002005018', 1);
insert into Recommendations (book_id, curator_id) values ('0060973129', 3);
insert into Recommendations (book_id, curator_id) values ('0195153448', 1);
insert into Recommendations (book_id, curator_id) values ('0002005018', 2);

# ---------------- Reading_List  ----------------
insert into Reading_List (book_id, reader_id) values ('0195153448', 2);
insert into Reading_List (book_id, reader_id) values ('0002005018', 1);
insert into Reading_List (book_id, reader_id) values ('0060973129', 1);
insert into Reading_List (book_id, reader_id) values ('0195153448', 3);
insert into Reading_List (book_id, reader_id) values ('0002005018', 3);
