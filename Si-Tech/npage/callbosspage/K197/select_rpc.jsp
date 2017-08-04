<%request.setCharacterEncoding("GB2312");%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.util.*"%>
<%
		ArrayList arr = (ArrayList)session.getAttribute("allArr");
		String[][] baseInfo = (String[][])arr.get(0);
		String regionCode = (baseInfo[0][16]).substring(0,2);
		String sqlStr = ReqUtil.get(request,"sqlStr");
	  String para = ReqUtil.get(request,"para");
%>
        <wtc:service  name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"   outnum="2">
				  <wtc:param value="<%=sqlStr%>" />
				  <wtc:param value="<%=para%>" />
				</wtc:service>
				<wtc:array id="tri_metaData" scope="end"/>
<%
String tri_metaDataStr = CreatePlanerArray.createArray("js_tri_metaDataStr",tri_metaData.length);
%>
<%=tri_metaDataStr%>
<%   
  for(int p=0;p<tri_metaData.length;p++)
  {
	  for(int q=0;q<tri_metaData[p].length;q++)
	  {
	   System.out.println(tri_metaData[p][q]);
%>
        js_tri_metaDataStr[<%=p%>][<%=q%>]="<%=tri_metaData[p][q]%>";
<%
	  }
  }
%>
var response = new AJAXPacket();
response.guid = '<%= request.getParameter("guid") %>';
response.data.add("rpc_page","chg_city");
response.data.add("tri_list",js_tri_metaDataStr);
core.ajax.receivePacket(response);



