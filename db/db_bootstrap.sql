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
  publisher_name VARCHAR(255),
  genre_id INT NOT NULL,
  visible BOOLEAN DEFAULT TRUE, 
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
  date_added DATE DEFAULT (CURRENT_DATE),
  accepted BOOLEAN DEFAULT NULL,
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

# ---------------- Authors ----------------
insert into Authors (firstName, lastName) values ('Sadye', 'Lassells');
insert into Authors (firstName, lastName) values ('Gabriellia', 'Brosel');
insert into Authors (firstName, lastName) values ('Melony', 'Vlach');
insert into Authors (firstName, lastName) values ('Peri', 'Minigo');
insert into Authors (firstName, lastName) values ('Tamara', 'Goldsworthy');
insert into Authors (firstName, lastName) values ('Fabio', 'Pavolini');
insert into Authors (firstName, lastName) values ('Andee', 'Shatliff');
insert into Authors (firstName, lastName) values ('Valry', 'Meedendorpe');
insert into Authors (firstName, lastName) values ('Gwenneth', 'Bleaden');
insert into Authors (firstName, lastName) values ('Hetti', 'Cobbled');
insert into Authors (firstName, lastName) values ('Amberly', 'Suston');
insert into Authors (firstName, lastName) values ('Eadith', 'Noyce');
insert into Authors (firstName, lastName) values ('Emmi', 'Sachno');
insert into Authors (firstName, lastName) values ('Renee', 'Woollett');
insert into Authors (firstName, lastName) values ('Bonni', 'Beaglehole');
insert into Authors (firstName, lastName) values ('Rustin', 'Naul');
insert into Authors (firstName, lastName) values ('Kermit', 'Collete');
insert into Authors (firstName, lastName) values ('Velma', 'Bessey');
insert into Authors (firstName, lastName) values ('Malena', 'Venditti');
insert into Authors (firstName, lastName) values ('Woodrow', 'Wakeford');
insert into Authors (firstName, lastName) values ('Brennan', 'Ort');
insert into Authors (firstName, lastName) values ('Lanny', 'Battey');
insert into Authors (firstName, lastName) values ('Starla', 'Spring');
insert into Authors (firstName, lastName) values ('Laughton', 'Coverley');
insert into Authors (firstName, lastName) values ('Abigail', 'Brusle');
insert into Authors (firstName, lastName) values ('Genny', 'Axcell');
insert into Authors (firstName, lastName) values ('Byrom', 'Nerne');
insert into Authors (firstName, lastName) values ('Dotty', 'Stainland');
insert into Authors (firstName, lastName) values ('Pierette', 'Gittose');
insert into Authors (firstName, lastName) values ('Husein', 'Sterricks');
insert into Authors (firstName, lastName) values ('Cathlene', 'Calafate');
insert into Authors (firstName, lastName) values ('Eddy', 'Adie');
insert into Authors (firstName, lastName) values ('Federica', 'Van der Kruys');
insert into Authors (firstName, lastName) values ('Carrol', 'Showalter');
insert into Authors (firstName, lastName) values ('Neely', 'Scandred');
insert into Authors (firstName, lastName) values ('Garold', 'Beadon');
insert into Authors (firstName, lastName) values ('Theodosia', 'Philps');
insert into Authors (firstName, lastName) values ('Faun', 'Honatsch');
insert into Authors (firstName, lastName) values ('Cristabel', 'Giddins');
insert into Authors (firstName, lastName) values ('Philippe', 'Wraith');
insert into Authors (firstName, lastName) values ('Gayler', 'Benton');
insert into Authors (firstName, lastName) values ('Sharla', 'Eacott');
insert into Authors (firstName, lastName) values ('Gena', 'Kilfether');
insert into Authors (firstName, lastName) values ('Mariellen', 'Iltchev');
insert into Authors (firstName, lastName) values ('Janaya', 'Macellar');
insert into Authors (firstName, lastName) values ('Gisele', 'McCullagh');
insert into Authors (firstName, lastName) values ('Reggie', 'Macvain');
insert into Authors (firstName, lastName) values ('Theresita', 'Gulliver');
insert into Authors (firstName, lastName) values ('Alecia', 'Medlar');
insert into Authors (firstName, lastName) values ('Kelwin', 'Riley');
insert into Authors (firstName, lastName) values ('Null', 'Book');



# ---------------- Curators ----------------
insert into Curators (firstName, lastName, email) values ('Leodora', 'Cheshir', 'lcheshir0@google.com.hk');
insert into Curators (firstName, lastName, email) values ('Nicoli', 'Battram', 'nbattram1@taobao.com');
insert into Curators (firstName, lastName, email) values ('Dalton', 'Leadbitter', 'dleadbitter2@facebook.com');
insert into Curators (firstName, lastName, email) values ('Alexandro', 'Heis', 'aheis3@economist.com');
insert into Curators (firstName, lastName, email) values ('Ave', 'Skrzynski', 'askrzynski4@bandcamp.com');
insert into Curators (firstName, lastName, email) values ('Bobbi', 'Aisthorpe', 'baisthorpe5@github.io');
insert into Curators (firstName, lastName, email) values ('Cortie', 'Bubb', 'cbubb6@google.com.hk');
insert into Curators (firstName, lastName, email) values ('Kathleen', 'Banister', 'kbanister7@springer.com');
insert into Curators (firstName, lastName, email) values ('Winfield', 'Bales', 'wbales8@vistaprint.com');
insert into Curators (firstName, lastName, email) values ('Hansiain', 'Peagram', 'hpeagram9@wikimedia.org');
insert into Curators (firstName, lastName, email) values ('Rriocard', 'Bissell', 'rbissella@ask.com');
insert into Curators (firstName, lastName, email) values ('Wallie', 'Abbitt', 'wabbittb@jalbum.net');
insert into Curators (firstName, lastName, email) values ('Casper', 'Dudeney', 'cdudeneyc@nifty.com');
insert into Curators (firstName, lastName, email) values ('Nelle', 'Cisar', 'ncisard@g.co');
insert into Curators (firstName, lastName, email) values ('Ransell', 'Lytton', 'rlyttone@alexa.com');
insert into Curators (firstName, lastName, email) values ('Chaddy', 'Caseborne', 'ccasebornef@senate.gov');
insert into Curators (firstName, lastName, email) values ('Krysta', 'Heake', 'kheakeg@army.mil');
insert into Curators (firstName, lastName, email) values ('Ber', 'Blow', 'bblowh@psu.edu');
insert into Curators (firstName, lastName, email) values ('Garrek', 'Spiby', 'gspibyi@independent.co.uk');
insert into Curators (firstName, lastName, email) values ('Darnall', 'Sondland', 'dsondlandj@google.cn');
insert into Curators (firstName, lastName, email) values ('Irwinn', 'Greenleaf', 'igreenleafk@devhub.com');
insert into Curators (firstName, lastName, email) values ('Barnie', 'De Gregario', 'bdegregariol@google.com.br');
insert into Curators (firstName, lastName, email) values ('Clovis', 'Burrells', 'cburrellsm@imdb.com');
insert into Curators (firstName, lastName, email) values ('Blondie', 'Lintott', 'blintottn@istockphoto.com');
insert into Curators (firstName, lastName, email) values ('Christoforo', 'Straw', 'cstrawo@i2i.jp');
insert into Curators (firstName, lastName, email) values ('Arnuad', 'Marchbank', 'amarchbankp@123-reg.co.uk');
insert into Curators (firstName, lastName, email) values ('Alard', 'Druce', 'adruceq@live.com');
insert into Curators (firstName, lastName, email) values ('Melisse', 'McGarrity', 'mmcgarrityr@360.cn');
insert into Curators (firstName, lastName, email) values ('Gilda', 'Clothier', 'gclothiers@multiply.com');
insert into Curators (firstName, lastName, email) values ('Car', 'Burberry', 'cburberryt@answers.com');
insert into Curators (firstName, lastName, email) values ('Kipp', 'Rowes', 'krowesu@europa.eu');
insert into Curators (firstName, lastName, email) values ('Pansie', 'Wakely', 'pwakelyv@ifeng.com');
insert into Curators (firstName, lastName, email) values ('Luisa', 'Muncer', 'lmuncerw@over-blog.com');
insert into Curators (firstName, lastName, email) values ('Toby', 'Doogue', 'tdooguex@si.edu');
insert into Curators (firstName, lastName, email) values ('Tierney', 'Coppard', 'tcoppardy@tiny.cc');
insert into Curators (firstName, lastName, email) values ('Nathaniel', 'Spellissy', 'nspellissyz@webnode.com');
insert into Curators (firstName, lastName, email) values ('Irena', 'McAlester', 'imcalester10@businesswire.com');
insert into Curators (firstName, lastName, email) values ('Homere', 'Ashbey', 'hashbey11@lulu.com');
insert into Curators (firstName, lastName, email) values ('Fanni', 'McCaughran', 'fmccaughran12@craigslist.org');
insert into Curators (firstName, lastName, email) values ('Olenolin', 'Touzey', 'otouzey13@tmall.com');
insert into Curators (firstName, lastName, email) values ('Inglebert', 'Brinkley', 'ibrinkley14@nyu.edu');
insert into Curators (firstName, lastName, email) values ('Blane', 'De Mitri', 'bdemitri15@wordpress.org');
insert into Curators (firstName, lastName, email) values ('Buddie', 'Maypowder', 'bmaypowder16@unesco.org');
insert into Curators (firstName, lastName, email) values ('Tatiana', 'Ianittello', 'tianittello17@theglobeandmail.com');
insert into Curators (firstName, lastName, email) values ('Wilhelm', 'Mongain', 'wmongain18@upenn.edu');
insert into Curators (firstName, lastName, email) values ('Lexis', 'Scothorn', 'lscothorn19@washington.edu');
insert into Curators (firstName, lastName, email) values ('Arleta', 'Mordan', 'amordan1a@oakley.com');
insert into Curators (firstName, lastName, email) values ('Cecily', 'Burniston', 'cburniston1b@narod.ru');
insert into Curators (firstName, lastName, email) values ('Chevy', 'Helm', 'chelm1c@webs.com');
insert into Curators (firstName, lastName, email) values ('Karlan', 'Voff', 'kvoff1d@theglobeandmail.com');

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
insert into Sellers (firstName, lastName, email, location) values ('Giraud', 'Mullane', 'gmullane0@google.fr', '2 Rigney Circle');
insert into Sellers (firstName, lastName, email, location) values ('Kyle', 'Ewbach', 'kewbach1@mit.edu', '7 Swallow Way');
insert into Sellers (firstName, lastName, email, location) values ('Barth', 'Harston', 'bharston2@topsy.com', '3345 Jackson Park');
insert into Sellers (firstName, lastName, email, location) values ('Clemmie', 'Rushbrook', 'crushbrook3@state.gov', '671 Elmside Crossing');
insert into Sellers (firstName, lastName, email, location) values ('Mona', 'Cutford', 'mcutford4@4shared.com', '780 Mallory Parkway');
insert into Sellers (firstName, lastName, email, location) values ('Morgen', 'Frear', 'mfrear5@sourceforge.net', '270 Eagle Crest Place');
insert into Sellers (firstName, lastName, email, location) values ('Dody', 'Pheazey', 'dpheazey6@latimes.com', '9 Carey Circle');
insert into Sellers (firstName, lastName, email, location) values ('Blake', 'Chasmar', 'bchasmar7@cbslocal.com', '050 Superior Lane');
insert into Sellers (firstName, lastName, email, location) values ('Art', 'Trodd', 'atrodd8@admin.ch', '2584 Basil Parkway');
insert into Sellers (firstName, lastName, email, location) values ('Annalee', 'Vice', 'avice9@psu.edu', '8 Monterey Lane');
insert into Sellers (firstName, lastName, email, location) values ('Marice', 'Brailey', 'mbraileya@plala.or.jp', '6004 Hooker Lane');
insert into Sellers (firstName, lastName, email, location) values ('Debora', 'Cabrales', 'dcabralesb@loc.gov', '998 Leroy Junction');
insert into Sellers (firstName, lastName, email, location) values ('Sarajane', 'Jacqueminet', 'sjacqueminetc@clickbank.net', '744 Village Green Lane');
insert into Sellers (firstName, lastName, email, location) values ('Paloma', 'Wisdish', 'pwisdishd@wunderground.com', '69 Forest Run Drive');
insert into Sellers (firstName, lastName, email, location) values ('Cinda', 'Riccardini', 'criccardinie@cisco.com', '81 Hanover Pass');
insert into Sellers (firstName, lastName, email, location) values ('Melvin', 'Bellord', 'mbellordf@wunderground.com', '5069 8th Alley');
insert into Sellers (firstName, lastName, email, location) values ('Royal', 'Lawn', 'rlawng@java.com', '31 Shasta Drive');
insert into Sellers (firstName, lastName, email, location) values ('Kin', 'Crump', 'kcrumph@instagram.com', '08 Gina Drive');
insert into Sellers (firstName, lastName, email, location) values ('Joshia', 'Garrattley', 'jgarrattleyi@goo.gl', '3 Melvin Alley');
insert into Sellers (firstName, lastName, email, location) values ('Walther', 'Fendlen', 'wfendlenj@surveymonkey.com', '1 Lakeland Street');
insert into Sellers (firstName, lastName, email, location) values ('Jewel', 'Evitts', 'jevittsk@home.pl', '2 Almo Court');
insert into Sellers (firstName, lastName, email, location) values ('Ripley', 'Boston', 'rbostonl@tinypic.com', '318 Ramsey Alley');
insert into Sellers (firstName, lastName, email, location) values ('Jean', 'Becker', 'jbeckerm@chron.com', '8 Havey Circle');
insert into Sellers (firstName, lastName, email, location) values ('Ardeen', 'Birdsey', 'abirdseyn@cam.ac.uk', '711 Dennis Trail');
insert into Sellers (firstName, lastName, email, location) values ('Denys', 'Dabbes', 'ddabbeso@google.es', '2 Springview Parkway');
insert into Sellers (firstName, lastName, email, location) values ('Kelly', 'Bendik', 'kbendikp@zimbio.com', '04875 Bunker Hill Way');
insert into Sellers (firstName, lastName, email, location) values ('Becka', 'Scorer', 'bscorerq@google.de', '77 Rigney Plaza');
insert into Sellers (firstName, lastName, email, location) values ('Alessandra', 'Faircliffe', 'afaircliffer@rediff.com', '234 Northfield Terrace');
insert into Sellers (firstName, lastName, email, location) values ('Thekla', 'O''Halloran', 'tohallorans@wufoo.com', '6092 Eastlawn Road');
insert into Sellers (firstName, lastName, email, location) values ('Saxe', 'Snazle', 'ssnazlet@lycos.com', '31 Dryden Trail');
insert into Sellers (firstName, lastName, email, location) values ('Staci', 'Hooks', 'shooksu@typepad.com', '820 Valley Edge Alley');
insert into Sellers (firstName, lastName, email, location) values ('Anatole', 'Horlock', 'ahorlockv@flickr.com', '59176 Amoth Circle');
insert into Sellers (firstName, lastName, email, location) values ('Ettore', 'Apthorpe', 'eapthorpew@mit.edu', '3 Del Mar Terrace');
insert into Sellers (firstName, lastName, email, location) values ('Dimitry', 'Sommerton', 'dsommertonx@rediff.com', '10 Westridge Trail');
insert into Sellers (firstName, lastName, email, location) values ('Roderigo', 'McCrystal', 'rmccrystaly@geocities.jp', '90046 Glendale Plaza');
insert into Sellers (firstName, lastName, email, location) values ('Delano', 'Conradie', 'dconradiez@godaddy.com', '5 Vidon Avenue');
insert into Sellers (firstName, lastName, email, location) values ('Vikky', 'Duerden', 'vduerden10@state.gov', '1033 Muir Plaza');
insert into Sellers (firstName, lastName, email, location) values ('Cory', 'Bucham', 'cbucham11@altervista.org', '13 Mockingbird Point');
insert into Sellers (firstName, lastName, email, location) values ('Godiva', 'Shephard', 'gshephard12@imgur.com', '593 Northview Alley');
insert into Sellers (firstName, lastName, email, location) values ('Giselle', 'Spadoni', 'gspadoni13@auda.org.au', '911 Johnson Lane');

