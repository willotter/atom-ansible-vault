#!/usr/bin/python
from ansible.utils.vault import VaultLib
import fileinput
from sys import argv


data = open(argv[2], 'rb').read()

vl = VaultLib(argv[1])

decrypted_data = vl.decrypt(data)
print(decrypted_data)
