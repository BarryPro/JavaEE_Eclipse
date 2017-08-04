/**
 * wanghfa 20100602 crm维护的报表调用此方法，参数statement是页面form对象
 * wanghfa 20100607 增加了报表格式的解耦
 **/

function select_crm(statement)
{
	if(statement)
	{
		with(statement) 
		{
      if(rpt_type.value==3)
			{
			    document.all("rpt_format").options.length=6;
			    document.all("rpt_format").options[0].text='明细';
			    document.all("rpt_format").options[0].value='10000';
			    document.all("rpt_format").options[1].text='工号小计';
			    document.all("rpt_format").options[1].value='01000';
			    document.all("rpt_format").options[2].text='操作小计';
			    document.all("rpt_format").options[2].value='00100';
			    document.all("rpt_format").options[3].text='明细+工号小计';
			    document.all("rpt_format").options[3].value='11000';
			    document.all("rpt_format").options[4].text='明细+操作小计';
			    document.all("rpt_format").options[4].value='10100';
			    document.all("rpt_format").options[5].text='明细+工号小计+操作小计';
			    document.all("rpt_format").options[5].value='11100';
			    
				hTableName.value="rst003";
				hParams1.value= "prc_1625_st003_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==4)
			{
			    document.all("rpt_format").options.length=8;
			    document.all("rpt_format").options[0].text='明细';
			    document.all("rpt_format").options[0].value='10000';
			    document.all("rpt_format").options[1].text='工号小计';
			    document.all("rpt_format").options[1].value='01000';
			    document.all("rpt_format").options[2].text='操作小计';
			    document.all("rpt_format").options[2].value='00100';
			    document.all("rpt_format").options[3].text='卡类小计';
			    document.all("rpt_format").options[3].value='00010';
			    document.all("rpt_format").options[4].text='明细+工号小计';
			    document.all("rpt_format").options[4].value='11000';
			    document.all("rpt_format").options[5].text='明细+操作小计';
			    document.all("rpt_format").options[5].value='10100';
			    document.all("rpt_format").options[6].text='明细+卡类小计';
			    document.all("rpt_format").options[6].value='10010';
			    document.all("rpt_format").options[7].text='明细+工号小计+操作小计+卡类小计';
			    document.all("rpt_format").options[7].value='11110';

				hTableName.value="rct003";
				hParams1.value= "prc_1625_ct003_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==5)
			{
			    document.all("rpt_format").options.length=8;
			    document.all("rpt_format").options[0].text='明细';
			    document.all("rpt_format").options[0].value='10000';
			    document.all("rpt_format").options[1].text='工号小计';
			    document.all("rpt_format").options[1].value='01000';
			    document.all("rpt_format").options[2].text='操作小计';
			    document.all("rpt_format").options[2].value='00100';
			    document.all("rpt_format").options[3].text='特服小计';
			    document.all("rpt_format").options[3].value='00010';
			    document.all("rpt_format").options[4].text='明细+工号小计';
			    document.all("rpt_format").options[4].value='11000';
			    document.all("rpt_format").options[5].text='明细+操作小计';
			    document.all("rpt_format").options[5].value='10100';
			    document.all("rpt_format").options[6].text='明细+特服小计';
			    document.all("rpt_format").options[6].value='10010';
			    document.all("rpt_format").options[7].text='明细+工号小计+操作小计+特服小计';
			    document.all("rpt_format").options[7].value='11110';

				hTableName.value="rft003";
				hParams1.value= "prc_1625_ft003_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==6)
			{
				hTableName.value="rtt003";
				hParams1.value= "prc_1625_tt003_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			
			else if(rpt_type.value==8)
			{
			    document.all("rpt_format").options.length=8;
			    document.all("rpt_format").options[0].text='明细';
			    document.all("rpt_format").options[0].value='10000';
			    document.all("rpt_format").options[1].text='工号小计';
			    document.all("rpt_format").options[1].value='01000';
			    document.all("rpt_format").options[2].text='操作小计';
			    document.all("rpt_format").options[2].value='00100';
			    document.all("rpt_format").options[3].text='兑换名称小计';
			    document.all("rpt_format").options[3].value='00010';
			    document.all("rpt_format").options[4].text='明细+工号小计';
			    document.all("rpt_format").options[4].value='11000';
			    document.all("rpt_format").options[5].text='明细+操作小计';
			    document.all("rpt_format").options[5].value='10100';
			    document.all("rpt_format").options[6].text='明细+兑换名称小计';
			    document.all("rpt_format").options[6].value='10010';
			    document.all("rpt_format").options[7].text='明细+工号小计+操作小计+兑换名称小计';
			    document.all("rpt_format").options[7].value='11110';

				hTableName.value="rjt003";
				hParams1.value= "prc_1625_jt003_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==9)
			{
			    document.all("rpt_format").options.length=8;
			    document.all("rpt_format").options[0].text='明细';
			    document.all("rpt_format").options[0].value='10000';
			    document.all("rpt_format").options[1].text='工号小计';
			    document.all("rpt_format").options[1].value='01000';
			    document.all("rpt_format").options[2].text='操作小计';
			    document.all("rpt_format").options[2].value='00100';
			    document.all("rpt_format").options[3].text='手机型号小计';
			    document.all("rpt_format").options[3].value='00010';
			    document.all("rpt_format").options[4].text='明细+工号小计';
			    document.all("rpt_format").options[4].value='11000';
			    document.all("rpt_format").options[5].text='明细+操作小计';
			    document.all("rpt_format").options[5].value='10100';
			    document.all("rpt_format").options[6].text='明细+手机型号小计';
			    document.all("rpt_format").options[6].value='10010';
			    document.all("rpt_format").options[7].text='明细+工号小计+操作小计+手机型号小计';
			    document.all("rpt_format").options[7].value='11110';

				hTableName.value="ryt003";
				hParams1.value= "prc_1625_yt003_upg('"+workNo.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==10)
			{
			    document.all("rpt_format").options.length=8;
			    document.all("rpt_format").options[0].text='明细';
			    document.all("rpt_format").options[0].value='10000';
			    document.all("rpt_format").options[1].text='工号小计';
			    document.all("rpt_format").options[1].value='01000';
			    document.all("rpt_format").options[2].text='操作小计';
			    document.all("rpt_format").options[2].value='00100';
			    document.all("rpt_format").options[3].text='回馈小计';
			    document.all("rpt_format").options[3].value='00010';
			    document.all("rpt_format").options[4].text='明细+工号小计';
			    document.all("rpt_format").options[4].value='11000';
			    document.all("rpt_format").options[5].text='明细+操作小计';
			    document.all("rpt_format").options[5].value='10100';
			    document.all("rpt_format").options[6].text='明细+回馈小计';
			    document.all("rpt_format").options[6].value='10010';
			    document.all("rpt_format").options[7].text='明细+工号小计+操作小计+回馈小计';
			    document.all("rpt_format").options[7].value='11110';

				hTableName.value="rgt003";
				hParams1.value= "prc_1625_gt003_upg('"+workNo.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==11)
			{
			    document.all("rpt_format").options.length=6;
			    document.all("rpt_format").options[0].text='明细';
			    document.all("rpt_format").options[0].value='10000';
			    document.all("rpt_format").options[1].text='工号小计';
			    document.all("rpt_format").options[1].value='01000';
			    document.all("rpt_format").options[2].text='操作小计';
			    document.all("rpt_format").options[2].value='00100';
			    document.all("rpt_format").options[3].text='明细+工号小计';
			    document.all("rpt_format").options[3].value='11000';
			    document.all("rpt_format").options[4].text='明细+操作小计';
			    document.all("rpt_format").options[4].value='10100';
			    document.all("rpt_format").options[5].text='明细+工号小计+操作小计';
			    document.all("rpt_format").options[5].value='11100';

				hTableName.value="rtt003";
				hParams1.value= "prc_1625_tt003_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==14)
			{
				hTableName.value="rfo006";
				hParams1.value= "prc_1615_qqt005_upg('T','"+groupId.value+"',' ',' ','"+workNo.value+"','"+begin_login.value+"|"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";														
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==15)
			{
				hTableName.value="rfo006";
				hParams1.value= "prc_1615_qqt006_upg('T','"+groupId.value+"',' ',' ','"+workNo.value+"','"+begin_login.value+"|"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==16)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_1677_2_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==17)
			{
				hTableName.value="rfo006";
				hParams1.value= "prc_1677_002Prn_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==18)
			{
				hTableName.value="rfo006";
				hParams1.value= "prc_1676_Prn_upg('T','"+groupId.value+"',' ',' ','"+workNo.value+"','"+begin_login.value+"|"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
																														 
			else if(rpt_type.value==20)
			{
				hTableName.value="rct003";
				hParams1.value= "prc_1247_pr004_2_upg('0','"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==21)
			{
				hTableName.value="rct003";
				hParams1.value= "prc_1247_pr004_2_upg('1','"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			
			else if(rpt_type.value==23)
			{
				hTableName.value="rct003";
				hParams1.value= "prc_1247_pr006_1_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==24)
			{
				hTableName.value="rct003";
				hParams1.value= "prc_1247_pr007_1_upg('0','"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==25)
			{
				hTableName.value="rct003";
				hParams1.value= "prc_1247_pr007_1_upg('1','"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==27)
			{
				hTableName.value="rct003";
				hParams1.value= "prc_1247_pr009_1_upg('0','"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==28)
			{
				hTableName.value="rct003";
				hParams1.value= "prc_1247_pr009_1_upg('1','"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			
			else if(rpt_type.value==30)
			{
				hTableName.value="rct003";
				hParams1.value= "prc_1247_pr0011_1_upg('0','"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==31)
			{
				hTableName.value="rct003";
				hParams1.value= "prc_1247_pr0011_1_upg('1','"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==32)
			{
				hTableName.value="rct003";
				hParams1.value= "prc_1247_pr0012_1_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
				else if(rpt_type.value==33)
			{
				hTableName.value="rct003";
				hParams1.value= "prc_1247_pr0013_1_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			
			else if(rpt_type.value==35)
			{
				hTableName.value="rct003";
				hParams1.value= "prc_1247_pr0015_1_upg('"+workNo.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			
			else if(rpt_type.value==37)
			{
				hTableName.value="rct003";
				hParams1.value= "prc_1246_pr006_1_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==38)
			{
				hTableName.value="rct003";
				hParams1.value= "prc_1246_pr006_1_a_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			
			else if(rpt_type.value==47)
			{
				hTableName.value="rfo006";
				hParams1.value= "prc_9003_2_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==48)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_1250_1_upg('"+workNo.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==51)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_9006_2_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==52)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_1258_2_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==53)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_1259_2_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==54)
			{
				hTableName.value="rct003";
				hParams1.value= "prc_1625_prepayMark_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
		
			else if(rpt_type.value==57)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_1257_2_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==60)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_1255_2_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
				else if(rpt_type.value==61)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_1256_2_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			
				else if(rpt_type.value==62)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1625_pt062_upg('"+workNo.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==63)
			{
				hTableName.value="RCR3070";
				hParams1.value= "prc_3071_2_upg('"+workNo.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==64)
			{
				hTableName.value="RCR3070";
				hParams1.value=  "prc_3071_mx_2_upg('"+workNo.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==65)
			{
				hTableName.value="RCR3070";
				hParams1.value=  "prc_3072_2_upg('"+workNo.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==66)
			{
				hTableName.value="RCR3070";
				hParams1.value=  "prc_3072_mx_2_upg('"+workNo.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==67)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1625_pt067_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==68)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1625_pt068_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==69)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1397_pt068_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==70)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1625_pt070_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==71)
			{
				hTableName.value="rct003";
				hParams1.value= "PRC_126h_PR001_1_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}			
			 else if(rpt_type.value==72)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1625_pt072_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==73)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1625_pt073_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==74)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1625_pt074_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==75)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1625_pt075_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==76)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_1625_color_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==77)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_5100_pt77_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==78)
			{
				hTableName.value="RPtLUCK52";
				hParams1.value= "prc_1625_luck52_1_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==79)
			{
				hTableName.value="rsr001";
				hParams1.value= "prc_1625_Batter_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==80)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1625_pt080_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==81)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1625_pt081_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==82)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1625_pt082_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==83)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1625_pt083_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==84)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1625_pt084_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==85)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1625_pt085_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
   			
			else if(rpt_type.value==87)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_2281_2_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==88)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1625_pt088_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==89)
			{
				hTableName.value="rjo005";
				hParams1.value= "PRC_1444_CX023_upg('"+workNo.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==90)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1625_pt090_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==91)
			{
				hTableName.value="rcr001";
				hParams1.value= "prc_1247_pr091_2_upg('0','"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==92)
			{
				hTableName.value="rcr001";
				hParams1.value= "prc_1247_pr091_2_upg('1','"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==93)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_8038_2_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==94)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_1625_94_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==95)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1625_pt095_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==96)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1625_pt096_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==97)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1625_pt097_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==98)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1625_pt098_upg('"+workNo.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==99)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1625_pt099_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}				
			else if(rpt_type.value==100)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1625_pt100_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			
			 else if(rpt_type.value==101)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1625_pt101_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==102)
			{
				hTableName.value="RPtLUCK52";
				hParams1.value= "prc_1625_midfest_1_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==103)
			{
				hTableName.value="RPtLUCK52";
				hParams1.value= "prc_1625_midfest_2_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==104)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1625_pt0104_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==105)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1625_pt0105_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==107)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_2289_jf_2_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==108)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1499_rpt25_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==109)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_7115_rpt25_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}   
			else if(rpt_type.value==110)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1625_pt0110_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}						
			else if(rpt_type.value==111)
			{
				hTableName.value="rfo006";
				hParams1.value= "prc_2268pay_rpt_upg('T','"+groupId.value+"',' ',' ','"+workNo.value+"','"+begin_login.value+"|"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==112)
			{
				hTableName.value="rfo006";
				hParams1.value= "prc_2269pay_rpt_upg('0','T','"+groupId.value+"',' ',' ','"+workNo.value+"','"+begin_login.value+"|"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}										
			else if(rpt_type.value==113)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_3286_tj2_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==114)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_3286_mx2_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==115)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_2281_tj2_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";
			}
			else if(rpt_type.value==116)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_2281_mx2_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";
			}	
			else if(rpt_type.value==119)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1469_rpt25_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
			 	action="print_rpt_crm.jsp";}
			else if(rpt_type.value==120)
			{
				hTableName.value="RPtLUCK52";
				hParams1.value= "prc_1625_luck52_11_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==121)
			{
				hTableName.value="rct003";
				hParams1.value= "prc_1625_pr121_mx_upg('0','"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==122)
			{
				hTableName.value="rct003";
				hParams1.value= "prc_1625_pr121_mx_upg('1','"+workNo.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==123)
			{
				hTableName.value="rct003";
				hParams1.value= "prc_1625_pr123_mx_upg('0','"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==124)
			{
				hTableName.value="rct003";
				hParams1.value= "prc_1625_pr123_mx_upg('1','"+workNo.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==125)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1469_rpt25_1_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==126)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_8030_pt126_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==127)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_8032_pt127_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			 else if(rpt_type.value==128)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1625_pt0128_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";} 
			else if(rpt_type.value==129)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1625_pt0129_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==130)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1625_pt0130_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==132)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_5100_pt77_tj_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==133)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1625_pt0133_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==135)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1625_pt0135_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==136)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1625_pt0136_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==137)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1625_pt0137_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==140)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1625_pt0140_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==141)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1104_rpt01_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==142)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1104_rpt02_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==143)
			{
				hTableName.value="rpd002";
				hParams1.value= "prc_1625_rpt143_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			
			else if(rpt_type.value==145)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1625_rpt145_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==146)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1625_rpt146_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==148)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1625_rpt148_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			
			
			else if(rpt_type.value==151)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1625_151_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==152)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1625_152_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==153)
  			{
  				hTableName.value="rpt003";
				hParams1.value= "prc_1625_rpt153_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==154)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1625_154_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==155)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1625_7955_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==156)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1625_7956_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==157)
			{
					hTableName.value="rbr001";
				hParams1.value= "prc_1625_160_urg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==158)
			{
					hTableName.value="rbr001";
				hParams1.value= "prc_1625_4a00_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==160)
			{
					hTableName.value="rpt003";
				hParams1.value= "prc_1625_jtdqzl_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==161)
			{
					hTableName.value="rpt003";
				hParams1.value= "prc_1625_jtcqzl_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==162)
			{
					hTableName.value="rbo006";
				hParams1.value= "prc_1625_gprsSale_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==163)
			{
					hTableName.value="rbo006";
				hParams1.value= "prc_1625_gprsSaleCard_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";} 
				else if(rpt_type.value==164)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1625_wpaybc_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			
			else if(rpt_type.value==165)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1625_pt165_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==166)
			{
					hTableName.value="rbo006";
				hParams1.value= "prc_1625_pt166_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			
			else if(rpt_type.value==168)
			{
					hTableName.value="rbo006";
				hParams1.value= "prc_1625_pt168_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			 else if(rpt_type.value==169)
			{
					hTableName.value="rbo006";
				hParams1.value= "prc_1625_pt169_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==170)
			{
					hTableName.value="rbo006";
				hParams1.value= "prc_1625_pt170_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			
			else if(rpt_type.value==175)
			{
					hTableName.value="rpt003";
				hParams1.value= "prc_1625_pt175_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";				
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==176)
			{
					hTableName.value="rbo006";
				hParams1.value= "prc_1625_pt176_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			
			
			else if(rpt_type.value==179)
			{
					hTableName.value="rbo006";
				hParams1.value= "prc_1625_pt179_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==180)
			{
				hTableName.value="rbo006";
				hParams1.value= "prc_1625_TD180_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==181)
			{
					hTableName.value="rbo006";
				hParams1.value= "prc_1625_TD181_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==182)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1625_pt182_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==183)
			{
					hTableName.value="rbo006";
				hParams1.value= "prc_1625_pt183_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==184)
			{
					hTableName.value="rbo006";
				hParams1.value= "prc_1625_pt6343_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
				
				else if(rpt_type.value==185)
	    {
	      	hTableName.value="rbo006";
	    	hParams1.value= "prc_1625_7671_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
	    	action="print_rpt_crm.jsp";
	    }
	    else if(rpt_type.value==187)
	    {
	      	hTableName.value="rpt003";
	    	hParams1.value= "prc_1625_pt187_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
	    	action="print_rpt_crm.jsp";
	    }
	    else if(rpt_type.value==188)
	    {
	      hTableName.value="rfo006";
	      hParams1.value= "prc_1625_pr188_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
	      action="print_rpt_crm.jsp";
	    }
	    
	     else if(document.form1.rpt_type.value==189)
	    {//20101019关于绥化分公司针对特定客户预存话费赠G3无线座机的需求@jingang@189-191
	      hTableName.value="rbo006";
	      hParams1.value= "prc_1625_TD182_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.begin_login.value+"','"+document.form1.end_login.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"'";
	    	action="print_rpt_crm.jsp";
	    }
	    else if(document.form1.rpt_type.value==190)
	    {
	      hTableName.value="rbo006";
	      hParams1.value= "prc_1625_TD183_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.begin_login.value+"','"+document.form1.end_login.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"'";
	  		action="print_rpt_crm.jsp";
	    }
	    else if(document.form1.rpt_type.value==191)
	    {
	      hTableName.value="rbo006";
	      hParams1.value= "prc_1625_7672_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.begin_login.value+"','"+document.form1.end_login.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"'";
				action="print_rpt_crm.jsp";
	    }
	    
	     //20100927-17:21关于哈尔滨分公司开展预存话费赠黑莓终端营销活动相关内容的请示@jingang
	    else if(document.form1.rpt_type.value==192)
	    {
	      hTableName.value="rbo006";
	      hParams1.value= "prc_1625_7673_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.begin_login.value+"','"+document.form1.end_login.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"'";
	    	action="print_rpt_crm.jsp";
	    }
	    //20101012 add lichaoa 关于查询用户以“三码合一”方式销售G3手机的信息及丢失重购的需求
	    else if(rpt_type.value==194)
	    {
	      	hTableName.value="rbt003";
	      	hParams1.value= "prc_1625_b632_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
		  	action="print_rpt_crm.jsp";
	    }
	    else if(document.form1.rpt_type.value==198)
	    {//20101207营业厅电子化工单打印统计表
	      hTableName.value="rbt003";
	      hParams1.value= "prc_1625_hwprt_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.begin_login.value+"','"+document.form1.end_login.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"'";
	    	action="print_rpt_crm.jsp";
	    } 
	    else if(document.form1.rpt_type.value==199)
			{//20101228新老报表改造，新增对应老报表166
				hTableName.value="dbo005";
				hParams1.value= "prc_1625_newsale_mx_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.begin_login.value+"','"+document.form1.end_login.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"'";
				action="print_rpt_crm.jsp";
			}
			else if(document.form1.rpt_type.value==200)
			{//20101228新老报表改造，新增对应老报表167
				hTableName.value="dbo005";
				hParams1.value= "prc_1625_newsale_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.begin_login.value+"','"+document.form1.end_login.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"'";
				action="print_rpt_crm.jsp";
			} 
			
			
			else if(document.form1.rpt_type.value==201)
			 {//20101228新老报表改造，新增对应老报表155
				hTableName.value="rbo006";
				hParams1.value= "PRC_1625_makeUpSim_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.begin_login.value+"','"+document.form1.end_login.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"'";
				action="print_rpt_crm.jsp";
			} 
	    else if(document.form1.rpt_type.value==202)
	    {//签约优惠购机需求
	      hTableName.value="rbo006";
	      hParams1.value= "PRC_2147_d069_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.begin_login.value+"','"+document.form1.end_login.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"'";
	    	action="print_rpt_crm.jsp";
	    }
	    else if(document.form1.rpt_type.value==203)
	    {//签约优惠购机需求
	      hTableName.value="rbo006";
	      hParams1.value= "PRC_2147_2285_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.begin_login.value+"','"+document.form1.end_login.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"'";
	    	action="print_rpt_crm.jsp";
	    }
	
	    else if(document.form1.rpt_type.value==205)
	    {
	    	//SIM卡使用量的查询明细报表
			hTableName.value="rpt003";
			hParams1.value= "PRC_1625_1104_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.begin_login.value+"','"+document.form1.end_login.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"'";
	    	action="print_rpt_crm.jsp";
	    }
	    else if(document.form1.rpt_type.value==206)
	    {//jingang@20110324@关于进一步完善工号管理的需求(授权稽核报表)@营业厅稽核日表
	      hTableName.value="rbo006";
	      hParams1.value= "prc_jyytjhrb_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.begin_login.value+"','"+document.form1.end_login.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"'";
	    	action="print_rpt_crm.jsp";
	    }
	    else if(document.form1.rpt_type.value==207)
	    {//wanghfa添加 2011/5/19 16:29 欢乐家庭需求
	      hTableName.value="rbo006";
	      hParams1.value= "prc_2147_d570_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.begin_login.value+"','"+document.form1.end_login.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"'";
	    	action="print_rpt_crm.jsp";
	    }
	    else if(document.form1.rpt_type.value==208)
	    {//ningtn添加 2011/6/13 营业厅TD固话补卡统计表
	      hTableName.value="rbo006";
	      hParams1.value= "prc_2147_208_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.begin_login.value+"','"+document.form1.end_login.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"'";
	    	action="print_rpt_crm.jsp";
	    }
	    else if(document.form1.rpt_type.value==209)
	    {//huangrong add  209->营业厅预存话费领奖明细报表
	      hTableName.value="rbo006";
	      hParams1.value= "prc_2147_209_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.begin_login.value+"','"+document.form1.end_login.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"'";
	    	action="print_rpt_crm.jsp";
	    }
	    else if(document.form1.rpt_type.value==210)	 
	    {
	      //alert("111");
		  hTableName.value="rbo006";
			    hParams1.value= "DBCUSTADM.prc_2147_210_upg_new('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.begin_login.value+"','"+document.form1.end_login.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"'";
				action="print_rpt_boss.jsp";
	    } 
	    else if(document.form1.rpt_type.value==213)	//fusk R_CMI_HLJ_xueyz_2014_1524671@关于报送2014年3月业务支撑系统市场专业需求的函-优化2355强开界面的需求
	    {
	      hTableName.value="RPT2266";
	      hParams1.value= "PRC_2147_RPT213_UPG('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.begin_login.value+"','"+document.form1.end_login.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"'";
	    	action="print_rpt_crm.jsp";
	    }

	   	else if(document.form1.rpt_type.value==318)	
	    {
	      hTableName.value="rbo006";
	      hParams1.value= "prc_2147_318_upg('"+document.form1.workNo.value+"','"
										      +document.form1.groupId.value+"','"
										      +document.form1.begin_login.value+"','"
										      +document.form1.end_login.value+"','"
										      +document.form1.begin_time.value+"','"
										      +document.form1.end_time.value+"'";
	    	action="print_rpt_crm.jsp";
	    }
	    else if(document.form1.rpt_type.value==319)	//2011/11/16 diling增加 营业厅sim补卡统计报表
	    {
	      hTableName.value="rbo006";
	      hParams1.value= "prc_2147_319_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.begin_login.value+"','"+document.form1.end_login.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"'";
	    	action="print_rpt_crm.jsp";
	    }
	    else if(document.form1.rpt_type.value==320)	//2011/12/20 wanghfa增加 营业厅合约计划营销案报表
	    {
	      hTableName.value="rcr001";
	      hParams1.value= "prc_2147_320_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.begin_login.value+"','"+document.form1.end_login.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"'";
	    	action="print_rpt_crm.jsp";
	    }
	    else if(document.form1.rpt_type.value==321)	//2011/01/05 wanghyd增加 营业厅自备机合约营销案报表
	    {
	      hTableName.value="rcr001";
	      hParams1.value= "prc_2147_321_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.begin_login.value+"','"+document.form1.end_login.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"'";
	    	action="print_rpt_crm.jsp";
	    }
	    else if(document.form1.rpt_type.value==322)	//2011/01/05 wanghyd增加 营业厅自备机合约营销案报表
	    {
	      hTableName.value="rcr001";
	      hParams1.value= "prc_2147_322_upg('"+document.form1.workNo.value+"','"
	      	+document.form1.groupId.value+"','"
	      	+document.form1.begin_login.value+"','"
	      	+document.form1.end_login.value+"','"
	      	+document.form1.begin_time.value+"','"
	      	+document.form1.end_time.value+"'";
	    	action="print_rpt_crm.jsp";
	    }	
	    	    	    else if(document.form1.rpt_type.value==325)	//2012/06/25 增加 报表名称：营业厅修改IMEI绑定关系统计报表
	    {
	      hTableName.value="rcr001";
	      hParams1.value= "prc_2147_325_upg('"+document.form1.workNo.value+"','"
	      	+document.form1.groupId.value+"','"
	      	+document.form1.begin_login.value+"','"
	      	+document.form1.end_login.value+"','"
	      	+document.form1.begin_time.value+"','"
	      	+document.form1.end_time.value+"'";
	    	action="print_rpt_crm.jsp";
	    }  
	   else if(document.form1.rpt_type.value==327)	//2012/06/25 增加 报表名称：营业厅修改IMEI绑定关系统计报表
	    {
	      hTableName.value="rcr001";
	      hParams1.value= "prc_2147_327_upg('"+document.form1.workNo.value+"','"
	      	+document.form1.groupId.value+"','"
	      	+document.form1.begin_login.value+"','"
	      	+document.form1.end_login.value+"','"
	      	+document.form1.begin_time.value+"','"
	      	+document.form1.end_time.value+"'";
	    	action="print_rpt_crm.jsp";
	    }     	    
			else if(document.form1.rpt_type.value==328)	//wanghyd 2012/9/24 11:18
			{
				hTableName.value="rbo006";
				hParams1.value= "prc_1625_TD328_upg('"+document.form1.workNo.value+"','"
				+document.form1.groupId.value+"','"
				+document.form1.begin_login.value+"','"
				+document.form1.end_login.value+"','"
				+document.form1.begin_time.value+"','"
				+document.form1.end_time.value+"'";
				action="print_rpt_crm.jsp";
			} 
			else if(document.form1.rpt_type.value==330)	//wanghyd 2012/9/24 11:18
			{
				hTableName.value="rcr001";
				hParams1.value= "prc_2147_330_upg('"
				+document.form1.workNo.value+"','"
				+document.form1.groupId.value+"','"
				+document.form1.begin_login.value+"','"
				+document.form1.end_login.value+"','"
				+document.form1.begin_time.value+"','"
				+document.form1.end_time.value+"'";
				action="print_rpt_crm.jsp";
			} 	
			else if(document.form1.rpt_type.value==331)	//2013-1-10 9:01:06 liujian增加 营业厅sim补卡统计报表
		    {
		      hTableName.value="rpt003";
		      hParams1.value= "prc_2147_331_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.begin_login.value+"','"+document.form1.end_login.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"'";
		    	action="print_rpt_crm.jsp";
		    }	
				else if(document.form1.rpt_type.value==332)	//zhouby
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_2147_332_upg('"
				+document.form1.workNo.value+"','"
				+document.form1.groupId.value+"','"
				+document.form1.begin_login.value+"','"
				+document.form1.end_login.value+"','"
				+document.form1.begin_time.value+"','"
				+document.form1.end_time.value+"'";
				action="print_rpt_crm.jsp";
			}
			else if(document.form1.rpt_type.value==335)	//2013/07/16 9:03:58 gaopeng 终端折扣购宽带统计报表(关于协助配置齐齐哈尔公司购终端打折购宽带营销方案的函)
		    {
		      hTableName.value="rpt003";
		      hParams1.value= "prc_2147_335_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.begin_login.value+"','"+document.form1.end_login.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"'";
		    	action="print_rpt_crm.jsp";
		    }
		  else if(document.form1.rpt_type.value==337)
			{
				hTableName.value="rbo006";
				hParams1.value= "prc_2147_337_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.begin_login.value+"','"+document.form1.end_login.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"'";
		    action="print_rpt_crm.jsp";
			}	 	
			else if(document.form1.rpt_type.value==346)
			{
				hTableName.value="rbo006";
				hParams1.value= "prc_2147_346_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.begin_login.value+"','"+document.form1.end_login.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"'";
		    action="print_rpt_crm.jsp";
			}
						else if(document.form1.rpt_type.value==347)
			{
				hTableName.value="rbo006";
				hParams1.value= "prc_2147_347jfzz_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.begin_login.value+"','"+document.form1.end_login.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"'";
		    action="print_rpt_crm.jsp";
			}
			else if(document.form1.rpt_type.value==349)
			{
				hTableName.value="rbo006";
				hParams1.value= "prc_2147_349_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.begin_login.value+"','"+document.form1.end_login.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"'";
		    action="print_rpt_crm.jsp";
			}
			else if(document.form1.rpt_type.value==350)
			{
				hTableName.value="rbo006";
				hParams1.value= "prc_2147_350_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.begin_login.value+"','"+document.form1.end_login.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"'";
		    action="print_rpt_crm.jsp";
			}
			else if(document.form1.rpt_type.value==351)
			{
				hTableName.value="rbo006";
				hParams1.value= "prc_2147_351_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.begin_login.value+"','"+document.form1.end_login.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"'";
		    action="print_rpt_crm.jsp";
			}
			else if(document.form1.rpt_type.value==356)
			{
				hTableName.value="rpt008";
				hParams1.value= "prc_2147_356JT_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.begin_login.value+"','"+document.form1.end_login.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"'";
		    action="print_rpt_crm.jsp";
			}
			else if(document.form1.rpt_type.value==358)	
	    {
	      hTableName.value="rcr001";
	      hParams1.value= "prc_2147_358_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.begin_login.value+"','"+document.form1.end_login.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"'";
	    	action="print_rpt_crm.jsp";
	    }	else if(rpt_type.value==359)
			{
				hTableName.value="rcr001";
				hParams1.value= "prc_2147_359_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.begin_login.value+"','"+document.form1.end_login.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"'";
				action="print_rpt_crm.jsp";
			}	else if(rpt_type.value==361)
			{
				hTableName.value="rbo005";
				hParams1.value= "prc_2147_361_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.begin_login.value+"','"+document.form1.end_login.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"'";
				action="print_rpt_crm.jsp";
			}else if(rpt_type.value==362)
			{
				hTableName.value="rbo005";
				hParams1.value= "prc_2147_362_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.begin_login.value+"','"+document.form1.end_login.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"'";
				action="print_rpt_crm.jsp";
			}
			else if(rpt_type.value==368)
			{
				hTableName.value="rbo006";
				hParams1.value= "prc_2417_368_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.begin_login.value+"','"+document.form1.end_login.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"'";
				action="print_rpt_crm.jsp";
			}
			else if(rpt_type.value==370)
			{
				hTableName.value="rbo006";
				hParams1.value= "prc_2417_370_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.begin_login.value+"','"+document.form1.end_login.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"'";
				action="print_rpt_crm.jsp";
			}
			
		}
	}
}
