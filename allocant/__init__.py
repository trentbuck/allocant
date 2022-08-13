import argparse
import datetime


import requests
import pypass


import requests.packages.urllib3.exceptions

# FIXME: the old server uses an in-house CA (not Let's Encrypt), and
#        the old server only supports TLS 1.1.
#        Tell requests it's OK to allow these things, until an automatic sunset of 1 Jan 2023.
if datetime.date.today() < datetime.date(year=2023, month=1, day=1):
    requests.packages.urllib3.disable_warnings(requests.packages.urllib3.exceptions.InsecureRequestWarning)


def main():
    parser = argparse.ArgumentParser()
    store = pypass.PasswordStore()
    parser.set_defaults(
        url='https://alloc-noauth.cyber.com.au/services/json.php',
        username=store.get_decrypted_password('work/alloc', entry=pypass.EntryType.username),
        password=store.get_decrypted_password('work/alloc', entry=pypass.EntryType.password),
    )
    del store
    args = parser.parse_args()

    resp = requests.get(
        args.url,
        data={'authenticate': True,
              'username': args.username,
              'password': args.password})
    resp.raise_for_status()
    print(resp.json())
