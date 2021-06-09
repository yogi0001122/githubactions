import uuid
import datetime

from app.main import db
from app.main.model.user import User


def save_new_user(data):
    user = User.query.filter_by(email=data['email']).first()
    if not user:
        new_user = User(
        email=data['email'],
        username=data['username'],
        )
        (response_object, response_code) = save_changes(new_user)
        return response_object, response_code 
    else:
        response_object = {
            'status': 'fail',
            'message': 'User already exists',
        }
        return response_object, 409 

def save_csvnew_user(data):
    for key,data in data.iterrows():
         new_user = User(
         email=data['email'],
         username=data['username'],
         )
         (response_object, response_code) = save_changes(new_user)

    return response_object, response_code 


def get_all_users():
    return User.query.all()

def save_changes(data):
    try:
        db.session.add(data)
        db.session.commit()
        response_object = {
            'status': 'success',
            'message': 'Successfully registered.'
        }
        return response_object, 201
    except:
        response_object = {
            'status': 'fail',
            'message': 'User already exists.',
        }
        return response_object, 409 
