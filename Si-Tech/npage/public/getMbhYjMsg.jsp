<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%
	String regionCode= (String)session.getAttribute("regCode");
	String dateStr2 =  new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	
	String phoneNo1 = request.getParameter("phoneNo");
	String opAccept = request.getParameter("opAccept");
	
	String opCode = request.getParameter("opCode");
	String getMsgSql = " select a.deposit "
+"  from wchg"+dateStr2+" a "
+" where a.login_accept =:opAccept1 "
+"   and a.deposit > 0 "
+"   and a.op_code = 'g794' "
+"   and a.phone_no =:vPhoneNo ";
	String[] inParams = new String[2];
	inParams[0] = getMsgSql;
	inParams[1] = "opAccept1="+opAccept.trim()+",vPhoneNo=" + phoneNo1;
	System.out.println("========== gaopengE150G795 ===== " + inParams[0]);
	System.out.println("========== gaopengE150G795 ===== " + inParams[1]);
	String retCode = "";
	String retMsg = "";
	String deposit = "";
	
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode_mail" retmsg="retMessage_mail" outnum="1"> 
    <wtc:param value="<%=inParams[0]%>"/>
    <wtc:param value="<%=inParams[1]%>"/> 
  </wtc:service>  
  <wtc:array id="result_mail"  scope="end"/>
<%
	retCode = retCode_mail;
	retMsg = retMessage_mail;
	if(result_mail.length > 0 && "000000".equals(retCode_mail)){
		deposit = result_mail[0][0];
		System.out.println("gaopengE150G795========="+deposit);
	}

%>

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
response.data.add("deposit","<%=deposit%>");

core.ajax.receivePacket(response);