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
		System.out.println("===gaopengSeeLog========= fm257Cfm.jsp ==========111");
		
		String regionCode = (String)session.getAttribute("regCode");
		
		String iLoginAccept = request.getParameter("iLoginAccept");
		String iChnSource = request.getParameter("iChnSource");
		String iOpCode =  request.getParameter("iOpCode");
		String iLoginNo = request.getParameter("iLoginNo");
		String iLoginPwd =  request.getParameter("iLoginPwd");
		String iPhoneNo =  request.getParameter("iPhoneNo");
		String iUserPwd =  request.getParameter("iUserPwd");
		
		String postFee =  request.getParameter("postFee");
		
		String oldCardNoStr =  request.getParameter("oldCardNoStr");
		System.out.println("===gaopengSeeLog========= fm257Cfm.jsp ==========oldCardNoStr");
		String newCardNoStr =  request.getParameter("newCardNoStr");
		System.out.println("===gaopengSeeLog========= fm257Cfm.jsp ==========newCardNoStr");
		String newCardPriceStr =  request.getParameter("newCardPriceStr");
		System.out.println("===gaopengSeeLog========= fm257Cfm.jsp ==========newCardPriceStr");
		
		
		String  inputParsm [] = new String[17];
		inputParsm[0] = iLoginAccept;
		inputParsm[1] = iChnSource;
		inputParsm[2] = iOpCode;
		inputParsm[3] = iLoginNo;
		inputParsm[4] = iLoginPwd;
		inputParsm[5] = iPhoneNo;
		inputParsm[6] = iUserPwd;
		
		inputParsm[7] = postFee;
		
		String[] oldCardNoStrArr = oldCardNoStr.split(",");
		String[] newCardNoStrArr = newCardNoStr.split(",");
		String[] newCardPriceStrArr = newCardPriceStr.split(",");
		String opNote = "工号"+iLoginNo+"进行"+iOpCode+"操作";
		
		
		
		String retCode11 = "";
		String retMsg11 = "";
		
		
		
try{		
%>
		<wtc:service name="sm257Cfm" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="2">
				<wtc:param value="<%=inputParsm[0]%>"/>
				<wtc:param value="<%=inputParsm[1]%>"/>
				<wtc:param value="<%=inputParsm[2]%>"/>
				<wtc:param value="<%=inputParsm[3]%>"/>
				<wtc:param value="<%=inputParsm[4]%>"/>
				<wtc:param value="<%=inputParsm[5]%>"/>
				<wtc:param value="<%=inputParsm[6]%>"/>
				<wtc:param value="<%=opNote%>"/>
				<wtc:param value="<%=inputParsm[7]%>"/>
					
				<wtc:params value="<%=oldCardNoStrArr%>"/>
				<wtc:params value="<%=newCardNoStrArr%>"/>
				<wtc:params value="<%=newCardPriceStrArr%>"/>
				
				
		</wtc:service>
		<wtc:array id="infoRet1"  scope="end"/>
		
			
	var infoArray = new Array();
	
<%
		retCode11 = retCode;
		retMsg11 = retMsg;
		if("000000".equals(retCode)){
			
		
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

core.ajax.receivePacket(response);                                                                                                                                                                                                                                                                                                                                                                         