# ---------------- Genre ----------------
INSERT INTO Genre
  (name)
VALUES
  ('Fantasy'),
  ('Mythology'),
  ('History'),
  ('Non-Fiction'),
  ('Science Fiction'),
  ('Realistic Fiction'),
  ('Action'),
  ('Adventure'),
  ('Comedy'),
  ('Crime'),
  ('Horror'),
  ('Romance'),
  ('Satire'),
  ('Science Fiction'),
  ('Speculative'),
  ('Thriller'),
  ('Western'),
  ('Philosophy'),
  ('Political'),
  ('Dystopian'),
  ('Utopian'),
  ('Biography'),
  ('Autobiography'),
  ('Noir'),
  ('Epic'),
  ('Mystery'),
  ('Space Opera'),
  ('Superhero'),
  ('Academic'),
  ('Cookbook'),
  ('Obituary'),
  ('Poetry');

# ---------------- Books ----------------
INSERT INTO Books
  (ISBN, year, writer_id, title, publisher_name, genre_id)
VALUES
  ('0195153448', 2002, 1, 'Classical Mythology', 'Oxford University Press', 2),
  ('0002005018', 2001, 2, 'Clara Callan', 'HarperFlamingo Canada', 1),
  ('0060973129', 1991, 3, 'Decision in Normandy', 'HarperPerennial', 3),
  ('0393045218', 1999, 4, 'The Mummies of Urumchi', 'W. W. Norton &amp; Company', 1),
  ('0399135782', 1999, 5, 'The Kitchen Gods Wife', 'Putnam Pub Group', 1),
  ('0425176428', 1999, 6, 'What If?: The Worlds Foremost Military Historians Imagine What Might Have Been', 'Berkley Publishing Group', 4),
  ('0671870432', 1999, 7, 'PLEADING GUILTY', 'Audioworks', 4),
  ('0679425608', 1999, 8, 'Under the Black Flag: The Romance and the Reality of Life Among the Pirates', 'Random House', 3),
  ('074322678X', 1999, 9, 'Where Youll Find Me: And Other Stories', 'Scribner', 6),
  ('0771074670', 1999, 10, 'Nights Below Station Street', 'Emblem Editions', 6),
  ('080652121X', 1999, 11, 'Hitlers Secret Bankers: The Myth of Swiss Neutrality During the Holocaust', 'Citadel Press', 3),
  ('0887841740', 1999, 12, 'The Middle Stories', 'House of Anansi Press', 6),
  ('8030833402', 2010, 13, 'Death Note 2: The Last Name', 'Dibbert, Sauer and Weimann', 7),
  ('2651606481', 2012, 14, 'Underworld: Evolution', 'Wolf, Waelchi and Ruecker', 8),
  ('8803418832', 2012, 15, 'Chandu the Magician', 'Kulas LLC', 9),
  ('0404270983', 2009, 16, 'Remains of the Day, The', 'Heaney and Sons', 10),
  ('3075757124', 2010, 17, 'Crime After Crime', 'Smitham, Fay and Yundt', 11),
  ('5736961675', 1997, 18, 'Case for Christ, The', 'Romaguera LLC', 12),
  ('7560067286', 1989, 19, 'Art & Copy', 'Langosh Group', 13),
  ('9169416157', 2011, 20, 'Offside', 'Toy, Kohler and Medhurst', 14),
  ('8245982908', 1986, 21, 'King Solomon''s Mines', 'Cummings, Kris and Stark', 15),
  ('1848872220', 2006, 22, 'My Boyfriends'' Dogs', 'Ortiz LLC', 16),
  ('3310064439', 2006, 23, 'Wonderful Crook, The (Pas si méchant que ça)', 'Terry Inc', 17),
  ('4414162338', 1991, 24, 'Tombstone', 'Price, Koepp and Feil', 18),
  ('4366833607', 1994, 25, 'New World (Shin-sae-gye)', 'Prohaska-Effertz', 19),
  ('9420499496', 2000, 26, 'Birds, the Bees and the Italians, The (Signore & signori)', 'Fritsch LLC', 20),
  ('0349289655', 2005, 27, 'Education of Mohammad Hussein, The', 'Gutkowski, Hills and Bergnaum', 21),
  ('0987031924', 2008, 28, 'Lipstick', 'Heidenreich, Erdman and Goyette', 22),
  ('9035785733', 2011, 29, 'Shinobi No Mono 4: Siege', 'Turcotte-Ferry', 23),
  ('6616246702', 1997, 30, 'Babylon A.D.', 'Veum and Sons', 24),
  ('2582935701', 1989, 31, 'Grumpier Old Men', 'Turcotte-Lueilwitz', 25),
  ('5415362252', 2002, 32, 'Harvest/La Cosecha, The', 'Macejkovic and Sons', 26),
  ('3559494173', 2000, 33, 'Since You Went Away', 'Aufderhar LLC', 27),
  ('7510761654', 2002, 34, 'Steel Dawn', 'Upton-Quitzon', 28),
  ('4259066355', 1997, 35, 'Watermarks', 'Kiehn Inc', 29),
  ('3971475766', 2003, 36, 'Juan of the Dead (Juan de los Muertos)', 'Waters, Tillman and McDermott', 30),
  ('9483864357', 2006, 37, 'Deadly Circuit (Mortelle randonnée)', 'Hansen-Cassin', 31),
  ('3886221838', 1966, 38, 'Lake House, The', 'Konopelski, McCullough and Konopelski', 32),
  ('0539480579', 2013, 39, 'Father''s Little Dividend', 'Walker, Kunze and Hoeger', 1),
  ('7282766280', 1988, 40, 'Christopher Strong', 'Moen, Adams and Kozey', 2),
  ('4749144249', 2004, 41, 'The Raid 2: Berandal', 'Goldner and Sons', 3),
  ('1542961988', 2008, 42, 'Transporter, The', 'Hills, Gottlieb and Leuschke', 4),
  ('4919322257', 2008, 43, 'High School High', 'Zulauf and Sons', 5),
  ('7624503736', 1992, 44, 'Frogs', 'Gleason, Predovic and Bartoletti', 6),
  ('0980424405', 2011, 45, 'Jesus Christ Superstar', 'Turcotte-Hansen', 7),
  ('5083416954', 2010, 46, 'Heading South (Vers le sud)', 'Torp, Douglas and Breitenberg', 8),
  ('1270157493', 1954, 47, 'Battlestar Galactica', 'Rosenbaum, Monahan and Carter', 9),
  ('5345795622', 2001, 48, 'November Man, The', 'Gutkowski LLC', 10),
  ('4263866611', 2005, 49, 'Diary of a Cannibal', 'Auer Inc', 11),
  ('1552041778', 1999, 50, 'Jane Doe', 'Mira Books', 3);
  
INSERT INTO Books
  (ISBN, year, writer_id, title, publisher_name, genre_id, visible)
VALUES
  ('0000000001', 2000, 1, 'test1', 'pub', 1, false),
  ('0000000002', 2000, 1, 'test2', 'pub', 1, false),
  ('0000000003', 2000, 1, 'test2', 'pub', 1, false);

# ---------------- Readers ----------------
INSERT INTO Readers
  (email, firstName, lastName, age, location)
