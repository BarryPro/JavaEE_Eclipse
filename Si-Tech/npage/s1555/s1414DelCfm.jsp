   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-23
********************/
%>
              
 
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page contentType="text/html;charset=GB2312"%>
<%/*
* name    : 
* author  : wangmei@si-tech.com.cn
* created : 2006-03-28
* revised : 2006-03-28
*/%>
<%
  String opCode = "1991";
  String opName = "数据业务付奖冲正";
%>       
<%  
    String workno = (String)session.getAttribute("workNo");
	String regionCode = (String)session.getAttribute("regCode");
	
	String rphone_no = (String)request.getParameter("phone_no");
	
    String[] inParas = new String[]{""};
	String[][] result  = null ;
    int flag = 0;
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="seq"/>
<%
	inParas = new String[7];
	inParas[0] = "1234567890";//手机号码
	inParas[1] = workno;//工号
	inParas[2] = "1991";//操作代码
	inParas[3] = "11";//奖品类型
	inParas[4] = request.getParameter("op_note");
	inParas[5] = request.getParameter("login_accept");//操作流水
	inParas[6] = seq;//打印流水
	System.out.println("login_accept="+inParas[5]);
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
		</wtc:service>
		<wtc:array id="result_t" scope="end" />

<%
	result = result_t;
	System.out.println("return_code="+result[0][0]);
	System.out.println("return_msg="+result[0][1]);
	String return_code = result[0][0];
 	String error_msg = result[0][1];
 	
 	String rcode=code1;
 	String rmsg=msg1;
%>

<%String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+
							"&retCodeForCntt="+rcode+
							"&opName="+opName+
							"&workNo="+workno+
							"&loginAccept="+inParas[6]+
							"&pageActivePhone="+rphone_no+
							"&retMsgForCntt="+rmsg+
							"&opBeginTime="+opBeginTime;
							System.out.println("url========"+url); %>
							
<jsp:include page="<%=url%>" flush="true" />


<%
if (return_code.equals("000000"))
	{
%>
<script language="JavaScript">
   rdShowMessageDialog("付奖冲正成功！",2);
   removeCurrentTab();
</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("付奖冲正失败!<br>errCode:"+"<%=return_code%>"+"<br>errMsg:"+"<%=error_msg%>",0);
	history.go(-1);
</script>
<%}%>
