<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *create:wanghfa@2010-9-21 短信回执业务
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
	String printAccept = WtcUtil.repNull(request.getParameter("printAccept"));
	String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String noPass = WtcUtil.repNull((String)session.getAttribute("password"));
	String opNote = WtcUtil.repNull(request.getParameter("opNote"));
	String receiptType = WtcUtil.repNull(request.getParameter("receiptType"));
	String receiptMethod = WtcUtil.repNull(request.getParameter("receiptMethod"));
	String idNo = "";
	
%>
<%
	System.out.println("===========wanghfa=sB600Cfm==0====== printAccept = " + printAccept);
	System.out.println("===========wanghfa=sB600Cfm==1====== 渠道 = 08");
	System.out.println("===========wanghfa=sB600Cfm==2====== opCode = " + opCode);
	System.out.println("===========wanghfa=sB600Cfm==3====== workNo = " + workNo);
	System.out.println("===========wanghfa=sB600Cfm==4====== noPass = " + noPass);
	System.out.println("===========wanghfa=sB600Cfm==5====== activePhone = " + activePhone);
	System.out.println("===========wanghfa=sB600Cfm==5====== userPwd = ");
	System.out.println("===========wanghfa=sB600Cfm==5====== opNote = " + opNote);
	System.out.println("===========wanghfa=sB600Cfm==6====== receiptType = " + receiptType);
	System.out.println("===========wanghfa=sB600Cfm==7====== receiptMethod = " + receiptMethod);
%>
	<wtc:service name="sB600Cfm" routerKey="phone" routerValue="<%=activePhone%>" retcode="retCode1" retmsg="retMsg1" outnum="1">			
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="08"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=noPass%>"/>
		<wtc:param value="<%=activePhone%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=opNote%>"/>
		<wtc:param value="<%=receiptType%>"/>
		<wtc:param value="<%=receiptMethod%>"/>
	</wtc:service>
	<wtc:array id="result1"  scope="end"/>
<%


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
	System.out.println("%%%%b600%%%调用统一接触开始%%%%%%%%");
	String url = "/npage/contact/upCnttInfo.jsp?opCode=" + opCode + "&opName=" + opName + "&workNo="
		+ workNo + "&retCodeForCntt=" + retCode1 + "&loginAccept=" + printAccept + "&pageActivePhone="
		+ activePhone + "&contactType=user&contactId=" + idNo + "&retMsgForCntt=" + retMsg1
		+ "&opBeginTime=" + myOpBeginTime;
	System.out.println("url = " + url);
%>
	<jsp:include page="<%=url%>" flush="true" />
<%	
	System.out.println("%%%%b600%%%调用统一接触结束%%%%%%%%");
//为统一接触  end


	System.out.println("===========wanghfa========== sB600Cfm : " + retCode1 + ", " + retMsg1);
	if (!(retCode1.equals("000000") && result1.length > 0)) {
%>
		<script language="JavaScript">
			rdShowMessageDialog("<%=retMsg1%>", 0);
			window.location = "fb600.jsp?activePhone=<%=activePhone%>&opCode=<%=opCode%>&opName=<%=opName%>";
		</script>
<%
	} else {
		for (int i = 0; i < result1[0].length; i ++) {
			System.out.println("==========wanghfa==================== result[0]["+i+"] = " + result1[0][i]);
		}
%>
		<script language="JavaScript">
			rdShowMessageDialog("<%=retMsg1%>", 3);
			window.location = "fb600.jsp?activePhone=<%=activePhone%>&opCode=<%=opCode%>&opName=<%=opName%>";
		</script>
<%
	}
%>

