<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%   
 String user_no_0022   = request.getParameter("user_no_0022");
 System.out.println("user_no_0022==="+user_no_0022);
 
 String checkFlag0022 = "" ;
%>
     <wtc:utype name="sChckFlwUserNo" id="retVal" scope="end" >
	      <wtc:uparam value="<%=user_no_0022%>" type="STRING"/> 
	      <wtc:uparam value="" type="STRING"/>    
     </wtc:utype>
<%		
	System.out.println("<<------------号码验证开始！！！！！！！！！！！！！！！！！！>>")	;
	String retCode=retVal.getValue(0);
	String retMsg=retVal.getValue(1);
	StringBuffer logBuffer = new StringBuffer(80);
	WtcUtil.recursivePrint(retVal,1,"2",logBuffer);		
	System.out.println(logBuffer.toString());
	if(retCode.equals("0"))
	{ 
		checkFlag0022 = retVal.getValue("2.0");
	}
%>
var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("checkFlag0022","<%=checkFlag0022%>");
core.ajax.receivePacket(response);