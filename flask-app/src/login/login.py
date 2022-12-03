from flask import Blueprint, request, jsonify, make_response
import json
from src import db


login = Blueprint('login', __name__)

@login.route('/reader', methods=['GET'])
def get_user():
    cursor = db.get_db().cursor()
    email = request.args.get('email')
    cursor.execute(f'select id, firstName, lastName from Readers where email=\'{email}\'')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response