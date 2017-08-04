<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *create:wanghfa@2010-11-29 网上开户配置
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<head>
<title>网上开户配置</title>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<%
	String opCode = WtcUtil.repNull(request.getParameter("opCode"));
	String opName = WtcUtil.repNull(request.getParameter("opName"));
	System.out.println("=========wanghfa========= fb890_cfm.jsp " + opCode + ", " + opName);
	
	String regionCode=(String)session.getAttribute("regCode");
	String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String noPass = WtcUtil.repNull((String)session.getAttribute("password"));
	String ipAddr = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
	String objectId = WtcUtil.repNull(request.getParameter("addObjectId"));
	String[] objectIds = objectId.split(",");
	String webGroupType = WtcUtil.repNull(request.getParameter("webGroupType"));
	
	String opNote = workNo + "对营业厅进行" + opName + "操作。";
	
	System.out.println("====wanghfa====fb890_cfm.jsp====sb890Cfm====0==== iloginNo = " + workNo);
	System.out.println("====wanghfa====fb890_cfm.jsp====sb890Cfm====1==== iloginPwd = " + noPass);
	System.out.println("====wanghfa====fb890_cfm.jsp====sb890Cfm====2==== iopCode = b890");
	System.out.println("====wanghfa====fb890_cfm.jsp====sb890Cfm====3==== iIpAddr = " + ipAddr);
	System.out.println("====wanghfa====fb890_cfm.jsp====sb890Cfm====4==== iloginNote = " + opNote);
	System.out.println("====wanghfa====fb890_cfm.jsp====sb890Cfm====5==== iorgtype = " + webGroupType);
	System.out.println("====wanghfa====fb890_cfm.jsp====sb890Cfm====6==== iobject_id = " + objectId);
%>
<wtc:service name="sb890Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2">
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=noPass%>"/>
	<wtc:param value="b890"/>
	<wtc:param value="<%=ipAddr%>"/>
	<wtc:param value="<%=opNote%>"/>
	<wtc:param value="<%=webGroupType%>"/>
	<wtc:params value="<%=objectIds%>"/>
</wtc:service>
<wtc:array id="result1" scope="end"/>
<%
	System.out.println("===========wanghfa======= sB608Cfm : " + retCode1 + ", " + retMsg1);
	
//为统一接触  start
	String myOpBeginTime = new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date());
	System.out.println("%%%%b890%%%调用统一接触开始%%%%%%%%");
	String url = "/npage/contact/upCnttInfo.jsp?opCode=" + opCode + "&opName=" + opName + "&workNo="
		+ workNo + "&retCodeForCntt=" + retCode1 + "&retMsgForCntt=" + retMsg1
		+ "&opBeginTime=" + myOpBeginTime;
	System.out.println("url = " + url);
%>
	<jsp:include page="<%=url%>" flush="true" />
<%
	System.out.println("%%%%b890%%%调用统一接触结束%%%%%%%%");
//为统一接触  end


	if ("000000".equals(retCode1)) {
%>
		<script language=javascript>
			rdShowMessageDialog("对营业厅的新增成功！", 2);
			window.location = "fb890.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
		</script>
<%
	} else {
%>
		<script language=javascript>
			rdShowMessageDialog("对营业厅的新增失败，sb890Cfm：<%=retCode1%>，<%=retMsg1%>。", 1);
			window.location = "fb890.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
		</script>
<%
	}
%>
