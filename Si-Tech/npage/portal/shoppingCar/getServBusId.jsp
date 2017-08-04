<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>

<%
  String offer_id = WtcUtil.repNull(request.getParameter("offer_id"));
	String strArray="var arrMsg; ";  //must
System.out.println("###################################################offer_id==="+offer_id);
%>
<wtc:utype name="sPMQServOffer" id="retVal" scope="end" >
			 <wtc:uparam value="<%=offer_id%>" type="LONG"/>  
</wtc:utype>
<%
	 String retCode = retVal.getValue(0);
	 String retMsg = retVal.getValue(1).replaceAll("\\n"," "); 
	 System.out.println("###################################################retMsg==="+retMsg);
	 System.out.println("###################################################retCode==="+retCode);
	 String location = "";
	  if(retCode.equals("0"))
	{
		strArray = WtcUtil.createArray("arrMsg",1);
		%>
		<%=strArray%>
		<%
					String temp = retVal.getUtype("2").getValue(1);
					if(temp == null || temp.trim().equals(""))
					{
						temp = "";
					}
					System.out.println("###################################################temp==="+temp);
	%>
					arrMsg[0][0] = "<%=temp.trim()%>";
					
	<%		
	}else{
		%>
		arrMsg=null;
		<%
		}
		
		System.out.println("---------------------retMsg-------------############------------"+retMsg);
		System.out.println("---------------------retCode-------------------------"+retCode);
%>


var response = new AJAXPacket();
response.data.add("retCode","<%= retCode %>");
response.data.add("retMsg","<%= retMsg %>");
response.data.add("backArrMsg",arrMsg);
core.ajax.receivePacket(response);