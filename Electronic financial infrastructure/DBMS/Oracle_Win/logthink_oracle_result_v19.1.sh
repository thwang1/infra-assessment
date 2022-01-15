#!c:/logthink/bin/sh

alias ls=c:/logthink/bin/ls
alias grep=c:/logthink/bin/grep
alias awk=c:/logthink/bin/gawk
alias find=c:/logthink/bin/find
alias tr=c:/logthink/bin/tr
alias wget=c:/logthink/bin/wget
alias wc=c:/logthink/bin/wc
alias cat=c:/logthink/bin/cat
alias cacls=c:/logthink/bin/cacls
alias sed=c:/logthink/bin/sed
alias pv=c:/logthink/bin/pv
alias mkdir=c:/logthink/bin/mkdir
alias pwd=c:/logthink/bin/pwd
alias date=c:/logthink/bin/date
alias uname=c:/logthink/bin/uname
alias reg=c:/logthink/bin/reg



set BUILD_VER=19.1
set LAST_UPDATE=2019.02


#set PATH=%PATH%;c:/logthink/bin

_HOSTNAME=`hostname`


logthink="c:/logthink"


_TMP_DIR=$think/tmp

ipconfig | egrep "IPv4|IP Address" | awk -F: '{print $2}' | awk '{print $1}' > ./tmp/ip_list.txt
if [ `cat ./tmp/ip_list.txt | awk '{print $1}' |grep "192." |wc -l` -gt 0 ]; then
	HOST_IP=`cat ./tmp/ip_list.txt |grep "192." |head -1`
else
	if [ `cat ./tmp/ip_list.txt | awk '{print $1}' |grep "10" |grep -v "110" | grep -v "210" |wc -l` -gt 0 ]; then
	HOST_IP=`cat ./tmp/ip_list.txt |grep "10." |grep -v "110." | grep -v "210." |head -1`
	else
	HOST_IP=`cat ./tmp/ip_list.txt |head -1`
	fi
fi

_PWD=`pwd`
_ORA_DIR=$_PWD
#_TMP_DIR=$_PWD/tmp
_RET_TXT=$_ORA_DIR/"logthink_${_HOSTNAME}_oracle_${HOST_IP}"_result.txt
_RET_TXT2=$_ORA_DIR/"logthink_${_HOSTNAME}_oracle_${HOST_IP}"_result.logthink




echo "" > $_RET_TXT 
echo "*****************************************************************************" >> $_RET_TXT 
echo "                           logthink Oracle Checklist                          " >> $_RET_TXT 
echo "*****************************************************************************" >> $_RET_TXT 
echo "      Copyright 2019 logthink Co. Ltd. All Rights Reserved. Ver$BUILD_VER	   " >> $_RET_TXT 
echo "                      Last modify date $LAST_UPDATE						   " >> $_RET_TXT 
echo "*****************************************************************************" >> $_RET_TXT 
echo "" >> $_RET_TXT 
echo "" >> $_RET_TXT 
echo "################################# Start Time ################################" >> $_RET_TXT 
date >> $_RET_TXT 
echo "" >> $_RET_TXT 

echo "#################################   Network Status   #################################" >> $_RET_TXT 
netstat -an | egrep -i "LISTEN|ESTABLISHED" >> $_RET_TXT 
echo " " >> $_RET_TXT 

echo "******************************* Start Script *********************************" >> $_RET_TXT
echo " " >> $_RET_TXT

# Oracle directory
_ORA_HOME2=`cat $_TMP_DIR/ora_home_dir.txt`
echo $_ORA_HOME2 > $_TMP_DIR/orahometest.txt
_ORA_HOME=`cat $_TMP_DIR/orahometest.txt`
_ORA_TNS=$_ORA_HOME/network/admin
_ORA_DBS=$_ORA_HOME/dbs
_ORA_VER=`cat $_TMP_DIR/1.0.txt | grep -i "ora" | grep [0-9] | awk -F" " '{print $1}' |\
          awk -F"." '{print $1}'`
#_ORA_VER=10

# Backup TNS file
if [ -f $_ORA_TNS/listener.ora ]
   then
	  cat $_ORA_TNS/listener.ora > $_TMP_DIR/listener.txt
fi
if [ -f $_ORA_TNS/sqlnet.ora ]
   then
      cat $_ORA_TNS/sqlnet.ora > $_TMP_DIR/sqlnet.txt
fi


# 1.1 START-------------------------------------------------------------------------------------
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo "1.01 START" >> $_RET_TXT
echo "1.1 ���ΰ����� ���� ������ ���� ����� ���� ����" >> $_RET_TXT
echo "==========================================================================" >> $_RET_TXT
echo "[����]" >> $_RET_TXT
echo "���� ������ Ȯ���Ͽ� ���ʿ��� ������ ���� ��� ��ȣ" >> $_RET_TXT
echo "����. ����� ���ͺ� �ʿ�" >> $_RET_TXT
echo " " >> $_RET_TXT
echo "[��Ȳ]" >> $_RET_TXT
cat $_TMP_DIR/1.1.txt >> $_RET_TXT
echo " " >> $_RET_TXT
echo "1.08 END" >> $_RET_TXT
# 1.1 END---------------------------------------------------------------------------------------



