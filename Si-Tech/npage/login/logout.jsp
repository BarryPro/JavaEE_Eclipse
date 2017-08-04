<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.sitech.crmpd.boss.bo.ContactInfo"%>
<%@ page errorPage="../common/errorpage.jsp" %>
<%@ page import="import java.io.*"%>
<%@ page import="import java.net.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
    response.setHeader("Pragma","No-cache");
    response.setHeader("Cache-Control","no-cache");
    response.setDateHeader("Expires", 0);
%>
<%
	String loginNo = (String) session.getAttribute("workNo");
	//接触平台状态
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
if( loginNo!=null ){

/** modified by hejwa 20110714 多OP改造--退出记录日志信息。begin **/
	try{
			String regionCode = (String)session.getAttribute("regCode");
			String duoOPLoginAccept = session.getAttribute("duoOPLoginAccept")==null?"":(String)session.getAttribute("duoOPLoginAccept");
		%>
		<wtc:service name="sQuitSystem" outnum="0" routerKey="region" routerValue="<%=regionCode%>"  retmsg="msg" retcode="code" >
		  <wtc:param value="<%=loginNo%>"/>
		  <wtc:param value="<%=duoOPLoginAccept%>"/>	
		</wtc:service>
		<%			
		/** modified by hejwa 20110714 多OP改造--退出记录日志信息。end **/ 
	    //String	sqlStr = "update dLoginMsg set try_times=0 where login_no ='"+loginNo+"'";
%>
		<wtc:service name="sLoginOut" outnum="0" routerKey="region" routerValue="<%=regionCode%>" 
			 retmsg="msg2" retcode="code2" >
				<wtc:param value=""/>
				<wtc:param value="01"/>
				<wtc:param value=""/>
				<wtc:param value="<%=loginNo%>"/>
				<wtc:param value=""/>
				<wtc:param value=""/>
				<wtc:param value=""/>
		</wtc:service>
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
<%
	/* 4a */
	String token = "";
	String test4alog = "";
	/* 测试时使用，日志写入文件 */
	test4alog = "\r\n @@@@ ====4A验证 退出开始====";
	System.out.println(test4alog);
	token = (String) session.getAttribute("token4a");
	test4alog = "\r\n===ningtn========Token==" + token;
	System.out.println(test4alog);
	if(token != null && !"".equals(token)){
		test4alog = "从4a登录的 -> " + token;
		System.out.println(test4alog);
		try{
			String[] tokenArr = new String[]{""};
			tokenArr = token.split("@");
			String urlValue = "http://10.110.111.193:8081/iam/ticket_login.do?method=appExit";
			test4alog = "开始访问 url="+urlValue;
			System.out.println(test4alog);
		  URL url = new URL(urlValue);
		  URLConnection uc = url.openConnection();
		  uc.setDoOutput(true);
		  uc.setDoInput(true);
		  HttpURLConnection httpConnection = (HttpURLConnection) uc;
		  httpConnection.setRequestMethod("POST");
		  OutputStream os = httpConnection.getOutputStream();
		  //发送请求
		  String reqDate = "Token="+tokenArr[0] 
		  							+ "&APP_KEY=" + tokenArr[2]
		  							+ "&ACC_KEY=" + tokenArr[1];
		  System.out.println("----->reqDate:" + reqDate);
		  byte[] bt=null;
		  bt = reqDate.getBytes();
		  os.write(bt);
		  os.close();
		  //判断是否超时 或是内部错误
      int rspCode=httpConnection.getResponseCode();
      if(rspCode!=200){//节点机超时或内部错误
          System.out.println("节点机超时或内部错误");
      }
      //接收返回值
      InputStream is = httpConnection.getInputStream();
      InputStreamReader isr = new InputStreamReader(is,"UTF-8");
      BufferedReader br = new BufferedReader(isr);
      String data = "";
      String tstr = "";
      while ((tstr = br.readLine()) != null) {
          data = data + tstr;
      }
      isr.close();
      is.close();
      test4alog = "\r\n @@@@返回报文=" + data;
      System.out.println(test4alog);
	  }catch(Exception e){
	  	System.out.println(e.toString());
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

