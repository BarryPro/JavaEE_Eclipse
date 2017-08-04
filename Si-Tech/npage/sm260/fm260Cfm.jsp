<%
/********************
 * version v2.0
 * gaopeng R_CMI_HLJ_guanjg_2015_2164784@关于和交通-违章查询业务BOSS与网站系统开发需求的函-集团客户部分
 * 开发商: si-tech
 ********************/
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		System.out.println("===gaopengSeeLog========= fm260Cfm.jsp ==========");
		
		String regionCode = (String)session.getAttribute("regCode");
		
		String iLoginAccept = request.getParameter("iLoginAccept");
		String iChnSource = request.getParameter("iChnSource");
		String iOpCode =  request.getParameter("iOpCode");
		String iLoginNo = request.getParameter("iLoginNo");
		String iLoginPwd =  request.getParameter("iLoginPwd");
		String iPhoneNo =  request.getParameter("iPhoneNo");
		String iUserPwd =  request.getParameter("iUserPwd");
		
		String carPStr =  request.getParameter("carPStr");
		String carJStr =  request.getParameter("carJStr");
		String carFStr =  request.getParameter("carFStr");
		String carNoType =  request.getParameter("carNoType");
		
		String selFlag =  request.getParameter("selFlag");
		String ipAddr =  request.getParameter("ipAddr");
		String product_id =  request.getParameter("product_id");
		String unitCode =  request.getParameter("unitCode");
		
		String[] carPStrArr =  carPStr.split(",");
		String[] carJStrArr =  carJStr.split(",");
		String[] carFStrArr =  carFStr.split(",");
		String[] carNoTypeArr =  carNoType.split(",");
		
		
		String  inputParsm [] = new String[18];
		inputParsm[0] = iLoginAccept;
		inputParsm[1] = iChnSource;
		inputParsm[2] = iOpCode;
		inputParsm[3] = iLoginNo;
		inputParsm[4] = iLoginPwd;
		inputParsm[5] = iPhoneNo;
		inputParsm[6] = iUserPwd;
		
		inputParsm[7] = "";
		inputParsm[8] = "";
		inputParsm[9] = "";
		
		inputParsm[10] = selFlag;
		inputParsm[11] = ipAddr;
		inputParsm[12] = product_id;
		inputParsm[13] = unitCode;
		
		
		String retCode11 = "";
		String retMsg11 = "";
		
		String oActualNum="";
		String oActualTotal="";
		
try{		
%>
		<wtc:service name="sm260Cfm" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="2">
				<wtc:param value="<%=inputParsm[0]%>"/>
				<wtc:param value="<%=inputParsm[1]%>"/>
				<wtc:param value="<%=inputParsm[2]%>"/>
				<wtc:param value="<%=inputParsm[3]%>"/>
				<wtc:param value="<%=inputParsm[4]%>"/>
				<wtc:param value="<%=inputParsm[5]%>"/>
				<wtc:param value="<%=inputParsm[6]%>"/>
				<wtc:params value="<%=carPStrArr%>"/>
				<wtc:params value="<%=carJStrArr%>"/>
				<wtc:params value="<%=carFStrArr%>"/>
				<wtc:params value="<%=carNoTypeArr%>"/>
				<wtc:param value="<%=inputParsm[10]%>"/>
				<wtc:param value="<%=inputParsm[11]%>"/>
				<wtc:param value="<%=inputParsm[12]%>"/>
				<wtc:param value="<%=inputParsm[13]%>"/>

				
		</wtc:service>
		<wtc:array id="infoRet1" start="0" length="2"  scope="end"/>
		
		
			
	var infoArray = new Array();
	
<%
		retCode11 = retCode;
		retMsg11 = retMsg;
		if("000000".equals(retCode)){
			if(infoRet1.length > 0 && "000000".equals(retCode)){
				for(int i=0;i<infoRet1.length;i++){
					%>
						infoArray[<%=i%>] = new Array();
						<%
							for(int j=0;j<infoRet1[i].length;j++){
								%>
								infoArray[<%=i%>][<%=j%>] = "<%=infoRet1[i][j]%>";
								<%
								System.out.println("gaopengSeeLog====sm263====infoArray["+i+"]["+j+"]====="+infoRet1[i][j]);
							}
						%>
						
					<%
				}
			}
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
response.data.add("infoArray",infoArray);

core.ajax.receivePacket(response);                                                                                                                                                                                                                                                                                                                                                                         