 <%
	/********************
	 version v2.0
	������: si-tech
	update:anln@2009-02-07 ҳ�����,�޸���ʽ
	********************/
%>  

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%	
	
//---------------------------------java������------------------------------------
	String opCode = "5263";	
	String opName = "�����̻������ϲ�ѯ";	//header.jsp��Ҫ�Ĳ���   
			
	//���й���Ȩ�޼���

%>

<html>
	<head>
		<title>�����̻������ϲ�ѯ</title>
		<%//-----------------------------------js����-------------------------------------%>		
		<script language=javascript>
			var agentPhone 	;
			var agent_name  ;
			var agent_address;
			var legal_present;
			var legal_id ;
			var account_no ;
			var agent_phone ;
			var register_money;
			var contact_person;
			var contact_id;
			var contact_phone;
			var bank_name;
			var bank_code;
			var deposit;
			var agent_size;
			var person_count;
			var person_count1;
			var pb_size ;
			var sign_time ;
			var father_agent;
			var limit_owe ;
		
			var agent_code ;
			var agent_type;
			var describe;
			var entity_group_name;
		  var entryType;
		  
			var work_no ;
			var amend_time ;
			var amend_before ;
			var amend_after ;
			
		
		//-------------------------------------����RPC------------------------------------
			
			onload=function() {
					
			}
		
			function doProcess(packet) {
				resetJSP();
				self.status="";
				var errCode = packet.data.findValueByName("errCode");
				var errMsg = packet.data.findValueByName("errMsg");
		    
		    		agentPhone = packet.data.findValueByName("agentPhone");
				agent_name = packet.data.findValueByName("agent_name");
				agent_address = packet.data.findValueByName("agent_address");
				legal_present = packet.data.findValueByName("legal_present");
				legal_id = packet.data.findValueByName("legal_id");
				account_no = packet.data.findValueByName("account_no");
				
				agent_phone = packet.data.findValueByName("agent_phone");
				register_money = packet.data.findValueByName("register_money");
				contact_person = packet.data.findValueByName("contact_person");
				contact_id = packet.data.findValueByName("contact_id");
				contact_phone = packet.data.findValueByName("contact_phone");
		
				bank_name = packet.data.findValueByName("bank_name");
				bank_code = packet.data.findValueByName("bank_code");
				deposit = packet.data.findValueByName("deposit");
				agent_size = packet.data.findValueByName("agent_size");
				person_count = packet.data.findValueByName("person_count");
		
				person_count1 = packet.data.findValueByName("person_count1");
				pb_size = packet.data.findValueByName("pb_size");
				sign_time = packet.data.findValueByName("sign_time");
				father_agent = packet.data.findValueByName("father_agent");
				limit_owe = packet.data.findValueByName("limit_owe");
		
				agent_code = packet.data.findValueByName("agent_code");
				agent_type = packet.data.findValueByName("agent_type");
				describe = packet.data.findValueByName("describe");
				entity_group_name = packet.data.findValueByName("entity_group_name");
				entryType = '��';
				if(entity_group_name == '')
				{
				    entryType = '��';
				}
				
		
				work_no = packet.data.findValueByName("work_no");
				amend_time = packet.data.findValueByName("amend_time");
				amend_before = packet.data.findValueByName("amend_before");
				amend_after = packet.data.findValueByName("amend_after");
		
		    
		    		document.form1.agentPhone.value=agentPhone;
				document.getElementById("agent_name").innerHTML = agent_name+"&nbsp;";
				document.getElementById("agent_address").innerHTML = agent_address+"&nbsp;";
				document.getElementById("legal_present").innerHTML = legal_present+"&nbsp;";
				document.getElementById("legal_id").innerHTML = legal_id+"&nbsp;";
				document.getElementById("account_no").innerHTML = account_no+"&nbsp;";
		
				document.getElementById("agent_phone").innerHTML = agent_phone+"&nbsp;";
				document.getElementById("register_money").innerHTML = register_money+"&nbsp;";
				document.getElementById("contact_person").innerHTML = contact_person+"&nbsp;";
				document.getElementById("contact_id").innerHTML = contact_id+"&nbsp;";
				document.getElementById("contact_phone").innerHTML = contact_phone+"&nbsp;";
		
				document.getElementById("bank_name").innerHTML = bank_name+"&nbsp;";
				document.getElementById("bank_code").innerHTML = bank_code+"&nbsp;";
				document.getElementById("deposit").innerHTML = deposit+"&nbsp;";
				document.getElementById("agent_size").innerHTML = agent_size+"&nbsp";
				document.getElementById("person_count").innerHTML = person_count+"&nbsp;";
		
				document.getElementById("person_count1").innerHTML = person_count1+"&nbsp;";
				document.getElementById("pb_size").innerHTML = pb_size+"&nbsp;";
				document.getElementById("sign_time").innerHTML = sign_time+"&nbsp;";
				document.getElementById("father_agent").innerHTML = father_agent+"&nbsp;";
				document.getElementById("limit_owe").innerHTML = limit_owe+"&nbsp;";
		
				document.getElementById("agent_code").innerHTML = agent_code+"&nbsp;";
				document.getElementById("agent_type").innerHTML = agent_type+"&nbsp;";
				document.getElementById("describe").innerHTML = describe+"&nbsp;";
				
				document.getElementById("entryType").innerHTML = entryType+"&nbsp;";
				document.getElementById("entity_group_name").innerHTML = entity_group_name+"&nbsp;";
				
				if(errCode!="000000"){
					rdShowMessageDialog("������룺"+errCode+"<br>������Ϣ��"+errMsg);
					return false;
				}
				
				while(document.getElementById("table1").rows.length > 1){
					document.getElementById("table1").deleteRow(1);
				}
		
				for(i = 0;i < work_no.length;i++){
					var rows = document.getElementById("table1").rows.length;
					var newrow = document.getElementById("table1").insertRow(rows);
					newrow.insertCell(0).innerHTML=work_no[i];
					newrow.insertCell(1).innerHTML=amend_time[i];
					newrow.insertCell(2).innerHTML=amend_before[i];
					newrow.insertCell(3).innerHTML=amend_after[i];
				}
			}
		
			function findagent(){
				var agentPhone = document.form1.agentPhone.value;
				var myPacket = new AJAXPacket("f5263_RPC.jsp","�����ύ�����Ժ�......");
				myPacket.data.add("agentPhone",agentPhone);
				core.ajax.sendPacket(myPacket);
				myPacket=null;
			}
		
			//--------------------------------�ύ��------------------------------------
			function commit(){
				form1.action="";
				form1.submit();
				return true;
			}
			
			//---------------------------------��ձ�---------------------------------------
			function resetJSP(){
				for(i=0;i<document.form1.elements.length;i++){
					if (document.form1.elements[i].type=="text"){
						document.form1.elements[i].value = "";
					}
				}
			}
		</script>
