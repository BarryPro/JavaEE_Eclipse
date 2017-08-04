
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String opCode = request.getParameter("opCode");
	String workNo = (String)session.getAttribute("workNo");
	String regionCode = (String)session.getAttribute("regCode");
	
String phoneNo = request.getParameter("phoneNo");		
String loginAcceptHv = request.getParameter("loginAcceptHv");		
String servId = request.getParameter("servId");		
		
	String retSultSum = "0";
	System.out.println("--------------------opCode----------------"+opCode);
	String querySql = "SELECT COUNT(*) FROM dLoginFuncView WHERE login_no = '"+workNo+"' AND   function_code like '"+opCode+"%'";
	System.out.println("querySql|||||||"+querySql);
	
	System.out.println("--------------phoneNo---------------"+phoneNo);
	System.out.println("--------------opCode---------------"+opCode);
	System.out.println("--------------workNo---------------"+workNo);
	System.out.println("--------------loginAcceptHv---------------"+loginAcceptHv);
%>
 	 <wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=querySql%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t" scope="end"/>
	 	
	 
	 <wtc:utype name="sReverChk" id="retVal" scope="end" >
          <wtc:uparam value="<%=phoneNo%>" type="String"/>      
          <wtc:uparam value="<%=opCode%>" type="String"/>      
          <wtc:uparam value="<%=workNo%>" type="String"/>      
          <wtc:uparam value="<%=loginAcceptHv%>" type="String"/>      
          <wtc:uparam value="<%=servId%>" type="String"/>    	
 </wtc:utype>	
<%
	String retCode=retVal.getValue(0);
	String retMsg=retVal.getValue(1);
	
	System.out.println("--------------retCode-------------"+retCode);
	System.out.println("--------------retMsg-------------"+retMsg);
	if(result_t.length>0&&result_t[0][0]!=null){
		retSultSum = result_t[0][0];
	}
	System.out.println("--------------retSultSum-------------"+retSultSum);
	
	retSultSum = "1";
%>
	
var response = new AJAXPacket();
response.data.add("retSultSum","<%=retSultSum%>");
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
core.ajax.receivePacket(response);