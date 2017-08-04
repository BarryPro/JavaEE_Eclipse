<%
/*
 * 功能: 儿童套餐
 * 版本: 1.0
 * 日期: 2012/6/28 11:19:29
 * 作者: zhangyan
 * 版权: si-tech
 * update:
*/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
String opCode=request.getParameter("opCode");
String opName=request.getParameter("opName");
String workNo = (String)session.getAttribute("workNo");
String cldPhoneNo=request.getParameter("activePhone");

/*用于校验手机号密码*/
boolean pwrf=false;
String pubOpCode = opCode;
String pubWorkNo = (String)session.getAttribute("workNo");

%>
<%@ include file="/npage/public/pubCheckPwdPower.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml"> 
	<head>
		<title><%=opCode%></title>
	</head>
	<body onload="cldInit()">
		<form  name="frm" action="" method="POST" >
			<input type="hidden" id="opCode" name	="opCode"	value= "<%=opCode%>">
			<input type="hidden" id="opName" name	="opName"	value= "<%=opName%>">
			<%@ include file="/npage/include/header.jsp" %>

			<DIV id="Operation_Table">

				<div class="title">
					<div id="title_zi"><%=opName%></div>
				</div>
				<table>
					<tr>
						<th align="center">儿童用户号码:</th>
						<td>
							<input type="text" id="cldPhoneNo" name="cldPhoneNo" 
								v_must="1"  v_type="phone" value='<%=cldPhoneNo%>' class='InputGrey'/>	
							<font color="red">*</font>
						</td>			
						<th align="center">儿童用户号码密码:</th>
						<td>
							<input type="password" id="cldPwd" name="cldPwd"/>
						</td>
					</tr>			
				</table>

				<table>
					<tr> 
						<td  id="footer">
							<input class="b_foot" type="button" name=nextBtn value="下一步"
								onClick="nextStep();">
							<input class="b_foot" type="button" name=rstBtn value="重置"
								onClick="doRst();">
							<input class="b_foot" type="button" name=clsBtn value="关闭"
								onClick="removeCurrentTab();">								
						</td>
					</tr>
				</table>	
			</div>
		</form>
	</body>
	<script type="text/javascript">
		var pwdIsRight="0";
		function cldInit()
		{
			if("true" == "<%=pwrf%>")
			{
				document.frm.cldPwd.disabled=true;
			}				
		}
		
		/*校验用户密码*/
		function checkUserPwd(phoneNo,custPwd)
		{
			var checkPwd_Packet = new AJAXPacket("/npage/public/pubCheckPwd.jsp","正在进行密码校验，请稍候......");
			checkPwd_Packet.data.add("custType", "01");						//01:手机号码 02 客户密码校验 03帐户密码校验
			checkPwd_Packet.data.add("phoneNo", phoneNo);		//移动号码,客户id,帐户id
			checkPwd_Packet.data.add("custPaswd", custPwd);//用户/客户/帐户密码
			checkPwd_Packet.data.add("idType", "");							//en 密码为密文，其它情况 密码为明文
			checkPwd_Packet.data.add("idNum", "");							//传空
			checkPwd_Packet.data.add("loginNo", "<%=workNo%>");				//工号
			core.ajax.sendPacket(checkPwd_Packet, doCheckPwd);
			checkPwd_Packet=null;
		}
		
		function doCheckPwd(packet) 
		{
			var retResult = packet.data.findValueByName("retResult");
			var msg = packet.data.findValueByName("msg");

			if (retResult != "000000") 
			{
				pwdIsRight = "0";
				rdShowMessageDialog(msg);
				return false;
			}
			else
			{
				pwdIsRight = "1";
			}
		}		
		
		/*重置*/	
		function doRst()
		{
			hiddenTip(document.frm);
			document.all.cldPhoneNo.value="";
			document.all.cldPwd.value="";
		}
		

		
		/*进入办理界面*/
		function nextStep()
		{
			
			if ( !(checkElement( document.frm.cldPhoneNo )) )
			{
				return false;
			}		
			
			if("false" == "<%=pwrf%>")
			{
				/*非免密*/
				if(document.frm.cldPwd.value.trim() == "")
				{
					rdShowMessageDialog("儿童用户号码密码必须输入",0);
					return false;
				}
				checkUserPwd(document.frm.cldPhoneNo.value,document.frm.cldPwd.value );
			}	

			var opCode=document.all.opCode.value;
			var opName=document.all.opName.value;

			if(pwdIsRight == "1" ||"true" == "<%=pwrf%>"){
				document.frm.action="fE889Open.jsp?opCode="+opCode+"&opName="+opName;
				document.frm.submit();
			}
		}

	</script>
</html>
