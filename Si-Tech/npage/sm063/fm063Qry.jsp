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
		System.out.println("============ fm063Qry.jsp ==========");
		
		String regionCode = (String)session.getAttribute("regCode");
		
		String iLoginAccept = request.getParameter("iLoginAccept");
		String iChnSource = request.getParameter("iChnSource");
		String iOpCode =  request.getParameter("iOpCode");
		String iLoginNo = request.getParameter("iLoginNo");
		String iLoginPwd =  request.getParameter("iLoginPwd");
		String iPhoneNo =  request.getParameter("iPhoneNo");
		String iUserPwd =  request.getParameter("iUserPwd");
		String iOpNote = request.getParameter("iOpNote");
		String iBeginTime =  request.getParameter("iBeginTime");
		String iEndTime =  request.getParameter("iEndTime");
		String iRegionCode =  request.getParameter("iRegionCode");
		

		
		String  inputParsm [] = new String[11];
		inputParsm[0] = iLoginAccept;
		inputParsm[1] = iChnSource;
		inputParsm[2] = iOpCode;
		inputParsm[3] = iLoginNo;
		inputParsm[4] = iLoginPwd;
		inputParsm[5] = iPhoneNo;
		inputParsm[6] = iUserPwd;
		inputParsm[7] = iOpNote;
		inputParsm[8] = iBeginTime;
		inputParsm[9] = iEndTime;
		inputParsm[10] = iRegionCode;
		
		String retCode11 = "";
		String retMsg11 = "";
		
try{		
%>
		<wtc:service name="sm063Qry" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="5">
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
		</wtc:service>
		<wtc:array id="ret" scope="end"/>
	var resultmsg = new Array();
<%
		retCode11 = retCode;
		retMsg11 = retMsg;
		if("000000".equals(retCode)){
			
			System.out.println("============ fm063Qry.jsp ==========" + ret.length);
			if(ret.length > 0 ){
				for(int i=0;i<ret.length;i++){
				System.out.println("============ fm063Qry.jsp ========== ret["+i+"][0]"+ret[i][0]);
				System.out.println("============ fm063Qry.jsp ========== ret["+i+"][1]"+ret[i][1]);
				System.out.println("============ fm063Qry.jsp ========== ret["+i+"][2]"+ret[i][2]);
				System.out.println("============ fm063Qry.jsp ========== ret["+i+"][3]"+ret[i][3]);
				System.out.println("============ fm063Qry.jsp ========== ret["+i+"][4]"+ret[i][4]);
				%>
					resultmsg[<%=i%>]=new Array();
					
					resultmsg[<%=i%>][0] = "<%=ret[i][0].trim()%>";
					resultmsg[<%=i%>][1] = "<%=ret[i][1].trim()%>";
					resultmsg[<%=i%>][2] = "<%=ret[i][2].trim()%>";
					resultmsg[<%=i%>][3] = "<%=ret[i][3].trim()%>";
					resultmsg[<%=i%>][4] = "<%=ret[i][4].trim()%>";
				<%
				}
			
			}
		}else{
			System.out.println("============ fm063Qry.jsp 失败==========");
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