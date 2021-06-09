from flask import request
import pandas as pd
from flask_restplus import Resource,reqparse
import werkzeug
from werkzeug.datastructures import FileStorage

from ..util.dto import UserDto
from ..service.user_service import save_new_user, get_all_users, save_csvnew_user

api = UserDto.api
_user = UserDto.user

upload_parser = reqparse.RequestParser(bundle_errors=True)
upload_parser.add_argument(
        name="file",
        type=FileStorage,
        location="files",
        #action="append" # If this is removed it works with 1 file
    )

@api.route('/')
class UserList(Resource):
    @api.doc('list_of_registered_users')
    @api.marshal_list_with(_user, envelope='data')
    def get(self):
        """List all registered users"""
        return get_all_users()

    @api.response(201, 'User successfully created.')
    @api.doc('create a new user')
    @api.expect(_user, validate=True)
    def post(self):
        """Creates a new User """
        data = request.json
        return save_new_user(data=data)

@api.route('/file')
#@api.response(201, 'User successfully created.')
@api.response(404, 'File not found.')
class UploadCSV(Resource):
    @api.doc('upload csv file to create a new user')
    @api.response(201, 'User successfully created.')
    @api.expect(upload_parser)
    def post(self):
       """upload csv file to create a new user"""
       args = upload_parser.parse_args()
       #file = request.files['file']
       file = args['file']
       data = pd.read_csv(file, names=['username','email'], header=None)
       print (data)
       return save_csvnew_user(data=data)
