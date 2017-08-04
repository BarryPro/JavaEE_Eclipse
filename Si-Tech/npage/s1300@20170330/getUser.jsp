<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>	
<%@ page contentType="text/html;charset=GBK"%>

<%	
	response.setHeader("Pragma","No-Cache"); 
    response.setHeader("Cache-Control","No-Cache");
    response.setDateHeader("Expires", 0); 
%>
 
<%
	String opName = request.getParameter("opName");
	String phoneNo = request.getParameter("phoneNo");
    
	String regionCode= (String)session.getAttribute("regCode");
	String workno = (String)session.getAttribute("workNo");
	String org_code = (String)session.getAttribute("orgCode");
	String nopass = (String)session.getAttribute("password");

 	//CallRemoteResultValue value=  viewBean.callService("0",null,"sPubSelect","2", inParas);
	//加上opcode
 %>
 <!--xl add for替换 sGetUserQry-->
 <wtc:service name="sGetUserQry" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="2">
			<wtc:param value="0"/>
			<wtc:param value="01"/>
			<wtc:param value="1354"/>
			<wtc:param value="<%=workno%>"/>
			<wtc:param value="<%=nopass%>"/>
			<wtc:param value="<%=phoneNo%>"/>
			<wtc:param value=""/>
			<wtc:param value=""/>
	 
		</wtc:service>
		<wtc:array id="tempArr" scope="end"/>
 	
 
 <%
 	String result[][]  = tempArr;

	if(result==null||result.length==0)
	{
   %>
      <SCRIPT LANGUAGE="JavaScript">
      <!--
       		  window.close();
       //-->
      </SCRIPT>
<%
	}
	 
   else  if ( result.length==1 )
   {
%>     

 		<SCRIPT LANGUAGE="JavaScript">
 		<!--
			window.returnValue="<%=result[0][0].trim()%>";
			window.close(); 
			
 		//-->
 		</SCRIPT>
<%   
    }
else
  {
%>

<SCRIPT LANGUAGE="JavaScript">
 		//alert("123");
 		</SCRIPT> 
<HEAD>
<TITLE>黑龙江BOSS-用户选择</TITLE>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>

<script language="JavaScript">
window.returnValue='';
function selUser()
{	
	  if(isNaN(document.frm.user.length))
	 {
         window.returnValue=document.frm.user.value;  
		 //alert("document.frm.user.value is "+document.frm.user.value);	
 	  }
      else
      for(i=0;i<document.frm.user.length;i++) 
	  {		    
		      if (document.frm.user[i].checked==true)
		     {
 					 window.returnValue=document.frm.user[i].value;    
			//		 alert("test is "+document.frm.user[i].value+" and i is "+i);	
					 break;
			  }
	   } 
 		
	   window.close(); 
}
</script>

</head>

<BODY>
<form name="frm" method="post" action="">
      <%@ include file="/npage/include/header_pop.jsp" %>
     
<table>
	<tr> 
		<th>&nbsp;</th>
		<th class="blue" align="center">用户ID</td>
		<th align="center">用户名称</td>
	</tr>
    <%
    String tbClass = ""; 
    for(int i=0; i < result.length; i++)
	{
			if(i%2==0){
				tbClass="Grey";
			}else{
				tbClass="";
			}
	%>
		<tr> 
			<td class="<%=tbClass%>"> 
				<div align="center"> 
					<input type="radio" name="user" value="<%=result[i][0].trim()%>"  <%if (i==0) {%>checked<%}%>>
				</div>
			</td>
			<td class="<%=tbClass%>"> 
				<div align="center"><%=result[i][0]%></div>
			</td>
			<td class="<%=tbClass%>"> 
				<div align="center"><%=result[i][1]%></div>
			</td>
		</tr>
    <%}%>
	<tr> 
		<td colspan="3"> 
			<div align="center"> 
				<input class="b_foot" type="button" name="Button" value="确定" onClick="selUser()">
				<input class="b_foot" type="button" name="return" value="返回" onClick="window.close();">
			</div>
		</td>
	</tr>
</table>
  <%@ include file="/npage/include/footer_pop.jsp" %>
</form>
</body>
</html>
<%
  }
%>