VALUES
  ('astennes0@sohu.com', 'Angie', 'Stennes', 56, 'Texas'),
  ('csutherden1@i2i.jp', 'Cherish', 'Sutherden', 39, 'Pennsylvania'),
  ('hourtic2@odnoklassniki.ru', 'Hertha', 'Ourtic', 28, 'Maryland'),
  ('eskelton3@omniture.com', 'Etta', 'Skelton', 47, 'Texas'),
  ('betoile4@home.pl', 'Barnabe', 'Etoile', 42, 'Arizona'),
  ('abahia5@goodreads.com', 'Aloysius', 'Bahia', 28, 'New York'),
  ('geustes6@twitter.com', 'Gail', 'Eustes', 20, 'Texas'),
  ('mboles7@phoca.cz', 'Merrick', 'Boles', 52, 'South Carolina'),
  ('mdanilowicz8@people.com.cn', 'Milly', 'Danilowicz', 41, 'California'),
  ('dostrich9@t-online.de', 'Dillie', 'Ostrich', 49, 'District of Columbia'),
  ('rdavidavidovicsa@examiner.com', 'Risa', 'Davidavidovics', 56, 'California'),
  ('glukeschb@stanford.edu', 'Greta', 'Lukesch', 29, 'Wyoming'),
  ('sradbournc@360.cn', 'Scarlet', 'Radbourn', 42, 'California'),
  ('ybleslid@cam.ac.uk', 'Yoshiko', 'Blesli', 44, 'Texas'),
  ('hwyndhame@friendfeed.com', 'Hilly', 'Wyndham', 44, 'Nevada'),
  ('vbleesingf@ifeng.com', 'Vonni', 'Bleesing', 49, 'California'),
  ('eseabrockeg@360.cn', 'Eugenio', 'Seabrocke', 55, 'South Dakota'),
  ('ahaylerh@mlb.com', 'Abel', 'Hayler', 34, 'Florida'),
  ('mrubenovi@accuweather.com', 'Maurine', 'Rubenov', 29, 'California'),
  ('joseltonj@ocn.ne.jp', 'Justin', 'Oselton', 26, 'New York'),
  ('mphilbrookk@salon.com', 'Meggi', 'Philbrook', 55, 'Alabama'),
  ('tapdelll@t-online.de', 'Trisha', 'Apdell', 51, 'Texas'),
  ('adoddridgem@wunderground.com', 'Antonino', 'Doddridge', 39, 'Oregon'),
  ('nkeemarn@shinystat.com', 'Noelle', 'Keemar', 28, 'District of Columbia'),
  ('dbruneto@infoseek.co.jp', 'Dorie', 'Brunet', 28, 'Georgia'),
  ('broadsp@ted.com', 'Babette', 'Roads', 48, 'District of Columbia'),
  ('jministerq@creativecommons.org', 'Jim', 'Minister', 37, 'South Carolina'),
  ('salaboner@telegraph.co.uk', 'Smith', 'Alabone', 57, 'North Carolina'),
  ('hcarbrys@bing.com', 'Hurlee', 'Carbry', 25, 'Florida'),
  ('fkiernant@geocities.com', 'Felicdad', 'Kiernan', 33, 'New York'),
  ('dgoedeu@latimes.com', 'Dody', 'Goede', 57, 'Washington'),
  ('scassyv@woothemes.com', 'Suzie', 'Cassy', 21, 'Oregon'),
  ('lflaunew@cafepress.com', 'Liane', 'Flaune', 50, 'Florida'),
  ('jwicklenx@weebly.com', 'Jermain', 'Wicklen', 38, 'Florida'),
  ('amowburyy@sciencedirect.com', 'Adah', 'Mowbury', 54, 'Texas'),
  ('rchellenhamz@youtube.com', 'Rolfe', 'Chellenham', 38, 'California'),
  ('gmcdunlevy10@walmart.com', 'Gaynor', 'McDunlevy', 19, 'California'),
  ('rmillam11@sciencedirect.com', 'Rafaelita', 'Millam', 26, 'Hawaii'),
  ('mheadon12@tiny.cc', 'Marylin', 'Headon', 18, 'Florida'),
  ('cmacphee13@booking.com', 'Cathyleen', 'MacPhee', 24, 'New York'),
  ('medleston14@indiatimes.com', 'Micki', 'Edleston', 50, 'Texas'),
  ('rpucknell15@google.nl', 'Rana', 'Pucknell', 59, 'Kentucky'),
  ('cmawd16@netscape.com', 'Codi', 'Mawd', 22, 'Arizona'),
  ('mblaker17@is.gd', 'Marnie', 'Blaker', 45, 'Ohio'),
  ('kgareisr18@gov.uk', 'Krysta', 'Gareisr', 57, 'Washington'),
  ('fwalmsley19@qq.com', 'Florentia', 'Walmsley', 20, 'Connecticut'),
  ('jcaudrelier1a@indiegogo.com', 'Juli', 'Caudrelier', 36, 'Pennsylvania'),
  ('gminchin1b@xing.com', 'Gardener', 'Minchin', 56, 'Texas'),
  ('arickwood1c@elegantthemes.com', 'Allix', 'Rickwood', 39, 'Minnesota'),
  ('vjoel1d@ow.ly', 'Virgil', 'Joel', 48, 'Ohio');