# 1.2 START-------------------------------------------------------------------------------------
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo "1.02 START" >> $_RET_TXT
echo "1.2 �α��� ���� Ƚ���� ���� ��ݽð� �� ���� ��� ��å ����" >> $_RET_TXT
echo "==================================" >> $_RET_TXT
echo "[����]" >> $_RET_TXT
echo "������ Ƚ���� �α��� ���п� ���� ��������� ������ �� ��� ��ȣ" >> $_RET_TXT
echo "Failed_login_attempts ���� 3 ���� ���� �Ǿ� ������, " >> $_RET_TXT
echo "password_lock_time ���� �����Ǿ� ���� ��� ��ȣ     " >> $_RET_TXT
echo "����. ���� ��� ����� ��ħ�� ���� ������ ���� �� �� ����" >> $_RET_TXT
echo " " >> $_RET_TXT
echo "[��Ȳ]" >> $_RET_TXT
cat $_TMP_DIR/1.2.txt >> $_RET_TXT
echo " " >> $_RET_TXT
echo "1.02 END" >> $_RET_TXT
# 1.2 END---------------------------------------------------------------------------------------



# 1.3 START-------------------------------------------------------------------------------------
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo "1.03 START" >> $_RET_TXT
echo "1.3 SYSDBA �α��� ���� ����" >> $_RET_TXT
echo "================================================================" >> $_RET_TXT
echo "[����]" >> $_RET_TXT
echo "SQLNET.ORA ���Ͼȿ� SQLNET.AUTHENTICATION_SERVICES=(NONE) ���� �Ǿ� ���� ��� ��ȣ" >> $_RET_TXT
echo " " >> $_RET_TXT
echo "[��Ȳ]" >> $_RET_TXT

echo "�� RAC Ȯ�� " >> $_RET_TXT
cat $_TMP_DIR/rac.txt >> $_RET_TXT
rm -rf $_TMP_DIR/rac.txt
echo " " >> $_RET_TXT
echo "�� sqlnet.ora ���� Ȯ��" >> $_RET_TXT
if [ -f $_ORA_TNS/sqlnet.ora ]
then
	cat $_ORA_TNS/sqlnet.ora | grep -i "sqlnet.authentication" >> $_RET_TXT
else
	echo "�� sqlnet.ora ������ �������� ����" >> $_RET_TXT
fi

echo " " >> $_RET_TXT
echo "1.03 END" >> $_RET_TXT
# 1.3 END---------------------------------------------------------------------------------------



# 2.1 START-------------------------------------------------------------------------------------
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo "2.01 START" >> $_RET_TXT
echo "2.1 �н����� ���뿡 ���� ������ ���� ����" >> $_RET_TXT
echo "===================================================" >> $_RET_TXT
echo "[����]" >> $_RET_TXT
echo "�Ķ���� ������ ����� ��� ��ȣ (PASSWORD_REUSE_TIME, PASSWORD_REUSE_MAX)" >> $_RET_TXT
echo "PASSWORD_REUSE_TIME ���� 365 �̻� �׸��� PASSWORD_REUSE_MAX ���� 10 ���� ��ȣ" >> $_RET_TXT
echo "����. ���� ��� ����� ��ħ�� ���� ������ ���� �� �� ����" >> $_RET_TXT
echo " ">> $_RET_TXT

echo "[��Ȳ]" >> $_RET_TXT
cat $_TMP_DIR/2.1.txt >> $_RET_TXT
echo " " >> $_RET_TXT
echo "2.01 END" >> $_RET_TXT
# 2.1 END---------------------------------------------------------------------------------------



# 2.2 START-------------------------------------------------------------------------------------
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo "2.02 START" >> $_RET_TXT
echo "2.2 DB ����� ������ ���������� �ο�" >> $_RET_TXT
echo "=======================================================================" >> $_RET_TXT
echo "[����]" >> $_RET_TXT
echo "����� ���� �߿� �������� ����ϴ� ������ ���� ��� ��ȣ" >> $_RET_TXT
echo "����. ����� ���ͺ� �ʿ�" >> $_RET_TXT
echo " " >> $_RET_TXT

echo "[��Ȳ]" >> $_RET_TXT
cat $_TMP_DIR/2.2.txt >> $_RET_TXT
echo " " >> $_RET_TXT
echo "2.02 END" >> $_RET_TXT
# 2.2 END---------------------------------------------------------------------------------------



# 3.1 START-------------------------------------------------------------------------------------
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo "3.01 START" >> $_RET_TXT
echo "3.1 ���߰����� ��й�ȣ ��������(DB����)" >> $_RET_TXT
echo "=============================" >> $_RET_TXT

echo "[����]" >> $_RET_TXT
echo "��й�ȣ ���� ���� ���� ������ �� ��ȣ" >> $_RET_TXT
echo " " >> $_RET_TXT
echo "[��Ȳ]" >> $_RET_TXT
echo "���ͺ� ���� : ����� ���ͺ並 ���� �н����� ���� ��å Ȯ���ʿ�" >> $_RET_TXT

echo " " >> $_RET_TXT
echo "3.01 END" >> $_RET_TXT
# 3.1 END---------------------------------------------------------------------------------------



