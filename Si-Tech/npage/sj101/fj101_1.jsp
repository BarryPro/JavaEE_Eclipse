<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by wangwg @ 20150511
 ********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%
	String opCode = "J101";
	String opName = "亲情圈成员业务受理";
	String workNo = (String)session.getAttribute("workNo");
    String workName = (String)session.getAttribute("workName");
    String regionCode=(String)session.getAttribute("regCode");
    String op_name =  "亲情圈成员业务受理";
%>

<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD>
		<TITLE><%=op_name%></TITLE>
		<script language=javascript>
			function doProcess(packet)
			{
				var error_code = packet.data.findValueByName("errorCode");
				var error_msg =  packet.data.findValueByName("errorMsg");
				var verifyType = packet.data.findValueByName("verifyType");
				if(verifyType=="phoneno")
				{
					if( parseInt(error_code) == 0 ){
						var custname	=	packet.data.findValueByName("custname");
						var runcode		= 	packet.data.findValueByName("runcode");
						var ordernum	=	packet.data.findValueByName("ordernum");
						var qqqstatus	=	packet.data.findValueByName("qqqstatus");
						document.all.username.value=custname;
						document.all.runname.value=runcode;
						if(parseInt(qqqstatus) == 0)
						{
							document.all.qqqstatus.value="无亲情圈";
							document.form1.button1.disabled=true;
							document.form1.button2.disabled=false;
							document.form1.button3.disabled=true;
						}
						else
						{
							document.all.qqqstatus.value="有亲情圈";
							document.form1.button1.disabled=false;
							document.form1.button2.disabled=true;
							document.form1.button3.disabled=false;
						}
						document.form1.phoneNo.disabled=true;
						var als = document.getElementById("ViewMsg").children[0];
						
						if(als.firstChild!=null)
							als.removeChild(als.firstChild);
						var backArrMsg  =       packet.data.findValueByName("backArrMsg");
						for(var i=0;i <backArrMsg.length;i++)
						{
							var trTemp = document.getElementById("ViewMsg").children[0].insertRow();
							trTemp.insertCell().innerHTML = "<input type='text' id='ViewMsg_code' name='ViewMsg_code_'+i class='InputGrey' size='20' readonly value='"+backArrMsg[i][0]+"' />";
							trTemp.insertCell().innerHTML = "<input type='text' name='ViewMsg_name' class='InputGrey' size='20' readonly value='"+backArrMsg[i][1]+"' />";
							trTemp.insertCell().innerHTML = "<input type='text' name='ViewMsg_time_'+i class='InputGrey' size='20' readonly value='"+backArrMsg[i][2]+"' />";
							trTemp.insertCell().innerHTML = "<input type='button' class='b_text' name='' id='' value='修改' onclick='update(\""+backArrMsg[i][0]+"\",\""+backArrMsg[i][1]+"\")'/>";	
							trTemp.insertCell().innerHTML = "<input type='button' class='b_text' name='' id='' value='退出' onclick='addRow(\""+backArrMsg[i][0]+"\",\""+backArrMsg[i][1]+"\",\"02\",\"退出\")'/>";

						}
					}
					else
					{
						rdShowMessageDialog("<br>错误代码:["+error_code+"]</br>错误信息:["+error_msg+"]",0);
					}
				}
				else if(verifyType=="QQQ")
				{
					if ( parseInt(error_code) == 0 ){
						rdShowMessageDialog("业务受理成功",2);
					}
					else
					{
						rdShowMessageDialog("<br>错误代码:["+error_code+"]</br>错误信息:["+error_msg+"]",0);
					}
					reset1();
				}
				else if(verifyType=="MIDQQQ")
				{
					if ( parseInt(error_code) == 0 ){
                                                rdShowMessageDialog("业务受理成功",2);
						reset1();
                                        }
                                        else
                                        {
                                                rdShowMessageDialog("<br>错误代码:["+error_code+"]</br>错误信息:["+error_msg+"]",0);
                                        }
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
				var myPacket = new AJAXPacket("fj101_Qry.jsp","正在确认，请稍候......");
				myPacket.data.add("verifyType","phoneno");
				myPacket.data.add("phoneno",document.form1.phoneNo.value);  
	  			core.ajax.sendPacket(myPacket);
	 			myPacket=null;
			}
			
			function CreateDropQQQ(oprcode)
			{
				if(document.form1.phoneNo.value.length<11 || isNumberString(document.form1.phoneNo.value,"1234567890")!=1) {
                                        rdShowMessageDialog("请输入手机号码,长度为11位数字!!");
                                        document.form1.phoneNo.focus();
                                        return false;
                                }
				var myPacket = new AJAXPacket("fj101_QQQ.jsp","正在确认，请稍候......");
				myPacket.data.add("verifyType","QQQ");
				myPacket.data.add("phoneno",document.form1.phoneNo.value);
				myPacket.data.add("oprcode",oprcode);
                                core.ajax.sendPacket(myPacket);
                                myPacket=null;
			}

			function midchange()
			{
				document.all.MemDiv.style.display="";
				document.all.COMMAND1.style.display="none";
				document.all.COMMAND2.style.display="";
			}

			function update(col1,col2)
			{
				document.form1.MumPhoneNo.disabled=true;
                                document.all.MumPhoneNo.value=col1;
                                document.all.MumName.value=col2;
				document.all.MumOprAdd.value="修改";
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
				var trTemp = document.getElementById("ViewMsg2").children[0].insertRow();
				trTemp.insertCell().innerHTML = "<input type='text' name='contactorInfoMsg_code' size='20' class='InputGrey' readonly value='"+col1+"' />";
				trTemp.insertCell().innerHTML = "<input type='text' name='contactorInfoMsg_name' size='20' class='InputGrey' readonly value='"+col2+"' />";
                                trTemp.insertCell().innerHTML = "<input type='text' name='contactorInfoMsg_oper' size='20' class='InputGrey' readonly value='"+col4+"'   />";
				trTemp.insertCell().innerHTML = "<input type='button' class='b_text' name='' id='' value='删除' onclick='deleteRow(\"ViewMsg2\", this)'/>";
			}
			function deleteRow(msgId, obj)
                        {
                                var tableTemp = document.getElementById(msgId).children[0];
                                tableTemp.deleteRow(obj.parentElement.parentElement.rowIndex);
                        }

			function MumAdd()
			{
				var MumPhoneNo = document.all.MumPhoneNo.value;
				var phoneNo = document.form1.phoneNo.value; 
                                var MumName = document.all.MumName.value;
				
                                if(MumPhoneNo<11 || isNumberString(MumPhoneNo,"1234567890")!=1) {
                                        rdShowMessageDialog("请输入手机号码,长度为11位数字!!");
                                        return false;
                                }
				if(MumPhoneNo==phoneNo)
				{
					rdShowMessageDialog("请输入手机号码,长度为11位数字!!");
                                        return false;
				}
				var ViewMsg = document.getElementsByName("ViewMsg2");
				for (var i = 0, l = ViewMsg.length; i < l; i++) {
                                        if(ViewMsg[i].value == MumPhoneNo)
                                        {
                                                rdShowMessageDialog("代码["+spCode+"]已经订购",0);
                                                return;
                                        }
                                }
				if(document.all.MumOprAdd.value=="修改")
				{
					addRow(MumPhoneNo,MumName,"03","修改");
				}
				else
				{
					addRow(MumPhoneNo,MumName,"01","添加");
				}
				MumAddrest();
			}
			function docheck()
			{
				var codelist = "";
				var namelist = "";
                                var operlist = "";
				var rolelist = "";
				var count=0;
				var contactorInfoMsg_code =document.getElementsByName("contactorInfoMsg_code");
				var ViewMsg_name = document.getElementsByName("ViewMsg_name");
				count= ViewMsg_name.length;
				for (var i = 0, l = contactorInfoMsg_code.length; i < l; i++) {
					codelist = codelist + contactorInfoMsg_code[i].value +";";
					rolelist = rolelist +"0;";
				}
				var contactorInfoMsg_oper =document.getElementsByName("contactorInfoMsg_oper");
				for (var i = 0, l = contactorInfoMsg_oper.length; i < l; i++) {
                                        if(contactorInfoMsg_oper[i].value == "添加")
                                        {
                                                operlist = operlist +"01;"
						count = count +1;
                                        }
                                        else if(contactorInfoMsg_oper[i].value == "退出")
                                        {
                                                operlist = operlist +"02;"
						count = count -1;
                                        }
					else if(contactorInfoMsg_oper[i].value == "修改")
                                        {
                                                operlist = operlist +"03;"
                                        }
                                }
				var contactorInfoMsg_name =document.getElementsByName("contactorInfoMsg_name");
				for (var i = 0, l = contactorInfoMsg_name.length; i < l; i++) {
					if(contactorInfoMsg_name[i].value=="")
						contactorInfoMsg_name[i].value="NULL";
                                        namelist = namelist + contactorInfoMsg_name[i].value +";"
                                }
				if(count>5)
				{
					rdShowMessageDialog("每个亲情圈最多5个成员",0);
					return;
				}
				if(contactorInfoMsg_code.length==0)
                                {
                                        rdShowMessageDialog("受理表为空！",0);
                                        return;
                                }
				document.all.strcontcode.value = codelist;
                                document.all.strcontname.value = namelist;
                                document.all.strcontrole.value = rolelist;
                                document.all.strcontopr.value = operlist;
				var myPacket = new AJAXPacket("fj101_MidCfm.jsp","正在确认，请稍候......");
				myPacket.data.add("verifyType","MIDQQQ");
				myPacket.data.add("phoneno",document.form1.phoneNo.value);
				myPacket.data.add("codelist",document.all.strcontcode.value);
				myPacket.data.add("namelist",document.all.strcontname.value);
				myPacket.data.add("rolelist",document.all.strcontrole.value);
				myPacket.data.add("operlist",document.all.strcontopr.value);
				core.ajax.sendPacket(myPacket);
				myPacket=null;
			}
			function MumAddrest()
			{
				document.form1.MumPhoneNo.disabled=false;
				document.form1.MumName.disabled=false;
				document.all.MumPhoneNo.value="";
				document.all.MumName.value="";
				document.all.MumOprAdd.value="添加";
			}
			
			function reset1()
			{
				location.reload();
			}
		</script>
	</HEAD>
	<BODY>
		<FORM action="fj101_Cfm.jsp" method=post name="form1" id="form1">
			<%@ include file="/npage/include/header.jsp"%>
        	<div class="title">
        		<div id="title_zi">亲情圈成员业务受理</div>
    		</div>
			<table cellSpacing="0">
				<tr> 
					<td class=blue>户主手机号码</td>
					<td>
						<input type="text" name="phoneNo" id="phoneNo" value ="" >
		                <input type="button" class="b_text" name="userinfo" value="验证" onclick="getUserInfo()">
					</td>
					<td class="blue"><div>户主姓名</div></td>
					<td>
						<input type="text"  class="InputGrey" readonly name="username" value="">
					</td>
				<tr>
				<tr> 
					<td class="blue"><div>运行状态</div></td>
					<td>
						<input type="text" class="InputGrey" readonly name="runname" value="">
					</td>
					<td class="blue"><div>亲情圈状态</div></td>
					<td>
                                                <input type="text" class="InputGrey" readonly name="qqqstatus" value="">
                                        </td>
				</tr>
			</table>
			<div id="MemDiv" style="display:none">
			<div class="title"><div id="title_zi">成员列表</div> </div>
			<div id="ViewMsg">
	    		<table cellSpacing="0">
	    			<tr>
	    				<th width="30%">成员手机号码</th>
					<th width="30%">成员称呼</th>
					<th width="30%">成员加入时间</th>
					<th width="5%">修改</th>
					<th width="5%">删除</th>
	    			</tr>
	    		</table>
    			</div>
			<div class="title"><div id="title_zi">成员操作</div></div>
			<div id="ViewMsg1">
	    		<table cellSpacing="0">
				<td class="blue"><div>成员手机号</div></td>
				<td><input type="text"  name="MumPhoneNo" id="MumPhoneNo" value=""></td>
				<td class="blue"><div>成员名称</div></td>
				<td><input type="text"  name="MumName" id="MumName" value=""></td>
				<td><input type="button" class="b_text" id="MumOprAdd" name="MumOprAdd" value="添加" onclick="MumAdd()">
				<input type="button" class="b_text"id="MumOprrest" name="MumOprrest" value="清除" onclick="MumAddrest()"></td>
			</table>
			</div>
			<div class="title"><div id="title_zi">受理列表</div></div>
			<div id="ViewMsg2">
	    		<table cellSpacing="0">
	    			<tr>
	    				<th width="30%">成员手机号码</th>
					<th width="30%">成员称呼</th>
					<th width="30%">操作说明</th>
					<th width="10%"></th>
				</tr>
			</table>
			</div>
			</div>
			<div id="COMMAND1">
			<table>
				<tr>
					<td colspan="4" id="footer">
						<div align="center">
							<input class="b_foot" type=button name=button1 value="成员操作"  onClick="midchange()" disabled>
							<input class="b_foot" type=button name=button2 value="建立亲情圈"  onClick="CreateDropQQQ('01')" disabled>
							<input class="b_foot" type=button name=button3 value="删除亲情圈"  onClick="CreateDropQQQ('02')" disabled>
							<input class="b_foot" name=clear type="reset" value="清除" onClick="reset1()" />
							<input class="b_foot" type=button name=button4 value="关闭" onClick="removeCurrentTab()">
						</div>
					</td>
				</tr>
			</table>
			</div>
			<div id="COMMAND2" style="display:none">
			<table>
				<tr>
					<td colspan="4" id="footer">
						<div align="center">
							<input class="b_foot" type=button name=button5 value="业务受理"  onClick="docheck()">
							<input class="b_foot" name=button6 type="reset" value="清除" onClick="reset1()" />
							<input class="b_foot" type=button name=button7 value="关闭" onClick="removeCurrentTab()">
						</div>
					</td>
				</tr>
			</table>	
			</div>
			<input type="hidden" class="button" name="hqqqstatus" value="">
			<input type="hidden" class="button" name="strcontcode" value="">
            		<input type="hidden" class="button" name="strcontname" value="">
            		<input type="hidden" class="button" name="strcontopr" value="">
            		<input type="hidden" class="button" name="strcontrole" value="">
		</FORM>
	</BODY>
</HTML>
