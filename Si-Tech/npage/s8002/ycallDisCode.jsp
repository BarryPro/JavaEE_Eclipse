<%
/********************
version v2.0
开发商: si-tech
update:anln@2009-02-25 页面改造,修改样式
********************/
%>
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%@ page import="com.sitech.boss.RoleManage.wrapper.*"%>
<%@ page import="com.sitech.boss.common.viewBean.comImpl"%>
<%
	comImpl comResult = new comImpl();
	String regionCode = request.getParameter("region_code");
	String sql1 = "SELECT region_code,district_code,district_name,login_district FROM sdiscode WHERE region_code='"+regionCode+"'";
//	ArrayList disArr = RoleManageWrapper.getDisCode(regionCode);
	ArrayList disArr = comResult.spubqry32("2",sql1);
	String[][] disCode = (String[][])disArr.get(0);

%>
<%
	String strArray = CreatePlanerArray.createArray("disCode",disCode.length);

%>
<%=strArray%>
<%

for(int i = 0 ; i < disCode.length ; i ++){
      	for(int j = 1 ; j < disCode[i].length ; j ++){

%>

	disCode[<%=i%>][<%=j-1%>] = "<%=disCode[i][j].trim()%>";
<%
	}
}
%>
var response = new AJAXPacket();
response.data.add("backString",disCode);
response.data.add("flag","3");
core.ajax.receivePacket(response);
