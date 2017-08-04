<%@ page contentType= "text/html;charset=GBK" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
String objId = request.getParameter("objId");
String workNo = (String)session.getAttribute("workNo");
StringBuffer contentStr = new StringBuffer(80);
StringBuffer opStr   = new StringBuffer(80);
String orgCode = (String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2);
%>

<%@ include file="dispatch.jsp" %>
<wtc:service name="sGetWorkDataNew" routerKey="region" routerValue="<%=regionCode%>"  outnum="10" >
	<wtc:param value="<%=workNo%>" />
  	<wtc:param value="1" />
  	<wtc:param value="99999" />
  	<wtc:param value="999" />
	</wtc:service>
	<wtc:array id="func" scope="end"/>	
<%
if(!retCode.equals("0"))
{
%>
	var opStr = "<%=opStr%>" ;
	var contentStr = "<%=contentStr%>" ;
	var response = new AJAXPacket();
		response.data.add("opStr",opStr);
		response.data.add("contentStr",contentStr );
		core.ajax.receivePacket(response);
<%
return;
}
%>

<%
int func_size=func.length;
contentStr.append("[");
opStr.append("[");
for(int i=0;i<func_size;i++){

	if(!func[i][3].trim().equals("#")){
		String tmp = getLink(func[i][7],func[i][3],func[i][1],session,request,func[i][9]);
		opStr.append("'").append(func[i][1]).append(" ").append(func[i][9]).append("'");		 
		contentStr.append("['").append(func[i][7]).append("','").append(func[i][1]).append("', '").append(func[i][9]).append("', '").append(tmp).append("', '").append(func[i][5]).append("']");
		
		if(i!=func_size-1) 
		{
			opStr.append(",");
			contentStr.append(",");
		}
  }
}
opStr.append("]"); 	
contentStr.append("]"); 
%>
var opStr = "<%=opStr%>" ;
var contentStr = <%=contentStr%> ;  
var response = new AJAXPacket();
response.data.add("opStr",opStr);
response.data.add("contentStr",contentStr );
response.data.add("objId","<%=objId%>" );
core.ajax.receivePacket(response);
