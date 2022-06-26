import ec2_class
import sys
ec2=ec2_class.ec2()

#This code will help user interact with this prog more effectively
#to use this script, use python3 metadata.py <argument >
# valid options are , json, and metadata variable in ec2 , or you can use --help for more infor
#  python3 metadata.py --help
# for pulling ec2 metadata in form of json use 
# python3 metadata.py json
#to get specific data use it as below
# python3 metadata.py public-hostname

valid_inputs=['ami-id', 'ami-launch-index', 'ami-manifest-path', 'block-device-mapping/', 'events/', 'hostname', 'identity-credentials/', 'instance-action', 'instance-id', 'instance-life-cycle', 'instance-type', 'local-hostname', 'local-ipv4', 'mac', 'metrics/', 'network/', 'placement/', 'profile', 'public-hostname', 'public-ipv4', 'public-keys/', 'reservation-id', 'security-groups']
help_content= "-- Valid Arguments -- \n\n json  -It will give ec2 metadata in json format. \n\n Or Use specific keyword to get any specific ec2 metadata \n"
try:
    if sys.argv[1]:
        if sys.argv[1] == "json":
            print(print(ec2.meta_data_json()))
        elif sys.argv[1] in valid_inputs:
            print(ec2.desired_meta_date(sys.argv[1]))
        elif sys.argv[1] == "--help":
            print(help_content)
            list=[print(i+'\n') for i in valid_inputs ]

        else:
            print("asd")
    else:
        print("provide a argument")
except IndexError:
    print('Provide an argument \n use "--help" for more info')