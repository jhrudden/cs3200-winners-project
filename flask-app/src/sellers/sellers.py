from flask import Blueprint, Response, request, jsonify, make_response, current_app
import json
from src import db
from src.helpers.helpers import make_get_request, check_if_exists

sellers = Blueprint('sellers', __name__)


@sellers.route('/getBookSubmissions/<sellerID>', methods=['GET'])
def getBookSubmissions(sellerID):
    seller_id = int(sellerID)
    query = f"""
        SELECT B.ISBN,
               B.title,
               B.year,
               B.publisher_name as Publisher,
               CONCAT(A.firstName, ' ', A.lastName) as authorName,
               BS.accepted
        FROM Books as B
        JOIN Authors A on B.writer_id = A.id
        JOIN Book_Submissions BS on B.isbn = BS.book_id 
        where BS.seller_id = {seller_id}
    """
    return make_get_request(query)

@sellers.route('/getRecentlyBought', methods=['GET'])
def getRecentlyBought():
    query = f"""
        SELECT
          CONCAT(R.firstName, ' ', R.lastName) as Reader,
          B.ISBN,
          B.title as Title,
          B.year as Year,
          B.publisher_name as Publisher,
          CONCAT(A.firstName, ' ', A.lastName) as Author,
          BB.date_bought as 'Date Bought'
        FROM Books_Bought as BB
        JOIN Books B on B.ISBN = BB.book_id
        JOIN Readers R on R.id = BB.reader_id
        JOIN Authors A on B.writer_id = A.id
        JOIN Genre G on B.genre_id = G.id
        ORDER BY BB.date_bought DESC
    """
    return make_get_request(query)


@sellers.route('/addBook', methods=['POST'])
def add_book():
    cursor = db.get_db().cursor()
    isbn = request.form['isbn']
    title = request.form['title']
    year = request.form['year']
    authFName = request.form['authFName']
    authLName = request.form['authLName']
    genre = request.form['genre']
    publisher = request.form['publisher']
    seller_id = request.form['seller_id']
    genreQuery = f'SELECT * FROM Genre WHERE name = \'{genre}\';'
    genreId = check_if_exists(genreQuery, 'id')
    authorQuery = f'SELECT * FROM Authors WHERE firstName = \'{authFName}\' and lastName = \'{authLName}\';'
    writerId = check_if_exists(authorQuery, 'id')
    if genreId is None:
        cursor.execute(f'INSERT INTO Genre (name) VALUES (\'{genre}\');')
        genreId = check_if_exists(genreQuery, 'id') # lazy coding lol
    if writerId is None:
        cursor.execute(f'INSERT INTO Authors (firstName, lastName) VALUES (\'{authFName}\', \'{authLName}\');')
        writerId = check_if_exists(authorQuery, 'id')
    cursor.execute(f"""
        INSERT INTO Books
          (ISBN, year, writer_id, title, publisher_name, genre_id, visible)
        VALUES
          (\'{isbn}\', {year}, {writerId}, \'{title}\', \'{publisher}\', {genreId}, false);
    """)
    cursor.execute(f"""
        INSERT INTO Book_Submissions (book_id, seller_id, accepted)
        VALUES (\'{isbn}\', {seller_id}, false);
    """)
    db.get_db().commit()
    the_response = make_response()
    the_response.status_code = 200
    return the_response

