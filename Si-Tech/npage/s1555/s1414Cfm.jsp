   
<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-23
********************/
%>
              
<%
  String opCode = "1414";
  String opName = "����ҵ�񸶽�";
%>              
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page contentType= "text/html;charset=gb2312" %>
<%/*
* name    : 
* author  : wangmei@si-tech.com.cn
* created : 2006-03-28
* revised : 2006-03-28
*/%>
 <%  
    String workno = (String)session.getAttribute("workNo");
    
String regionCode = (String)session.getAttribute("regCode");
	
    String[] inParas = new String[]{""};
	String[][] result  = null ;
    int flag = 0;

	inParas = new String[8];
	inParas[0] = request.getParameter("srv_no");//�ֻ�����
	inParas[1] = workno;//����
	inParas[2] = "1414";//��������
	inParas[3] = request.getParameter("award_type");//��Ʒ����
	inParas[4] = request.getParameter("op_note");//��ע
	inParas[5] = request.getParameter("printAccept");//��ӡ��ˮ
	inParas[6] = request.getParameter("cust_name");//��ӡ��ˮ
	inParas[7] = request.getParameter("award_sum");//��������
	System.out.println("cust_name="+inParas[6]);
	
	//value = viewBean.callService("0", null, "s1414Cfm", "2", inParas);
%>

    <wtc:service name="s1414Cfm" outnum="2" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=inParas[0]%>" />
			<wtc:param value="<%=inParas[1]%>" />	
			<wtc:param value="<%=inParas[2]%>" />	
			<wtc:param value="<%=inParas[3]%>" />
			<wtc:param value="<%=inParas[4]%>" />
			<wtc:param value="<%=inParas[5]%>" />
			<wtc:param value="<%=inParas[6]%>" />
			<wtc:param value="<%=inParas[7]%>" />					
		</wtc:service>
		<wtc:array id="result_t" scope="end" />

<%
	result = result_t;
	System.out.println("return_code="+result[0][0]);
	System.out.println("return_msg"+result[0][1]);
	String return_code = result[0][0];
 	String error_msg = result[0][1];

if (return_code.equals("000000"))
	{
%>
<script language="JavaScript">
   rdShowMessageDialog("�����ɹ���",2);
   removeCurrentTab();
</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("����ʧ��!<br>errCode:"+"<%=return_code%>"+"<br>errMsg:"+"<%=error_msg%>",0);
	history.go(-1);
</script>
<%}%>


<%String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+code1+"&opName="+opName+"&workNo="+workno+"&loginAccept="+inParas[5]+"&pageActivePhone="+inParas[0]+"&retMsgForCntt="+msg1+"&opBeginTime="+opBeginTime; %>
<jsp:include page="<%=url%>" flush="true" />