</head>
	<%//--------------------------------------ҳ������--------------------------------------------%>
	<body>
		<form name="form1" method="post">
			<%@ include file="/npage/include/header.jsp" %>     	
			<div class="title">
				<div id="title_zi">�����̻������ϲ�ѯ</div>
			</div>
		        <table  cellspacing="0">
		          	<tr> 
		            		<td width="18%" class="blue" class="blue">�������ֻ���</td>
			            	<td width="32%"> 
			              		<input name="agentPhone" type="text"  id="agentPhone" maxlength="11">
						<input name="findagent1" type="button" class="b_text" value="��ѯ" onClick="findagent()">            </td>
			            		<td width="18%" >&nbsp;</td>
		            	    		<td width="32%" >&nbsp;</td>
		          	</tr>		
			          <tr> 
				            <td class="blue">��������</td>
				            <td id="agent_name">&nbsp;</td>
				            <td class="blue">�����ַ</td>
			            	    <td id="agent_address">&nbsp;</td>
			          </tr>		
				          <tr> 
					            <td class="blue" class="blue">���˴�������</td>
					            <td id="legal_present">&nbsp;</td>
					            <td class="blue">���˴������֤��</td>
					            <td id="legal_id">&nbsp;</td>
				          </tr>
		
				 	  <tr> 
					            <td  class="blue">�ʱ�</td>
					            <td id="account_no">&nbsp;</td>
					            <td  class="blue">��ϵ�绰</td>
					            <td id="agent_phone">&nbsp;</td>
		          		 </tr>
		
				          <tr> 
					            <td class="blue">ע���ʽ�</td>
					            <td id="register_money">&nbsp;</td>
					            <td class="blue">��ϵ������</td>
					            <td id="contact_person">&nbsp;</td>
				          </tr>
		
					  <tr> 
					            <td  class="blue">��ϵ�����֤��</td>
					            <td id="contact_id">&nbsp;</td>
					            <td  class="blue">��ϵ�˵绰</td>
					            <td id="contact_phone">&nbsp;</td>
				          </tr>		
					  <tr>
					            <td class="blue">��������</td>
					            <td id="bank_name">&nbsp;</td>
					            <td  class="blue">�����ʺ�</td>
					            <td id="bank_code">&nbsp;</td>
				          </tr>
		
				          <tr> 
					            <td class="blue">Ѻ����</td>
					            <td id="deposit">&nbsp;</td>
					            <td class="blue">Ӫҵ���</td>
					            <td id="agent_size">&nbsp;&nbsp;</td>
				          </tr>		
					   <tr> 
					            <td  class="blue">Ӫҵ��Ա��</td>
					            <td id="person_count">&nbsp;</td>
					            <td  class="blue">Ӫ����Ա��</td>
					            <td id="person_count1">&nbsp;</td>
				          </tr>
		
				          <tr> 
					            <td class="blue">���ҳߴ�</td>
					            <td id="pb_size">&nbsp;</td>
					            <td class="blue">ǩԼʱ��</td>
					            <td id="sign_time">&nbsp;</td>
				          </tr>
		
					  <tr> 
					            <td  class="blue">���ݲ�Ȩ</td>
					            <td id="father_agent">&nbsp;</td>
					            <td class="blue">�������޷���</td>
					            <td id="limit_owe">&nbsp;</td>
				          </tr>
		
				          <tr> 
					            <td class="blue">���г�ֵ�˺�</td>
					            <td id="agent_code">&nbsp;</td>
					            <td class="blue">��ǰ״̬</td>
					            <td id="agent_type">&nbsp;</td>
				          </tr>
				          <tr> 
				            <td class="blue">�����Ƿ�Ϊ��˾��������ʵ������</td>
				            <td colspan="3" id="entryType" readonly class="InputGrey">&nbsp;</td>
				          </tr>
							    <tr> 
				            <td class="blue">�����Ӧ����</td>
				            <td colspan="3" id="entity_group_name" readonly class="InputGrey">&nbsp;</td>
				          </tr>		
					        <tr> 
				            <td class="blue">��ע</td>
				            <td colspan="3" id="describe" readonly class="InputGrey">&nbsp;</td>
				          </tr>		
				</table>
				<br>
				<div class="title">
					<div id="title_zi">״̬�仯��¼</div>
				</div>			
				<table  id="table1"  cellspacing="0">
					<TR>
						<th>&nbsp;&nbsp;����</th>
						<th>&nbsp;&nbsp;�޸�ʱ��</th>
						<th>&nbsp;&nbsp;�޸�ǰ״̬</th>
						<th>&nbsp;&nbsp;�޸ĺ�״̬</th>
					</TR>
				</table>		   
		        	<table cellspacing="0">
				    	<tr >
				    		<td id="footer"> 				    			 
					                <input name="reset" type="button" class="b_foot"  value="��ӡ" onClick="printJSP()">
					                &nbsp; 
					                <input name="reset" type="button" class="b_foot"  value="���" onClick="resetJSP()">
					                &nbsp; 
					                <input name="back" onClick="removeCurrentTab()" class="b_foot" type="button"  value="�ر�" >
					                &nbsp; 
				    		</td>
				    	</tr>
				 </table>	
				 <%@ include file="/npage/include/footer.jsp" %>	  		
		</form>
	<OBJECT
		classid="clsid:28EE9D9D-1A80-4BFF-B464-0E6B69E26B05"
		codebase="/ocx/printatl.dll#version=1,0,0,1"
		id="printctrl"
		style="DISPLAY: none"
		VIEWASTEXT
		>
	</OBJECT>
	</body>
