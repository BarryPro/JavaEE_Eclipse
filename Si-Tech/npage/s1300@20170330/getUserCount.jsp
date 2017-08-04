<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-15 页面改造,修改样式
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

 <%
	  String opCode = "1302";
		String opName="账号缴费";
	
		String accountstr = request.getParameter("accountstr");
    String namestr = request.getParameter("namestr");
		String accounttypestr = request.getParameter("accounttypestr");
		String paytypestr = request.getParameter("paytypestr");
		String shoudpaystr = request.getParameter("shoudpaystr");
	
		String orgCode = (String)session.getAttribute("orgCode");
		String regionCode = orgCode.substring(0,2);
		String accounts[] = accountstr.split(",") ;
		String names[] = new String[accounts.length];
		for(int i=0; i<accounts.length; i++) {
	   	//String inParas[] = {"select bank_cust from dConMsg where contract_no=?" };
		String[] inPutArray = new String[2];
		inPutArray[0]="select bank_cust from dConMsg where contract_no=:contractr_No";
		inPutArray[1]="contractr_No="+accounts[i];
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

<HTML><HEAD><TITLE>帐号查询</TITLE>

<script language="JavaScript">
	
	function selAccount(){	
		  if(isNaN(document.frm.account.length)){
	         window.returnValue=document.frm.account.value;    
	 	  }else{
	       for(i=0;i<document.frm.account.length;i++){		    
			      if (document.frm.account[i].checked==true){
		 					 window.returnValue=document.frm.account[i].value;     
							 break;
				  	}
		   	 } 
		  }
	 		window.close(); 
	}
 </script>

</head>

<BODY>
<form name="frm" method="post" action="">      
<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">帐号查询</div>
		</div>
  <table cellspacing="0">
    <tr align="center"> 
      <th>&nbsp;</th>
      <th>帐号</th>
		  <th>帐户名称</th>
		  <th>帐户类型</th>
		  <th>付费方式</th>
		  <th>欠费</th>
    </tr>
<% 
   for(int i=0; i<accounts.length; i++){
%>
    <tr align="center"> 
      <td> 
         <input type="radio" name="account" value=<%=accounts[i]%>  <%if (i==0) {%>checked<%}%>>
      </td>
      <td><%=accounts[i]%></td>
		  <td><%=names[i]%></td>
		  <td><%=accounttypestrs[i]%></td>
		  <td><%=paytypestrs[i]%></td>
		  <td><%=shoudpaystrs[i]%></td>
	</tr>
<%
		}
%>
    <tr> 
      <td id="footer" colspan="6"> 
          <input class="b_foot" type="button" name="Button" value="确定" onClick="selAccount()">
          <input class="b_foot" type="button" name="return" value="返回" onClick="window.close()">
    </tr>
  </table>
 </DIV>
</DIV>
</form>
</body>
</html>
