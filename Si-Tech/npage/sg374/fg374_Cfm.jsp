<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-02-05
 ********************/
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%
String workNo = (String)session.getAttribute("workNo");
String workName = (String)session.getAttribute("workName");
String regionCode=(String)session.getAttribute("regCode");
String op_name =  "农信通受理";
String org_code = (String)session.getAttribute("orgCode");//归属代码
String login_passwd = (String)session.getAttribute("password");//工号密码
String region_code = org_code.substring(0,2);
String phoneNo  = request.getParameter("phoneNo");
String strcontent  = request.getParameter("strcontent");
String strcontype  = request.getParameter("strcontype");
String strcontopr  = request.getParameter("strcontopr");
String spid  = request.getParameter("spid");
String bizcode  = request.getParameter("bizcode");

String [] inputParam = new String [12] ;
	inputParam[0]="0";
	inputParam[1]="08";
	inputParam[2]="g374";
	inputParam[3]=workNo;
	inputParam[4]=login_passwd;
	inputParam[5]=phoneNo;
	inputParam[6]="";
	inputParam[7]=strcontopr;
	inputParam[8]=strcontype;
	inputParam[9]=strcontent;
	inputParam[10]=spid;
	inputParam[11]=bizcode;
%>
<wtc:service name="sg374Cfm" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode" retmsg="retMsg" outnum="2" >
	<wtc:param value="<%=inputParam[0]%>"/>
	<wtc:param value="<%=inputParam[1]%>"/>
	<wtc:param value="<%=inputParam[2]%>"/>
	<wtc:param value="<%=inputParam[3]%>"/>
	<wtc:param value="<%=inputParam[4]%>"/>
	<wtc:param value="<%=inputParam[5]%>"/>
	<wtc:param value="<%=inputParam[6]%>"/>
	<wtc:param value="<%=inputParam[7]%>"/>
	<wtc:param value="<%=inputParam[8]%>"/>
	<wtc:param value="<%=inputParam[9]%>"/>
	<wtc:param value="<%=inputParam[10]%>"/>
	<wtc:param value="<%=inputParam[11]%>"/>
</wtc:service>
<%

if(!retCode.equals("000000")){%>
	<script language="JavaScript">
	    rdShowMessageDialog("业务受理失败，原因：<%=retMsg%>!",0);
	    history.go(-1);
	</script>
<%
}
else{
%>
	<script language="JavaScript">
	   	rdShowMessageDialog("<%=retMsg%>!",2);
	   	history.go(-1);
	</script>
<%
}
%>