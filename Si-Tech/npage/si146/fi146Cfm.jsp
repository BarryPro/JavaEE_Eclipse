<%
/********************
 * version v2.0
 * gaopeng 2013/11/26 15:30:53 双跨融合V网成员套餐受理
 * 开发商: si-tech
 ********************/
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		System.out.println("============ fUnitPhoneCheck.jsp init ==========");
		
		String regionCode = (String)session.getAttribute("regCode");
		
		String iLoginAccept = request.getParameter("iLoginAccept");
		String iChnSource = request.getParameter("iChnSource");
		String iOpCode =  request.getParameter("iOpCode");
		String iLoginNo = request.getParameter("iLoginNo");
		String iLoginPwd =  request.getParameter("iLoginPwd");
		String iPhoneNo =  request.getParameter("iPhoneNo");
		String iUserPwd =  request.getParameter("iUserPwd");
		String iProductId = request.getParameter("iProductId");
		String iOprType =  request.getParameter("iOprType");
		String iOfferId =  request.getParameter("iOfferId");
		String iOfferIdNew =  request.getParameter("iOfferIdNew");

		
		String  inputParsm [] = new String[11];
		inputParsm[0] = iLoginAccept;
		inputParsm[1] = iChnSource;
		inputParsm[2] = iOpCode;
		inputParsm[3] = iLoginNo;
		inputParsm[4] = iLoginPwd;
		inputParsm[5] = iPhoneNo;
		inputParsm[6] = iUserPwd;
		inputParsm[7] = iProductId;
		inputParsm[8] = iOprType;
		inputParsm[9] = iOfferId;
		inputParsm[10] = iOfferIdNew;
		
%>
		<wtc:service name="si146Cfm" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="4">
				<wtc:param value="<%=inputParsm[0]%>"/>
				<wtc:param value="<%=inputParsm[1]%>"/>
				<wtc:param value="<%=inputParsm[2]%>"/>
				<wtc:param value="<%=inputParsm[3]%>"/>
				<wtc:param value="<%=inputParsm[4]%>"/>
				<wtc:param value="<%=inputParsm[5]%>"/>
				<wtc:param value="<%=inputParsm[6]%>"/>
				<wtc:param value="<%=inputParsm[7]%>"/>
				<wtc:param value="<%=inputParsm[8]%>"/>
				<wtc:param value="<%=inputParsm[9]%>"/>
				<wtc:param value="<%=inputParsm[10]%>"/>			
		</wtc:service>
		<wtc:array id="ret" scope="end"/>
	var resultmsg = new Array();
<%
		
		if("000000".equals(retCode)){
			
			System.out.println("============ fUnitPhoneCheck.jsp ========== ret.length：" + ret.length);
			if(ret.length > 0 ){
				for(int i=0;i<ret.length;i++){
				System.out.println("============ fUnitPhoneCheck.jsp ========== ret[i][0]："+ret[i][0]);
				System.out.println("============ fUnitPhoneCheck.jsp ========== ret[i][1]："+ret[i][1]);
				System.out.println("============ fUnitPhoneCheck.jsp ========== ret[i][2]："+ret[i][2]);
				System.out.println("============ fUnitPhoneCheck.jsp ========== ret[i][3]："+ret[i][3]);
				%>
					resultmsg[<%=i%>] = new Array();
					
					resultmsg[<%=i%>][0] = "<%=ret[i][0].trim()%>";
					resultmsg[<%=i%>][1] = "<%=ret[i][1].trim()%>";
					resultmsg[<%=i%>][2] = "<%=ret[i][2].trim()%>";
					resultmsg[<%=i%>][3] = "<%=ret[i][3].trim()%>";
				<%
				}
			
			}
		}else{
			System.out.println("============ fUnitPhoneCheck.jsp 失败==========");
		}
%>
var response = new AJAXPacket();
response.data.add("retCode","<%=retCode %>");
response.data.add("retMsg","<%=retMsg %>");
response.data.add("retArray",resultmsg);
core.ajax.receivePacket(response);