//** yuanqs 100601 bossά���ı�����ô˷���������statement��ҳ��form����
function select_boss(statement)
{
	if(statement)
	{
		with(statement) 
		{
			if(rpt_type.value==3)
			{
				//alert(" boss �洢����");
				hTableName.value="rpo006";
				hParams1.value= "dbcustadm.PRC_g642_PO006_UPG('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+function_code.value+"'";
				action = "print_rpt_boss.jsp";
			}
			 
		}
	}
}