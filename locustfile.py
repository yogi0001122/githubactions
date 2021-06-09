from locust import HttpUser, task, between
import random
import json
from uuid import uuid4
import uuid


class QuickstartUser(HttpUser):
    wait_time = between(5, 9)

    def my_random_string(string_length=10):
        """Returns a random string of length string_length."""
        random = str(uuid.uuid4()) # Convert UUID format to a Python string.
        random = random.upper() # Make all characters uppercase.
        random = random.replace("-","") # Remove the UUID '-'.
        return random[0:string_length] # Return the random string.

    @task(1)
    def create_post(self):
        def my_random_string(string_length=10):
            random = str(uuid.uuid4())
            random = random.upper()
            random = random.replace("-","")
            return random[0:string_length]
        #id = 1
        while True:
           value = [id,id]
           value = my_random_string(10)
           values = [value,value]
           payload = '''{
              "email": "yogichauhan%s@gmail.xom",
              "username": "yogichauhan%s"
              }''' % tuple (values)
           headers = {'content-type': 'application/json'}
           self.client.post("/user/",data=payload,
           headers=headers,
           name = "Create a new user")
           #id = id + 1

    def on_start(self):
        pass
