<%request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=gbk" %>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%@ page import="com.sitech.boss.s1210.pub.Pub_lxd"%>
<%@ page import="com.sitech.boss.s1270.viewBean.*" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.util.*"%>
<%@ page import="java.util.*;"%>
<%@ page import="java.io.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%/*
* ǰ̨����ͨ��RPC��������  2003-12-25
* @author  ghostlin
* @version 1.0
* @since   JDK 1.4
* Copyright (c) 2002-2003 si-tech All rights reserved.
*/%>
<%/*
* ע����������������ҳ���ı����λ�õ��Ⱥ�˳�����һ���ı���Ϊi1���Դ����ơ�
		���ֱ������������ݶԴ˱���ʹ�õ����壬����;��
*/%>
<%/*
*��ҳ�����ڶ�RPC�������÷��񣬲����ؽ����
*/%>

<%
	S1270View  callView = new S1270View();   
	String sqlStrNo = ReqUtil.get(request,"sqlStrNo");
	String sqlStrVal = ReqUtil.get(request,"sqlStrVal");
	ArrayList retArray_select = new ArrayList();
	
	String org_Code = (String)session.getAttribute("orgCode");
	String regionCode = org_Code.substring(0,2);

	//retArray_select = callView.spubqry32Process("2","0",sqlStr).getList();
%>
<wtc:service name="sCrmDefSqlSel"  routerKey="region" routerValue="<%=regionCode%>" outnum="2">
        <wtc:param value="<%=sqlStrNo%>"/>
        <wtc:param value="<%=sqlStrVal%>"/>
</wtc:service>
<wtc:array id="returnStr1" scope="end" />
<%
	String[][] tri_metaData = returnStr1;
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
response.data.add("tri_list",js_tri_metaDataStr);
core.ajax.receivePacket(response);



