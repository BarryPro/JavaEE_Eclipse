<%
/********************
 version v2.0
 ������: si-tech
 ģ�飺ͳһ�콱
 update zhaohaitao at 2009.1.4
********************/
%>
	
<%@ include file="/npage/include/public_title_name.jsp" %>	
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>


<%	
	String phoneNo = request.getParameter("phoneNo");
	String opCode = request.getParameter("opCode");
    String opName = request.getParameter("opName");	
    String pringAccept = request.getParameter("printAccept");
    
	String work_no = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");

	String paraAray[] = new String[11];

	paraAray[0] = request.getParameter("id_no");			//�ֻ�����
	paraAray[1] = work_no;									//����
    paraAray[2] = request.getParameter("phoneNo");			//�绰����
	paraAray[3] = request.getParameter("usePoint");			//�û����ѻ���
	paraAray[4] = org_code;									//�ҽ����Ź���
	paraAray[5] = request.getParameter("num1");				//10Ԫ��Ʒ����
	paraAray[6] = request.getParameter("num2");				//20Ԫ��Ʒ����
	paraAray[7] = request.getParameter("num3");				//50Ԫ��Ʒ����
	paraAray[8] = request.getParameter("num4");				//100Ԫ��Ʒ����
	paraAray[9] = request.getParameter("num5");				//200Ԫ��Ʒ����
    paraAray[10] = request.getParameter("leavePoint");		//ʣ�����

 	
	//String[] ret = impl.callService("s1444Cfm",paraAray,"2","phone",request.getParameter("phoneNo"));
%>
	<wtc:service name="s1444Cfm" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="2">			
		<wtc:param value="<%=paraAray[0]%>" />
		<wtc:param value="<%=paraAray[1]%>" />
		<wtc:param value="<%=paraAray[2]%>" />
		<wtc:param value="<%=paraAray[3]%>" />
		<wtc:param value="<%=paraAray[4]%>" />
		<wtc:param value="<%=paraAray[5]%>" />
		<wtc:param value="<%=paraAray[6]%>" />
		<wtc:param value="<%=paraAray[7]%>" />
		<wtc:param value="<%=paraAray[8]%>" />
		<wtc:param value="<%=paraAray[9]%>" />
		<wtc:param value="<%=paraAray[10]%>" />
	</wtc:service>
	<wtc:array id="tempArr" scope="end"/>
<%
	String url = "/npage/contact/upCnttInfo.jsp?opCode=1557"+"&retCodeForCntt="+retCode1+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+pringAccept+"&pageActivePhone="+phoneNo+"&retMsgForCntt="+retMsg1+"&opBeginTime="+opBeginTime; 
%>
	<jsp:include page="<%=url%>" flush="true" />
<%
	String errCode = retCode1;
	String errMsg = retMsg1;
	if (errCode.equals("000000"))
	{
<script language="JavaScript">
   rdShowMessageDialog("�ҽ��ɹ���",2);
   removeCurrentTab();
</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("�ҽ�ʧ��!<br>errCode:"+"<%=errCode%>"+"<br>errMsg:"+"<%=errMsg%>",0);
	history.go(-1);
</script>
<%}%>
