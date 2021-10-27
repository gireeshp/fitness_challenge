import os
import json

from appwrite.client import Client
from appwrite.services.database import Database

user_collection_id = "617497ffb09f7"

def init_client():
    # Initialize the Appwrite client
    client = Client()
    client.set_endpoint(os.getenv("APPWRITE_ENDPOINT"))
    client.set_project(os.getenv("APPWRITE_FUNCTION_PROJECT_ID"))
    client.set_key(os.getenv("APPWRITE_API_KEY"))

    return client

def main():
    print ("Inside 1")
    payload = json.loads(os.getenv("APPWRITE_FUNCTION_EVENT_DATA"))
    print ("Got payload")
    print (payload)

    userId = payload["$id"]
    print (userId)
    userName = payload["name"]
    print (userName)
    email = payload["email"]
    print (email)


    client = init_client()
    database = Database(client)
    print ("Client and DB created")

    database.create_document(user_collection_id, {'user_id': userId, 'user_name': userName, 'email': email})
    print ("Document created")

if __name__ == "__main__":
    main()
