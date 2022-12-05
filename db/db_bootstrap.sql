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
  ("Carlo", "D\'este"),
  ('Reggie', 'Books');


# ---------------- Curators ----------------
insert into Curators (firstName, lastName, email) values ('Stavros', 'Ashbey', 'sashbey0@mediafire.com');
insert into Curators (firstName, lastName, email) values ('Tedra', 'Bahlmann', 'tbahlmann1@webeden.co.uk');
insert into Curators (firstName, lastName, email) values ('Jard', 'Bernardy', 'jbernardy2@cbsnews.com');
insert into Curators (firstName, lastName, email) values ('Borden', 'Lake', 'blake3@ft.com');
insert into Curators (firstName, lastName, email) values ('Jobie', 'Hand', 'jhand4@sohu.com');
insert into Curators (firstName, lastName, email) values('Abby', 'Apple', 'abap@gmail.com');
insert into Curators (firstName, lastName, email) values('Bobby', 'Boston', 'bobo@gmail.com');
insert into Curators (firstName, lastName, email) values('Charlie', 'Chaplin', 'chacha@gmail.com');
insert into Curators (firstName, lastName, email) values('Dick', 'Dylan', 'didy@gmail.com');
insert into Curators (firstName, lastName, email) values('Ethan', 'Eeeee', 'ethee@gmail.com');
insert into Curators (firstName, lastName, email) values('Frank', 'Ferdinand', 'frafer@gmail.com');
insert into Curators (firstName, lastName, email) values('Gary', 'Goop', 'gargoo@gmail.com');

# ---------------- Sellers ----------------
insert into Sellers (firstName, lastName, email, location) values ('Gwenora', 'Heinicke', 'gheinicke0@webmd.com', '392 Waxwing Plaza');
insert into Sellers (firstName, lastName, email, location) values ('Sibyl', 'Pitcaithly', 'spitcaithly1@live.com', '72 Bartelt Plaza');
insert into Sellers (firstName, lastName, email, location) values ('Clemmy', 'Leguay', 'cleguay2@trellian.com', '6926 Erie Alley');
insert into Sellers (firstName, lastName, email, location) values ('York', 'Colcutt', 'ycolcutt3@techcrunch.com', '405 Summerview Drive');
insert into Sellers (firstName, lastName, email, location) values ('Bari', 'Seviour', 'bseviour4@furl.net', '11303 Del Mar Drive');
insert into Sellers (firstName, lastName, email, location) values ('Tom', 'Hanks', 'tomhanks@gmail.com', '10 Calumet St');
insert into Sellers (firstName, lastName, email, location) values ('Meryl', 'Streep', 'meryl@gmail.com', '11 Boylston St');
insert into Sellers (firstName, lastName, email, location) values ('Brad', 'Pitt', 'bradp@gmail.com', '12 Park St');
insert into Sellers (firstName, lastName, email, location) values ('Will', 'Smith', 'will@gmail.com', '13 Melnea Cass Blvd');
insert into Sellers (firstName, lastName, email, location) values ('Daniel', 'Radcliffe', 'harrypotter@gmail.com', '14 Hogwards Dr');

INSERT INTO Genre
  (name)
VALUES
  ('Fantasy'),
  ('Mythology'),
  ('History'),
  ('Non-Fiction'),
  ('Science Fiction'),
  ('Realistic Fiction'),
  ('Poetry');

INSERT INTO Books
  (ISBN, year, writer_id, title, img_url, publisher_name, genre_id)
