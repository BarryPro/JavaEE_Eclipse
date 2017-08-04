//wanghfa 20100602 crm维护的报表调用此方法，参数statement是页面form对象
function select_boss(statement)
{
	//var bank_name = document.getElementById("selOp").value;
	
	 //alert(bank_name);
	if(statement)
	{
		with(statement)
		{
			    var objSel = document.getElementById("selOp");
				//alert(objSel.value);
			    var g_id = document.getElementById("status_id").value;
			    //alert(g_id);
				hTableName.value="rfo006";
				//var bankName = bank_name.value;
				//alert(bankName);

				//hParams1.value= "DBCUSTADM.PRC_group_bill('"+workNo.value+"','"+begin_time.value+"','"+end_time.value+"','"+bankName+"' ";
				
				hParams1.value= "DBCUSTADM.PRC_group_bill('"+workNo.value+"','"+jtcpid.value+"','"+end_time.value+"','"+g_id+"' ";
				
				action="print_rpt_boss.jsp";
		 
		}
	}
}