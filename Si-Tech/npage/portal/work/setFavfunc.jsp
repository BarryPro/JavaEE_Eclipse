<%
   /*
   *   功能: 设置营业员常用功能
　 * 版本: v1.0
　 * 日期: 2008/03/30
　 * 作者: wuln
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType= "text/html;charset=gb2312" %>
<%
     //清除缓存
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 

     String workNo = (String)session.getAttribute("workNo");
     String regionCode = (String)session.getAttribute("regCode");
	String ret_code="999999";
	
     String function_code=request.getParameter("function_code")==null?"2609":request.getParameter("function_code");   
     String op_type   =request.getParameter("manageflag")==null?"i":request.getParameter("manageflag");   
%>

<wtc:service name="sIndexFuncCfm" outnum="1" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=function_code%>"/>
	<wtc:param value="<%=op_type%>"/>
</wtc:service>
<wtc:array id="result" scope="end" />

<%
if(retCode.equals("000000"))
      {
        ret_code="000000";
      }
     else
     {
      ret_code="999999";
     }
  out.println(ret_code);
%>	