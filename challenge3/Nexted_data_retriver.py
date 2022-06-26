import json

temp_dir={}

# this fucntion will return a dir of simple key pairs inside a json file
def find_the_simple_dict(object):
    
    for key, value in object.items():
        if isinstance(value,dict):
            temp_dir[key] = value
            find_the_simple_dict(value)
        else:
            temp_dir[key] = value
    return temp_dir
#This function will dig out deeply  which have single value hidden inside
def nest_object_value(object):

    for key, value in object.items():
        if isinstance(value,dict):
            return nest_object_value(value)
            
        else:
            return value



def find_the_key_value(object, key):
    key_pair_dict=find_the_simple_dict(object)
    if isinstance(key_pair_dict[key], dict ):
        return nest_object_value(key_pair_dict[key])

    else:
        return key_pair_dict[key] 


'''
object1 = '{"a":{"b":{"c":"d"}}}'
data=json.loads(object1)  
print(find_the_key_value(j, 'public-hostname'))
'''



##======================================================
object1 = '{"a":{"b":{"c":"d"}}}'
data1=json.loads(object1)

key10='a'
key11='b'
key12='c'

object2 = '{"x":{"y":{"z":"a"}}}'
data2=json.loads(object2)
key20='x'
key21='y'
key22='z'




#use case using first set of data
usecase_10=find_the_key_value(data1,key10)
usecase_11=find_the_key_value(data1,key11)
usecase_12=find_the_key_value(data1,key12)
#use case using second set of data
usecase_20=find_the_key_value(data2,key20)
usecase_21=find_the_key_value(data2,key21)
usecase_22=find_the_key_value(data2,key22)

print(f'--> using {object1} with key {key10} ==> function will return {usecase_10}')
print(f'--> using {object1} with key {key11} ==> function will return {usecase_11}')
print(f'--> using {object1} with key {key12} ==> function will return {usecase_12}')
print(f'--> using {object2} with key {key20} ==> function will return {usecase_20}')
print(f'--> using {object2} with key {key21} ==> function will return {usecase_21}')
print(f'--> using {object2} with key {key22} ==> function will return {usecase_22}')


#=============
with open('./challenge3/json_metadata_from_challenge2.txt') as m:
    j=json.load(m)
