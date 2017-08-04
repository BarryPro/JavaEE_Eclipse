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
	String phoneNo = request.getParameter("phoneNo").trim();					//用户号码
	//String opCode = request.getParameter("opCode");
	String opName = "充值卡手工充值";//操作代码
	String opCode = "e251";	
	String orgCode = request.getParameter("orgCode");					//归属代码
	String regionCode = (String)session.getAttribute("regCode");		//地市代码
	String iLoginAccept ="0";
	String iChnSource  =request.getParameter("channelId");
	
	String workno = (String)session.getAttribute("workNo");
	String pwd = request.getParameter("pwd");
	String nopass = (String)session.getAttribute("password");
 %>
 	<wtc:service name="se257QryBD" routerKey="region" routerValue="<%=regionCode%>" outnum="11" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=iLoginAccept%>"/>
		<wtc:param value="<%=iChnSource%>"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workno%>"/>
		<wtc:param value="<%=nopass%>"/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value="<%=pwd%>"/>
	</wtc:service>
	<wtc:array id="mainInfo1" start="0" length="2" scope="end"/>
	<wtc:array id="mainInfo2" start="2" length="3" scope="end"/>
	<wtc:array id="mainInfo3" start="5" length="2" scope="end"/>
	<wtc:array id="mainInfo4" start="7" length="4" scope="end"/>
	<wtc:array id="mainInfo5" start="11" length="2" scope="end"/>
 <%
 	String errCode = retCode;
	String errMsg = retMsg;
	String oProjectName = "";
	String oPartInTime = ""; /*参与时间*/
	String oOnlyMyFlag = "";/* 是否办理了转赠标识 1表示办理了*/
	String oAllFee=""; /*总金额*/
	String oMyFee="";/*给自己充值的金额*/
	/*以下可能有多值*/
	String oStoreNo="";/*充值卡开始卡号*/
	String oEndStoreNo="";/*充值卡结束卡号*/
	String oTranFee=""; /*转赠金额*/
	String oTranTime ="";/*转赠时间*/
	String oTranPhone="";/*转赠电话*/
	String oCustName="";
	String[][] result1  = null ;
	String[][] result2  = null ;
	String[][] result3  = null ;
	String[][] result4  = null ;//多用户的字段
	String[][] result5  = null ;

	result1 = mainInfo1;
	result2 = mainInfo2;
	result3 = mainInfo3;
	result4 = mainInfo4;
	result5 = mainInfo5;
	//System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAA test for result is "+result[0][0]);
	if(result4==null||result4.length==0)
	{
   %>
      <SCRIPT LANGUAGE="JavaScript">
      <!--
       		  window.close();
       //-->
      </SCRIPT>
<%
	}
	 
   else  if ( result3.length==1 )
   {
%>      
 		<SCRIPT LANGUAGE="JavaScript">
 		<!--
			window.returnValue="<%=result4[0][1].trim()%>";
			window.close(); 
 		//-->
 		</SCRIPT>
<%   
    }
else
  {
%>

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
		<th class="blue" align="center">用户名称</td>
		<th align="center">用户号码</td>
		<th class="blue" align="center">时间</td>
		<th align="center">用户金额</td>
		 
	</tr>
    <%
    String tbClass = "";
	String add_money="";
	String sql_money="select to_char(add_pay_money) from wChargeCardMsg where phone_no1='?' and phone_no2='?' ";
    for(int i=0; i < result3.length; i++)
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
					<input type="radio" name="user" value="<%=result4[i][3]+","+result4[i][2]+","+result4[i][1]+","+result4[i][0]%>"  <%if (i==0) {%>checked<%}%>>
				</div>
			</td>
			<td class="<%=tbClass%>"> 
				<div align="center"><%=result4[i][3]%></div>
			</td>
			<td class="<%=tbClass%>"> 
				<div align="center"><%=result4[i][2]%></div>
			</td>
			<td class="<%=tbClass%>"> 
				<div align="center"><%=result4[i][1]%></div>
			</td>
			<td class="<%=tbClass%>"> 
				<div align="center"><%=result4[i][0]%></div>
			</td>
		</tr>
    <%}%>
	 
	<tr> 
		<td colspan="5"> 
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