# 3.2 START-------------------------------------------------------------------------------------
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo "3.02 START" >> $_RET_TXT
echo "3.2 �⺻ ���� �� �н����� ����(����Ʈ ID �� �н����� ���� �� ���)" >> $_RET_TXT
echo "====================================" >> $_RET_TXT
echo "[����]" >> $_RET_TXT
echo "�⺻ ������  �н����带 ������� ���� ��� ��ȣ" >> $_RET_TXT
echo "OPEN �� ������ ��츸 Ȯ��"                      >> $_RET_TXT
echo "���õ� ���ڵ尡 ������ ��ȣ" >> $_RET_TXT
echo "������� ���� ������ �⺻ �н����� ��� �����̹Ƿ� ���" >> $_RET_TXT
echo " " >> $_RET_TXT
echo "[��Ȳ]" >> $_RET_TXT
cat $_TMP_DIR/3.2.txt >> $_RET_TXT
echo " " >> $_RET_TXT
echo "3.02 END" >> $_RET_TXT
# 3.2 END---------------------------------------------------------------------------------------



# 3.3 START-------------------------------------------------------------------------------------
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo "3.03 START" >> $_RET_TXT
echo "3.3 ��й�ȣ ���⵵ ����" >> $_RET_TXT
echo "=============================================================" >> $_RET_TXT
echo "[����]" >> $_RET_TXT
echo "PASSWORD_VERIFY_FUNCTION�� Ȱ��ȭ�Ǿ� �ְ� ���⵵ �� �н����� ���� ������ �Ǿ� ������ ��ȣ " >> $_RET_TXT
echo "���� �ַ���� ���Ͽ� ���⵵ ������ �����Ǵ� ��� ��ȣ" >> $_RET_TXT
echo " " >> $_RET_TXT
echo "[��Ȳ]" >> $_RET_TXT

echo "�� Verify_function ���� Ȯ��" >> $_RET_TXT
echo "--------------------------------" >> $_RET_TXT
cat $_TMP_DIR/3.3.txt >> $_RET_TXT

echo " " >> $_RET_TXT

echo "�� Verify_function ���� Ȯ��" >> $_RET_TXT
echo "--------------------------------" >> $_RET_TXT
if [ -f $_ORA_HOME/rdbms/admin/utlpwdmg.sql ]
then
	echo "�� Oracle 11g ���� ���� Ȯ��" >> $_RET_TXT
	cat $_ORA_HOME/rdbms/admin/utlpwdmg.sql | egrep -i "length|verify_function" >> $_RET_TXT
	echo " " >> $_RET_TXT
	echo "�� Oracle 12c �̻� ���� Ȯ��" >> $_RET_TXT
	cat $_ORA_HOME/rdbms/admin/utlpwdmg.sql | egrep -i "complexity_check|verify_function|life_time" >> $_RET_TXT
	echo " " >> $_RET_TXT
else
	"�� $_ORA_HOME/rdbms/admin/utlpwdmg.sql ������ �������� ����" >> $_RET_TXT
fi
echo " " >> $_RET_TXT

echo "�� Verify_function ���� Ȯ��(11g����)" >> $_RET_TXT
echo "--------------------------------" >> $_RET_TXT
cat $_TMP_DIR/3.31.txt >> $_RET_TXT
rm -rf $_TMP_DIR/3.31.txt
echo " " >> $_RET_TXT

echo "�� Verify_function ���� Ȯ��(11g)" >> $_RET_TXT
echo "--------------------------------" >> $_RET_TXT
cat $_TMP_DIR/3.32.txt >> $_RET_TXT


echo " " >> $_RET_TXT
echo "3.03 END" >> $_RET_TXT
# 3.3 END---------------------------------------------------------------------------------------



# 3.4 START-------------------------------------------------------------------------------------
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo "3.04 START" >> $_RET_TXT
echo "3.4 ��й�ȣ�� �ֱ����� ����" >> $_RET_TXT
echo "=====================================================================" >> $_RET_TXT
echo "[����]" >> $_RET_TXT
echo "�н����带 �ֱ������� �����ϰ� �н����� ��å�� ����Ǿ� �ִ� ��� ��ȣ" >> $_RET_TXT
echo "PASSWORD_LIFE_TIME ���� 90���� �׸��� PASSWORD_GRACE_TIME ���� 5 �̻� ��ȣ " >> $_RET_TXT
echo "����. ���� ��� ����� ��ħ�� ���� ������ ���� �� �� ����" >> $_RET_TXT
echo " " >> $_RET_TXT
echo "[��Ȳ]" >> $_RET_TXT
cat $_TMP_DIR/3.4.txt >> $_RET_TXT
echo " " >> $_RET_TXT
echo "3.04 END" >> $_RET_TXT
# 3.4 END---------------------------------------------------------------------------------------



# 3.5 START-------------------------------------------------------------------------------------
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo "3.05 START" >> $_RET_TXT
echo "3.5 listener ��й�ȣ ���� �� ����Ʈ ��Ʈ ����" >> $_RET_TXT
echo "================================================" >> $_RET_TXT
echo "[����]" >> $_RET_TXT
echo "listener�� ��й�ȣ ������ ���������� �Ǿ� �ְ�, ��Ʈ��ȣ�� ����Ʈ ��Ʈ��ȣ�� 1521�� �ƴ� ���" >> $_RET_TXT
echo " " >> $_RET_TXT
echo "[��Ȳ]" >> $_RET_TXT

