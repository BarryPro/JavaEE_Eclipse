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
<%
	String dis_code = request.getParameter("dis_code");
	String region_code = request.getParameter("region_code");

	String sql = "";	
	sql = "SELECT a.town_code,a.town_code||'->'||a.town_name,a.login_town FROM stowncode a, dchngroupmsg b  WHERE a.district_code='"+dis_code+"' and a.region_code='"+region_code+"' and a.group_id=b.group_id and b.is_active='Y' order by a.town_code  ";
	System.out.println("liangyl---------------sql="+sql);
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=region_code%>"  retcode="retCode1" retmsg="retMsg1" outnum="3">
		<wtc:sql><%=sql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="al" scope="end" />
<%
	//List al = co.spubqry32("3",sql);
	String townStrs[][]=null;
	String strArray = "";
	if(al != null&&al.length>0)
	{
		townStrs = al;
		strArray = CreatePlanerArray.createArray("townCode",townStrs.length);
	}else{
		strArray = CreatePlanerArray.createArray("townCode",0);
	}
%>
<%=strArray%>
<%
if(al != null&&al.length>0){
	for(int i = 0 ; i < townStrs.length ; i ++)
	{
	      for(int j = 0 ; j < townStrs[i].length ; j ++)
	      {      
	%>
	townCode[<%=i%>][<%=j%>] = "<%=townStrs[i][j].trim()%>";
	<%
		  }
	}
	}
%>
var response = new AJAXPacket();
response.data.add("backString",townCode);
response.data.add("flag","4");
core.ajax.receivePacket(response);
