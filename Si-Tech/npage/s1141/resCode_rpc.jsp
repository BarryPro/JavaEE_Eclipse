 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-02-16 页面改造,修改样式
	********************/
%>
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%@ page import="com.sitech.boss.util.*"%>
<%
	//S1270View  callView = new S1270View();   
	String sqlStr = ReqUtil.get(request,"sqlStr");
	String regionCode = (String)session.getAttribute("regCode");
	System.out.println("-----"+sqlStr);//打印查询语句到控制台
	//retArray_select = callView.spubqry32Process("2","0",sqlStr).getList();
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
		<wtc:sql><%=sqlStr%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="tri_metaData" scope="end" />
<%
	//String[][] tri_metaData = (String[][])retArray_select.get(0);
	String tri_metaDataStr = CreatePlanerArray.createArray("js_tri_metaDataStr",tri_metaData.length);
%>
	<%=tri_metaDataStr%>
	<%   
	  for(int p=0;p<tri_metaData.length;p++)
	  {
		  for(int q=0;q<tri_metaData[p].length;q++)
		  {
	%>
	        js_tri_metaDataStr[<%=p%>][<%=q%>]="<%=tri_metaData[p][q]%>";
	<%
		  }
	  }
	%>

var response = new AJAXPacket();
response.data.add("rpc_page","chg_city");
response.data.add("tri_list",js_tri_metaDataStr);
core.ajax.receivePacket(response);



