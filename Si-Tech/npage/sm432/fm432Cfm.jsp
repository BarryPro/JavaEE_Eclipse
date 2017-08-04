<%
  /*
   * 功能: 
   * 版本: 1.0
   * 日期: liangyl 2016/11/29 关于优化现有ONT管理系统的需求
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

		String iLoginAccept = WtcUtil.repStr(request.getParameter("iLoginAccept"),"");//每次提交都为一个新流水 hejwa and haoyy 2015年6月10日10:32:09
		String iChnSource = WtcUtil.repStr(request.getParameter("iChnSource"),"");
		String iOpCode =  WtcUtil.repStr(request.getParameter("iOpCode"),"");
		String iLoginNo = WtcUtil.repStr(request.getParameter("iLoginNo"),"");
		String iLoginPwd =  WtcUtil.repStr(request.getParameter("iLoginPwd"),"");
		String iPhoneNo =  WtcUtil.repStr(request.getParameter("iPhoneNo"),"");
		String iUserPwd =  WtcUtil.repStr(request.getParameter("iUserPwd"),"");
		
		String userType =  WtcUtil.repStr(request.getParameter("userType"),"");
		String oldSn =  WtcUtil.repStr(request.getParameter("oldSn"),"");
		String newSn =  WtcUtil.repStr(request.getParameter("newSn"),"");
		String zhuangjiNum =  WtcUtil.repStr(request.getParameter("zhuangjiNum"),"");
		String zhuangjiSn =  WtcUtil.repStr(request.getParameter("zhuangjiSn"),"");
		String kuandaiNum =  WtcUtil.repStr(request.getParameter("kuandaiNum"),"");
		String liushui =  WtcUtil.repStr(request.getParameter("liushui"),"");
		String jine = WtcUtil.repStr( request.getParameter("jine"),"");
		
		String  inputParsm [] = new String[15];
		inputParsm[0] = iLoginAccept;
		inputParsm[1] = iChnSource;
		inputParsm[2] = iOpCode;
		inputParsm[3] = iLoginNo;
		inputParsm[4] = iLoginPwd;
		inputParsm[5] = iPhoneNo;
		inputParsm[6] = iUserPwd;	
		inputParsm[7] = userType;
		inputParsm[8] = oldSn;
		inputParsm[9] = newSn;
		inputParsm[10] = zhuangjiSn;
		inputParsm[11] = zhuangjiNum;
		inputParsm[12] = kuandaiNum;
		inputParsm[13] = liushui;
		inputParsm[14] = jine;
		
		String retCode11 = "";
		String retMsg11 = "";
		
		String oActualNum="";
		String oActualTotal="";
		
try{		
%>
		<wtc:service name="sM432Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="2">
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