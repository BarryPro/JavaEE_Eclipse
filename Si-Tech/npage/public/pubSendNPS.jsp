<%
/*
 * ����: ��ʡ���㼶�ͻ������NPS���齨��ƽ̨����
 * �汾: 1.0
 * ����: 2016/8/19
 * ����: liangyl
 * ��Ȩ: si-tech
 * update:
 */
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>

<wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="sLoginAccept"/>
<%
String iLoginAccept = request.getParameter("statisLoginAccept"); /*��ˮ*/
String iChnSource="01";
String iOpCode=request.getParameter("statisOpCode");
String iLoginNo=(String)session.getAttribute("workNo");
String iLoginPwd=(String)session.getAttribute("password");
String iPhoneNo=request.getParameter("statisPhoneNo");
String iUserPwd="";

System.out.println("@liangyl~~~~iLoginAccept="+iLoginAccept);
System.out.println("@liangyl~~~~iChnSource="+iChnSource);
System.out.println("@liangyl~~~~iOpCode="+iOpCode);
System.out.println("@liangyl~~~~iLoginNo="+iLoginNo);
System.out.println("@liangyl~~~~iLoginPwd="+iLoginPwd);
System.out.println("@liangyl~~~~iPhoneNo="+iPhoneNo);
System.out.println("@liangyl~~~~iUserPwd="+iUserPwd);
%>

<wtc:service name="sevalCfm" retcode="retCode" retmsg="retMsg" outnum="2" >
	<wtc:param value="<%=iLoginAccept%>"/>
	<wtc:param value="<%=iChnSource%>"/>
	<wtc:param value="<%=iOpCode%>"/>
	<wtc:param value="<%=iLoginNo%>"/>
	<wtc:param value="<%=iLoginPwd%>"/>
	<wtc:param value="<%=iPhoneNo%>"/>
	<wtc:param value="<%=iUserPwd%>"/>
</wtc:service>

<%
	System.out.println("@liangyl~~~~retCode"+retCode);
	System.out.println("@liangyl~~~~retMsg"+retMsg);
%>