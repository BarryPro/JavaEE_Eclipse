<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
	String queryTypeId = WtcUtil.repNull(request.getParameter("queryTypeId"));
	String loginAccept = WtcUtil.repNull(request.getParameter("loginAccept"));
	String queryId = WtcUtil.repNull(request.getParameter("queryId"));
	String offerInstId = WtcUtil.repNull(request.getParameter("offerInstId"));
	String attrStr = WtcUtil.repNull(request.getParameter("attrStr"));
	String sysCurrTime = new SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date());//系统当前时间
	String [] attrAry = attrStr.split("\\$");
	System.out.println("---------attrStr-----------"+attrStr);
	System.out.println("---------queryId-----------"+queryId);
	System.out.println("---------loginAccept-----------"+loginAccept);
	System.out.println("---------attrStr-----------"+attrStr);
	
%>
<wtc:utype name="sSetAttrVal" id="retVal" scope="end">
<wtc:uparams name="attrValArr" iMaxOccurs="1">
	<wtc:uparam value="<%=queryTypeId%>" type="string"/>	
  <wtc:uparam value="<%=loginAccept%>" type="long"/>
  <wtc:uparam name="workNo" type="string"/>	
  <wtc:uparam value="<%=queryId%>" type="int"/>
  <wtc:uparam value="<%=offerInstId%>" type="long"/>	
		<%
			for(int i = 0;i<1;i++){
			String attrId = attrAry[i].split("~")[0];
			String attrValue = attrAry[i].split("~")[1];
			System.out.println("---------attrId------"+attrId+"------>"+attrValue);
		%>
				<wtc:uparam value="<%=attrId%>" type="int"/>
				<wtc:uparam value="<%=attrValue%>" type="string"/>	
		<%
			}  	
		%>	
  <wtc:uparam value="1" type="string"/>	
  <wtc:uparam value="qp01" type="string"/>	
  <wtc:uparam value="<%=sysCurrTime%>" type="string"/>
  <wtc:uparam value="20500101000001" type="string"/>	
 </wtc:uparams>					
</wtc:utype>

<%
	String retCode = retVal.getValue(0);
	String retMsg  = retVal.getValue(1).replaceAll("\\n"," ");
%>

var response = new AJAXPacket();

response.data.add("errorCode","<%=retCode%>");
response.data.add("errorMsg","<%=retMsg%>");
core.ajax.receivePacket(response);