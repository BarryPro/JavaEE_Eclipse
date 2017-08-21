#!/usr/bin/env bash
. /cfg/comm_set.sh

set_yzlog_begin_time 1000 bal_invprint_info bal_invprint_info

sqlplus  <<!
set num 14 line 1000

--ls -l


exit
!

set_yzlog_end_time 1000 bal_invprint_info bal_invprint_info
