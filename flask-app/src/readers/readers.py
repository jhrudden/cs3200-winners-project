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
@readers.route('/readingList', methods=['GET'])
def get_authors():
    cursor = db.get_db().cursor()
    cursor.execute('select id, firstName, lastName from Authors')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response
    # return f'<h1>Getting all the authors.</h1>'