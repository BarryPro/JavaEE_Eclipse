<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
	String opCode = request.getParameter("opCode");
	String phoneNo = request.getParameter("phoneNo");
	String printAccept = request.getParameter("printAccept")== null? "" : request.getParameter("printAccept");
	String prodCode = request.getParameter("prodCode")== null? "" : request.getParameter("prodCode");
	String prodCodeNew = request.getParameter("prodCodeNew") == null? "" : request.getParameter("prodCodeNew");
	String famCode = request.getParameter("famCode")== null? "" : request.getParameter("famCode");
	
	String work_no = (String)session.getAttribute("workNo");
  String regionCode= (String)session.getAttribute("regCode");
  String password = (String)session.getAttribute("password");
  String innetFee = "";//产品变更+续签：初装费
  String faultFee = "";//家庭解散：违约金
  String innetrate="0";
  String innetRateFee="";
  String innetFeeLeft="";
  String TermFee = "";//终端违约金
%>
		<wtc:service name="sFamUpdChk" routerKey="region" routerValue="<%=regionCode%>"
			  retcode="retCode1" retmsg="retMsg1" outnum="6">
				<wtc:param value="<%=printAccept%>"/>
				<wtc:param value="01"/>
				<wtc:param value="<%=opCode%>"/>
				<wtc:param value="<%=work_no%>"/>
				<wtc:param value="<%=password%>"/>
				<wtc:param value="<%=phoneNo%>"/>
				<wtc:param value=""/>
				<wtc:param value="<%=prodCode%>"/>
				<wtc:param value="<%=famCode%>"/>
				<wtc:param value="<%=prodCodeNew%>"/>
		</wtc:service>
		<wtc:array id="result" scope="end"/>
	<%
		if("000000".equals(retCode1)){
			if(result.length > 0 ){
				innetFee = result[0][0];
				faultFee = result[0][1];
        innetrate=result[0][2];
        innetRateFee=result[0][3];
        innetFeeLeft=result[0][4];				
        TermFee = result[0][5];
        System.out.println("gaopengSeeLog============e280======faultFee=="+faultFee);
        System.out.println("gaopengSeeLog============e280======TermFee=="+TermFee);
			}
		}
	%>
	var response = new AJAXPacket();
	response.data.add("retCode","<%= retCode1 %>");
	response.data.add("retMsg","<%= retMsg1 %>");
	response.data.add("innetFee","<%=innetFee%>");
	response.data.add("faultFee","<%=faultFee%>");
	response.data.add("innetrate","<%=innetrate%>");
	response.data.add("innetRateFee","<%=innetRateFee%>");
	response.data.add("innetFeeLeft","<%=innetFeeLeft%>");
	response.data.add("TermFee","<%=TermFee%>");
	core.ajax.receivePacket(response);