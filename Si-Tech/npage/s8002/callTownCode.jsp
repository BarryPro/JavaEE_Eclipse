<%
/********************
version v2.0
开发商: si-tech
update:anln@2009-02-25 页面改造,修改样式
********************/
%>
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.RoleManage.wrapper.*"%>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%@ page import="com.sitech.boss.common.viewBean.comImpl"%>
<%
	comImpl comResult = new comImpl();
	String dis_code = request.getParameter("dis_code");
	String region_code = request.getParameter("region_code");
	String sql1 = "SELECT town_code,town_name,login_town,region_code,district_code FROM stowncode WHERE district_code='"+dis_code+"' and and region_code='"+region_code+"'";
//	ArrayList townArr = RoleManageWrapper.getTownCode(region_code,dis_code);
	ArrayList townArr = comResult.spubqry32("2",sql1);
	String[][] townCode = (String[][])townArr.get(0);
%>
<%
	String strArray = CreatePlanerArray.createArray("townCode",townCode.length);
%>
<%=strArray%>
<%

for(int i = 0 ; i < townCode.length ; i ++){
      for(int j = 0 ; j < townCode[i].length-2 ; j ++){


%>
townCode[<%=i%>][<%=j%>] = "<%=townCode[i][j].trim()%>";
<%
}
}
%>
var response = new AJAXPacket();
response.data.add("backString",townCode);
response.data.add("flag","1");
core.ajax.receivePacket(response);
