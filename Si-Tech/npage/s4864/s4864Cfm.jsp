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


	String workno = (String)session.getAttribute("workNo");
	
	String money = request.getParameter("money");
  String phone_no = request.getParameter("phoneNo");
  
  System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"+money+","+phone_no);
 
	String[] inParas = new String[4];
	inParas[0]=workno;
	inParas[1]="b864";
	inParas[2]=phone_no;
	inParas[3]=money;
%>

<wtc:service name="s_b864cfm"  retcode="return_code" retmsg="return_message" outnum="2">
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
  	rdShowMessageDialog("新入网用户赠送话费成功！");
	  history.go(-1);
<%
	} else {
%>
    rdShowMessageDialog("新入网用户赠送话失败！<br>错误代码：'<%=return_code%>'<br>错误信息：'<%=return_message%>'",0);
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