</html>

<script language=javascript>
	
function printJSP() {
	getAfterPrompt();
	//alert(document.form1.agentPhone.value);
	if (agent_name == ""){
     		 rdShowMessageDialog("��������Ϣ����ȷ�����ܴ�ӡ��");
      		 return false;
	}
   	printctrl.Setup(0) ;
	printctrl.StartPrint();
	printctrl.PageStart();

	printctrl.Print(10,5,9,0,"�������ֻ��ţ�"+document.form1.agentPhone.value);  
	
	printctrl.Print(10,6,9,0,"�������ƣ�    "+agent_name);  
	printctrl.Print(50,6,9,0,"�����ַ��    "+agent_address);  

	printctrl.Print(10,7,9,0,"���˴���������"+legal_present);  
	printctrl.Print(50,7,9,0,"���˴������֤�ţ�"+legal_id);  

	printctrl.Print(10,8,9,0,"�ʱࣺ        "+account_no);  
	printctrl.Print(50,8,9,0,"��ϵ�绰��    "+agent_phone);  

	printctrl.Print(10,9,9,0,"ע���ʽ�    "+register_money);  
	printctrl.Print(50,9,9,0,"��ϵ��������  "+contact_person);  

	printctrl.Print(10,10,9,0,"��ϵ�����֤�ţ�"+contact_id);  
	printctrl.Print(50,10,9,0,"��ϵ�˵绰�� "+contact_phone);  

	printctrl.Print(10,11,9,0,"�������У�   "+bank_name);  
	printctrl.Print(50,11,9,0,"�����ʺţ�   "+bank_code);  

	printctrl.Print(10,12,9,0,"Ѻ���   "+deposit);  
	printctrl.Print(50,12,9,0,"Ӫҵ�����   "+agent_size);  

	printctrl.Print(10,13,9,0,"Ӫҵ��Ա���� "+person_count);  
	printctrl.Print(50,13,9,0,"Ӫ����Ա���� "+person_count1);  

	printctrl.Print(10,14,9,0,"���ҳߴ磺   "+pb_size);  
	printctrl.Print(50,14,9,0,"ǩԼʱ�䣺   "+sign_time);  

	printctrl.Print(10,15,9,0,"���ݲ�Ȩ��   "+father_agent);  
	printctrl.Print(50,15,9,0,"�������޷��ã�"+limit_owe);  

	printctrl.Print(10,16,9,0,"���г�ֵ�˺ţ�"+agent_code);  
	printctrl.Print(50,16,9,0,"��ǰ״̬��    "+agent_type);  

  printctrl.Print(10,17,9,0,"�����Ƿ�Ϊ��˾��������ʵ��������"+entryType);
	printctrl.Print(10,18,9,0,"�����Ӧ���㣺"+entity_group_name);
	printctrl.Print(10,19,9,0,"��ע��        "+describe);  

	printctrl.PageEnd() ;
	printctrl.StopPrint() ; 
}

