<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="com.sitech.boss.amd.viewbean.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.config.*"%>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="com.sitech.boss.pub.CallRemoteResultValue"%>
<%@ page import="com.sitech.boss.pub.exception.BOException"%>
<%@ page errorPage="/page/common/errorpage.jsp"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>

<%


	
	String str = request.getParameter("str");
	String show_mode = request.getParameter("show_mode");
  String phone_no = request.getParameter("phoneno");
  System.out.println("------------------------"+str);
  System.out.println("------------------------"+show_mode);
  System.out.println("------------------------"+phone_no);
	String[] inParas = new String[3];
	inParas[0]=str;
	inParas[1]=show_mode;
	inParas[2]=phone_no;
%>

<wtc:service name="sConModual"  retcode="return_code" retmsg="return_message" outnum="2">
	<wtc:param value="<%=inParas[0]%>"/>
	<wtc:param value="<%=inParas[1]%>"/>
	<wtc:param value="<%=inParas[2]%>"/>
</wtc:service>

	
<script language="JavaScript"	src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>
<SCRIPT type=text/javascript>
function ifprint(){
<%  
  if (return_code.equals("000000")){
%>
  	rdShowMessageDialog("定制模板成功！");
	  document.location.href("chooseCon.jsp?phoneno=<%=phone_no%>&show_mode=<%=show_mode%>");
<%
	} else {
%>
    rdShowMessageDialog("定制模板失败！<br>错误代码：'<%=return_code%>'<br>错误信息：'<%=return_message%>'",0);
    history.go(-1);
<%
	}     
%>
}			
</SCRIPT>
<html>
<body onload="ifprint()">
</body>
</html>
