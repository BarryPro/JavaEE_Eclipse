<%
/*
* ����: ��վԤԼ����
* �汾: 1.0
* ����: 2011-11-8 8:15:06
* ����: zhangyan
* ��Ȩ: si-tech
* update:
*/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
String iLoginAccept = 	request.getParameter("iLoginAccept")==null?"":request.getParameter("iLoginAccept");
String iChnSource = 	"";
String iOpCode = 		request.getParameter("iOpCode")==null?"":request.getParameter("iOpCode");
String iLoginNo = 		request.getParameter("iLoginNo")==null?"":request.getParameter("iLoginNo");
String iLoginPwd = 		request.getParameter("iLoginPwd")==null?"":request.getParameter("iLoginPwd");
String iPhoneNo = 		request.getParameter("iPhoneNo")==null?"":request.getParameter("iPhoneNo");
String iUserPwd = 		request.getParameter("iUserPwd")==null?"":request.getParameter("iUserPwd");
String inOpNote = 		request.getParameter("inOpNote")==null?"":request.getParameter("inOpNote");
String iBookingId = 	request.getParameter("iBookingId")==null?"":request.getParameter("iBookingId");


System.out.println("~~~~~~~~~~~~~~~~~~iBookingId=["+iBookingId+"]");

try{
%>
	<wtc:service name="sE385Cfm" retcode="retcode" retmsg="retmsg" outnum="2" >
		<wtc:param value="<%=iLoginAccept%>"/>
		<wtc:param value="<%=iChnSource%>"/>
		<wtc:param value="<%=iOpCode%>"/>
		<wtc:param value="<%=iLoginNo%>"/>
		<wtc:param value="<%=iLoginPwd%>"/>
		<wtc:param value="<%=iPhoneNo%>"/>
		<wtc:param value="<%=iUserPwd%>"/>
		<wtc:param value="<%=inOpNote%>"/>
		<wtc:param value="<%=iBookingId%>"/>
	</wtc:service>
<%
  System.out.println("%%%%%%����ԤԼ����%%%%%%%%%%"+retcode);
  System.out.println("%%%%%%����ԤԼ����%%%%%%%%%%"+retmsg);
 }catch(Throwable e)
      {
    
      }
  System.out.println("%%%%%%һ��ԤԼ������óɹ�%%%%%%%%%%");
%>
