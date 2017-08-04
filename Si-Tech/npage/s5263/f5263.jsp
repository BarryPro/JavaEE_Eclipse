 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-02-07 页面改造,修改样式
	********************/
%>  

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%	
	
//---------------------------------java代码区------------------------------------
	String opCode = "5263";	
	String opName = "代理商基本资料查询";	//header.jsp需要的参数   
			
	//进行工号权限检验

%>

<html>
	<head>
		<title>代理商基本资料查询</title>
		<%//-----------------------------------js区域-------------------------------------%>		
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
			
		
		//-------------------------------------处理RPC------------------------------------
			
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
				entryType = '是';
				if(entity_group_name == '')
				{
				    entryType = '否';
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
					rdShowMessageDialog("错误代码："+errCode+"<br>错误信息："+errMsg);
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
				var myPacket = new AJAXPacket("f5263_RPC.jsp","正在提交，请稍候......");
				myPacket.data.add("agentPhone",agentPhone);
				core.ajax.sendPacket(myPacket);
				myPacket=null;
			}
		
			//--------------------------------提交表单------------------------------------
			function commit(){
				form1.action="";
				form1.submit();
				return true;
			}
			
			//---------------------------------清空表单---------------------------------------
			function resetJSP(){
				for(i=0;i<document.form1.elements.length;i++){
					if (document.form1.elements[i].type=="text"){
						document.form1.elements[i].value = "";
					}
				}
			}
		</script>
