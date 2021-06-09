from .. import db

class User(db.Model):
    """ User Model for storing user related details """
    __tablename__ = "user_table"

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    email = db.Column(db.String(255), nullable=False)
    username = db.Column(db.String(50))

    def __repr__(self):
        return "<User: {}>".format(self.username)
