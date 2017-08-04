<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>	
<%
	String addr=request.getParameter("newAddress");//地址简写
	String bureau_id=request.getParameter("objectId");//先传当前处理局
	System.out.println("bureau_id==============="+bureau_id);
	String[][] result=null;
  String strArray="var arrMsg = new Array; ";  //must 
%>

<wtc:utype name="sSelAddr" id="retAddrInfo" scope="end">
     <wtc:uparam value="<%=addr%>" type="STRING"/>
     <wtc:uparam value="<%=bureau_id%>" type="STRING"/>
</wtc:utype>

<%
String retrunCode =retAddrInfo.getValue(0);
String returnMsg  =retAddrInfo.getValue(1);
strArray = CreatePlanerArray.createArray("arrMsg",retAddrInfo.getSize(2));
%>
<%=strArray%>
<%	
if(retrunCode.equals("0")){
	int lineNum=retAddrInfo.getSize(2);
	int colNum=retAddrInfo.getSize("2.0");
	
	result=new String[lineNum][colNum];

	for(int i=0;i<lineNum;i++){
			for(int j=0;j<colNum;j++){
					if(retAddrInfo.getValue("2."+i+"."+j) == null || retAddrInfo.getValue("2."+i+"."+j).trim().equals("")){
   						result[i][j] = "";
   						continue;
   				}
					result[i][j]=retAddrInfo.getValue("2."+i+"."+j);
%>
arrMsg[<%=i%>][<%=j%>] = "<%=result[i][j].trim()%>";
<%
			}
	}
}else{
	returnMsg="查询地址信息出错！";
}
%>
var verifyType="chooseAddress";

var response = new AJAXPacket();
	response.data.add("verifyType",verifyType);
	response.data.add("errorCode","<%= retrunCode %>");
	response.data.add("errorMsg","<%= returnMsg %>");
	
	response.data.add("arrMsg",arrMsg);

core.ajax.receivePacket(response);