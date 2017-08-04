<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-01-13
 ********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>


<%
    //得到输入参数
    String opCode = WtcUtil.repStr(request.getParameter("opCode")," ");
    String phoneNo = WtcUtil.repStr(request.getParameter("phoneNo")," ");
    String regionCode = (String)session.getAttribute("regCode");
    
%>	 
		<wtc:service name="s5584Qry" outnum="4" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="" />
			<wtc:param value="" />
			<wtc:param value="<%=opCode%>" />
			<wtc:param value="" />
			<wtc:param value="" />
			<wtc:param value="<%=phoneNo%>" />					
			<wtc:param value="" />						
			<wtc:param value="12" />							
		</wtc:service>
		<wtc:array id="result_t3" scope="end" />
<%
String offerId = "";
String offerName = "";
String offerDesc = "";
String fprodId = "";

 if(!code1.equals("000000")){
 }else{
		offerId = result_t3[0][0];
		offerName = result_t3[0][1];
		offerDesc = result_t3[0][2];
		fprodId = result_t3[0][3];
	
	} 
%>

var response = new AJAXPacket();
response.data.add("code","<%=code1%>");
response.data.add("msg","<%=msg1%>");
response.data.add("offerId","<%=offerId%>");
response.data.add("offerName","<%=offerName%>");
response.data.add("offerDesc","<%=offerDesc%>");
response.data.add("fprodId","<%=fprodId%>");
core.ajax.receivePacket(response);
