<%
/********************
 * version v2.0
 * 开发商: si-tech
 * author: daixy
 * date  : 20100226
 ********************/
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>

 <%
    response.setHeader("Pragma","No-Cache");
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0);
   
	/************************ 获取参数值 ***********************/
	String iLoginAccept = request.getParameter("iLoginAccept");
	String iChnSource = "";      
	String op_code = request.getParameter("opCode");
	String iLoginNo = (String)session.getAttribute("workNo");
	String iLoginPwd = (String)session.getAttribute("password");
	String iPhoneNo = request.getParameter("phoneNo");        
	String iUserPwd = "";       
	String iNowState = request.getParameter("iNowState");        
	String iIpAddr = (String)session.getAttribute("ipAddr");
	String opName = request.getParameter("opName");       
 
 	/***************** 调用后台处理服务 begin *******************/
    String [] inParas = new String[9];
	inParas[0] = iLoginAccept;
	inParas[1] = iChnSource;
	inParas[2] = op_code;
	inParas[3] = iLoginNo;
	inParas[4] = iLoginPwd;
	inParas[5] = iPhoneNo;
	inParas[6] = iUserPwd;
	inParas[7] = iIpAddr;
	inParas[8] = iNowState;
%>

	 <wtc:service name="s9458Cfm" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="retCode" retmsg="retMsg" outnum="2">			
	  	<wtc:param value="<%=inParas[0]%>"/>	
		<wtc:param value="<%=inParas[1]%>" />
	 	<wtc:param value="<%=inParas[2]%>"/>
		<wtc:param value="<%=inParas[3]%>"/>
	  	<wtc:param value="<%=inParas[4]%>"/>
	  	<wtc:param value="<%=inParas[5]%>"/>
	  	<wtc:param value="<%=inParas[6]%>"/>
	  	<wtc:param value="<%=inParas[7]%>"/>
	  	<wtc:param value="<%=inParas[8]%>"/>
	  </wtc:service>	
	  <wtc:array id="result"  scope="end"/>	
	  	
<%
	String url = "/npage/contact/upCnttInfo.jsp?opCode="+op_code+"&retCodeForCntt="+retCode+"&opName="+opName+"&workNo="+iLoginNo+"&loginAccept="+iLoginAccept+"&pageActivePhone="+iPhoneNo+"&retMsgForCntt="+retMsg+"&opBeginTime="+opBeginTime; 
	System.out.println("!@#$$$$$$$$$$$$$$$$$$$$$$$$$"+url);
%>
	<jsp:include page="<%=url%>" flush="true" />
<%	
	/******************** 调用后台处理服务 end ***********************/
	
	if (result.length>0 && retCode.equals("000000"))
{%>
	 <script language="JavaScript">
		rdShowMessageDialog("操作成功",2);
		removeCurrentTab();
	 </script>
<%}else{%>
	 <script language="JavaScript">
		rdShowMessageDialog("查询错误!<br>错误代码：'<%=retCode%>'，错误信息：'<%=retMsg%>'。",0);
		history.go(-2);
	 </script>
<%} %>