# ---------------- Ratings ----------------
insert into Ratings (book_id, reader_id, score, comments) values ('0195153448', 18, 2, 'whatever');
insert into Ratings (book_id, reader_id, score, comments) values ('0002005018', 8, 4, 'i liked it');
insert into Ratings (book_id, reader_id, score, comments) values ('0060973129', 48, 0, 'terrible');
insert into Ratings (book_id, reader_id, score, comments) values ('0393045218', 20, 2, 'whatever');
insert into Ratings (book_id, reader_id, score, comments) values ('0399135782', 50, 4, 'very good');
insert into Ratings (book_id, reader_id, score, comments) values ('0425176428', 38, 4, 'i liked it');
insert into Ratings (book_id, reader_id, score, comments) values ('0671870432', 26, 1, 'terrible');
insert into Ratings (book_id, reader_id, score, comments) values ('0679425608', 46, 0, 'terrible');
insert into Ratings (book_id, reader_id, score, comments) values ('074322678X', 30, 1, 'not good');
insert into Ratings (book_id, reader_id, score, comments) values ('0771074670', 44, 3, 'whatever');
insert into Ratings (book_id, reader_id, score, comments) values ('080652121X', 11, 5, 'awesome');
insert into Ratings (book_id, reader_id, score, comments) values ('0887841740', 15, 0, 'terrible');
insert into Ratings (book_id, reader_id, score, comments) values ('8030833402', 31, 0, 'terrible');
insert into Ratings (book_id, reader_id, score, comments) values ('2651606481', 49, 0, 'terrible');
insert into Ratings (book_id, reader_id, score, comments) values ('8803418832', 38, 1, 'terrible');
insert into Ratings (book_id, reader_id, score, comments) values ('0404270983', 41, 1, 'terrible');
insert into Ratings (book_id, reader_id, score, comments) values ('3075757124', 45, 3, 'okay');
insert into Ratings (book_id, reader_id, score, comments) values ('5736961675', 3, 5, 'loved it');
insert into Ratings (book_id, reader_id, score, comments) values ('7560067286', 35, 2, 'whatever');
insert into Ratings (book_id, reader_id, score, comments) values ('9169416157', 35, 5, 'awesome');
insert into Ratings (book_id, reader_id, score, comments) values ('8245982908', 44, 2, 'meh at best');
insert into Ratings (book_id, reader_id, score, comments) values ('1848872220', 3, 5, 'loved it');
insert into Ratings (book_id, reader_id, score, comments) values ('3310064439', 47, 0, 'terrible');
insert into Ratings (book_id, reader_id, score, comments) values ('4414162338', 39, 2, 'whatever');
insert into Ratings (book_id, reader_id, score, comments) values ('4366833607', 15, 1, 'not good');
insert into Ratings (book_id, reader_id, score, comments) values ('9420499496', 20, 4, 'very good');
insert into Ratings (book_id, reader_id, score, comments) values ('0349289655', 22, 2, 'whatever');
insert into Ratings (book_id, reader_id, score, comments) values ('0987031924', 9, 1, 'terrible');
insert into Ratings (book_id, reader_id, score, comments) values ('9035785733', 37, 2, 'meh at best');
insert into Ratings (book_id, reader_id, score, comments) values ('6616246702', 6, 4, 'pretty good');
insert into Ratings (book_id, reader_id, score, comments) values ('2582935701', 27, 3, 'whatever');
insert into Ratings (book_id, reader_id, score, comments) values ('5415362252', 16, 3, 'whatever');
insert into Ratings (book_id, reader_id, score, comments) values ('3559494173', 25, 1, 'not good');
insert into Ratings (book_id, reader_id, score, comments) values ('7510761654', 16, 1, 'not good');
insert into Ratings (book_id, reader_id, score, comments) values ('4259066355', 7, 0, 'terrible');
insert into Ratings (book_id, reader_id, score, comments) values ('3971475766', 25, 2, 'whatever');
insert into Ratings (book_id, reader_id, score, comments) values ('9483864357', 19, 2, 'whatever');
insert into Ratings (book_id, reader_id, score, comments) values ('3886221838', 8, 2, 'whatever');
insert into Ratings (book_id, reader_id, score, comments) values ('0539480579', 25, 2, 'whatever');
insert into Ratings (book_id, reader_id, score, comments) values ('7282766280', 43, 0, 'terrible');
insert into Ratings (book_id, reader_id, score, comments) values ('4749144249', 47, 0, 'terrible');
insert into Ratings (book_id, reader_id, score, comments) values ('1542961988', 10, 4, 'very good');
insert into Ratings (book_id, reader_id, score, comments) values ('4919322257', 48, 5, 'awesome');
insert into Ratings (book_id, reader_id, score, comments) values ('7624503736', 16, 1, 'terrible');
insert into Ratings (book_id, reader_id, score, comments) values ('0980424405', 30, 4, 'very good');
insert into Ratings (book_id, reader_id, score, comments) values ('5083416954', 33, 3, 'whatever');
insert into Ratings (book_id, reader_id, score, comments) values ('1270157493', 21, 2, 'whatever');
insert into Ratings (book_id, reader_id, score, comments) values ('5345795622', 35, 0, 'terrible');
insert into Ratings (book_id, reader_id, score, comments) values ('4263866611', 32, 4, 'i liked it');
insert into Ratings (book_id, reader_id, score, comments) values ('1552041778', 26, 1, 'terrible');
insert into Ratings (book_id, reader_id, score, comments) values ('0195153448', 6, 0, 'terrible');
insert into Ratings (book_id, reader_id, score, comments) values ('0002005018', 10, 0, 'terrible');
insert into Ratings (book_id, reader_id, score, comments) values ('0060973129', 35, 1, 'not good');
insert into Ratings (book_id, reader_id, score, comments) values ('0393045218', 14, 4, 'pretty good');
insert into Ratings (book_id, reader_id, score, comments) values ('0399135782', 35, 2, 'whatever');
insert into Ratings (book_id, reader_id, score, comments) values ('0425176428', 12, 5, 'loved it');
insert into Ratings (book_id, reader_id, score, comments) values ('0671870432', 4, 2, 'whatever');
insert into Ratings (book_id, reader_id, score, comments) values ('0679425608', 39, 1, 'not good');
insert into Ratings (book_id, reader_id, score, comments) values ('074322678X', 9, 1, 'terrible');
insert into Ratings (book_id, reader_id, score, comments) values ('0771074670', 16, 0, 'terrible');
insert into Ratings (book_id, reader_id, score, comments) values ('080652121X', 27, 4, 'i liked it');
insert into Ratings (book_id, reader_id, score, comments) values ('0887841740', 31, 5, 'awesome');
insert into Ratings (book_id, reader_id, score, comments) values ('8030833402', 42, 5, 'loved it');
insert into Ratings (book_id, reader_id, score, comments) values ('2651606481', 15, 5, 'loved it');
insert into Ratings (book_id, reader_id, score, comments) values ('8803418832', 37, 0, 'terrible');
insert into Ratings (book_id, reader_id, score, comments) values ('0404270983', 8, 4, 'pretty good');
insert into Ratings (book_id, reader_id, score, comments) values ('3075757124', 36, 4, 'pretty good');
insert into Ratings (book_id, reader_id, score, comments) values ('5736961675', 37, 2, 'whatever');
insert into Ratings (book_id, reader_id, score, comments) values ('7560067286', 15, 4, 'very good');
insert into Ratings (book_id, reader_id, score, comments) values ('9169416157', 39, 3, 'whatever');
insert into Ratings (book_id, reader_id, score, comments) values ('8245982908', 35, 4, 'pretty good');
insert into Ratings (book_id, reader_id, score, comments) values ('1848872220', 26, 4, 'very good');
insert into Ratings (book_id, reader_id, score, comments) values ('3310064439', 35, 0, 'terrible');
insert into Ratings (book_id, reader_id, score, comments) values ('4414162338', 14, 5, 'awesome');
insert into Ratings (book_id, reader_id, score, comments) values ('4366833607', 19, 5, 'awesome');
insert into Ratings (book_id, reader_id, score, comments) values ('9420499496', 12, 2, 'whatever');
insert into Ratings (book_id, reader_id, score, comments) values ('0349289655', 46, 1, 'terrible');
insert into Ratings (book_id, reader_id, score, comments) values ('0987031924', 50, 3, 'whatever');
insert into Ratings (book_id, reader_id, score, comments) values ('9035785733', 35, 3, 'okay');
insert into Ratings (book_id, reader_id, score, comments) values ('6616246702', 24, 1, 'not good');
insert into Ratings (book_id, reader_id, score, comments) values ('2582935701', 40, 4, 'i liked it');
insert into Ratings (book_id, reader_id, score, comments) values ('5415362252', 31, 5, 'awesome');
insert into Ratings (book_id, reader_id, score, comments) values ('3559494173', 43, 5, 'awesome');
insert into Ratings (book_id, reader_id, score, comments) values ('7510761654', 48, 2, 'whatever');
insert into Ratings (book_id, reader_id, score, comments) values ('4259066355', 41, 5, 'awesome');
insert into Ratings (book_id, reader_id, score, comments) values ('3971475766', 46, 1, 'not good');
insert into Ratings (book_id, reader_id, score, comments) values ('9483864357', 5, 0, 'terrible');
insert into Ratings (book_id, reader_id, score, comments) values ('3886221838', 30, 1, 'not good');
insert into Ratings (book_id, reader_id, score, comments) values ('0539480579', 6, 4, 'pretty good');
insert into Ratings (book_id, reader_id, score, comments) values ('7282766280', 31, 3, 'okay');
insert into Ratings (book_id, reader_id, score, comments) values ('4749144249', 1, 3, 'whatever');
insert into Ratings (book_id, reader_id, score, comments) values ('1542961988', 13, 5, 'awesome');
insert into Ratings (book_id, reader_id, score, comments) values ('4919322257', 41, 2, 'whatever');
insert into Ratings (book_id, reader_id, score, comments) values ('7624503736', 26, 4, 'very good');
insert into Ratings (book_id, reader_id, score, comments) values ('0980424405', 5, 2, 'whatever');
insert into Ratings (book_id, reader_id, score, comments) values ('5083416954', 43, 2, 'whatever');
insert into Ratings (book_id, reader_id, score, comments) values ('1270157493', 17, 2, 'whatever');
insert into Ratings (book_id, reader_id, score, comments) values ('5345795622', 6, 5, 'loved it');
insert into Ratings (book_id, reader_id, score, comments) values ('4263866611', 12, 0, 'terrible');
insert into Ratings (book_id, reader_id, score, comments) values ('1552041778', 38, 4, 'very good');
insert into Ratings (book_id, reader_id, score, comments) values ('0195153448', 13, 2, 'whatever');
insert into Ratings (book_id, reader_id, score, comments) values ('0002005018', 20, 5, 'awesome');
insert into Ratings (book_id, reader_id, score, comments) values ('0060973129', 47, 2, 'meh at best');
insert into Ratings (book_id, reader_id, score, comments) values ('0393045218', 16, 3, 'okay');
insert into Ratings (book_id, reader_id, score, comments) values ('0399135782', 33, 3, 'whatever');
insert into Ratings (book_id, reader_id, score, comments) values ('0425176428', 19, 3, 'okay');
insert into Ratings (book_id, reader_id, score, comments) values ('0671870432', 12, 1, 'terrible');
insert into Ratings (book_id, reader_id, score, comments) values ('0679425608', 1, 5, 'loved it');
insert into Ratings (book_id, reader_id, score, comments) values ('074322678X', 5, 0, 'terrible');
insert into Ratings (book_id, reader_id, score, comments) values ('0771074670', 36, 2, 'whatever');
insert into Ratings (book_id, reader_id, score, comments) values ('080652121X', 2, 3, 'whatever');
insert into Ratings (book_id, reader_id, score, comments) values ('0887841740', 50, 5, 'loved it');
insert into Ratings (book_id, reader_id, score, comments) values ('8030833402', 6, 0, 'terrible');
insert into Ratings (book_id, reader_id, score, comments) values ('2651606481', 25, 4, 'pretty good');
insert into Ratings (book_id, reader_id, score, comments) values ('8803418832', 49, 0, 'terrible');
insert into Ratings (book_id, reader_id, score, comments) values ('0404270983', 29, 0, 'terrible');
insert into Ratings (book_id, reader_id, score, comments) values ('3075757124', 14, 3, 'okay');
insert into Ratings (book_id, reader_id, score, comments) values ('5736961675', 9, 1, 'terrible');
insert into Ratings (book_id, reader_id, score, comments) values ('7560067286', 3, 5, 'loved it');
insert into Ratings (book_id, reader_id, score, comments) values ('9169416157', 2, 0, 'terrible');
insert into Ratings (book_id, reader_id, score, comments) values ('8245982908', 50, 0, 'terrible');
insert into Ratings (book_id, reader_id, score, comments) values ('1848872220', 41, 3, 'okay');
insert into Ratings (book_id, reader_id, score, comments) values ('3310064439', 14, 3, 'okay');
insert into Ratings (book_id, reader_id, score, comments) values ('4414162338', 6, 2, 'meh at best');
insert into Ratings (book_id, reader_id, score, comments) values ('4366833607', 40, 4, 'i liked it');
insert into Ratings (book_id, reader_id, score, comments) values ('9420499496', 40, 1, 'terrible');
insert into Ratings (book_id, reader_id, score, comments) values ('0349289655', 37, 5, 'awesome');
insert into Ratings (book_id, reader_id, score, comments) values ('0987031924', 21, 4, 'very good');
insert into Ratings (book_id, reader_id, score, comments) values ('9035785733', 16, 1, 'not good');
insert into Ratings (book_id, reader_id, score, comments) values ('6616246702', 16, 5, 'awesome');
insert into Ratings (book_id, reader_id, score, comments) values ('2582935701', 9, 0, 'terrible');
insert into Ratings (book_id, reader_id, score, comments) values ('5415362252', 8, 0, 'terrible');
insert into Ratings (book_id, reader_id, score, comments) values ('3559494173', 36, 5, 'awesome');
insert into Ratings (book_id, reader_id, score, comments) values ('7510761654', 42, 5, 'awesome');
insert into Ratings (book_id, reader_id, score, comments) values ('4259066355', 50, 4, 'very good');
insert into Ratings (book_id, reader_id, score, comments) values ('3971475766', 2, 3, 'whatever');
insert into Ratings (book_id, reader_id, score, comments) values ('9483864357', 48, 0, 'terrible');
insert into Ratings (book_id, reader_id, score, comments) values ('3886221838', 44, 0, 'terrible');
insert into Ratings (book_id, reader_id, score, comments) values ('0539480579', 17, 0, 'terrible');
insert into Ratings (book_id, reader_id, score, comments) values ('7282766280', 5, 3, 'okay');
insert into Ratings (book_id, reader_id, score, comments) values ('4749144249', 4, 1, 'terrible');
insert into Ratings (book_id, reader_id, score, comments) values ('1542961988', 17, 1, 'terrible');
insert into Ratings (book_id, reader_id, score, comments) values ('4919322257', 47, 5, 'awesome');
insert into Ratings (book_id, reader_id, score, comments) values ('7624503736', 32, 4, 'i liked it');
insert into Ratings (book_id, reader_id, score, comments) values ('0980424405', 29, 2, 'meh at best');
insert into Ratings (book_id, reader_id, score, comments) values ('5083416954', 13, 3, 'okay');
insert into Ratings (book_id, reader_id, score, comments) values ('1270157493', 19, 0, 'terrible');
insert into Ratings (book_id, reader_id, score, comments) values ('5345795622', 32, 2, 'meh at best');
insert into Ratings (book_id, reader_id, score, comments) values ('4263866611', 6, 0, 'terrible');
insert into Ratings (book_id, reader_id, score, comments) values ('1552041778', 25, 5, 'awesome');
insert into Ratings (book_id, reader_id, score, comments) values ('0195153448', 37, 2, 'whatever');
insert into Ratings (book_id, reader_id, score, comments) values ('0002005018', 49, 5, 'loved it');
insert into Ratings (book_id, reader_id, score, comments) values ('0060973129', 32, 0, 'terrible');
insert into Ratings (book_id, reader_id, score, comments) values ('0393045218', 42, 3, 'whatever');
insert into Ratings (book_id, reader_id, score, comments) values ('0399135782', 42, 2, 'meh at best');
insert into Ratings (book_id, reader_id, score, comments) values ('0425176428', 27, 2, 'meh at best');
insert into Ratings (book_id, reader_id, score, comments) values ('0671870432', 48, 2, 'whatever');
insert into Ratings (book_id, reader_id, score, comments) values ('0679425608', 26, 4, 'very good');
insert into Ratings (book_id, reader_id, score, comments) values ('074322678X', 15, 5, 'awesome');
insert into Ratings (book_id, reader_id, score, comments) values ('0771074670', 3, 3, 'okay');
insert into Ratings (book_id, reader_id, score, comments) values ('080652121X', 31, 2, 'whatever');
insert into Ratings (book_id, reader_id, score, comments) values ('0887841740', 33, 2, 'whatever');
insert into Ratings (book_id, reader_id, score, comments) values ('8030833402', 28, 0, 'terrible');
insert into Ratings (book_id, reader_id, score, comments) values ('2651606481', 1, 2, 'whatever');
insert into Ratings (book_id, reader_id, score, comments) values ('8803418832', 46, 2, 'whatever');
insert into Ratings (book_id, reader_id, score, comments) values ('0404270983', 13, 1, 'not good');
insert into Ratings (book_id, reader_id, score, comments) values ('3075757124', 49, 2, 'meh at best');
insert into Ratings (book_id, reader_id, score, comments) values ('5736961675', 45, 0, 'terrible');
insert into Ratings (book_id, reader_id, score, comments) values ('7560067286', 44, 0, 'terrible');
insert into Ratings (book_id, reader_id, score, comments) values ('9169416157', 41, 0, 'terrible');
insert into Ratings (book_id, reader_id, score, comments) values ('8245982908', 45, 0, 'terrible');
insert into Ratings (book_id, reader_id, score, comments) values ('1848872220', 34, 4, 'very good');
insert into Ratings (book_id, reader_id, score, comments) values ('3310064439', 34, 0, 'terrible');
insert into Ratings (book_id, reader_id, score, comments) values ('4414162338', 16, 3, 'okay');
insert into Ratings (book_id, reader_id, score, comments) values ('4366833607', 50, 3, 'okay');
insert into Ratings (book_id, reader_id, score, comments) values ('9420499496', 10, 4, 'very good');
insert into Ratings (book_id, reader_id, score, comments) values ('0349289655', 3, 5, 'awesome');
insert into Ratings (book_id, reader_id, score, comments) values ('0987031924', 7, 4, 'i liked it');
insert into Ratings (book_id, reader_id, score, comments) values ('9035785733', 31, 1, 'terrible');
insert into Ratings (book_id, reader_id, score, comments) values ('6616246702', 37, 3, 'whatever');
insert into Ratings (book_id, reader_id, score, comments) values ('2582935701', 24, 1, 'terrible');
insert into Ratings (book_id, reader_id, score, comments) values ('5415362252', 23, 3, 'okay');
insert into Ratings (book_id, reader_id, score, comments) values ('3559494173', 35, 3, 'okay');
insert into Ratings (book_id, reader_id, score, comments) values ('7510761654', 2, 0, 'terrible');
insert into Ratings (book_id, reader_id, score, comments) values ('4259066355', 42, 3, 'whatever');
insert into Ratings (book_id, reader_id, score, comments) values ('3971475766', 19, 1, 'not good');
insert into Ratings (book_id, reader_id, score, comments) values ('9483864357', 36, 1, 'terrible');
insert into Ratings (book_id, reader_id, score, comments) values ('3886221838', 1, 3, 'okay');
insert into Ratings (book_id, reader_id, score, comments) values ('0539480579', 23, 4, 'pretty good');
insert into Ratings (book_id, reader_id, score, comments) values ('7282766280', 35, 4, 'pretty good');
insert into Ratings (book_id, reader_id, score, comments) values ('4749144249', 19, 4, 'i liked it');
insert into Ratings (book_id, reader_id, score, comments) values ('1542961988', 35, 4, 'pretty good');
insert into Ratings (book_id, reader_id, score, comments) values ('4919322257', 38, 5, 'awesome');
insert into Ratings (book_id, reader_id, score, comments) values ('7624503736', 46, 5, 'awesome');
insert into Ratings (book_id, reader_id, score, comments) values ('0980424405', 36, 3, 'okay');
insert into Ratings (book_id, reader_id, score, comments) values ('5083416954', 32, 2, 'whatever');
insert into Ratings (book_id, reader_id, score, comments) values ('1270157493', 37, 3, 'whatever');
insert into Ratings (book_id, reader_id, score, comments) values ('5345795622', 44, 1, 'not good');
insert into Ratings (book_id, reader_id, score, comments) values ('4263866611', 25, 0, 'terrible');
insert into Ratings (book_id, reader_id, score, comments) values ('1552041778', 21, 4, 'very good');

