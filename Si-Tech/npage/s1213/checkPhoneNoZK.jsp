<%
/********************
 * version v2.0
 * ¿ª·¢ÉÌ: si-tech
 * update by wanglm @ 20110613
 ********************/
%>
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>  
<%
	String regionCode=(String)session.getAttribute("regCode");
	String phoneNo = request.getParameter("phoneNo");
	String sql = "  select a.contract_no from dConMsg a, dCustMsg b, dConUserMsg c  where a.contract_no = c.contract_no  and b.id_no = c.id_no  and b.phone_no = '"+phoneNo+"'";
	String accountNo = "";
	String[][] result1 = new String[][]{};
	String flag = "";
	String retc = "";
	String retm = "";
%>

	<wtc:pubselect name="sPubSelect" outnum="1"  routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" >
	 <wtc:sql><%=sql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result" scope="end"/>  
	
   <%
	if(result != null && result.length > 0){
		accountNo = result[0][0];
		%>
		   	<wtc:service name="bs_s1216Query" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1">
	        <wtc:param value="<%=accountNo%>"/>
	        </wtc:service>
	        <wtc:array id="resultArr" scope="end" />
		<%
		result1 = resultArr ;
		retc = retCode1 ;
		retm = retMsg1 ;
	}
	
	if(result1 != null && result1.length > 0){
	   flag = result1[0][0];
    }
	%>
var response = new AJAXPacket();
response.data.add("retc","<%=retc%>");
response.data.add("retm","<%=retm%>");
response.data.add("flag","<%=flag%>");
core.ajax.receivePacket(response);

	    
		