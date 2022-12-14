from flask import Blueprint, Response, request, jsonify, make_response, current_app
import json
from datetime import datetime

from src import db
from src.helpers.helpers import make_get_request


readers = Blueprint('readers', __name__)

# TODO: readingList endpoint here
@readers.route('/reading-list/<readerID>', methods=['GET'])
def get_readingList(readerID):
    reader_id = int(readerID)
    query = f"""
        SELECT B.ISBN,
               B.title as Title,
               B.year as Year,
               B.publisher_name as Publisher,
               CONCAT(A.firstName, ' ', A.lastName) as Author,
               (BB.book_id is not NULL) as 'Bought?',
                RA.score as Rating,
                RA.comments as Review
        FROM Reading_List as RL
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
               B.title as Title,
               B.year as Year,
               B.publisher_name as Publisher,
               CONCAT(A.firstName, ' ', A.lastName) as Author,
               (BB.date_bought IS NOT NULL) as 'Bought?',
               (RL.reader_id is NOT NULL) as 'Saved?',
               RA.score as Rating,
               RA.comments as Review
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
           B.title as Title,
           B.year as Year,
           B.publisher_name as Publisher,
           CONCAT(A.firstName, ' ', A.lastName) as Author,
           (BB.date_bought IS NOT NULL) as 'Bought?',
           (RL.reader_id is NOT NULL) as 'Saved?',
           RA.score as Rating,
           RA.comments as Review
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

@readers.route('/buy-or-sell', methods=['PUT'])
def buy_or_sell():
    cursor = db.get_db().cursor()
    reader_id = int(request.form['reader_id'])
    book_id = request.form['book_id']
    dt_now = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    current_app.logger.info(f"buy_or_sell({reader_id}, {book_id}) -> NONE")
    cursor.execute(f"""SELECT * FROM Books_Bought 
            where reader_id = {reader_id} and book_id = \"{book_id}\";
    """)
    buy_status = cursor.fetchall()
    current_app.logger.info(f"book is {buy_status}")
    if not(buy_status):
        cursor.execute(f"""
            INSERT INTO Books_Bought
              (book_id, reader_id, date_bought)
            VALUES
              (\"{book_id}\", {reader_id}, \"{dt_now}\");
        """)
    else:
        cursor.execute(f"""
            DELETE FROM Books_Bought 
            WHERE book_id = \"{book_id}\" and reader_id = {reader_id};
        """)
    db.get_db().commit()
    the_response = make_response()
    the_response.status_code = 200
    return the_response

@readers.route('/save-or-discard', methods=['PUT'])
def save_or_discard():
    cursor = db.get_db().cursor()
    reader_id = int(request.form['reader_id'])
    book_id = request.form['book_id']
    current_app.logger.info(f"save_or_discard({reader_id}, {book_id}) -> NONE")
    cursor.execute(f"""SELECT * FROM Reading_List 
            where reader_id = {reader_id} and book_id = \"{book_id}\";
    """)
    save_status = cursor.fetchall()
    current_app.logger.info(f"book is {save_status}")
    if not(save_status):
        cursor.execute(f"""
            INSERT INTO Reading_List
              (book_id, reader_id)
            VALUES
              (\"{book_id}\", {reader_id});
        """)
    else:
        cursor.execute(f"""
            DELETE FROM Reading_List 
            WHERE book_id = \"{book_id}\" and reader_id = {reader_id};
        """)
    db.get_db().commit()
    the_response = make_response()
    the_response.status_code = 200
    return the_response

