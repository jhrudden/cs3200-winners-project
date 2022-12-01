from flask import Blueprint, request, jsonify, make_response
import json
from src import db


authors = Blueprint('authors', __name__)

# Get all authors from the DB
@authors.route('/authors', methods=['GET'])
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