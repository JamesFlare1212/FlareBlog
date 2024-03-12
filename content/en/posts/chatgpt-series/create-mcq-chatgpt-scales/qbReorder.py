import json
from collections import OrderedDict

# Open the JSON file and load the data as a list of dictionaries
with open('data.json', 'r') as f:
    data = json.load(f)

# Create an ordered dictionary to store the objects by their order_number
data_dict = OrderedDict()
for obj in data:
    if 'order_number' in obj:
        order_number = obj['order_number']
        if order_number in data_dict:
            data_dict[order_number].append(obj)
        else:
            data_dict[order_number] = [obj]

# Create a new list of dictionaries with the objects ordered by their order_number
data_sorted = []
for order_number, objs in data_dict.items():
    for i, obj in enumerate(objs):
        obj['order_number'] = str(len(data_sorted) + i + 1)
    data_sorted.extend(objs)

# Write the modified list of dictionaries back to the JSON file
with open('question_bank.json', 'w') as f:
    json.dump(data_sorted, f, indent=2)