echo " " >> $_RET_TXT

echo "�� listener.ora ���� Ȯ��" >> $_RET_TXT
if [ -f $_ORA_HOME/network/admin/listener.ora ]
then
	cat $_ORA_HOME/network/admin/listener.ora >> $_RET_TXT
else
  echo "�� listener.ora ������ �������� ����" >> $_RET_TXT
fi


echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo "3.05 END" >> $_RET_TXT
# 3.5 END---------------------------------------------------------------------------------------



# 4.1 START-------------------------------------------------------------------------------------
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo "4.01 START" >> $_RET_TXT
echo "4.1 DBA�̿��� �ΰ����� ���� ����ڰ� �ý��� ���̺��� ������ �� ������ ����" >> $_RET_TXT
echo "======================================================================================" >> $_RET_TXT
echo "[����]" >> $_RET_TXT
echo "DBA�� ���� �����Ͽ��� �� ���̺��� ���ΰ��� ������ ���� ������ ��� ���" >> $_RET_TXT
echo "��� ���� ���� ��� ��ȣ" >> $_RET_TXT
echo " " >> $_RET_TXT
echo "[��Ȳ]" >> $_RET_TXT
cat $_TMP_DIR/4.1.txt >> $_RET_TXT
echo " " >> $_RET_TXT
echo "4.01 END" >> $_RET_TXT
# 4.1 END---------------------------------------------------------------------------------------




# 4.2 START-------------------------------------------------------------------------------------
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo "4.02 START" >> $_RET_TXT
echo "4.2 ���ʿ��� ODBC/OLE-DB ������ �ҽ��� ����̺� ����" >> $_RET_TXT
echo "=================================================================" >> $_RET_TXT
echo "[����]" >> $_RET_TXT
echo "���ʿ��� ODBC/OLE-DB�� ��ġ���� ���� ��� ��ȣ" >> $_RET_TXT
echo "[��Ȳ]" >> $_RET_TXT
echo "Oracle�� �ش���� ���� : N/A" >> $_RET_TXT

echo " " >> $_RET_TXT
echo "4.02 END" >> $_RET_TXT
# 4.2 END---------------------------------------------------------------------------------------



# 4.3 START-------------------------------------------------------------------------------------
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo "4.03 START" >> $_RET_TXT
echo "4.3 �����ͺ��̽��� �ֿ� ��������, �н����� ���� �� �ֿ� ���ϵ��� ���� ���� ������ ����" >> $_RET_TXT
echo "==========================================================================================" >> $_RET_TXT
echo "[����]" >> $_RET_TXT
echo "�� orapwd<SID> ���� ���ٱ��ѿ� administrator, system group, owner group, oracle service, account, DBAs ������ �Ǵ� �� ���ϼ��� " >> $_RET_TXT
echo "�� ��Ÿ �ٸ� �׷��� ���� " >> $_RET_TXT

echo " " >> $_RET_TXT
echo "[��Ȳ]" >> $_RET_TXT
cacls $_ORA_HOME/BIN/orapwd*.exe >> $_RET_TXT

echo " " >> $_RET_TXT
echo "���� �� ������ ���� ������ �������� ���� �� ����" >> $_RET_TXT
echo " " >> $_RET_TXT
echo "4.03 END" >> $_RET_TXT
# 4.3 END---------------------------------------------------------------------------------------



# 4.4 START-------------------------------------------------------------------------------------
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo "4.04 START" >> $_RET_TXT
echo "4.4 �����ͺ��̽��� �ֿ� ���� ��ȣ ���� ���� DB ������ umask ����" >> $_RET_TXT
echo "======================================================" >> $_RET_TXT
echo "[����]" >> $_RET_TXT
echo "DB ������ umask�� 022 �̻����� ���� ������ ��� ��ȣ" >> $_RET_TXT
echo " " >> $_RET_TXT

echo "[��Ȳ]" >> $_RET_TXT
echo "Windows OS N/A" >> $_RET_TXT
echo " " >> $_RET_TXT
echo "4.04 END" >> $_RET_TXT
# 4.4 END---------------------------------------------------------------------------------------



# 4.5 START-------------------------------------------------------------------------------------
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo "4.05 START" >> $_RET_TXT
echo "4.5 ����Ŭ ������ �α� �� trace ���Ͽ� ���� ���ϱ��� ������ ����" >> $_RET_TXT
echo "===============================================================================" >> $_RET_TXT
echo "[����]" >> $_RET_TXT
echo "listener.ora ���Ͽ� ADMIN_RESTRICTIONS_LISTENER=ON �� ���� ������ ��� ��ȣ" >> $_RET_TXT
echo " " >> $_RET_TXT
echo "[��Ȳ]" >> $_RET_TXT
echo " " >> $_RET_TXT
echo "- Listener ���� �������� ���� -" >> $_RET_TXT
_ADM_FLAG="0"
if [ `cat "$_ORA_TNS/listener.ora" | grep -i ADMIN_REST | grep -v "^#" |\
      grep -i ON | wc -l` -eq 0 ]
   then
      _ADM_FLAG="1"
      echo "�������� ������ �Ǿ����� �ʽ��ϴ�" >> $_RET_TXT
   else
      cat "$_ORA_TNS/listener.ora" | grep -i ADMIN_REST >> $_RET_TXT
