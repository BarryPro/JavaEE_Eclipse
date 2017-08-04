<%
  /*
   * 功能: 用户信誉度修改2308
   * 版本: 1.0
   * 日期: 2009/1/15
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>


<%
	 					//操作工号
	String phoneNo = request.getParameter("phoneNo").trim();					//用户号码
	String opCode = request.getParameter("opCode");						//操作代码
	String orgCode = request.getParameter("orgCode");					//归属代码
	String regionCode = (String)session.getAttribute("regCode");		//地市代码
 
%>

 
 
	<wtc:service name="bs_sCodeMain" routerKey="region" routerValue="<%=regionCode%>" outnum="3" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=phoneNo%>"/>
 
	</wtc:service>
	<wtc:array id="mainInfo" scope="end"/>
<%
	String errCode = retCode;
	String errMsg = retMsg;
	String cust_name = "";
	String cust_id = "";
	String cust_addr = "";
	if(errMsg.equals("")){
		errMsg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(errCode));
		if( errMsg.equals("null")){
			errMsg ="未知错误信息";
		}
	} 
	
	
	if(retCode.equals("0")||retCode.equals("000000"))
	{
			
		%>
			var response = new AJAXPacket();
			response.data.add("flag1","0");
			
			core.ajax.receivePacket(response);
		<%
	}
	else
	{
		%>
			var response = new AJAXPacket();
			response.data.add("flag1","1");
			response.data.add("errCode","<%=errCode%>");
			response.data.add("errMsg","<%=errMsg%>");
			core.ajax.receivePacket(response);
		<%
	}
	

%>
	
 