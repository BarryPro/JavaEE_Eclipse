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
		System.out.println("============ fUnitPhoneCheck.jsp ==========");
		
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

		
		String  inputParsm [] = new String[9];
		inputParsm[0] = iLoginAccept;
		inputParsm[1] = iChnSource;
		inputParsm[2] = iOpCode;
		inputParsm[3] = iLoginNo;
		inputParsm[4] = iLoginPwd;
		inputParsm[5] = iPhoneNo;
		inputParsm[6] = iUserPwd;
		inputParsm[7] = iProductId;
		inputParsm[8] = iOprType;
		
		String oOfferIdNow = "";
		String oOfferNameNow = "";
		
%>
		<wtc:service name="sSKPhoneChk" routerKey="region" routerValue="<%=regionCode%>"
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
		</wtc:service>
		<wtc:array id="result1" start="0" length="2"  scope="end"/>
		<wtc:array id="result2" start="2" length="2"  scope="end"/>
	var resultmsg = new Array();
<%
		
		if("000000".equals(retCode)){
		if(result1.length > 0){
			/*当前生效的资费代码*/
				oOfferIdNow = result1[0][0] == null ? "": result1[0][0];
			/*当前生效的资费名称*/
				oOfferNameNow = result1[0][1] == null ? "": result1[0][1];
				System.out.println("============ fUnitPhoneCheck.jsp =========oOfferIdNow=" + oOfferIdNow);
				System.out.println("============ fUnitPhoneCheck.jsp =========oOfferNameNow=" + oOfferNameNow);
		}
			System.out.println("============ fUnitPhoneCheck.jsp =========result1.length=" + result1.length);
			System.out.println("============ fUnitPhoneCheck.jsp =========result2.length=" + result2.length);
			if(result2.length > 0 ){
				for(int i=0;i<result2.length;i++){
				System.out.println("============ fUnitPhoneCheck.jsp ========== result2[i][0]"+result2[i][0]);
				System.out.println("============ fUnitPhoneCheck.jsp ========== result2[i][1]"+result2[i][1]);
				%>
					resultmsg[<%=i%>]=new Array();
					
					resultmsg[<%=i%>][0] = "<%=result2[i][0].trim()%>";
					resultmsg[<%=i%>][1] = "<%=result2[i][1].trim()%>";
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
response.data.add("oOfferIdNow","<%=oOfferIdNow%>");
response.data.add("oOfferNameNow","<%=oOfferNameNow%>");
response.data.add("retArray",resultmsg);
core.ajax.receivePacket(response);