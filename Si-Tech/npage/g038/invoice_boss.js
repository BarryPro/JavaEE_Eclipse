//wanghfa 20100602 crm维护的报表调用此方法，参数statement是页面form对象
function select_boss_count(statement)
{
	if(statement)
	{
		with(statement)
		{
			 
				//alert("test");
				var bankName = bank_name.value;
				hTableName.value="rpt003";
				hParams1.value= "DBCUSTADM.PRC_bankCount('"+workNo.value+"','"+begin_time.value+"','"+end_time.value+"','"+bankName+"' ";
				action="print_rpt_boss.jsp";
		 
		}
	}
}