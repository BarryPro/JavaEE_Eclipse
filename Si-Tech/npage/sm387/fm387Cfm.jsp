<%
/********************
 * version v2.0
 * gaopeng 2015/02/11 9:50:29 关于11月份集团客户部CRM、BOSS和经分系统需求的函-7-行业应用流量卡BOSS系统需求
 * 开发商: si-tech
 ********************/
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
		/**
		sKBMainOffCfm
		###          0  打印流水                iLognAccept
		###          1  渠道代码                iChnSource
		###          2  操作代码                iOpCode
		###          3  操作工号                iLoginNo
		###          4  工号密码                iLoginPwd
		###          5  用户号码                iPhoneNo
		###          6  用户密码                iUserPwd
		
		###          7  当前主产品代码          iOldMode
		###          8  新主产品代码            iNewMode
		###          9  系统日志                iSysNote
		###          10 操作日志                iOpNote
		###          11 登录IP                  iIpAddr
		###          12 积分抵扣标示            iDealType 
		###          13 积分抵扣号码            iPhoneChgNo
		###          14 积分抵扣数量            iMarkScore


		*/
		System.out.println("===gaopengSeeLog========= fm225Cfm.jsp ==========");
		
		String regionCode = (String)session.getAttribute("regCode");
		
		String iLoginAccept = request.getParameter("iLoginAccept");//每次提交都为一个新流水 hejwa and haoyy 2015年6月10日10:32:09
		
		String iChnSource = request.getParameter("iChnSource");
		String iOpCode =  request.getParameter("iOpCode");
		String iLoginNo = request.getParameter("iLoginNo");
		String iLoginPwd =  request.getParameter("iLoginPwd");
		String iPhoneNo =  request.getParameter("iPhoneNo");
		String iUserPwd =  request.getParameter("iUserPwd");
		
		String ipAddr = request.getRemoteAddr();
		
		String oldFeeCode =  request.getParameter("oldFeeCode");
		String newFeeCode =  request.getParameter("newFeeCode");
		String iSysNote =  "工号"+iLoginNo+"执行"+iOpCode+"操作,手机号："+iPhoneNo;
		String iOpNote =  "工号"+iLoginNo+"执行"+iOpCode+"操作,手机号："+iPhoneNo;
		
		String jfdkFlag =  request.getParameter("jfdkFlag");
		String jfdkPhone =  request.getParameter("jfdkPhone");
		String jdfkNum =  request.getParameter("jdfkNum");
		
		
		
		String  inputParsm [] = new String[17];
		inputParsm[0] = iLoginAccept;
		inputParsm[1] = iChnSource;
		inputParsm[2] = iOpCode;
		inputParsm[3] = iLoginNo;
		inputParsm[4] = iLoginPwd;
		inputParsm[5] = iPhoneNo;
		inputParsm[6] = iUserPwd;
		
		inputParsm[7] = oldFeeCode;
		inputParsm[8] = newFeeCode;
		inputParsm[9] = iSysNote;
		inputParsm[10] = iOpNote;
		inputParsm[11] = ipAddr;
		inputParsm[12] = jfdkFlag;
		inputParsm[13] = jfdkPhone;
		inputParsm[14] = jdfkNum;
		
		String retCode11 = "";
		String retMsg11 = "";
		
		String oActualNum="";
		String oActualTotal="";
		
try{		
%>
		<wtc:service name="sKBMainOffCfm" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="2">
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
response.data.add("retMsg","<%=retMsg11 %>");;
core.ajax.receivePacket(response);                                                                                                                                                                                                                                                                                                                                                                         