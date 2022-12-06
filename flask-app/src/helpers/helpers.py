from flask import request, jsonify, make_response, Response, current_app
import json
from src import db

def make_get_request(query: str) -> Response:
    cursor = db.get_db().cursor()
    cursor.execute(query)
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

def check_if_exists(query: str, idKey: str) -> str or None:
    # check if query returns something. Note, this function was made so that it also returns the first
    # value of a given expected key in the query response. It can be used more generally, but you'd need to fill
    # the idKey w/ the a valid key + check for a str return vs None
    cursor = db.get_db().cursor()
    cursor.execute(query)
    row_headers = [x[0] for x in cursor.description]
    resultData = cursor.fetchall()
    if len(resultData):
        resultDict = dict(zip(row_headers, resultData[0]))
        return resultDict[idKey]
    return None