<%request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=gbk" %>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.util.*"%>
<%/*
* 前台报表通过RPC处理结果集  2003-12-25
* @author  ghostlin
* @version 1.0
* @since   JDK 1.4
* Copyright (c) 2002-2003 si-tech All rights reserved.
*/%>
<%/*
* 注：变量的命名依据页面文本域的位置的先后顺序，如第一个文本域为i1，以此类推。
		部分变量的命名依据对此变量使用的意义，或用途。
*/%>
<%/*
*此页面用于对RPC连动调用服务，并穿回结果集
*/%>

<%
		String regionCode = (String)session.getAttribute("regCode");

String retType = WtcUtil.repNull(request.getParameter("retType"));
	String sqlStr = ReqUtil.get(request,"sqlStr");
		/* 参数 */
	String param = WtcUtil.repNull(request.getParameter("params"));
  String [] params = param.split("\\|");
	String  wtcOutNum =WtcUtil.repNull(request.getParameter("outNum"));
	System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA查询-----"+sqlStr);//打印查询语句到控制台
	
%>
 <wtc:service name="sDynSqlCfm" routerKey="region" routerValue="<%=regionCode%>" outnum="<%=wtcOutNum%>" retcode="retCode" retmsg="retMsg">
		  <wtc:param value="<%=sqlStr%>"/>
		 <%
		 		for(int i=0;i<params.length;i++){
		 %>		
		 		 <wtc:param value="<%=params[i]%>"/>
		 	<%
		 		}
		 %>
	</wtc:service>
	<wtc:array id="tri_metaData" scope="end"/>
<%
	String tri_metaDataStr = CreatePlanerArray.createArray("js_tri_metaDataStr",tri_metaData.length);
	System.out.println("tri_metaData[][]======"+tri_metaData.length);
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
response.data.add("retType","<%=retType%>");
response.data.add("tri_list",js_tri_metaDataStr);
core.ajax.receivePacket(response);



