# Build API using Python Flask
![FlaskAPI](https://github.com/yogi0001122/python/blob/master/python-flask-app/FlaskAPI.PNG)

The following are needed to run PythonFlask API: 

### Prerequisites: 

- [Python](https://www.python.org/downloads/) (version 3.6)
- [pip](https://pip.pypa.io/en/stable/installing/)

- Install below Python's Libraries. Create requirements.txt file and should look similar to the one below:

         pandas
         flask-bcrypt
         Flask-SQLAlchemy
         flask-restplus
         Flask-Migrate
         Flask-Script
         flask_testing
         sqlalchemy-migrate==0.7.2
         psycopg2==2.8.5
         Werkzeug==0.16.1
 
- Run below mentioned command 
  
            pip install -r requirements.txt
            
            
### Test Flask API

  
         export DATABASE_URL="postgresql://user:password@IP:5432/flaskdb"
   
         ## Initiate a migration folder, Create a migration script and Apply the migration script to the database
   
         python manage.py db init
         python manage.py db migrate --message 'initial database migration'
         python manage.py db upgrade
   
         ## Now test application to see that everything is working fine
   
         python manage.py run


# How to Containerized Python Flask?

## Prerequisites

The following are needed to run flask api in docker container:

- [Docker](https://docs.docker.com/install/) (version 18.09)

### Run shell script install_docker.sh to install docker on your system

    bash install_docker.sh

### Build Docker image

    docker build -t flaskapp:1.0 .
    
### Provide Run time enviornment to Docker image

    ### Create .env file in API's home directory and paste DATABASE_URL="postgresql://user:password@IP:5432/flaskdb".

    docker run --env-file ./.env -p 5001:5001 -d flaskapp:1.0
