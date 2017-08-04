//** yuanqs 100601 crm维护的报表调用此方法,参数statement是页面form对象
function select_crm(statement)
{
	if(statement)
	{
		with(statement)
		{
			if(rpt_type.value==1) /*业务操作明细报表*/
			{
				hTableName.value="rbo006";
				hParams1.value= "prc_g642_bo006_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+function_code.value+"'";
				action = "print_rpt_crm.jsp";
			}
			else if(rpt_type.value==2) /*营业员促销品统一付奖明细报表*/
			{
				hTableName.value="rpt003";
				hParams1.value= "PRC_g642_CX028_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action = "print_rpt_crm.jsp";
			}
		}
	}
}
