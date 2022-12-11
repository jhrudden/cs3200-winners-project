# CS3200 Final Project Repo
This repo represents the backend codebase for the Fall 2022 final project of the CS3200 Class at Northeastern University,
written by Michael Huang, John Henry Rudden, and Andrew Yuan.\
Below, you can find out how to setup the project as well as a video highlighting the final application demo.

# Project Synposis
Our project is EZBooks, a service where readers, a group of literary curators, and book sellers can find, buy, and organize books all on one site. We maintain a database of many books, each with user ratings and comments, as well as lists of book recommendations organized by our curators.  
EZBooks has 3 main functions:
1. Readers can make lists of books they want to read, and add reviews for books they've read. They can also view a list of books suggested to them by curators.
1. Curators can add new books to the EZBooks database and recommend books to readers.
1. Sellers can submit new books to the EZBooks database and view trends in the popularity of certain books.

# Project Video Demo
Here is a link to a Youtube Video featuring a demo of our project's application.\
--> https://drive.google.com/file/d/18RvOoVwJoRziFIhAec7rmINdj-S5185J/view?ts=63965fbe <--

# Features
This repo contains 2 docker containers: 
1. A MySQL 8 container
1. A Python Flask container to implement a REST API  

Our API is exposed to the public internet via nGrok. An AppSmith Application connects to this API and contains the UI for our project.\
For more information about this process, please view our demo video above.

# Setup + Startup
To setup the backend code for EZBooks, add the following password files to /secrets/ and fill them with a password:
 - db_password.txt
 - db_root_password.txt

This application runs on Docker containers. Install docker desktop here: https://docs.docker.com/get-docker/

Once this setup is complete, run ```docker-compose up --build``` to build the docker containers. The current backend puts the main
application on port 8001 and the database on port 3200. Make sure to change these values if necessary. This can be done in the 
docker-compose.yml file.

To shutdown the containers, simply 'ctrl+c' the running process and run ```docker-compose down``` to delete the containers from
docker desktop.





