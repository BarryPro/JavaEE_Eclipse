 <%
	/********************
	 version v2.0
	������: si-tech
	update:anln@2009-01-14 ҳ�����,�޸���ʽ
	********************/
%> 

<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
 
 <%  
 	 String opCode = "5100";	
	 String opName = "���긶��";	
    	String regionCode = (String)session.getAttribute("regCode");
    	String workno = (String)session.getAttribute("workNo");    	
	//ScallSvrViewBean viewBean = new ScallSvrViewBean();    	
   	String[] inParas = new String[]{""};
	//String[][] result  = null ;
    	int flag = 0;

	inParas = new String[7];
	inParas[0] = request.getParameter("srv_no");//�ֻ�����
	inParas[1] = workno;//����
	inParas[2] = "5100";//��������
	inParas[3] = request.getParameter("award_type");//��Ʒ����
	inParas[4] = request.getParameter("op_note");//��ע
	inParas[5] = request.getParameter("printAccept");//��ӡ��ˮ
	inParas[6] = request.getParameter("cust_name"); 
	
	System.out.println("cust_name="+inParas[6]);	
	//value = viewBean.callService("0", null, "s5100Cfm", "2", inParas);
	//result = value.getData();
	%>
	<wtc:service name="s5100Cfm" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
			<wtc:params value="<%=inParas%>" />
	</wtc:service>
	<wtc:array id="result" scope="end" />	
	
	<%
	String return_code="";
	String error_msg="";
	
	if(result!=null&&result.length>0){
		System.out.println("2222222222222222222222222222222"+result[0][0]);
		System.out.println("2222222222222222222222222222222"+result[0][1]);
		return_code = result[0][0];
	 	error_msg = result[0][1];
	}
	if (return_code.equals("000000")){
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
	
<%String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+
							"&retCodeForCntt="+retCode1+
							"&opName="+opName+
							"&workNo="+workno+
							"&loginAccept="+inParas[5]+
							"&pageActivePhone="+inParas[0]+
							"&retMsgForCntt="+retMsg1+
							"&opBeginTime="+opBeginTime; %>
<jsp:include page="<%=url%>" flush="true" />
