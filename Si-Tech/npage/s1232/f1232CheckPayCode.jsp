<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.util.*"%>
<%
  String workNo = (String)session.getAttribute("workNo");
  String regionCode= (String)session.getAttribute("regCode");
  String password = (String)session.getAttribute("password");
	String vConID = WtcUtil.repNull((String)request.getParameter("vConID"));
	
	String inParamsPayFlag [] = new String[2];
	inParamsPayFlag[0] = "select count(1) from dconmsg t where t.pay_code= '4'  and t.contract_no =:vConID ";
	inParamsPayFlag[1] = "vConID="+vConID;
 	
 	
%>

<%  
  
String retCode11 = "";
String retMsg11 = "";
int mycount = 0;
try{
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="1"> 
	    <wtc:param value="<%=inParamsPayFlag[0]%>"/>
	    <wtc:param value="<%=inParamsPayFlag[1]%>"/> 
	  </wtc:service>  
	  <wtc:array id="ret"  scope="end"/>
<%
	retCode11 = retCode;
	retMsg11 = retMsg;
	if(retCode.equals("000000")) {
		if(ret.length > 0) {
			 mycount = Integer.parseInt(ret[0][0]);
		}
	}
	}catch(Exception e){
		retCode11 = "444444";
		retMsg11 = "系统错误请联系管理员！";
	}
%>

	var response = new AJAXPacket();
	response.data.add("retcode","<%=retCode11%>");
	response.data.add("retmsg","<%=retMsg11%>");
	response.data.add("mycount","<%=mycount%>");

	core.ajax.receivePacket(response);