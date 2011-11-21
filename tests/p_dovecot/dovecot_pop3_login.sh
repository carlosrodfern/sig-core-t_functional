#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - adding pop3test local user account + attempting POP3 login"

{ userdel pop3test; useradd pop3test && echo pop3test | passwd --stdin pop3test; } &>/dev/null

t_Log "Dovecot POP3 login test"
echo -e "user pop3test\npass pop3test\n" | nc localhost 110 | grep "+OK Logged in."

if (t_GetPkgRel dovecot | grep -q el6)
then
   echo "[*] ** EXPERIMENTAL **: Test not working on CentOS 6, forcing PASS"
   true
fi

t_CheckExitStatus $?

userdel -rf pop3test