# ---------------- Books_Bought ----------------
insert into Books_Bought (book_id, reader_id, date_bought) values ('1542961988', 2, '2022-04-27');
insert into Books_Bought (book_id, reader_id, date_bought) values ('080652121X', 31, '2022-03-22');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0404270983', 48, '2022-07-22');
insert into Books_Bought (book_id, reader_id, date_bought) values ('4263866611', 14, '2021-12-11');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0393045218', 12, '2022-04-16');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0393045218', 2, '2022-01-03');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0060973129', 45, '2022-09-02');
insert into Books_Bought (book_id, reader_id, date_bought) values ('5415362252', 5, '2021-12-19');
insert into Books_Bought (book_id, reader_id, date_bought) values ('3886221838', 5, '2022-07-21');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0539480579', 36, '2022-06-05');
insert into Books_Bought (book_id, reader_id, date_bought) values ('6616246702', 26, '2022-01-28');
insert into Books_Bought (book_id, reader_id, date_bought) values ('9420499496', 28, '2022-06-18');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0393045218', 32, '2021-12-06');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0679425608', 3, '2022-05-23');
insert into Books_Bought (book_id, reader_id, date_bought) values ('080652121X', 14, '2022-10-27');
insert into Books_Bought (book_id, reader_id, date_bought) values ('4749144249', 43, '2022-06-15');
insert into Books_Bought (book_id, reader_id, date_bought) values ('3971475766', 29, '2022-03-05');
insert into Books_Bought (book_id, reader_id, date_bought) values ('074322678X', 3, '2022-10-15');
insert into Books_Bought (book_id, reader_id, date_bought) values ('080652121X', 26, '2022-11-23');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0404270983', 15, '2022-02-01');
insert into Books_Bought (book_id, reader_id, date_bought) values ('2582935701', 48, '2022-06-14');
insert into Books_Bought (book_id, reader_id, date_bought) values ('3886221838', 39, '2022-07-10');
insert into Books_Bought (book_id, reader_id, date_bought) values ('4749144249', 44, '2022-06-03');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0987031924', 25, '2022-08-17');
insert into Books_Bought (book_id, reader_id, date_bought) values ('1552041778', 34, '2022-01-16');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0987031924', 24, '2022-08-15');
insert into Books_Bought (book_id, reader_id, date_bought) values ('4414162338', 33, '2022-05-03');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0060973129', 33, '2022-07-29');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0349289655', 29, '2022-09-16');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0671870432', 40, '2022-03-07');
insert into Books_Bought (book_id, reader_id, date_bought) values ('4366833607', 40, '2022-06-03');
insert into Books_Bought (book_id, reader_id, date_bought) values ('9169416157', 8, '2022-03-27');
insert into Books_Bought (book_id, reader_id, date_bought) values ('4919322257', 5, '2022-06-16');
insert into Books_Bought (book_id, reader_id, date_bought) values ('9035785733', 27, '2022-09-11');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0002005018', 10, '2022-04-07');
insert into Books_Bought (book_id, reader_id, date_bought) values ('9420499496', 8, '2022-09-29');
insert into Books_Bought (book_id, reader_id, date_bought) values ('7560067286', 22, '2022-05-29');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0393045218', 28, '2022-12-01');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0399135782', 12, '2022-04-09');
insert into Books_Bought (book_id, reader_id, date_bought) values ('5415362252', 33, '2022-01-31');
insert into Books_Bought (book_id, reader_id, date_bought) values ('8803418832', 30, '2022-02-23');
insert into Books_Bought (book_id, reader_id, date_bought) values ('4414162338', 30, '2022-06-15');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0002005018', 27, '2022-11-15');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0671870432', 24, '2022-07-17');
insert into Books_Bought (book_id, reader_id, date_bought) values ('1848872220', 15, '2022-03-19');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0399135782', 27, '2022-08-08');
insert into Books_Bought (book_id, reader_id, date_bought) values ('9483864357', 3, '2022-03-22');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0399135782', 42, '2022-10-04');
insert into Books_Bought (book_id, reader_id, date_bought) values ('8245982908', 20, '2022-07-09');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0771074670', 3, '2022-02-14');
insert into Books_Bought (book_id, reader_id, date_bought) values ('5345795622', 1, '2022-07-22');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0425176428', 21, '2022-05-15');
insert into Books_Bought (book_id, reader_id, date_bought) values ('4414162338', 38, '2022-09-19');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0399135782', 14, '2022-05-11');
insert into Books_Bought (book_id, reader_id, date_bought) values ('5736961675', 13, '2022-02-20');
insert into Books_Bought (book_id, reader_id, date_bought) values ('8245982908', 5, '2022-09-24');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0887841740', 38, '2022-03-18');
insert into Books_Bought (book_id, reader_id, date_bought) values ('1848872220', 2, '2022-08-30');
insert into Books_Bought (book_id, reader_id, date_bought) values ('5736961675', 47, '2022-01-01');
insert into Books_Bought (book_id, reader_id, date_bought) values ('4414162338', 26, '2022-10-23');
insert into Books_Bought (book_id, reader_id, date_bought) values ('4414162338', 15, '2022-04-30');
insert into Books_Bought (book_id, reader_id, date_bought) values ('9035785733', 10, '2022-01-14');
insert into Books_Bought (book_id, reader_id, date_bought) values ('9169416157', 26, '2022-04-24');
insert into Books_Bought (book_id, reader_id, date_bought) values ('8803418832', 25, '2022-07-17');
insert into Books_Bought (book_id, reader_id, date_bought) values ('3075757124', 29, '2022-04-23');
insert into Books_Bought (book_id, reader_id, date_bought) values ('8245982908', 26, '2022-06-04');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0887841740', 14, '2022-02-11');
insert into Books_Bought (book_id, reader_id, date_bought) values ('074322678X', 17, '2022-10-08');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0060973129', 24, '2022-02-03');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0195153448', 42, '2022-10-08');
insert into Books_Bought (book_id, reader_id, date_bought) values ('4263866611', 6, '2022-02-25');
insert into Books_Bought (book_id, reader_id, date_bought) values ('1270157493', 38, '2022-10-25');
insert into Books_Bought (book_id, reader_id, date_bought) values ('1542961988', 46, '2022-05-20');
insert into Books_Bought (book_id, reader_id, date_bought) values ('9035785733', 1, '2022-11-05');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0539480579', 32, '2022-11-12');
insert into Books_Bought (book_id, reader_id, date_bought) values ('6616246702', 5, '2022-06-11');
insert into Books_Bought (book_id, reader_id, date_bought) values ('3971475766', 41, '2022-08-09');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0671870432', 48, '2022-03-31');
insert into Books_Bought (book_id, reader_id, date_bought) values ('4263866611', 15, '2022-05-14');
insert into Books_Bought (book_id, reader_id, date_bought) values ('7624503736', 44, '2022-08-24');
insert into Books_Bought (book_id, reader_id, date_bought) values ('1270157493', 28, '2022-11-22');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0980424405', 15, '2022-06-06');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0671870432', 2, '2021-12-17');
insert into Books_Bought (book_id, reader_id, date_bought) values ('3971475766', 16, '2021-12-09');
insert into Books_Bought (book_id, reader_id, date_bought) values ('8803418832', 8, '2022-10-14');
insert into Books_Bought (book_id, reader_id, date_bought) values ('1270157493', 49, '2022-04-25');
insert into Books_Bought (book_id, reader_id, date_bought) values ('9035785733', 33, '2022-10-15');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0679425608', 14, '2022-03-11');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0539480579', 18, '2022-09-26');
insert into Books_Bought (book_id, reader_id, date_bought) values ('8245982908', 35, '2022-08-17');
insert into Books_Bought (book_id, reader_id, date_bought) values ('074322678X', 14, '2022-07-11');
insert into Books_Bought (book_id, reader_id, date_bought) values ('9169416157', 32, '2021-12-28');
insert into Books_Bought (book_id, reader_id, date_bought) values ('1270157493', 27, '2022-10-17');
insert into Books_Bought (book_id, reader_id, date_bought) values ('4366833607', 36, '2021-12-19');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0404270983', 4, '2022-05-17');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0887841740', 13, '2022-05-19');
insert into Books_Bought (book_id, reader_id, date_bought) values ('2651606481', 28, '2022-03-21');
insert into Books_Bought (book_id, reader_id, date_bought) values ('3971475766', 14, '2021-12-22');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0425176428', 50, '2022-01-04');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0887841740', 34, '2022-07-28');
insert into Books_Bought (book_id, reader_id, date_bought) values ('4919322257', 49, '2022-04-04');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0679425608', 34, '2022-07-11');
insert into Books_Bought (book_id, reader_id, date_bought) values ('2582935701', 31, '2021-12-16');
insert into Books_Bought (book_id, reader_id, date_bought) values ('1270157493', 4, '2022-02-11');
insert into Books_Bought (book_id, reader_id, date_bought) values ('1552041778', 18, '2022-03-01');
insert into Books_Bought (book_id, reader_id, date_bought) values ('4366833607', 21, '2022-09-03');
insert into Books_Bought (book_id, reader_id, date_bought) values ('4414162338', 23, '2022-07-04');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0425176428', 35, '2022-06-01');
insert into Books_Bought (book_id, reader_id, date_bought) values ('9420499496', 31, '2022-11-07');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0539480579', 22, '2022-01-18');
insert into Books_Bought (book_id, reader_id, date_bought) values ('5083416954', 12, '2022-11-06');
insert into Books_Bought (book_id, reader_id, date_bought) values ('6616246702', 11, '2022-05-10');
insert into Books_Bought (book_id, reader_id, date_bought) values ('1552041778', 24, '2022-10-13');
insert into Books_Bought (book_id, reader_id, date_bought) values ('8030833402', 48, '2022-03-23');
insert into Books_Bought (book_id, reader_id, date_bought) values ('1542961988', 35, '2022-08-20');
insert into Books_Bought (book_id, reader_id, date_bought) values ('5345795622', 36, '2022-04-08');
insert into Books_Bought (book_id, reader_id, date_bought) values ('3075757124', 25, '2022-01-15');
insert into Books_Bought (book_id, reader_id, date_bought) values ('4259066355', 39, '2022-06-12');
insert into Books_Bought (book_id, reader_id, date_bought) values ('4414162338', 50, '2022-02-14');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0060973129', 41, '2022-07-13');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0980424405', 23, '2022-05-26');
insert into Books_Bought (book_id, reader_id, date_bought) values ('080652121X', 7, '2022-03-19');
insert into Books_Bought (book_id, reader_id, date_bought) values ('2651606481', 5, '2021-12-08');
insert into Books_Bought (book_id, reader_id, date_bought) values ('8245982908', 28, '2022-03-12');
insert into Books_Bought (book_id, reader_id, date_bought) values ('1270157493', 45, '2022-06-11');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0060973129', 14, '2022-06-11');
insert into Books_Bought (book_id, reader_id, date_bought) values ('9483864357', 6, '2022-12-05');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0671870432', 38, '2022-09-23');
insert into Books_Bought (book_id, reader_id, date_bought) values ('4749144249', 50, '2022-08-16');
insert into Books_Bought (book_id, reader_id, date_bought) values ('4749144249', 27, '2022-04-03');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0349289655', 27, '2022-06-06');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0399135782', 45, '2022-08-25');
insert into Books_Bought (book_id, reader_id, date_bought) values ('5736961675', 17, '2022-01-03');
insert into Books_Bought (book_id, reader_id, date_bought) values ('1270157493', 33, '2022-05-05');
insert into Books_Bought (book_id, reader_id, date_bought) values ('5415362252', 38, '2022-03-08');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0771074670', 40, '2022-06-15');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0771074670', 36, '2021-12-08');
insert into Books_Bought (book_id, reader_id, date_bought) values ('5345795622', 46, '2022-11-05');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0399135782', 16, '2022-05-23');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0887841740', 45, '2022-09-05');
insert into Books_Bought (book_id, reader_id, date_bought) values ('9169416157', 7, '2022-09-29');
insert into Books_Bought (book_id, reader_id, date_bought) values ('4366833607', 12, '2022-12-04');
insert into Books_Bought (book_id, reader_id, date_bought) values ('8245982908', 24, '2022-01-17');
insert into Books_Bought (book_id, reader_id, date_bought) values ('8030833402', 33, '2022-05-31');
insert into Books_Bought (book_id, reader_id, date_bought) values ('5083416954', 11, '2022-04-25');
insert into Books_Bought (book_id, reader_id, date_bought) values ('7510761654', 9, '2022-03-21');
insert into Books_Bought (book_id, reader_id, date_bought) values ('9483864357', 50, '2022-01-02');
insert into Books_Bought (book_id, reader_id, date_bought) values ('1542961988', 23, '2022-02-04');
insert into Books_Bought (book_id, reader_id, date_bought) values ('5083416954', 9, '2022-09-04');
insert into Books_Bought (book_id, reader_id, date_bought) values ('7560067286', 33, '2022-04-10');
insert into Books_Bought (book_id, reader_id, date_bought) values ('1542961988', 36, '2022-03-11');
insert into Books_Bought (book_id, reader_id, date_bought) values ('8803418832', 50, '2022-01-10');
insert into Books_Bought (book_id, reader_id, date_bought) values ('3310064439', 24, '2022-07-10');
insert into Books_Bought (book_id, reader_id, date_bought) values ('8803418832', 37, '2022-07-11');
insert into Books_Bought (book_id, reader_id, date_bought) values ('4259066355', 18, '2022-04-04');
insert into Books_Bought (book_id, reader_id, date_bought) values ('5736961675', 5, '2022-07-04');
insert into Books_Bought (book_id, reader_id, date_bought) values ('3886221838', 21, '2022-10-12');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0425176428', 17, '2022-07-06');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0887841740', 6, '2022-03-01');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0771074670', 24, '2022-02-22');
insert into Books_Bought (book_id, reader_id, date_bought) values ('3886221838', 23, '2022-02-17');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0425176428', 22, '2022-03-17');
insert into Books_Bought (book_id, reader_id, date_bought) values ('8245982908', 10, '2021-12-31');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0671870432', 8, '2022-03-04');
insert into Books_Bought (book_id, reader_id, date_bought) values ('1270157493', 6, '2022-02-24');
insert into Books_Bought (book_id, reader_id, date_bought) values ('6616246702', 38, '2022-05-17');
insert into Books_Bought (book_id, reader_id, date_bought) values ('8803418832', 40, '2022-09-23');
insert into Books_Bought (book_id, reader_id, date_bought) values ('5083416954', 42, '2022-01-03');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0002005018', 11, '2022-08-17');
insert into Books_Bought (book_id, reader_id, date_bought) values ('4366833607', 27, '2021-12-21');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0404270983', 29, '2021-12-24');
insert into Books_Bought (book_id, reader_id, date_bought) values ('8030833402', 2, '2022-03-26');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0060973129', 34, '2022-10-04');
insert into Books_Bought (book_id, reader_id, date_bought) values ('4414162338', 3, '2021-12-12');
insert into Books_Bought (book_id, reader_id, date_bought) values ('3559494173', 42, '2022-02-26');
insert into Books_Bought (book_id, reader_id, date_bought) values ('9035785733', 25, '2022-05-31');
insert into Books_Bought (book_id, reader_id, date_bought) values ('5736961675', 33, '2022-10-25');
insert into Books_Bought (book_id, reader_id, date_bought) values ('4366833607', 45, '2022-02-11');
insert into Books_Bought (book_id, reader_id, date_bought) values ('5345795622', 43, '2022-03-22');
insert into Books_Bought (book_id, reader_id, date_bought) values ('3559494173', 32, '2022-09-20');
insert into Books_Bought (book_id, reader_id, date_bought) values ('9420499496', 36, '2022-02-15');
insert into Books_Bought (book_id, reader_id, date_bought) values ('9035785733', 11, '2022-04-27');
insert into Books_Bought (book_id, reader_id, date_bought) values ('3075757124', 9, '2022-05-02');
insert into Books_Bought (book_id, reader_id, date_bought) values ('4263866611', 27, '2022-05-13');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0771074670', 48, '2021-12-09');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0060973129', 25, '2022-04-08');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0349289655', 15, '2022-02-03');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0887841740', 1, '2022-09-15');
insert into Books_Bought (book_id, reader_id, date_bought) values ('5415362252', 47, '2021-12-17');
insert into Books_Bought (book_id, reader_id, date_bought) values ('7510761654', 26, '2022-04-13');
insert into Books_Bought (book_id, reader_id, date_bought) values ('5736961675', 21, '2022-10-04');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0393045218', 27, '2022-02-13');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0679425608', 38, '2022-04-06');
insert into Books_Bought (book_id, reader_id, date_bought) values ('3886221838', 4, '2022-02-03');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0539480579', 42, '2022-06-01');
insert into Books_Bought (book_id, reader_id, date_bought) values ('5415362252', 50, '2022-07-14');
insert into Books_Bought (book_id, reader_id, date_bought) values ('2582935701', 44, '2022-11-08');
insert into Books_Bought (book_id, reader_id, date_bought) values ('7510761654', 27, '2022-11-23');
insert into Books_Bought (book_id, reader_id, date_bought) values ('0887841740', 47, '2022-08-29');
insert into Books_Bought (book_id, reader_id, date_bought) values ('4919322257', 24, '2022-04-05');



