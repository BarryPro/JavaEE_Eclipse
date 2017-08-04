//wanghfa 20100602 crm维护的报表调用此方法，参数statement是页面form对象
function select_crm(statement)
{
	if(statement)
	{
		with(statement)
		{   
			 
			if(rpt_type.value==3)
			{
				hTableName.value="rsr001";
				hParams1.value= "prc_1640_sr001_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==6)
			{
				hTableName.value="rtr001";
				hParams1.value= "prc_1640_tr001_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==7)
			{
				hTableName.value="rvr001";
				hParams1.value= "prc_1640_vr001_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==8)
			{
				hTableName.value="rjr001";
				hParams1.value= "prc_1640_jr001_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==9)
			{
				hTableName.value="ryr001";
				hParams1.value= "prc_1640_yr001_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			
			else if(rpt_type.value==11)
			{
				hTableName.value="rtr001";
				hParams1.value= "prc_1640_tr001_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==14)
			{
				hTableName.value="rfo006";
				hParams1.value= "prc_1640_qqt006_upg('"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+workNo.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
				else if(rpt_type.value==15)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_1677_4_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
				else if(rpt_type.value==21)
			{
				hTableName.value="rcr001";
				hParams1.value= "prc_1247_pr005_3_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			
			else if(rpt_type.value==16)
			{
				hTableName.value="rfo006";
				hParams1.value= "prc_1677_004Prn_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==17)
			{
				hTableName.value="rfo006";
				hParams1.value= "prc_1676_Prn_upg('"+rptRight.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+workNo.value+"','aaaaaa','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			                                    
			else if(rpt_type.value==19)
			{
				hTableName.value="rcr001";
				hParams1.value= "prc_1247_pr004_4_upg('0','"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==20)
			{
				hTableName.value="rcr001";
				hParams1.value= "prc_1247_pr004_4_upg('1','"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			
			else if(rpt_type.value==23)
			{
				hTableName.value="rcr001";
				hParams1.value= "prc_1247_pr007_3_upg('0','"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==24)
			{
				hTableName.value="rcr001";
				hParams1.value= "prc_1247_pr007_3_upg('1','"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==25)
			{
				hTableName.value="rcr001";
				hParams1.value= "prc_1247_pr009_3_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			
			
			else if(rpt_type.value==29)
			{
				hTableName.value="rcr001";
				hParams1.value= "prc_1247_pr0012_3_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
				else if(rpt_type.value==30)
			{
				hTableName.value="rcr001";
				hParams1.value= "prc_1247_pr0013_3_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
		
			else if(rpt_type.value==33)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_1247_pr0016_3_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			
			else if(rpt_type.value==35)
			{
				hTableName.value="rcr001";
				hParams1.value= "prc_1246_4_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			
			else if(rpt_type.value==40)
			{
				hTableName.value="rfo006";
				hParams1.value= 
				"prc_9003_4_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			
			
			
			
			else if(rpt_type.value==48)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_9005_4_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==49)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_9006_4_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==50)
			{
				hTableName.value="rsr001";
				hParams1.value= "prc_1640_Batter_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==51)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_1258_4_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==52)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_1259_4_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==53)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_1640_prepayMark_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm.jsp";}
			
			else if(rpt_type.value==56)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_1257_4_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==58)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_1247_pr058_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==59)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_1255_4_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==61)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_1247_pr061_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==62)
			{
				hTableName.value="RCR3070";
				hParams1.value= "prc_3071_4_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==63)
			{
				hTableName.value="RCR3070";
				hParams1.value= "prc_3071_mx_4_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==64)
			{
				hTableName.value="RCR3070";
				hParams1.value= "prc_3072_4_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==65)
			{
				hTableName.value="RCR3070";
				hParams1.value= "prc_3072_mx_4_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==66)
			{
				hTableName.value="RCR3070";
				hParams1.value= "prc_3073_4_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==67)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_1247_pr067_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==68)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_1247_pr068_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==69)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1397_pt066_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==70)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1397_pt065_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==71)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_credit_pt003_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==72)
			{
				hTableName.value="rcr001";
				hParams1.value= "PRC_126h_PR001_3_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}    
			else if(rpt_type.value==73)
			{
				hTableName.value="rcr001";
				hParams1.value= "PRC_126h_PR002_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==74)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_2417_pt074_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";} 
			
			else if(rpt_type.value==80)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_1247_pr080_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==81)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_1247_pr081_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==82)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_1247_pr082_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==84)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_1640_color_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==85)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_5100_pt85_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==86)
			{
				hTableName.value="RPtLUCK52";
				hParams1.value= "prc_1640_luck52_1_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==87)
			{
				hTableName.value="RPtLUCK52";
				hParams1.value= "prc_1640_luck52_2_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==88)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_1247_pr088_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==89)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_1247_pr089_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==92)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_1247_pr092_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==93)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_1247_pr093_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			
			else if(rpt_type.value==95)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_2281_4_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==96)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_1247_pr096_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==97)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_1256_4_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==98)
			{
				hTableName.value="RPtLUCK52";
				hParams1.value= "PRC_1444_CX011_upg('"+workNo.value+"','"+groupId.value+"','"+bgroupId.value+"','"+egroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==99)
			{
				hTableName.value="rjo005";
				hParams1.value= "PRC_1444_CX025_upg('"+workNo.value+"','"+groupId.value+"','"+bgroupId.value+"','"+egroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==100)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_1247_pr0100_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==101)
			{
				hTableName.value="rcr001";
				hParams1.value= "prc_1247_pr0101_upg('0','"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==102)
			{
				hTableName.value="rcr001";
				hParams1.value= "prc_1247_pr0101_upg('1','"+workNo.value+"','"+groupId.value+"','"+bgroupId.value+"','"+egroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==103)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_1640_pr0103_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==104)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_1640_pr0104_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==105)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_8038_mx_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==106)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_8038_4_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==107)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_1247_pr0107_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==109)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_2289_jf_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==112)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_1247_pr0112_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==113)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_1247_pr0113_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==114)
			{
				hTableName.value="RPtLUCK52";
				hParams1.value= "prc_1640_midfest_1_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==115)
			{
				hTableName.value="RPtLUCK52";
				hParams1.value= "prc_1640_midfest_2_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==116)
			{
				hTableName.value="RPtLUCK52";
				hParams1.value= "prc_1640_midfest_3_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==117)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_1247_pr0117_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			
			else if(rpt_type.value==118)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_1247_pr0118_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==119)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1499_rpt40_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==120)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_7115_rpt40_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==121)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_1247_pr0121_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==122)
			{
				hTableName.value="rfo006";
				hParams1.value= "prc_2268pay_rpt_upg('"+rptRight.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+workNo.value+"',' ','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==123)
			{
				hTableName.value="rfo006";
				hParams1.value= "prc_2269pay_rpt_upg('0','"+rptRight.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+workNo.value+"',' ','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}									  
			else if(rpt_type.value==124)
			{
				hTableName.value="rfo006";
				hParams1.value= "prc_2269pay_rpt_upg('1','"+rptRight.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+workNo.value+"',' ','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==125)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_3286_tj4_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==126)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_3286_mx4_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==127)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_2281_tj4_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==128)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_2281_mx4_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==131)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1469_rpt40_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==132)
			{
				hTableName.value="RPtLUCK52";
				hParams1.value= "prc_1640_luck52_11_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==133)
			{
				hTableName.value="RPtLUCK52";
				hParams1.value= "prc_1640_luck52_21_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			
			else if(rpt_type.value==134)
			{
				hTableName.value="rcr001";
				hParams1.value= "prc_1640_pr134_upg('0','"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==135)
			{
				hTableName.value="rcr001";
				hParams1.value= "prc_1640_pr134_upg('1','"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==136)
			{
				hTableName.value="rcr001";
			
				hParams1.value= "prc_1640_pr136_mx_upg('0','"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==137)
			{
				hTableName.value="rcr001";
				hParams1.value= "prc_1640_pr136_mx('1','"+workNo.value+"','"+groupId.value+"','"+bgroupId.value+"','"+egroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==138)
			{
				hTableName.value="rpt003";
				hParams1.value="prc_1469_rpt40_1_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==141)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_8030_pr141_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==142)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_8032_pr142_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==143)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_1247_pr0143_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==144)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_1788_pr0144_upg('"+workNo.value+"','"+region_code.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==146)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_5100_pt85_tj_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==147)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_1247_pr0147_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==149)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_1247_pr0149_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==150)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_1247_pr0150_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==152)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_1247_pr0152_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==154)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_1247_pr0154_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==155){
				hTableName.value="rpt003";
				hParams1.value= "prc_1104_rpt04_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==156){
				hTableName.value="rpt003";
				hParams1.value= "prc_1104_rpt05_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==157){
				hTableName.value="rpd002";
				hParams1.value= "prc_1640_rpt157_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
				
				
				
				else if(rpt_type.value==159)
			{
				hTableName.value="RBT001";
				hParams1.value= "prc_1640_BT001_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
				else if(rpt_type.value==163)
			{
				hTableName.value="RBW001";
				hParams1.value= "prc_1640_BW001_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
				else if(rpt_type.value==180)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_1247_pr0168_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==181)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_1247_pr0169_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			
			else if(rpt_type.value==160)
			{
				hTableName.value="rbt002";
				hParams1.value= "PRC_1640_BT002_UPG('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==161)
			{
				hTableName.value="RBV001";
				hParams1.value= "prc_1640_BV001_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==162)
			{
				hTableName.value="RBU001";
				hParams1.value= "prc_1640_BU001_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			
			else if(rpt_type.value==164)
			{
				hTableName.value="RBW002";
				hParams1.value= "PRC_1640_BW002_UPG('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
				
			
			else if(rpt_type.value==166)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_1247_pr164_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			
			else if(rpt_type.value==168)
			{
				hTableName.value="rjo005";
				hParams1.value= "PRC_1247_PR164_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==169)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1640_rpt160_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==171)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_1247_pr0166_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==172)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_1247_pr0172_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==173)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_1640_7955_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==174)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_1640_7956_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==177)
			{
				hTableName.value="rbr001";
				hParams1.value= "prc_1640_177_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==178)
			{
				hTableName.value="rbr001";
				hParams1.value= "prc_1640_178_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==179)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_1247_pr0167_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			
			else if(rpt_type.value==182)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_1247_pr0182_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==183)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_1247_pr0183_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==184)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_1247_pr0184_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==186)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_1247_pr0186_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==187)
			{
				hTableName.value="rcr001";
				hParams1.value= "prc_1640_gprsSale_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==188)
			{
				hTableName.value="rcr001";
				hParams1.value= "prc_1640_gprsSaleCard_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==189)
			{
				hTableName.value="rpr001";
				hParams1.value= "prc_1640_wpaybc_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==190)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_1247_pr190_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==191)
			{
				hTableName.value="rcr001";
				hParams1.value= "prc_1247_pr191_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==192)
			{
				hTableName.value="rcr001";
				hParams1.value= "prc_1247_pr192_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==193)
			{
				hTableName.value="rcr001";
				hParams1.value= "prc_1247_pr193_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==194)
			{
				hTableName.value="rcr001";
				hParams1.value= "prc_1247_pr194_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==195)
			{
				hTableName.value="rcr001";
				hParams1.value= "prc_1247_pr195_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}	
			else if(rpt_type.value==196)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_1247_pr196_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==197)
			{
				hTableName.value="rcr001";
				hParams1.value= "prc_1247_pr197_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==198)
			{
				hTableName.value="rcr001";
				hParams1.value= "prc_1247_pr198_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			
			
			else if(rpt_type.value==201)
			{
				hTableName.value="rcr001";
				hParams1.value= "prc_1247_pr201_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==202)
			{
				hTableName.value="rcr001";
				hParams1.value= "prc_1640_TD202_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==203)
			{
				hTableName.value="rcr001";
				hParams1.value= "prc_1640_TD203_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==204)
			{
				hTableName.value="rcr001";
				hParams1.value= "prc_1640_TD204_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==205)
			{
				hTableName.value="rcr001";
				hParams1.value= "prc_1247_pr205_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==206)
			{
				hTableName.value="rcr001";
				hParams1.value= "prc_1640_7671_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==207)
			{
				hTableName.value="rcr001";
				hParams1.value= "prc_1640_7955zj_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==208)
			{
				hTableName.value="rcr001";
				hParams1.value= "prc_1640_7955hz_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
				
				
				

	else if(rpt_type.value==211)
    {
      hTableName.value="rcr001";
      hParams1.value= "prc_1640_pr211_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
      action="print_rpt_crm.jsp";
    }
	else if(rpt_type.value==212)
    {
      hTableName.value="rjo005";
      hParams1.value= "prc_1640_pr212_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
      action="print_rpt_crm.jsp";
    }
	else if(rpt_type.value==213)
  	{
      hTableName.value="rjo005";
      hParams1.value= "prc_1640_pr213_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
      action="print_rpt_crm.jsp";
  	}
  	else if(rpt_type.value==214)
  	{
      hTableName.value="rjo005";
      hParams1.value= "prc_1640_pr214_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
      action="print_rpt_crm.jsp";
  	}
  	else if(rpt_type.value==215)
  	{
      hTableName.value="rcr001";
	  hParams1.value= "prc_1640_7955hz_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
	  action="print_rpt_crm.jsp";
  	}
  	else if(rpt_type.value==216)
  	{
      hTableName.value="rcr001";
	  hParams1.value= "prc_1640_7955zj_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
	  action="print_rpt_crm.jsp";
  	}
  	else if(rpt_type.value==217)
    	{
     		 hTableName.value="rfo006";
      		hParams1.value= "prc_1640_pr217_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
      		action="print_rpt_crm.jsp";
   		 }
   		 
   		 else if(rpt_type.value==218)
    	{
     		 hTableName.value="rcr001";
      		hParams1.value= "prc_1640_pr218_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
      		action="print_rpt_crm.jsp";
   		 }
  	     else if(document.form1.rpt_type.value==220)
		    {
				hTableName.value="rcr001";
				hParams1.value= "prc_1640_TD205_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.bGroupId.value+"','"+document.form1.eGroupId.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"' ";
				action="print_rpt_crm.jsp";
			}
			else if(document.form1.rpt_type.value==225)
		    {
				hTableName.value="rcr001";
				hParams1.value= "PRC_1640_TD210_UPG('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.bGroupId.value+"','"+document.form1.eGroupId.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"' ";
				action="print_rpt_crm.jsp";
			}
			else if(document.form1.rpt_type.value==226)
		    {
				hTableName.value="rcr001";
				hParams1.value= "prc_1640_7672_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.bGroupId.value+"','"+document.form1.eGroupId.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"' ";
				action="print_rpt_crm.jsp";
			}
  	     
	   else if(document.form1.rpt_type.value==221)
	    {   //20100927-17:21关于哈尔滨分公司开展预存话费赠黑莓终端营销活动相关内容的请示@jingang
					hTableName.value="rcr001";
					hParams1.value= "prc_1640_7673_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.bGroupId.value+"','"+document.form1.eGroupId.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"' ";
					action="print_rpt_crm.jsp";
			}
						 else if(document.form1.rpt_type.value==227)
	    {   //20101028-17:21关于增加地区免密码查询详单操作统计明细报表的需求@jingang
					hTableName.value="rpo006";//rpo006
					hParams1.value= "prc_1640_jg001_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.bGroupId.value+"','"+document.form1.eGroupId.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"' ";
					action="print_rpt_crm.jsp";
			}
			else if(document.form1.rpt_type.value==232)
		    {
				hTableName.value="rbo006";
				hParams1.value= "PRC_2149_d069_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.bGroupId.value+"','"+document.form1.eGroupId.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"' ";
				action="print_rpt_crm.jsp";
			}
			else if(document.form1.rpt_type.value==233)
		    {
				hTableName.value="rbo006";
				hParams1.value= "PRC_2149_2285_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.bGroupId.value+"','"+document.form1.eGroupId.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"' ";
				action="print_rpt_crm.jsp";
			}
			else if(document.form1.rpt_type.value==234)
		  {//ningtn IMEI重新绑定
				hTableName.value="rbo006";
				hParams1.value= "prc_8090_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.bGroupId.value+"','"+document.form1.eGroupId.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"' ";
				action="print_rpt_crm.jsp";
			}
			else if(document.form1.rpt_type.value==236)
		  {
		  		//SIM卡使用量的查询明细报表
				hTableName.value="rpt003";
				hParams1.value= "prc_1640_1104_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.bGroupId.value+"','"+document.form1.eGroupId.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"' ";
				action="print_rpt_crm.jsp";
			}
			else if(document.form1.rpt_type.value==237)
		  {//jingang@20110324@关于进一步完善工号管理的需求(授权稽核报表)@地区稽核月表
				hTableName.value="rcr001";
				hParams1.value= "prc_jdqjhyb_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.bGroupId.value+"','"+document.form1.eGroupId.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"' ";
				action="print_rpt_crm.jsp";
			}
			else if(document.form1.rpt_type.value==238)
		  {//fusk R_CMI_HLJ_xueyz_2014_1524671@关于报送2014年3月业务支撑系统市场专业需求的函-优化2355强开界面的需求
				hTableName.value="RPT2266";
				hParams1.value= "PRC_2149_RPT238_UPG('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.bGroupId.value+"','"+document.form1.eGroupId.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"' ";
				action="print_rpt_crm.jsp";
			}
		
			else if(document.form1.rpt_type.value==308)
		  {
		  	//huangrong add VIP候车室明细 2011-4-8
				hTableName.value="rcr001";
				hParams1.value= "prc_2149_b878mx_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.bGroupId.value+"','"+document.form1.eGroupId.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"' ";
				action="print_rpt_crm.jsp";
			}
			else if(document.form1.rpt_type.value==309)
		  {
		  	//huangrong add 地市VIP候车服务省内统计表 2011-4-8 
				hTableName.value="rcr001";
				hParams1.value= "prc_2149_b878inner_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.bGroupId.value+"','"+document.form1.eGroupId.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"' ";
				action="print_rpt_crm.jsp";
			}
			else if(document.form1.rpt_type.value==310)
		  {
		  	//huangrong add 地市VIP候车服务省内统计表 2011-4-11
				hTableName.value="rcr001";
				hParams1.value= "prc_2149_b878out_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.bGroupId.value+"','"+document.form1.eGroupId.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"' ";
				action="print_rpt_crm.jsp";
			}
			else if(document.form1.rpt_type.value==311)
		  {
		  	//huangrong add 地市VIP候车服务省内统计表 2011-4-11   
				hTableName.value="rcr001";
				hParams1.value= "prc_2149_b878server_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.bGroupId.value+"','"+document.form1.eGroupId.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"' ";
				action="print_rpt_crm.jsp";
			}				
			else if(document.form1.rpt_type.value==312)
		  {
		  	//ningtn add 
				hTableName.value="rbo006";
				hParams1.value= "prc_2149_312_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.bGroupId.value+"','"+document.form1.eGroupId.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"' ";
				action="print_rpt_crm.jsp";
			}	 
			else if(document.form1.rpt_type.value==313) {	//2011/8/16 wanghfa添加 赠送预存款活动办理统计报表
				hTableName.value="rbo006";
				hParams1.value= "prc_2149_313_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.bGroupId.value+"','"+document.form1.eGroupId.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"' ";
				action="print_rpt_crm.jsp";
			}
			else if(document.form1.rpt_type.value==315) {	//2011/10/9 diling添加 大庆移动e家之有线电视报表
				hTableName.value="rcr001";
				hParams1.value= "prc_2149_315_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.bGroupId.value+"','"+document.form1.eGroupId.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"' ";
				action="print_rpt_crm.jsp";
			}
			else if(document.form1.rpt_type.value==317) {	//2011/10/13 diling添加 社会渠道工号解除绑定的明细报表
				hTableName.value="rcr001";
				hParams1.value= "prc_2149_317_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.bGroupId.value+"','"+document.form1.eGroupId.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"' ";
				action="print_rpt_crm.jsp";
			}
			else if(document.form1.rpt_type.value==320) {	//2011/11/16 diling添加 地市sim补卡统计报表
				hTableName.value="rcr001";
				hParams1.value= "prc_2149_320_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.bGroupId.value+"','"+document.form1.eGroupId.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"' ";
				action="print_rpt_crm.jsp";
			}
			else if(document.form1.rpt_type.value==321) {	//2011/12/23 wanghfa添加 地区合约计划购机统计报表
				hTableName.value="rcr001";
				hParams1.value= "prc_2149_321_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.bGroupId.value+"','"+document.form1.eGroupId.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"' ";
				action="print_rpt_crm.jsp";
			}
			else if(document.form1.rpt_type.value==322) {	//2011/01/05 wanghyd增加 地市自备机合约营销案报表
				hTableName.value="rcr001";
				hParams1.value= "prc_2149_322_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.bGroupId.value+"','"+document.form1.eGroupId.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"' ";
				action="print_rpt_crm.jsp";
			}
			else if(document.form1.rpt_type.value==323) {	
				hTableName.value="rcr001";
				hParams1.value= "prc_2149_323_upg('"
					+document.form1.workNo.value+"','"
					+document.form1.groupId.value+"','"
					+document.form1.bGroupId.value+"','"
					+document.form1.eGroupId.value+"','"
					+document.form1.begin_time.value+"','"
					+document.form1.end_time.value+"' ";
				action="print_rpt_crm.jsp";
			}
						else if(document.form1.rpt_type.value==326) {	
				hTableName.value="rcr001";
				hParams1.value= "prc_2149_326_upg('"
					+document.form1.workNo.value+"','"
					+document.form1.groupId.value+"','"
					+document.form1.bGroupId.value+"','"
					+document.form1.eGroupId.value+"','"
					+document.form1.begin_time.value+" 00:00:00','"
					+document.form1.end_time.value+" 23:59:59' ";
				action="print_rpt_crm.jsp";
			}
			else if(document.form1.rpt_type.value==327) {	
				hTableName.value="rbo006";
				hParams1.value= "prc_2149_327_upg('"
					+document.form1.workNo.value+"','"
					+document.form1.groupId.value+"','"
					+document.form1.bGroupId.value+"','"
					+document.form1.eGroupId.value+"','"
					+document.form1.begin_time.value+" 00:00:00','"
					+document.form1.end_time.value+" 23:59:59' ";
				action="print_rpt_crm.jsp";
			}
			else if(document.form1.rpt_type.value==328) {	
				hTableName.value="rcr001";
				hParams1.value= "prc_2149_328_upg('"
					+document.form1.workNo.value+"','"
					+document.form1.groupId.value+"','"
					+document.form1.bGroupId.value+"','"
					+document.form1.eGroupId.value+"','"
					+document.form1.begin_time.value+" 00:00:00','"
					+document.form1.end_time.value+" 23:59:59' ";
				action="print_rpt_crm.jsp";
			}		
			
						else if(document.form1.rpt_type.value==329) {	//wanghyd 2012/9/24 11:18
				hTableName.value="rcr001";
				hParams1.value= "PRC_1640_TD329_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";
			}
			else if(document.form1.rpt_type.value==333) {	
				hTableName.value="rcr001";
				hParams1.value= "prc_2149_333_upg('"
					+document.form1.workNo.value+"','"
					+document.form1.groupId.value+"','"
					+document.form1.bGroupId.value+"','"
					+document.form1.eGroupId.value+"','"
					+document.form1.begin_time.value+" 00:00:00','"
					+document.form1.end_time.value+" 23:59:59' ";
				action="print_rpt_crm.jsp";
			}				
			else if(document.form1.rpt_type.value==336) {	
				hTableName.value="rcr001";
				hParams1.value= "prc_2149_336_upg('"
					+document.form1.workNo.value+"','"
					+document.form1.groupId.value+"','"
					+document.form1.bGroupId.value+"','"
					+document.form1.eGroupId.value+"','"
					+document.form1.begin_time.value+" 00:00:00','"
					+document.form1.end_time.value+" 23:59:59' ";
				action="print_rpt_crm.jsp";
			}			
			else if(document.form1.rpt_type.value==337) {	
				hTableName.value="rcr001";
				hParams1.value= "prc_2149_337_upg('"
					+document.form1.workNo.value+"','"
					+document.form1.groupId.value+"','"
					+document.form1.bGroupId.value+"','"
					+document.form1.eGroupId.value+"','"
					+document.form1.begin_time.value+" 00:00:00','"
					+document.form1.end_time.value+" 23:59:59' ";
				action="print_rpt_crm.jsp";
			}	
			else if(document.form1.rpt_type.value==340) {	//2013/07/16 9:03:58 gaopeng 终端折扣购宽带统计报表(关于协助配置齐齐哈尔公司购终端打折购宽带营销方案的函) 
				hTableName.value="rbo006";
				hParams1.value= "prc_2149_340_upg('"
					+document.form1.workNo.value+"','"
					+document.form1.groupId.value+"','"
					+document.form1.bGroupId.value+"','"
					+document.form1.eGroupId.value+"','"
					+document.form1.begin_time.value+" 00:00:00','"
					+document.form1.end_time.value+" 23:59:59' ";
				action="print_rpt_crm.jsp";
			}		
			else if(document.form1.rpt_type.value==342) {	
				hTableName.value="rbo006";
				hParams1.value= "prc_2149_342_upg('"
					+document.form1.workNo.value+"','"
					+document.form1.groupId.value+"','"
					+document.form1.bGroupId.value+"','"
					+document.form1.eGroupId.value+"','"
					+document.form1.begin_time.value+" 00:00:00','"
					+document.form1.end_time.value+" 23:59:59' ";
				action="print_rpt_crm.jsp";
			}
			else if(document.form1.rpt_type.value==352) {	
				hTableName.value="rbo006";
				hParams1.value= "prc_2149_352_upg('"
					+document.form1.workNo.value+"','"
					+document.form1.groupId.value+"','"
					+document.form1.bGroupId.value+"','"
					+document.form1.eGroupId.value+"','"
					+document.form1.begin_time.value+" 00:00:00','"
					+document.form1.end_time.value+" 23:59:59' ";
				action="print_rpt_crm.jsp";
			}		
						else if(document.form1.rpt_type.value==353) {
				hTableName.value="rbo006";
				hParams1.value= "prc_2149_353jfzz_upg('"
					+document.form1.workNo.value+"','"
					+document.form1.groupId.value+"','"
					+document.form1.bGroupId.value+"','"
					+document.form1.eGroupId.value+"','"
					+document.form1.begin_time.value+" 00:00:00','"
					+document.form1.end_time.value+" 23:59:59' ";
				action="print_rpt_crm.jsp";
			}
			else if(document.form1.rpt_type.value==357) {
				hTableName.value="rbo006";
				hParams1.value= "prc_2149_357_upg('"
					+document.form1.workNo.value+"','"
					+document.form1.groupId.value+"','"
					+document.form1.bGroupId.value+"','"
					+document.form1.eGroupId.value+"','"
					+document.form1.begin_time.value+" 00:00:00','"
					+document.form1.end_time.value+" 23:59:59' ";
				action="print_rpt_crm.jsp";
			}
			else if(document.form1.rpt_type.value==358) {
				hTableName.value="rbo006";
				hParams1.value= "prc_2149_358_upg('"
					+document.form1.workNo.value+"','"
					+document.form1.groupId.value+"','"
					+document.form1.bGroupId.value+"','"
					+document.form1.eGroupId.value+"','"
					+document.form1.begin_time.value+" 00:00:00','"
					+document.form1.end_time.value+" 23:59:59' ";
				action="print_rpt_crm.jsp";
			}
			else if(document.form1.rpt_type.value==359) {
				hTableName.value="rbo006";
				hParams1.value= "prc_2149_359_upg('"
					+document.form1.workNo.value+"','"
					+document.form1.groupId.value+"','"
					+document.form1.bGroupId.value+"','"
					+document.form1.eGroupId.value+"','"
					+document.form1.begin_time.value+" 00:00:00','"
					+document.form1.end_time.value+" 23:59:59' ";
				action="print_rpt_crm.jsp";
			}
			else if(document.form1.rpt_type.value==364) {
				hTableName.value="rbr001";
				hParams1.value= "prc_1640_rbr364_upg('"
					+document.form1.workNo.value+"','"
					+document.form1.groupId.value+"','"
					+document.form1.bGroupId.value+"','"
					+document.form1.eGroupId.value+"','"
					+document.form1.begin_time.value+" 00:00:00','"
					+document.form1.end_time.value+" 23:59:59' ";
				action="print_rpt_crm.jsp";
			}else if(document.form1.rpt_type.value==367) {	
				hTableName.value="rcr001";
				hParams1.value= "prc_2149_367_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.bGroupId.value+"','"+document.form1.eGroupId.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"' ";
				action="print_rpt_crm.jsp";
			}else if(rpt_type.value==368)
			{
				hTableName.value="rcr001";
				hParams1.value= "prc_2149_368_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm.jsp";
			}else if(rpt_type.value==369)
			{
				hTableName.value="rcr001";
				hParams1.value= "prc_2149_369_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm.jsp";
			}else if(rpt_type.value==370)
			{
				hTableName.value="rcr001";
				hParams1.value= "prc_2149_370_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm.jsp";
			}
			else if(rpt_type.value==372)
			{
				hTableName.value="rcr001";
				hParams1.value= "prc_2149_372_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm.jsp";
			}
			else if(rpt_type.value==381)
			{
				hTableName.value="rbo006";
				hParams1.value= "prc_2149_381_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm.jsp";
			}
			else if(rpt_type.value==382)
			{
				hTableName.value="RCQ001";
				hParams1.value= "prc_2149_382_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm.jsp";
			}
			else if(rpt_type.value==383)
			{
				hTableName.value="RCQ001";
				hParams1.value= "prc_2149_383_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm.jsp";
			}
		}
	}
}
