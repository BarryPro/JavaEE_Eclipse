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
	
	String work_no = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	
	String phoneNo = request.getParameter("phoneNo");
	String opCode = request.getParameter("opCode");
    String opName = request.getParameter("opName");	
	
	String paraAray[] = new String[9];

	paraAray[0] = request.getParameter("phoneNo");//�ֻ�����
	paraAray[1] = work_no;//����
    paraAray[2] = "1557";//��������
	paraAray[3] = request.getParameter("awardId");//�����
	paraAray[4] = request.getParameter("awardNo");//��ȡ����
	paraAray[5] = request.getParameter("inTotal");//�˺�����
	paraAray[6] = request.getParameter("payAccept");//��Ʒ��ˮ
	paraAray[7] = request.getParameter("opNote");//��ע
    paraAray[8] = request.getParameter("printAccept");//��ӡ��ˮ

 	
	//String[] ret = impl.callService("s1557giftCfm",paraAray,"2","phone",request.getParameter("phoneNo"));
%>
	<wtc:service name="s1557giftCfm" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="2">			
		<wtc:param value="<%=paraAray[0]%>" />
		<wtc:param value="<%=paraAray[1]%>" />
		<wtc:param value="<%=paraAray[2]%>" />
		<wtc:param value="<%=paraAray[3]%>" />
		<wtc:param value="<%=paraAray[4]%>" />
		<wtc:param value="<%=paraAray[5]%>" />
		<wtc:param value="<%=paraAray[6]%>" />
		<wtc:param value="<%=paraAray[7]%>" />
		<wtc:param value="<%=paraAray[8]%>" />
	</wtc:service>
	<wtc:array id="tempArr" scope="end"/>
<%
	String url = "/npage/contact/upCnttInfo.jsp?opCode=1557"+"&retCodeForCntt="+retCode1+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+paraAray[8]+"&pageActivePhone="+phoneNo+"&retMsgForCntt="+retMsg1+"&opBeginTime="+opBeginTime; 
%>
	<jsp:include page="<%=url%>" flush="true" />
<%
	String errCode = retCode1;
	String errMsg = retMsg1;
	if (errCode.equals("000000"))
	{
%>
<script language="JavaScript">
   rdShowMessageDialog("�����¾�ϲ����Ʒ�ɹ���",2);
   removeCurrentTab();
</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("�����¾�ϲ����Ʒʧ��!<br>errCode:"+"<%=errCode%>"+"<br>errMsg:"+"<%=errMsg%>",0);
	history.go(-1);
</script>
<%}%>
