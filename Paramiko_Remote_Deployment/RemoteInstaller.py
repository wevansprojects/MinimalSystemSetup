#!/usr/bin/env python3

import yaml
import paramiko
import os
import time

from pyscript.sysinfo import system_info

with open("yaml/config.yaml") as yamlfile:
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

        ftp_client = client.open_sftp()
        ftp_client.put("pyscript/install.sh", "/tmp/install.sh")
        ftp_client.close()

        # Set Script Permissions
        command = "sudo -S chmod u+x /tmp/install.sh"
        stdin, stdout, stderr = client.exec_command(command)
        stdin.write(password + "\n")
        print(stdout.read().decode("utf-8"))


        print(":=============:")
        print("Script Details:")
        print(":=============:")
        print("------------------------------------------------")
        # Run Scripts
        command = "sudo -S /tmp/./install.sh"
        stdin, stdout, stderr = client.exec_command(command)
        stdin.write(password + "\n")
        print(stdout.read().decode("utf-8"))

        stdin, stdout, stderr = client.exec_command("rm /tmp/install.sh")
        print(stdout.read().decode("utf-8"))

        print(":================:")
        print("System Log Output:")
        print(":================:")
        print("------------------------------------------------")
        #command = "sudo -S cat /var/log/dnf.log|grep 'DDEBUG Command\|\INFO Complete!\|INFO Package'|tail -10"
        command = "sudo -S journalctl |tail -10"
        stdin, stdout, stderr = client.exec_command(command)
        stdin.write(password + "\n")
        print(stdout.read().decode("utf-8"))
        time.sleep(1)
        client.close()

    else:
        status = server + " is NOT Reachable"
        # print(status)
        print(f"\nThe Server {server} did not ping it will be ignored\n")
# End of script
