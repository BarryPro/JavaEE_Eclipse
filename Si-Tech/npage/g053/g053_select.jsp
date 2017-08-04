<%request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=gbk" %>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%@ page import="com.sitech.boss.s1270.viewBean.*" %>
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
	S1270View  callView = new S1270View(); 
	String[] inParas1 =new String[2];  
	inParas1[0] = ReqUtil.get(request,"sqlStr");
	inParas1[1] = ReqUtil.get(request,"param1");
%>

<wtc:service name="TlsPubSelBoss"  retcode="retCode2" retmsg="retMsg2" outnum="2">
		    <wtc:param value="<%=inParas1[0]%>"/>
			<wtc:param value="<%=inParas1[1]%>"/>
		</wtc:service>
<wtc:array id="result" scope="end" />
<%
  String[][] tri_metaData = result;
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



