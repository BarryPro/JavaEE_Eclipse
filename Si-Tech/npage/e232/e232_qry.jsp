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
	String phoneNo = request.getParameter("phoneNo").trim();	
	String phoneNo2 = request.getParameter("phoneNo2").trim();//用户号码
	String opCode = request.getParameter("opCode");						//操作代码
	String orgCode = request.getParameter("orgCode");					//归属代码
	String regionCode = (String)session.getAttribute("regCode");		//地市代码
 
%>

 
 
	<wtc:service name="bs_sCodeQry" routerKey="region" routerValue="<%=regionCode%>" outnum="9" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value="<%=phoneNo2%>"/>
	</wtc:service>
	<wtc:array id="mainInfo" scope="end"/>
<%
	String errCode = retCode;
	String errMsg = retMsg;
	String dMainFee = "";
	String dMainMonth = "";
	String mainPer="";
	String dSecondFee= "";
	String dSecondMonth = "";
	String secPer= "";
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
		dMainFee = mainInfo[0][0];
		dMainMonth = mainInfo[0][1];
		mainPer = mainInfo[0][2];
		dSecondFee = mainInfo[0][3];
		dSecondMonth = mainInfo[0][4];
		secPer = mainInfo[0][5];
		cust_name=mainInfo[0][6];
		cust_id=mainInfo[0][8];
		cust_addr=mainInfo[0][7];
		%>
			var response = new AJAXPacket();
			response.data.add("flag2","0");
			response.data.add("dMainFee","<%=dMainFee%>");
			response.data.add("dMainMonth","<%=dMainMonth%>");
			response.data.add("mainPer","<%=mainPer%>");
			response.data.add("dSecondFee","<%=dSecondFee%>");
			response.data.add("dSecondMonth","<%=dSecondMonth%>");
			response.data.add("secPer","<%=secPer%>");
			response.data.add("cust_name","<%=cust_name%>");
			response.data.add("cust_addr","<%=cust_addr%>");
			response.data.add("cust_id","<%=cust_id%>");
			core.ajax.receivePacket(response);
		<%
	}
	else
	{
		%>
			var response = new AJAXPacket();
			response.data.add("flag2","1");
			response.data.add("errCode2","<%=errCode%>");
			response.data.add("errMsg2","<%=errMsg%>");
			core.ajax.receivePacket(response);
		<%
	}
	

%>
	
 