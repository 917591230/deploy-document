#!/bin/bash
# ���������û��nginx��keepalived����kill��
A=`ps -C nginx --no-header |wc -l`      ## �鿴�Ƿ��� nginx���� ��ֵ��������A 
if [ $A -eq 0 ];then				  ## ���û�н���ֵ��Ϊ ��
       service keepalived stop                ## ����� keepalived ����
fi
