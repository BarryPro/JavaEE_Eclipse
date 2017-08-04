<%
/********************
 * version v2.0
 * gaopeng 2014/08/11 9:23:46 R_CMI_HLJ_guanjg_2015_2094748@关于物联网专网专号业务功能优化的函
 * 开发商: si-tech
 ********************/
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		System.out.println("===gaopengSeeLog========= fm238Qry.jsp ==========");
		
		String regionCode = (String)session.getAttribute("regCode");
		
		String iLoginAccept = (String)request.getParameter("iLoginAccept");
		String iChnSource = (String)request.getParameter("iChnSource");
		String iOpCode =  (String)request.getParameter("iOpCode");
		String iLoginNo = (String)request.getParameter("iLoginNo");
		String iLoginPwd =  (String)request.getParameter("iLoginPwd");
		String iPhoneNo =  (String)request.getParameter("iPhoneNo");
		String iUserPwd =  (String)request.getParameter("iUserPwd");
		String startCust =  (String)request.getParameter("startCust");
		String endCust =  (String)request.getParameter("endCust");
		String unitCode =  (String)request.getParameter("unitCode");
		String selType =  (String)request.getParameter("selType");
		
		String startphoneNo =  (String)request.getParameter("startphoneNo");
		String endphoneNo =  (String)request.getParameter("endphoneNo");
		String accepts =  (String)request.getParameter("accepts");
		
		if(iPhoneNo != null && !"".equals(iPhoneNo)){
			String iPhoneNoHead10648 = iPhoneNo.substring(0,5);
			String iPhoneNoHead147 = iPhoneNo.substring(0,3);
			
			System.out.println("gaopengSeeLogm239----------进来了-------iPhoneNo="+iPhoneNo);
			
			/*
			if("10648".equals(iPhoneNoHead10648)){
				iPhoneNo = iPhoneNo.replaceFirst("10648","205");
			}
			else if("147".equals(iPhoneNoHead147)){
				iPhoneNo = iPhoneNo.replaceFirst("147","206");
			}
			*/
			%>
			
			<wtc:service name="sm317Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode_sTSInfoBack" retmsg="retMessage_sTSInfoBack" outnum="1"> 
		    <wtc:param value=""/>
				<wtc:param value="01"/>
				<wtc:param value="<%=iOpCode%>"/>
				<wtc:param value="<%=iLoginNo%>"/>
				<wtc:param value="<%=iLoginPwd%>"/>
				<wtc:param value="<%=iPhoneNo%>"/>
			  <wtc:param value=""/>
		  </wtc:service>  
		  <wtc:array id="result_sTSInfoBack"  scope="end"/>
	
		<%
		System.out.println("gaopengSeeLogm239-----------------retCode_sTSInfoBack="+retCode_sTSInfoBack);
		if(result_sTSInfoBack.length > 0){
			iPhoneNo = result_sTSInfoBack[0][0];
			System.out.println("gaopengSeeLogm239-----------------iPhoneNo="+iPhoneNo);
		}
		%>
		
			<%
			
		}
		
		if(startphoneNo != null && !"".equals(startphoneNo)){
			String iPhoneNoHead10648 = startphoneNo.substring(0,5);
			String iPhoneNoHead147 = startphoneNo.substring(0,3);
			/*
			if("10648".equals(iPhoneNoHead10648)){
				startphoneNo = startphoneNo.replaceFirst("10648","205");
			}
			else if("147".equals(iPhoneNoHead147)){
				startphoneNo = startphoneNo.replaceFirst("147","206");
			}
			*/
			%>
			<wtc:service name="sm317Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode_sTSInfoBack2" retmsg="retMessage_sTSInfoBack2" outnum="1"> 
		    <wtc:param value=""/>
				<wtc:param value="01"/>
				<wtc:param value="<%=iOpCode%>"/>
				<wtc:param value="<%=iLoginNo%>"/>
				<wtc:param value="<%=iLoginPwd%>"/>
				<wtc:param value="<%=startphoneNo%>"/>
			  <wtc:param value=""/>
		  </wtc:service>  
		  <wtc:array id="result_sTSInfoBack2"  scope="end"/>
	
		<%
		if(result_sTSInfoBack2.length > 0){
			startphoneNo = result_sTSInfoBack2[0][0];
			System.out.println("gaopengSeeLogm239-----------------startphoneNo="+startphoneNo);
		}
		%>
			<%
			
		}
		
		if(endphoneNo != null && !"".equals(endphoneNo)){
			String iPhoneNoHead10648 = endphoneNo.substring(0,5);
			String iPhoneNoHead147 = endphoneNo.substring(0,3);
			/*
			if("10648".equals(iPhoneNoHead10648)){
				endphoneNo = endphoneNo.replaceFirst("10648","205");
			}
			else if("147".equals(iPhoneNoHead147)){
				endphoneNo = endphoneNo.replaceFirst("147","206");
			}
			*/
			%>
			<wtc:service name="sm317Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode_sTSInfoBack3" retmsg="retMessage_sTSInfoBack3" outnum="1"> 
		    <wtc:param value=""/>
				<wtc:param value="01"/>
				<wtc:param value="<%=iOpCode%>"/>
				<wtc:param value="<%=iLoginNo%>"/>
				<wtc:param value="<%=iLoginPwd%>"/>
				<wtc:param value="<%=endphoneNo%>"/>
			  <wtc:param value=""/>
		  </wtc:service>  
		  <wtc:array id="result_sTSInfoBack3"  scope="end"/>
	
		<%
		if(result_sTSInfoBack3.length > 0){
			endphoneNo = result_sTSInfoBack3[0][0];
			System.out.println("gaopengSeeLogm239-----------------endphoneNo="+endphoneNo);
		}
		%>
			<%
			
		}
		
		/*
		if(iPhoneNo != null && !"".equals(iPhoneNo)){
			String iPhoneNoHead10648 = iPhoneNo.substring(0,5);
			String iPhoneNoHead147 = iPhoneNo.substring(0,3);
			
			if("10648".equals(iPhoneNoHead10648)){
				iPhoneNo = iPhoneNo.replaceFirst("10648","205");
			}
			else if("147".equals(iPhoneNoHead147)){
				iPhoneNo = iPhoneNo.replaceFirst("147","206");
			}
			
		}
		
		if(startphoneNo != null && !"".equals(startphoneNo)){
			String iPhoneNoHead10648 = startphoneNo.substring(0,5);
			String iPhoneNoHead147 = startphoneNo.substring(0,3);
			
			if("10648".equals(iPhoneNoHead10648)){
				startphoneNo = startphoneNo.replaceFirst("10648","205");
			}
			else if("147".equals(iPhoneNoHead147)){
				startphoneNo = startphoneNo.replaceFirst("147","206");
			}
			
		}
		
		if(endphoneNo != null && !"".equals(endphoneNo)){
			String iPhoneNoHead10648 = endphoneNo.substring(0,5);
			String iPhoneNoHead147 = endphoneNo.substring(0,3);
			
			if("10648".equals(iPhoneNoHead10648)){
				endphoneNo = endphoneNo.replaceFirst("10648","205");
			}
			else if("147".equals(iPhoneNoHead147)){
				endphoneNo = endphoneNo.replaceFirst("147","206");
			}
			
		}
		*/
		
		String  inputParsm [] = new String[13];
		inputParsm[0] = iLoginAccept;
		inputParsm[1] = iChnSource;
		inputParsm[2] = iOpCode;
		inputParsm[3] = iLoginNo;
		inputParsm[4] = iLoginPwd;
		inputParsm[5] = iPhoneNo;
		inputParsm[6] = iUserPwd;
		inputParsm[7] = selType;
		inputParsm[8] = unitCode;
		inputParsm[9] = startCust;
		inputParsm[10] = endCust;
		inputParsm[11] = startphoneNo;
		inputParsm[12] = endphoneNo;
		
		/*出参个数*/
		String outNum = "1";
		
		if("0".equals(selType)){
			outNum = "10";
		}else if("1".equals(selType)){
			outNum = "11";
		}else if("2".equals(selType)){
			outNum = "12";
		}else if("3".equals(selType)){
			outNum = "12";
		}
		
		
		
		String retCode11 = "";
		String retMsg11 = "";
		
try{		
%>
		<wtc:service name="sm238Cfm" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="<%=outNum%>">
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
				<wtc:param value="<%=accepts%>"/>
		</wtc:service>
		<wtc:array id="infoRet1"  scope="end"/>
		
			
	var infoArray = new Array();
	
<%
		retCode11 = retCode;
		retMsg11 = retMsg;
		if("000000".equals(retCode)){
			System.out.println("============ fm238Qry.jsp ==========" + infoRet1.length);
			
				for(int i=0;i<infoRet1.length;i++){
					
				%>
					infoArray[<%=i%>] = new Array();
					<%
					for(int j=0;j<infoRet1[i].length;j++){
					%>
						infoArray[<%=i%>][<%=j%>] = "<%=infoRet1[i][j]%>";
					
				<%
				
			System.out.println("============ fm238Qry.jsp ==========infoRet1["+i+"]["+j+"]" + infoRet1[i][j]+"=================");
					}
				}
			
		}else{
			System.out.println("============ fm238Qry.jsp 失败==========");
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
response.data.add("selType","<%=selType%>");

core.ajax.receivePacket(response);                                                                                                                                                                                                                                                                                                                                                                         