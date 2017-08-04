<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ page import="java.util.*"%>

<%
System.out.println("----------------------------------------------fq046_getFeeInfo.jsp---------------------------------------");
	String servBusId = request.getParameter("servBusId");
	String objId = request.getParameter("objId");
	StringBuffer contentStr = new StringBuffer(80);
	StringBuffer opStr = new StringBuffer(80);
	System.out.println(".................servBusId ==" +servBusId);
%>
	 <wtc:utype name="sPMGetBaseFee" id="retVal" scope="end">
     <wtc:uparam value="<%=servBusId%>" type="LONG"/> 
   </wtc:utype>
<%
	String retCode = retVal.getValue(0);
  String retMessage = retVal.getValue(1).replace('\n',' ');
if(!retCode.equals("0"))
{
	opStr.append("1 ").append("2 ").append("3");
	%>
		var contentStr = <%=contentStr%> ;
		var opStr = <%=opStr%> ;
		var response = new AJAXPacket();
		response.data.add("opCodeStr",opCodeStr);
		response.data.add("opNameStr",opNameStr);
		response.data.add("contentStr",contentStr );
		core.ajax.receivePacket(response);
	<%
		return;
}
 		UType uu = retVal.getUtype(2);
		System.out.println("~~~~~~~~~~~~~~~~"+uu.getSize());
		contentStr.append("[");
		opStr.append("[");
		//费用串:	费用类型~费用代码~应收费用~优惠费用~是否打印~收取方式~说明
		for(int i = 0 ; i<uu.getSize();i++){
			String tmp  = uu.getValue(i+".3") + "~" + uu.getValue(i+".4") + "~" + uu.getValue(i+".5") + "~" + uu.getValue(i+".6") + "~" + uu.getValue(i+".8") + "~" + uu.getValue(i+".9")+ "~" + uu.getValue(i+".10")+"~";
			contentStr.append("'"+tmp+"',");
			opStr.append("'"+ uu.getValue(i+".4") +"->" + uu.getValue(i+".10") + " ',");
			System.out.println("~~~~~~~~~~~~~~~~"+tmp);
		}
		contentStr.append("' ']");
		opStr.append("' ']");
		System.out.println(contentStr);
		System.out.println(opStr);
%>
var contentStr = <%=contentStr%> ;
var opStr = <%=opStr%>;

var response = new AJAXPacket();
response.data.add("contentStr",contentStr );
response.data.add("opStr",opStr);
response.data.add("objId","<%=objId%>" );
core.ajax.receivePacket(response);