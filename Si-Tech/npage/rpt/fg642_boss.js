//** yuanqs 100601 boss维护的报表调用此方法，参数statement是页面form对象
function select_boss(statement)
{
	if(statement)
	{
		with(statement) 
		{
			if(rpt_type.value==3)
			{
				//alert(" boss 存储过程");
				hTableName.value="rpo006";
				hParams1.value= "dbcustadm.PRC_g642_PO006_UPG('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+function_code.value+"'";
				action = "print_rpt_boss.jsp";
			}
			 
		}
	}
}