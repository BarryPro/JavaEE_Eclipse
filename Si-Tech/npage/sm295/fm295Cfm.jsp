<%
/********************
 * version v2.0
 * gaopeng 2015/02/11 9:50:29 关于11月份集团客户部CRM、BOSS和经分系统需求的函-7-行业应用流量卡BOSS系统需求
 * 开发商: si-tech
 ********************/
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		System.out.println("===gaopengSeeLog========= fm295Cfm.jsp ==========");
		
		System.out.println("gaopengSeeLog===m295====");
		
		String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));
		String workNo = (String)session.getAttribute("workNo");
		String password = (String) session.getAttribute("password");
		String opCode = request.getParameter("opCode");
		String groupId = (String)session.getAttribute("groupId");
		String regionCode = (String)session.getAttribute("regCode");
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAccept" />
<%		
		String upFileName = request.getParameter("upFileName");
		String radioFlag = request.getParameter("radioFlag");
		String checkGroupIds = request.getParameter("checkGroupIds");
		
		String giftNos = request.getParameter("giftNos");
		
		/**
		strcpy(iLoginAccept,	input_parms[0]);
		strcpy(iChnSource,		input_parms[1]);
		strcpy(iOpCode,			input_parms[2]);
		strcpy(iLoginNo,		input_parms[3]);
		strcpy(iLoginPwd,		input_parms[4]);
		strcpy(iPhoneNo,		input_parms[5]);
		strcpy(iUserPwd,		input_parms[6]);
		
		strcpy(iOpType,			input_parms[7]);  // A:增 U:改 D:删 M:批量导入 //
		strcpy(iFilePath,		input_parms[8]); 
		strcpy(iGroupIdMult,	input_parms[9]);  ///多个用|分隔//
		strcpy(iOpNote,			input_parms[10]);

		*/
		String  inputParsm [] = new String[17];
		inputParsm[0] = sysAccept;
		inputParsm[1] = "01";
		inputParsm[2] = opCode;
		inputParsm[3] = workNo;
		inputParsm[4] = password;
		inputParsm[5] = phoneNo;
		inputParsm[6] = "";
		
		inputParsm[7] = "simple".equals(radioFlag)?"M":"D";
		inputParsm[8] = upFileName;
		inputParsm[9] = checkGroupIds;
		inputParsm[10] = "工号:"+workNo+"执行"+opCode+"的"+inputParsm[7]+"操作";
		inputParsm[11] = giftNos;
		
		String retCode11 = "";
		String retMsg11 = "";
		
		int errorNum = 0;
		
try{		
%>
		<wtc:service name="sm295Cfm" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="3">
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
				<wtc:param value="<%=inputParsm[11]%>"/>
				<wtc:param value="<%=inputParsm[10]%>"/>
				
		</wtc:service>
		<wtc:array id="infoRet1" start="0" length="1"  scope="end"/>
		<wtc:array id="infoRet2" start="1" length="2"  scope="end"/>

	
	var infoArray = new Array();
	
<%
		retCode11 = retCode;
		retMsg11 = retMsg;
		if("000000".equals(retCode) && infoRet1.length > 0){
			errorNum = Integer.parseInt(infoRet1[0][0]);
			System.out.println("gaopengSeeLogm295====m295====errorNum====="+errorNum);
		}if("000000".equals(retCode) && infoRet2.length > 0){
			for(int i=0;i<infoRet2.length;i++){
				%>
				infoArray[<%=i%>] = new Array();
				<%
				for(int j=0;j<infoRet2[i].length;j++){
				%>
				infoArray[<%=i%>][<%=j%>] = "<%=infoRet2[i][j]%>";
				<%
				System.out.println("gaopengSeeLogm295====m295====infoArray["+i+"]["+j+"]====="+infoRet2[i][j]);
				}
				
			}
			
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
response.data.add("errorNum","<%=errorNum %>");
response.data.add("infoArray",infoArray);

core.ajax.receivePacket(response);                                                                                                                                                                                                                                                                                                                                                                         