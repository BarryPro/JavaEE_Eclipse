<%
/********************
 * version v2.0
 * gaopeng 2014/03/10 10:48:14 ������ͳһ�Ż�������ʡ4Gר��������
 * ������: si-tech
 ********************/
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		System.out.println("============ fm052Qry.jsp ==========");
		
		String regionCode = (String)session.getAttribute("regCode");
		
		String iLoginAccept = request.getParameter("iLoginAccept");
		String iChnSource = request.getParameter("iChnSource");
		String iOpCode =  request.getParameter("iOpCode");
		String iLoginNo = request.getParameter("iLoginNo");
		String iLoginPwd =  request.getParameter("iLoginPwd");
		String iPhoneNo =  request.getParameter("iPhoneNo");
		String iUserPwd =  request.getParameter("iUserPwd");
		String iFileNo = request.getParameter("iFileNo");
		
		

		
		String  inputParsm [] = new String[8];
		inputParsm[0] = iLoginAccept;
		inputParsm[1] = iChnSource;
		inputParsm[2] = iOpCode;
		inputParsm[3] = iLoginNo;
		inputParsm[4] = iLoginPwd;
		inputParsm[5] = iPhoneNo;
		inputParsm[6] = iUserPwd;
		inputParsm[7] = iFileNo;
		
		
		String retCode11 = "";
		String retMsg11 = "";
		
try{		
%>
		<wtc:service name="sm052Qry" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="4">
				<wtc:param value="<%=inputParsm[0]%>"/>
				<wtc:param value="<%=inputParsm[1]%>"/>
				<wtc:param value="<%=inputParsm[2]%>"/>
				<wtc:param value="<%=inputParsm[3]%>"/>
				<wtc:param value="<%=inputParsm[4]%>"/>
				<wtc:param value="<%=inputParsm[5]%>"/>
				<wtc:param value="<%=inputParsm[6]%>"/>
				<wtc:param value="<%=inputParsm[7]%>"/>
		</wtc:service>
		<wtc:array id="ret" scope="end"/>
	var resultmsg = new Array();
<%
		retCode11 = retCode;
		retMsg11 = retMsg;
		if("000000".equals(retCode)){
			
			System.out.println("============ fm052Qry.jsp ==========" + ret.length);
			if(ret.length > 0 ){
				for(int i=0;i<ret.length;i++){
				System.out.println("============ fm052Qry.jsp ========== ret["+i+"][0]"+ret[i][0]);
				System.out.println("============ fm052Qry.jsp ========== ret["+i+"][1]"+ret[i][1]);
				System.out.println("============ fm052Qry.jsp ========== ret["+i+"][2]"+ret[i][2]);
				System.out.println("============ fm052Qry.jsp ========== ret["+i+"][3]"+ret[i][3]);
				%>
					resultmsg[<%=i%>]=new Array();
					
					resultmsg[<%=i%>][0] = "<%=ret[i][0].trim()%>";
					resultmsg[<%=i%>][1] = "<%=ret[i][1].trim()%>";
					resultmsg[<%=i%>][2] = "<%=ret[i][2].trim()%>";
					resultmsg[<%=i%>][3] = "<%=ret[i][3].trim()%>";
				<%
				}
			
			}
		}else{
			System.out.println("============ fm052Qry.jsp ʧ��==========");
		}
		}catch(Exception e){
			retCode11 = "444444";
			retMsg11 = "����δ����������������ϵ����Ա��";
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