fi
cat $_TMP_DIR/4.5.txt >> $_RET_TXT
echo " " >> $_RET_TXT
echo "4.05 END" >> $_RET_TXT
# 4.5 END---------------------------------------------------------------------------------------



# 5.1 START-------------------------------------------------------------------------------------
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo "5.01 START" >> $_RET_TXT
echo "5.1 �н����� Ȯ���Լ� ���� ����" >> $_RET_TXT
echo "===================================================" >> $_RET_TXT
echo "[����]" >> $_RET_TXT
echo "PASSWORD_VERIFY_FUNCTION �� Ȱ��ȭ�� ��ȣ " >> $_RET_TXT
echo " " >> $_RET_TXT
echo "[��Ȳ]" >> $_RET_TXT
cat $_TMP_DIR/5.1.txt >> $_RET_TXT
echo " " >> $_RET_TXT

echo "�� Verify_function ���� Ȯ��" >> $_RET_TXT
echo "--------------------------------" >> $_RET_TXT
cat $_TMP_DIR/3.3.txt >> $_RET_TXT
rm -rf $_TMP_DIR/3.3.txt
echo " " >> $_RET_TXT

echo "�� Verify_function ���� Ȯ��" >> $_RET_TXT
echo "--------------------------------" >> $_RET_TXT
if [ -f $_ORA_HOME/rdbms/admin/utlpwdmg.sql ]
then
	echo "�� Oracle 11g ���� ���� Ȯ��" >> $_RET_TXT
	cat $_ORA_HOME/rdbms/admin/utlpwdmg.sql | egrep -i "length|verify_function" >> $_RET_TXT
	echo " " >> $_RET_TXT
	echo "�� Oracle 12c �̻� ���� Ȯ��" >> $_RET_TXT
	cat $_ORA_HOME/rdbms/admin/utlpwdmg.sql | egrep -i "complexity_check|verify_function|life_time" >> $_RET_TXT
	echo " " >> $_RET_TXT
else
	"�� $_ORA_HOME/rdbms/admin/utlpwdmg.sql ������ �������� ����" >> $_RET_TXT
fi
echo " " >> $_RET_TXT

echo "5.01 END" >> $_RET_TXT
# 5.1 END---------------------------------------------------------------------------------------



# 5.2 START-------------------------------------------------------------------------------------
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo "5.02 START" >> $_RET_TXT
echo "5.2 Role�� ���� grant option ���� ����" >> $_RET_TXT
echo "=============================================================" >> $_RET_TXT
echo "[����]" >> $_RET_TXT
echo "���̺��� ���� GRANTABLE �ɼ��� ������ ����ڿ��Ը� �ο��Ǿ� ���� ��� ��ȣ " >> $_RET_TXT
echo "���õ� ���ڵ尡 ������ ��ȣ" >> $_RET_TXT
echo " " >> $_RET_TXT

echo "[��Ȳ]" >> $_RET_TXT
cat $_TMP_DIR/5.2.txt >> $_RET_TXT
echo " " >> $_RET_TXT
echo "5.02 END" >> $_RET_TXT
# 5.2 END---------------------------------------------------------------------------------------



# 5.3 START-------------------------------------------------------------------------------------
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo "5.03 START" >> $_RET_TXT
echo "5.3 �ΰ����� ���� Object Owner�� ���� ����" >> $_RET_TXT
echo "=============================================================" >> $_RET_TXT
echo "[����]" >> $_RET_TXT
echo "Object Owner�� SYS, SYSTEM�� ���� �����ͺ��̽� ������ ������ ���� ���α׷��� ������ �������� ������ ��� ��ȣ" >> $_RET_TXT
echo "�ش� ������Ʈ�� �����ڰ� �������� ����ڿ� ���ͺ�" >> $_RET_TXT
echo " " >> $_RET_TXT
echo "[��Ȳ]" >> $_RET_TXT
cat $_TMP_DIR/5.3.txt >> $_RET_TXT
echo " " >> $_RET_TXT
echo "5.03 END" >> $_RET_TXT
# 5.3 END---------------------------------------------------------------------------------------



# 5.4 START-------------------------------------------------------------------------------------
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo "5.04 START" >> $_RET_TXT
echo "5.4 �����ͺ��̽��� �ڿ� ���� ��� ���� ����" >> $_RET_TXT
echo "=============================================================" >> $_RET_TXT
echo "[����]" >> $_RET_TXT
echo "�����ͺ��̽� �ڿ� ���� ����� Ȱ��ȭ �� ��ȣ" >> $_RET_TXT
echo "RESOURCE_LIMIT TRUE �� ��� ��ȣ" >> $_RET_TXT
echo " " >> $_RET_TXT
echo "[��Ȳ]" >> $_RET_TXT
cat $_TMP_DIR/5.4.txt >> $_RET_TXT
echo " " >> $_RET_TXT
echo "5.04 END" >> $_RET_TXT
# 5.4 END---------------------------------------------------------------------------------------



