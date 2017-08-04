//wanghfa 20100602 crm维护的报表调用此方法，参数statement是页面form对象
function select_boss(statement)
{
	//var bank_name = document.getElementById("selOp").value;
	
	 //alert(bank_name);
	if(statement)
	{
		with(statement)
		{
			// var objSel = document.getElementById("selOp");

			   
			  
				hTableName.value="rpt003";
				//var bankName = bank_name.value;
				//alert(bankName);

				hParams1.value= "DBCUSTADM.PRC_g248('"+workNo.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				action="print_rpt_boss.jsp";
		 
		}
	}
}