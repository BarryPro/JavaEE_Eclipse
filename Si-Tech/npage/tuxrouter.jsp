<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ page language="java" import="java.util.*,java.io.*" pageEncoding="GBK"%>
<%@ page import="com.sitech.crmpd.core.wtc.router.RouterClientTemplate"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ page import="com.sitech.crmpd.boss.bo.ContactInfo"%>
<%@ page import="java.util.*"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page import="java.math.BigDecimal"%>
<%
  String optype = request.getParameter("optype");
  String region = request.getParameter("region");
  String tuxreg = request.getParameter("tuxreg");
  if ((optype.compareTo("1")!=0 && optype.compareTo("2")!=0 && optype.compareTo("3")!=0) ||
      (tuxreg.compareTo("_A")!=0 && tuxreg.compareTo("_B")!=0)) {
%>
  <script language="javascript">
    alert("输入参数错误! optype=[<%=optype%>] region=[<%=region%>] tuxreg=[<%=tuxreg%>]");
    window.close(-1);
  </script>
<%
  } else {
    if (optype.compareTo("1")==0) {
      try
      {
        String s0="";
        Map sMap = RouterClientTemplate.getRouterMaps(s0);
        out.println("RETMSG 内存中路由列表个数："+sMap.size());
      }
      catch (Exception e)
      {
        e.printStackTrace();
%>
        <script language="javascript">
          alert("查询失败原因:<%=e.getMessage()%>");
          window.close(-1);
        </script>
<%
      }
    }
    if (optype.compareTo("2")==0) {
      try
      {
        RouterClientTemplate.updateMaps(region,tuxreg);
        out.println("RETMSG 修改成功");
      }
      catch (Exception e)
      {
        e.printStackTrace();
%>
        <script language="javascript">
          alert("修改失败原因:<%=e.getMessage()%>");
          window.close(-1);
        </script>
<%
      }
    }
    if (optype.compareTo("3")==0) {
      try
      {
        String s0="";
        Map sMap = RouterClientTemplate.getRouterMaps(s0);
        out.println("内存中路由列表个数："+sMap.size()+"</br></br>");
        Set qkey0 = sMap.keySet();
        for (Iterator it0 = qkey0.iterator(); it0.hasNext();) {
          String s1 = (String) it0.next();
          out.println(s1+sMap.get(s1)+"</br>");
        }
      
        out.println("配置文件中路由列表个数："+sMap.size()+"</br></br>");
        ResourceBundle rb = ResourceBundle.getBundle("TUXEDO_ROUTER");
        for (Enumeration keys = rb.getKeys (); keys.hasMoreElements ();)
        {
          final String key = (String) keys.nextElement ();
          final String value = rb.getString (key);
          out.println("IN CFGFILE "+key+"->"+value+"</br>");
        }
      }
      catch (Exception e)
      {
        e.printStackTrace();
%>
        <script language="javascript">
          alert("查询失败原因:<%=e.getMessage()%>");
          window.close(-1);
        </script>
<%
      }
    }
    
  }
%>
