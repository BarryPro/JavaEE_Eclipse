
<%
/**********************************
	liangyl@2016/4/29 10:48:10
***********************************/
%>
<!DOCtype html PUBLIC "-//W3C//Dtd Xhtml 1.0 Transitional//EN" 
	"http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ include file="/npage/properties/getRDMessage.jsp"%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="sLoginAccept" />
<%
String logacc = sLoginAccept;
String chnSrc = "01";
String opCode =request.getParameter("opCode");
String opName = request.getParameter("opName");
String workNo = (String)session.getAttribute("workNo");
String passwd = (String)session.getAttribute("password");
String regCode = (String)session.getAttribute("regCode");

String fieldPath = request.getRealPath("npage/properties") +"/fieldMsg.properties";
String fieldMsg = readValue(opCode , "d0" ,"f_msg",fieldPath);	
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=opName%></title>
<script language="javascript" type="text/javascript" src="/npage/public/zalidate.js"></script>
<script>
	var stepNum = 0;
	$( document ).ready(
		function ()
		{
			$( "#d0" ).show( 300 );
		}
	);
	function doRet()
	{
		document.frm.action = "#";
		document.frm.submit();	
	}
	function doCfm ()
	{
		document.frm.action = "fm373Cancel_cfm.jsp?logacc=<%=logacc%>"
			+"&chnSrc=<%=chnSrc%>"
			+"&opCode=<%=opCode%>"
			+"&workNo=<%=workNo%>"
			+"&passwd=<%=passwd%>"
			+"&phoNo="
			+"&usrPwd="
			+"&opName=<%=opName%>";	
		document.frm.submit();		
	}
</script>
</head>
<body>
<form name="frm" ACTION="" METHOD="POST" ENCtype="multipart/form-data">
	<%@ include file="/npage/include/header.jsp"%>
	<div id="Operation_Table">
		<div id="d0" name="d0" STYLE="display: none">
			<div class="title">
				<div id="title_zi"><%=opName%></div>
			</div>
			<table>
				<tr>
					<td width='100%' align='left' class='blue' colspan='2'>
						<font color='red'>&nbsp&nbsp&nbsp&nbsp˵��:</br>
							1����������,ÿ����Ϣռһ��,ÿ����Ϣ������������:����������.(���ӣ�12345678).</br>
							2���������,ÿ����Ϣռһ��,ÿ����Ϣ������������:����������,���ͬʱ����500��.(���ӣ�12345678).</br>
							3�� ȡ��������������Ч.</br>
							3����ȷ����ǰ����������m373�����������ڰ���Ȩ��. 
						</font>
					</td>
				</tr>
				<tr>
					<td width='50%' align='center'>
						�����ļ�:
					</td>
					<td width='50%'>
						<input type='file' id='f_ifo' name='f_ifo' ch_name='�ļ�' />
					</td>
				</tr>
				<tr>
					<td colspan='2' align='center' id='footer'>
						<input type='button' id='' name='' class='b_foot' value='ȷ��' onClick='doCfm()' />
						<input type='button' id='' name='' class='b_foot' value='����' onClick='doRet()' />
						<input type='button' id='' name='' class='b_foot' value='�ر�' onClick='removeCurrentTab();' />
					</td>
				</tr>
			</table>
		</div>
		<div id='queryDiv'></div>
		<input type='hidden' id='logacc' name='logacc' value='<%=logacc%>' />
		<input type='hidden' id='chnSrc' name='chnSrc' value='<%=chnSrc%>' />
		<input type='hidden' id='opCode' name='opCode' value='<%=opCode%>' />
		<input type='hidden' id='opName' name='opName' value='<%=opName%>' />
	</div>
	<%@ include file="/npage/include/footer_new.jsp"%>
</form>
</body>
</html>