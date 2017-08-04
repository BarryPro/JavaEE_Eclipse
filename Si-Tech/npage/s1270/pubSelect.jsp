<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%
	String sqlStr = WtcUtil.repNull(request.getParameter("sqlStr"));	
	String strArray="var resultAry;";  
	
%>
<wtc:pubselect name="sPubSelect" outnum="2">
	<wtc:sql><%=sqlStr%></wtc:sql> 
</wtc:pubselect>
<wtc:array id="result" scope="end"/>
<%
	if(retCode.equals("000000") && result.length > 0){
		strArray = CreatePlanerArray.createArray("resultAry",result.length);
%>		
		<%=strArray%>
<%	
		for(int i=0;i<result.length;i++){
			for(int j=0;j<result[i].length;j++){
%>
			resultAry[<%=i%>][<%=j%>] = "<%=result[i][j]%>";
<%	
			}
		}	
	}else{
%>		
	 <%=strArray%>
<%
	}
%>

var response = new AJAXPacket();

response.data.add("errorCode","<%=retCode%>");
response.data.add("errorMsg","<%=retMsg%>");
response.data.add("resultAry",resultAry);
core.ajax.receivePacket(response);