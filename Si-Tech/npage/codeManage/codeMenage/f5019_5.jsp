<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
String retType =  request.getParameter("retType");
String region_code =  request.getParameter("region_code");
String bullet_code =  request.getParameter("bullet_code");
String regionCode = (String)session.getAttribute("regCode");
String strsql="";
if (region_code.equals("ZZ"))
  {
    strsql="select bullet_content, boot_name,valid_flag,color from dsysbullet where  bullet_code =" +"'"+ bullet_code+"' and region_code ='01'";
  }
 else
  {   
  	strsql = "select bullet_content, boot_name,valid_flag,color from dsysbullet where  bullet_code =" +"'"+ bullet_code+"' and region_code ='"+region_code+"'";
  }
%>

	<wtc:pubselect name="sPubSelect" outnum="4" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  		<wtc:sql><%=strsql%></wtc:sql>
 		</wtc:pubselect>
	<wtc:array id="result_t" scope="end"/>
	 
<%

String retCode="000000";
String retMessage="";
String boot_name="";
String bullet_content="";
String valid_flag="";
String color2="";
if(result_t.length>0)
{ 
  bullet_content=result_t[0][0];
  boot_name=result_t[0][1];
  valid_flag=result_t[0][2];
  color2=result_t[0][3];
}
else
  {
	 retCode="000001";
     retMessage="无此公告信息";
  }

%>
var response = new AJAXPacket();
var retType = "<%=retType%>";
var retCode = "<%=retCode%>";
var retMessage = "<%=retMessage%>";
var boot_name = "<%=boot_name%>";
var bullet_content ="<%=bullet_content%>";
var valid_flag ="<%=valid_flag%>";
var color2= "<%=color2%>";

response.data.add("retType",retType); 
response.data.add("retCode",retCode); 
response.data.add("retMessage",retMessage); 
response.data.add("boot_name",boot_name); 
response.data.add("bullet_content",bullet_content); 
response.data.add("valid_flag",valid_flag); 
response.data.add("color2",color2); 
core.ajax.receivePacket(response);