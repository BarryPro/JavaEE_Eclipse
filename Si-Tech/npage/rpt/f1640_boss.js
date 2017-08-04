//wanghfa 20100602 crm维护的报表调用此方法，参数statement是页面form对象
function select_boss(statement)
{
	if(statement)
	{
		with(statement)
		{
			if(rpt_type.value==10)
			{
				hTableName.value="rgr001";
				hParams1.value= "prc_1640_gr001_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_boss.jsp";}
			else if(rpt_type.value==12)
			{
				hTableName.value="rcr001";
				hParams1.value= "prc_1247_pr002_1_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_boss.jsp";}
				else if(rpt_type.value==18)
			{
				hTableName.value="rfo006";
				hParams1.value= "prc_1676_001Prn_upg('"+rptRight.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+workNo.value+"',' ','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_boss.jsp";}
				else if(rpt_type.value==26)
			{
				hTableName.value="rcr001";
				hParams1.value= "prc_1247_pr0010_4_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_boss.jsp";}
			else if(rpt_type.value==41)
			{
				hTableName.value="rcd002";
				hParams1.value= 
				"prc_1250_3_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_boss.jsp";}
			else if(rpt_type.value==42)
			{
				hTableName.value="rpr001";
				hParams1.value= 
				"prc_1251_4_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_boss.jsp";}
			else if(rpt_type.value==43)
			{
				hTableName.value="rct003";
				hParams1.value= 
				"prc_1247_pr001_3_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_boss.jsp";}
				else if(rpt_type.value==45)
			{
				hTableName.value="rcr001";
				hParams1.value= "prc_1252_4_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_boss.jsp";}
				else if(rpt_type.value==47)
			{
				hTableName.value="rpr001";
				hParams1.value= "prc_9004_4_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_boss.jsp";}
			else if(rpt_type.value==75)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_2308_pt075_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_boss.jsp";}
				else if(rpt_type.value==76)
			{
				hTableName.value="rcr7722";
				hParams1.value= "prc_7722_4_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_boss.jsp";}
			else if(rpt_type.value==77)
			{
				hTableName.value="rcr7722";
				hParams1.value= "prc_7722_mx4_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"','"+begin_phonehead.value+"','"+end_phonehead.value+"' ";
				action="print_rpt_boss.jsp";} 
			else if(rpt_type.value==78)
			{
				hTableName.value="rcr7722";
				hParams1.value= "prc_7722adj_4_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_boss.jsp";} 
			else if(rpt_type.value==79)
			{
				hTableName.value="rcr7722";
				hParams1.value= "prc_7722adj_mx4_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"','"+begin_phonehead.value+"','"+end_phonehead.value+"' ";
				action="print_rpt_boss.jsp";} 
			else if(rpt_type.value==148)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_3459_pr0148_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_boss.jsp";}
			else if(rpt_type.value==185)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_3303_rpt1640_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_boss.jsp";}
				else if(rpt_type.value==200)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_1640_4141_1_UPG('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_boss.jsp";}
				else if(rpt_type.value==199)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_1640_4141_UPG('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_boss.jsp";}
				
				else if(rpt_type.value==209)
    {
      alert("20911111");
	  hTableName.value="ryt001";
      hParams1.value= "dbcustadm.PRC_1733_UPG('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
     action="print_rpt_boss.jsp";
    }
    else if(rpt_type.value==210)
    {
      hTableName.value="ryt001";
      hParams1.value= "PRC_1734_UPG('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
     action="print_rpt_boss.jsp";
    }
    //addby zhangxq 20101012---begin
    else if(rpt_type.value==222)
    {
      hTableName.value="rbo005";
      hParams1.value= "PRC_1735_UPG('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
     action="print_rpt_boss.jsp";
    }
     
     else if(rpt_type.value==223)
    {
      hTableName.value="rpt003";
      hParams1.value= "PRC_1640_CHN223_UPG('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
     action="print_rpt_boss.jsp";
    }
     else if(rpt_type.value==224)
    {
      hTableName.value="rpt003";
      hParams1.value= "PRC_1640_RPT224_UPG('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
     action="print_rpt_boss.jsp";
    }
    //addby zhangxq 20101012---end
	else if(rpt_type.value == 300)
	{
		alert("go 300");
		hTableName.value="rpt003";
		hParams1.value= "dbreport.PRC_1640_RPT300_UPG('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
		action="print_rpt_boss.jsp";
	}
			else if(rpt_type.value==307)
			{
				hTableName.value="rfo006";
				hParams1.value= "prc_2148_JT01_upg('"+rptRight.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+workNo.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_boss.jsp";
			}
			// xl add
			else if(document.form1.rpt_type.value==314) 
			{        
			    hTableName.value="rbo006";
			    hParams1.value= "DBCUSTADM.prc_2149_314_new('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.bGroupId.value+"','"+document.form1.eGroupId.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"' ";
			    action="print_rpt_boss.jsp";
		  }
			// xl add
			else if(document.form1.rpt_type.value==365) 
			{        
				//alert("yrdy");
			    hTableName.value="rpr001";
			    hParams1.value= "DBCUSTADM.PRC_2149_311_PR001('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.bGroupId.value+"','"+document.form1.eGroupId.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"' ";
			    action="print_rpt_boss.jsp";
		  }
		  else if(rpt_type.value==366)
			{
				hTableName.value="rpt003";
				hParams1.value= "DBCUSTADM.prc_e068_pt366_upg('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_boss.jsp";
			}
			 else if(rpt_type.value==371)
			{
				hTableName.value="RFO006";
				hParams1.value= "DBCUSTADM.PRC_2149_ZQ_RPT('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_boss.jsp";
			}
			else if(rpt_type.value==385)
			{
				hTableName.value="rbo006";
				hParams1.value= "DBCUSTADM.PRC_2149_e_inv_billing('"+workNo.value+"','"+groupId.value+"','"+bGroupId.value+"','"+eGroupId.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_boss.jsp";
			}
		}
	}
}
