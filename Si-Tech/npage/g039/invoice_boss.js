//wanghfa 20100602 crmά���ı�����ô˷���������statement��ҳ��form����
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
				var bankName = bank_name.value;
				var regionName = region_name.value;
				
				//alert(bankName);

				hParams1.value= "DBCUSTADM.PRC_bankCount_dtl('"+workNo.value+"','"+begin_time.value+"','"+end_time.value+"','"+bankName+"','"+regionName+"' ";
				action="print_rpt_boss.jsp";
		 
		}
	}
}