<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%
	String regionCode= (String)session.getAttribute("regCode");
	String cfmLogin = request.getParameter("cfmLogin");
	String yajinmoney="";
	
	String  inParamsorderNum [] = new String[2];
  inParamsorderNum[0] = "select terminale_fee from dbcustadm.wBroadTerminalOpr	where id_no=(select id_no from dbroadbandmsg where cfm_login=:cfmloginno) and	flag = '0' and op_code in('e916','m419') and returnflag = '0'";
  inParamsorderNum[1] = "cfmloginno="+cfmLogin;	
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode_mail" retmsg="retMessage_mail" outnum="1"> 
    <wtc:param value="<%=inParamsorderNum[0]%>"/>
    <wtc:param value="<%=inParamsorderNum[1]%>"/> 
  </wtc:service>  
  <wtc:array id="result_mail"  scope="end"/>
<%
	if(result_mail.length > 0 && "000000".equals(retCode_mail)){
		yajinmoney = result_mail[0][0];
		System.out.println("gaopengSeeLog===e083====yajinmoney=="+yajinmoney);
	}

%>

var response = new AJAXPacket();
response.data.add("result","<%=yajinmoney%>");

core.ajax.receivePacket(response);