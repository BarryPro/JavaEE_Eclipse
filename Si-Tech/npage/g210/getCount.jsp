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
    String opName = "集团共享流量查询";//request.getParameter("opName");
	String unit_id = request.getParameter("unit_id");
	//select a.unit_name,to_char(b.id_no),c.offer_name,to_char(b.account_id),to_char(b.user_no) from dgrpcustmsg a, dgrpusermsg b, product_offer c, sGrpSmFieldRela  d where a.cust_id = b.cust_id  and b.run_code = 'A'  and b.sm_code = d.User_Type  and c.offer_id = to_number(b.product_code)  and d.Field_Code = '10358' and a.unit_id = '4510245983';
    String[] inParas1 =new String[2];
	inParas1[0]="select a.unit_name,to_char(b.id_no),c.offer_name,to_char(b.account_id),to_char(b.user_no) from dgrpcustmsg a, dgrpusermsg b, product_offer c, sGrpSmFieldRela  d where a.cust_id = b.cust_id  and b.run_code = 'A'  and b.sm_code = d.User_Type  and c.offer_id = to_number(b.product_code)  and d.Field_Code = '10358' and a.unit_id =:unit_id";
	inParas1[1]="unit_id="+unit_id;
 %>
 	<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="15004678912" retcode="retCode1" retmsg="retMsg1" outnum="5" >
		<wtc:param value="<%=inParas1[0]%>"/>
		<wtc:param value="<%=inParas1[1]%>"/>
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
			//alert("tt "+"<%=result[0][4].trim()%>"+"."+"<%=result[0][0].trim()%>"+"."+"<%=result[0][2].trim()%>");
			window.returnValue="<%=result[0][4].trim()%>"+","+"<%=result[0][0].trim()%>"+","+"<%=result[0][2].trim()%>";
			
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
 	  }
      else
      for(i=0;i<document.frm.user.length;i++) 
	  {		    
		      if (document.frm.user[i].checked==true)
		     {
 					 window.returnValue=document.frm.user[i].value;     
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
		<th class="blue" align="center">集团名称</td>
		<th align="center">用户ID</td>
		<th align="center">资费名称</td>
		<th align="center">集团产品帐号</td>
		<th align="center">集团号码</td>
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
					<input type="radio" name="user" value="<%=result[i][4].trim()+","+result[i][0].trim()+","+result[i][2].trim()%>"  <%if (i==0) {%>checked<%}%>>
				</div>
			</td>
			<td class="<%=tbClass%>"> 
				<div align="center"><%=result[i][0]%></div>
			</td>
			<td class="<%=tbClass%>"> 
				<div align="center"><%=result[i][1]%></div>
			</td>
			<td class="<%=tbClass%>"> 
				<div align="center"><%=result[i][2]%></div>
			</td>
			<td class="<%=tbClass%>"> 
				<div align="center"><%=result[i][3]%></div>
			</td>
			<td class="<%=tbClass%>"> 
				<div align="center"><%=result[i][4]%></div>
			</td>

		</tr>
    <%}%>
	<tr> 
		<td colspan="6"> 
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
