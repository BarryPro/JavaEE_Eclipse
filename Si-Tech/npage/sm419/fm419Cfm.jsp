<%
  /*
   * 功能: 
   * 版本: 1.0
   * 日期: liangyl 2016/10/31 关于协助开发、优化BOSS系统宽带业务功能的函
   * 作者: liangyl
   * 版权: si-tech
  */
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
		
		String regionCode = (String)session.getAttribute("regCode");
		String workNo = (String)session.getAttribute("workNo");

		String iLoginAccept = request.getParameter("iLoginAccept");//每次提交都为一个新流水 hejwa and haoyy 2015年6月10日10:32:09
		String iChnSource = request.getParameter("iChnSource");
		String iOpCode =  request.getParameter("iOpCode");
		String iLoginNo = request.getParameter("iLoginNo");
		String iLoginPwd =  request.getParameter("iLoginPwd");
		String iPhoneNo =  request.getParameter("iPhoneNo");
		String iUserPwd =  request.getParameter("iUserPwd");
		String yajinType = request.getParameter("yajinType");
		String yewuType =  request.getParameter("yewuType");
		String kuandaiNum = request.getParameter("kuandaiNum");
		String kdZd =  request.getParameter("kdZd");
		String fysqfs =  request.getParameter("fysqfs");
		String kdZdFee =  request.getParameter("kdZdFee");
		String snNumber =  request.getParameter("snNumber");
		
		String  inputParsm [] = new String[15];
		inputParsm[0] = iLoginAccept;
		inputParsm[1] = iChnSource;
		inputParsm[2] = iOpCode;
		inputParsm[3] = iLoginNo;
		inputParsm[4] = iLoginPwd;
		inputParsm[5] = iPhoneNo;
		inputParsm[6] = iUserPwd;
		inputParsm[7] = yajinType;
		inputParsm[8] = yewuType;
		inputParsm[9] = kuandaiNum;
		inputParsm[10] = kdZd;
		inputParsm[11] = fysqfs;
		inputParsm[12] = kdZdFee;
		inputParsm[13] = workNo+"对宽带号"+kuandaiNum+"进行押金补收操作，金额["+kdZdFee+"]";
		inputParsm[14] = snNumber;
		
		String retCode11 = "";
		String retMsg11 = "";
		
		String oActualNum="";
		String oActualTotal="";
		
try{		
%>
		<wtc:service name="sm419Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="2">
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
				<wtc:param value="<%=inputParsm[13]%>"/>
				<wtc:param value="<%=inputParsm[14]%>"/>
		</wtc:service>
		<wtc:array id="infoRet1" scope="end"/>
			
	var infoArray = new Array();
	
<%
		retCode11 = retCode;
		retMsg11 = retMsg;
		
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