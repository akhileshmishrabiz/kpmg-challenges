class ec2:
    import json
    import requests


    meta_data_url = 'http://169.254.169.254/latest/'

    ## below function will validate if input is a valid json or not
    def json_validator(self,json_input):
        try:
            ec2.json.loads(json_input)
        except ValueError:
            return False
        return True


    def walk_the_tree(self,url,arr):
        output={}
        
        for item in arr:
            updated_url= url+item
            response = ec2.requests.get(updated_url)
            text=response.text 
            if item[-1] == '/':
                next_level_items = text.splitlines()
                output[item[:-1]]= ec2.walk_the_tree(updated_url,next_level_items)
            elif ec2.json_validator(text):
                output[item] = ec2.json.loads(text)
            else:
                output[item] = text
        return output

            
                
    def meta_data(self):
        first_step=["meta-data/"]
        output=ec2.walk_the_tree(ec2.meta_data_url,first_step)
        return output

    def meta_data_json(self):
        non_json_metadata=ec2.meta_data()
        try:
            json_metadata=ec2.json.dumps(non_json_metadata, indent=2)
        except TypeError:
            return non_json_metadata
        return json_metadata

    ## Function to pull desired data only
    def desired_meta_date(self,desired_data):
        first_step=['meta-data/']
        desired_step=[first_step[0] + desired_data]
        output=ec2.walk_the_tree(ec2.meta_data_url,desired_step)
        return output




