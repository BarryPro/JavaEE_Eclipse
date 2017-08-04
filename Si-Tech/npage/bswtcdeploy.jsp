<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ page language="java" import="java.util.*,java.io.*" pageEncoding="GBK"%>
<%@ page import="com.sitech.crmpd.core.wtc.cache.ServiceTemplate"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ page import="com.sitech.crmpd.boss.bo.ContactInfo"%>
<%@ page import="java.util.*"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page import="java.math.BigDecimal"%>
<%
  ServiceTemplate stemplate = ServiceTemplate.getInstance();
  Map sMap = stemplate.getServiceMap();
  out.println("RETMSG 发布前 内存中service列表个数："+sMap.size()+"</br></br>");
  sMap.clear();
  Set qkey0 = sMap.keySet();
  out.println("RETMSG 发布中 内存中service列表个数："+sMap.size()+"</br></br>");
  for (Iterator it0 = qkey0.iterator(); it0.hasNext();) {
    String s0 = (String) it0.next();
    out.println("----"+s0+"</br>");
  }
  try
  {
    ResourceBundle rb = ResourceBundle.getBundle("SERVICE_CONFIG");
    for (Enumeration keys = rb.getKeys (); keys.hasMoreElements ();)
    {
         final String key = (String) keys.nextElement ();
         final String value = rb.getString (key);
         sMap.put (key, value);
    }
  }
  catch (Exception e)
  {
  e.printStackTrace();
%>
  <script language="javascript">
    alert("发布失败原因:<%=e.getMessage()%>");
    window.close(-1);
  </script>
<%
  }

  Set qkey = sMap.keySet();
  out.println("RETMSG 发布后 内存中service列表个数："+sMap.size()+"</br></br>");
  for (Iterator it = qkey.iterator(); it.hasNext();) {
    String s = (String) it.next();
    out.println("++++"+s+"</br>");
  }

%>
