## Description: you must concatenate the n th letter from each word given in a list

def new_word(items):
    n = len(items)
    string = ""
    for index, item in enumerate(items):
        string += item[index]
    return string

print(new_word(["yoda", "best", "has"]))


import json

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

    items = event_body.get("items", [])

    # Ensure items is a list
    if not isinstance(items, list):
        return {
            "statusCode": 400,
            "body": json.dumps({"message": "Invalid items list format"})
        }

    result_string = ""
    
    for index, item in enumerate(items):
        if len(item) > index:  # Check if index is within bounds
            result_string += item[index]
        else:
            return {
                "statusCode": 400,
                "body": json.dumps({"message": f"Word '{item}' is too short for index {index}"})
            }

    return {
        "statusCode": 200,
        "body": json.dumps({
            "message": "String construction successful",
            "string": result_string,
        })
    }

# {
#     "items": ["yoda", "best", "has"]
# }