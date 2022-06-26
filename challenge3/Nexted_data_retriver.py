import json

with open('./challenge3/json_metadata_from_challenge2.txt') as m:
    j=json.load(m)
temp_dir={}

#a=j['meta-data']
#print(a)


def find_the_tree(object):
    
    for key, value in object.items():
        if isinstance(value,dict):
            find_the_tree(value)
        else:
            temp_dir[key] = value
    return temp_dir

object1 = '{"a":{"b":{"c":"d"}}}'
data=json.loads(object1)  
print(find_the_tree(j))

#def find_the_value(objct, key):
