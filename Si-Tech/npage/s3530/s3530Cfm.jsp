   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-10
********************/
%>

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%@ page import="java.util.*"%>

 <%
  response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
	String opName = "会籍管理";
	String loginAccept = request.getParameter("loginAccept");
 	String opCode  = request.getParameter("opCode");
	String phoneNo = request.getParameter("phoneNo");
	String cardNo = request.getParameter("cardNo");
	String newcardNo = request.getParameter("oldcardNo");
	String opNote = request.getParameter("opNote");
	String oldloginAccept = request.getParameter("oldloginAccept");
	String clubType = request.getParameter("clubType");
		

    //==============================获取营业员信息
    String[][] result = new String[][]{};
    String workno = (String)session.getAttribute("workNo");
	  String regionCode = (String)session.getAttribute("regCode");
	//=======================获得操作流水
	
    String [] inParas = new String[9];
	
	inParas[0] = loginAccept;
	inParas[1] = opCode;
	inParas[2] = workno;
	inParas[3] = phoneNo;
	inParas[4] = cardNo;
	inParas[5] = newcardNo;
	inParas[6] = opNote;
	inParas[7] = oldloginAccept;
	inParas[8] = clubType;
	
	
	//String[] ret = impl.callService("s3530Cfm",inParas,"2");
	
%>


    <wtc:service name="s3530Cfm" outnum="2" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=inParas[0]%>" />
			<wtc:param value="<%=inParas[1]%>" />
			<wtc:param value="<%=inParas[2]%>" />
			<wtc:param value="<%=inParas[3]%>" />
			<wtc:param value="<%=inParas[4]%>" />
			<wtc:param value="<%=inParas[5]%>" />	
			<wtc:param value="<%=inParas[6]%>" />
			<wtc:param value="<%=inParas[7]%>" />					
			<wtc:param value="<%=inParas[8]%>" />		
		</wtc:service>
		<wtc:array id="result_t1" scope="end"/>


<%	
	String retCode=code1;
	String retMsg =msg1;
	
	if (result_t1 != null && code1.equals("000000"))
{%>
	 <script language="JavaScript">
		rdShowMessageDialog("操作成功",2);
		window.location.href="s3530.jsp?ph_no=<%=phoneNo%>";
	 </script>
<%}else{%>
	 <script language="JavaScript">
		rdShowMessageDialog("查询错误!<br>错误代码：'<%=retCode%>'，错误信息：'<%=retMsg%>'。",0);
		window.location.href="s3530.jsp?ph_no=<%=phoneNo%>";
	 </script>
<%} %>


<%String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+code1+"&opName="+opName+"&workNo="+workno+"&loginAccept="+loginAccept+"&pageActivePhone="+phoneNo+"&retMsgForCntt="+msg1+"&opBeginTime="+opBeginTime; %>
<jsp:include page="<%=url%>" flush="true" />