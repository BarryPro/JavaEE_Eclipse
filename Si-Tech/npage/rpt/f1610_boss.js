//** yuanqs 100601 boss维护的报表调用此方法，参数statement是页面form对象
function select_boss(statement)
{
	if(statement)
	{
		with(statement) 
		{
			if(rpt_type.value==2)
			{
				hTableName.value="rpo006";
				hParams1.value= "prc_1610_po006_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+function_code.value+"'";
				action = "print_rpt_boss.jsp";
			}
			else if(rpt_type.value==18)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_1247_pr001_upg('"+workNo.value+"','"+login_no.value+ "','" + begin_time.value+"','"+end_time.value+"'";
				action = "print_rpt_boss.jsp";
			}
			else if(rpt_type.value==23)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_1249_1_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+function_code.value+"'";
				action = "print_rpt_boss.jsp";
			}
			else if(rpt_type.value==24)
			{
				hTableName.value="rPo006";
				hParams1.value= "prc_1610_po006_1_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+function_code.value+"'";
				action = "print_rpt_boss.jsp";
			}
			//xl add 1362 操作明细报表
			else if(rpt_type.value==42)
			{
				hTableName.value="rfo006";
				//hParams1.value= "DBCUSTADM.PRC_1362_MX_RPT('"+workNo.value+"','"+groupId.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+function_code.value+"'";
				hParams1.value= "DBCUSTADM.PRC_1362_MX_RPT('"+workNo.value+"','"+groupId.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action = "print_rpt_boss.jsp";
			}
			else if(rpt_type.value==43)
			{
				hTableName.value="rfo006";
				//hParams1.value= "DBCUSTADM.PRC_1362_MX_RPT('"+workNo.value+"','"+groupId.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+function_code.value+"'";
				hParams1.value= "DBCUSTADM.PRC_1364_RPT_2145('"+workNo.value+"','"+groupId.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action = "print_rpt_boss.jsp";
			}
		}
	}
}