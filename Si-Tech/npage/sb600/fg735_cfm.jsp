<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *create:wanghfa@2010-9-21 短信签名业务
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode = WtcUtil.repNull(request.getParameter("opCode"));
	String opName = WtcUtil.repNull(request.getParameter("opName"));
	String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));
	String printAccept = WtcUtil.repNull(request.getParameter("printAccept"));
	String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String noPass = WtcUtil.repNull((String)session.getAttribute("password"));
	String opNote = WtcUtil.repNull(request.getParameter("opNote"));
	String regCode = (String)session.getAttribute("regCode");
	
	//获取系统时间
  Date currentTime = new Date(); 
  java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMMddHHmmss");
  String currentTimeString = formatter.format(currentTime);
%>
<%
	System.out.println("===========wanghfa=sB600Cfm==0====== printAccept = " + printAccept);
	System.out.println("===========wanghfa=sB600Cfm==1====== 渠道 = 08");
	System.out.println("===========wanghfa=sB600Cfm==2====== opCode = " + opCode);
	System.out.println("===========wanghfa=sB600Cfm==3====== workNo = " + workNo);
	System.out.println("===========wanghfa=sB600Cfm==4====== noPass = " + noPass);
	System.out.println("===========wanghfa=sB600Cfm==5====== activePhone = " + activePhone);
	System.out.println("===========wanghfa=sB600Cfm==5====== opNote = " + opNote);
%>
<wtc:service name="sProWorkFlowCfm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode1" retmsg="retMsg1" outnum="9">
	<wtc:param value="<%=printAccept%>"/>
	<wtc:param value="01"/>
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=noPass%>"/>
	<wtc:param value="<%=phoneNo%>"/>
	<wtc:param value=""/>
	<wtc:param value="01"/>     <%/*01：订购及退订；CX：前台验证 */%>
  <wtc:param value="DXQM"/>   <%/* 企业代码 */%>
  <wtc:param value="12"/> <%/*12：订购及退订；DXQMCX：前台验证 */%>
  <wtc:param value="07"/> 
  <wtc:param value="<%=currentTimeString%>"/>
  <wtc:param value="20501231235959"/>
  <wtc:param value="<%=currentTimeString%>"/>
  <wtc:param value="<%=opNote%>"/>
</wtc:service>
	<wtc:array id="result1"  scope="end"/>
<%	
	if (!"000000".equals(retCode1)) {
%>
		<script language="JavaScript">
			rdShowMessageDialog("短信签名退订失败！<br>错误代码：<%=retCode1%><br>错误信息：<%=retMsg1%>", 0);
			window.location = "fb600.jsp?activePhone=<%=phoneNo%>&opCode=<%=opCode%>&opName=<%=opName%>";
		</script>
<%
	} else {
%>
		<script language="JavaScript">
			rdShowMessageDialog("短信签名退订成功！", 2);
			window.location = "fb600.jsp?activePhone=<%=phoneNo%>&opCode=<%=opCode%>&opName=<%=opName%>";
		</script>
<%
	}
%>

