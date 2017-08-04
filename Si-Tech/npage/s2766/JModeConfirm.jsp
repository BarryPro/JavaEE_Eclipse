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


	
	String users = request.getParameter("users");
	String contract_no = request.getParameter("contract_no");
  String type = request.getParameter("type1");
  String show_mode = request.getParameter("show_mode");
  System.out.println("------------------------"+users);
  System.out.println("------------------------"+show_mode);
  System.out.println("------------------------"+contract_no);
  System.out.println("------------------------"+type);
	String[] inParas = new String[4];
	inParas[0]=contract_no;
	inParas[1]=users;
	inParas[2]=type;
	inParas[3]=show_mode;
%>

<wtc:service name="sJtConModual"  retcode="return_code" retmsg="return_message" outnum="2">
	<wtc:param value="<%=inParas[0]%>"/>
	<wtc:param value="<%=inParas[1]%>"/>
	<wtc:param value="<%=inParas[2]%>"/>
	<wtc:param value="<%=inParas[3]%>"/>
</wtc:service>

	
<script language="JavaScript"	src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>
<SCRIPT type=text/javascript>
function ifprint(){
<%  
  if (return_code.equals("000000")){
%>
  	rdShowMessageDialog("定制模板成功！");
	  document.location.href("f2765_2.jsp");
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
