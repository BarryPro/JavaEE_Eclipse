<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%
		//-------------------提取订购/退订信息-------------------
		String servId = WtcUtil.repNull(request.getParameter("servId"));
		String loginAccept = WtcUtil.repNull(request.getParameter("loginAccept"));
		String workNo = (String)session.getAttribute("workNo");
		String strArray="var retAry;";  
%>
<wtc:utype name="sGetChgBuffMsg" id="retVal" scope="end">
	<wtc:uparam value="<%=workNo%>" type="string"/>	
  <wtc:uparam value="<%=loginAccept%>" type="long"/>
  <wtc:uparam value="<%=servId%>" type="long"/>	
</wtc:utype>

<%
	String retCode = retVal.getValue(0);
	String retMsg  = retVal.getValue(1).replaceAll("\\n"," ");
	
	StringBuffer logBuffer = new StringBuffer(80);
	WtcUtil.recursivePrint(retVal,1,"2",logBuffer);
	System.out.println(logBuffer.toString());
	
	if(retCode.equals("0")){
		int retValNum = retVal.getUtype("2").getSize();
	System.out.println("@@@@---sSearShortMsgHis---------------retValNum------"+retValNum);	
	  strArray = WtcUtil.createArray("retAry",retValNum);
%>
		<%=strArray%>
<%	  
		for(int i=0;i<retValNum;i++){
			UType uType = retVal.getUtype("2."+i);
			for(int j=0;j<uType.getSize();j++){
			//System.out.println("liubo ========="+uType.getValue(j));
%>
			retAry[<%=i%>][<%=j%>] = "<%=uType.getValue(j)%>";
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
response.data.add("retAry",retAry);
core.ajax.receivePacket(response);