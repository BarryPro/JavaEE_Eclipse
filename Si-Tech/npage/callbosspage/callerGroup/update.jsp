
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%


String id=request.getParameter("id")==null?"":request.getParameter("id");
String phone=request.getParameter("phone")==null?"":request.getParameter("phone");
String class_id=request.getParameter("class_id")==null?"":request.getParameter("class_id");
String Region_Code=request.getParameter("Region_Code")==null?"":request.getParameter("Region_Code");
String note=request.getParameter("note")==null?"":request.getParameter("note");
String outflag=request.getParameter("outflag")==null?"":request.getParameter("outflag");
String orgCode = (String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2);


String sqlArr="UPDATE Dcallercalloutphone d SET d.Region_Code = :v1 , d.Caller_Call_Out_Phone = :v2 , note =:v3 , classid = :v4,outflag = :v5 WHERE d.Caller_Call_Out_Id = :v6";

%>
<wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
<wtc:param value="<%=sqlArr%>"/>
<wtc:param value="dbchange"/>
<wtc:param value="<%=Region_Code%>"/>
<wtc:param value="<%=phone%>"/>
<wtc:param value="<%=note%>"/>
<wtc:param value="<%=class_id%>"/>
<wtc:param value="<%=outflag%>"/>
<wtc:param value="<%=id%>"/>
</wtc:service>
<wtc:array id="retRows"  scope="end"/>	
	
	
var response = new AJAXPacket();
response.data.add("retCode",<%=retCode%>);
core.ajax.receivePacket(response);