</head>
	<%//--------------------------------------页面区域--------------------------------------------%>
	<body>
		<form name="form1" method="post">
			<%@ include file="/npage/include/header.jsp" %>     	
			<div class="title">
				<div id="title_zi">代理商基本资料查询</div>
			</div>
		        <table  cellspacing="0">
		          	<tr> 
		            		<td width="18%" class="blue" class="blue">代理商手机号</td>
			            	<td width="32%"> 
			              		<input name="agentPhone" type="text"  id="agentPhone" maxlength="11">
						<input name="findagent1" type="button" class="b_text" value="查询" onClick="findagent()">            </td>
			            		<td width="18%" >&nbsp;</td>
		            	    		<td width="32%" >&nbsp;</td>
		          	</tr>		
			          <tr> 
				            <td class="blue">网点名称</td>
				            <td id="agent_name">&nbsp;</td>
				            <td class="blue">网点地址</td>
			            	    <td id="agent_address">&nbsp;</td>
			          </tr>		
				          <tr> 
					            <td class="blue" class="blue">法人代表姓名</td>
					            <td id="legal_present">&nbsp;</td>
					            <td class="blue">法人代表身份证号</td>
					            <td id="legal_id">&nbsp;</td>
				          </tr>
		
				 	  <tr> 
					            <td  class="blue">邮编</td>
					            <td id="account_no">&nbsp;</td>
					            <td  class="blue">联系电话</td>
					            <td id="agent_phone">&nbsp;</td>
		          		 </tr>
		
				          <tr> 
					            <td class="blue">注册资金</td>
					            <td id="register_money">&nbsp;</td>
					            <td class="blue">联系人姓名</td>
					            <td id="contact_person">&nbsp;</td>
				          </tr>
		
					  <tr> 
					            <td  class="blue">联系人身份证号</td>
					            <td id="contact_id">&nbsp;</td>
					            <td  class="blue">联系人电话</td>
					            <td id="contact_phone">&nbsp;</td>
				          </tr>		
					  <tr>
					            <td class="blue">开户银行</td>
					            <td id="bank_name">&nbsp;</td>
					            <td  class="blue">银行帐号</td>
					            <td id="bank_code">&nbsp;</td>
				          </tr>
		
				          <tr> 
					            <td class="blue">押金金额</td>
					            <td id="deposit">&nbsp;</td>
					            <td class="blue">营业面积</td>
					            <td id="agent_size">&nbsp;&nbsp;</td>
				          </tr>		
					   <tr> 
					            <td  class="blue">营业人员数</td>
					            <td id="person_count">&nbsp;</td>
					            <td  class="blue">营销人员数</td>
					            <td id="person_count1">&nbsp;</td>
				          </tr>
		
				          <tr> 
					            <td class="blue">牌匾尺寸</td>
					            <td id="pb_size">&nbsp;</td>
					            <td class="blue">签约时间</td>
					            <td id="sign_time">&nbsp;</td>
				          </tr>
		
					  <tr> 
					            <td  class="blue">房屋产权</td>
					            <td id="father_agent">&nbsp;</td>
					            <td class="blue">房屋租赁费用</td>
					            <td id="limit_owe">&nbsp;</td>
				          </tr>
		
				          <tr> 
					            <td class="blue">空中充值账号</td>
					            <td id="agent_code">&nbsp;</td>
					            <td class="blue">当前状态</td>
					            <td id="agent_type">&nbsp;</td>
				          </tr>
				          <tr> 
				            <td class="blue">网点是否为公司现有其他实体渠道</td>
				            <td colspan="3" id="entryType" readonly class="InputGrey">&nbsp;</td>
				          </tr>
							    <tr> 
				            <td class="blue">具体对应网点</td>
				            <td colspan="3" id="entity_group_name" readonly class="InputGrey">&nbsp;</td>
				          </tr>		
					        <tr> 
				            <td class="blue">备注</td>
				            <td colspan="3" id="describe" readonly class="InputGrey">&nbsp;</td>
				          </tr>		
				</table>
				<br>
				<div class="title">
					<div id="title_zi">状态变化纪录</div>
				</div>			
				<table  id="table1"  cellspacing="0">
					<TR>
						<th>&nbsp;&nbsp;工号</th>
						<th>&nbsp;&nbsp;修改时间</th>
						<th>&nbsp;&nbsp;修改前状态</th>
						<th>&nbsp;&nbsp;修改后状态</th>
					</TR>
				</table>		   
		        	<table cellspacing="0">
				    	<tr >
				    		<td id="footer"> 				    			 
					                <input name="reset" type="button" class="b_foot"  value="打印" onClick="printJSP()">
					                &nbsp; 
					                <input name="reset" type="button" class="b_foot"  value="清除" onClick="resetJSP()">
					                &nbsp; 
					                <input name="back" onClick="removeCurrentTab()" class="b_foot" type="button"  value="关闭" >
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
     		 rdShowMessageDialog("代理商信息不正确，不能打印！");
      		 return false;
	}
   	printctrl.Setup(0) ;
	printctrl.StartPrint();
	printctrl.PageStart();

	printctrl.Print(10,5,9,0,"代理商手机号："+document.form1.agentPhone.value);  
	
	printctrl.Print(10,6,9,0,"网点名称：    "+agent_name);  
	printctrl.Print(50,6,9,0,"网点地址：    "+agent_address);  

	printctrl.Print(10,7,9,0,"法人代表姓名："+legal_present);  
	printctrl.Print(50,7,9,0,"法人代表身份证号："+legal_id);  

	printctrl.Print(10,8,9,0,"邮编：        "+account_no);  
	printctrl.Print(50,8,9,0,"联系电话：    "+agent_phone);  

	printctrl.Print(10,9,9,0,"注册资金：    "+register_money);  
	printctrl.Print(50,9,9,0,"联系人姓名：  "+contact_person);  

	printctrl.Print(10,10,9,0,"联系人身份证号："+contact_id);  
	printctrl.Print(50,10,9,0,"联系人电话： "+contact_phone);  

	printctrl.Print(10,11,9,0,"开户银行：   "+bank_name);  
	printctrl.Print(50,11,9,0,"银行帐号：   "+bank_code);  

	printctrl.Print(10,12,9,0,"押金金额：   "+deposit);  
	printctrl.Print(50,12,9,0,"营业面积：   "+agent_size);  

	printctrl.Print(10,13,9,0,"营业人员数： "+person_count);  
	printctrl.Print(50,13,9,0,"营销人员数： "+person_count1);  

	printctrl.Print(10,14,9,0,"牌匾尺寸：   "+pb_size);  
	printctrl.Print(50,14,9,0,"签约时间：   "+sign_time);  

	printctrl.Print(10,15,9,0,"房屋产权：   "+father_agent);  
	printctrl.Print(50,15,9,0,"房屋租赁费用："+limit_owe);  

	printctrl.Print(10,16,9,0,"空中充值账号："+agent_code);  
	printctrl.Print(50,16,9,0,"当前状态：    "+agent_type);  

  printctrl.Print(10,17,9,0,"网点是否为公司现有其他实体渠道："+entryType);
	printctrl.Print(10,18,9,0,"具体对应网点："+entity_group_name);
	printctrl.Print(10,19,9,0,"备注：        "+describe);  

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
