# RobotClone

*Save and reuse the configuration of most any command-line program.*

![](robotclone.png)

---

## Description

RobotClone (`rc`) is a wrapper script that allows you to save the configuration of most any command to a simple text file.

Comments can also be saved to the configuration file, so you can document what your configuration does.

Some use cases for this are:

- Save frequently used command configurations.
- Share command configurations with others on your team.
- Document what your command configurations do.

---

## Basic usage

```bash
rc <command> <config file> [optional extra arguments]
```

---

## Instructions

1. Identify a working command with arguments that you want to save as a configuration. 
	- Here's a long Nmap command as an example:

```bash
nmap -sS -Pn -n --randomize-hosts --max-retries 0 --max-scan-delay 1s --max-rtt-timeout 500ms --source-port 53 -vv -p- scanme.nmap.org
```

In this example, maybe one of the following applies to you:
- You frequently use this command and want to be able to execute it on a variety of hosts.
- You want others on your team to execute this same command without typo'ing it.
- It took you a long time to figure out the right combination/order of arguments, and in addition to one of the two situations above, you want to document what each argument does.

2. Create a new file (the configuration file) and save all the command-line arguments to the file, with one argument on each line.
	- Example, using the same Nmap command above, and saved as `scan_all_tcp_ports.cfg`:

```bash
-sS
-Pn
-n
--randomize-hosts
--max-retries 0
--max-scan-delay 1s
--max-rtt-timeout 500ms
--source-port 53
-vv
-p-
scanme.nmap.org
```

3. Add comments to the configuration file to document the purpose of each argument, or if the argument should be changed before use.

```bash
# Perform a SYN scan.
-sS

# Do not ping before scanning.
-Pn

# Do not do DNS resolution.
-n

# Scan hosts in a random order.
--randomize-hosts

# Do not make more than one attempt to reach each port.
--max-retries 0

# Maximum scan delay of 1 second between probes.
--max-scan-delay 1s 

# Do not wait more than 500ms for a response.
--max-rtt-timeout 500ms

# Send traffic out via port 53.
--source-port 53 

# Display extra verbose output.
-vv

# Scan all possible ports.
-p-

# Target host to be scanned.
scanme.nmap.org
```

> See the  `examples` folder in this repo for examples of configuration files written for other programs. They may not be the best examples. (I know CredMaster supports its own configuration files. 😝) They were just programs I happened to be using on the same day I wrote RobotClone.

4. Now you can run Nmap with all the arguments you saved in your configuration file by using RobotClone like so:

```bash
rc nmap scan_all_tcp_ports.cfg
```

RobotClone prints the current date and time and the full command-line that is being executed. Then it runs the command.
- Partial output from the previous command:

```bash
$ rc nmap scan_all_tcp_ports.cfg
Wed 09 Aug 2023 06:11:53 PM UTC
Running: nmap -sS -Pn -n --randomize-hosts --max-retries 0 --max-scan-delay 1s  --max-rtt-timeout 500ms --source-port 53  -vv -p- scanme.nmap.org
Starting Nmap 7.80 ( https://nmap.org ) at 2023-08-09 14:11 EDT
Warning: Hostname scanme.nmap.org resolves to 2 IPs. Using 45.33.32.156.
Initiating SYN Stealth Scan at 14:11
Scanning scanme.nmap.org (45.33.32.156) [65535 ports]
Discovered open port 22/tcp on 45.33.32.156
Discovered open port 80/tcp on 45.33.32.156
...
```

5. Finally, you can remove any arguments from your configuration that should be supplied by the user at runtime.
	- In the case of our example, we might want to remove `scanme.nmap.org` from our configuration. Then the user can specify their own target each time they run RobotClone.
		- The user can specify up to seven additional arguments beyond those defined in the configuration file.
	- Execution with the target host as an additional argument looks like this:

```bash
rc nmap scan_all_tcp_ports.cfg example.com
```

---

![](rampage.png)