VALUES
  ('0195153448', 2002, 1, 'Classical Mythology', 'http://images.amazon.com/images/P/0195153448.01.MZZZZZZZ.jpg', 'Oxford University Press', 2),
  ('0002005018', 2001, 2, 'Clara Callan', 'http://images.amazon.com/images/P/0002005018.01.MZZZZZZZ.jpg', 'HarperFlamingo Canada', 1),
  ('0060973129', 1991, 3, 'Decision in Normandy', 'http://images.amazon.com/images/P/0060973129.01.MZZZZZZZ.jpg', 'HarperPerennial', 3),
  ('0393045218', 1999, 4, 'The Mummies of Urumchi', 'http://images.amazon.com/images/P/0393045218.01.MZZZZZZZ.jpg', 'W. W. Norton &amp; Company', 1),
  ('0399135782', 1999, 4, 'The Kitchen Gods Wife', 'http://images.amazon.com/images/P/0399135782.01.MZZZZZZZ.jpg', 'Putnam Pub Group', 1),
  ('0425176428', 1999, 4, 'What If?: The Worlds Foremost Military Historians Imagine What Might Have Been', 'http://images.amazon.com/images/P/0425176428.01.MZZZZZZZ.jpg', 'Berkley Publishing Group', 4),
  ('0671870432', 1999, 4, 'PLEADING GUILTY', 'http://images.amazon.com/images/P/0671870432.01.MZZZZZZZ.jpg', 'Audioworks', 4),
  ('0679425608', 1999, 4, 'Under the Black Flag: The Romance and the Reality of Life Among the Pirates', 'http://images.amazon.com/images/P/0679425608.01.MZZZZZZZ.jpg', 'Random House', 3),
  ('074322678X', 1999, 4, 'Where Youll Find Me: And Other Stories', 'http://images.amazon.com/images/P/074322678X.01.MZZZZZZZ.jpg', 'Scribner', 6),
  ('0771074670', 1999, 4, 'Nights Below Station Street', 'http://images.amazon.com/images/P/0771074670.01.MZZZZZZZ.jpg', 'Emblem Editions', 6),
  ('080652121X', 1999, 4, 'Hitlers Secret Bankers: The Myth of Swiss Neutrality During the Holocaust', 'http://images.amazon.com/images/P/080652121X.01.MZZZZZZZ.jpg', 'Citadel Press', 3),
  ('0887841740', 1999, 4, 'The Middle Stories', 'http://images.amazon.com/images/P/0887841740.01.MZZZZZZZ.jpg', 'House of Anansi Press', 6),
  ('1552041778', 1999, 4, 'Jane Doe', 'http://images.amazon.com/images/P/1552041778.01.MZZZZZZZ.jpg', 'Mira Books', 3);


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
  ('0060973129', 3, 3, 'meh at best'),
  ('0393045218', 3, 5, 'awesome'),
  ('0399135782', 3, 3, 'ok'),
  ('0425176428', 3, 4, 'liked it'),
  ('0671870432', 3, 5, 'loved it'),
  ('0679425608', 3, 4, 'pretty good'),
  ('074322678X', 3, 3, 'whatever'),
  ('0771074670', 3, 1, 'yuck bro'),
  ('080652121X', 3, 5, 'fanTASTIC!!!1!1');

# ---------------- Books_Bought ----------------
insert into Books_Bought (book_id, reader_id, date_bought) values ('0195153448', 1, '2022-02-17');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0002005018', 2, '2022-08-29');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0060973129', 3, '2022-09-09');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0195153448', 2, '2022-11-04');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0002005018', 1, '2022-05-11');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0393045218', 3, '2022-05-12');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0425176428', 3, '2022-05-13');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0671870432', 3, '2022-05-14');
insert into Books_Bought (book_id, reader_id, date_bought) values ('074322678X', 3, '2022-05-15');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0771074670', 3, '2022-05-16');
insert into Books_Bought (book_id, reader_id, date_bought) values ('080652121X', 3, '2022-05-17');

# ---------------- BookSubmissions ----------------
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('0195153448', 1, '2022-02-17', true);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('0002005018', 3, '2022-08-29', false);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('0060973129', 2, '2022-09-09', false);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('0195153448', 2, '2022-11-04', false);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('0002005018', 2, '2022-05-11', false);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('0399135782', 6, '2022-05-11', true);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('0679425608', 6, '2022-05-12', true);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('0771074670', 6, '2022-05-13', true);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('080652121X', 6, '2022-05-14', true);

# ---------------- Recommendations  ----------------
insert into Recommendations (book_id, curator_id) values ('0195153448', 2);
insert into Recommendations (book_id, curator_id) values ('0002005018', 1);
insert into Recommendations (book_id, curator_id) values ('0060973129', 3);
insert into Recommendations (book_id, curator_id) values ('0195153448', 1);
insert into Recommendations (book_id, curator_id) values ('0002005018', 2);
insert into Recommendations (book_id, curator_id) values ('0399135782', 2);
insert into Recommendations (book_id, curator_id) values ('0679425608', 2);
insert into Recommendations (book_id, curator_id) values ('0060973129', 2);
insert into Recommendations (book_id, curator_id) values ('0771074670', 2);
insert into Recommendations (book_id, curator_id) values ('080652121X', 2);

# ---------------- Reading_List  ----------------
insert into Reading_List (book_id, reader_id) values ('0195153448', 2);
insert into Reading_List (book_id, reader_id) values ('0002005018', 1);
insert into Reading_List (book_id, reader_id) values ('0060973129', 1);
insert into Reading_List (book_id, reader_id) values ('0195153448', 3);
insert into Reading_List (book_id, reader_id) values ('0002005018', 3);
insert into Reading_List (book_id, reader_id) values ('0393045218', 3);
insert into Reading_List (book_id, reader_id) values ('0399135782', 3);
insert into Reading_List (book_id, reader_id) values ('0671870432', 3);
insert into Reading_List (book_id, reader_id) values ('0679425608', 3);
insert into Reading_List (book_id, reader_id) values ('080652121X', 3);