# ---------------- Book Submissions ----------------
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('0195153448', 1, '2022-06-19', true);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('0002005018', 2, '2022-07-10', true);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('0060973129', 3, '2022-06-26', true);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('0393045218', 4, '2022-01-06', true);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('0399135782', 5, '2022-01-27', true);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('0425176428', 6, '2022-12-05', true);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('0671870432', 7, '2022-08-12', true);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('0679425608', 8, '2022-03-13', true);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('074322678X', 9, '2022-05-04', true);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('0771074670', 10, '2022-04-27', true);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('080652121X', 11, '2022-03-03', true);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('0887841740', 12, '2022-11-23', true);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('8030833402', 13, '2022-05-31', true);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('2651606481', 14, '2022-04-01', true);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('8803418832', 15, '2022-05-05', true);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('0404270983', 16, '2022-08-31', true);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('3075757124', 17, '2022-06-22', true);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('5736961675', 18, '2022-07-23', true);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('7560067286', 19, '2022-01-16', true);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('9169416157', 20, '2022-08-20', true);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('8245982908', 21, '2022-06-01', true);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('1848872220', 22, '2022-08-30', true);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('3310064439', 23, '2022-01-27', true);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('4414162338', 24, '2022-11-03', true);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('4366833607', 25, '2022-04-22', true);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('9420499496', 26, '2021-12-20', true);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('0349289655', 27, '2022-09-25', true);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('0987031924', 28, '2022-02-21', true);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('9035785733', 29, '2022-01-01', true);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('6616246702', 30, '2022-02-03', true);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('2582935701', 31, '2022-01-20', true);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('5415362252', 32, '2022-04-25', true);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('3559494173', 33, '2022-09-13', true);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('7510761654', 34, '2022-04-25', true);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('4259066355', 35, '2022-05-07', true);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('3971475766', 36, '2022-05-24', true);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('9483864357', 37, '2022-08-27', true);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('3886221838', 38, '2022-01-11', true);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('0539480579', 39, '2022-11-01', true);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('7282766280', 40, '2022-03-20', true);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('4749144249', 41, '2021-12-19', true);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('1542961988', 42, '2022-04-01', true);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('4919322257', 43, '2022-08-14', true);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('7624503736', 44, '2022-03-24', true);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('0980424405', 45, '2022-05-27', true);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('5083416954', 46, '2022-08-30', true);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('1270157493', 47, '2022-09-15', true);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('5345795622', 48, '2022-03-28', true);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('4263866611', 49, '2022-08-13', true);
insert into Book_Submissions (book_id, seller_id, date_added, accepted) values ('1552041778', 50, '2022-05-07', true);

insert into Book_Submissions (book_id, seller_id) values ('0000000001', 1);
insert into Book_Submissions (book_id, seller_id) values ('0000000002', 1);
insert into Book_Submissions (book_id, seller_id) values ('0000000003', 1);

