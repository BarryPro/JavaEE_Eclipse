<%
/********************
 * version v2.0
 * ¿ª·¢ÉÌ: si-tech
 * update by qidp @ 2009-02-05
 ********************/
%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%
String regionCode = (String)session.getAttribute("regCode");
String spid=request.getParameter("spid");
String sqlStr="select dd.spid,dd.bizcode,dd.biztype,dd.billingtype from ddsmpspbizinfo dd where dd.spid = '"+spid+"' and dd.bizstatus <> 'N'";	
int callDataNum = 0;
System.out.println("test001getnewspinfo=="+sqlStr);
%>
	<wtc:pubselect  name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="4">
		<wtc:sql><%=sqlStr%></wtc:sql>
	</wtc:pubselect>
	<wtc:array  id="callData" scope="end"/>	
<%
	if(callData!=null&&callData.length>0){
			callDataNum = callData.length;	
	} 
	
	String stringArray = WtcUtil.createArray("arrMsg",callDataNum);
	
	System.out.println("test001=="+callData.length);

%> 
	<%=stringArray%>
<%
	for(int i = 0 ; i < callData.length ; i ++){
	  for(int j = 0 ; j < callData[i].length ; j ++){
			if(callData[i][j].trim().equals("") || callData[i][j] == null){
			   callData[i][j] = "";
			}
%>
			arrMsg[<%=i%>][<%=j%>] = "<%=callData[i][j].trim()%>";
<%
	  }
	}
%>  
var response = new AJAXPacket();

response.guid = '<%= request.getParameter("guid") %>';
response.data.add("verifyType","newspinfo");
response.data.add("errorCode","0");
response.data.add("errorMsg","success");
response.data.add("backArrMsg",arrMsg );

core.ajax.receivePacket(response);
