 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-02-12 页面改造,修改样式
	********************/
%>
<%@ page contentType="text/html;charset=Gbk"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%
	String opName1= "红名单管理";
	String phoneNo=request.getParameter("phoneNo");
	System.out.println("phoneNo================="+phoneNo);
	String regionCode= (String)session.getAttribute("regCode");
	String loginAccept = request.getParameter("loginAccept");
	String opCode= request.getParameter("opCode");
	String workNo= request.getParameter("workNo");
	String noPass = (String)session.getAttribute("password");
	String orgCode= request.getParameter("orgCode");
	String idNo= request.getParameter("idNo");
	String opType = request.getParameter("opType");
	String redType = request.getParameter("redType");
	String redReason = request.getParameter("redReason");
	String expireTime = request.getParameter("expireTime");
	String handFee= request.getParameter("handFee");
	String factPay= request.getParameter("factPay");
	String sysRemark= request.getParameter("sysRemark");
	String remark= request.getParameter("remark");
	String ipAdd= request.getParameter("ipAdd");	
        %>
    <wtc:service name="s2300Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1" >
			<wtc:param value="<%=loginAccept%>"/>
			<wtc:param value="<%=opCode%>"/>
			<wtc:param value="<%=workNo%>"/>
			<wtc:param value="<%=noPass%>"/>
			<wtc:param value="<%=orgCode%>"/>
			
			<wtc:param value="<%=idNo%>"/>
			<wtc:param value="<%=opType%>"/>
			<wtc:param value="<%=redType%>"/>
			<wtc:param value="<%=redReason%>"/>
			<wtc:param value="<%=expireTime%>"/>
			
			<wtc:param value="<%=handFee%>"/>
			<wtc:param value="<%=factPay%>"/>
			<wtc:param value="<%=sysRemark%>"/>
			<wtc:param value="<%=remark%>"/>
			<wtc:param value="<%=ipAdd%>"/>
		</wtc:service>
		<wtc:array id="backInfo"  scope="end"/>
		
        <%
     	if(retMsg1.equals("")){
		retMsg1 = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(retMsg1));
		if( retMsg1.equals("null")){
			retMsg1 ="未知错误信息";
	}
} 

%>


<%
	String strArray = CreatePlanerArray.createArray("backInfo",backInfo.length);
%>
<%=strArray%>
<%

for(int i = 0 ; i < backInfo.length ; i ++){
      for(int j = 0 ; j < backInfo[i].length ; j ++){


%>

backInfo[<%=i%>][<%=j%>] = "<%=backInfo[i][j].trim()%>";
<%
}
}
%>
var response = new AJAXPacket();
response.data.add("backString",backInfo);
response.data.add("flag","1");
response.data.add("errCode","<%=retCode1%>");
response.data.add("errMsg","<%=retMsg1%>");
core.ajax.receivePacket(response);

<%
	String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode1+"&opName="+opName1+"&workNo="+workNo+"&loginAccept="+loginAccept+"&pageActivePhone="+phoneNo+"&retMsgForCntt="+retMsg1+"&opBeginTime="+opBeginTime; 
	System.out.println("url======================="+url);
%>
<jsp:include page="<%=url%>" flush="true" />
