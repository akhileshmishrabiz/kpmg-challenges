import ec2_class

ec2=ec2_class.ec2()
print(ec2.meta_data())
#print(ec2.meta_data_json())

# code allows for a particular data key to be retrieved individually
    #I have made it interactive 
'''
key=''
while key != 'exit':
    print("To exit the prog, type 'exit' ")
    key=input("Which meta-data you want to pull \n -> ")
    valid_inputs=['ami-id', 'ami-launch-index', 'ami-manifest-path', 'block-device-mapping/', 'events/', 'hostname', 'identity-credentials/', 'instance-action', 'instance-id', 'instance-life-cycle', 'instance-type', 'local-hostname', 'local-ipv4', 'mac', 'metrics/', 'network/', 'placement/', 'profile', 'public-hostname', 'public-ipv4', 'public-keys/', 'reservation-id', 'security-groups']
        
    if key in valid_inputs:
        print(f'  {ec2.desired_meta_date(key)}  \n')
    else:
        print("Please input correct value ")
'''