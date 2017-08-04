<%
/********************
 * version v2.0
 * gaopeng 2014/07/11 15:27:12 关于在CRM系统中开发电商线上订单查询页面和增加客户下行通知短信的需求
 * 开发商: si-tech
 ********************/
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		System.out.println("============ fm125Qry.jsp ==========");
		
		String regionCode = (String)session.getAttribute("regCode");
		
		String iLoginAccept = request.getParameter("iLoginAccept");
		String iChnSource = request.getParameter("iChnSource");
		String iOpCode =  request.getParameter("iOpCode");
		String iLoginNo = request.getParameter("iLoginNo");
		String iLoginPwd =  request.getParameter("iLoginPwd");
		String iPhoneNo =  request.getParameter("iPhoneNo");
		String iUserPwd =  request.getParameter("iUserPwd");
		String iOpNote =  request.getParameter("iOpNote");
		
		

		
		String  inputParsm [] = new String[10];
		inputParsm[0] = iLoginAccept;
		inputParsm[1] = iChnSource;
		inputParsm[2] = iOpCode;
		inputParsm[3] = iLoginNo;
		inputParsm[4] = iLoginPwd;
		inputParsm[5] = iPhoneNo;
		inputParsm[6] = iUserPwd;
		inputParsm[7] = iOpNote;
		
		
		
		String retCode11 = "";
		String retMsg11 = "";
		
try{		
%>
		<wtc:service name="sM125Qry" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="9">
				<wtc:param value=""/>
				<wtc:param value="<%=inputParsm[1]%>"/>
				<wtc:param value="<%=inputParsm[2]%>"/>
				<wtc:param value="<%=inputParsm[3]%>"/>
				<wtc:param value="<%=inputParsm[4]%>"/>
				<wtc:param value="<%=inputParsm[5]%>"/>
				<wtc:param value="<%=inputParsm[6]%>"/>
				<wtc:param value="<%=inputParsm[7]%>"/>
		</wtc:service>
		<wtc:array id="infoRet"  scope="end"/>
		
			
	var infoArray = new Array();;
<%
		retCode11 = retCode;
		retMsg11 = retMsg;
		if("000000".equals(retCode)){
			System.out.println("============ fm125Qry.jsp ==========" + infoRet.length);
			
			
			
			if(infoRet.length > 0 ){
				for(int i=0;i<infoRet.length;i++){
					System.out.println("============ fm125Qry.jsp ========== infoRet["+i+"][0]"+infoRet[i][0]);
					System.out.println("============ fm125Qry.jsp ========== infoRet["+i+"][1]"+infoRet[i][1]);
					System.out.println("============ fm125Qry.jsp ========== infoRet["+i+"][2]"+infoRet[i][2]);
					System.out.println("============ fm125Qry.jsp ========== infoRet["+i+"][3]"+infoRet[i][3]);
					System.out.println("============ fm125Qry.jsp ========== infoRet["+i+"][4]"+infoRet[i][4]);
					System.out.println("============ fm125Qry.jsp ========== infoRet["+i+"][5]"+infoRet[i][5]);
					System.out.println("============ fm125Qry.jsp ========== infoRet["+i+"][6]"+infoRet[i][6]);
					System.out.println("============ fm125Qry.jsp ========== infoRet["+i+"][7]"+infoRet[i][7]);
					System.out.println("============ fm125Qry.jsp ========== infoRet["+i+"][8]"+infoRet[i][8]);
				%>
					infoArray[<%=i%>] = new Array();
					
					infoArray[<%=i%>][0] = "<%=infoRet[i][0].trim()%>";
					infoArray[<%=i%>][1] = "<%=infoRet[i][1].trim()%>";
					infoArray[<%=i%>][2] = "<%=infoRet[i][2].trim()%>";
					infoArray[<%=i%>][3] = "<%=infoRet[i][3].trim()%>";
					infoArray[<%=i%>][4] = "<%=infoRet[i][4].trim()%>";
					infoArray[<%=i%>][5] = "<%=infoRet[i][5].trim()%>";
					infoArray[<%=i%>][6] = "<%=infoRet[i][6].trim()%>";
					infoArray[<%=i%>][7] = "<%=infoRet[i][7].trim()%>";
					infoArray[<%=i%>][8] = "<%=infoRet[i][8].trim()%>";
					
					
				<%
				}
			
			}
		}else{
			System.out.println("============ fm125Qry.jsp 失败==========");
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
core.ajax.receivePacket(response);                                                                                                                                                                                                                                                                                                                                                                         