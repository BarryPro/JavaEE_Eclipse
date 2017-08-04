<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *create:wanghfa@2010-9-6 二人世界情侣号码
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<html>
<head>
<title>二人世界业务办理</title>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<%
	String loginAccept = WtcUtil.repStr(request.getParameter("loginAccept"), "");
	String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
	String opName = WtcUtil.repStr(request.getParameter("opName"), "");
	String workNo = (String)session.getAttribute("workNo");
	String noPass = (String)session.getAttribute("password");
	String loverPhone = WtcUtil.repStr(request.getParameter("loverPhone"), "");
	String idNo = "";
	
	System.out.println("===========wanghfa===0====== loginAccept = " + loginAccept);
	System.out.println("===========wanghfa===1====== 渠道 = 01");
	System.out.println("===========wanghfa===2====== opCode = " + opCode);
	System.out.println("===========wanghfa===3====== workNo = " + workNo);
	System.out.println("===========wanghfa===4====== noPass = " + noPass);
	System.out.println("===========wanghfa===5====== 号码1 = " + activePhone);
	System.out.println("===========wanghfa===6====== 密码1 = ");
	System.out.println("===========wanghfa===7====== 号码2 = " + loverPhone);
	System.out.println("===========wanghfa===8====== 密码2 = ");

%>
	<wtc:service name="sB551Check" routerKey="phone" routerValue="<%=activePhone%>" retcode="retCode1" retmsg="retMsg1" outnum="1">
		<wtc:param value="<%=loginAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=noPass%>"/>
		<wtc:param value="<%=activePhone%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=loverPhone%>"/>
		<wtc:param value=""/>
	</wtc:service>
	<wtc:array id="result1"  scope="end"/>
	
	<script language="javascript">
<%
	System.out.println("===========wanghfa========= sB551Check:" + retCode1 + "," + retMsg1);
	
//为统一接触  start
	String sqlFindIdno = "select id_no from dcustmsg where phone_no = '" + activePhone + "'";
%>

<wtc:pubselect name="sPubSelect" retCode="retCode2" retMsg="retMsg2" outnum="1">
	<wtc:sql><%=sqlFindIdno%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result2" scope="end"/>

<%
	System.out.println("===========wanghfa========= 查询idNo:" + retCode2 + "," + retMsg2);
	if ("000000".equals(retCode2) && result2[0][0] != null) {
		idNo = result2[0][0];
	}
	
	String myOpBeginTime = new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date());
	System.out.println("%%%%b551%%%调用统一接触开始%%%%%%%%");
	String url = "/npage/contact/upCnttInfo.jsp?opCode=" + opCode + "&opName=" + opName + "&workNo="
		+ workNo + "&retCodeForCntt=" + retCode1 + "&loginAccept=" + loginAccept + "&pageActivePhone="
		+ activePhone + "&contactType=user&contactId=" + idNo + "&retMsgForCntt=" + retMsg1
		+ "&opBeginTime=" + myOpBeginTime;
	System.out.println("url = " + url);
%>
	<jsp:include page="<%=url%>" flush="true" />
<%	
	System.out.println("%%%%b551%%%调用统一接触结束%%%%%%%%");
//为统一接触  end
	
	if ("000000".equals(retCode1)) {
%>
		rdShowMessageDialog("<%=activePhone%>和<%=loverPhone%>二人世界业务办理申请成功！情侣号码回复短信即办理完成。", 2);
		window.location = "fb551.jsp?opCode=b551&opName=二人世界业务受理&activePhone=<%=activePhone%>";
<%
	} else {
%>
		rdShowMessageDialog("sB551Check服务：<%=retCode1%>，retMsg = <%=retMsg1%>", 0);
		window.location = "fb551.jsp?opCode=b551&opName=二人世界业务受理&activePhone=<%=activePhone%>";
<%
	}
%>
	</script>