# 6.1 START-------------------------------------------------------------------------------------
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo "6.01 START" >> $_RET_TXT
echo "6.1 DBA ���� ���� ����" >> $_RET_TXT
echo "======================================================================" >> $_RET_TXT
echo "[����]" >> $_RET_TXT
echo "SYSDBA ������ �������� �Ϲݰ��� �� ���ø����̼� ������ �ο��Ǿ� ���� ���� ��� ��ȣ" >> $_RET_TXT
echo "����. ���� ��� ����� ��ħ�� ���� ������ ���� �� �� ����" >> $_RET_TXT
echo " " >> $_RET_TXT
echo "[��Ȳ]" >> $_RET_TXT
echo "- 1. SYSDBA ��������" >> $_RET_TXT
cat $_TMP_DIR/6.1.1.txt >> $_RET_TXT
echo "- 2. ADMIN�� ������ ���� ���� ���� ����" >> $_RET_TXT
cat $_TMP_DIR/6.1.2.txt >> $_RET_TXT
echo "1,2������ ���õ� ���ڵ尡 ������ ��ȣ" >> $_RET_TXT
echo " " >> $_RET_TXT
echo "6.01 END" >> $_RET_TXT
# 6.1 END---------------------------------------------------------------------------------------



# 6.2 START-------------------------------------------------------------------------------------
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo "6.02 START" >> $_RET_TXT
echo "6.2 ���ݿ��� DB �������� ���� ����" >> $_RET_TXT
echo "================================================================================================" >> $_RET_TXT
echo "[����]" >> $_RET_TXT
echo "��ȭ�� ���� �Ǵ� ����������� �ַ�� ���� �� ��ȣ" >> $_RET_TXT
echo "���� ��������� �Ʒ��� ���� ��Ȱ��ȭ(FALSE) �Ǿ������� ��ȣ" >> $_RET_TXT
echo " - REMOTE_OS_AUTHENT=FALSE" >> $_RET_TXT
echo " " >> $_RET_TXT
echo "* ������ �Ķ���� Ȯ��" >> $_RET_TXT
echo " - 9i �̻� ���� : SQL �������� Ȯ��" >> $_RET_TXT
echo " - 8i ���� ���� : init<SID>.ora ���� Ȯ��" >> $_RET_TXT
echo " " >> $_RET_TXT

echo "[��Ȳ]" >> $_RET_TXT
_INT_FILE="$_ORA_DBS/init*.ora"
if [ $_ORA_VER -ge 9 ] 
   then 
      cat $_TMP_DIR/6.2.txt >> $_RET_TXT
   else
      cat $_INT_FILE | grep -i REMOTE_OS >> $_RET_TXT
	  	  if [ `cat $_INT_FILE | grep -i "REMOTE_OS_AUTHENT" | grep -v "^#" | grep -i "FALSE" | wc -l` -eq 0 ]
			 then 
				echo "REMOTE_OS_AUTHENT���� ����" >> $_RET_TXT
		  fi
fi
echo " " >> $_RET_TXT
echo "6.02 END" >> $_RET_TXT
# 6.2 END---------------------------------------------------------------------------------------



# 6.3 START-------------------------------------------------------------------------------------
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo "6.03 START" >> $_RET_TXT
echo "6.3 OS_ROLES,  REMOTE_OS_ROLES ����" >> $_RET_TXT
echo "=======================================================================" >> $_RET_TXT
echo "[����]" >> $_RET_TXT
echo "OS_ROLES, REMOTE_OS_AUTHENTICATION, REMOTE_OS_ROLES�� FALSE�� ���� �Ǿ����� ��� ��ȣ" >> $_RET_TXT
echo " " >> $_RET_TXT
echo "[��Ȳ]" >> $_RET_TXT
cat $_TMP_DIR/6.3.txt >> $_RET_TXT
echo " " >> $_RET_TXT
echo "6.03 END" >> $_RET_TXT
# 6.3 END---------------------------------------------------------------------------------------



# 6.4 START-------------------------------------------------------------------------------------
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo "6.04 START" >> $_RET_TXT
echo "6.4 �������α׷� �Ǵ� DBA ������ Role�� Public ���� ����" >> $_RET_TXT
echo "==========================" >> $_RET_TXT
echo "[����]" >> $_RET_TXT
echo "�������α׷� �Ǵ� DBA ������ Role�� Public���� �������� ���� ��� ��ȣ" >> $_RET_TXT
echo "���õ� ���ڵ尡 ������ ��ȣ" >> $_RET_TXT
echo " " >> $_RET_TXT
echo "[��Ȳ]" >> $_RET_TXT
cat $_TMP_DIR/6.4.txt >> $_RET_TXT
echo " " >> $_RET_TXT
echo "6.04 END" >> $_RET_TXT
# 6.4 END---------------------------------------------------------------------------------------



# 7.1 START-------------------------------------------------------------------------------------
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo "7.01 START" >> $_RET_TXT
echo "7.1 ���� Idle timeout ����" >> $_RET_TXT
echo "==============================================" >> $_RET_TXT
echo "[����]" >> $_RET_TXT
echo "���� Idle timeout ����(5��) Ȥ�� ���� �ַ���� ���Ͽ� �ش� ��� ��� " >> $_RET_TXT
echo " " >> $_RET_TXT
echo "[��Ȳ]" >> $_RET_TXT

