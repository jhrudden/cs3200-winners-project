from flask import Blueprint, request, jsonify, make_response
import json
from src import db


readingList = Blueprint('readingList', __name__)

# Get the readinglist table from the DB
# need book isbn title author(name) year
# need reader userid bought(?)
@readingList.route('/readingList', methods=['GET'])
def get_readingList():
    cursor = db.get_db().cursor()
    cursor.execute("""
        SELECT b.ISBN, b.title, b.year, a.firstName as AuthorFirstName, 
        rl.reader_id, r.firstName as ReaderFirstName
        FROM Books as b JOIN Authors as a ON b.writer_id=a.id
        JOIN Reading_List as rl ON rl.book_id=b.ISBN
        JOIN Readers as r ON rl.reader_id=r.id
        """)
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response
