<%
/********************
 version v2.0
开发商: si-tech
*
*liuxmc
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
		String opCode = "g053";
		String opName = "渠道发票信息";
		String login_no = (String)session.getAttribute("workNo");
		String sqlStr = "select BANK_CODE,BANK_NAME from QD_BANKCODE order by BANK_CODE";
	    String sqlStr1 = "select region_code,region_name from sregioncode where region_code<=13 order by region_code";
		
%>
<wtc:pubselect name="TlsPubSelBoss" outnum="2" retmsg="return_msg" retcode="return_code">
			<wtc:sql><%=sqlStr%></wtc:sql>
		  </wtc:pubselect>
<wtc:array id="return_result" scope="end"/>	 

<wtc:pubselect name="TlsPubSelBoss" outnum="2" retmsg="return_msg1" retcode="return_code1">
			<wtc:sql><%=sqlStr1%></wtc:sql>
		  </wtc:pubselect>
<wtc:array id="return_result1" scope="end"/>	 	

<%
   String bank_options = "<option value=>--请选择--</option>";
   String region_options ="<option value=>--请选择--</option>";
   for(int i=0;i<return_result.length;i++)
   {
     bank_options += "<option value="+return_result[i][0]+">"+return_result[i][1]+"</option>";
   }
   
      for(int i=0;i<return_result1.length;i++)
   {
     region_options += "<option value="+return_result1[i][0]+">"+return_result1[i][1]+"</option>";
   }
%>
<HTML>
<HEAD>
<script language="JavaScript">

function commit(){
	
	if(document.frm.s_Invoice_number.value=="")  {
     rdShowMessageDialog("请输入起始发票号码!");
     document.frm.s_Invoice_number.value = "";
     document.frm.s_Invoice_number.focus();
     return false;
  }
  
  if(document.frm.s_Invoice_number.value.length < 8)  {
     rdShowMessageDialog("起始发票号码长度不够!");
     document.frm.s_Invoice_number.value = "";
     document.frm.s_Invoice_number.focus();
     return false;
  }
	
	if(document.frm.e_Invoice_number.value=="")  {
     rdShowMessageDialog("请输入终止发票号码!");
     document.frm.e_Invoice_number.value = "";
     document.frm.e_Invoice_number.focus();
     return false;
  }
  
  if(document.frm.e_Invoice_number.value.length < 8)  {
     rdShowMessageDialog("终止发票号码长度不够!");
     document.frm.e_Invoice_number.value = "";
     document.frm.e_Invoice_number.focus();
     return false;
  }
  
  if(document.frm.Invoice_code.value=="")  {
     rdShowMessageDialog("请输入发票代码!");
     document.frm.Invoice_code.value = "";
     document.frm.Invoice_code.focus();
     return false;
  }
  
  if(document.frm.Invoice_code.value.length < 12)  {
     rdShowMessageDialog("发票代码长度不够!");
     document.frm.Invoice_code.value = "";
     document.frm.Invoice_code.focus();
     return false;
  }
  if(document.frm.bank_code.value =="")  {
     rdShowMessageDialog("请选择银行名称!");
     document.frm.bank_code.value = "";
     document.frm.bank_code.focus();
     return false;
  }
  if(document.frm.region_code.value =="")  {
     rdShowMessageDialog("请选择地市名称!");
     document.frm.region_code.value = "";
     document.frm.region_code.focus();
     return false;
  }
  
	document.frm.submit();
	            
}

 function sel1() { 		 
	window.location.href='g053.jsp';
 }
 function sel2(){ 
	window.location.href='g053_2.jsp';
 } 
 function sel3(){
    window.location.href='g053_3.jsp';
 }
function sel4(){
    window.location.href='g053_4.jsp';
 }
function sel5(){
    window.location.href='g053_5.jsp';
 }
function sel6(){
    window.location.href='g053_6.jsp';
} 
function sel7(){
    window.location.href='g053_7.jsp';
}
function doclear() {
 	frm.reset();
}

 </script> 
 
<title>黑龙江BOSS-发票信息查询和录入</title>
</head>
<BODY>
<form action="g053Cfm.jsp" method="post" name="frm">
		<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">发票统计信息和录入</div>
		</div> 

  <table cellspacing="0">
    <tr>
    	<td class="blue" width="15%">查询方式</td>
        <td> 
          <input name="busyType2" type="radio" onClick="sel1()" value="1" checked>地市领票 
          <input name="busyType2" type="radio" onClick="sel5()" value="1">营业厅领票
<!--           
          <input name="busyType2" type="radio" onClick="sel2()" value="1">发票使用情况查询 
          <input name="busyType2" type="radio" onClick="sel3()" value="1">领用存情况表 
          <input name="busyType2" type="radio" onClick="sel4()" value="1">上期领用存情况表   
 -->                 
          <input name="busyType2" type="radio" onClick="sel6()" value="1">查询与删除
		  <input name="busyType2" type="radio" onClick="sel7()" value="1">查询
      </td>
      
    </tr>
  </table>

  
  <table cellspacing="0">
    <tr>
    	<td align="left" class="blue" width="15%">起始发票号码:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="s_Invoice_number" size="10" maxlength="8" onKeyPress="return isKeyNumberdot(0)"><font color="#FF0000">*</font>
      </td>
      <td align="left" class="blue" width="15%">终止发票号码:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="e_Invoice_number" size="10" maxlength="8" onKeyPress="return isKeyNumberdot(0)"><font color="#FF0000">*</font>
      </td>
      <td align="left" class="blue" width="15%">发票代码:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="Invoice_code" size="14" maxlength="12" onKeyPress="return isKeyNumberdot(0)"><font color="#FF0000">*</font>
      </td>      
    </tr>
    
    <tr>
    	<td align="left" class="blue" width="15%">银&nbsp;&nbsp;行&nbsp;&nbsp;名&nbsp;&nbsp;称:&nbsp;&nbsp;&nbsp;
        <select name="bank_code" >
          	<%=bank_options%>                   
          </select><font color="#FF0000">*</font>
      </td>
      <td align="left" class="blue" width="15%">地&nbsp;&nbsp;市&nbsp;&nbsp;名&nbsp;&nbsp;称:&nbsp;&nbsp;&nbsp;
        <select name="region_code" >
          	<%=region_options%>                   
          </select><font color="#FF0000">*</font>
      </td>
      <td align="left" class="blue" width="15%">&nbsp;&nbsp;&nbsp;      
      </td>      
    </tr>
  </table>
           
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
              <input type="button" name="query" class="b_foot" value="确认" onclick="commit()" >
          &nbsp;
          <input type="button" name="return1" class="b_foot" value="清除" onclick="doclear()" >
          &nbsp;
		  <input type="button" name="return2" class="b_foot" value="关闭" onClick="removeCurrentTab()" >
       </td>
    </tr>
  </table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %>
</form>
 </BODY>
</HTML>

