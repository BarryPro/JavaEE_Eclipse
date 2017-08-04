<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>

<%
  String login_no =(String) session.getAttribute("workNo");//工号
  String groupId = WtcUtil.repNull(request.getParameter("groupId"));//销售品编码
  System.out.println("---------------------------ajax_getHotOffer.jsp----------------------"+groupId);
  System.out.println("---------------------------login_no----------------------"+login_no);
  
%>

<wtc:utype name="sGetHotBOffer" id="retVal" scope="end">
			<wtc:uparam value="1104" type="STRING"/>  
			<wtc:uparam value="<%=groupId%>" type="STRING"/>  
			<wtc:uparam value="" type="STRING"/>
</wtc:utype>
var retResult = new Array();
<%
	 String retCode = retVal.getValue(0);
	 String retMsg = retVal.getValue(1).replaceAll("\\n"," "); 
   int retValNum = retVal.getUtype("2").getSize();
   System.out.println("--------------------retValNum--------------------"+retValNum);
	 System.out.println("retCode|"+retCode+"\n"+"retMsg|"+retMsg);
	 String temp="";
	 	StringBuffer logBuffer = new StringBuffer(80);
    System.out.println(logBuffer.toString());
 		WtcUtil.recursivePrint(retVal,1,"2",logBuffer);
 		
 		for(int i=0;i<retValNum;i++){
 			System.out.println("-----------------retVal.getUtype(2.+i).getValue(0)----------------"+retVal.getUtype("2."+i).getValue(0));
 			System.out.println("-----------------retVal.getUtype(2.+i).getValue(1)----------------"+retVal.getUtype("2."+i).getValue(1));
 			System.out.println("-----------------retVal.getUtype(2.+i).getValue(2)----------------"+retVal.getUtype("2."+i).getValue(2));
 			System.out.println("-----------------retVal.getUtype(2.+i).getValue(3)----------------"+retVal.getUtype("2."+i).getValue(3));
 			System.out.println("-----------------retVal.getUtype(2.+i).getValue(4)----------------"+retVal.getUtype("2."+i).getValue(4));
 			System.out.println("-----------------retVal.getUtype(2.+i).getValue(5)----------------"+retVal.getUtype("2."+i).getValue(5));
 			System.out.println("-----------------retVal.getUtype(2.+i).getValue(6)----------------"+retVal.getUtype("2."+i).getValue(6));
 			System.out.println("-----------------retVal.getUtype(2.+i).getValue(7)----------------"+retVal.getUtype("2."+i).getValue(7));
 			System.out.println("-----------------retVal.getUtype(2.+i).getValue(8)----------------"+retVal.getUtype("2."+i).getValue(8));
 			System.out.println("-----------------retVal.getUtype(2.+i).getValue(9)----------------"+retVal.getUtype("2."+i).getValue(9));
 			System.out.println("-----------------retVal.getUtype(2.+i).getValue(10)----------------"+retVal.getUtype("2."+i).getValue(10));
 			System.out.println("-----------------retVal.getUtype(2.+i).getValue(11)----------------"+retVal.getUtype("2."+i).getValue(11));
 			System.out.println("-----------------retVal.getUtype(2.+i).getValue(12)----------------"+retVal.getUtype("2."+i).getValue(12));
 			System.out.println("-----------------retVal.getUtype(2.+i).getValue(13)----------------"+retVal.getUtype("2."+i).getValue(13));
 			System.out.println("-----------------retVal.getUtype(2.+i).getValue(14)----------------"+retVal.getUtype("2."+i).getValue(14));
 			System.out.println("-----------------retVal.getUtype(2.+i).getValue(15)----------------"+retVal.getUtype("2."+i).getValue(15));
 		%>
 		retResult[<%=i%>] = new Array();
 		
 		retResult[<%=i%>][0] =  "<%=retVal.getUtype("2."+i).getValue(0)%>";
 		retResult[<%=i%>][1] =  "<%=retVal.getUtype("2."+i).getValue(1)%>";
 		retResult[<%=i%>][2] =  "<%=retVal.getUtype("2."+i).getValue(2)%>";
 		retResult[<%=i%>][3] =  "<%=retVal.getUtype("2."+i).getValue(3)%>";
 		retResult[<%=i%>][4] =  "<%=retVal.getUtype("2."+i).getValue(4)%>";
 		retResult[<%=i%>][5] =  "<%=retVal.getUtype("2."+i).getValue(5)%>";
 		retResult[<%=i%>][6] =  "<%=retVal.getUtype("2."+i).getValue(6)%>";
 		retResult[<%=i%>][7] =  "<%=retVal.getUtype("2."+i).getValue(7)%>";
 		retResult[<%=i%>][8] =  "<%=retVal.getUtype("2."+i).getValue(8)%>";
 		retResult[<%=i%>][9] =  "<%=retVal.getUtype("2."+i).getValue(9)%>";
 		retResult[<%=i%>][10] = "<%=retVal.getUtype("2."+i).getValue(10)%>";
 		retResult[<%=i%>][11] = "<%=retVal.getUtype("2."+i).getValue(11)%>";
 		retResult[<%=i%>][12] = "<%=retVal.getUtype("2."+i).getValue(12)%>";
 		retResult[<%=i%>][13] = "<%=retVal.getUtype("2."+i).getValue(13)%>";
 		retResult[<%=i%>][14] = "<%=retVal.getUtype("2."+i).getValue(14)%>";
 		retResult[<%=i%>][15] = "<%=retVal.getUtype("2."+i).getValue(15)%>";
 		
 		<%
 		}
		%>


var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
response.data.add("retResult",retResult);
core.ajax.receivePacket(response);