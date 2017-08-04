<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="java.util.ArrayList"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<% 
    ArrayList arrSession = (ArrayList)session.getAttribute("allArr");

	String[][] baseInfoSession = (String[][])arrSession.get(0);
    String work_no = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String org_code = (String)session.getAttribute("orgCode");
	 /* 记录发票补打操作日志（doucm）*/
	request.setCharacterEncoding("GBK");
	String retInfo=request.getParameter("retInfo");
	String dirtPage=request.getParameter("dirtPage");
	  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
		
	 	String paraStr[]=new String[6];
		paraStr[0] = request.getParameter("workNo");
		paraStr[1] = request.getParameter("vPhoneNo");
		paraStr[2] = request.getParameter("loginAccept");
		paraStr[3] = request.getParameter("totalDate");
		paraStr[4] = "m123";
		paraStr[5] = "宽带发票补打！";
		
		//SPubCallSvrImpl callView =new SPubCallSvrImpl();
		for(int i = 0; i<paraStr.length; i++)
		{
			System.out.println("params = " + paraStr[i]);
		}

%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="printAccept"/>
<%
%>
<wtc:service name="s1244Print" routerKey="phone" routerValue="<%=paraStr[1]%>" retcode="s1244PrintCode" retmsg="s1244PrintMsg" outnum="1">
    <wtc:param value="<%=paraStr[0]%>"/>
    <wtc:param value="<%=paraStr[1]%>"/>
    <wtc:param value="<%=paraStr[2]%>"/>
    <wtc:param value="<%=paraStr[3]%>"/>
    <wtc:param value="<%=paraStr[4]%>"/>
    <wtc:param value="<%=paraStr[5]%>"/>
</wtc:service>
<wtc:array id="s1244PrintArr" scope="end" />
<%
		String retCode = s1244PrintCode;
		String retMsg  = s1244PrintMsg;	
		System.out.println(" -----------------   in chkPrint: "+retCode+" : "+retMsg);	
		if(!"000000".equals(retCode)){
%>
<SCRIPT type=text/javascript>
	rdShowMessageDialog("返回信息:<%=retCode%>-><%=retMsg%>",1);
  window.location="fm123.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
</SCRIPT>
<%
}else {
	%>
<SCRIPT type=text/javascript>
  window.location="fm123.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
</SCRIPT>
<%
	}
 %>
