<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String seqPara = request.getParameter("seqPara");
	String sequenceNo = "";
	System.out.println(".............................seqPara=="+seqPara);
%>
<wtc:utype name="sGetSeqNo" id="retSeqNo" scope="end" >
	<wtc:uparam value="<%=seqPara%>" type="INT"/>
	<wtc:uparam value="<%=regionCode%>" type="STRING"/>
	<wtc:uparam value="xx" type="STRING"/>
</wtc:utype>	
<%
	String retCode=String.valueOf(retSeqNo.getValue(0));
	String retMsg=retSeqNo.getValue(1);
	System.out.println(retCode+"-------------------------------------->"+retMsg);
	if(retCode.equals("0") && retSeqNo.getUtype("2").getSize() > 0 ){
		sequenceNo = retSeqNo.getValue("2.0");
	}
%>	


var response = new AJAXPacket();

response.data.add("errorCode","<%=retCode%>");
response.data.add("errorMsg","<%=retMsg%>");
response.data.add("sequenceNo","<%=sequenceNo%>");
core.ajax.receivePacket(response);