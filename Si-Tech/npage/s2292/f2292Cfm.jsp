<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.1.5
********************/
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ page import="java.util.*"%>

 <%
    response.setHeader("Pragma","No-Cache");
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0);
   String loginPwd    = (String)session.getAttribute("password"); //工号密码
	String loginAccept = request.getParameter("loginAccept");
	String opName = request.getParameter("opName");
 	String opCode  = request.getParameter("opCode");
	String phoneNo = request.getParameter("phoneNo");
	String cardNo = request.getParameter("packnumtype");
	String opNote = request.getParameter("opNote");
	String oldloginAccept = request.getParameter("oldloginAccept");
	


    //==============================获取营业员信息
    String workno = (String)session.getAttribute("workNo");
    String workname = (String)session.getAttribute("workName");
	String regionCode = (String)session.getAttribute("regCode");
	//=======================获得操作流水
	String stream=loginAccept;
	String thework_no=workno;
	String themob=phoneNo;
	String theop_code=opCode;
%>
<%
    String [] inParas = new String[8];

	inParas[0] = loginAccept;
	inParas[1] = opCode;
	inParas[2] = workno;
	inParas[3] = phoneNo;
	inParas[4] = cardNo;
	inParas[5] = opNote;
	inParas[6] = oldloginAccept;
	inParas[7] = "01";

	//String[] ret = impl.callService("s2292Cfm",inParas,"2");
%>
	 <wtc:service name="s2292Cfm" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="6">			
	  	<wtc:param value="<%=inParas[0]%>"/>	
		<wtc:param value="01" />
	 	<wtc:param value="<%=inParas[1]%>"/>
		<wtc:param value="<%=inParas[2]%>"/>
		<wtc:param value="<%=loginPwd%>" />	
		<wtc:param value="<%=inParas[3]%>"/>
    	<wtc:param value=" " /> 	  
	  <wtc:param value="<%=inParas[4]%>"/>
	  <wtc:param value="<%=inParas[5]%>"/>
	  <wtc:param value="<%=inParas[6]%>"/>
	  <wtc:param value="<%=inParas[7]%>"/>
	  </wtc:service>	
	  <wtc:array id="result"  scope="end"/>	
<%
	String url = "/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode1+"&opName="+opName+"&workNo="+workno+"&loginAccept="+loginAccept+"&pageActivePhone="+phoneNo+"&retMsgForCntt="+retMsg1+"&opBeginTime="+opBeginTime; 
	System.out.println("!@#$$$$$$$$$$$$$$$$$$$$$$$$$"+url);
%>
	<jsp:include page="<%=url%>" flush="true" />
<%	
	String retCode= retCode1;
	String retMsg = retMsg1;
	System.out.println("retCode1===="+retCode);
	if (result.length>0 && retCode.equals("000000"))
{%>
	 <script language="JavaScript">
		rdShowMessageDialog("操作成功",2);
		removeCurrentTab();
	 </script>
<%}else{%>
	 <script language="JavaScript">
		rdShowMessageDialog("查询错误!<br>错误代码：'<%=retCode%>'，错误信息：'<%=retMsg%>'。",0);
		//window.location.href="f2292.jsp?";
		history.go(-2);
	 </script>
<%} %>
