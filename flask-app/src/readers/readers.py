from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


readers = Blueprint('readers', __name__)

@readers.route('/addReview', methods=['POST'])
def add_review():
    cursor = db.get_db().cursor()
    score = request.form['score']
    comments = request.form['comments']
    book_id = request.form['book_id']
    reader_id = request.form['reader_id']
    cursor.execute(f"""
    INSERT INTO Ratings
      (book_id, reader_id, score, comments)
    VALUES
      (\'{book_id}\', {reader_id}, {score}, \'{comments}\');
    """)
    the_response = make_response()
    the_response.status_code = 200
    return the_response

# Get all authors from the DB
# TODO: readingList endpoint here
@readers.route('/reading-list/<readerID>', methods=['GET'])
def get_readingList(readerID):
    reader_id = int(readerID)
    cursor = db.get_db().cursor()
    cursor.execute("""
        SELECT B.ISBN,
               B.title,
               B.year,
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
        where RL.reader_id = %s
""", (reader_id))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

