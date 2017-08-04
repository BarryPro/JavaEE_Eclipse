 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-01-20 页面改造,修改样式
	update:haoyy@2010-08-10 新增客服密码参数（与新密码相同）
	********************/
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.csp.bsf.pwm.util.*"%>


<%
	String regionCode = (String)session.getAttribute("regCode");

	String work_no = request.getParameter("work_no");
	String nopass = request.getParameter("nopass");
	String op_code = request.getParameter("op_code");
	String oldPass = request.getParameter("oldPass");
	String newPass = request.getParameter("newPass");
	String cfmPass = request.getParameter("cfmPass");

	MD5 _md5 = new MD5();
	String KfPassWord= _md5.encode(newPass);  /* 客服密码  */

	String paraStr[]=new String[7];
	paraStr[0]=work_no;
	paraStr[1]=nopass;
	paraStr[2]=op_code;
	paraStr[3]=oldPass;
	paraStr[4]=newPass;
	paraStr[5]=cfmPass;
	paraStr[6]=KfPassWord;
	//SPubCallSvrImpl callImpl = new SPubCallSvrImpl();
	//String[] backInfo=callImpl.callService("s8004Cfm", paraStr, "3");
	%>
	 <wtc:service name="s8004Cfm" routerKey="region" routerValue=" <%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="3">
		<wtc:params value="<%=paraStr%>"/>
	</wtc:service>
	<wtc:array id="backInfo" scope="end" />
	<%

	String info = "";
	String retCode= "";
	String retMsg = "";
	if(backInfo!=null&&backInfo.length>0){
		retCode=retCode1;
		retMsg=retMsg1;
	}
	if(backInfo[0][0].trim().equals("000000")){
		info="操作已成功！";
	}
	else{
		info = retMsg;
	}
%>
var response = new AJAXPacket();
var groupString = "";
groupString = "<%=info%>";
response.data.add("backGroupInfo",groupString);
core.ajax.receivePacket(response);
