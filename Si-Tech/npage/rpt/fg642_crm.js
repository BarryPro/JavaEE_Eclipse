//** yuanqs 100601 crmά���ı�����ô˷���,����statement��ҳ��form����
function select_crm(statement)
{
	if(statement)
	{
		with(statement)
		{
			if(rpt_type.value==1) /*ҵ�������ϸ����*/
			{
				hTableName.value="rbo006";
				hParams1.value= "prc_g642_bo006_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+function_code.value+"'";
				action = "print_rpt_crm.jsp";
			}
			else if(rpt_type.value==2) /*ӪҵԱ����Ʒͳһ������ϸ����*/
			{
				hTableName.value="rpt003";
				hParams1.value= "PRC_g642_CX028_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action = "print_rpt_crm.jsp";
			}
		}
	}
}
