//** yuanqs 100601 crm维护的报表调用此方法,参数statement是页面form对象
function select_crm_bao(statement)
{
	if(statement)
	{
		with(statement)
		{
			if(rpt_type.value==1)
                        {
                                hTableName.value="rbo006";
                                hParams1.value= "prc_1610_bo006_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+function_code.value+"'";
                                action = "print_rpt_crm_report.jsp";
                        } else if(rpt_type.value==7)
			{
				hTableName.value="rvo006";
				hParams1.value= "prc_1610_vo006_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+function_code.value+"'";
				action="print_rpt_crm_report.jsp";
			}
			else if(rpt_type.value==21)
			{
				hTableName.value="rco005";
				hParams1.value= "prc_1610_do006_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+function_code.value+"'";
				action="print_rpt_crm_report.jsp";
			}
			else if(rpt_type.value==22)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_2145_pr003_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action = "print_rpt_crm_report.jsp";
			}			
			else if(rpt_type.value==40)
			{
				hTableName.value="rbo006";
				hParams1.value= "prc_2145_pos_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action = "print_rpt_crm_report.jsp";
			}
			else if(rpt_type.value==44)
			{
				hTableName.value="rbo006";
				hParams1.value= "prc_2145_1104_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action = "print_rpt_crm_report.jsp";
			}			
			
		}
	}
}
