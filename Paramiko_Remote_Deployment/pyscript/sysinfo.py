#!/usr/bin/env python3
# import subprocess
from subprocess import check_output, STDOUT
import subprocess

# Extracting Command Output into a variable to be printed out with Text


def system_info():
    command1 = ["hostname"]
    output1 = check_output(command1, stderr=STDOUT).decode()
    print("Server:         " + output1.rstrip())
    command2 = ["uname", "-r"]
    output2 = check_output(command2, stderr=STDOUT).decode()
    print("Kernel:         " + output2.rstrip())
    command3 = ["uname", "-i"]
    output3 = check_output(command3, stderr=STDOUT).decode()
    print("System:         " + output3.rstrip())
    command4 = ["uname", "-o"]
    output4 = check_output(command4, stderr=STDOUT).decode()
    print("OS:             " + output4.rstrip())
    command5 = ["hostname", "-I"]
    output = check_output(command5, stderr=STDOUT).decode()
    print("Local IP:       " + output.rstrip())

    time_process = subprocess.Popen(["timedatectl"], stdout=subprocess.PIPE, text=True)
    grep_process = subprocess.Popen(
        ["grep", "Local time"],
        stdin=time_process.stdout,
        stdout=subprocess.PIPE,
        text=True,
    )
    awk_process = subprocess.Popen(
        ["awk", "{print $5,$6}"],
        stdin=grep_process.stdout,
        stdout=subprocess.PIPE,
        text=True,
    )

    output, error = awk_process.communicate()

    print("Local Time:     " + output.rstrip())
    print("------------------------------------------------")


# Main Function That Calls Other Functions


def main():
    system_info()


if __name__ == "__main__":
    main()
