
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
						<font color='red'>&nbsp&nbsp&nbsp&nbsp说明:</br>
							1、单个申请,每条信息占一行,每条信息包含以下内容:物联网号码.(例子：12345678).</br>
							2、多个申请,每条信息占一行,每条信息包含以下内容:物联网号码,最多同时导入500条.(例子：12345678).</br>
							3、 取消休眠期立即生效.</br>
							3、请确保当前操作工号有m373物联网休眠期办理权限. 
						</font>
					</td>
				</tr>
				<tr>
					<td width='50%' align='center'>
						批量文件:
					</td>
					<td width='50%'>
						<input type='file' id='f_ifo' name='f_ifo' ch_name='文件' />
					</td>
				</tr>
				<tr>
					<td colspan='2' align='center' id='footer'>
						<input type='button' id='' name='' class='b_foot' value='确认' onClick='doCfm()' />
						<input type='button' id='' name='' class='b_foot' value='重置' onClick='doRet()' />
						<input type='button' id='' name='' class='b_foot' value='关闭' onClick='removeCurrentTab();' />
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