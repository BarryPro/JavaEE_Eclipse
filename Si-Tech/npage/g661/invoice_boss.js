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
			    var g_id = document.getElementById("group_id").value;
			    //alert(g_id);
				hTableName.value="rfo006";
				var bankName = bank_name.value;
				//alert(bankName);

				//hParams1.value= "DBCUSTADM.PRC_invoice_rpt_qx('"+workNo.value+"','"+begin_time.value+"','"+end_time.value+"','"+bankName+"' ";
				if(objSel.value==1)
			    {
					hParams1.value= "DBCUSTADM.PRC_invoice_rpt_yyt('"+workNo.value+"','"+workNo.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				}
				if(objSel.value==2)
			    {
					hParams1.value= "DBCUSTADM.PRC_invoice_rpt_qx('"+workNo.value+"','"+g_id+"','"+workNo.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				}
				if(objSel.value==3)
			    {
					hParams1.value= "DBCUSTADM.PRC_invoice_rpt_ds6('"+workNo.value+"','"+g_id+"','"+workNo.value+"','"+begin_time.value+"','"+end_time.value+"' ";
				}
				
				action="print_rpt_boss.jsp";
		 
		}
	}
}