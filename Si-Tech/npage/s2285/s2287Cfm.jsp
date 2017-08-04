<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-9
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
	
<%@ page contentType="text/html; charset=GB2312" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%@ page import="java.util.*"%>

 <%
    response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
	
	String loginAccept = request.getParameter("loginAccept");
 	String opCode  = request.getParameter("opCode");
 	String opName="";
 	if(opCode.equals("2287")){
		opName="换卡申请";
	}else{
		opName="换卡冲正";
		
	}
	
	String phoneNo = request.getParameter("phoneNo");
	String cardNo = request.getParameter("cardNo");
	String newcardNo = request.getParameter("newcardNo");
	String opNote = request.getParameter("opNote");
	String oldloginAccept = request.getParameter("oldloginAccept");
		

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
	inParas[4] = cardNo;
	inParas[5] = newcardNo;
	inParas[6] = opNote;
	inParas[7] = oldloginAccept;
	
	
	//String[] ret = impl.callService("s2285Cfm",inParas,"2");
%>

    <wtc:service name="s2285Cfm" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
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
	String url = "/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+code+"&opName="+opName+"&workNo="+workno+"&loginAccept="+loginAccept+"&pageActivePhone="+phoneNo+"&retMsgForCntt="+msg+"&opBeginTime="+opBeginTime;
%>
	<jsp:include page="<%=url%>" flush="true" />
<%	
	String retCode= code;
	String retMsg = msg;	
	
	if (result_t != null && retCode.equals("000000"))
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
