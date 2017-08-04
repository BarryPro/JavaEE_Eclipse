<%
    /*************************************
    * 功  能: 网上终端销售出库 e899
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2012-7-6
    **************************************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String regCode = (String)session.getAttribute("regCode");
	String loginNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String loginPassword = WtcUtil.repNull((String)session.getAttribute("password"));
	
	String opCode=WtcUtil.repNull((String)request.getParameter("opCode"));
	String qryPhoneNo=WtcUtil.repNull((String)request.getParameter("qryPhoneNo"));
	String iMeiNo=WtcUtil.repNull((String)request.getParameter("iMeiNo"));
	String machineTypeNo=WtcUtil.repNull((String)request.getParameter("machineTypeNo"));
	String machineColor=WtcUtil.repNull((String)request.getParameter("machineColor"));
	String qryOrderNo=WtcUtil.repNull((String)request.getParameter("qryOrderNo"));
	
	String note = qryPhoneNo;
	String opAccept = "";
%>
 <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>" id="printAccept"/>
<%
  String [] inputParam = new String [12] ;
	inputParam[0] = printAccept; //流水
	inputParam[1] = "01";        //渠道
	inputParam[2] = opCode;      //操作代码
	inputParam[3] = loginNo;     //工号
	inputParam[4] = loginPassword;//工号密码
	inputParam[5] = qryPhoneNo;   //号码
	inputParam[6] = "";           //号码密码
	inputParam[7] = note;           //操作备注
	inputParam[8] = iMeiNo;       //imei码
	inputParam[9] = machineTypeNo;  //机型代码
	inputParam[10] = machineColor;  //机型颜色
	inputParam[11] = qryOrderNo;  //订单号
	
	System.out.println("-----------e899------提交-----inputParam[0]="+inputParam[0]);
	System.out.println("-----------e899------提交-----inputParam[0]="+inputParam[1]);
	System.out.println("-----------e899------提交-----inputParam[0]="+inputParam[2]);
	System.out.println("-----------e899------提交-----inputParam[0]="+inputParam[3]);
	System.out.println("-----------e899------提交-----inputParam[0]="+inputParam[4]);
	System.out.println("-----------e899------提交-----inputParam[0]="+inputParam[5]);
	System.out.println("-----------e899------提交-----inputParam[0]="+inputParam[6]);
	System.out.println("-----------e899------提交-----inputParam[0]="+inputParam[7]);
	System.out.println("-----------e899------提交-----inputParam[0]="+inputParam[8]);
	System.out.println("-----------e899------提交-----inputParam[0]="+inputParam[9]);
	System.out.println("-----------e899------提交-----inputParam[0]="+inputParam[10]);
%>
	<wtc:service name="se899Cfm" routerKey="phone" routerValue="<%=qryPhoneNo%>" retcode="retCode" retmsg="retMsg" outnum="3">
		<wtc:param value="<%=inputParam[0]%>"/>
		<wtc:param value="<%=inputParam[1]%>"/>
		<wtc:param value="<%=inputParam[2]%>"/>
		<wtc:param value="<%=inputParam[3]%>"/>
		<wtc:param value="<%=inputParam[4]%>"/>
		<wtc:param value="<%=inputParam[5]%>"/>
		<wtc:param value="<%=inputParam[6]%>"/>
		<wtc:param value="<%=inputParam[7]%>"/>
		<wtc:param value="<%=inputParam[8]%>"/>
		<wtc:param value="<%=inputParam[9]%>"/>
		<wtc:param value="<%=inputParam[10]%>"/>
		<wtc:param value="<%=inputParam[11]%>"/>
	</wtc:service>
	<wtc:array id="ret"  scope="end"/>
<%
  System.out.println("-----------e899------提交-----retcode="+retCode);
  System.out.println("-----------e899------提交-----retMsg="+retMsg);
  if("000000".equals(retCode)){
    if(ret.length>0){
      opAccept = ret[0][0];
    }
  }
%>
var response = new AJAXPacket();
response.data.add("retcode","<%=retCode%>");
response.data.add("retmsg","<%=retMsg%>");
response.data.add("opAccept","<%=opAccept%>");
core.ajax.receivePacket(response);
 
	    