<%
/********************
 * version v2.0
 * gaopeng 2014/03/10 10:48:14 关于在统一门户建设我省4G专区的需求
 * 开发商: si-tech
 ********************/
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		System.out.println("============ fm110Qry_1.jsp ==========");
		
		String regionCode = (String)session.getAttribute("regCode");
		
		String iLoginAccept = request.getParameter("iLoginAccept");
		String iChnSource = request.getParameter("iChnSource");
		String iOpCode =  request.getParameter("iOpCode");
		String iLoginNo = request.getParameter("iLoginNo");
		String iLoginPwd =  request.getParameter("iLoginPwd");
		String iPhoneNo =  request.getParameter("iPhoneNo");
		String iUserPwd =  request.getParameter("iUserPwd");
		
		String  inputParsm [] = new String[7];
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
		<wtc:service name="sm349BillQry" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="7">
				<wtc:param value="<%=inputParsm[0]%>"/>
				<wtc:param value="<%=inputParsm[1]%>"/>
				<wtc:param value="<%=inputParsm[2]%>"/>
				<wtc:param value="<%=inputParsm[3]%>"/>
				<wtc:param value="<%=inputParsm[4]%>"/>
				<wtc:param value="<%=inputParsm[5]%>"/>
				<wtc:param value="<%=inputParsm[6]%>"/>
				
		</wtc:service>
		<wtc:array id="ret" scope="end"/>
		var resultmsg = new Array();
<%
		retCode11 = retCode;
		retMsg11 = retMsg;
		if("000000".equals(retCode)){
			if(ret.length > 0 ){
				for(int i=0;i<ret.length;i++){
				%>
					resultmsg[<%=i%>]=new Array();
					resultmsg[<%=i%>][0] = "<%=ret[i][0].trim()%>";
					resultmsg[<%=i%>][1] = "<%=ret[i][1].trim()%>";
					resultmsg[<%=i%>][2] = "<%=ret[i][2].trim()%>";
					resultmsg[<%=i%>][3] = "<%=ret[i][3].trim()%>";
					resultmsg[<%=i%>][4] = "<%=ret[i][4].trim()%>";
					resultmsg[<%=i%>][5] = "<%=ret[i][5].trim()%>";
					resultmsg[<%=i%>][6] = "<%=ret[i][6].trim()%>";
				<%
				}
			
			}
		}else{
			System.out.println("============ fm110Qry_1.jsp 失败==========");
		}
		}catch(Exception e){
			retCode11 = "444444";
			retMsg11 = "服务未启动或不正常，请联系管理员！";
			%>
				var resultmsg = new Array();
			<%
		}
%>
var response = new AJAXPacket();
response.data.add("retCode","<%=retCode11 %>");
response.data.add("retMsg","<%=retMsg11 %>");
response.data.add("retArray",resultmsg);
core.ajax.receivePacket(response);