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
String phoneNo = request.getParameter("phoneno");
//String sqlStr="select oprcode,oprname from SOBBIZOPERCODE where bizlist like '%51%' order by oprcode";	

String sqlStr = "select count(*) FROM DBPRODADM.group_instance_member a, DBCUSTADM.dcustmsg b where a.member_role_id = '70032' AND a.exp_date > SYSDATE and a.serv_id = b.id_no and b.phone_no = '"+phoneNo+"'";

int callDataNum = 0;
%>
	<wtc:pubselect  name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="1">
		<wtc:sql><%=sqlStr%></wtc:sql>
	</wtc:pubselect>
	<wtc:array  id="callData" scope="end"/>	
<%
	if(callData!=null&&callData.length>0){
			callDataNum = callData.length;	
	} 
	
	String stringArray = WtcUtil.createArray("arrMsg",callDataNum);
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
response.data.add("verifyType","rhcount");
response.data.add("errorCode","0");
response.data.add("errorMsg","success");
response.data.add("backArrMsg",arrMsg );

core.ajax.receivePacket(response);
