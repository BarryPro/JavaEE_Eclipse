<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>

<%
 
  String smCode = WtcUtil.repNull(request.getParameter("smCode")); 
  String offerId = WtcUtil.repNull(request.getParameter("offerId")); 
  String opCode = WtcUtil.repNull(request.getParameter("opCode")); 
  String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));
  System.out.println("------------------smCode-----------------"+smCode);
  System.out.println("------------------offerId-----------------"+offerId);
  System.out.println("------------------opCode-----------------"+opCode);
  String regionCode = (String)session.getAttribute("regCode");
  String workNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password"); 
	String accountType = (String)session.getAttribute("accountType"); //1 为营业工号 2 为客服工号
  String strArray="var retResult; ";  //must
  String arrStr = "var retResult; ";
  String[][] result_t = new String[][]{};
  //218
  if("1270".equals(opCode)){ /* update for 关于优化客服CRM系统功能七月份第六次需求的函@2014/9/15 */
  	%>
    	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="printAccept"/>
    		
    	<wtc:service name="sOfferTypeQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="3">			
				<wtc:param value="<%=printAccept%>"/>
				<wtc:param value="01"/>	
				<wtc:param value="<%=opCode%>"/>
				<wtc:param value="<%=workNo%>"/>
				<wtc:param value="<%=password%>"/>
				<wtc:param value="<%=phoneNo%>"/>
				<wtc:param value=""/>
				<wtc:param value="<%=smCode%>"/>
				<wtc:param value="<%=accountType%>"/>
				<wtc:param value="<%=offerId%>"/>
		  </wtc:service>	
			<wtc:array id="resultList"  scope="end"/>
<%
			result_t = resultList;
	}else{
%>
		<wtc:service name="sDynSqlCfm" routerKey="region" routerValue="<%=regionCode%>" outnum="3">
			  <wtc:param value="215"/>
			  <wtc:param value="<%=smCode%>"/>
			  <wtc:param value="<%=offerId%>"/>
			  <wtc:param value="<%=opCode%>"/>
		</wtc:service>
		<wtc:array id="resultList" scope="end"/>
<%
			result_t = resultList;
	}

	 strArray = WtcUtil.createArray("retResult",result_t.length);	
%>
<%=strArray%>
<%
	for(int i=0;i<result_t.length;i++){
	  System.out.println("value = " + result_t[i][1]);
	%>
		retResult[<%=i%>][0] = "<%=result_t[i][0]%>";
		retResult[<%=i%>][1] = "<%=result_t[i][1]%>";
	<%
	}
%>
var response = new AJAXPacket();
response.data.add("retResult",retResult);
core.ajax.receivePacket(response);