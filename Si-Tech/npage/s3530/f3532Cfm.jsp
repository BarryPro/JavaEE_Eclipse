   
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
  String opName = "服务兑换";
%>         
 <%
    response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
	String work_no = (String)session.getAttribute("workNo");
	String loginAccept = request.getParameter("loginAccept");
 	String opCode  = request.getParameter("opCode");
	String phoneNo = request.getParameter("phoneNo");
	String favourType = request.getParameter("markname");
	String num = request.getParameter("num");
	String opNote = request.getParameter("opNote");
	String oldloginAccept = " ";
	String favourCode = favourType.substring(0,4);

	System.out.println("favourType="+favourType );
	System.out.println("favourCode="+favourCode );
		

    //==============================获取营业员信息
    String[][] result = new String[][]{};
	
    String workno = (String)session.getAttribute("workNo");
		String regionCode = (String)session.getAttribute("regCode");
	//=======================获得操作流水
	
    String [] inParas = new String[8];
	
	inParas[0] = loginAccept;
	inParas[1] = opCode;
	inParas[2] = workno;
	inParas[3] = phoneNo;
	inParas[4] = favourCode;
	inParas[5] = num;
	inParas[6] = opNote;
	inParas[7] = oldloginAccept;
	
	
	//String[] ret = impl.callService("s3532Cfm",inParas,"2");
%>

    <wtc:service name="s3532Cfm" outnum="2" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=inParas[0]%>" />
			<wtc:param value="<%=inParas[1]%>" />
			<wtc:param value="<%=inParas[2]%>" />
			<wtc:param value="<%=inParas[3]%>" />
			<wtc:param value="<%=inParas[4]%>" />
			<wtc:param value="<%=inParas[5]%>" />	
			<wtc:param value="<%=inParas[6]%>" />
			<wtc:param value="<%=inParas[7]%>" />					
		</wtc:service>
		<wtc:array id="result_t1" scope="end"/>

<%
	
	String retCode= code1;
	String retMsg = msg1;	
	
	if (result_t1 != null && code1.equals("000000"))
{%>
	 <script language="JavaScript">
		rdShowMessageDialog("操作成功",2);
		window.location.href="f3532.jsp?ph_no=<%=phoneNo%>";
	 </script>
<%}else{%>
	 <script language="JavaScript">
		rdShowMessageDialog("查询错误!<br>错误代码：'<%=retCode%>'，错误信息：'<%=retMsg%>'。",0);
		window.location.href="f3532.jsp?ph_no=<%=phoneNo%>";
	 </script>
<%} %>


<%String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+code1+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+loginAccept+"&pageActivePhone="+phoneNo+"&retMsgForCntt="+msg1+"&opBeginTime="+opBeginTime; %>
<jsp:include page="<%=url%>" flush="true" />