# ---------------- Recommendations  ----------------
insert into Recommendations (book_id, curator_id) values ('4414162338', 35);
insert into Recommendations (book_id, curator_id) values ('3971475766', 2);
insert into Recommendations (book_id, curator_id) values ('7282766280', 19);
insert into Recommendations (book_id, curator_id) values ('4749144249', 22);
insert into Recommendations (book_id, curator_id) values ('0671870432', 31);
insert into Recommendations (book_id, curator_id) values ('0399135782', 35);
insert into Recommendations (book_id, curator_id) values ('0671870432', 10);
insert into Recommendations (book_id, curator_id) values ('0349289655', 50);
insert into Recommendations (book_id, curator_id) values ('0539480579', 30);
insert into Recommendations (book_id, curator_id) values ('2651606481', 6);
insert into Recommendations (book_id, curator_id) values ('0404270983', 4);
insert into Recommendations (book_id, curator_id) values ('0060973129', 2);
insert into Recommendations (book_id, curator_id) values ('0539480579', 12);
insert into Recommendations (book_id, curator_id) values ('0539480579', 8);
insert into Recommendations (book_id, curator_id) values ('0425176428', 3);
insert into Recommendations (book_id, curator_id) values ('0195153448', 39);
insert into Recommendations (book_id, curator_id) values ('0679425608', 19);
insert into Recommendations (book_id, curator_id) values ('5345795622', 6);
insert into Recommendations (book_id, curator_id) values ('0539480579', 3);
insert into Recommendations (book_id, curator_id) values ('0987031924', 3);
insert into Recommendations (book_id, curator_id) values ('0393045218', 30);
insert into Recommendations (book_id, curator_id) values ('074322678X', 37);
insert into Recommendations (book_id, curator_id) values ('080652121X', 30);
insert into Recommendations (book_id, curator_id) values ('0771074670', 18);
insert into Recommendations (book_id, curator_id) values ('5415362252', 32);
insert into Recommendations (book_id, curator_id) values ('0987031924', 18);
insert into Recommendations (book_id, curator_id) values ('9420499496', 33);
insert into Recommendations (book_id, curator_id) values ('5083416954', 9);
insert into Recommendations (book_id, curator_id) values ('0349289655', 5);
insert into Recommendations (book_id, curator_id) values ('3075757124', 11);
insert into Recommendations (book_id, curator_id) values ('4259066355', 19);
insert into Recommendations (book_id, curator_id) values ('4259066355', 48);
insert into Recommendations (book_id, curator_id) values ('4366833607', 33);
insert into Recommendations (book_id, curator_id) values ('4414162338', 32);
insert into Recommendations (book_id, curator_id) values ('4366833607', 48);
insert into Recommendations (book_id, curator_id) values ('5415362252', 43);
insert into Recommendations (book_id, curator_id) values ('5083416954', 1);
insert into Recommendations (book_id, curator_id) values ('5736961675', 23);
insert into Recommendations (book_id, curator_id) values ('1270157493', 42);
insert into Recommendations (book_id, curator_id) values ('9483864357', 5);
insert into Recommendations (book_id, curator_id) values ('7624503736', 31);
insert into Recommendations (book_id, curator_id) values ('080652121X', 40);
insert into Recommendations (book_id, curator_id) values ('9035785733', 29);
insert into Recommendations (book_id, curator_id) values ('0980424405', 44);
insert into Recommendations (book_id, curator_id) values ('0060973129', 29);
insert into Recommendations (book_id, curator_id) values ('8030833402', 48);
insert into Recommendations (book_id, curator_id) values ('0980424405', 14);
insert into Recommendations (book_id, curator_id) values ('0987031924', 16);
insert into Recommendations (book_id, curator_id) values ('074322678X', 27);
insert into Recommendations (book_id, curator_id) values ('7624503736', 7);
insert into Recommendations (book_id, curator_id) values ('7510761654', 15);
insert into Recommendations (book_id, curator_id) values ('0771074670', 26);
insert into Recommendations (book_id, curator_id) values ('0002005018', 26);
insert into Recommendations (book_id, curator_id) values ('8030833402', 29);
insert into Recommendations (book_id, curator_id) values ('4414162338', 24);
insert into Recommendations (book_id, curator_id) values ('0060973129', 40);
insert into Recommendations (book_id, curator_id) values ('1552041778', 21);
insert into Recommendations (book_id, curator_id) values ('9169416157', 41);
insert into Recommendations (book_id, curator_id) values ('7624503736', 1);
insert into Recommendations (book_id, curator_id) values ('7510761654', 18);
insert into Recommendations (book_id, curator_id) values ('9420499496', 30);
insert into Recommendations (book_id, curator_id) values ('4259066355', 33);
insert into Recommendations (book_id, curator_id) values ('8030833402', 6);
insert into Recommendations (book_id, curator_id) values ('0539480579', 15);
insert into Recommendations (book_id, curator_id) values ('1542961988', 36);
insert into Recommendations (book_id, curator_id) values ('4414162338', 48);
insert into Recommendations (book_id, curator_id) values ('0771074670', 5);
insert into Recommendations (book_id, curator_id) values ('3886221838', 17);
insert into Recommendations (book_id, curator_id) values ('5415362252', 15);
insert into Recommendations (book_id, curator_id) values ('7560067286', 31);
insert into Recommendations (book_id, curator_id) values ('3075757124', 38);
insert into Recommendations (book_id, curator_id) values ('0679425608', 32);
insert into Recommendations (book_id, curator_id) values ('5736961675', 12);
insert into Recommendations (book_id, curator_id) values ('1552041778', 13);
insert into Recommendations (book_id, curator_id) values ('5083416954', 38);
insert into Recommendations (book_id, curator_id) values ('3310064439', 24);
insert into Recommendations (book_id, curator_id) values ('5083416954', 8);
insert into Recommendations (book_id, curator_id) values ('9420499496', 26);
insert into Recommendations (book_id, curator_id) values ('7624503736', 18);
insert into Recommendations (book_id, curator_id) values ('0425176428', 7);
insert into Recommendations (book_id, curator_id) values ('9483864357', 21);
insert into Recommendations (book_id, curator_id) values ('8803418832', 35);
insert into Recommendations (book_id, curator_id) values ('0404270983', 37);
insert into Recommendations (book_id, curator_id) values ('8803418832', 1);
insert into Recommendations (book_id, curator_id) values ('8245982908', 10);
insert into Recommendations (book_id, curator_id) values ('0771074670', 14);
insert into Recommendations (book_id, curator_id) values ('3310064439', 44);
insert into Recommendations (book_id, curator_id) values ('8803418832', 5);
insert into Recommendations (book_id, curator_id) values ('5345795622', 17);
insert into Recommendations (book_id, curator_id) values ('4749144249', 47);
insert into Recommendations (book_id, curator_id) values ('0887841740', 7);
insert into Recommendations (book_id, curator_id) values ('4263866611', 33);
insert into Recommendations (book_id, curator_id) values ('4259066355', 3);
insert into Recommendations (book_id, curator_id) values ('8803418832', 30);
insert into Recommendations (book_id, curator_id) values ('5083416954', 5);
insert into Recommendations (book_id, curator_id) values ('074322678X', 4);
insert into Recommendations (book_id, curator_id) values ('8030833402', 5);
insert into Recommendations (book_id, curator_id) values ('0425176428', 6);
insert into Recommendations (book_id, curator_id) values ('4919322257', 38);
insert into Recommendations (book_id, curator_id) values ('7510761654', 29);
insert into Recommendations (book_id, curator_id) values ('8803418832', 36);
insert into Recommendations (book_id, curator_id) values ('3559494173', 24);
insert into Recommendations (book_id, curator_id) values ('0002005018', 17);
insert into Recommendations (book_id, curator_id) values ('9483864357', 46);
insert into Recommendations (book_id, curator_id) values ('7282766280', 49);
insert into Recommendations (book_id, curator_id) values ('9169416157', 27);
insert into Recommendations (book_id, curator_id) values ('9035785733', 37);
insert into Recommendations (book_id, curator_id) values ('0404270983', 21);
insert into Recommendations (book_id, curator_id) values ('0980424405', 39);
insert into Recommendations (book_id, curator_id) values ('4259066355', 21);
insert into Recommendations (book_id, curator_id) values ('0060973129', 44);
insert into Recommendations (book_id, curator_id) values ('0539480579', 16);
insert into Recommendations (book_id, curator_id) values ('5736961675', 26);
insert into Recommendations (book_id, curator_id) values ('9035785733', 38);
insert into Recommendations (book_id, curator_id) values ('9483864357', 20);
insert into Recommendations (book_id, curator_id) values ('2582935701', 10);
insert into Recommendations (book_id, curator_id) values ('4366833607', 50);
insert into Recommendations (book_id, curator_id) values ('3075757124', 9);
insert into Recommendations (book_id, curator_id) values ('3886221838', 3);
insert into Recommendations (book_id, curator_id) values ('3075757124', 28);
insert into Recommendations (book_id, curator_id) values ('7624503736', 46);
insert into Recommendations (book_id, curator_id) values ('0425176428', 11);
insert into Recommendations (book_id, curator_id) values ('1270157493', 31);
insert into Recommendations (book_id, curator_id) values ('0425176428', 8);
insert into Recommendations (book_id, curator_id) values ('4259066355', 9);
insert into Recommendations (book_id, curator_id) values ('8030833402', 44);
insert into Recommendations (book_id, curator_id) values ('0404270983', 35);
insert into Recommendations (book_id, curator_id) values ('0349289655', 38);
insert into Recommendations (book_id, curator_id) values ('3075757124', 50);
insert into Recommendations (book_id, curator_id) values ('0671870432', 40);
insert into Recommendations (book_id, curator_id) values ('3075757124', 7);
insert into Recommendations (book_id, curator_id) values ('0671870432', 32);
insert into Recommendations (book_id, curator_id) values ('0399135782', 43);
insert into Recommendations (book_id, curator_id) values ('7624503736', 4);
insert into Recommendations (book_id, curator_id) values ('6616246702', 26);
insert into Recommendations (book_id, curator_id) values ('4414162338', 5);
insert into Recommendations (book_id, curator_id) values ('4749144249', 19);
insert into Recommendations (book_id, curator_id) values ('1552041778', 35);
insert into Recommendations (book_id, curator_id) values ('0060973129', 25);
insert into Recommendations (book_id, curator_id) values ('5345795622', 3);
insert into Recommendations (book_id, curator_id) values ('3075757124', 2);
insert into Recommendations (book_id, curator_id) values ('0671870432', 2);
insert into Recommendations (book_id, curator_id) values ('8030833402', 23);
insert into Recommendations (book_id, curator_id) values ('1552041778', 32);
insert into Recommendations (book_id, curator_id) values ('7282766280', 28);
insert into Recommendations (book_id, curator_id) values ('4749144249', 10);
insert into Recommendations (book_id, curator_id) values ('3971475766', 19);
insert into Recommendations (book_id, curator_id) values ('3886221838', 44);
insert into Recommendations (book_id, curator_id) values ('8803418832', 32);
insert into Recommendations (book_id, curator_id) values ('3075757124', 15);
insert into Recommendations (book_id, curator_id) values ('0349289655', 28);
insert into Recommendations (book_id, curator_id) values ('0195153448', 48);
insert into Recommendations (book_id, curator_id) values ('5083416954', 13);
insert into Recommendations (book_id, curator_id) values ('6616246702', 3);
insert into Recommendations (book_id, curator_id) values ('6616246702', 37);
insert into Recommendations (book_id, curator_id) values ('9169416157', 40);
insert into Recommendations (book_id, curator_id) values ('0404270983', 41);
insert into Recommendations (book_id, curator_id) values ('9035785733', 9);
insert into Recommendations (book_id, curator_id) values ('4414162338', 6);
insert into Recommendations (book_id, curator_id) values ('8030833402', 13);
insert into Recommendations (book_id, curator_id) values ('1542961988', 23);
insert into Recommendations (book_id, curator_id) values ('5083416954', 34);
insert into Recommendations (book_id, curator_id) values ('0539480579', 41);
insert into Recommendations (book_id, curator_id) values ('9169416157', 31);
insert into Recommendations (book_id, curator_id) values ('0393045218', 27);
insert into Recommendations (book_id, curator_id) values ('3310064439', 15);
insert into Recommendations (book_id, curator_id) values ('1270157493', 2);
insert into Recommendations (book_id, curator_id) values ('3310064439', 35);
insert into Recommendations (book_id, curator_id) values ('0771074670', 35);
insert into Recommendations (book_id, curator_id) values ('3886221838', 47);
insert into Recommendations (book_id, curator_id) values ('0399135782', 3);
insert into Recommendations (book_id, curator_id) values ('4366833607', 49);
insert into Recommendations (book_id, curator_id) values ('4366833607', 11);
insert into Recommendations (book_id, curator_id) values ('2651606481', 33);
insert into Recommendations (book_id, curator_id) values ('0887841740', 1);
insert into Recommendations (book_id, curator_id) values ('3075757124', 12);
insert into Recommendations (book_id, curator_id) values ('0671870432', 14);
insert into Recommendations (book_id, curator_id) values ('7282766280', 12);
insert into Recommendations (book_id, curator_id) values ('4919322257', 45);
insert into Recommendations (book_id, curator_id) values ('4919322257', 33);
insert into Recommendations (book_id, curator_id) values ('2582935701', 33);
insert into Recommendations (book_id, curator_id) values ('4259066355', 15);
insert into Recommendations (book_id, curator_id) values ('8030833402', 35);
insert into Recommendations (book_id, curator_id) values ('4749144249', 16);
insert into Recommendations (book_id, curator_id) values ('5083416954', 46);
insert into Recommendations (book_id, curator_id) values ('1270157493', 13);
insert into Recommendations (book_id, curator_id) values ('8030833402', 34);
insert into Recommendations (book_id, curator_id) values ('1542961988', 37);
insert into Recommendations (book_id, curator_id) values ('3886221838', 10);
insert into Recommendations (book_id, curator_id) values ('9420499496', 40);
insert into Recommendations (book_id, curator_id) values ('5345795622', 13);
insert into Recommendations (book_id, curator_id) values ('1270157493', 6);
insert into Recommendations (book_id, curator_id) values ('8803418832', 48);
insert into Recommendations (book_id, curator_id) values ('5345795622', 27);
insert into Recommendations (book_id, curator_id) values ('0987031924', 23);
insert into Recommendations (book_id, curator_id) values ('0539480579', 29);
insert into Recommendations (book_id, curator_id) values ('7560067286', 3);
insert into Recommendations (book_id, curator_id) values ('9035785733', 2);
insert into Recommendations (book_id, curator_id) values ('4263866611', 4);
insert into Recommendations (book_id, curator_id) values ('3310064439', 5);