function resetJSP(){
    		document.form1.agentPhone.value="";    		
		document.getElementById("agent_name").innerHTML = ""+"&nbsp;";
		document.getElementById("agent_address").innerHTML = ""+"&nbsp;";
		document.getElementById("legal_present").innerHTML = ""+"&nbsp;";
		document.getElementById("legal_id").innerHTML = ""+"&nbsp;";
		document.getElementById("account_no").innerHTML = ""+"&nbsp;";

		document.getElementById("agent_phone").innerHTML = ""+"&nbsp;";
		document.getElementById("register_money").innerHTML = ""+"&nbsp;";
		document.getElementById("contact_person").innerHTML =""+"&nbsp;";
		document.getElementById("contact_id").innerHTML = ""+"&nbsp;";
		document.getElementById("contact_phone").innerHTML = ""+"&nbsp;";

		document.getElementById("bank_name").innerHTML = ""+"&nbsp;";
		document.getElementById("bank_code").innerHTML = ""+"&nbsp;";
		document.getElementById("deposit").innerHTML = ""+"&nbsp;";
		document.getElementById("agent_size").innerHTML =""+"&nbsp;";
		document.getElementById("person_count").innerHTML = ""+"&nbsp;";

		document.getElementById("person_count1").innerHTML = ""+"&nbsp;";
		document.getElementById("pb_size").innerHTML = ""+"&nbsp;";
		document.getElementById("sign_time").innerHTML = ""+"&nbsp;";
		document.getElementById("father_agent").innerHTML = ""+"&nbsp;";
		document.getElementById("limit_owe").innerHTML = ""+"&nbsp;";

		document.getElementById("agent_code").innerHTML = ""+"&nbsp;";
		document.getElementById("agent_type").innerHTML = ""+"&nbsp;";
		document.getElementById("describe").innerHTML =""+"&nbsp;";
		document.getElementById("entity_group_name").innerHTML =""+"&nbsp;";
		while(document.getElementById("table1").rows.length > 1){
			document.getElementById("table1").deleteRow(1);
		}
}



</script>
