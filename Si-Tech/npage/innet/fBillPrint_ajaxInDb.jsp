<%
/********************
 *¿ª·¢ÉÌ: si-tech
 *create by wanghfa @ 20110725
 ********************/
%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>

<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
	request.setCharacterEncoding("GBK");
	
	String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	int inParamsNo = Integer.parseInt(request.getParameter("inParamsNo"));
	System.out.println("====wanghfa====pubBillPrint_ajaxInDb.jsp==== inParamsNo = " + inParamsNo);
	String[] inParams = new String[inParamsNo];
	String retCode = "";
	
%>
	<wtc:service name="sG794InDB" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1">			
	<%
		for (int i = 0; i < inParamsNo; i ++) {
			inParams[i] = request.getParameter("inParams" + i);
			System.out.println("====wanghfa====pubBillPrint_ajaxInDb.jsp====s1300PrintInDB==== inParams["+i+"] = " + inParams[i]);
			%>
				<wtc:param value="<%=inParams[i]%>"/>
			<%
		}
	%>
	</wtc:service>
	<wtc:array id="result1"  scope="end"/>
<%
	if (result1.length > 0) {
		retCode = result1[0][0];
	}
	System.out.println("====wanghfa====pubBillPrint_ajaxInDb.jsp====s1300PrintInDB==== " + retCode + ", " + retMsg1);
%>

var response = new AJAXPacket();
response.data.add("retCode", "<%=retCode%>");
response.data.add("retMsg", "<%=retMsg1%>");
core.ajax.receivePacket(response);
