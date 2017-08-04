<%
/********************
 version v2.0
 开发商: si-tech
 update hejw@2009-1-21
********************/
%>
<%
  String opCode = "5255";
  String opName = "空中充值帐户缴费";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%@ page import="com.sitech.boss.amd.viewbean.*" %>


<%	response.setHeader("Pragma","No-Cache"); 
	    response.setHeader("Cache-Control","No-Cache");
        response.setDateHeader("Expires", 0); 
        String regionCode = (String)session.getAttribute("regCode");
%>
<%
	String phoneNo = request.getParameter("phoneNo");
    
	/*
	String inParas[] = {"select to_char(a.contract_no),a.bank_cust from dConMsg a,dCustMsg b, dConUserMsg c where a.contract_no=c.contract_no and c.serial_no=0 and b.phone_no='"+phoneNo+"' and substr(b.run_code,2,1) < 'a' and b.id_no = c.id_no" };
	*/
    String inParas = "select to_char(a.contract_no),a.bank_cust,d.type_name,e.pay_name,to_char(a.owe_fee) from dConMsg a,dCustMsg b, dConUserMsg c,sAccountType d,sPayCode e,dagtbasemsg f where a.contract_no=c.contract_no and c.serial_no=0 and b.phone_no='?' and substr(b.run_code,2,1) < 'a' and b.id_no = c.id_no and a.account_type=d.account_type and e.region_code=substr(a.belong_code,1,2) and e.pay_code=a.pay_code and f.CONTRACT_NO=a.CONTRACT_NO";

//	CallRemoteResultValue value=  viewBean.callService("0",null,"sPubSelect",outNum, inParas); 
%>

		<wtc:pubselect name="TlsPubSelBoss" outnum="5" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=inParas%></wtc:sql>
 	  <wtc:param value="<%=phoneNo%>"/>
 	  </wtc:pubselect>
	 <wtc:array id="result_t" scope="end"/>

<%
 	String result[][]  = result_t;

	//System.out.println("aaaaaaaaa"+result[0][0]);
%>

 <%
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
 

<HTML><HEAD><TITLE>黑龙江BOSS-帐号查询</TITLE>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>

<script language="JavaScript">
window.returnValue='';
function selAccount()
{	
     
       for(i=0;i<document.frm.account.length;i++) 
	  {		    
		      if (document.frm.account[i].checked==true)
		     {
 					 window.returnValue=document.frm.account[i].value;     
					 break;
			  }
	   } 
 		window.close(); 
}
	
 

 </script>

</head>

<BODY >
<form name="frm" method="post" action="">

      <%@ include file="/npage/include/header_pop.jsp" %>                         


	<div class="title">
		<div id="title_zi">帐号查询</div>
	</div>
 

  <table  cellspacing="0">
    <tr> 
      <th height="25" width="10%"> 
        <div align="center">选择</div>
      </th>
      <th height="25" width="20%"> 
        <div align="center">帐号</div>
      </th>
      <th height="25"> 
        <div align="center">帐户名称</div>
      </th>

      <th height="25"> 
        <div align="center">帐户类型</div>
      </th>

	  <th height="25"> 
        <div align="center">付费方式</div>
      </th>

	  <th height="25"> 
        <div align="center">欠费</div>
      </th> 

    </tr>
    <% 
    String class_str = "";
    for(int i=0; i < result.length  ; i++)
	{
	if(i%2==0)
	class_str="Grey";
 
		%>
			<tr> 
			  <td height="25" class="<%=class_str%>"> 
				<div align="center"> 
				  <input type="radio" name="account" value="<%=result[i][0].trim()%>"  <%if (i==0) {%>checked<%}%>>
				</div>
			  </td>
			  <td height="25" class="<%=class_str%>"> 
				<div align="center"><%=result[i][0]%></div>
			  </td>
			  <td height="25" class="<%=class_str%>"> 
				<div align="center"><%=result[i][1]%></div>
			  </td>
			   <td height="25" class="<%=class_str%>"> 
				<div align="center"><%=result[i][2]%></div>
			  </td>
			   <td height="25" class="<%=class_str%>"> 
				<div align="center"><%=result[i][3]%></div>
			  </td>
			   <td height="25" class="<%=class_str%>"> 
				<div align="center"><%=result[i][4]%></div>
			  </td>
			</tr>
    <%}%>
 
    <tr> 
      <td  colspan="6" id="footer"> 
        <div align="center"> 
          <input class="b_foot" type="button" name="Button" value="确定" onClick="selAccount()">
          <input class="b_foot" type="button" name="return" value="返回" onClick="window.close()">
        </div>
      </td>
    </tr>
  </table>
 
  <%@ include file="/npage/include/footer_pop.jsp" %>
</form>
</body>
</html>
<%}%>

