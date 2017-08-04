//wanghfa 20100602 crm维护的报表调用此方法，参数statement是页面form对象
function select_crm(statement)
{
	if(statement)
	{
		with(statement) 
		{
      if(rpt_type.value==3)
			{
				hTableName.value="rsd002";
				hParams1.value= "prc_1630_sd002_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==7)
			{
				hTableName.value="rvd002";
				hParams1.value= "prc_1630_vd002_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==8)
			{
				hTableName.value="rjd002";
				hParams1.value= "prc_1630_jd002_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==9)
			{
				hTableName.value="ryd002";
				hParams1.value= "prc_1630_yd002_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			
			else if(rpt_type.value==14)
			{
				hTableName.value="rfo006";
				hParams1.value= "prc_1615_qqt005_upg('"+rptright.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+workNo.value+"','"+workNo.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==15)
			{
				hTableName.value="rbo006";
				hParams1.value= "prc_1630_qqt006_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==16)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_1677_3_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==18)
			{
				hTableName.value="rfo006";
				hParams1.value= "prc_1676_prn_upg('"+rptright.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+workNo.value+"','aaaaaa','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			                              
			else if(rpt_type.value==20)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_1247_pr004_3_upg('0','"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==21)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_1247_pr004_3_upg('1','"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
				
			else if(rpt_type.value==22)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_1247_pr005_2_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			
			else if(rpt_type.value==23)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_1247_pr006_2_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00"+"','"+end_time.value+" 23:59:59"+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==24)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_1247_pr007_2_upg('0','"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==25)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_1247_pr007_2_upg('1','"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==26)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_1247_pr009_2_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			
			
			
			else if(rpt_type.value==41)
			{
				hTableName.value="rfo006";
				hParams1.value="prc_9003_3_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==43)
			{
				hTableName.value="rfo006";
				hParams1.value="prc_9002_3_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
		
			else if(rpt_type.value==48)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_9005_3_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==49)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_9006_3_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==50)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_1258_3_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==51)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_1259_3_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==52)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_1630_prepayMark_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm.jsp";}
			
			
			else if(rpt_type.value==55)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_1257_3_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==57)
			{
				hTableName.value="rpd002";
				hParams1.value= "prc_1630_pd057_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}	
			else if(rpt_type.value==58)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_1255_3_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}	
			else if(rpt_type.value==59)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_1256_3_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
				
			else if(rpt_type.value==60)
			{
				hTableName.value="rpd002";
				hParams1.value= "prc_1630_pd060_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}	
			else if(rpt_type.value==61)
			{
				hTableName.value="RCR3070";
				hParams1.value= "prc_3071_3_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}	
			else if(rpt_type.value==62)
			{
				hTableName.value="RCR3070";
				hParams1.value= "prc_3071_mx_3_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}	
			else if(rpt_type.value==63)
			{
				hTableName.value="RCR3070";
				hParams1.value= "prc_3072_3_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==64)
			{
				hTableName.value="RCR3070";
				hParams1.value= "prc_3072_mx_3_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==65)
			{
				hTableName.value="rpd002";
				hParams1.value= "prc_1630_pd065_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==66)
			{
				hTableName.value="rpd002";
				hParams1.value= "prc_1630_pd066_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==67)
			{
				hTableName.value="rpd002";
				hParams1.value= "prc_1630_pd067_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==68)
			{
				hTableName.value="rcd002";
				hParams1.value= "PRC_126h_PR001_2_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==69)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1397_pt069_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}    
			
			else if(rpt_type.value==74)
			{
				hTableName.value="rpd002";
				hParams1.value= "prc_1630_pd074_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";} 
			else if(rpt_type.value==75)
			{
				hTableName.value="rpd002";
				hParams1.value= "prc_1630_pd075_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==76)
			{
				hTableName.value="rpd002";
				hParams1.value= "prc_1630_pd076_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==77)
			{
				hTableName.value="rpd002";
				hParams1.value= "prc_1630_pd077_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==78)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_1630_color_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==79)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_5100_pt79_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==80)
			{
				hTableName.value="RPtLUCK52";
				hParams1.value= "prc_1630_luck52_1_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==81)
			{
				hTableName.value="RPtLUCK52";
				hParams1.value= "prc_1630_luck52_2_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==82)
			{
				hTableName.value="rsr001";
				hParams1.value= "prc_1630_Batter_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";} 
			else if(rpt_type.value==83)
			{
				hTableName.value="rpd002";
				hParams1.value= "prc_1630_pd083_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}  
			else if(rpt_type.value==84)
			{
				hTableName.value="rpd002";
				hParams1.value= "prc_1630_pd084_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}  
			else if(rpt_type.value==87)
			{
				hTableName.value="rpd002";
				hParams1.value= "prc_1630_pd087_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==89)
			{
				hTableName.value="rpd002";
				hParams1.value= "prc_1630_pd089_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			
			else if(rpt_type.value==91)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_2281_3_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==92)
			{
				hTableName.value="rpd002";
				hParams1.value= "prc_1630_pd092_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==93)
			{
				hTableName.value="RPtLUCK52";
				hParams1.value= "PRC_1444_CX012_upg('"+workNo.value+"','"+region_code.value+"','"+district_code.value.substr(2,4)+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==94)
			{
				hTableName.value="rjo005";
				hParams1.value= "PRC_1444_CX024_upg('"+workNo.value+"','"+begin_town.value+"','"+end_town.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==95)
			{
				hTableName.value="rpd002";
				hParams1.value= "prc_1630_pd095_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			
			else if(rpt_type.value==96)
			{
				hTableName.value="rcr001";
				hParams1.value= "prc_1247_pr096_3_upg('0','"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==97)
			{
				hTableName.value="rcr001";
				hParams1.value= "prc_1247_pr096_3_upg('1','"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==98)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_8038_3_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==99)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_1630_99_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==100)
			{
				hTableName.value="rpd002";
				hParams1.value= "prc_1630_pd0100_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==101)
			{
				hTableName.value="rpd002";
				hParams1.value= "prc_1630_pd0101_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==102)
			{
				hTableName.value="rpd002";
				hParams1.value= "prc_1630_pd0102_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==103)
			{
				hTableName.value="rpd002";
				hParams1.value= "prc_1630_pd0103_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==104)
			{
				hTableName.value="rbo005";
				hParams1.value= "prc_1630_pd0104_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==105)
			{
				hTableName.value="rbo005";
				hParams1.value= "prc_1630_pd0105_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";} 
			else if(rpt_type.value==106)
			{
				hTableName.value="rbo005";
				hParams1.value= "prc_1630_pd0106_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==107)
			{
				hTableName.value="RPtLUCK52";
				hParams1.value= "prc_1630_midfest_1_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==108)
			{
				hTableName.value="RPtLUCK52";
				hParams1.value= "prc_1630_midfest_2_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==109)
			{
				hTableName.value="RPtLUCK52";
				hParams1.value= "prc_1630_midfest_3_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==110)
			{
				hTableName.value="rpd002";
				hParams1.value= "prc_1630_pd0110_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==111)
			{
				hTableName.value="rpd002";
				hParams1.value= "prc_1630_pd0111_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==113)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_2289_jf_3_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==114)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1499_rpt30_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==115)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_7115_rpt30_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}  
			else if(rpt_type.value==116)
			{
				hTableName.value="rpd002";
				hParams1.value= "prc_1630_pd0116_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}     
			else if(rpt_type.value==117)
			{
				hTableName.value="rfo006";
				hParams1.value= "prc_2268pay_rpt_upg('"+rptright.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+workNo.value+"',' ','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==118)
			{
				hTableName.value="rfo006";
				hParams1.value= "prc_2269pay_rpt_upg('0','"+rptright.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+workNo.value+"',' ','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}								  
			else if(rpt_type.value==119)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_3286_tj3_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==120)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_3286_mx3_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==121)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_2281_tj3_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==122)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_2281_mx3_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==125)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1469_rpt30_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==126)
			{
				hTableName.value="RPtLUCK52";
				hParams1.value= "prc_1630_luck52_11_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==127)
			{
				hTableName.value="RPtLUCK52";
				hParams1.value= "prc_1630_luck52_21_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==128)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_1630_pr128_upg('0','"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==129)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_1630_pr128_upg('1','"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==130)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_1630_pr129_mx_upg('0','"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==131)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_1630_pr129_mx_upg('1','"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==132)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1469_rpt30_1_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==135)
			{
				hTableName.value="rpd002";
				hParams1.value= "prc_8030_pd135_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==136)
			{
				hTableName.value="rpd002";
				hParams1.value= "prc_8032_pd136_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==146)
			{
				hTableName.value="rpd002";
				hParams1.value= "prc_1630_pd0146_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";} 
			else if(rpt_type.value==147)
			{
				hTableName.value="rpd002";
				hParams1.value= "prc_1630_pd0147_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==149)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_5100_pt79_tj_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==150)
			{
				hTableName.value="rpd002";
				hParams1.value= "prc_1630_pd0150_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==152)
			{
				hTableName.value="rpd002";
				hParams1.value= "prc_1630_pd0152_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==153)
			{
				hTableName.value="rpd002";
				hParams1.value= "prc_1630_pd0153_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			
			else if(rpt_type.value==158)
			{
				hTableName.value="rpd002";
				hParams1.value= "prc_1630_pd0158_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
				else if(rpt_type.value==159)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1104_rpt03_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
			
				action="print_rpt_crm.jsp";}
				
				else if(rpt_type.value==161)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1630_rpt161_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
			
				action="print_rpt_crm.jsp";}
				
				else if(rpt_type.value==163)
			{
				hTableName.value="rpd002";
				hParams1.value= "prc_1630_rtp163_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
				else if(rpt_type.value==164)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1630_rpt164_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
			
				action="print_rpt_crm.jsp";}
			
			else if(rpt_type.value==166)
			{
				hTableName.value="rpd002";
				hParams1.value= "prc_1630_pd0166_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==167)
			{
				hTableName.value="rpd002";
				hParams1.value= "prc_1630_pd0167_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm.jsp";} 
			else if(rpt_type.value==168)
			{
				hTableName.value="rpd002";
				hParams1.value= "prc_1630_pd0168_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm.jsp";} 
			else if(rpt_type.value==169)
			{
				hTableName.value="rpd002";
				hParams1.value= "prc_1630_7955_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==170)
			{
				hTableName.value="rpd002";
				hParams1.value= "prc_1630_7956_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==172)
			{
				hTableName.value="rpd002";
				hParams1.value= "prc_1630_pd0174_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm.jsp";} 
			else if(rpt_type.value==173)
			{
				hTableName.value="rpd002";
				hParams1.value= "prc_1630_pd0ghmx_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==171)
			{
				var begin=begin_time.value.substring(0,6);
				var end=end_time.value.substring(0,6);
				if(begin!=end)
				{
					alert("时间需在同一年同一月份，请重新设置！");
					begin_time.focus();
					return false;
				}
				hTableName.value="rpd002";
				hParams1.value= "prc_1630_pd0170_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			
			else if(rpt_type.value==179)
			{    	
				hTableName.value="rcd002";
				hParams1.value= "prc_1630_wpaybc_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
			
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==180)
			{
				hTableName.value="rpd002";
				hParams1.value= "prc_1630_pd180_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";} 
			else if(rpt_type.value==181)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_1630_pd181_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==182)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_1630_pd182_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==183)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_1630_pd183_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==184)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_1630_pd184_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==185)
			{
				hTableName.value="rpd002";
				hParams1.value= "prc_1630_pd185_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==186)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_1630_pd186_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==187)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_1630_pd187_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			
			
			else if(rpt_type.value==190)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_1630_pd190_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==191)
			{
				hTableName.value="rcd002";
				hParams1.value= "PRC_1630_TD191_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==192)
			{
				hTableName.value="rcd002";
				hParams1.value= "PRC_1630_TD192_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==193)
			{
				hTableName.value="rcd002";
				hParams1.value= "PRC_1630_pd193_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==194)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_1630_pd194_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==195)
			{
				hTableName.value="rcd002";
				hParams1.value= "PRC_1630_7671_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
				
				else if(rpt_type.value==177)
			{
				hTableName.value="rcd002";
				hParams1.value= "PRC_1630_gprsSale_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==178)
			{
				hTableName.value="rcd002";
				hParams1.value= "PRC_1630_gprsSaleCard_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
				
				else if(rpt_type.value==198)
	    {
	      hTableName.value="rcd002";
	      hParams1.value= "prc_1630_pd198_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
	      	action="print_rpt_crm.jsp";
	    } 
	    else if(rpt_type.value==199)
	    {
	      hTableName.value="rfo006";
	      hParams1.value= "prc_1630_pr199_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
	      	action="print_rpt_crm.jsp";
	    }
	    else if(document.form1.rpt_type.value==201)
	    {//20101019关于绥化分公司针对特定客户预存话费赠G3无线座机的需求@jingang@201，202，204
	      hTableName.value="rcd002";
	   		hParams1.value= "PRC_1630_TD193_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.bGroupId.value+"','"+document.form1.eGroupId.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"' ";
	 			action="print_rpt_crm.jsp";
	    }
	    else if(document.form1.rpt_type.value==202)
	    {
	      hTableName.value="rcd002";
	   		hParams1.value= "PRC_1630_TD194_UPG('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.bGroupId.value+"','"+document.form1.eGroupId.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"' ";
	 			action="print_rpt_crm.jsp";
	    }
	    else if(document.form1.rpt_type.value==204)
	    {
	      hTableName.value="rcd002";
	      hParams1.value= "PRC_1630_7672_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.bGroupId.value+"','"+document.form1.eGroupId.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"' ";
	    	action="print_rpt_crm.jsp";
	    }
	    //20100927-17:21关于哈尔滨分公司开展预存话费赠黑莓终端营销活动相关内容的请示@jingang
			else if(document.form1.rpt_type.value==203)
	    {
	      hTableName.value="rcd002";
	   		hParams1.value= "PRC_1630_7673_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.bGroupId.value+"','"+document.form1.eGroupId.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"' ";
	   		action="print_rpt_crm.jsp";
	    }
		else if(document.form1.rpt_type.value==205)
	    {
	    	//SIM卡使用量的查询明细报表
			hTableName.value="rpt003";
			hParams1.value= "prc_1630_1104_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.bGroupId.value+"','"+document.form1.eGroupId.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"' ";
	    	action="print_rpt_crm.jsp";
	    }	
	    else if(document.form1.rpt_type.value==207)//fusk R_CMI_HLJ_xueyz_2014_1524671@关于报送2014年3月业务支撑系统市场专业需求的函-优化2355强开界面的需求
	    { 
	      hTableName.value="RPT2266";
	      hParams1.value= "PRC_2148_RPT207_UPG('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.bGroupId.value+"','"+document.form1.eGroupId.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"' ";
	    	action="print_rpt_crm.jsp";
	    }
	    else if(document.form1.rpt_type.value==301)
	    {//签约优惠购机需求
	      hTableName.value="rbo006";
	      hParams1.value= "PRC_2148_d069_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.bGroupId.value+"','"+document.form1.eGroupId.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"' ";
	    	action="print_rpt_crm.jsp";
	    } 
	    else if(document.form1.rpt_type.value==302)
	    {//动感地带护照
	      hTableName.value="rbo006";
	      hParams1.value= "PRC_2148_2285_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.bGroupId.value+"','"+document.form1.eGroupId.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"' ";
	    	action="print_rpt_crm.jsp";
	    }
	    else if(document.form1.rpt_type.value==303)
	    {//报表改造
	      hTableName.value="dbo005";
	      hParams1.value= "prc_1630_newsale_mx_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.bGroupId.value+"','"+document.form1.eGroupId.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"' ";
	    	action="print_rpt_crm.jsp";
	    }
	    else if(document.form1.rpt_type.value==304)
	    {//报表改造
	      hTableName.value="dbo005";
	      hParams1.value= "prc_1630_newsale_op_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.bGroupId.value+"','"+document.form1.eGroupId.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"' ";
	    	action="print_rpt_crm.jsp";
	    }
			
			else if(document.form1.rpt_type.value==309)
	    {//ningtn 
	      hTableName.value="rbo006";
	      hParams1.value= "prc_2148_309_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.bGroupId.value+"','"+document.form1.eGroupId.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"' ";
	    	action="print_rpt_crm.jsp";
	    }
			else if(document.form1.rpt_type.value==308)
	    {//huangrong add 308->区县预存话费领奖明细报表 2011-6-20
	      hTableName.value="rbo006";
	      hParams1.value= "prc_2148_308_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.bGroupId.value+"','"+document.form1.eGroupId.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"' ";
	    	action="print_rpt_crm.jsp";
	    }
			else if(document.form1.rpt_type.value==310) {	//wanghfa add 310->报表名称：赠送预存款活动办理统计报表 2011-8-16
	      hTableName.value="rbo006";
	      hParams1.value= "prc_2148_310_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.bGroupId.value+"','"+document.form1.eGroupId.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"' ";
	    	action="print_rpt_crm.jsp";
	    }
			else if(document.form1.rpt_type.value==311) {	//2011/9/12 wanghfa添加 区县电子发票统计报表
	      hTableName.value="rbo006";
		  //第一次选的 第二次选的
	      hParams1.value= "DBCUSTADM.prc_2148_invoice_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.bGroupId.value+"','"+document.form1.eGroupId.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"' ";
	      //alert(hParams1.value);
		  action="print_rpt_boss.jsp";
	    } 
	    else if(document.form1.rpt_type.value==315) {	//2011/12/22 wanghfa添加 区县合约计划购机统计报表
	      hTableName.value="rcr001";
	      hParams1.value= "prc_2148_315_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.bGroupId.value+"','"+document.form1.eGroupId.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"' ";
	    	action="print_rpt_crm.jsp";
	    }
	    else if(document.form1.rpt_type.value==316) {	//2011/01/05 wanghyd增加 区县自备机合约营销案报表
	      hTableName.value="rcr001";
	      hParams1.value= "prc_2148_316_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.bGroupId.value+"','"+document.form1.eGroupId.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"' ";
	    	action="print_rpt_crm.jsp";
	    }
	    else if(document.form1.rpt_type.value==317) 
		{	
			hTableName.value="rcr001";
			hParams1.value= "prc_2148_317_upg('"+document.form1.workNo.value+"','"
			+document.form1.groupId.value+"','"
			+document.form1.bGroupId.value+"','"
			+document.form1.eGroupId.value+"','"
			+document.form1.begin_time.value+"','"
			+document.form1.end_time.value+"' ";
			action="print_rpt_crm.jsp";
	    }
	    	    else if(document.form1.rpt_type.value==318)  //2012/06/25 增加 报表名称：区县修改IMEI绑定关系统计报表
		{	
			hTableName.value="rcr001";
			hParams1.value= "prc_2148_318_upg('"+document.form1.workNo.value+"','"
			+document.form1.groupId.value+"','"
			+document.form1.bGroupId.value+"','"
			+document.form1.eGroupId.value+"','"
			+document.form1.begin_time.value+" 00:00:00','"
			+document.form1.end_time.value+" 23:59:59' ";
			action="print_rpt_crm.jsp";
	    }
	    else if(document.form1.rpt_type.value==319)  //ningtn 2012-8-7 16:33:17
			{	
				hTableName.value="rbo006";
				hParams1.value= "prc_2148_319_upg('"+document.form1.workNo.value+"','"
				+document.form1.groupId.value+"','"
				+document.form1.bGroupId.value+"','"
				+document.form1.eGroupId.value+"','"
				+document.form1.begin_time.value+" 00:00:00','"
				+document.form1.end_time.value+" 23:59:59' ";
				action="print_rpt_crm.jsp";
	    }
	    else if(document.form1.rpt_type.value==320)  //ningtn 2012-8-7 16:33:17
			{	
				hTableName.value="rcr001";
				hParams1.value= "prc_2148_320_upg('"+document.form1.workNo.value+"','"
				+document.form1.groupId.value+"','"
				+document.form1.bGroupId.value+"','"
				+document.form1.eGroupId.value+"','"
				+document.form1.begin_time.value+" 00:00:00','"
				+document.form1.end_time.value+" 23:59:59' ";
				action="print_rpt_crm.jsp";
	    }	 
	    
	    	    else if(document.form1.rpt_type.value==321)  	//wanghyd 2012/9/24 11:18
			{	
				hTableName.value="rcd002";
				hParams1.value= "PRC_1630_TD321_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";
	    }	 
			else if(document.form1.rpt_type.value==324) 
			{	
				hTableName.value="rcr001";
				hParams1.value= "prc_2148_324_upg('"
					+document.form1.workNo.value+"','"
					+document.form1.groupId.value+"','"
					+document.form1.bGroupId.value+"','"
					+document.form1.eGroupId.value+"','"
					+document.form1.begin_time.value+"','"
					+document.form1.end_time.value+"' ";
				action="print_rpt_crm.jsp";
			}
			else if(document.form1.rpt_type.value==325) 
			{	
				hTableName.value="rcr001";
				hParams1.value= "prc_2148_325_upg('"
					+document.form1.workNo.value+"','"
					+document.form1.groupId.value+"','"
					+document.form1.bGroupId.value+"','"
					+document.form1.eGroupId.value+"','"
					+document.form1.begin_time.value+"','"
					+document.form1.end_time.value+"' ";
				action="print_rpt_crm.jsp";
			}
			else if(document.form1.rpt_type.value==328)//2013/07/16 9:03:58 gaopeng 终端折扣购宽带统计报表(关于协助配置齐齐哈尔公司购终端打折购宽带营销方案的函) 
			{	
					hTableName.value="rbo006";
					hParams1.value= "prc_2148_328_upg('"+document.form1.workNo.value+"','"
					+document.form1.groupId.value+"','"
					+document.form1.bGroupId.value+"','"
					+document.form1.eGroupId.value+"','"
					+document.form1.begin_time.value+" 00:00:00','"
					+document.form1.end_time.value+" 23:59:59' ";
					action="print_rpt_crm.jsp";
			}
						else if(document.form1.rpt_type.value==339)
			{	
					hTableName.value="rbo006";
					hParams1.value= "prc_2148_339jfzz_upg('"+document.form1.workNo.value+"','"
					+document.form1.groupId.value+"','"
					+document.form1.bGroupId.value+"','"
					+document.form1.eGroupId.value+"','"
					+document.form1.begin_time.value+" 00:00:00','"
					+document.form1.end_time.value+" 23:59:59' ";
					action="print_rpt_crm.jsp";
			}
			else if(document.form1.rpt_type.value==340)
			{	
					hTableName.value="rbo006";
					hParams1.value= "prc_2148_340_upg('"+document.form1.workNo.value+"','"
					+document.form1.groupId.value+"','"
					+document.form1.bGroupId.value+"','"
					+document.form1.eGroupId.value+"','"
					+document.form1.begin_time.value+" 00:00:00','"
					+document.form1.end_time.value+" 23:59:59' ";
					action="print_rpt_crm.jsp";
			}
			else if(document.form1.rpt_type.value==341)
			{	
					hTableName.value="rbo006";
					hParams1.value= "prc_2148_341_upg('"+document.form1.workNo.value+"','"
					+document.form1.groupId.value+"','"
					+document.form1.bGroupId.value+"','"
					+document.form1.eGroupId.value+"','"
					+document.form1.begin_time.value+" 00:00:00','"
					+document.form1.end_time.value+" 23:59:59' ";
					action="print_rpt_crm.jsp";
			}
			else if(document.form1.rpt_type.value==342)
			{	
					hTableName.value="rbo006";
					hParams1.value= "prc_2148_342_upg('"+document.form1.workNo.value+"','"
					+document.form1.groupId.value+"','"
					+document.form1.bGroupId.value+"','"
					+document.form1.eGroupId.value+"','"
					+document.form1.begin_time.value+" 00:00:00','"
					+document.form1.end_time.value+" 23:59:59' ";
					action="print_rpt_crm.jsp";
			}else if(document.form1.rpt_type.value==347)
			{	
					hTableName.value="rcr001";
					hParams1.value= "prc_2148_347_upg('"+document.form1.workNo.value+"','"
					+document.form1.groupId.value+"','"
					+document.form1.bGroupId.value+"','"
					+document.form1.eGroupId.value+"','"
					+document.form1.begin_time.value+" 00:00:00','"
					+document.form1.end_time.value+" 23:59:59' ";
					action="print_rpt_crm.jsp";
			}else if(rpt_type.value==348)
			{
				hTableName.value="rcr001";
				hParams1.value= "prc_2148_348_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm.jsp";
			}else if(rpt_type.value==349)
			{
				hTableName.value="rcr001";
				hParams1.value= "prc_2148_349_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm.jsp";
			}else if(rpt_type.value==350)
			{
				hTableName.value="rcr001";
				hParams1.value= "prc_2148_350_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm.jsp";
			}
			else if(rpt_type.value==352)
			{
				hTableName.value="rcr001";
				hParams1.value= "prc_2148_352_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm.jsp";
			}
			else if(rpt_type.value==357)
			{
				hTableName.value="rbo006";
				hParams1.value= "prc_2148_357_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm.jsp";
			}
			else if(rpt_type.value==359)
			{
				hTableName.value="rbo006";
				hParams1.value= "prc_2148_359_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+" 00:00:00','"+end_time.value+" 23:59:59' ";
				action="print_rpt_crm.jsp";
			}
		}
	}
}
