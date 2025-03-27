## Description: your job is to create a class Dictionary which you can add words to and their entries

# class Dictionary:
#     def __init__(self):
#         self.dictionary = {}

#     def newentry(self, key, value):
#         self.dictionary[key] = value
#         return
    
#     def look(self, key_to_search):
#         for key in self.dictionary:
#             if key == key_to_search:
#                 return self.dictionary[key]
#         return f"Can't find entry for {key_to_search}"

# # Create an object 
# d = Dictionary()
# d.newentry('Apple', 'A fruit that grows on trees')
# print(d.look('Apple'))
# print(d.look('Banana'))

import json

class Dictionary:
    """A simple dictionary class to store and retrieve key-value pairs."""
    def __init__(self):
        """Initializes an empty dictionary."""
        self.dictionary = {}

    def newentry(self, key, value):
        """Adds a new entry to the dictionary."""
        self.dictionary[key] = value
    
    def look(self, key_to_search):
        """Searches for a key in the dictionary and returns its value or a default message."""
        return self.dictionary.get(key_to_search, f"Can't find entry for {key_to_search}")

def lambda_handler(event, context):
    print("Received event:", json.dumps(event, indent=2))  # Debugging log

    try:
        # Ensure the event has a body and parse JSON safely
        event_body = json.loads(event.get("body", "{}"))
    except json.JSONDecodeError:
        return {
            "statusCode": 400,
            "body": json.dumps({"message": "Invalid JSON format"})
        }

    dictionary = event_body.get("d", {})
    keys_to_lookup = event_body.get("l", [])

    # Ensure dictionary is actually a dictionary
    if not isinstance(dictionary, dict):
        return {
            "statusCode": 400,
            "body": json.dumps({"message": "Invalid dictionary format"})
        }

    # Ensure keys_to_lookup is a list
    if not isinstance(keys_to_lookup, list):
        return {
            "statusCode": 400,
            "body": json.dumps({"message": "Invalid lookup list format"})
        }

    # Initialize Dictionary and process entries
    d = Dictionary()
    for key, value in dictionary.items():
        d.newentry(key, value)

    # Lookup requested keys
    result = {item: d.look(item) for item in keys_to_lookup}

    return {
        "statusCode": 200,
        "body": json.dumps({
            "message": "Dictionary processed successfully",
            "results": result
        })
    }