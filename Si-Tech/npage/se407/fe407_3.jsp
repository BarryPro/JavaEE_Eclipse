<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����: ������Ϣ�ٱ���ѯ
   * �汾: 1.0
   * ����: 2011-11-8 8:15:06
   * ����: zhangyan
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
String work_no =(String)session.getAttribute("workNo");//����
String opCode="e407";
String opName="��վԤԼ��Ϣ��ѯ";
String region_code = (String)session.getAttribute("regCode");
String bookingId = request.getParameter("bookingId");

String iLoginAccept=	"";
String iChnSource=		"";
String iOpCode=        	request.getParameter("bookingOpCode");
String iLoginNo=		work_no;       								/*��ѯ����*/
String iLoginPwd=		(String)session.getAttribute("password");     
String iPhoneNo=		"";										/*��׼��Σ���ʱ����*/    
String iUserPwd=   		"";										/*��׼��Σ���ʱ����*/
String inOpNote=		"";
String iIdIccid=		"";
String inLoginAccept=	bookingId;
String errCode = "";
String errMsg = "";

System.out.println("zhangyan add iLoginAccept= 	["+iLoginAccept+"]");
System.out.println("zhangyan add iChnSource = 	["+iChnSource+"]");
System.out.println("zhangyan add iOpCode = 		["+iOpCode+"]");
System.out.println("zhangyan add iLoginNo = 	["+iLoginNo+"]");
System.out.println("zhangyan add iLoginPwd = 	["+iLoginPwd+"]");
System.out.println("zhangyan add iPhoneNo = 	["+iPhoneNo+"]");
System.out.println("zhangyan add iUserPwd = 	["+iUserPwd+"]");
System.out.println("zhangyan add iLoginPwd = 	["+inOpNote+"]");
System.out.println("zhangyan add iPhoneNo = 	["+iIdIccid+"]");
System.out.println("zhangyan add iUserPwd = 	["+inLoginAccept+"]");
%>

<wtc:service name="sE385Qry" routerKey="regionCode" routerValue="<%=region_code%>" 
	retcode="retcode1" retmsg="retmsg1"  outnum="8">
		<wtc:param value="<%=iLoginAccept%>"/>
		<wtc:param value="<%=iChnSource%>"/>
		<wtc:param value="<%=iOpCode%>"/>
		<wtc:param value="<%=iLoginNo%>"/>
		<wtc:param value="<%=iLoginPwd%>"/>
		<wtc:param value="<%=iPhoneNo%>"/>
		<wtc:param value="<%=iUserPwd%>"/>
		<wtc:param value="<%=inOpNote%>"/>
		<wtc:param value="<%=iIdIccid%>"/>
		<wtc:param value="<%=inLoginAccept%>"/>
</wtc:service>
<wtc:array id="resultList" scope="end" />

<%
errCode = retcode1 ; 
errMsg = retmsg1;
if (!"000000".equals(errCode)  )
{
	System.out.println("zhangyan add errCode = 	["+errCode+"]");
%>
	<script>
		alert("<%=errCode%>"+":"+"<%=errMsg%>");
		window.close();
	</script>
<%
}
else
{
	if (resultList[0][5].equals(""))
	{
	%>
		<script language="javascript" >
			alert("û��ԤԼ��ϸ��Ϣ!" );
			window.close();
		</script>
	<%
	}
}
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>������BOSS-ҵ���ѯ-ԤԼ��Ϣ��ѯ</title>
<script language="javascript" type="text/javascript" src="/njs/plugins/My97DatePicker/WdatePicker.js"></script>
</head>
<body>
<div id="divBody">
<form action="" method=post name="form1">   
	<DIV id="Operation_Table">   
		<div class="title">
			<div id="title_zi">��վԤԼ�����ѯ 
		</div>
	</div>

	<jsp:include page="/npage/public/pubGetJsonStr.jsp">
		<jsp:param name="jsonStr" value="<%=resultList[0][5]%>"  />
	</jsp:include>		
	

	<table cellspacing="0" id = "footTab">	
	<tr>
		<td align=center colspan="6"> 
			<input class="b_foot" name=close onClick="window.close()" type=button value=�ر�>
		</td>
	</tr>
	</table>
	<%@ include file="/npage/include/footer_simple.jsp" %>

</form>
</div>
</body>
</html>
<%/*-----------------------------javascript��-------------------------------------*/%>
<script language="javascript">
</script>


