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
    payload = json.loads(os.getenv("APPWRITE_FUNCTION_EVENT_DATA"))

    userId = payload["$id"]
    userName = payload["name"]
    email = payload["email"]


    client = init_client()
    database = Database(client)

    database.create_document(user_collection_id, {'user_id': userId, 'user_name': userName, 'email': email})

if __name__ == "__main__":
    main()
