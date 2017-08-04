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
	String op_codes = request.getParameter("s_opcode");
	System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA "+op_codes);
 %>
 	<wtc:service name="se257QryBD" routerKey="region" routerValue="<%=regionCode%>" outnum="13" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=iLoginAccept%>"/>
		<wtc:param value="<%=iChnSource%>"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workno%>"/>
		<wtc:param value="<%=nopass%>"/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value="<%=pwd%>"/>
		<wtc:param value="<%=op_codes%>"/>
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
	//xl add
	String[][] result4  = null ;
	String[][] result5  = null ;
	result1 = mainInfo1;
	result2 = mainInfo2;
	result3 = mainInfo3;
	result4 = mainInfo4;
	result5 = mainInfo5;
	System.out.println("fffffffffffffffAAAAAAAAAAAAAAAAAAAAAAAAAAA test for mainInfo3 is "+mainInfo3+" result3.legnth is "+result3.length);
	//Integer.parseInt(result3.length)=1;
	if(result3==null||result3.length==0)
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
			window.returnValue="<%=result3[0][0].trim()%>";
			//alert("1组情况 window.returnValue is "+window.returnValue);
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
	 //  alert("test "+window.returnValue);
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
		<th class="blue" align="center">开始卡号</td>
		<th align="center">结束卡号</td>
		<th align="center">办理业务代码</td> 
		<th align="center">办理业务流水</td>
		<th align="center">办理活动名称</td>
		<th align="center">办理活动时间</td>
	
	</tr>
    <%
    String tbClass = "";
	String add_money="";
//	String sql_money="select to_char(add_pay_money) from wChargeCardMsg where phone_no1='?' and phone_no2='?' ";
    

			
			for(int j=0;j<result3.length;j++)//for循环的
			{
				{
					%>
					<tr> 
			<td class="<%=tbClass%>"> 
				<div align="center"> 
				<%
					//项目名称个数同其他的一样
					//卡号个数单独的 外层套项目的个数
					 
					
						 
						%>
						<input type="radio" name="user" value="<%=result3[j][0]+","+result3[j][1]+","+result5[j][0]+","+result5[j][1]+","+result1[j][0]+","+result1[j][1]%>"  <%if (j==0) {%>checked<%}%>>
						<td class="<%=tbClass%>"> 
							<div align="center"><%=result3[j][0]%></div>
						</td>
						<td class="<%=tbClass%>"> 
							<div align="center"><%=result3[j][1]%></div>
						</td> 
							<td class="<%=tbClass%>"> 
								<div align="center"><%=result5[j][0]%></div>
							</td>
							<td class="<%=tbClass%>"> 
								<div align="center"><%=result5[j][1]%></div>
							</td>
							<td class="<%=tbClass%>"> 
								<div align="center"><%=result1[j][0]%></div>
							</td>
							<td class="<%=tbClass%>"> 
								<div align="center"><%=result1[j][1]%></div>
							</td>
						<%
					
				//	System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaa i is "+i+" and result2[i][0] is "+result2[i][0]+" and result2[i][1] is "+result2[i][0]+" and result4[i][0] is "+result4[i][0]+" and result4[i][1] is "+result4[i][1]);

				%>

							 
				</div>
			</td>
			 
				 </tr>
					<%
				}
	%>
			 
		
	 
				
				 
		
    <%}
	
	%>
	 
	<tr> 
		<td colspan="7"> 
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
