from flask import Blueprint, Response, request, jsonify, make_response, current_app
import json
from src import db
from src.helpers.helpers import make_get_request


readers = Blueprint('readers', __name__)

# TODO: readingList endpoint here
@readers.route('/reading-list/<readerID>', methods=['GET'])
def get_readingList(readerID):
    reader_id = int(readerID)
    query = f"""
        SELECT B.ISBN,
               B.title,
               B.year,
               B.publisher_name as Publisher,
               CONCAT(A.firstName, ' ', A.lastName) as authorName,
               RL.reader_id,
               CONCAT(R.firstName, ' ', R.lastName) as readerName,
               (BB.book_id is not NULL) as 'bought?',
                RA.score,
                RA.comments
        FROM Reading_List as RL
        JOIN Readers R on R.id = RL.reader_id
        JOIN Books B on RL.book_id = B.ISBN
        JOIN Authors A on B.writer_id = A.id
        LEFT OUTER JOIN Ratings as RA on RA.book_id = RL.book_id and RA.reader_id = RL.reader_id
        LEFT OUTER JOIN Books_Bought BB on RL.reader_id = BB.reader_id and BB.book_id = RL.book_id
        where RL.reader_id = {reader_id}
    """
    return make_get_request(query)

@readers.route('/book-list/<readerID>', methods=['GET'])
def get_book_list(readerID):
    reader_id = int(readerID)
    query = f"""
        SELECT B.ISBN,
               B.title,
               B.year,
               B.publisher_name as Publisher,
               CONCAT(A.firstName, ' ', A.lastName) as authorName,
               (BB.date_bought IS NOT NULL) as 'bought?',
               (RL.reader_id is NOT NULL) as 'saved?',
               RA.score as review
        FROM Books B
        LEFT OUTER JOIN (SELECT * FROM Reading_List where reader_id = {reader_id}) as RL
            on RL.book_id = B.ISBN
        LEFT OUTER JOIN (SELECT * FROM Books_Bought where reader_id = {reader_id}) as BB
            on BB.book_id = B.ISBN
        LEFT OUTER JOIN (SELECT * FROM Ratings where reader_id = {reader_id}) as RA
            on RA.book_id = B.ISBN
        JOIN Authors A on A.id = B.writer_id
        where B.visible = true;
    """
    return make_get_request(query)

# TODO: maybe need to take in curator id too
@readers.route('/recommendations/<readerID>', methods=['GET'])
def get_recommendations(readerID):
    reader_id = int(readerID)
    query = f"""
        SELECT 
           DISTINCT (B.ISBN),
           B.title,
           B.year,
           B.publisher_name as Publisher,
           CONCAT(A.firstName, ' ', A.lastName) as authorName,
           (BB.date_bought IS NOT NULL) as 'bought?',
           (RL.reader_id is NOT NULL) as 'saved?',
           RA.score as review
        FROM Recommendations Rec
        Join Books B on Rec.book_id = B.ISBN
        LEFT OUTER JOIN (SELECT * FROM Reading_List where reader_id = {reader_id}) as RL
            on RL.book_id = B.ISBN
        LEFT OUTER JOIN (SELECT * FROM Books_Bought where reader_id = {reader_id}) as BB
            on BB.book_id = B.ISBN
        LEFT OUTER JOIN (SELECT * FROM Ratings where reader_id = {reader_id}) as RA
            on RA.book_id = B.ISBN
        JOIN Authors A on A.id = B.writer_id;
    """
    return make_get_request(query)

@readers.route('/addReview', methods=['POST'])
def add_review():
    cursor = db.get_db().cursor()
    score = request.form['score']
    comments = request.form['comments']
    book_id = request.form['book_id']
    reader_id = request.form['reader_id']
    cursor.execute(f"""
    REPLACE INTO Ratings
      (book_id, reader_id, score, comments)
    VALUES
      (\"{book_id}\", {reader_id}, {score}, \"{comments}\");
    """)
    db.get_db().commit()
    the_response = make_response()
    the_response.status_code = 200
    return the_response

@readers.route('/buy-or-sell', methods=['POST'])
def buy_or_sell():
    cursor = db.get_db().cursor()
    reader_id = int(request.form['reader_id'])
    book_id = request.form['book_id']
    buy_status = cursor.execute(f"""SELECT * FROM Books_Bought 
            where reader_id = {reader_id} and book_id = {book_id};
    """).fetchall()
    if len(buy_status):
        cursor.execute(f"""
        INSERT INTO Books_Bought
          (book_id, reader_id)
        VALUES
          (\"{book_id}\", {reader_id});
        """)
    else:
        cursor.execute(f""" DELETE FROM Books_Bought 
                WHERE book_id = {book_id} and reader_id = {reader_id};
        """)
    db.get_db().commit()
    the_response = make_response()
    the_response.status_code = 200
    return the_response

