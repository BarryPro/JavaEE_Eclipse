//wanghfa 20100602 boss维护的报表调用此方法，参数statement是页面form对象
function select_boss(statement)
{
	if(statement)
	{
		with(statement)
		{
			if(rpt_type.value==2)
			{
				hTableName.value="rpo005";
				hParams1.value= "prc_1615_po005_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_boss.jsp";}
			else if(rpt_type.value==14)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_1247_pr001_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_boss.jsp";}
			else if(rpt_type.value==21)
			{
				hTableName.value="rfo006";
				hParams1.value= "prc_1676_001Prn_upg('"+rptRight.value+"','"+groupId.value+"',' ',' ','"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_boss.jsp";}
			else if(rpt_type.value==33)
			{
				hTableName.value="rPo005";
				hParams1.value= "PRC_1251_1_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action="print_rpt_boss.jsp";}
			else if(rpt_type.value==115)
			{
				hTableName.value="rbo005";
				hParams1.value= "prc_1615_po0115_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_boss.jsp";}
			else if(rpt_type.value==116)
			{
				hTableName.value="rbo005";
				hParams1.value= "prc_1615_po0116_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_boss.jsp";}
			//xl add 集团产品转账报表
			else if(rpt_type.value==336)
			{
				hTableName.value="rfo006";
				hParams1.value= "DBCUSTADM.PRC_e832_RPT('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				//alert("新的存储过程"+hParams1.value);
				action="print_rpt_boss.jsp";}
			//
			else if(rpt_type.value==346)
			{
				//alert("test");
				 
				hTableName.value="RCR7722";
				hParams1.value= "dbcustadm.PRC_CARD_TJ_UPG('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action="print_rpt_boss.jsp";
			}
			//xl add for huxl e832冲正报表 参数和临时表
			else if(rpt_type.value==371)
			{
				//alert("test");
				 
				hTableName.value="RFO006";
				hParams1.value= "DBCUSTADM.PRC_2146_ZQ_RPT('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				//alert(hParams1.value);
				action="print_rpt_boss.jsp";
			}
			//'376 DBCUSTADM.PRC_2146_e_inv_billing
			else if(rpt_type.value==376)
			{
				//alert("test");
				 
				hTableName.value="rbo006";
				hParams1.value= "DBCUSTADM.PRC_2146_e_inv_billing('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				//alert(hParams1.value);
				action="print_rpt_boss.jsp";
			}
		}
	}
}

