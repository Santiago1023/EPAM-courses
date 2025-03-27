## Description: Given a dictionary of items and their costs and an array specifying the items bought, calculate the total cost of the items plus a given tax
def get_total(costs, items, tax):
    total = 0
    for item in items:
        total += costs[item]
    total += (tax*total)
    return total

costs = {'socks': 5, 'shoes': 60, 'sweater': 30}
print(get_total(costs, ['socks', 'shoes'], 0.09))


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

    costs = event_body.get("costs", {})
    items = event_body.get("items", [])
    tax = event_body.get("tax", 0)

    # Ensure costs is a dictionary
    if not isinstance(costs, dict):
        return {
            "statusCode": 400,
            "body": json.dumps({"message": "Invalid cost data format"})
        }

    # Ensure items is a list
    if not isinstance(items, list):
        return {
            "statusCode": 400,
            "body": json.dumps({"message": "Invalid items list format"})
        }

    # Ensure tax is a valid number
    if not isinstance(tax, (int, float)):
        return {
            "statusCode": 400,
            "body": json.dumps({"message": "Invalid tax format"})
        }

    # Calculate total cost
    total = 0
    missing_items = []
    for item in items:
        if item in costs:
            total += costs[item]
        else:
            missing_items.append(item)

    total += (tax * total)

    return {
        "statusCode": 200,
        "body": json.dumps({
            "message": "Cost calculation successful",
            "total": total,
            "missing_items": missing_items
        })
    }


# {
#     "costs": {"socks": 5, "shoes": 60, "sweater": 30},
#     "items": ["socks", "shoes", "hola"],
#     "tax": 0.09
# }