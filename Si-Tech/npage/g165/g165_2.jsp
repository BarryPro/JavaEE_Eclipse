<%
/********************
 version v2.0
������: si-tech
*
*liuxmc
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
String[] inParas2 = new String[6];
		String opCode = "g165";
		String opName = "����Ʊ¼��";
		String workno = (String)session.getAttribute("workNo");
		String invoice_id = request.getParameter("invoice_id");  
		String invoice_no = request.getParameter("invoice_no"); 
		String loss_type = request.getParameter("loss_type"); 
		String loss_reason = request.getParameter("loss_reason"); 
		//xl add for ��Ʊ����
		String fplx = request.getParameter("fplx");
	inParas2[0]= workno;
	inParas2[1]=invoice_id;
	inParas2[2]=invoice_no;
	inParas2[3]=loss_type;
	inParas2[4]=loss_reason;
	inParas2[5]=fplx;
  %>
  <wtc:service name="sInsPsInfo" retcode="retCode1" retmsg="retMsg1" outnum="2">
	<wtc:param value="<%=inParas2[0]%>"/>
	<wtc:param value="<%=inParas2[1]%>"/>
	<wtc:param value="<%=inParas2[2]%>"/>
	<wtc:param value="<%=inParas2[3]%>"/>
	<wtc:param value="<%=inParas2[4]%>"/>
	<wtc:param value="<%=inParas2[5]%>"/>
  </wtc:service>
  <wtc:array id="ret_val" scope="end" />
  <%
	String retCode= retCode1;
	String retMsg = retMsg1;
	if ( retCode1.equals("000000") ||retCode1=="000000" )
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("����Ʊ¼��ɹ���");
				window.location.href="g165_1.jsp";  
			</script>
		<%
	}
	else
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("����Ʊ¼��ʧ�ܣ��������"+"<%=retCode1%>������ԭ��"+"<%=retMsg1%>");
				window.location.href="g165_1.jsp";  
			</script>
		<%
	}
  %>	
	
<HTML>
<HEAD>

 
<title>������BOSS-��Ʊ��Ϣ��ѯ��¼��</title>
</head>
<BODY>

 </BODY>
</HTML>

