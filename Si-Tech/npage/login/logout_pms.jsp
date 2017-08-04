<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.sitech.crmpd.boss.bo.ContactInfo"%>
<%@ page errorPage="../common/errorpage.jsp" %>
<%
    response.setHeader("Pragma","No-cache");
    response.setHeader("Cache-Control","no-cache");
    response.setDateHeader("Expires", 0);
%>
<%
	String loginNo = (String) request.getParameter("loginNo");
	//接触平台状态
	System.out.println("---hjw-------------logout.jsp-------");	
  String appCnttFlag = (String)application.getAttribute("appCnttFlag"); 	

//在异常退出系统时关闭所有未关闭的统一接触信息 add by liubo 统一接触服务不可积压。
try{
	if(appCnttFlag!=null&&"Y".equals(appCnttFlag))
	{
		Map map = (Map)session.getAttribute("contactInfo");	
		Iterator iterator = map.keySet().iterator(); 
	  while (iterator.hasNext()) {
	      Object key = iterator.next();
	      System.out.println("map.get(key) is :"+map.get(key));      
		    ContactInfo contactInfo = (ContactInfo) map.get(key); 
			  String Contact_id=contactInfo.getContact_id(); 
			  String url="/npage/contact/EndCntt.jsp?gCustId="+key+"&Contact_id="+Contact_id;    
			  %>
			  <jsp:include page="<%=url%>" flush="true" />
			  <%
	  } 
	}  
}catch(Exception ex){
	System.out.println("同意接触关闭失败");
}	
System.out.println("---hjw---------loginNo-----------"+loginNo);	
if( loginNo!=null ){ 
	    String	sqlStr = "update dLoginMsg set try_times=0 where login_no ='"+loginNo+"'";
	    System.out.println("---hjw---------sqlStr-----------"+sqlStr);	
try{ 
%>
<wtc:pubselect name="sPubSelect" outnum="1">
	<wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>
<%
		}catch(Exception ex)
		{
		  %>
		  <script>
		  	alert('退出登录失败，工号已被锁定！');
		  </script>
		  <%
		}
}
%>
<html>
<head>
<title>
      正在退出登录
</title>
<script>
function startTimer(){
        setTimeout("exit()",2000);
}
function exit(){
 window.opener=null;
 window.open('','_self');
 window.close();
}
</script>

</head>
<body onload=startTimer() bgcolor="649ECC">
<%
String selfIp = request.getRemoteAddr();
Counter.logout(selfIp,new User());
session.invalidate();
%>
<br>
<table width="75%" border="0" cellspacing="0" align="center">
  <tr> 
  <td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
  </tr>
  <tr> 
    <td rowspan="2" background="../../images/online.gif" width="30" height="10">&nbsp;</td>
    <td>&nbsp;</td>
    <td rowspan="2" background="../../images/offline.gif" width="30">&nbsp;</td>
  </tr>
  <tr> 
    <td height=10 align="center" background="../../images/process.gif"> </td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
  </tr>
</table>
</body>
</html>

