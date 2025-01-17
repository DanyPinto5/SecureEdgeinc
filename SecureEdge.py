import subprocess
#ask to ip and CIDR
network_range = input("Please, Insert IP and CIDR block: ")

output_file = "customtool.txt"

print(f"Scanning {network_range}")


try:
    result = subprocess.run(
        ["nmap", "-sn", network_range],
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True,
    )
except FileNotFoundError:
    print("Nmap not install")
    exit()


output_lines = result.stdout.splitlines()


hosts = []
for line in output_lines:
    if "Nmap scan report for" in line:
        
        host = line.split("for")[-1].strip()
        hosts.append({"host": host, "state": "Unknown"})
    elif "Host is up" in line:
        if hosts:
            hosts[-1]["state"] = "Up"


with open(output_file, "a") as file:
    file.write(f"Scanning {network_range}\n\n")
    for host in hosts:
        file.write(f"IP/Host: {host["host"]} - State: {host["state"]}\n")
        print(f"IP/Host: {host}")  
    file.write("\n")

print(f"save in {output_file}")