#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>
#	Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - tftp-server put file test."

if (t_GetPkgRel basesystem | grep -q el6)
then
  TFTP_DIR=/var/lib/tftpboot
else
  TFTP_DIR=/tftpboot
fi

chmod 777 $TFTP_DIR
echo "t_functional_test" > put_test
touch $TFTP_DIR/put_test
chmod 666 $TFTP_DIR/put_test
tftp 127.0.0.1  -c put put_test

cat $TFTP_DIR/put_test | grep -q 't_functional_test' 
ret_val=$?

#cleaning up
/bin/rm -f put_test
/bin/rm -f $TFTP_DIR/put_test

t_CheckExitStatus $ret_val