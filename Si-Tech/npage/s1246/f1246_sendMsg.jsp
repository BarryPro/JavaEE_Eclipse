
<%
  /*
   * 功能: 强关发短信
   * 版本: 1.0
   * 日期: 2011/10/14 13:06:29
   * 作者: zhangyan
   * 版权: si-tech
   * update:
  */
%>

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String iLoginAccept ="";
	String iChnSource = "01"; 
	String iOpCode     ="1246";
	String iLoginNo    =(String)session.getAttribute("workNo");
	String iLoginPwd   ="";
	String iPhoneNo    =request.getParameter("i1");
	String iUserPwd    ="";
	String iLargeTicketTime  =request.getParameter("largeticket_time");
	String iOwning_fee = request.getParameter("owning_fee");
	
	System.out.println("zhangyan add : iLoginAccept       =["+ iLoginAccept     +"]");
	System.out.println("zhangyan add : iChnSource         =["+ iChnSource       +"]");
	System.out.println("zhangyan add : iOpCode            =["+ iOpCode          +"]");
	System.out.println("zhangyan add : iLoginNo           =["+ iLoginNo         +"]");
	System.out.println("zhangyan add : iLoginPwd          =["+ iLoginPwd        +"]");
	System.out.println("zhangyan add : iPhoneNo           =["+ iPhoneNo         +"]");
	System.out.println("zhangyan add : iUserPwd           =["+ iUserPwd         +"]");
	System.out.println("zhangyan add : iLargeTicketTime   =["+ iLargeTicketTime +"]");	
	System.out.println("zhangyan add : iOwning_fee   =["+ iOwning_fee +"]");	
%>

	<wtc:service name="s1246SendMsg" routerKey="region" routerValue="<%=iPhoneNo%>" 
		outnum="2" retCode="retCode" retMsg="retMsg">
		<wtc:param value="<%=iLoginAccept%>"/>
		<wtc:param value="<%=iChnSource%>"/>
		<wtc:param value="<%=iOpCode%>"/>
		<wtc:param value="<%=iLoginNo%>"/>
		<wtc:param value="<%=iLoginPwd%>"/>
		<wtc:param value="<%=iPhoneNo%>"/>
		<wtc:param value="<%=iUserPwd%>"/>
		<wtc:param value="<%=iLargeTicketTime%>"/>
		<wtc:param value="<%=iOwning_fee%>"/>
	</wtc:service>
<wtc:array id="result" scope="end" />

var response = new AJAXPacket();
var retCode = "";
var retMsg = ""
retCode="<%=retCode%>";
retMsg="<%=retMsg%>";
response.data.add("retCode",retCode);
response.data.add("retMsg",retMsg);

core.ajax.receivePacket(response);