echo "���� Idle timeout ���� Ȯ�� " >> $_RET_TXT
cat $_TMP_DIR/7.1.txt >> $_RET_TXT
echo " " >> $_RET_TXT

echo " " >> $_RET_TXT
echo "7.01 END" >> $_RET_TXT
# 7.1 END---------------------------------------------------------------------------------------



# 8.1 START-------------------------------------------------------------------------------------
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo "8.01 START" >> $_RET_TXT
echo "8.1 �����ͺ��̽� �ֽ� ������ġ�� ��� �ǰ����� ����" >> $_RET_TXT
echo "=============================================================" >> $_RET_TXT
echo "[����]" >> $_RET_TXT
echo "�ֽ� ������ġ ������ �Ǿ����� ��� ��ȣ" >> $_RET_TXT
echo " " >> $_RET_TXT

echo "[��Ȳ]" >> $_RET_TXT
cat $_TMP_DIR/8.1.txt >> $_RET_TXT
echo " " >> $_RET_TXT
echo "8.01 END" >> $_RET_TXT
# 8.1 END---------------------------------------------------------------------------------------




# 8.2 START-------------------------------------------------------------------------------------
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo "8.02 START" >> $_RET_TXT
echo "8.2 ���ȿ� ������� ���� ������ �����ͺ��̽� ��� ����" >> $_RET_TXT
echo "=============================================================" >> $_RET_TXTecho "[����]" >> $_RET_TXT
echo "Oracle 12cg Release 1	12.1.0.2.0" >> $_RET_TXT
echo "Oracle 11g Release 2	11.2.0.2 zLinux64" >> $_RET_TXT
echo "Oracle 11g Release 2	11.2.0.1 All OS" >> $_RET_TXT
echo "Oracle 11g Release 1	11.1.0.7 Microsoft Windows Server 2008" >> $_RET_TXT
echo "Oracle 11g Release 1	11.1.0.6 All OS" >> $_RET_TXT
echo "Oracle 10g Release 2	10.2.0.5 Windows 64bit itanium" >> $_RET_TXT
echo "Oracle 10g Release 2	10.2.0.4 Windows, MAC OS X" >> $_RET_TXT
echo "Oracle 10g Release 2	10.2.0.1 All OS" >> $_RET_TXT
echo "Oracle 10g Release 1	10.1.0.5" >> $_RET_TXT
echo "Oracle 9i Release 2	9.2.0.8" >> $_RET_TXT
echo "Oracle 9i Release 1	9.0.1.4" >> $_RET_TXT
echo "Oracle 8i Release 3	8.1.7.4" >> $_RET_TXT
echo "Oracle 8i		8.0.6.3" >> $_RET_TXT
echo " " >> $_RET_TXT
echo "[��Ȳ]" >> $_RET_TXT
cat $_TMP_DIR/8.2.txt >> $_RET_TXT
echo " " >> $_RET_TXT
echo "8.02 END" >> $_RET_TXT
# 8.2 END---------------------------------------------------------------------------------------



# 9.1 START-------------------------------------------------------------------------------------
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo "9.01 START" >> $_RET_TXT
echo "9.1 ���� ��� ���� ����" >> $_RET_TXT
echo "===============================================" >> $_RET_TXT
echo "[����]" >> $_RET_TXT
echo "����Ŭ ��ü �⺻ ���� ����� ���� �� �̰ų�(audit_trail=none �ܿ� ����) �ַ���� ���� DBMS���� ����� ������ �� ��� ��ȣ" >> $_RET_TXT
echo "����, ����, ���� ���� ���� ����� ��å�� �����ϵ��� ���� �Ǿ��ִ� ��� ��ȣ" >> $_RET_TXT
echo "����� ���ͺ� �ʿ�" >> $_RET_TXT
echo "DBsafer, DB-i ��� ���� �ַ���̳� DBMS ��ü ������ ������ ���� ���� ����� ������ ��� ��ȣ" >> $_RET_TXT
echo " " >> $_RET_TXT
echo "[��Ȳ]" >> $_RET_TXT
cat $_TMP_DIR/9.1.txt >> $_RET_TXT



echo " " >> $_RET_TXT
echo "9.01 END" >> $_RET_TXT
# 9.1 END---------------------------------------------------------------------------------------



# 10.1 START-------------------------------------------------------------------------------------
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo "10.01 START" >> $_RET_TXT
echo "10.1 DB���� �߿����� ��ȣȭ ���� ����" >> $_RET_TXT
echo "==========================================" >> $_RET_TXT
echo "[����]" >> $_RET_TXT
echo "�ֹε�Ϲ�ȣ/��й�ȣ �� �ֿ������� ���ؼ� ��ȣȭ�� ����Ǿ� �ִ��� ����" >> $_RET_TXT
echo " " >> $_RET_TXT
echo "[��Ȳ]" >> $_RET_TXT
echo "���ͺ� ���� : ����� ���ͺ� �Ǵ� �ǻ縦 ���� �߿����� ���� ��ȣȭ ���뿩�� Ȯ��" >> $_RET_TXT




echo " " >> $_RET_TXT
echo "10.01 END" >> $_RET_TXT
# 10.1 END---------------------------------------------------------------------------------------



