<%
/*
 * ����: ��ͯ�ײ�
 * �汾: 1.0
 * ����: 2012/6/28 11:19:29
 * ����: zhangyan
 * ��Ȩ: si-tech
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

/*����У���ֻ�������*/
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
						<th align="center">��ͯ�û�����:</th>
						<td>
							<input type="text" id="cldPhoneNo" name="cldPhoneNo" 
								v_must="1"  v_type="phone" value='<%=cldPhoneNo%>' class='InputGrey'/>	
							<font color="red">*</font>
						</td>			
						<th align="center">��ͯ�û���������:</th>
						<td>
							<input type="password" id="cldPwd" name="cldPwd"/>
						</td>
					</tr>			
				</table>

				<table>
					<tr> 
						<td  id="footer">
							<input class="b_foot" type="button" name=nextBtn value="��һ��"
								onClick="nextStep();">
							<input class="b_foot" type="button" name=rstBtn value="����"
								onClick="doRst();">
							<input class="b_foot" type="button" name=clsBtn value="�ر�"
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
		
		/*У���û�����*/
		function checkUserPwd(phoneNo,custPwd)
		{
			var checkPwd_Packet = new AJAXPacket("/npage/public/pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
			checkPwd_Packet.data.add("custType", "01");						//01:�ֻ����� 02 �ͻ�����У�� 03�ʻ�����У��
			checkPwd_Packet.data.add("phoneNo", phoneNo);		//�ƶ�����,�ͻ�id,�ʻ�id
			checkPwd_Packet.data.add("custPaswd", custPwd);//�û�/�ͻ�/�ʻ�����
			checkPwd_Packet.data.add("idType", "");							//en ����Ϊ���ģ�������� ����Ϊ����
			checkPwd_Packet.data.add("idNum", "");							//����
			checkPwd_Packet.data.add("loginNo", "<%=workNo%>");				//����
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
		
		/*����*/	
		function doRst()
		{
			hiddenTip(document.frm);
			document.all.cldPhoneNo.value="";
			document.all.cldPwd.value="";
		}
		

		
		/*����������*/
		function nextStep()
		{
			
			if ( !(checkElement( document.frm.cldPhoneNo )) )
			{
				return false;
			}		
			
			if("false" == "<%=pwrf%>")
			{
				/*������*/
				if(document.frm.cldPwd.value.trim() == "")
				{
					rdShowMessageDialog("��ͯ�û����������������",0);
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
