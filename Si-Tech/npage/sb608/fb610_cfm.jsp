<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *create:wanghfa@2010-9-26 三口之家
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<head>
<title>退出三口之家</title>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<%
	String opCode = WtcUtil.repNull(request.getParameter("opCode"));
	String opName = WtcUtil.repNull(request.getParameter("opName"));
	System.out.println("=========wanghfa========= fb610_cfm.jsp " + opCode + ", " + opName);
	
	String printAccept = WtcUtil.repNull(request.getParameter("printAccept"));
	String memberPhone2 = WtcUtil.repNull(request.getParameter("memberPhone2"));
	String opNote = WtcUtil.repNull(request.getParameter("opNote"));
	String productId = WtcUtil.repNull(request.getParameter("productId"));
	
	String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String noPass = WtcUtil.repNull((String)session.getAttribute("password"));
	String idNo = "";
	
	System.out.println("===========wanghfa=sB608Cfm==0====== loginAccept = " + printAccept);
	System.out.println("===========wanghfa=sB608Cfm==1====== chnSource = 01");
	System.out.println("===========wanghfa=sB608Cfm==2====== opCode = " + opCode);
	System.out.println("===========wanghfa=sB608Cfm==3====== workNo = " + workNo);
	System.out.println("===========wanghfa=sB608Cfm==4====== noPass = " + noPass);
	System.out.println("===========wanghfa=sB608Cfm==5====== 家长号码 = ");
	System.out.println("===========wanghfa=sB608Cfm==6====== 家长密码 = ");
	System.out.println("===========wanghfa=sB608Cfm==7====== 成员号码 = " + memberPhone2);
	System.out.println("===========wanghfa=sB608Cfm==8====== 成员密码 = ");
	System.out.println("===========wanghfa=sB608Cfm==9====== 产品代码 = " + productId);
	System.out.println("===========wanghfa=sB608Cfm=10====== opNote = " + opNote);
%>
<wtc:service name="sB608Cfm" routerKey="phone" routerValue="<%=memberPhone2%>" retcode="retCode1" retmsg="retMsg1" outnum="2">
	<wtc:param value="<%=printAccept%>"/>
	<wtc:param value="01"/>
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=noPass%>"/>
	<wtc:param value=""/>
	<wtc:param value=""/>
	<wtc:param value="<%=memberPhone2%>"/>
	<wtc:param value=""/>
	<wtc:param value="<%=productId%>"/>
	<wtc:param value="<%=opNote%>"/>
</wtc:service>
<wtc:array id="result1" scope="end"/>
<%
	System.out.println("===========wanghfa======= sB608Cfm : " + retCode1 + ", " + retMsg1);
	
//为统一接触  start
	String sqlFindIdno = "select id_no from dcustmsg where phone_no = '" + memberPhone2 + "'";
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
		+ workNo + "&retCodeForCntt=" + retCode1 + "&loginAccept=" + printAccept + "&pageActivePhone="
		+ memberPhone2 + "&contactType=user&contactId=" + idNo + "&retMsgForCntt=" + retMsg1
		+ "&opBeginTime=" + myOpBeginTime;
	System.out.println("url = " + url);
%>
	<jsp:include page="<%=url%>" flush="true" />
<%	
	System.out.println("%%%%b551%%%调用统一接触结束%%%%%%%%");
//为统一接触  end


	if ("000000".equals(retCode1)) {
%>
		<script language=javascript>
			rdShowMessageDialog("<%=memberPhone2%>的三口之家退出家庭业务办理成功！", 2);
			window.location = "fb608.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
		</script>
<%
	} else {
%>
		<script language=javascript>
			rdShowMessageDialog("<%=retMsg1%>", 1);
			window.location = "fb608.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
		</script>
<%
	}
%>
