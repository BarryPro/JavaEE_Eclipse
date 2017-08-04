//wanghfa 20100602 crm维护的报表调用此方法，参数statement是页面form对象
function select_crm(statement)
{
	if(statement)
	{
		with(statement)
		{  
			if(rpt_type.value==1)
			{
				hTableName.value="rbo005";
				hParams1.value= "prc_1615_bo005_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==3)
			{
				hTableName.value="rso005";
				hParams1.value= "prc_1615_so005_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==4)
			{
				hTableName.value="rco005";
				hParams1.value= "prc_1615_co005_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==6)
			{
				hTableName.value="rto005";
				hParams1.value= "prc_1615_to005_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			
			else if(rpt_type.value==8)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_1615_jo005_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==9)
			{
				hTableName.value="ryo005";
				hParams1.value= "prc_1615_yo005_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==10)
			{
				hTableName.value="rgo005";
				hParams1.value= "prc_1615_go005_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==11)
			{
				hTableName.value="rto005";
				hParams1.value= "prc_1615_to005_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==12)
			{
				hTableName.value="rro005";
				hParams1.value= "prc_1615_ro005_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==13)
			{
				hTableName.value="rao005";
				hParams1.value= "prc_1615_ao005_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			
			else if(rpt_type.value==15)
			{
				hTableName.value="rfo006";
				hParams1.value= "prc_1615_qqt005_upg('"+rptRight.value+"','"+groupId.value+"',' ',' ','"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";      									
				action="print_rpt_crm.jsp";}									  
			else if(rpt_type.value==17)
			{
				hTableName.value="rfo006";
				hParams1.value= "prc_1615_qqt006_upg('"+rptRight.value+"','"+groupId.value+"',' ',' ','"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}									  																																																	   									   
			else if(rpt_type.value==18)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_1677_1_upg('"+workNo.value+"','"+groupId.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==19)
			{
				hTableName.value="rfo006";
				hParams1.value= "prc_1677_001Prn_upg('"+rptRight.value+"','"+org_code.value.substring(0,9)+"','"+groupId.value+"','"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}									  
			else if(rpt_type.value==20)
			{
				hTableName.value="rfo006";
				hParams1.value= "prc_1676_Prn_upg('"+rptRight.value+"','"+groupId.value+"',' ',' ','"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}								   
												  
			else if(rpt_type.value==22)
			{
				hTableName.value="rco005";
				hParams1.value= "prc_1247_pr004_upg('0','"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==23)
			{
				hTableName.value="rco005";
				hParams1.value= "prc_1247_pr004_upg('1','"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			
			else if(rpt_type.value==25)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_1247_pr006_upg('1','"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==26)
			{
				hTableName.value="rco005";
				hParams1.value= "prc_1247_pr009_upg('1','"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==126)
			{
				hTableName.value="rbo006";
				hParams1.value= "PRC_1615_gprsSaleCard_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
				else if(rpt_type.value==44)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_1256_1_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}					     
			
			
			else if(rpt_type.value==35)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_1258_1_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==36)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_1259_1_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==37)
			{
				hTableName.value="rct003";
				hParams1.value= "prc_1615_PrepayMark_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==38)
			{
				hTableName.value="t1788rpt";
				hParams1.value= "prc_1615_rpt1_upg('"+workNo.value+"','"+login_no.value+"','"+region_code.value+"','"+district_code.value.substring(2,4)+"','"+town_code.value.substring(4,7)+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==39)
			{
				hTableName.value="t1788rpt";
				hParams1.value= "prc_1615_rpt2_upg('"+workNo.value+"','"+login_no.value+"','"+region_code.value+"','"+district_code.value.substring(2,4)+"','"+town_code.value.substring(4,7)+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==40)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_1257_1_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==41)
			{
				hTableName.value="rpo005";
				hParams1.value= "prc_1615_po041_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==42)
			{
				hTableName.value="rpo005";
				hParams1.value= "prc_1615_po042_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==43)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_1255_1_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
				else if(rpt_type.value==44)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_1256_1_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			
			else if(rpt_type.value==45)
			{
				hTableName.value="rbo005";
				hParams1.value= "prc_1615_po045_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==46)
			{
				hTableName.value="RCR3070";
				hParams1.value= "prc_3071_1_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==47)
			{
				hTableName.value="RCR3070";
				hParams1.value= "prc_3071_mx_1_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==48)
			{
				hTableName.value="RCR3070";
				hParams1.value= "prc_3072_1_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==49)
			{
				hTableName.value="RCR3070";
				hParams1.value= "prc_3072_mx_1_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==50)
			{
				hTableName.value="rbo005";
				hParams1.value= "prc_1615_po050_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==51)
			{
				hTableName.value="rbo005";
				hParams1.value= "prc_1615_po051_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==52)
			{
				hTableName.value="rbo005";
				hParams1.value= "prc_1615_po052_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==53)
			{
				hTableName.value="rbo005";
				hParams1.value= "prc_1615_po053_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==54)
			{
				hTableName.value="rbo005";
				hParams1.value= "prc_1615_po054_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==55)
			{
				hTableName.value="rbo005";
				hParams1.value= "prc_1615_po055_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==56)
			{
				hTableName.value="rbo005";
				hParams1.value= "prc_1615_po056_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==57)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_1615_color_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==58)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_5100_pt58_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==59)
			{
				hTableName.value="RPtLUCK52";
				hParams1.value= "prc_1615_luck52_1_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==60)
			{
				hTableName.value="rsr001";
				hParams1.value= "prc_1615_Batter_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==61)
			{
				hTableName.value="rbo005";
				hParams1.value= "prc_1615_po061_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==62)
			{
				hTableName.value="rbo005";
				hParams1.value= "prc_1615_po062_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==63)
			{
				hTableName.value="rbo005";
				hParams1.value= "prc_1615_po063_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==64)
			{
				hTableName.value="rbo005";
				hParams1.value= "prc_1615_po064_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==65)
			{
				hTableName.value="rbo005";
				hParams1.value= "prc_1615_po065_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==66)
			{
				hTableName.value="rbo005";
				hParams1.value= "prc_1615_po066_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==67)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_2281_1_upg('"+workNo.value+"','"+groupId.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==68)
			{
				hTableName.value="rbo005";
				hParams1.value= "prc_1615_po068_upg('"+workNo.value+"','"+groupId.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==69)
			{
				hTableName.value="rjo005";
				hParams1.value= "PRC_1444_CX021_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==70)
			{
				hTableName.value="rbo005";
				hParams1.value= "prc_1615_po070_upg('"+workNo.value+"','"+groupId.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==71)
			{
				hTableName.value="rco005";
				hParams1.value= "prc_1247_pr071_upg('0','"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==72)
			{
				hTableName.value="rco005";
				hParams1.value= "prc_1247_pr071_upg('1','"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==73)
			{
				hTableName.value="rbo005";
				hParams1.value= "prc_1615_po073_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==74)
			{
				hTableName.value="rbo005";
				hParams1.value= "prc_1615_po074_upg('"+workNo.value+"','"+groupId.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==75)
			{
				hTableName.value="rbo005";
				hParams1.value= "prc_1615_po075_upg('"+workNo.value+"','"+groupId.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			
			else if(rpt_type.value==76)
			{
				hTableName.value="rbo005";
				hParams1.value= "prc_1615_po076_upg('"+workNo.value+"','"+groupId.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			
			else if(rpt_type.value==77)
			{
				hTableName.value="rbo005";
				hParams1.value= "prc_1615_po077_upg('"+workNo.value+"','"+groupId.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			
			else if(rpt_type.value==78)
			{
				hTableName.value="rbo005";
				hParams1.value= "prc_1615_po078_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}            
			else if(rpt_type.value==79)
			{
				hTableName.value="rbo005";
				hParams1.value= "prc_1615_po079_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}   
			else if(rpt_type.value==80)
			{
				hTableName.value="rbo005";
				hParams1.value= "prc_1615_po080_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}   
			else if(rpt_type.value==81)
			{
				hTableName.value="rbo005";
				hParams1.value= "prc_1615_po081_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}  
			else if(rpt_type.value==83)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_2289_jf_1_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}  
			else if(rpt_type.value==84)
			{
				hTableName.value="rco005";
				hParams1.value= "prc_2289_yc_1_upg('0','"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==85)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1499_rpt15_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==86)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_7115_rpt15_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";} 
			else if(rpt_type.value==87)
			{
				hTableName.value="rbo005";
				hParams1.value= "prc_1615_po087_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";} 
			else if(rpt_type.value==88)
			{
				hTableName.value="rfo006";
				hParams1.value= "prc_2268pay_rpt_upg('"+rptRight.value+"','"+groupId.value+"',' ',' ','"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==89)
			{
				hTableName.value="rfo006";
				hParams1.value= "prc_2269pay_rpt_upg('0','"+rptRight.value+"','"+groupId.value+"',' ',' ','"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}									  
			else if(rpt_type.value==90)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_3286_tj1_upg('"+workNo.value+"','"+groupId.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==91)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_3286_mx1_upg('"+workNo.value+"','"+groupId.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			  
			else if(rpt_type.value==93)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1469_rpt15_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==94)
			{
				hTableName.value="RPtLUCK52";
				hParams1.value= "prc_1615_luck52_11_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}    
			else if(rpt_type.value==95)
			{
				hTableName.value="rco005";
				hParams1.value= "prc_1615_pr95_upg('0','"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==96)
			{
				hTableName.value="rco005";
				hParams1.value= "prc_1615_pr95_upg('1','"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==97)
			{
				hTableName.value="rco005";
				hParams1.value= "prc_1615_pr96_upg('0','"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==98)
			{
				hTableName.value="rco005";
				hParams1.value= "prc_1615_pr96_upg('1','"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}	
			else if(rpt_type.value==99)
			{
				hTableName.value="rbo005";
				hParams1.value= "prc_8030_po99_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==100)
			{
				hTableName.value="rbo005";
				hParams1.value= "prc_8032_po100_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==101)
			{
				hTableName.value="rbo005";
				hParams1.value= "prc_1615_po0101_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==102)
			{
				hTableName.value="rbo005";
				hParams1.value= "prc_1615_po0102_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==104)
			{
				hTableName.value="rbo005";
				hParams1.value= "prc_1615_po0104_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==105)
			{
				hTableName.value="rbo005";
				hParams1.value= "prc_1615_po0105_upg('"+workNo.value+"','"+groupId.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==106)
			{
				hTableName.value="rbo005";
				hParams1.value= "prc_1615_po0106_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==107)
			{
				hTableName.value="rbo005";
				hParams1.value= "prc_1615_po0107_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==108)
			{
				hTableName.value="rbo005";
				hParams1.value= "prc_1615_po0108_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==109)
			{
				hTableName.value="rbo005";
				hParams1.value= "prc_1615_po0109_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			
			else if(rpt_type.value==111)
			{
				hTableName.value="rbo005";
				hParams1.value= "prc_1615_po0111_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==112)
			{
				hTableName.value="rbo005";
				hParams1.value= "prc_1615_po0112_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==113)
			{
				hTableName.value="rbo005";
				hParams1.value= "prc_1615_po0113_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==114)
			{
				hTableName.value="rbo005";
				hParams1.value= "prc_1615_po0114_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==117)
			{
				hTableName.value="rbo005";
				hParams1.value= "prc_7162_po0117_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==118)
			{
				hTableName.value="rbo005";
				hParams1.value= "prc_1615_rpt118_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==119)
			{
				hTableName.value="rbo005";
				hParams1.value= "prc_1615_7955_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==120)
			{
				hTableName.value="rbo005";
				hParams1.value= "prc_1615_7956_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==121)
			{
				hTableName.value="rco005";
				hParams1.value= "prc_1615_pr119_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==122)
			{
				hTableName.value="rbo005";
				hParams1.value= "prc_1615_rpt120_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==123)
			{
				hTableName.value="rbo005";
				hParams1.value= "prc_1615_rpt121_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==124)
			{
				hTableName.value="rbo006";
				hParams1.value= "PRC_1615_makeUpSim_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}    
			else if(rpt_type.value==125)
			{
				hTableName.value="rbo006";
				hParams1.value= "PRC_1615_gprsSale_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}  
				else if(rpt_type.value==126)
			{
				hTableName.value="rbo006";
				hParams1.value= "PRC_1615_gprsSaleCard_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}  
			    
			else if(rpt_type.value==127)
			{
				hTableName.value="rpo005";
				hParams1.value= "prc_1615_wpaybc_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==128)
			{
				hTableName.value="rbo005";
				hParams1.value= "prc_1615_po128_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==129)
			{
				hTableName.value="rbo006";
				hParams1.value= "prc_1615_po129_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}  
			else if(rpt_type.value==130)
			{
				hTableName.value="rbo006";
				hParams1.value= "prc_1615_po130_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";} 
			else if(rpt_type.value==131)
			{
				hTableName.value="rbo006";
				hParams1.value= "prc_1615_po131_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}   
			else if(rpt_type.value==132)
			{
				hTableName.value="rbo006";
				hParams1.value= "prc_1615_po132_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==133)
			{
				hTableName.value="rbo006";
				hParams1.value= "prc_1615_po133_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";} 
			else if(rpt_type.value==134)
			{
				hTableName.value="rbo006";
				hParams1.value= "prc_1615_po134_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==135)
			{
				hTableName.value="rbo006";
				hParams1.value= "PRC_1615_TD135_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==136)
			{
				hTableName.value="rbo006";
				hParams1.value= "PRC_1615_TD136_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";}
			else if(rpt_type.value==137)
			{
				hTableName.value="rbo006";
				hParams1.value= "PRC_1615_TD137_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";} 
			else if(rpt_type.value==138)
			{
				hTableName.value="rbo006";
				hParams1.value= "prc_1615_po138_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";} 
			else if(rpt_type.value==139)
			{
				hTableName.value="rbo006";
				hParams1.value= "PRC_1615_7671_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";} 
				
			//20100927-17:21关于哈尔滨分公司开展预存话费赠黑莓终端营销活动相关内容的请示@jingang
			else if(rpt_type.value==143)
	    {
	      hTableName.value="rbo006";
	      hParams1.value= "PRC_1615_7673_upg('"+document.form1.workNo.value+"','"+document.form1.login_no.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"','"+document.form1.rpt_format.value+"'";
	   		action="print_rpt_crm.jsp";
	    }
	    else if(document.form1.rpt_type.value==140)
	    {//20101019关于绥化分公司针对特定客户预存话费赠G3无线座机的需求@jingang@140-142
	      hTableName.value="rbo006";  
	      hParams1.value= "PRC_1615_TD141_upg('"+document.form1.workNo.value+"','"+document.form1.login_no.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"','"+document.form1.rpt_format.value+"'";
	   		action="print_rpt_crm.jsp";
	    } 
	    else if(document.form1.rpt_type.value==141)
	    {
	      hTableName.value="rbo006";
	      hParams1.value= "PRC_1615_TD144_UPG('"+document.form1.workNo.value+"','"+document.form1.login_no.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"','"+document.form1.rpt_format.value+"'";
	   		action="print_rpt_crm.jsp";
	    }
	    else if(document.form1.rpt_type.value==142)
	    {
	      hTableName.value="rbo006";
	      hParams1.value= "PRC_1615_7672_upg('"+document.form1.workNo.value+"','"+document.form1.login_no.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"','"+document.form1.rpt_format.value+"'";
	   		action="print_rpt_crm.jsp";
	    }	
		
			else if(rpt_type.value==148)
			{//20101207营业员电子化工单打印统计表
				hTableName.value="rbo005";
				hParams1.value= "prc_1615_hwprt_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";
			}
			else if(rpt_type.value==149)
		  {
		    hTableName.value="dbo005";
		    hParams1.value= "prc_1615_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
		    action="print_rpt_crm.jsp";
		  }
			else if(rpt_type.value==150)
	    {
	      hTableName.value="rbo006";
	      hParams1.value= "PRC_2146_d069_upg('"+document.form1.workNo.value+"','"+document.form1.login_no.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"'";
	    	action="print_rpt_crm.jsp";
	    }
	    else if(rpt_type.value==151)
	    {
	      hTableName.value="rbo006";
	      hParams1.value= "prc_2146_2285_upg('"+document.form1.workNo.value+"','"+document.form1.login_no.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"'";
	    	action="print_rpt_crm.jsp";
	    }
	    else if(rpt_type.value==153)
	    {//huangrong add 2011-6-16 营业员预存话费领奖明细报表
	      hTableName.value="rbo006";
	      hParams1.value= "prc_2146_153_upg('"+document.form1.workNo.value+"','"+document.form1.login_no.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"'";
	    	action="print_rpt_crm.jsp";
	    }
	    //xl add 改为调用计费存储过程 prc_2146_154_upg
			else if(rpt_type.value==154)	 
	    {
	      hTableName.value="rbo006";
	      hParams1.value= "DBCUSTADM.PRC_2146_154_billing('"+document.form1.workNo.value+"','"+document.form1.login_no.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"'";
	    	action="print_rpt_boss.jsp";
	    }
	    else if(rpt_type.value==157)	//2011/11/16 diling增加 营业员sim补卡统计报表
	    {
            hTableName.value="rcr001";
            hParams1.value= "prc_2146_157_upg('"+document.form1.workNo.value+"','"+document.form1.login_no.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"'";
            action="print_rpt_crm.jsp";
	    }
	    else if(rpt_type.value==158)	//2011/12/20 wanghfa增加 营业员合约计划营销案报表
	    {
	      hTableName.value="rcr001";
	      hParams1.value= "prc_2146_158_upg('"+document.form1.workNo.value+"','"+document.form1.login_no.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"'";
	    	action="print_rpt_crm.jsp";
	    }
	    	    else if(rpt_type.value==159)	//2011/01/05 wanghyd增加 营业员自备机合约营销案报表
	    {
	      hTableName.value="rcr001";
	      hParams1.value= "prc_2146_159_upg('"+document.form1.workNo.value+"','"+document.form1.login_no.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"'";
	    	action="print_rpt_crm.jsp";
	    }
	   	else if(rpt_type.value==160)	//zhangyan add
	    {
	      hTableName.value="rcr001";
	      hParams1.value= "prc_2146_160_upg('"+document.form1.workNo.value+"','"
	      	+document.form1.login_no.value+"','"
	      	+document.form1.begin_time.value+"','"
	      	+document.form1.end_time.value+"'";
	    	action="print_rpt_crm.jsp";
	    }	    
	    
			else if(rpt_type.value==161)	//wanghyd add
	    {
	      hTableName.value="rbo006";
	      hParams1.value= "prc_2146_161_upg('"+document.form1.workNo.value+"','"
	      	+document.form1.login_no.value+"','"
	      	+document.form1.begin_time.value+"','"
	      	+document.form1.end_time.value+"'";
	    	action="print_rpt_crm.jsp";
	    }
	    else if(rpt_type.value==162)	//ningtn 2012-8-7 15:38:41
	    {
	      hTableName.value="rbo006";
	      hParams1.value= "prc_2146_162_upg('"+document.form1.workNo.value+"','"
	      	+document.form1.login_no.value+"','"
	      	+document.form1.begin_time.value+"','"
	      	+document.form1.end_time.value+"'";
	    	action="print_rpt_crm.jsp";
	    }
	    	    else if(rpt_type.value==163)	//wanghyd 2012/9/24 11:18
	    {
	      hTableName.value="rbo006";
	      hParams1.value= "PRC_1615_TD163_upg('"+document.form1.workNo.value+"','"
	      	+document.form1.login_no.value+"','"
	      	+document.form1.begin_time.value+"','"
	      	+document.form1.end_time.value+"','"+rpt_format.value+"'";
	    	action="print_rpt_crm.jsp";
	    }
	     else if(rpt_type.value==164) {	//zhouby 2013/4/9
	      hTableName.value="rbo006";
	      hParams1.value= "PRC_2146_164_upg('"+document.form1.workNo.value+"','"
	      	+document.form1.login_no.value+"','"
	      	+document.form1.begin_time.value+"','"
	      	+document.form1.end_time.value+"','"+rpt_format.value+"'";
	    	action="print_rpt_crm.jsp";
	    }
	    else if(rpt_type.value==165) {	//fusk R_CMI_HLJ_xueyz_2014_1524671@关于报送2014年3月业务支撑系统市场专业需求的函-优化2355强开界面的需求
	      hTableName.value="RPT2266";
	      hParams1.value= "PRC_2146_RPT165_UPG('"+document.form1.workNo.value+"','"
	      	+document.form1.login_no.value+"','"
	      	+document.form1.begin_time.value+"','"
	      	+document.form1.end_time.value+"'";
	    	action="print_rpt_crm.jsp";
	    }
	    else if(rpt_type.value==341) {
    	  hTableName.value="rbo006";
	      hParams1.value= "prc_2146_341_upg('"+document.form1.workNo.value+"','"
	      	+document.form1.login_no.value+"','"
	      	+document.form1.begin_time.value+"','"
	      	+document.form1.end_time.value+"','"+rpt_format.value+"'";
	    	action="print_rpt_crm.jsp";
      }
	    else if(rpt_type.value==342){ /* 营业员实收统计报表一（旧版) */
				hTableName.value="t1788rpt";
				hParams1.value= "prc_1615_rpt1_upg_old('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";
			}
			else if(rpt_type.value==343){ /* 营业员实收统计报表二（旧版） */
				hTableName.value="t1788rpt";
				hParams1.value= "prc_1615_rpt2_upg_old('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_crm.jsp";
			}
			else if(rpt_type.value==344) {
    	  hTableName.value="rbo006";
	      hParams1.value= "prc_2146_344_upg('"+document.form1.workNo.value+"','"
	      	+document.form1.login_no.value+"','"
	      	+document.form1.begin_time.value+"','"
	      	+document.form1.end_time.value+"','"+rpt_format.value+"'";
	    	action="print_rpt_crm.jsp";
      }
      			else if(rpt_type.value==345) {
    	  hTableName.value="rbo006";
	      hParams1.value= "prc_2146_345jfzz_upg('"+document.form1.workNo.value+"','"
	      	+document.form1.login_no.value+"','"
	      	+document.form1.begin_time.value+"','"
	      	+document.form1.end_time.value+"','"+rpt_format.value+"'";
	    	action="print_rpt_crm.jsp";
      }
      else if(rpt_type.value==347) {
    	  hTableName.value="rbo006";
	      hParams1.value= "prc_2146_347_upg('"+document.form1.workNo.value+"','"
	      	+document.form1.login_no.value+"','"
	      	+document.form1.begin_time.value+"','"
	      	+document.form1.end_time.value+"','"+rpt_format.value+"'";
	    	action="print_rpt_crm.jsp";
      }
      else if(rpt_type.value==348) {
    	  hTableName.value="rbo006";
	      hParams1.value= "prc_2146_348_upg('"+document.form1.workNo.value+"','"
	      	+document.form1.login_no.value+"','"
	      	+document.form1.begin_time.value+"','"
	      	+document.form1.end_time.value+"','"+rpt_format.value+"'";
	    	action="print_rpt_crm.jsp";
      }
      else if(rpt_type.value==349) {
    	  hTableName.value="rbo006";
	      hParams1.value= "prc_2146_349_upg('"+document.form1.workNo.value+"','"
	      	+document.form1.login_no.value+"','"
	      	+document.form1.begin_time.value+"','"
	      	+document.form1.end_time.value+"','"+rpt_format.value+"'";
	    	action="print_rpt_crm.jsp";
      }else if(rpt_type.value==350) {
    	  hTableName.value="rcr001";
	      hParams1.value= "prc_2146_350_upg('"+document.form1.workNo.value+"','"
	      	+document.form1.login_no.value+"','"
	      	+document.form1.begin_time.value+"','"
	      	+document.form1.end_time.value+"','"+rpt_format.value+"'";
	    	action="print_rpt_crm.jsp";
      }/*else if(rpt_type.value==351)
			{
				alert("1");
				hTableName.value="rcr001";
				hParams1.value= "prc_2146_351_upg('"+document.form1.workNo.value+"','"
	      	+document.form1.login_no.value+"','"
	      	+document.form1.begin_time.value+"','"
	      	+document.form1.end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_crm.jsp";
			}*/
			else if(rpt_type.value==351) {
    	  hTableName.value="rcr001";
	      hParams1.value= "prc_2146_351_upg('"+document.form1.workNo.value+"','"
	      	+document.form1.login_no.value+"','"
	      	+document.form1.begin_time.value+"','"
	      	+document.form1.end_time.value+"','"+rpt_format.value+"'";
	    	action="print_rpt_crm.jsp";
      }	else if(rpt_type.value==372) {
    	  hTableName.value="rbo005";
	      hParams1.value= "prc_1615_372_upg('"+document.form1.workNo.value+"','"
	      	+document.form1.login_no.value+"','"
	      	+document.form1.begin_time.value+"','"
	      	+document.form1.end_time.value+"','"+rpt_format.value+"'";
	    	action="print_rpt_crm.jsp";
      }else if(rpt_type.value==373) {
    	  hTableName.value="rbo005";
	      hParams1.value= "prc_1615_373_upg('"+document.form1.workNo.value+"','"
	      	+document.form1.login_no.value+"','"
	      	+document.form1.begin_time.value+"','"
	      	+document.form1.end_time.value+"','"+rpt_format.value+"'";
	    	action="print_rpt_crm.jsp";
      }else if(rpt_type.value==375) {
    	  hTableName.value="rbo005";
	      hParams1.value= "prc_2146_375_upg('"+document.form1.workNo.value+"','"
	      	+document.form1.login_no.value+"','"
	      	+document.form1.begin_time.value+"','"
	      	+document.form1.end_time.value+"','"+rpt_format.value+"'";
	    	action="print_rpt_crm.jsp";
      }
		
      
		}
	}
}