# 11.1 START-------------------------------------------------------------------------------------
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo "11.01 START" >> $_RET_TXT
echo "11.1 �����ͺ��̽� ������ ������ Audit Table�� ���� �ִ� ����" >> $_RET_TXT
echo "=============================================================" >> $_RET_TXT
echo "[����]" >> $_RET_TXT
echo "Audit Table�� �����ͺ��̽� ������ ��������  ���� ���� ��� ��ȣ" >> $_RET_TXT
echo "AUD$ TAABLE�� ������ ������ �������� ��� " >> $_RET_TXT
echo " " >> $_RET_TXT
echo "[��Ȳ]" >> $_RET_TXT
cat $_TMP_DIR/11.1.txt >> $_RET_TXT
echo " " >> $_RET_TXT
echo "11.01 END" >> $_RET_TXT
# 11.1 END---------------------------------------------------------------------------------------









# ����.1 ���� ���� START-------------------------------------------------------------------------------------
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo "����.1 ���� ����"
echo "����.1 ���� ����" >> $_RET_TXT
echo "=============================================================" >> $_RET_TXT
echo "�� ������ Ȱ��ȭ ����, ����ϴ� profile Ȯ�� �� ����" >> $_RET_TXT
echo " " >> $_RET_TXT
cat $_TMP_DIR/info1.txt >> $_RET_TXT
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
# ����.1 ���� ���� END---------------------------------------------------------------------------------------


# ����.2 ������ role ���� START-------------------------------------------------------------------------------------
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo "����.2 ������ role ����"
echo "����.2 ������ role ����" >> $_RET_TXT
echo "=============================================================" >> $_RET_TXT
echo "������ role�� Ȯ�� �ʿ� �� ����" >> $_RET_TXT
echo "(ex> DBA������ ���� Ȯ�� ��)" >> $_RET_TXT
echo " " >> $_RET_TXT
cat $_TMP_DIR/info2.txt >> $_RET_TXT
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
# ����.2 ������ role ���� END---------------------------------------------------------------------------------------


# ����.3 ��ü Profile ���� START-------------------------------------------------------------------------------------
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
echo "����.3 ��ü Profile ����"
echo "����.3 ��ü Profile ����" >> $_RET_TXT
echo "=============================================================" >> $_RET_TXT
echo " " >> $_RET_TXT
cat $_TMP_DIR/info3.txt >> $_RET_TXT
echo " " >> $_RET_TXT
echo " " >> $_RET_TXT
# ����.3 ��ü Profile ���� END---------------------------------------------------------------------------------------


echo "" >> $_RET_TXT
echo "#################################################################################" >> $_RET_TXT
echo "########################## ��ũ��Ʈ ������ ###########################" >> $_RET_TXT
echo "#################################################################################" >> $_RET_TXT
echo "_ORA_TNS�� $_ORA_TNS" >> $_RET_TXT
echo "_ORA_DBS�� $_ORA_DBS" >> $_RET_TXT
echo "_ORA_VER�� $_ORA_VER" >> $_RET_TXT
echo "_ORA_HOME�� $_ORA_HOME" >> $_RET_TXT


echo "" >> $_RET_TXT
echo "#################################################################################" >> $_RET_TXT
echo "########################## cat $_ORA_TNS/listener.ora ###########################" >> $_RET_TXT
echo "#################################################################################" >> $_RET_TXT
if [ -f $_TMP_DIR/listener.txt ]
then
	cat $_TMP_DIR/listener.txt >> $_RET_TXT
else
	echo "�Է��Ͻ� ORA_HOME ���丮 ���� /network/admin/listener.ora�� �������� ����" >> $_RET_TXT
fi


echo "" >> $_RET_TXT
echo "#################################################################################" >> $_RET_TXT
echo "########################### cat $_ORA_TNS/sqlnet.ora ############################" >> $_RET_TXT
echo "#################################################################################" >> $_RET_TXT
if [ -f $_TMP_DIR/sqlnet.txt ]
then
	cat $_TMP_DIR/sqlnet.txt >> $_RET_TXT
else
	echo "�Է��Ͻ� ORA_HOME ���丮 ���� /network/admin/sqlnet.ora�� �������� ����" >> $_RET_TXT
fi


echo "" >> $_RET_TXT
echo "###############################################################################" >> $_RET_TXT
echo "############################# Oracle Version info ############################" >> $_RET_TXT 
echo "###############################################################################" >> $_RET_TXT
cat $_TMP_DIR/1.0.txt | grep -i "ora" >> $_RET_TXT


echo "" >> $_RET_TXT
echo "###############################################################################" >> $_RET_TXT
echo "################################ ifconfig -a ################################" >> $_RET_TXT
echo "###############################################################################" >> $_RET_TXT
ipconfig /all >> $_RET_TXT

echo "" >> $_RET_TXT
echo "################################# END Time ################################" >> $_RET_TXT 
date >> $_RET_TXT 

echo "" 
echo "######################### Script�� ����Ǿ����ϴ� ###########################" 

echo " " >> $_RET_TXT 
echo " " >> $_RET_TXT 
echo "****************************** End Script ***********************************" >> $_RET_TXT
echo "END_RESULT" >> $_RET_TXT
echo " " >> $_RET_TXT 