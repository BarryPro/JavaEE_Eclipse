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
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*" %> 
<%@ page import="java.util.*" %>
<%
		String opCode = "g339";
		String opName = "跨省集团账单查询";
		 
		
%>
 

<HTML>
<HEAD>
<script language="JavaScript">
<!--	


 

 function docheck()
 {
	
	  var objSel_pay = document.getElementById("pay_id");
	  var pay_value=objSel_pay.value;	
	  //alert("document.frm.jfzq.value is "+document.frm.jfzq.value+" and document.frm.kfbm.value is "+document.frm.kfbm.value+" and pay_value is "+pay_value);
	  if( document.frm.jfzq.value=="" &&document.frm.kfbm.value=="" && pay_value=="00")
	  {
			rdShowMessageDialog("请输入查询条件!");
			 
			return false;
	  }
	  
	   document.frm.action="g339_2.jsp?jfzq="+document.frm.jfzq.value+"&kfbm="+document.frm.kfbm.value+"&pay_value="+pay_value;
 
	   document.frm.submit();
 
	 
 } 
 
 


 
 
  function doclear() {
 		frm.reset();
 }

 


-->
 </script> 
 
<title>黑龙江BOSS-普通缴费</title>
</head>
<BODY>
<form action="" method="post" name="frm">
		
		<%@ include file="/npage/include/header.jsp" %>   
  	<div class="title">
			<div id="title_zi">请输入查询条件</div>
		</div>
	<table cellspacing="0">
    <tr> 
      <td class="blue" width="15%">全网集团客户编码</td>
      <td> 
        <input type="text" name="kfbm" size="32" maxlength="32" > 
      </td>
      <td class="blue">计费帐期</td>
      <td> 
        <input type="text" name="jfzq" size="14" maxlength="14" > 
      </td>
       
    </tr>
	 
	
	<tr>
	 <td class="blue">帐单标记</td>
      <td> 
        <select id="pay_id">
			 <option value="00" selected>请选择</option>
			 <option value="0" >应收</option>
			 <option value="1" >实收</option>
			 
		</select>
      </td>
	</tr>


  </table>
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" name="query" class="b_foot" value="查询" onclick="docheck()" >
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