<%
/********************
 * version v2.0
 * gaopeng 2016/5/30 14:42:35 转售业务查询
 * 开发商: si-tech
 ********************/
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		System.out.println("===gaopengSeeLog========= fm384Qry.jsp ==========");
		
		String regionCode = (String)session.getAttribute("regCode");
		
		String iLoginAccept = request.getParameter("iLoginAccept");
		String iChnSource = request.getParameter("iChnSource");
		String iOpCode =  request.getParameter("iOpCode");
		String iLoginNo = request.getParameter("iLoginNo");
		String iLoginPwd =  request.getParameter("iLoginPwd");
		String iPhoneNo =  request.getParameter("iPhoneNo");
		
		
		String  inputParsm [] = new String[11];
		inputParsm[0] = iLoginAccept;
		inputParsm[1] = iChnSource;
		inputParsm[2] = iOpCode;
		inputParsm[3] = iLoginNo;
		inputParsm[4] = iLoginPwd;
		inputParsm[5] = iPhoneNo;
		inputParsm[6] = "";
		
		
		
		
		
		String retCode11 = "";
		String retMsg11 = "";
		
try{		
%>
		<wtc:service name="sm384Qry" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="10">
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
			System.out.println("============ fm384Qry.jsp ==========" + infoRet1.length);
			
				for(int i=0;i<infoRet1.length;i++){
					
				%>
					infoArray[<%=i%>] = new Array();
					infoArray[<%=i%>][0] = "<%=infoRet1[i][0]%>";
					infoArray[<%=i%>][1] = "<%=infoRet1[i][1]%>";
					infoArray[<%=i%>][2] = "<%=infoRet1[i][2]%>";
					infoArray[<%=i%>][3] = "<%=infoRet1[i][3]%>";
					infoArray[<%=i%>][4] = "<%=infoRet1[i][4]%>";
					infoArray[<%=i%>][5] = "<%=infoRet1[i][5]%>";
					infoArray[<%=i%>][6] = "<%=infoRet1[i][6]%>";
					infoArray[<%=i%>][7] = "<%=infoRet1[i][7]%>";
					infoArray[<%=i%>][8] = "<%=infoRet1[i][8]%>";
					infoArray[<%=i%>][9] = "<%=infoRet1[i][9]%>";
					
					
				<%
				
			System.out.println("============ fm384Qry.jsp ==========infoRet1["+i+"][0]" + infoRet1[i][0]);
			System.out.println("============ fm384Qry.jsp ==========infoRet1["+i+"][1]" + infoRet1[i][1]);
			System.out.println("============ fm384Qry.jsp ==========infoRet1["+i+"][2]" + infoRet1[i][2]);
			System.out.println("============ fm384Qry.jsp ==========infoRet1["+i+"][3]" + infoRet1[i][3]);
			System.out.println("============ fm384Qry.jsp ==========infoRet1["+i+"][4]" + infoRet1[i][4]);
			System.out.println("============ fm384Qry.jsp ==========infoRet1["+i+"][5]" + infoRet1[i][5]);
			System.out.println("============ fm384Qry.jsp ==========infoRet1["+i+"][6]" + infoRet1[i][6]);
			System.out.println("============ fm384Qry.jsp ==========infoRet1["+i+"][7]" + infoRet1[i][7]);
			System.out.println("============ fm384Qry.jsp ==========infoRet1["+i+"][8]" + infoRet1[i][8]);
			System.out.println("============ fm384Qry.jsp ==========infoRet1["+i+"][9]" + infoRet1[i][9]);
		
			
				}
			
		}else{
			System.out.println("============ fm384Qry.jsp 失败==========");
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