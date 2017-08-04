 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-01-20 页面改造,修改样式
	update:haoyy@2010-08-10 密码复位时客服密码初始化为Abc1234%
	********************/
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.csp.bsf.pwm.util.*"%>

<%
	String work_no = request.getParameter("work_no");
	String nopass  = request.getParameter("nopass");
	String op_code = request.getParameter("op_code");
	String loginNo = request.getParameter("login_no");

	String regionCode = (String)session.getAttribute("regCode");

	MD5 _md5 = new MD5();
	String kfPassWord = _md5.encode("Abc1234%"); /*客服工号复位密码需要同时传入客服加密的结果*/

	String paraStr[]=new String[5];
	paraStr[0]=work_no;
	paraStr[1]=nopass;
	paraStr[2]=op_code;
	paraStr[3]=loginNo;
	paraStr[4]=kfPassWord;

	//SPubCallSvrImpl callImpl = new SPubCallSvrImpl();
	//String[] backInfo=callImpl.callService("s8006Cfm", paraStr, "3");
%>
	<wtc:service name="s8006Cfm" routerKey="region" routerValue=" <%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="3">
		<wtc:param value="<%=paraStr[0]%>"/>
		<wtc:param value="<%=paraStr[1]%>"/>
		<wtc:param value="<%=paraStr[2]%>"/>
		<wtc:param value="<%=paraStr[3]%>"/>
		<wtc:param value="<%=paraStr[4]%>"/>
	</wtc:service>
	<wtc:array id="backInfo" scope="end" />
<%

	String info = "";
	//String retCode= String.valueOf(callImpl.getErrCode());
	//String retMsg = callImpl.getErrMsg();
	if(backInfo!=null&&backInfo.length>0){
		if(backInfo[0][0].trim().equals("000000")){
			info="操作已成功！";
		}else{
			info = backInfo[0][1].trim();
		}
	}
%>
var response = new AJAXPacket();
var groupString = "";
groupString = "<%=info%>";
response.data.add("backGroupInfo",groupString);
core.ajax.receivePacket(response);
