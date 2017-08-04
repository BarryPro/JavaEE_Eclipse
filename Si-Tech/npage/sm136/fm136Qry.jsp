<%
/********************
 * version v2.0
 * gaopeng 2014/08/08 10:59:49 R_CMI_HLJ_xueyz_2014_1666493@关于实现融合通信联合集团的需求
 * 开发商: si-tech
 ********************/
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		System.out.println("===gaopengSeeLog========= fm136Qry.jsp ==========");
		
		String regionCode = (String)session.getAttribute("regCode");
		
		String iLoginAccept = request.getParameter("iLoginAccept");
		String iChnSource = request.getParameter("iChnSource");
		String iOpCode =  request.getParameter("iOpCode");
		String iLoginNo = request.getParameter("iLoginNo");
		String iLoginPwd =  request.getParameter("iLoginPwd");
		String iPhoneNo =  request.getParameter("iPhoneNo");
		String iUserPwd =  request.getParameter("iUserPwd");
		
		String mainUnitCode =  request.getParameter("mainUnitCode");
		String otherUnitCode =  request.getParameter("otherUnitCode");
		
		String mainUnitCode_ID =  request.getParameter("mainUnitCode_ID");
		String otherUnitCode_ID =  request.getParameter("otherUnitCode_ID");
		
				
			
		
		String opType =  request.getParameter("opType");
		String serviceName = "";
		int outNumI = 0;
		if("0".equals(opType) || "1".equals(opType)){
			serviceName = "sm136Cfm";
			outNumI = 2;
		}else if("2".equals(opType)){
			serviceName = "sm136Qry";
			outNumI = 4;
		}
		
		String  inputParsm [] = new String[12];
		inputParsm[0] = "";
		inputParsm[1] = iChnSource;
		inputParsm[2] = iOpCode;
		inputParsm[3] = iLoginNo;
		inputParsm[4] = iLoginPwd;
		inputParsm[5] = iPhoneNo;
		inputParsm[6] = iUserPwd;
		inputParsm[7] = opType;
		inputParsm[8] = mainUnitCode;
		inputParsm[9] = otherUnitCode;
		
		inputParsm[10] = mainUnitCode_ID;
		inputParsm[11] = otherUnitCode_ID;
		
		
		
		
		String retCode11 = "";
		String retMsg11 = "";
		
try{		
	String outNumB = outNumI+"";
%>
		<wtc:service name="<%=serviceName%>" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="<%=outNumB%>">
				<wtc:param value="<%=inputParsm[0]%>"/>
				<wtc:param value="<%=inputParsm[1]%>"/>
				<wtc:param value="<%=inputParsm[2]%>"/>
				<wtc:param value="<%=inputParsm[3]%>"/>
				<wtc:param value="<%=inputParsm[4]%>"/>
				<wtc:param value="<%=inputParsm[5]%>"/>
				<wtc:param value="<%=inputParsm[6]%>"/>
				<%
				if("0".equals(opType) || "1".equals(opType)){
				%>
				<wtc:param value="<%=inputParsm[7]%>"/>
				<%
				}
				%>
				<wtc:param value="<%=inputParsm[8]%>"/>
				<wtc:param value="<%=inputParsm[9]%>"/>
					
				<wtc:param value="<%=inputParsm[10]%>"/>
				<wtc:param value="<%=inputParsm[11]%>"/>		
					
		</wtc:service>
		<wtc:array id="infoRet1"  scope="end"/>
		
			
	var infoArray = new Array();
	
<%
		retCode11 = retCode;
		retMsg11 = retMsg;
		if("000000".equals(retCode)){
			System.out.println("============ fm136Qry.jsp ==========" + infoRet1.length);
			
				for(int i=0;i<infoRet1.length;i++){
					
				%>
					infoArray[<%=i%>] = new Array();
					<% for(int j=0;j<outNumI;j++){%>
						infoArray[<%=i%>][<%=j%>] = "<%=infoRet1[i][j].trim()%>";
				<%
					}
					for(int j=0;j<outNumI;j++){
			System.out.println("============ fm136Qry.jsp ==========infoRet1["+i+"]["+j+"].trim()" + infoRet1[i][j].trim());
					}
				}
			
		}else{
			System.out.println("============ fm136Qry.jsp 失败==========");
		}
		}catch(Exception e){
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
response.data.add("opType","<%=opType%>");

core.ajax.receivePacket(response);                                                                                                                                                                                                                                                                                                                                                                         