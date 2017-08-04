<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
    String retType = WtcUtil.repNull(request.getParameter("retType"));
    String checkpw = WtcUtil.repNull(request.getParameter("checkpw"));
		String loginNo = (String)session.getAttribute("workNo"); 
		String ip=(String)session.getAttribute("ipAddr");
		ip = "".equals(ip)?request.getRemoteAddr():ip;

%>
<wtc:service name="sLoginCheck" outnum="50" >
	<wtc:param value="<%=loginNo%>" />
  <wtc:param value="<%=checkpw%>" />
  <wtc:param value="<%=ip%>" />
</wtc:service>
<wtc:array id="str1" start="0"  length="24" scope="end"/>
<wtc:array id="str2" start="24" length="4" scope="end"/>
<wtc:array id="str3" start="27" length="8" scope="end"/>
<wtc:array id="str4" start="36" length="1" scope="end"/>
<wtc:array id="str5" start="37" length="1" scope="end"/>
<wtc:array id="str6" start="38" length="6" scope="end"/>
<wtc:array id="str7" start="44" length="1" scope="end"/>
	var response = new AJAXPacket();
	response.data.add("retType","<%=retType%>");
	response.data.add("retCode","<%=retCode%>");
	response.data.add("strmsg","<%=str1[0][1]%>");
	response.data.add("retMsg","<%=retMsg%>");
	core.ajax.receivePacket(response);




