<%
/********************
 version v2.0
 ������: si-tech
 update zhaohaitao at 2009.01.15
 ģ��:Ԥ�滰�������-����
********************/
%>

	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>

<%	
	String opCode = "1292";
	String opName = "Ԥ�滰�������-����";
	String phoneNo = request.getParameter("phoneNo");
	
	String work_no = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
	
	String paraAray[] = new String[12];

    paraAray[0] = request.getParameter("phoneNo").trim();//�������
    paraAray[1] = work_no;//����
    paraAray[2] = request.getParameter("type_code_value");//�û�����
    paraAray[3] = request.getParameter("battery_code");//��Ʒ����
    paraAray[4] = request.getParameter("battery_fee");//����
    paraAray[5] = request.getParameter("prepay_fee");//Ԥ���
    paraAray[6] = request.getParameter("invoice_date");//��Ʊ����
    paraAray[7] = request.getParameter("invoice_work");//��Ʊ����
    paraAray[8] = request.getParameter("invoice_accept");//��Ʊ��ˮ
    paraAray[9] = "1292";//��������
	paraAray[10] = request.getParameter("opNote");//������ע
	paraAray[11] = request.getParameter("printAccept");//������ע
	

	//String[] ret = impl.callService("s1292_Apply",paraAray,"2","phone",request.getParameter("phoneNo"));
%>
	<wtc:service name="s1292_Apply" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="2">			
	<wtc:param value="<%=paraAray[0]%>"/>	
	<wtc:param value="<%=paraAray[1]%>"/>	
	<wtc:param value="<%=paraAray[2]%>"/>	
	<wtc:param value="<%=paraAray[3]%>"/>	
	<wtc:param value="<%=paraAray[4]%>"/>	
	<wtc:param value="<%=paraAray[5]%>"/>	
	<wtc:param value="<%=paraAray[6]%>"/>	
	<wtc:param value="<%=paraAray[7]%>"/>	
	<wtc:param value="<%=paraAray[8]%>"/>	
	<wtc:param value="<%=paraAray[9]%>"/>	
	<wtc:param value="<%=paraAray[10]%>"/>	
	<wtc:param value="<%=paraAray[11]%>"/>
	</wtc:service>	
	<wtc:array id="result1"  scope="end"/>
<%
	String errCode = retCode1;
	String errMsg = retMsg1;
	String url = "/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode1+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+request.getParameter("printAccept")+"&pageActivePhone="+phoneNo+"&retMsgForCntt="+retMsg1+"&opBeginTime="+opBeginTime; 
%>
	<jsp:include page="<%=url%>" flush="true" />
<%
	if (errCode.equals("000000"))
	{
%>
<script language="JavaScript">
   rdShowMessageDialog("Ԥ�滰�������-����ɹ�!",2);
   removeCurrentTab();
</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("Ԥ�滰�������-����ʧ��!(<%=errMsg%>",0);
	history.go(-1);
</script>
<%}%>
