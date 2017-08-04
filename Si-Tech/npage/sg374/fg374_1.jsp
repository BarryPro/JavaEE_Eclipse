<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 20121225
 ********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%
	String opCode = "g374";
	String opName = "农信通百事易功能受理";
	String workNo = (String)session.getAttribute("workNo");
    String workName = (String)session.getAttribute("workName");
    String regionCode=(String)session.getAttribute("regCode");
    String op_name =  "农信通百事易功能受理";
%>
   
<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD>
		<TITLE><%=op_name%></TITLE>
		<script language=javascript>
			function jsSelectIsExitItem(objSelect, objItemValue) {        
				var isExit = false;        
				for (var i = 0; i < objSelect.options.length; i++) {        
					if (objSelect.options[i].value == objItemValue) {        
						isExit = true;        
						break;        
					}        
				}        
				return isExit;        
			}
			function jsAddItemToSelect(objSelect, objItemText, objItemValue) {        
				//判断是否存在        
				if (!jsSelectIsExitItem(objSelect, objItemValue)) {        
					var varItem = new Option(objItemText, objItemValue);      
					objSelect.options.add(varItem);
				}        
			}
			function isNumberString (InString,RefString)
			{
				if(InString.length==0) return (false);
				for (Count=0; Count < InString.length; Count++)  {
				        TempChar= InString.substring (Count, Count+1);
				        if (RefString.indexOf (TempChar, 0)==-1)  
				        return (false);
				}
				return (true);
			}
			function addRow(col1,col2,col3,col4)
			{
				var inpList = document.getElementsByName("contactorInfoMsg_code");
				if(inpList.length>=6)
				{
					rdShowMessageDialog("受理表中最多只能有六条记录",0);
					return;
				}
				for (var i = 0, l = inpList.length; i < l; i++) {
					if(inpList[i].value == col1)
					{
						rdShowMessageDialog("代码["+col1+"]受理表中存在",0);
						return;
					}
				}
				if(col1 == "4510001"&&inpList.length>0)
				{
					rdShowMessageDialog("["+col1+"]业务，只能单独受理",0);
					return;
				}
				var trTemp = document.getElementById("contactorInfoMsg").children[0].insertRow();
				trTemp.insertCell().innerHTML = "<input type='text' name='contactorInfoMsg_code' size='20' readonly value='"+col1+"' />";
				trTemp.insertCell().innerHTML = "<input type='text' name='contactorInfoMsg_name' size='20' readonly value='"+col2+"' />";
				trTemp.insertCell().innerHTML = "<input type='text' name='contactorInfoMsg_type' size='20' readonly value='"+col3+"'  />";
				trTemp.insertCell().innerHTML = "<input type='text' name='contactorInfoMsg_oper' size='20' readonly value='"+col4+"'   />";
				trTemp.insertCell().innerHTML = "<input type='button' class='b_text' name='' id='' value='删除' onclick='deleteRow(\"contactorInfoMsg\", this)'/>";
				
			}
			function doProcess(packet)
			{
				//使用RPC的时候,以下三个变量作为标准使用.
				var error_code = packet.data.findValueByName("errorCode");
				var error_msg =  packet.data.findValueByName("errorMsg");
				var verifyType = packet.data.findValueByName("verifyType");
				self.status="";
				if(verifyType=="phoneno"){
					if( parseInt(error_code) == 0 ){
						var custname	=	packet.data.findValueByName("custname");
						var runcode		= 	packet.data.findValueByName("runcode");
						var basecode	=	packet.data.findValueByName("basecode");
						var ordernum	=	packet.data.findValueByName("ordernum");
						var conlist	=	packet.data.findValueByName("conlist");
						var flag	=	packet.data.findValueByName("flag");
						if(flag=="0")
						{
							if(basecode==0)
							{
								rdShowMessageDialog("没订购基础业务",0);
								return;
							}
							var backArrMsg1	=	packet.data.findValueByName("backArrMsg1");
							for(var i=0;i <backArrMsg1.length;i++)
							{
								var spid = backArrMsg1[i][0];
								var bizcode = backArrMsg1[i][1];
								var bizname = backArrMsg1[i][2];
								jsAddItemToSelect(document.all.value03,bizname,spid+"_"+bizcode);
								document.all.spid.value=backArrMsg1[0][0];
								document.all.bizcode.value=backArrMsg1[0][1];
							}
							document.all.checkbiz.disabled = false;
							document.all.value03.disabled = false;
							document.all.username.value=custname;
							document.all.runname.value=runcode;
							document.all.ordermax.value="3";
							document.all.style10.style.display="";
						}
						else
						{
							var backArrMsg	=	packet.data.findValueByName("backArrMsg");
							document.all.ordernum.value=ordernum;
							document.form1.next.disabled = false;
							document.all.userinfo.disabled = true;
							document.all.style02.style.display="";
							document.all.ordernum.conlist=conlist;
							var strs= new Array();
							strs=conlist.split(",");
							for(var i=0;i <strs.length;i++)
							{
								if(strs[i]=="01")
								{
									jsAddItemToSelect(document.all.value02,"综合","01");
								}
								else if(strs[i]=="02")
								{
									jsAddItemToSelect(document.all.value02,"频道","02");
								}
								else if(strs[i]=="03")
								{
									jsAddItemToSelect(document.all.value02,"栏目","03");
								}
							}
							for(var i=0;i <backArrMsg.length;i++)
							{
								var trTemp = document.getElementById("ViewMsg").children[0].insertRow();
								var typename = "";
								var opername = "";
								if(backArrMsg[i][2]=="01")
								{
									typename = "综合";
								}
								else if(backArrMsg[i][2]=="02")
								{
									typename = "频道";
								}
								else if(backArrMsg[i][2]=="03")
								{
									typename = "栏目";
								}
								else
								{
									typename = "未知";
								}
								trTemp.insertCell().innerHTML = "<input type='text' name='ViewMsg_code'  size='20' readonly value='"+backArrMsg[i][0]+"' />";
								trTemp.insertCell().innerHTML = "<input type='text' name='ViewMsg_name'  size='20' readonly value='"+backArrMsg[i][1]+"' />";
								trTemp.insertCell().innerHTML = "<input type='text' name='ViewMsg_type'  size='20' readonly value='"+typename+"'  />";
								trTemp.insertCell().innerHTML = "<input type='text' name='ViewMsg_time'  size='20' readonly value='"+backArrMsg[i][3]+"'  />";
								trTemp.insertCell().innerHTML = "<input type='text' name='ViewMsg_oper'  size='20' readonly value='订购'  />";
								if(backArrMsg[i][0] != "4510001")
									trTemp.insertCell().innerHTML = "<input type='button' class='b_text' name='' id='' value='退订' onclick='addRow(\""+backArrMsg[i][0]+"\",\""+backArrMsg[i][1]+"\",\""+typename+"\",\"退订\")'/>";
							}
						}
					}else{
						rdShowMessageDialog("<br>错误代码:["+error_code+"]</br>错误信息:["+error_msg+"]",0);
						return false;
					}
				}
				else if(verifyType=="ONE"){
					var myArrayId = packet.data.findValueByName("myArrayId");
					var myArrayName = packet.data.findValueByName("myArrayName");
					var length1 = packet.data.findValueByName("length1");
					length1++;
					document.all.value04.options.length=length1;
					document.all.value04.options[0].text="请选择二级栏目";
					document.all.value04.options[0].value="0";
					for(j=1;j<length1;j++)
					{
						document.all.value04.options[j].text=myArrayName[j-1];
						document.all.value04.options[j].value=myArrayId[j-1];
					}
					document.all.value04.options[0].selected=true;
					if(document.all.OneType.value == 0)
					{
						document.all.spCode.value = "";
						document.all.spCodeName.value = "";
					}
					else
					{
						document.all.spCode.value = document.all.OneType.value;
						document.all.spCodeName.value = document.all.OneType.options[document.all.OneType.selectedIndex].text;
					}
				}
				else if(verifyType=="TWO"){
					var myArrayId = packet.data.findValueByName("myArrayId");
					var myArrayName = packet.data.findValueByName("myArrayName");
					var length1 = packet.data.findValueByName("length1");
					length1++;
					document.all.value05.options.length=length1;
					document.all.value05.options[0].text="请选择三级栏目";
					document.all.value05.options[0].value="0";
					for(j=1;j<length1;j++)
					{
						document.all.value05.options[j].text=myArrayName[j-1];
						document.all.value05.options[j].value=myArrayId[j-1];
					}
					document.all.value05.options[0].selected=true;
					document.all.spCode.value = document.all.value04.value;
					document.all.spCodeName.value = document.all.value04.options[document.all.value04.selectedIndex].text;
				}
			}
			function getUserInfo()
			{
				if(document.form1.phoneNo.value.length<11 || isNumberString(document.form1.phoneNo.value,"1234567890")!=1) {
					rdShowMessageDialog("请输入手机号码,长度为11位数字!!");
					document.form1.phoneNo.focus();
					return false;
				}
				else if (parseInt(document.form1.phoneNo.value.substring(0,2),10)!=15 &&
				parseInt(document.form1.phoneNo.value.substring(0,2),10)!=18 &&
				parseInt(document.form1.phoneNo.value.substring(0,2),10)!=14 && 
				parseInt(document.form1.phoneNo.value.substring(0,2),10)!=17 && 
				(parseInt(document.form1.phoneNo.value.substring(0,3),10)<134 || 
				parseInt(document.form1.phoneNo.value.substring(0,3),10)>139)){
					rdShowMessageDialog("请输入134-139,或15,14,18,17开头的手机号码!!");
					document.form1.phoneNo.focus();
					return false;
				}
	  			var myPacket = new AJAXPacket("fg374_rpc_check.jsp","正在确认，请稍候......");
				myPacket.data.add("verifyType","phoneno");
				myPacket.data.add("flag","0");
				myPacket.data.add("spid","0");
				myPacket.data.add("bizcode","0");
				myPacket.data.add("phoneno",document.form1.phoneNo.value);  
	  			core.ajax.sendPacket(myPacket);
	 			myPacket=null;
			}
			function spQry()
			{
				var phoneno = document.form1.phoneNo.value;
				var spid = document.form1.spid.value;
				var bizcode = document.form1.bizcode.value;
				var path ="fg374_Qry.jsp?phoneno="+phoneno+"&spid="+spid+"&bizcode="+bizcode;
				window.open(path,"newwindow","height=450, width=790,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
			}
			function toChange(par1)
			{
				if(par1 =="ONE")
				{
					var par2 = document.all.OneType.value;
					var myPacket = new AJAXPacket("select_offer.jsp","正在确认，请稍候......");
					myPacket.data.add("verifyType",par1);
					myPacket.data.add("SQL","select contentcode,contentname from dbcustadm.ddsmpspbizconinfo where contentcode like '"+par2+"'||'__' and contenttype ='02' order by contentcode asc ");  
		  			core.ajax.sendPacket(myPacket);
		 			myPacket=null;
		 		}
		 		else if(par1 =="TWO")
		 		{
		 			var par2 = document.all.value04.value;
		 			var myPacket = new AJAXPacket("select_offer.jsp","正在确认，请稍候......");
					myPacket.data.add("verifyType",par1);
					myPacket.data.add("SQL","select contentcode,contentname from dbcustadm.ddsmpspbizconinfo where contentcode like '"+par2+"'||'__' and contenttype ='02' order by contentcode asc ");  
		  			core.ajax.sendPacket(myPacket);
		 			myPacket=null;
		 		}
		 		else if (par1 =="THREE")
		 		{
		 			document.all.spCode.value = document.all.value05.value;
		 			document.all.spCodeName.value = document.all.value05.options[document.all.value05.selectedIndex].text;
		 		}
			}
			function changeType()
			{
				var i = document.all.value02.value;
				if(i == "01")
				{
					document.all.spCode.value="4510001";
					document.all.spCodeName.value="综合";
					document.all.spQuery.disabled = true;
					document.all.spCfm.disabled = false;
					document.all.spCode.readonly = true;
					document.all.style03.style.display="none";
				}
				else if(i == "02")
				{
					document.all.spCode.value=""
					document.all.spCodeName.value=""
					document.all.spQuery.disabled = true;
					document.all.spCfm.disabled = false;
					document.all.style03.style.display="";
					document.all.OneType.options[0].selected=true;
					document.all.value04.options[0].selected=true;
					document.all.value05.options[0].selected=true;
					document.all.spQuery.disabled = true;
					document.all.spCode.readonly = true;
				}
				else if(i == "03")
				{
					document.all.spCode.value="";
					document.all.spCodeName.value=""
					document.all.spQuery.disabled = false;
					document.all.spCfm.disabled = false;
					document.all.style03.style.display="none";
				}
				else 
				{
					document.all.spCode.value="";
					document.all.spCodeName.value="";
					document.all.spQuery.disabled = true;
					document.all.spCfm.disabled = true;
					document.all.style03.style.display="none";
					document.all.OneType.options[0].selected=true;
					document.all.value04.options[0].selected=true;
					document.all.value05.options[0].selected=true;
				}
			}
			function deleteRow(msgId, obj) 
			{
				var tableTemp = document.getElementById(msgId).children[0];
				tableTemp.deleteRow(obj.parentElement.parentElement.rowIndex);
			}
			function docheck()
			{
				var codelist = ""
				var operlist = ""
				var typelist = ""
				var ViewMsg = document.getElementsByName("ViewMsg_code");
				for (var i = 0, l = ViewMsg.length; i < l; i++) {
					if(ViewMsg[i].value == "4510001")
					{
						if(rdShowConfirmDialog('订购当前业务，会退订4510001业务，确定么？')!=1)
							return;
					}
				}
				
				var contactorInfoMsg_code =document.getElementsByName("contactorInfoMsg_code");
				
				for (var i = 0, l = contactorInfoMsg_code.length; i < l; i++) {
					if(contactorInfoMsg_code[i].value == "4510001")
					{
						if(rdShowConfirmDialog('订购4510001业务，会退订其他所有业务，确定么？')!=1)
							return;
					}
					codelist = codelist + contactorInfoMsg_code[i].value +";"
				}
				
				var contactorInfoMsg_oper =document.getElementsByName("contactorInfoMsg_oper");
				for (var i = 0, l = contactorInfoMsg_oper.length; i < l; i++) {
					if(contactorInfoMsg_oper[i].value == "订购")
					{
						operlist = operlist +"01;"
					}
					else if(contactorInfoMsg_oper[i].value == "退订")
					{
						operlist = operlist +"02;"
					}
				}
				
				var contactorInfoMsg_type =document.getElementsByName("contactorInfoMsg_type");
				for (var i = 0, l = contactorInfoMsg_type.length; i < l; i++) {
					if(contactorInfoMsg_type[i].value == "综合")
					{
						typelist = typelist +"01;"
					}
					else if(contactorInfoMsg_type[i].value == "频道")
					{
						typelist = typelist +"02;"
					}
					else if(contactorInfoMsg_type[i].value == "栏目")
					{
						typelist = typelist +"03;"
					}
				}
				if(contactorInfoMsg_code.length==0)
				{
					rdShowMessageDialog("受理表为空！",0);
					return;
				}
				document.all.strcontent.value = codelist;
				document.all.strcontype.value = typelist;
				document.all.strcontopr.value = operlist;
				frmCfm();
			}
			function frmCfm()
			{
		        document.form1.action="fg374_Cfm.jsp";
		        form1.submit();
		        document.form1.next.disabled = true;
		        return true;
			}
			function dinggou()
			{
				var spCode = document.all.spCode.value;
				var spCodeName = document.all.spCodeName.value;
				var spCodeType = document.all.value02.options[document.all.value02.selectedIndex].text;
				if(spCode == "")
				{
					rdShowMessageDialog("订购内容为空",0);
					return;
				}
				var ViewMsg = document.getElementsByName("ViewMsg_code");
				for (var i = 0, l = ViewMsg.length; i < l; i++) {
					if(ViewMsg[i].value == spCode)
					{
						rdShowMessageDialog("代码["+spCode+"]已经订购",0);
						return;
					}
				}
				if(spCode != '4510001')
				{
				var count = 0;
				var ViewMsg_1 = document.getElementsByName("ViewMsg_oper");
				var ViewMsg_2 = document.getElementsByName("ViewMsg_code");
				for (var i = 0, l = ViewMsg_1.length; i < l; i++) {
					if(ViewMsg_2[i].value != "4510001")
					{
						count ++;
					}
				}
				var contactorInfoMsg = document.getElementsByName("contactorInfoMsg_oper");
				
					for (var i = 0, l = contactorInfoMsg.length; i < l; i++) {
					if(contactorInfoMsg[i].value == "订购")
					{
						count ++;
					}
					else
					{
						count --;
					}
					}
					if(count>=3)
					{
					rdShowMessageDialog("最多只能订购3条",0);
					return;
					}
				}
				addRow(spCode,spCodeName,spCodeType,"订购")
			}
			function changeBiz()
			{
				var spid = "";
				var bizcode = "";
				var currSelectValue = document.all.value03.value;
				var strs= new Array();
				strs=currSelectValue.split("_");
				spid = strs[0];
				bizcode = strs[1];
				document.all.spid.value=spid;
				document.all.bizcode.value=bizcode;
			}
			function checkone()
			{
				document.all.checkbiz.disabled = true;
				document.all.value03.disabled = true;
				if(document.form1.phoneNo.value.length<11 || isNumberString(document.form1.phoneNo.value,"1234567890")!=1) {
					rdShowMessageDialog("请输入手机号码,长度为11位数字!!");
					document.form1.phoneNo.focus();
					return false;
				}
				else if (parseInt(document.form1.phoneNo.value.substring(0,2),10)!=15 &&
				parseInt(document.form1.phoneNo.value.substring(0,2),10)!=18 &&
				parseInt(document.form1.phoneNo.value.substring(0,2),10)!=14 && 
				parseInt(document.form1.phoneNo.value.substring(0,2),10)!=17 && 
				(parseInt(document.form1.phoneNo.value.substring(0,3),10)<134 || 
				parseInt(document.form1.phoneNo.value.substring(0,3),10)>139)){
					rdShowMessageDialog("请输入134-139,或15,14,18,17开头的手机号码!!");
					document.form1.phoneNo.focus();
					return false;
				}
	  			var myPacket = new AJAXPacket("fg374_rpc_check.jsp","正在确认，请稍候......");
				myPacket.data.add("verifyType","phoneno");
				myPacket.data.add("flag","1");
				myPacket.data.add("spid",document.form1.spid.value);
				myPacket.data.add("bizcode",document.form1.bizcode.value);
				myPacket.data.add("phoneno",document.form1.phoneNo.value);  
	  			core.ajax.sendPacket(myPacket);
	 			myPacket=null;
			}
		</script>
	</HEAD>
	<BODY>
		<FORM action="fg374_Cfm.jsp" method=post name="form1" id="form1">
			<%@ include file="/npage/include/header.jsp"%>
        	<div class="title">
        		<div id="title_zi">农信通百事易功能受理</div>
    		</div>
    		<table cellSpacing="0">
				<tr> 
					<td class=blue>手机号码</td>
					<td>
						<input type="text" name="phoneNo" id="phoneNo" readonly value ="<%=activePhone%>" onchange="chgPhone()">
		                <input type="button" class="b_text" name="userinfo" value="验证" onclick="getUserInfo()">
					</td>
					<td class="blue"><div>用户姓名</div></td>
					<td>
						<input type="text"  class="InputGrey" readonly name="username" value="">
					</td>
				<tr> 
					<td class="blue"><div>运行状态</div></td>
					<td>
						<input type="text" class="InputGrey" readonly name="runname" value="">
					</td>
				</tr>
				<tr>
					<td class="blue"><div>订购最大条数</div></td>
					<td>
						<input type="text" class="InputGrey" readonly name="ordermax" value="">
					</td>
					<td class="blue"><div>当前条数</div></td>
					<td>
						<input type="text"  class="InputGrey" readonly name="ordernum" value="">
					</td>
				</tr>
			</table>
			
			<div class="title">
        		<div id="title_zi">基础业务列表</div>
    		</div>
			<table  id="style10" cellSpacing="0" style="display:none">
				<tr>
					<td class="blue"><div>企业代码</div></td>
					<td>
						<input type="text"  class="InputGrey" readonly name="spid" value="">
					</td>
					<td class="blue"><div>业务代码</div></td>
					<td>
						<input type="text"  class="InputGrey" readonly name="bizcode" value="">
					</td>
				</tr>
				<tr>
					<td class="blue"><div>基础业务名称</div></td>
					<td>
						<select name="value03" class="button" onChange="changeBiz()">
						</select>
						<input type="button" class="b_text" name="checkbiz" value="选择" onclick="checkone()">
					</td>
				</tr>
			</table>
			
			<div class="title">
        		<div id="title_zi">查询列表</div>
    		</div>
			<div id="ViewMsg">
	    		<table cellSpacing="0">
	    			<tr>
	    				<th width="30%">内容编码</th>
						<th width="30%">内容名称</th>
						<th width="10%">内容类型</th>
						<th width="10%">操作时间</th>
						<th width="10%">当前状态</th>
						<th width="10%">操作</th>
	    			</tr>
	    		</table>
    		</div>
    		<div class="title">
        		<div id="title_zi">订购</div>
    		</div>
			<table id="style02" cellSpacing="0" style="display:none">
                <tr> 
                  <td class=blue>编码类型</td>
                  <td colspan="5">
                    <select name="value02" class="button"  onChange="changeType()">
                        <option value="00" selected>请选择类型</option>
                    </select>
                  </td>
                </tr>
                <tr id="style03" style="display:none"> 
                  <td class=blue>一级栏目</td>
                  <td>
                  	<select name="OneType"  class="button"   onChange="toChange('ONE')">
                  	<option value="0">请选一级栏目</option>
	                  	<wtc:qoption  name="sPubSelect"  routerKey="region"  routerValue="<%=regionCode%>"  outnum="2">
						  <wtc:sql>
						          select contentcode,contentname from dbcustadm.ddsmpspbizconinfo where contentcode like '451000_' and contenttype ='02' order by contentcode asc
						  </wtc:sql>
						</wtc:qoption>
					</select>
                  </td>
                  <td class=blue>二级栏目</td>
                  <td> 
                    <select name="value04" class="button" style="width:270px" onChange="toChange('TWO')">
                    	 <option value="" selected>请选二级栏目</option>
                    </select>
                  </td>
                  <td class=blue>三级栏目</td>
                  <td> 
                    <select name="value05" class="button" style="width:270px" onChange="toChange('THREE')">
                        <option value="" selected>请选三级栏目</option>
                    </select>
                  </td>
                </tr>
                <tr id="style05"> 
					<td class=blue>套餐编码</td>
					<td  id="spinfo1">
						<input type="text" name="spCode" value="" maxlength="6">
						<input type="button" class="b_text" name="spQuery" value="查询" disabled onclick="spQry()">
					</td>
					<td class=blue>套餐名称</td>
					<td id="spinfo1">
						<input type="text" name="spCodeName" style="width:270px" value="" maxlength="80">
					</td>
					<td class=blue>操作</td>
					<td  id="spinfo1">
						<input type="button" class="b_text" name="spCfm" value="订购" disabled onclick="dinggou()">
					</td>
                </tr>
			</table>
			<div class="title">
        		<div id="title_zi">受理列表</div>
    		</div>
    		<div id="contactorInfoMsg">
	    		<table cellSpacing="0">
	    			<tr>
	    				<th width="25%">内容编码</th>
						<th width="25%">内容名称</th>
						<th width="25%">内容类型</th>
						<th width="10%">操作</th>
						<th width="10%"></th>
	    			</tr>
	    		</table>
    		</div>
			<table cellspacing="0">
				<tr>
					<td noWrap id="footer">
					<div align="center">
						<input type="button" name="next" class="b_foot" value="受理" onclick="docheck()" disabled />
						&nbsp;
						<input type="button" name="query" class="b_foot" value="清除" onclick="location.reload();" />
						&nbsp;
						<input type="button" name="close" class="b_foot" value="关闭" onClick="removeCurrentTab();">
					</div>
					</td>
				</tr>
			</table>
			<input type="hidden" class="button" name="strcontent" value="">
            <input type="hidden" class="button" name="strcontype" value="">
            <input type="hidden" class="button" name="strcontopr" value="">
			<input type="hidden" class="button" name="conlist" value="">
			<%@include  file="/npage/include/footer.jsp"%>
		</FORM>
	</BODY>
</HTML>