# ---------------- Reading_List  ----------------
insert into Reading_List (book_id, reader_id) values ('4919322257', 19);
insert into Reading_List (book_id, reader_id) values ('074322678X', 23);
insert into Reading_List (book_id, reader_id) values ('0393045218', 36);
insert into Reading_List (book_id, reader_id) values ('0060973129', 8);
insert into Reading_List (book_id, reader_id) values ('4366833607', 13);
insert into Reading_List (book_id, reader_id) values ('4414162338', 47);
insert into Reading_List (book_id, reader_id) values ('5415362252', 50);
insert into Reading_List (book_id, reader_id) values ('0987031924', 19);
insert into Reading_List (book_id, reader_id) values ('0002005018', 18);
insert into Reading_List (book_id, reader_id) values ('9483864357', 5);
insert into Reading_List (book_id, reader_id) values ('4263866611', 35);
insert into Reading_List (book_id, reader_id) values ('4919322257', 48);
insert into Reading_List (book_id, reader_id) values ('3971475766', 36);
insert into Reading_List (book_id, reader_id) values ('8803418832', 35);
insert into Reading_List (book_id, reader_id) values ('2651606481', 50);
insert into Reading_List (book_id, reader_id) values ('1552041778', 17);
insert into Reading_List (book_id, reader_id) values ('6616246702', 40);
insert into Reading_List (book_id, reader_id) values ('4366833607', 14);
insert into Reading_List (book_id, reader_id) values ('1552041778', 25);
insert into Reading_List (book_id, reader_id) values ('0679425608', 9);
insert into Reading_List (book_id, reader_id) values ('3559494173', 44);
insert into Reading_List (book_id, reader_id) values ('0425176428', 16);
insert into Reading_List (book_id, reader_id) values ('0771074670', 34);
insert into Reading_List (book_id, reader_id) values ('5415362252', 24);
insert into Reading_List (book_id, reader_id) values ('4919322257', 45);
insert into Reading_List (book_id, reader_id) values ('8030833402', 14);
insert into Reading_List (book_id, reader_id) values ('0987031924', 13);
insert into Reading_List (book_id, reader_id) values ('0980424405', 44);
insert into Reading_List (book_id, reader_id) values ('1552041778', 45);
insert into Reading_List (book_id, reader_id) values ('0060973129', 36);
insert into Reading_List (book_id, reader_id) values ('9483864357', 27);
insert into Reading_List (book_id, reader_id) values ('5736961675', 44);
insert into Reading_List (book_id, reader_id) values ('0887841740', 13);
insert into Reading_List (book_id, reader_id) values ('0393045218', 27);
insert into Reading_List (book_id, reader_id) values ('7624503736', 49);
insert into Reading_List (book_id, reader_id) values ('080652121X', 1);
insert into Reading_List (book_id, reader_id) values ('1848872220', 36);
insert into Reading_List (book_id, reader_id) values ('1848872220', 25);
insert into Reading_List (book_id, reader_id) values ('3559494173', 14);
insert into Reading_List (book_id, reader_id) values ('0393045218', 11);
insert into Reading_List (book_id, reader_id) values ('0393045218', 25);
insert into Reading_List (book_id, reader_id) values ('080652121X', 23);
insert into Reading_List (book_id, reader_id) values ('0349289655', 1);
insert into Reading_List (book_id, reader_id) values ('3971475766', 2);
insert into Reading_List (book_id, reader_id) values ('4259066355', 41);
insert into Reading_List (book_id, reader_id) values ('3971475766', 15);
insert into Reading_List (book_id, reader_id) values ('7510761654', 40);
insert into Reading_List (book_id, reader_id) values ('4366833607', 33);
insert into Reading_List (book_id, reader_id) values ('2582935701', 15);
insert into Reading_List (book_id, reader_id) values ('9035785733', 27);
insert into Reading_List (book_id, reader_id) values ('0002005018', 12);
insert into Reading_List (book_id, reader_id) values ('080652121X', 45);
insert into Reading_List (book_id, reader_id) values ('0425176428', 34);
insert into Reading_List (book_id, reader_id) values ('1848872220', 7);
insert into Reading_List (book_id, reader_id) values ('080652121X', 19);
insert into Reading_List (book_id, reader_id) values ('7282766280', 10);
insert into Reading_List (book_id, reader_id) values ('4919322257', 21);
insert into Reading_List (book_id, reader_id) values ('3075757124', 19);
insert into Reading_List (book_id, reader_id) values ('0887841740', 9);
insert into Reading_List (book_id, reader_id) values ('7624503736', 8);
insert into Reading_List (book_id, reader_id) values ('3886221838', 23);
insert into Reading_List (book_id, reader_id) values ('4414162338', 35);
insert into Reading_List (book_id, reader_id) values ('7624503736', 47);
insert into Reading_List (book_id, reader_id) values ('0425176428', 5);
insert into Reading_List (book_id, reader_id) values ('9483864357', 14);
insert into Reading_List (book_id, reader_id) values ('5083416954', 17);
insert into Reading_List (book_id, reader_id) values ('7560067286', 24);
insert into Reading_List (book_id, reader_id) values ('0887841740', 47);
insert into Reading_List (book_id, reader_id) values ('8030833402', 6);
insert into Reading_List (book_id, reader_id) values ('1848872220', 5);
insert into Reading_List (book_id, reader_id) values ('3559494173', 5);
insert into Reading_List (book_id, reader_id) values ('5736961675', 8);
insert into Reading_List (book_id, reader_id) values ('0987031924', 39);
insert into Reading_List (book_id, reader_id) values ('3559494173', 35);
insert into Reading_List (book_id, reader_id) values ('0980424405', 36);
insert into Reading_List (book_id, reader_id) values ('0539480579', 30);
insert into Reading_List (book_id, reader_id) values ('1848872220', 37);
insert into Reading_List (book_id, reader_id) values ('5083416954', 43);
insert into Reading_List (book_id, reader_id) values ('0002005018', 14);
insert into Reading_List (book_id, reader_id) values ('2651606481', 44);
insert into Reading_List (book_id, reader_id) values ('7624503736', 13);
insert into Reading_List (book_id, reader_id) values ('0393045218', 39);
insert into Reading_List (book_id, reader_id) values ('8803418832', 36);
insert into Reading_List (book_id, reader_id) values ('4263866611', 1);
insert into Reading_List (book_id, reader_id) values ('0002005018', 1);
insert into Reading_List (book_id, reader_id) values ('5345795622', 15);
insert into Reading_List (book_id, reader_id) values ('3886221838', 24);
insert into Reading_List (book_id, reader_id) values ('7560067286', 42);
insert into Reading_List (book_id, reader_id) values ('7282766280', 25);
insert into Reading_List (book_id, reader_id) values ('0987031924', 30);
insert into Reading_List (book_id, reader_id) values ('074322678X', 19);
insert into Reading_List (book_id, reader_id) values ('074322678X', 13);
insert into Reading_List (book_id, reader_id) values ('2651606481', 8);
insert into Reading_List (book_id, reader_id) values ('7560067286', 7);
insert into Reading_List (book_id, reader_id) values ('3559494173', 26);
insert into Reading_List (book_id, reader_id) values ('0349289655', 25);
insert into Reading_List (book_id, reader_id) values ('080652121X', 11);
insert into Reading_List (book_id, reader_id) values ('0399135782', 35);
insert into Reading_List (book_id, reader_id) values ('5415362252', 17);
insert into Reading_List (book_id, reader_id) values ('0002005018', 47);
insert into Reading_List (book_id, reader_id) values ('8245982908', 6);
insert into Reading_List (book_id, reader_id) values ('5083416954', 3);
insert into Reading_List (book_id, reader_id) values ('3886221838', 13);
insert into Reading_List (book_id, reader_id) values ('9169416157', 39);
insert into Reading_List (book_id, reader_id) values ('4749144249', 17);
insert into Reading_List (book_id, reader_id) values ('4366833607', 50);
insert into Reading_List (book_id, reader_id) values ('3886221838', 46);
insert into Reading_List (book_id, reader_id) values ('0349289655', 11);
insert into Reading_List (book_id, reader_id) values ('8245982908', 35);
insert into Reading_List (book_id, reader_id) values ('9420499496', 37);
insert into Reading_List (book_id, reader_id) values ('2651606481', 40);
insert into Reading_List (book_id, reader_id) values ('9420499496', 46);
insert into Reading_List (book_id, reader_id) values ('2582935701', 47);
insert into Reading_List (book_id, reader_id) values ('0679425608', 26);
insert into Reading_List (book_id, reader_id) values ('9483864357', 13);
insert into Reading_List (book_id, reader_id) values ('0349289655', 33);
insert into Reading_List (book_id, reader_id) values ('4919322257', 44);
insert into Reading_List (book_id, reader_id) values ('074322678X', 2);
insert into Reading_List (book_id, reader_id) values ('0393045218', 43);
insert into Reading_List (book_id, reader_id) values ('0539480579', 10);
insert into Reading_List (book_id, reader_id) values ('0060973129', 9);
insert into Reading_List (book_id, reader_id) values ('7624503736', 9);
insert into Reading_List (book_id, reader_id) values ('9035785733', 41);
insert into Reading_List (book_id, reader_id) values ('1552041778', 38);
insert into Reading_List (book_id, reader_id) values ('5083416954', 20);
insert into Reading_List (book_id, reader_id) values ('0679425608', 49);
insert into Reading_List (book_id, reader_id) values ('1848872220', 6);
insert into Reading_List (book_id, reader_id) values ('7510761654', 48);
insert into Reading_List (book_id, reader_id) values ('9035785733', 23);
insert into Reading_List (book_id, reader_id) values ('4366833607', 40);
insert into Reading_List (book_id, reader_id) values ('3971475766', 14);
insert into Reading_List (book_id, reader_id) values ('0679425608', 12);
insert into Reading_List (book_id, reader_id) values ('3886221838', 25);
insert into Reading_List (book_id, reader_id) values ('0980424405', 19);
insert into Reading_List (book_id, reader_id) values ('7282766280', 15);
insert into Reading_List (book_id, reader_id) values ('4263866611', 34);
insert into Reading_List (book_id, reader_id) values ('5415362252', 49);
insert into Reading_List (book_id, reader_id) values ('0771074670', 37);
insert into Reading_List (book_id, reader_id) values ('7560067286', 11);
insert into Reading_List (book_id, reader_id) values ('0393045218', 49);
insert into Reading_List (book_id, reader_id) values ('0195153448', 28);
insert into Reading_List (book_id, reader_id) values ('0679425608', 10);
insert into Reading_List (book_id, reader_id) values ('0404270983', 30);
insert into Reading_List (book_id, reader_id) values ('0539480579', 20);
insert into Reading_List (book_id, reader_id) values ('4414162338', 32);
insert into Reading_List (book_id, reader_id) values ('3971475766', 19);
insert into Reading_List (book_id, reader_id) values ('8030833402', 46);
insert into Reading_List (book_id, reader_id) values ('1270157493', 20);
insert into Reading_List (book_id, reader_id) values ('7510761654', 23);
insert into Reading_List (book_id, reader_id) values ('7510761654', 43);
insert into Reading_List (book_id, reader_id) values ('4414162338', 33);
insert into Reading_List (book_id, reader_id) values ('2582935701', 40);
insert into Reading_List (book_id, reader_id) values ('0195153448', 36);
insert into Reading_List (book_id, reader_id) values ('0980424405', 10);
insert into Reading_List (book_id, reader_id) values ('0393045218', 17);
insert into Reading_List (book_id, reader_id) values ('4263866611', 47);
insert into Reading_List (book_id, reader_id) values ('4414162338', 28);
insert into Reading_List (book_id, reader_id) values ('0671870432', 18);
insert into Reading_List (book_id, reader_id) values ('1552041778', 7);
insert into Reading_List (book_id, reader_id) values ('8245982908', 2);
insert into Reading_List (book_id, reader_id) values ('0060973129', 22);
insert into Reading_List (book_id, reader_id) values ('4259066355', 40);
insert into Reading_List (book_id, reader_id) values ('2651606481', 20);
insert into Reading_List (book_id, reader_id) values ('0393045218', 48);
insert into Reading_List (book_id, reader_id) values ('9169416157', 10);
insert into Reading_List (book_id, reader_id) values ('0671870432', 7);
insert into Reading_List (book_id, reader_id) values ('080652121X', 50);
insert into Reading_List (book_id, reader_id) values ('9483864357', 36);
insert into Reading_List (book_id, reader_id) values ('3559494173', 45);
insert into Reading_List (book_id, reader_id) values ('2582935701', 29);
insert into Reading_List (book_id, reader_id) values ('3886221838', 9);
insert into Reading_List (book_id, reader_id) values ('3075757124', 31);
insert into Reading_List (book_id, reader_id) values ('7560067286', 45);
insert into Reading_List (book_id, reader_id) values ('5083416954', 5);
insert into Reading_List (book_id, reader_id) values ('0393045218', 47);
insert into Reading_List (book_id, reader_id) values ('7624503736', 3);
insert into Reading_List (book_id, reader_id) values ('0399135782', 6);
insert into Reading_List (book_id, reader_id) values ('5083416954', 14);
insert into Reading_List (book_id, reader_id) values ('7624503736', 37);
insert into Reading_List (book_id, reader_id) values ('0539480579', 9);
insert into Reading_List (book_id, reader_id) values ('4366833607', 10);
insert into Reading_List (book_id, reader_id) values ('074322678X', 43);
insert into Reading_List (book_id, reader_id) values ('0980424405', 18);
insert into Reading_List (book_id, reader_id) values ('5736961675', 1);
insert into Reading_List (book_id, reader_id) values ('8803418832', 30);
insert into Reading_List (book_id, reader_id) values ('9483864357', 22);
insert into Reading_List (book_id, reader_id) values ('0060973129', 18);
insert into Reading_List (book_id, reader_id) values ('7510761654', 21);
insert into Reading_List (book_id, reader_id) values ('2651606481', 47);
insert into Reading_List (book_id, reader_id) values ('4919322257', 29);
insert into Reading_List (book_id, reader_id) values ('5345795622', 14);
insert into Reading_List (book_id, reader_id) values ('1552041778', 43);
insert into Reading_List (book_id, reader_id) values ('0002005018', 2);
insert into Reading_List (book_id, reader_id) values ('3310064439', 38);
insert into Reading_List (book_id, reader_id) values ('4749144249', 33);
insert into Reading_List (book_id, reader_id) values ('0671870432', 8);
insert into Reading_List (book_id, reader_id) values ('7282766280', 16);
insert into Reading_List (book_id, reader_id) values ('0393045218', 26);
insert into Reading_List (book_id, reader_id) values ('7282766280', 14);
insert into Reading_List (book_id, reader_id) values ('0987031924', 18);

