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
--> [link] <--

# Features
This repo contains 2 docker containers: 
1. A MySQL 8 container
1. A Python Flask container to implement a REST API  

Our API is exposed to the public internet via nGrok. A AppSmith Application connects to this API and forms a UI for our project.\
For more information about this process, please view our demo video above.




