<%
/********************
 version v2.0
 开发商: si-tech
 update hejw@2009-1-22
********************/
%>
<%
  String opCode = "5255";
  String opName = "空中充值帐户缴费";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %> 

  <%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
    response.setDateHeader("Expires", 0); 
	String regionCode =(String)session.getAttribute("regCode");
	String accountstr = request.getParameter("accountstr");
  String namestr = request.getParameter("namestr");
	String accounttypestr = request.getParameter("accounttypestr");
	String paytypestr = request.getParameter("paytypestr");
	String shoudpaystr = request.getParameter("shoudpaystr");
	String accounts[] = accountstr.split(",") ;
		String names[] = new String[accounts.length];

		for(int i=0; i<accounts.length; i++) {
		
	   	//String inParas = "select bank_cust from dConMsg where contract_no=?" ;
	   	String[] inPutArray = new String[2];
		inPutArray[0]="select bank_cust from dConMsg where contract_no=:contractr_No";
		inPutArray[1]="contractr_No="+accounts[i];
		System.out.println("---------------accounts[i]---------------"+accounts[i]);
%>
			<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
				<wtc:param value="<%=inPutArray[0]%>"/>
				<wtc:param value="<%=inPutArray[1]%>"/>
			</wtc:service>
			<wtc:array id="result" scope="end" />
<%
			if(result!=null&&result.length>0){
			 	names[i] = result[0][0];
			}
	}

	String accounttypestrs[] = accounttypestr.split(",");
	String paytypestrs[] = paytypestr.split(",");
	String shoudpaystrs[] = shoudpaystr.split(",");
  %> 

<HTML><HEAD><TITLE>黑龙江BOSS-帐号查询</TITLE>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<script language="JavaScript">
function hhhhhhhh()
{
	
	<%
	if(names.length>0&&names[0]==null){
%>
	document.getElementById("hh").style.display="none";
	rdShowMessageDialog("没有找到相应数据",0);
	window.close();
<%
}
	%>
	
	}	
function selAccount()
{	
       

	  if(isNaN(document.frm.account.length))
	 {		
         window.returnValue=document.frm.account.value;    
 	  }
      else
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

<BODY onload="hhhhhhhh()">
<form name="frm" method="post" action="">      
<%@ include file="/npage/include/header_pop.jsp" %>

	<div class="title">
		<div id="title_zi">帐号查询</div>
	</div>

  <table cellspacing="0" id="hh">
  	
    <tr> 

      <td> 
        <div align="center"> &nbsp;</div>
      </td>
      
      <td width="20%"> 
        <div align="center">帐号</div>
      </td>
      
	  <td> 
        <div align="center">帐户名称</div>
      </td>

	  <td> 
        <div align="center">帐户类型</div>
      </td>

	  <td> 
        <div align="center">付费方式</div>
      </td>

	  <td> 
        <div align="center">欠费</div>
      </td>


    </tr>
    <% for(int i=0; i < accounts.length  ; i++){%>
    <tr> 
      <td> 
        <div align="center"> 
          <input type="radio" name="account" value=<%=accounts[i]%>  <%if (i==0) {%>checked<%}%>>
        </div>
      </td>
      <td> 
        <div align="center"><%=accounts[i]%></div>
      </td>
      
	  <td> 
        <div align="center"><%=names[i]%></div>
      </td>

	  <td> 
        <div align="center"><%=accounttypestrs[i]%></div>
      </td>

	  <td> 
        <div align="center"><%=paytypestrs[i]%></div>
      </td>

	  <td> 
        <div align="center"><%=shoudpaystrs[i]%></div>
      </td>
    
	</tr>
    <%}%>
    <tr> 
      <td colspan="6"> 
        <div align="center" id="footer"> 
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
