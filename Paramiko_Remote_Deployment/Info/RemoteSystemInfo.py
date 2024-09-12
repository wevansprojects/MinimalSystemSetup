#!/usr/bin/env python3

import yaml
import paramiko
import os
import time

user_folder_name = os.path.expanduser("~")
user = os.path.basename(user_folder_name)
home_path = os.path.join("/home/" + user)

config_file_path = os.path.join(home_path + "/Paramiko_Remote_Deployment/yaml/config.yaml")
script_ftp_file_path = os.path.join(home_path + "/Paramiko_Remote_Deployment/pyscript/")

with open(config_file_path) as yamlfile:
    data = yaml.load(yamlfile, Loader=yaml.FullLoader)
    username = data["user"]
    password = data["password"]
    privatekey = data["privatekey"]
    port = data["port"]
    serverstocheck = data["servers"]
yamlfile.close()

for server in serverstocheck:
    response = os.system(f"\nping -c2 {server} >/dev/null \n")

    if response == 0:
        status = server.rstrip() + " is Reachable\n"
        # print(status)

        client = paramiko.SSHClient()
        client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        # ssh_key = paramiko.RSAKey.from_private_key_file(privatekey, password)
        ssh_key = paramiko.ECDSAKey.from_private_key_file(privatekey, password)

        client.connect(server, port, username, pkey=ssh_key)

        ftp_client = client.open_sftp()
        ftp_client.put(script_ftp_file_path + "sysinfo.py", "/tmp/sysinfo.py")
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
        command = "sudo -S journalctl|tail -30"

        stdin, stdout, stderr = client.exec_command(command)
        stdin.write(password + "\n")
        print(stdout.read().decode("utf-8"))
        time.sleep(1)
        client.close()

    else:
        status = server + " is NOT Reachable"
        print(f"\nThe Server {server} did not ping it will be ignored\n")
# End of script
