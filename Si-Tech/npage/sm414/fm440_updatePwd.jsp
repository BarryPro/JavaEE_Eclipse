<%
  /*
   * ����: 
   * �汾: 1.0
   * ����: liangyl 2016/12/08 ʡ��ħ�ٺ�ƽ̨�㲥���ܺ�֧�����ܿ�������
   * ����: liangyl
   * ��Ȩ: si-tech
  */
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
		String regionCode = (String)session.getAttribute("regCode");

		String iLoginAccept = request.getParameter("iLoginAccept");
		String iChnSource = request.getParameter("iChnSource");
		String iOpCode =  "m440";
		String iWorkNo = request.getParameter("iWorkNo");
		String iWorkPwd =  request.getParameter("iWorkPwd");
		String iPhoneNo =  request.getParameter("iPhoneNo");
		String iUserPwd =  request.getParameter("iUserPwd");
		
		String sm440_imei =  request.getParameter("sm440_imei");
		String sm440_pwd =  request.getParameter("sm440_pwd");
		
		String  inputParsm [] = new String[10];
		inputParsm[0] = iLoginAccept;
		inputParsm[1] = iChnSource;
		inputParsm[2] = iOpCode;
		inputParsm[3] = iWorkNo;
		inputParsm[4] = iWorkPwd;
		inputParsm[5] = iPhoneNo;
		inputParsm[6] = iUserPwd;
		inputParsm[7] = iWorkNo+"ͨ��m440,��"+iPhoneNo+"����ħ�ٺ������޸�";
		inputParsm[8] = sm440_imei;
		inputParsm[9] = sm440_pwd;
		
		String retCode11 = "";
		String retMsg11 = "";
try{		
%>
	<wtc:service name="sm440Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="2">
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
	</wtc:service>
	<wtc:array id="sm440Cfm_result" scope="end"/>
			
	var infoArray = new Array();
	
<%
		retCode11 = retCode;
		retMsg11 = retMsg;
		
		}catch(Exception e){
			e.printStackTrace();
			retCode11 = "444444";
			retMsg11 = "����δ����������������ϵ����Ա��";
			%>
				var infoArray = new Array();
			<%
		}
%>
var response = new AJAXPacket();
response.data.add("code","<%=retCode11 %>");
response.data.add("msg","<%=retMsg11 %>");
core.ajax.receivePacket(response);                                                                                                                                                                                                                                                                                                                                                                         