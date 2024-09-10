#!/usr/bin/env python3

# Once the above commands have been run and the repo cloned
# All other scripts should work as intended.

# Import The Libaries we need
# yaml - from pyYAML Python Package to use yaml files
# paramiko - is our ssh libary for python
# os - is so we can run some bash commands like ping to test server access
# time - because of annoying paramiko error which requires us to put in a timer

import yaml
import paramiko
import os
import time

# Here we open a yaml file called config.yaml
# we extract the relevant title from our yaml dictionary object
# we assign the relevant title to a variable to use in the paramiko section
with open("yaml/config.yaml") as yamlfile:
#with open("yaml/config.yml") as yamlfile:
    data = yaml.load(yamlfile, Loader=yaml.FullLoader)
    username = data["user"]
    password = data["password"]
    privatekey = data["privatekey"]
    port = data["port"]
    serverstocheck = data["servers"]
yamlfile.close()

# Now we have our information from the yaml file
# we should try some simple error handling to check if we
# can ping the server to make sure its accessible
# We'll need to run a for loop to loop through all of the collected server ip's
for server in serverstocheck:
    # This command will ping our server the >/dev/null will ignore output
    # so we can replace it with our own printed message
    response = os.system(f"\nping -c2 {server} >/dev/null \n")

    # This if statement checks the ping response
    # The statement prints out if the IP address is reachable
    # If the IP Address is reachable then we can run our paramiko script
    if response == 0:
        status = server.rstrip() + " is Reachable\n"
        # print(status)

        # Here we can finally run the paramiko library with the collected
        # yaml data on the server we confirmed is now reachable
        client = paramiko.SSHClient()
        client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        # ssh_key = paramiko.RSAKey.from_private_key_file(privatekey, password)
        ssh_key = paramiko.ECDSAKey.from_private_key_file(privatekey, password)

        client.connect(server, port, username, pkey=ssh_key)

        ftp_client = client.open_sftp()
        ftp_client.put("pyscript/sysinfo.py", "/tmp/sysinfo.py")
        ftp_client.close()

        print(":=============:")
        print("System Details:")
        print(":=============:")
        print("------------------------------------------------")
        stdin, stdout, stderr = client.exec_command("python3 /tmp/sysinfo.py")
        print(stdout.read().decode("utf-8"))
        stdin, stdout, stderr = client.exec_command("rm /tmp/sysinfo.py")
        print(stdout.read().decode("utf-8"))

        print(":=============:")
        print("Script Details:")
        print(":=============:")
        print("------------------------------------------------")
        print("N/A")
        print("\n")
        print(":================:")
        print("System Log Output:")
        print(":================:")
        print("------------------------------------------------")
        #command = "sudo -S journalctl|tail -30"
        #command = "sudo -S cat /var/log/dnf.log|grep 'dnf install\|\dnf erase\|Cleaning up'|tail -10"
        command = "sudo -S cat /var/log/dnf.log|grep 'dnf install\|\dnf erase'|tail -10"

        stdin, stdout, stderr = client.exec_command(command)
        stdin.write(password + "\n")
        print(stdout.read().decode("utf-8"))

        command = "sudo -S grep 'installed' /var/log/dpkg.log|grep -v 'half'|tail -10"
        stdin, stdout, stderr = client.exec_command(command)
        stdin.write(password + "\n")
        print(stdout.read().decode("utf-8"))

        time.sleep(1)
        client.close()

    else:
        status = server + " is NOT Reachable"
        print(f"\nThe Server {server} did not ping it will be ignored\n")
# End of script
