   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-12
********************/
%>
<%request.setCharacterEncoding("GBK");%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType= "text/html;charset=gb2312" %>
<%
	String error_msg="系统错误，请与系统管理员联系，谢谢!!";
	String error_code="444444";
	String[][] errCodeMsg = null;
	String regionCode = (String)session.getAttribute("regCode");
	
	
  	int valid = 1;	//0:正确，1：系统错误，2：业务错误
  	String sDBChange = "sDBChange";
  	String procSql = request.getParameter("procSql");
  	System.out.println(procSql);
%>

    <wtc:service name="sPubProcCfm" outnum="3" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=procSql%>" />
			<wtc:param value="<%=sDBChange%>" />	
		</wtc:service>
		<wtc:array id="result_t2" scope="end"/>

<% 
if(code.equals("000000"))
	valid=1;
else
	valid=2;
	
if( valid == 2){%>
<script language="JavaScript">
<!--
	rdShowMessageDialog("<br>业务错误代码:"+"<%=error_code %></br>"+"错误信息:"+"<%=error_msg %>");
	window.location="f5004.jsp";
//-->
</script>

<%}else{%>
<script language="JavaScript">
<!--
	rdShowMessageDialog("操作成功!!");
	window.location="f5004.jsp";
//-->
</script>
<%}%>








