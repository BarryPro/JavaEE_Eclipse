<%request.setCharacterEncoding("GB2312");%>
<%@page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
/*
* 功能: 缺少资源记录
* 版本: 1.0
* 日期: 2011-09-22
* 作者: lijy
* 版权: sitech
*/
%>
<%
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	System.out.println("==============缺失资源记录=============== ");
	String LoginAccept = request.getParameter("LoginAccept")==null?"":request.getParameter("LoginAccept");
	String ChnSource=request.getParameter("ChnSource")==null?"":request.getParameter("ChnSource");
	String OpCode = request.getParameter("OpCode")==null?"":request.getParameter("OpCode");
	String LoginNo=request.getParameter("LoginNo")==null?"":request.getParameter("LoginNo");
	String LoginPwd = request.getParameter("LoginPwd")==null?"":request.getParameter("LoginPwd");
	String PhoneNo=request.getParameter("PhoneNo")==null?"":request.getParameter("PhoneNo");
	String UserPwd = request.getParameter("UserPwd")==null?"":request.getParameter("UserPwd");
	
	//String Address=request.getParameter("Address")==null?"":request.getParameter("Address");
	//String UserName=request.getParameter("UserName")==null?"":request.getParameter("UserName");
	//String UserPhone = request.getParameter("UserPhone")==null?"":request.getParameter("UserPhone");
	//String busiType=request.getParameter("busiType")==null?"":request.getParameter("busiType");
	
	String userName = WtcUtil.repStr(request.getParameter("userName"),"");
	String contractPhone = WtcUtil.repStr(request.getParameter("contractPhone"),"");
	String county = WtcUtil.repStr(request.getParameter("county"),"");
	String ownerShip = WtcUtil.repStr(request.getParameter("ownerShip"),"");
	String userareaName = WtcUtil.repStr(request.getParameter("userareaName"),"");
	String bundMobile = WtcUtil.repStr(request.getParameter("bundMobile"),"");
	String bandWidth = WtcUtil.repStr(request.getParameter("bandWidth"),"");
	String ageLimit = WtcUtil.repStr(request.getParameter("ageLimit"),"");
	String isIptv = WtcUtil.repStr(request.getParameter("isIptv"),"");
	String description = WtcUtil.repStr(request.getParameter("description"),"");
	String expireTime = WtcUtil.repStr(request.getParameter("expireTime"),"");
	
	String iAreaCode = WtcUtil.repStr(request.getParameter("iAreaCode"),"");
	String iStandAddr = WtcUtil.repStr(request.getParameter("iStandAddr"),"");
	String iColFlag = WtcUtil.repStr(request.getParameter("iColFlag"),"");

	String opName="资源查询";
	
%> 
<wtc:service name="sInLackResInfo" routerKey="region"   retcode="retcode" retmsg="retmsg"  outnum="2" >
	<wtc:param value="<%=LoginAccept%>"/>
	<wtc:param value="<%=ChnSource%>"/>
	<wtc:param value="<%=OpCode%>"/>
	<wtc:param value="<%=LoginNo%>"/>
	<wtc:param value="<%=LoginPwd%>"/>
	<wtc:param value="<%=PhoneNo%>"/>
	<wtc:param value="<%=UserPwd%>"/>
	
	<wtc:param value=""/>
	<wtc:param value="<%=userName%>"/>
	<wtc:param value="<%=contractPhone%>"/>
	<wtc:param value=""/>
	<wtc:param value="<%=regionCode%>"/>
	<wtc:param value="<%=county%>"/>
	<wtc:param value="<%=ownerShip%>"/>
	<wtc:param value="<%=userareaName%>"/>
	<wtc:param value="<%=bundMobile%>"/>
	<wtc:param value="<%=bandWidth%>"/>
	<wtc:param value="<%=ageLimit%>"/>
	<wtc:param value="<%=description%>"/>
	<wtc:param value="<%=isIptv%>"/>
	<wtc:param value="<%=expireTime%>"/>
		
	<wtc:param value="<%=iAreaCode%>"/>
	<wtc:param value="<%=iStandAddr%>"/>
	<wtc:param value="<%=iColFlag%>"/>
						
</wtc:service>	
<wtc:array id="result"  scope="end"/>
<%
	System.out.println("retcode======"+retcode);
	System.out.println("retMsg======"+retmsg);
	
 
%>
var response = new AJAXPacket();
var returnCode= "<%=retcode%>";
var returnMsg="<%=retmsg%>";
response.data.add("retCode",returnCode);
response.data.add("retMessage",returnMsg);
core.ajax.receivePacket(response);


