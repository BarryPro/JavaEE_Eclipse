<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="java.util.*"%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
	String[][] callData = null;
	String strArray = "var arrMsg; ";
	String errorCode = "444444";
	String errorMsg = "系统错误，请与系统管理员联系，谢谢!!";
	

	
	String verifyType = request.getParameter("verifyType");
	
	String character_number = request.getParameter("character_number");
	String character_value = request.getParameter("character_value");
	String sPOSpecNumber  = request.getParameter("sPOSpecNumber");
	
	

	//wuxy alter 20090925 去掉 AND b.product_status = '1'
	String sqlStr = "SELECT COUNT(*) FROM dproductspecinfo  a,dproductcharacterinfo e ,dproductcharacter c,sprodcharactercode d "
	                +" WHERE substr(trim(c.character_number),length(trim(c.character_number))-3,4)=d.character_number_end4   and c.character_value = '"+character_value.trim()+"'"
	                +" and d.field_code='00006' and a.pospec_number='"+sPOSpecNumber.trim()+"' and a.productspec_number=e.productspec_number and e.productcharacter_num=c.character_number  ";
	
%>


<wtc:pubselect name="sPubSelect" routerKey="region"
	retcode="retCode" retmsg="retMsg"
	outnum="1">
	<wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result" scope="end" />
<%
callData = result;
strArray = WtcUtil.createArray("arrMsg",callData.length);
%>
<%=strArray%>
<%
	for (int i = 0; i < callData.length; i++) {
		for (int j = 0; j < callData[i].length; j++) {

			if (callData[i][j].trim().equals("") || callData[i][j] == null) {
				callData[i][j] = "";
			}
%>
arrMsg[<%=i%>][<%=j%>] = "<%=callData[i][j].trim()%>";
<%
		}
	}
%>


var response = new AJAXPacket(); 
response.data.add("verifyType",'<%=verifyType%>');
response.data.add("errorCode",'<%=retCode%>');
response.data.add("errorMsg",'<%=retMsg%>');
response.data.add("backArrMsg",arrMsg);
response.data.add("inputCharacter_number",'<%=character_number%>');
core.ajax.receivePacket(response);

