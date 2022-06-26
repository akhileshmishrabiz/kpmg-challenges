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

# this function will take object and key and will provide the output
def find_the_key_value(object, key):
    object
    key_pair_dict=find_the_simple_dict(object)
    if isinstance(key_pair_dict[key], dict ):
        return nest_object_value(key_pair_dict[key])
    else:
        return key_pair_dict[key] 

###############################################################################
#use case from challenge examples 
object1 = {"a":{"b":{"c":"d"}}}

key10='a'
key11='b'
key12='c'

object2 = {"x":{"y":{"z":"a"}}}
key20='x'
key21='y'
key22='z'

#use case using first set of data
usecase_10=find_the_key_value(object1,key10)
usecase_11=find_the_key_value(object1,key11)
usecase_12=find_the_key_value(object1,key12)
#use case using second set of data
usecase_20=find_the_key_value(object2,key20)
usecase_21=find_the_key_value(object2,key21)
usecase_22=find_the_key_value(object2,key22)

print(f'--> using object {object1} with key {key10} ==> function will return {usecase_10}')
print(f'--> using object {object1} with key {key11} ==> function will return {usecase_11}')
print(f'--> using object {object1} with key {key12} ==> function will return {usecase_12}')
print(f'--> using object {object2} with key {key20} ==> function will return {usecase_20}')
print(f'--> using object {object2} with key {key21} ==> function will return {usecase_21}')
print(f'--> using object {object2} with key {key22} ==> function will return {usecase_22}')

############################################################################################################# 

## We will use json metadat from ec2 to test our code 
with open('./challenge3/json_metadata_from_challenge2.txt') as m:
    ec2_metadata_json_object=json.load(m)

public_hostname = find_the_key_value(ec2_metadata_json_object, 'public-hostname')
local_ipv4 = find_the_key_value(ec2_metadata_json_object, 'local-ipv4')
Instance_type = find_the_key_value(ec2_metadata_json_object, 'instance-type')
Interface_id = find_the_key_value(ec2_metadata_json_object, 'interface-id')
availability_zone = find_the_key_value(ec2_metadata_json_object, 'availability-zone')
Public_ip = find_the_key_value(ec2_metadata_json_object, 'public-ipv4')

print(f'Ec2 hostname is --> {public_hostname}')
print(f'Ec2 Private Ip  is --> {local_ipv4}')
print(f'Ec2 Public IP is --> {Public_ip}')
print(f'Ec2 Instance type  is --> {Instance_type}')
print(f'Ec2 AZ is --> {availability_zone}')
print(f'Ec2 Nic Id is --> {Interface_id}')

######################################################################################