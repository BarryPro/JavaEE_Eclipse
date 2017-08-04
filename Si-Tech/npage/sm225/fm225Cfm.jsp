<%
/********************
 * version v2.0
 * gaopeng 2015/02/11 9:50:29 关于11月份集团客户部CRM、BOSS和经分系统需求的函-7-行业应用流量卡BOSS系统需求
 * 开发商: si-tech
 ********************/
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
		System.out.println("===gaopengSeeLog========= fm225Cfm.jsp ==========");
		
		String regionCode = (String)session.getAttribute("regCode");
		
		String iLoginAccept = request.getParameter("iLoginAccept");//每次提交都为一个新流水 hejwa and haoyy 2015年6月10日10:32:09
		
		String iChnSource = request.getParameter("iChnSource");
		String iOpCode =  request.getParameter("iOpCode");
		String iLoginNo = request.getParameter("iLoginNo");
		String iLoginPwd =  request.getParameter("iLoginPwd");
		String iPhoneNo =  request.getParameter("iPhoneNo");
		String iUserPwd =  request.getParameter("iUserPwd");
		
		String product_id =  request.getParameter("product_id");
		String startCardNo =  request.getParameter("startCardNo");
		String endCardNo =  request.getParameter("endCardNo");
		String cardSum =  request.getParameter("cardSum");
		String cardPrice =  request.getParameter("cardPrice");
		String cardValid =  request.getParameter("cardValid");
		String cardDiscount =  request.getParameter("cardDiscount");
		String cardRealPrice =  request.getParameter("cardRealPrice");
		
		String cardRealMoney =  request.getParameter("cardRealMoney");
		String product_account =  request.getParameter("product_account");
		
		String  inputParsm [] = new String[17];
		inputParsm[0] = iLoginAccept;
		inputParsm[1] = iChnSource;
		inputParsm[2] = iOpCode;
		inputParsm[3] = iLoginNo;
		inputParsm[4] = iLoginPwd;
		inputParsm[5] = iPhoneNo;
		inputParsm[6] = iUserPwd;
		
		inputParsm[7] = product_id;
		inputParsm[8] = startCardNo;
		inputParsm[9] = endCardNo;
		inputParsm[10] = cardSum;
		inputParsm[11] = cardPrice;
		inputParsm[12] = cardValid;
		inputParsm[13] = cardDiscount;
		inputParsm[14] = cardRealPrice;
		inputParsm[15] = cardRealMoney;
		inputParsm[16] = product_account;
		
		
		
		
		String retCode11 = "";
		String retMsg11 = "";
		
		String oActualNum="";
		String oActualTotal="";
		
try{		
%>
		<wtc:service name="sm225Cfm" routerKey="region" routerValue="<%=regionCode%>"
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
				<wtc:param value="<%=inputParsm[11]%>"/>
				<wtc:param value="<%=inputParsm[12]%>"/>
				<wtc:param value="<%=inputParsm[13]%>"/>
				<wtc:param value="<%=inputParsm[14]%>"/>
				<wtc:param value="<%=inputParsm[15]%>"/>
				<wtc:param value="<%=inputParsm[16]%>"/>
				
		</wtc:service>
		<wtc:array id="infoRet1" start="0" length="2"  scope="end"/>
		<wtc:array id="infoRet2" start="2" length="2"  scope="end"/>
		
			
	var infoArray = new Array();
	
<%
		retCode11 = retCode;
		retMsg11 = retMsg;
		if("000000".equals(retCode)){
			oActualNum = infoRet1[0][0];
			oActualTotal = infoRet1[0][1];
			for(int i=0;i<infoRet2.length;i++){
					
				%>
					infoArray[<%=i%>] = new Array();
					infoArray[<%=i%>][0] = "<%=infoRet2[i][0]%>";
					infoArray[<%=i%>][1] = "<%=infoRet2[i][1]%>";
				<%
				
			System.out.println("============ fm225Cfm.jsp ==========infoRet1["+i+"][0]" + infoRet2[i][0]);
			System.out.println("============ fm225Cfm.jsp ==========infoRet1["+i+"][1]" + infoRet2[i][1]);
		
			
			}
		}else{
		
		}
		}catch(Exception e){
			e.printStackTrace();
			retCode11 = "444444";
			retMsg11 = "服务未启动或不正常，请联系管理员！";
			%>
				var infoArray = new Array();
			<%
		}
%>
var response = new AJAXPacket();
response.data.add("retCode","<%=retCode11 %>");
response.data.add("retMsg","<%=retMsg11 %>");
response.data.add("infoArray",infoArray);
response.data.add("oActualNum","<%=oActualNum%>");
response.data.add("oActualTotal","<%=oActualTotal%>");
core.ajax.receivePacket(response);                                                                                                                                                                                                                                                                                                                                                                         