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
               CONCAT(S.firstName, ' ', S.lastName) as Seller,
               BS.date_added as Date,
               S.id
        FROM Books as B
        JOIN Authors A on B.writer_id = A.id
        JOIN Book_Submissions BS on B.isbn = BS.book_id 
        JOIN Sellers S on BS.seller_id = S.id
        where BS.accepted IS NULL
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


@curators.route('/decideBookSubmission', methods=['PUT'])
def make_book_decision():
    cursor = db.get_db().cursor()
    isbn = request.form['isbn']
    seller_id = request.form['seller_id']
    decision = int(request.form['decision'])
    cursor.execute(f"""
        REPLACE INTO Book_Submissions (book_id, seller_id, accepted)
        VALUES (\'{isbn}\', {seller_id}, {decision});
    """)
    if decision == 1:
      cursor.execute(f"""
          UPDATE Books as B SET B.visible = true WHERE B.ISBN = \'{isbn}\'
      """)
    db.get_db().commit()
    the_response = make_response()
    the_response.status_code = 200
    return the_response

@curators.route('/makeRecommendation', methods=['PUT'])
def make_recommendation():
    cursor = db.get_db().cursor()
    isbn = request.form['isbn']
    curator_id = request.form['curator_id']
    cursor.execute(f"""
          SELECT * FROM Recommendations WHERE book_id = \'{isbn}\' and curator_id = {curator_id}
    """)
    status = cursor.fetchall()
    if not(status):
      cursor.execute(f"""
          INSERT INTO Recommendations (book_id, curator_id)
          VALUES (\'{isbn}\', {curator_id});
      """)
    else:
      cursor.execute(f"""
          DELETE FROM Recommendations
          WHERE book_id = \'{isbn}\' and curator_id = {curator_id};
      """)
    db.get_db().commit()
    the_response = make_response()
    the_response.status_code = 200
    return the_response