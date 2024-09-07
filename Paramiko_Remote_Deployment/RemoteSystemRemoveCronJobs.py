#!/usr/bin/env python3

import yaml
import paramiko
import os
import time


with open("yaml/config.yaml") as yamlfile:
    # with open("yaml/cloudconfig.yml") as yamlfile:
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

        stdin, stdout, stderr = client.exec_command(
            "echo 'Running on Server:' $(hostname)"
        )
        print(stdout.read().decode("utf-8"))

        ftp_client = client.open_sftp()
        ftp_client.put("pyscript/removecronjobs.sh", "/tmp/removecronjobs.sh")
        ftp_client.close()

        ftp_client = client.open_sftp()
        ftp_client.put("pyscript/sysinfo.py", "/tmp/sysinfo.py")
        ftp_client.close()

        print("System Details:")

        print("\n")

        print("System Info:")
        stdin, stdout, stderr = client.exec_command("python3 /tmp/sysinfo.py")
        print(stdout.read().decode("utf-8"))
        stdin, stdout, stderr = client.exec_command("rm /tmp/sysinfo.py")
        print(stdout.read().decode("utf-8"))

        print("\n")
        print("Script Output:")
        print("Removing Cron Tasks")

        command = "sudo -S chmod u+x /tmp/removecronjobs.sh"
        stdin, stdout, stderr = client.exec_command(command)
        stdin.write(password + "\n")
        print(stdout.read().decode("utf-8"))

        # Run Scripts

        command = "sudo -S /tmp/./removecronjobs.sh"
        stdin, stdout, stderr = client.exec_command(command)
        stdin.write(password + "\n")
        print(stdout.read().decode("utf-8"))

        stdin, stdout, stderr = client.exec_command("rm /tmp/*.sh")
        print(stdout.read().decode("utf-8"))
        print("Cron Tasks Removed")
        print("\n")

        print("System Log Output:")
        print("\n")
        command = "sudo -S cat /var/log/apt/term.log|tail -10"
        # command = "sudo -S journalctl |tail -10"

        # command = "sudo -S cat /var/log/dnf.log|grep 'DDEBUG Command\|\INFO Complete!\|INFO Package'|tail -10"
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
