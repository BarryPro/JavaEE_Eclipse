<%
   /*
   * 功能: 快捷键提示信息设置
　 * 版本: v1.0
　 * 日期: 2008年12月9日
　 * 作者: chenjy
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType= "text/html;charset=GBK" %>

<%
	String workNo = (String)session.getAttribute("workNo");
	String regionCode = (String)session.getAttribute("regCode");
	String skinType=(String)request.getParameter("skinType");
	String layout=(String)request.getParameter("layout");
	String vVilidFlag = "1";
	
%> 
	<wtc:service name="sSkinUpd" outnum="1" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=skinType%>"/> 
		<wtc:param value="<%=vVilidFlag%>"/>
        <wtc:param value="<%=layout%>"/>
		<wtc:param value=""/> 
	</wtc:service>
<%
    if("000000".equals(retCode)){
        session.setAttribute("cssPath",skinType);
        session.setAttribute("layout",layout);
    }



/**  modified by hejwa in 20110714 多OP改造--工作区通讯改造  begin **/ 
String  powerCode = session.getAttribute("powerCode")==null?"":((String)session.getAttribute("powerCode")).trim();//角色代码
String ip_Addr = (String)session.getAttribute("ipAddr");
String tabNum = request.getParameter("tabNum")==null?"":request.getParameter("tabNum").trim();
String rightkey = request.getParameter("rightkey")==null?"":request.getParameter("rightkey").trim();
String themePath = request.getParameter("themePath")==null?"":request.getParameter("themePath").trim();
	String layout_css = layout;
	String theme_css  = skinType;
	
%>
<wtc:service name="sDwkSpaceSet" outnum="0" routerKey="region" routerValue="<%=regionCode%>">
	  <wtc:param value="1"/>
	  <wtc:param value="<%=workNo%>"/>
	  <wtc:param value=""/>	
	  <wtc:param value=""/>	
	  <wtc:param value="<%=tabNum%>"/>
	  <wtc:param value="<%=rightkey%>"/>
	  <wtc:param value="<%=workNo%>" />
	  <wtc:param value="d555" />
      <wtc:param value="<%=ip_Addr%>" />
      <wtc:param value="<%=powerCode%>" />
      <wtc:param value="我的工作区设置" />
      <wtc:param value="<%=layout_css%>" />
      <wtc:param value="<%=theme_css%>" />	
</wtc:service>
<%
/**  modified by hejwa in 20110714 多OP改造--工作区通讯改造  end **/ 

%>
var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
response.data.add("skinType","<%=skinType%>");
response.data.add("layout","<%=layout%>");
core.ajax.receivePacket(response);
