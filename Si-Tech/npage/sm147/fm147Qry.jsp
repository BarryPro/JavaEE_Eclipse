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
		System.out.println("===gaopengSeeLog========= fm147Qry.jsp ==========");
		
		String regionCode = (String)session.getAttribute("regCode");
		
		String iLoginAccept = request.getParameter("iLoginAccept");
		String iChnSource = request.getParameter("iChnSource");
		String iOpCode =  request.getParameter("iOpCode");
		String iLoginNo = request.getParameter("iLoginNo");
		String iLoginPwd =  request.getParameter("iLoginPwd");
		String iPhoneNo =  request.getParameter("iPhoneNo");
		String iUserPwd =  request.getParameter("iUserPwd");
		
		
		
		String  inputParsm [] = new String[10];
		inputParsm[0] = iLoginAccept;
		inputParsm[1] = iChnSource;
		inputParsm[2] = iOpCode;
		inputParsm[3] = iLoginNo;
		inputParsm[4] = iLoginPwd;
		inputParsm[5] = iPhoneNo;
		inputParsm[6] = iUserPwd;
		
		
		
		
		String retCode11 = "";
		String retMsg11 = "";
		int retLength = 0;
		
try{		
%>
		<wtc:service name="sM147Qry" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="9">
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
		System.out.println("========gaopengSeeLog==== fm147Qry.jsp ==========" + retCode11);
		System.out.println("========gaopengSeeLog==== fm147Qry.jsp ==========" + retMsg11);
		if("000000".equals(retCode)){
			System.out.println("======gaopengSeeLog===== fm147Qry.jsp ==========" + infoRet1.length);
			retLength = infoRet1.length;
				for(int i=0;i<infoRet1.length;i++){
					
				%>
					infoArray[<%=i%>] = new Array();
					infoArray[<%=i%>][0] = "<%=infoRet1[i][0].trim()%>";
					infoArray[<%=i%>][1] = "<%=infoRet1[i][1].trim()%>";
					infoArray[<%=i%>][2] = "<%=infoRet1[i][2].trim()%>";
					infoArray[<%=i%>][3] = "<%=infoRet1[i][3].trim()%>";
					infoArray[<%=i%>][4] = "<%=infoRet1[i][4].trim()%>";
					infoArray[<%=i%>][5] = "<%=infoRet1[i][5].trim()%>";
					infoArray[<%=i%>][6] = "<%=infoRet1[i][6].trim()%>";
					infoArray[<%=i%>][7] = "<%=infoRet1[i][7].trim()%>";
					infoArray[<%=i%>][8] = "<%=infoRet1[i][8].trim()%>";
					
				<%
			System.out.println("gaopengSeeLog==========fm147Qry.jsp===array===start");
			System.out.println("============ fm147Qry.jsp ==========infoRet1["+i+"][0].trim()" + infoRet1[i][0].trim());
			System.out.println("============ fm147Qry.jsp ==========infoRet1["+i+"][1].trim()" + infoRet1[i][1].trim());
			System.out.println("============ fm147Qry.jsp ==========infoRet1["+i+"][2].trim()" + infoRet1[i][2].trim());
			System.out.println("============ fm147Qry.jsp ==========infoRet1["+i+"][3].trim()" + infoRet1[i][3].trim());
			System.out.println("============ fm147Qry.jsp ==========infoRet1["+i+"][4].trim()" + infoRet1[i][4].trim());
			System.out.println("============ fm147Qry.jsp ==========infoRet1["+i+"][5].trim()" + infoRet1[i][5].trim());
			System.out.println("============ fm147Qry.jsp ==========infoRet1["+i+"][6].trim()" + infoRet1[i][6].trim());
			System.out.println("============ fm147Qry.jsp ==========infoRet1["+i+"][7].trim()" + infoRet1[i][7].trim());
			System.out.println("============ fm147Qry.jsp ==========infoRet1["+i+"][8].trim()" + infoRet1[i][8].trim());
			System.out.println("gaopengSeeLog==========fm147Qry.jsp===array===end");
				}
			
		}else{
			System.out.println("============ fm147Qry.jsp 失败==========");
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
response.data.add("retLength","<%=retLength%>");

core.ajax.receivePacket(response);                                                                                                                                                                                                                                                                                                                                                                         