<%
/********************
 version v2.0
开发商 si-tech
update hejw@2009-1-13
********************/
%>


<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%@ page import="java.util.*"%>
<%/*
* name    : 
* author  : wangmei@si-tech.com.cn
* created : 2005-10-17
* revised : 2005-10-17
*/%>
<%
  String opCode = "1441";
  String opName = "重新签署协议登记";
%>

 <%  
    String workno = (String)session.getAttribute("workNo");
    String workname = (String)session.getAttribute("workName");
    String regionCode= (String)session.getAttribute("regCode");

	String ipAddr = (String)session.getAttribute("ipAddr");
	String phoneNo = request.getParameter("phone_no");
	String conName = request.getParameter("Contract_name");
	String smName = request.getParameter("sm_name");
	String Protocal = request.getParameter("protocal");
	String date = request.getParameter("date");
	String smcode = request.getParameter("smcode");
	String printAccept = request.getParameter("printAccept");

	System.out.println("Phone_no=="+phoneNo);
	System.out.println("conName=="+conName);
	System.out.println("printAccept=="+printAccept);
    
    String[] inParas = new String[]{""};

   
	inParas = new String[9];
	inParas[0] = phoneNo;
	inParas[1] = conName;
	inParas[2] = smcode;
	inParas[3] = Protocal;
	inParas[4] = date;
	inParas[5] = workno;
	inParas[6] = opCode;
	inParas[7] = ipAddr;
	inParas[8] = printAccept;
    
	//System.out.println("11111111111111111111111");


%>
	  <wtc:service name="s1441Cfm" outnum="2" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
				<wtc:param value="<%=phoneNo%>" />
				<wtc:param value="<%=conName%>" />
				<wtc:param value="<%=smcode%>" />
				<wtc:param value="<%=Protocal%>" />
				<wtc:param value="<%=date%>" />
				<wtc:param value="<%=workno%>" />
				<wtc:param value="<%=opCode%>" />
				<wtc:param value="<%=ipAddr%>" />
				<wtc:param value="<%=printAccept%>" />
		</wtc:service>
<%

	String return_code = code1;
 	String error_msg = msg1;

if (return_code.equals("000000"))
	{
%>
<script language="JavaScript">
   rdShowMessageDialog("登记成功! ",2);
   removeCurrentTab();
</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("登记失败!错误代码<%=return_code%>,错误信息<%=error_msg%>",0);
	history.go(-1);
</script>
<%}%>

 <%
 	String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+code1+"&opName="+opName
 		+"&workNo="+workno+"&loginAccept="+printAccept+"&pageActivePhone="+phoneNo+"&retMsgForCntt="+msg1
 		+"&opBeginTime="+opBeginTime; 
%>
<jsp:include page="<%=url%>" flush="true" />