from flask import Blueprint, Response, request, jsonify, make_response, current_app
import json
from src import db
from src.helpers.helpers import make_get_request, check_if_exists

curators = Blueprint('curators', __name__)


@curators.route('/getBookSubmissions', methods=['GET'])
def getBookSubmissions():
    query = f"""
        SELECT B.ISBN,
               B.title as Title,
               B.year as Year,
               B.publisher_name as Publisher,
               CONCAT(A.firstName, ' ', A.lastName) as Author,
               BS.seller_id
        FROM Books as B
        JOIN Authors A on B.writer_id = A.id
        JOIN Book_Submissions BS on B.isbn = BS.book_id 
        where BS.accepted = false
    """
    return make_get_request(query)

@curators.route('/getBookList/<curatorID>', methods=['GET'])
def get_book_list(curatorID):
    curator_id = int(curatorID)
    query = f"""
        SELECT B.ISBN,
               B.title as Title,
               B.year as Year,
               B.publisher_name as Publisher,
               CONCAT(A.firstName, ' ', A.lastName) as Author,
               (R.curator_id IS NOT NULL) as 'Recommended?'
        FROM Books B
        LEFT OUTER JOIN (SELECT * FROM Recommendations where curator_id = {curator_id}) as R
            on R.book_id = B.ISBN
        JOIN Authors A on A.id = B.writer_id
        where B.visible = true;
    """
    return make_get_request(query)


@curators.route('/acceptBookSubmission', methods=['PUT'])
def add_book():
    cursor = db.get_db().cursor()
    isbn = request.form['isbn']
    seller_id = request.form['seller_id']
    cursor.execute(f"""
        REPLACE INTO Book_Submissions (book_id, seller_id, accepted)
        VALUES (\'{isbn}\', {seller_id}, true);
    """)
    cursor.execute(f"""
        UPDATE Books as B SET B.visible = true WHERE B.ISBN = {isbn}
    """)
    db.get_db().commit()
    the_response = make_response()
    the_response.status_code = 200
    return the_response