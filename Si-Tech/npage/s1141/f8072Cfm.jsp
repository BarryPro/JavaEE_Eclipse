 <%
	/********************
	 version v2.0
	������: si-tech
	update:anln@2009-02-16 ҳ�����,�޸���ʽ
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gbk"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

 <%  
 	 String opCode = "8072";	
	 String opName = "���˰���ǩԼ����";	//header.jsp��Ҫ�Ĳ���  
	  
   	String regionCode = (String)session.getAttribute("regCode");
   	
   	String workno =(String)session.getAttribute("workNo");  
	String ip_Addr = (String)session.getAttribute("ipAddr");
	String op_code = request.getParameter("opcode");
	String back_accept = "";
	String logic_code = "";
	String res_code = "";
	String op_name = "";

	
    if(op_code.equals("8072"))
	{
		back_accept = "0";
		logic_code = request.getParameter("logic_code");//�н��ȼ�
		res_code = request.getParameter("res_code");//��Ʒ����
		op_name = "����";
	}else{
		back_accept = request.getParameter("back_accept");
		logic_code = request.getParameter("logic_code_back");//�н��ȼ�
		res_code = request.getParameter("res_code_back");//��Ʒ����
		op_name = "����";
	}
	
	
	//ScallSvrViewBean viewBean = new ScallSvrViewBean();
    	//CallRemoteResultValue  value = null;
    	String[] inParas = new String[]{""};
	//String[][] result  = null ;
    	int flag = 0;

	inParas = new String[11];
	
	inParas[0] = workno;//����
	inParas[1] = op_code;//��������
	inParas[2] = request.getParameter("login_accept");//������ˮ
	inParas[3] = request.getParameter("phone_no");//�ֻ�����
	inParas[4] = request.getParameter("out_prepay_fee");//��ֵ���
	inParas[5] = request.getParameter("child_code");//�����
	inParas[6] = logic_code;
	inParas[7] = res_code;
	inParas[8] = ip_Addr;//��ӡ��ˮ
	inParas[9] = request.getParameter("opNote");//������ע
	inParas[10] = back_accept;  
	//value = viewBean.callService("0", null, "s8072Cfm", "2", inParas);
%>
	<wtc:service name="s8072Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2" >
		<wtc:param value="<%=inParas[0]%>"/>
		<wtc:param value="<%=inParas[1]%>"/>
		<wtc:param value="<%=inParas[2]%>"/>
		<wtc:param value="<%=inParas[3]%>"/>
		<wtc:param value="<%=inParas[4]%>"/>		
		<wtc:param value="<%=inParas[5]%>"/>
		<wtc:param value="<%=inParas[6]%>"/>
		<wtc:param value="<%=inParas[7]%>"/>
		<wtc:param value="<%=inParas[8]%>"/>
		<wtc:param value="<%=inParas[9]%>"/>
		<wtc:param value="<%=inParas[10]%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%

	//result = value.getData();
	System.out.println("return_code="+result[0][0]);
	System.out.println("return_msg"+result[0][1]);
	String return_code = result[0][0];
 	String error_msg = result[0][1];

if (return_code.equals("000000"))
	{
%>
<script language="JavaScript">
   rdShowMessageDialog("���˰������ǩԼ<%=op_name%>�����ɹ���",2);
   history.go(-2);
</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("���˰������ǩԼ<%=op_name%>����ʧ��!<br>errCode:"+"<%=return_code%>"+"<br>errMsg:"+"<%=error_msg%>",0);
	history.go(-1);
</script>
<%}%>

<%
	String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode1
		+"&opName="+opName+"&workNo="+workno+"&loginAccept="+inParas[2]+"&pageActivePhone="+inParas[3]
		+"&retMsgForCntt="+retMsg1+"&opBeginTime="+opBeginTime;
%>
<jsp:include page="<%=url%>" flush="true" />