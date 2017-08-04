<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>

<%
    String workno = (String)session.getAttribute("workNo");
    String password = (String)session.getAttribute("password");
    String workname = (String)session.getAttribute("workName");
    String orgcode = (String)session.getAttribute("orgCode");
    String regionCode = orgcode.substring(0,2);
    String ipAddr = (String)session.getAttribute("ipAddr");

		String phone_no = request.getParameter("phone_no");
		String i_awake_fee = request.getParameter("i_awake_fee");
		String busyType = request.getParameter("busyType");
		String opCode = request.getParameter("opCode");
		String retSuccessMsg = "";
		String busyType222 = "";
		if("U".equals(busyType)){
			retSuccessMsg = "增加操作成功";
			busyType222="0";
		}else if("D".equals(busyType)){
			retSuccessMsg = "删除操作成功";
			busyType222="1";
		}
		
%>                                                     

<html>
<body>
  <wtc:service name="s2280Cfm" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="iErrorNo" retmsg="sErrorMessage"  outnum="2" >
    <wtc:param value="0"/>
    <wtc:param value="01"/>
    <wtc:param value="<%=opCode%>"/>
    <wtc:param value="<%=workno%>"/>
    <wtc:param value="<%=password%>"/>
    <wtc:param value="<%=phone_no%>"/>
    <wtc:param value=""/>
    <wtc:param value="<%=orgcode%>"/>
    <wtc:param value=""/>
    <wtc:param value="<%=ipAddr%>"/>
    <wtc:param value="U"/>
    <wtc:param value="<%=i_awake_fee%>"/>
    <wtc:param value="1"/>
    <wtc:param value="1"/>
    <wtc:param value="0700"/>
    <wtc:param value="2100"/>
    <wtc:param value="0"/>
    <wtc:param value="<%=busyType222%>"/>
  </wtc:service>
	
<%	
	if( iErrorNo.equals("000000") )
	{
%>
		<script language="JavaScript">
			rdShowMessageDialog("<%=retSuccessMsg%>！",2);
			window.history.go(-1);
		</script>
<%
	}
	else
	{
%>
		<script language="JavaScript">
			rdShowMessageDialog("<%=sErrorMessage%>",0);
			window.history.go(-1);
		</script>
<%
	}
%>
	
</body>
</html>
