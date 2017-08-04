//wanghfa 20100602 crm维护的报表调用此方法，参数statement是页面form对象
function select_boss(statement)
{
	if(statement)
	{
		with(statement)
		{
			if(rpt_type.value==10)
			{    	
				hTableName.value="rgd002";
				hParams1.value= "prc_1630_gd002_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_boss.jsp";}
			else if(rpt_type.value==12)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_1247_pr002_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_boss.jsp";}
				else if(rpt_type.value==19)
			{
				hTableName.value="rfo006";
				hParams1.value= "prc_1676_001Prn_upg('"+rptright.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+workNo.value+"',' ','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_boss.jsp";}
				else if(rpt_type.value==27)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_1247_pr0010_2_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_boss.jsp";}  
			else if(rpt_type.value==42)
			{
				hTableName.value="rcd002";
				hParams1.value="prc_1250_2_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_boss.jsp";}
			else if(rpt_type.value==45)
			{
				hTableName.value="rcd002";
				hParams1.value="prc_1251_3_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_boss.jsp";}
			else if(rpt_type.value==46)
			{
				hTableName.value="rct003";
				hParams1.value="prc_1247_pr001_2_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_boss.jsp";}
				else if(rpt_type.value==70)
			{
				hTableName.value="rcr7722";
				hParams1.value= "prc_7722_3_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_boss.jsp";}  
			else if(rpt_type.value==71)
			{
				hTableName.value="rcr7722";
				hParams1.value= "prc_7722_mx3_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"','"+begin_phonehead.value+"','"+end_phonehead.value+"' ";
				action="print_rpt_boss.jsp";}   
			else if(rpt_type.value==72)
			{
				hTableName.value="rcr7722";
				hParams1.value= "prc_7722adj_3_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_boss.jsp";}    
			else if(rpt_type.value==73)
			{
				hTableName.value="rcr7722";
				hParams1.value= "prc_7722adj_mx3_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"','"+begin_phonehead.value+"','"+end_phonehead.value+"' ";
				action="print_rpt_boss.jsp";} 
			else if(rpt_type.value==134)
			{
				hTableName.value="rcr7722";
				hParams1.value= "prc_2225_mx3_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_boss.jsp";} 
			else if(rpt_type.value==151)
			{
				hTableName.value="rpd002";
				hParams1.value= "prc_3459_pt151_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_boss.jsp";}
				else if(rpt_type.value==189)
			{
				hTableName.value="rpd002";
				hParams1.value= "prc_1630_pt4141_1_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_boss.jsp";}
				else if(rpt_type.value==188)
			{
				hTableName.value="rpd002";
				hParams1.value= "prc_1630_pt4141_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_boss.jsp";}
				else if(rpt_type.value==307)
			{
				hTableName.value="rfo006";
				hParams1.value= "PRC_2148_JT01_UPG('"+rptright.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+workNo.value+"','"+begin_time.value+"','"+end_time.value+"' ";
			
				action="print_rpt_boss.jsp";}
				// add end
				else if(rpt_type.value==351)
				{
				hTableName.value="rfo006";
				hParams1.value= "DBCUSTADM.PRC_2148_ZQ_RPT('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
			
				action="print_rpt_boss.jsp";}
				//DBCUSTADM.PRC_2148_e_inv_billing
				else if(rpt_type.value==360)
				{
				hTableName.value="rbo006";
				hParams1.value= "DBCUSTADM.PRC_2148_e_inv_billing('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
			
				action="print_rpt_boss.jsp";}
		}
	}
}
