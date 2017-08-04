<%
  /*
   * 功能: 两城一家
   * 版本: 2.0
   * 日期: 2010/12/23
   * 作者: weigp
   * 版权: si-tech
   * update:
   */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<html>
<head>
<title>两城一家/非常假期</title>
<%
	String loginAccept = WtcUtil.repStr(request.getParameter("loginAccept"), "");
	String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
	String opName = WtcUtil.repStr(request.getParameter("opName"), "");
	String workNo = (String)session.getAttribute("workNo");
	String noPass = (String)session.getAttribute("password");
	String userPhone = WtcUtil.repStr(request.getParameter("userPhone"), "");
	String idNo = "";
	String iModeCodeA = request.getParameter("oldOfferCode");
	String[] iModeCodeAMulti = null;
	String iModeCodeAMultiStr = new String();
	if ("d013".equals(opCode) || "d014".equals(opCode) || "b997".equals(opCode) || "b998".equals(opCode)) {
		iModeCodeAMulti = request.getParameterValues("oldOfferCodeMulti");
		for (int i = 0; i < iModeCodeAMulti.length; i ++) {
			if (i < (iModeCodeAMulti.length - 1)) {
				iModeCodeAMultiStr += iModeCodeAMulti[i] + "#";
			} else {
				iModeCodeAMultiStr += iModeCodeAMulti[i];
			}
		}
	}

	String iModeCodeB = request.getParameter("newOfferCode");
	String iOpNOte = request.getParameter("iOpNOte");
	System.out.println("==============1====== loginAccept = " + loginAccept);
	System.out.println("==============2====== 渠道 = 01");
	System.out.println("==============3====== opCode = " + opCode);
	System.out.println("==============4====== workNo = " + workNo);
	System.out.println("==============5====== noPass = " + noPass);
	System.out.println("==============6====== 号码1 = " + userPhone);
	System.out.println("==============7====== "+iModeCodeA+"-----");
	System.out.println("==============8====== "+iModeCodeB+"-----");
	System.out.println("==============9====== "+iOpNOte+"-----");
	System.out.println("====wanghfa==== iModeCodeAMultiStr = " + iModeCodeAMultiStr);

%>
	<wtc:service name="sB997Cfm" routerKey="phone" routerValue="<%=userPhone%>" retcode="retCode1" retmsg="retMsg1" outnum="2">
		<wtc:param value="<%=loginAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=noPass%>"/>
		<wtc:param value="<%=userPhone%>"/>
		<wtc:param value=""/>
		<%
		if ("d013".equals(opCode) || "d014".equals(opCode) || "b997".equals(opCode) || "b998".equals(opCode)) {
			%>
			<wtc:param value="<%=iModeCodeAMultiStr%>"/>
			<%
		} else {
			%>
			<wtc:param value="<%=iModeCodeA%>"/>
			<%
		}
		%>
		<wtc:param value="<%=iModeCodeB%>"/>
		<wtc:param value="<%=iOpNOte%>"/>
	</wtc:service>
	<wtc:array id="result1"  scope="end"/>
	
	<script language="javascript">
<%
	System.out.println("==================== 两城一家/非常假期:" + retCode1 + "," + retMsg1);
	
	//为统一接触  start
	String sqlFindIdno = "select id_no from dcustmsg where phone_no = '" + userPhone + "'";
%>

<wtc:pubselect name="sPubSelect" retCode="retCode2" retMsg="retMsg2" outnum="1">
	<wtc:sql><%=sqlFindIdno%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result2" scope="end"/>

<%
	System.out.println("==================== 查询idNo:" + retCode2 + "," + retMsg2);
	if ("000000".equals(retCode2) && result2[0][0] != null) {
		idNo = result2[0][0];
	}

	String myOpBeginTime = new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date());
	System.out.println("%%%%%%%调用统一接触开始%%%%%%%%");
	String url = "/npage/contact/upCnttInfo.jsp?opCode=" + opCode + "&opName=" + opName + "&workNo="
		+ workNo + "&retCodeForCntt=" + retCode1 + "&loginAccept=" + loginAccept + "&pageActivePhone="
		+ userPhone + "&contactType=user&contactId=" + idNo + "&retMsgForCntt=" + retMsg1
		+ "&opBeginTime=" + myOpBeginTime;
	System.out.println("url = " + url);
%>
	<jsp:include page="<%=url%>" flush="true" />
<%	
	System.out.println("%%%%%%%调用统一接触结束%%%%%%%%");
	//为统一接触  end
	
	if ("000000".equals(retCode1)) {
%>
		rdShowMessageDialog("业务办理成功！", 2);
		window.location = 'fd013.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=userPhone%>';
<%
	} else {
%>
		rdShowMessageDialog("错误代码：<%=retCode1%>，错误信息： <%=retMsg1%>", 0);
		window.location = 'fd013.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=userPhone%>';
<%
	}
%>
	</script>
