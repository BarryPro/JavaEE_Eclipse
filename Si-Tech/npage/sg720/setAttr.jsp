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
	String opCode = WtcUtil.repNull(request.getParameter("opCode"));
	String effT = WtcUtil.repNull(request.getParameter("effT"));	
	effT = effT.replaceAll(" ","");
	effT = effT.replaceAll(":","");
	String sysCurrTime = new SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date());//系统当前时间
	String [] attrAry = attrStr.split("\\$");
	String workNo = (String)session.getAttribute("workNo");
	System.out.println("---------attrStr-----------"+attrStr);
	System.out.println("---------queryId-----------"+queryId);
	System.out.println("---------loginAccept-----------"+loginAccept);
	System.out.println("---------attrStr-----------"+attrStr);
	
	System.out.println("---------workNo-----------"+workNo);
	System.out.println("---------effT-----------"+effT);
	System.out.println("---------opCode-----------"+opCode);
	
%>
<wtc:utype name="sSetAttrVal" id="retVal" scope="end">
	<%
			for(int i = 0;i<attrAry.length;i++){
			String attrId = attrAry[i].split("~")[0];
			String attrValue = attrAry[i].split("~")[1];
			System.out.println("---------attrId------"+attrId+"------>"+attrValue);
		%>
		<wtc:uparams name="attrValArr" iMaxOccurs="1">
			<wtc:uparam value="<%=queryTypeId%>" type="string"/>	
		  <wtc:uparam value="<%=loginAccept%>" type="long"/>
		  <wtc:uparam value="<%=workNo%>" type="string"/>	
		  <wtc:uparam value="<%=queryId%>" type="int"/>
		  <wtc:uparam value="<%=offerInstId%>" type="long"/>	
			<wtc:uparam value="<%=attrId%>" type="int"/>
			<wtc:uparam value="<%=attrValue%>" type="string"/>	
		  <wtc:uparam value="1" type="string"/>	
		  <wtc:uparam value="<%=opCode%>" type="string"/>	
		  <wtc:uparam value="<%=effT%>" type="string"/>
		  <wtc:uparam value="20500101000001" type="string"/>	
		 </wtc:uparams>		
	 <%
		}  	
	 %>			
</wtc:utype>

<%
	String retCode = retVal.getValue(0);
	String retMsg  = retVal.getValue(1).replaceAll("\\n"," ");
	
	System.out.println("--------------------retCode------------------"+retCode);
	System.out.println("--------------------retMsg-------------------"+retMsg);
%>

var response = new AJAXPacket();

response.data.add("errorCode","<%=retCode%>");
response.data.add("errorMsg","<%=retMsg%>");
core.ajax.receivePacket(response);
