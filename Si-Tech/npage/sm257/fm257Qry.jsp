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
		System.out.println("===gaopengSeeLog========= fm257Qry.jsp ==========");
		
		String regionCode = (String)session.getAttribute("regCode");
		
		String iLoginAccept = request.getParameter("iLoginAccept");
		String iChnSource = request.getParameter("iChnSource");
		String iOpCode =  request.getParameter("iOpCode");
		String iLoginNo = request.getParameter("iLoginNo");
		String iLoginPwd =  request.getParameter("iLoginPwd");
		String iPhoneNo =  request.getParameter("iPhoneNo");
		String iUserPwd =  request.getParameter("iUserPwd");
		String opAccept =  request.getParameter("opAccept");
		String iccid =  request.getParameter("iccid");
		
		String  inputParsm [] = new String[11];
		inputParsm[0] = opAccept;
		inputParsm[1] = iChnSource;
		inputParsm[2] = iOpCode;
		inputParsm[3] = iLoginNo;
		inputParsm[4] = iLoginPwd;
		inputParsm[5] = iPhoneNo;
		inputParsm[6] = iUserPwd;
		inputParsm[7] = iccid;
		
		
		
		
		
		String retCode11 = "";
		String retMsg11 = "";
		
		/*
			Trim(oOLD_CARD_NO);          久卡号开始 0
			Trim(oOLD_CARD_NO_end);    久卡号结束 1
			Trim(oNEW_CARD_NO);         新卡号开始2
			Trim(oNEW_CARD_NO_end);     新号结束3
			Trim(oUSE_FLAG);             是否已刮0-未刮1-已刮4
			Trim(oCONTACT_NAME);        联系人姓名/客户姓名5
			Trim(oCONTACT_PHONE);     联系人电话/客户电话6
			Trim(oID_ICCID);           证件号码7
			Trim(oCARD_STATIC);             有价卡状态，0:未邮寄,1:邮寄中,2:已完结8
			Trim(oREMOTE_ORDER_NUMBER);   '外省邮寄订单号  /投诉单号9
			Trim(ocard_money);           卡面值 10
			Trim(oREMOTE_POSTAGE);       邮费11

		
		*/
		
try{		
%>
		<wtc:service name="sm256Qry" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="15">
				<wtc:param value="<%=inputParsm[0]%>"/>
				<wtc:param value="<%=inputParsm[1]%>"/>
				<wtc:param value="<%=inputParsm[2]%>"/>
				<wtc:param value="<%=inputParsm[3]%>"/>
				<wtc:param value="<%=inputParsm[4]%>"/>
				<wtc:param value="<%=inputParsm[5]%>"/>
				<wtc:param value="<%=inputParsm[6]%>"/>
				<wtc:param value="<%=inputParsm[7]%>"/>
			
		</wtc:service>
		<wtc:array id="infoRet1"  scope="end"/>
		
			
	var infoArray = new Array();
	
<%
		retCode11 = retCode;
		retMsg11 = retMsg;
		if("000000".equals(retCode)){
			System.out.println("============ fm257Qry.jsp ==========" + infoRet1.length);
			
				for(int i=0;i<infoRet1.length;i++){
					
				%>
					infoArray[<%=i%>] = new Array();
					<%for(int j=0;j<infoRet1[i].length;j++){%>
					infoArray[<%=i%>][<%=j%>] = "<%=infoRet1[i][j]%>";
					
					<%
					System.out.println("============ fm257Qry.jsp ==========infoRet1["+i+"]["+j+"]" + infoRet1[i][j]);
					}
					%>
				<%
				}
			
		}else{
			System.out.println("============ fm257Qry.jsp 失败==========");
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