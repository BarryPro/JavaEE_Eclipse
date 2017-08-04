<%
/********************
 * version v2.0
 * gaopeng 2015/02/11 9:50:29 
 * 开发商: si-tech
 ********************/
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		System.out.println("===gaopengSeeLog========= fm395Qry.jsp ==========");
		
		String regionCode = (String)session.getAttribute("regCode");
		
		String iLoginAccept = request.getParameter("iLoginAccept");
		String iChnSource = request.getParameter("iChnSource");
		String iOpCode =  request.getParameter("iOpCode");
		String iLoginNo = request.getParameter("iLoginNo");
		String iLoginPwd =  request.getParameter("iLoginPwd");
		String iPhoneNo =  request.getParameter("iPhoneNo");
		String iUserPwd =  request.getParameter("iUserPwd");
		
		String  inputParsm [] = new String[11];
		inputParsm[0] = iLoginAccept;
		inputParsm[1] = iChnSource;
		inputParsm[2] = iOpCode;
		inputParsm[3] = iLoginNo;
		inputParsm[4] = iLoginPwd;
		inputParsm[5] = iPhoneNo;
		inputParsm[6] = iUserPwd;
		
		
		
		
		
		String retCode11 = "";
		String retMsg11 = "";
		
try{		
%>
		<wtc:service name="sm395Qry" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="5">
				<wtc:param value="<%=inputParsm[0]%>"/>
				<wtc:param value="<%=inputParsm[1]%>"/>
				<wtc:param value="<%=inputParsm[2]%>"/>
				<wtc:param value="<%=inputParsm[3]%>"/>
				<wtc:param value="<%=inputParsm[4]%>"/>
				<wtc:param value="<%=inputParsm[5]%>"/>
				<wtc:param value="<%=inputParsm[6]%>"/>
		</wtc:service>
		<wtc:array id="infoRet1"  scope="end"/>
		
			
	var infoArray = new Array();
	
<%
		retCode11 = retCode;
		retMsg11 = retMsg;
		if("000000".equals(retCode)){
			System.out.println("============ fm395Qry.jsp ==========" + infoRet1.length);
			
				for(int i=0;i<infoRet1.length;i++){
					
				%>
					infoArray[<%=i%>] = new Array();
					infoArray[<%=i%>][0] = "<%=infoRet1[i][0]%>";
					infoArray[<%=i%>][1] = "<%=infoRet1[i][1]%>";
					infoArray[<%=i%>][2] = "<%=infoRet1[i][2]%>";
					infoArray[<%=i%>][3] = "<%=infoRet1[i][3]%>";
					infoArray[<%=i%>][4] = "<%=infoRet1[i][4]%>";
					
					
				<%
				
			System.out.println("============ fm395Qry.jsp ==========infoRet1["+i+"][0]" + infoRet1[i][0]);
			System.out.println("============ fm395Qry.jsp ==========infoRet1["+i+"][1]" + infoRet1[i][1]);
			System.out.println("============ fm395Qry.jsp ==========infoRet1["+i+"][2]" + infoRet1[i][2]);
			System.out.println("============ fm395Qry.jsp ==========infoRet1["+i+"][3]" + infoRet1[i][3]);
			System.out.println("============ fm395Qry.jsp ==========infoRet1["+i+"][4]" + infoRet1[i][4]);
		
			
				}
			
		}else{
			System.out.println("============ fm395Qry.jsp 失败==========");
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