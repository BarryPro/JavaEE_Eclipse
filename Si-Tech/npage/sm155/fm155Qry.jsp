<%
/********************
 * version v2.0
 * gaopeng 2014/08/11 9:23:46 关于优化客服CRM系统功能六月份第一次需求的函
 * 开发商: si-tech
 ********************/
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		System.out.println("===gaopengSeeLog========= fm155Qry.jsp ==========");
		
		String regionCode = (String)session.getAttribute("regCode");
		
		String iLoginAccept = request.getParameter("iLoginAccept");
		String iChnSource = request.getParameter("iChnSource");
		String iOpCode =  request.getParameter("iOpCode");
		String iLoginNo = request.getParameter("iLoginNo");
		String iLoginPwd =  request.getParameter("iLoginPwd");
		String iPhoneNo =  request.getParameter("iPhoneNo");
		String iUserPwd =  request.getParameter("iUserPwd");
		
		String startTime =  request.getParameter("startTime");
		String endTime =  request.getParameter("endTime");
		String selRegion =  request.getParameter("selRegion");
		if("$$".equals(selRegion)){
			selRegion = "";
		}
		
		String  inputParsm [] = new String[11];
		inputParsm[0] = iLoginAccept;
		inputParsm[1] = iChnSource;
		inputParsm[2] = iOpCode;
		inputParsm[3] = iLoginNo;
		inputParsm[4] = iLoginPwd;
		inputParsm[5] = iPhoneNo;
		inputParsm[6] = iUserPwd;
		inputParsm[7] = "";
		inputParsm[8] = startTime;
		inputParsm[9] = endTime;
		inputParsm[10] = selRegion;
		
		
		
		String retCode11 = "";
		String retMsg11 = "";
		
try{		
%>
		<wtc:service name="sm155Qry" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="4">
				<wtc:param value=",%=inputParsm[0]%>"/>
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
		<wtc:array id="infoRet1"  scope="end"/>
		
			
	var infoArray = new Array();
	
<%
		retCode11 = retCode;
		retMsg11 = retMsg;
		if("000000".equals(retCode)){
			System.out.println("============ fm155Qry.jsp ==========" + infoRet1.length);
			
				for(int i=0;i<infoRet1.length;i++){
					
				%>
					infoArray[<%=i%>] = new Array();
					infoArray[<%=i%>][0] = "<%=infoRet1[i][0].trim()%>";
					infoArray[<%=i%>][1] = "<%=infoRet1[i][1].trim()%>";
					infoArray[<%=i%>][2] = "<%=infoRet1[i][2].trim()%>";
					infoArray[<%=i%>][3] = "<%=infoRet1[i][3].trim()%>";
					
				<%
				
			System.out.println("============ fm155Qry.jsp ==========infoRet1["+i+"][0].trim()" + infoRet1[i][0].trim());
			System.out.println("============ fm155Qry.jsp ==========infoRet1["+i+"][1].trim()" + infoRet1[i][1].trim());
			System.out.println("============ fm155Qry.jsp ==========infoRet1["+i+"][2].trim()" + infoRet1[i][2].trim());
			System.out.println("============ fm155Qry.jsp ==========infoRet1["+i+"][3].trim()" + infoRet1[i][3].trim());
		
				}
			
		}else{
			System.out.println("============ fm155Qry.jsp 失败==========");
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