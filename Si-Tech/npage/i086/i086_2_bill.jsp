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
		String opCode = "i086";
		String opName = "专款及账目项查询";
 
	 
%>
<HTML>
<HEAD>
<script language="JavaScript">
<!--	

 function doclear() {
 		frm.reset();
 }

   function docheck3()
   {
	   var s_paytype =  document.all.rpt_type[document.all.rpt_type.selectedIndex].text;
	   var s_new = s_paytype.split("-->")[1];
	 //  alert(s_new);
	   document.frm.action = "i086_2_qry.jsp?s_new="+s_new+"&level=2";
	   document.frm.submit();	
	   
   }
 
   
   
     
   function sel1()
   {
			window.location.href='i086_1.jsp';
   }
   function sel2()
   {
		   window.location.href='i086_1_bill.jsp';
   }
   function sel3()
   {
		   window.location.href='i086_2_bill.jsp';
   }
   function sel4()
   {
		   window.location.href='i086_3_bill.jsp';
   }
    
-->
 </script> 
 
<title>黑龙江BOSS-普通缴费</title>
</head>
<BODY >
<form action="" method="post" name="frm">
		
	
	<%@ include file="/npage/include/header.jsp" %>   
  	
	<table cellspacing="0">
      <tbody> 
      <tr> 
        <td class="blue" width="15%">查询方式</td>
        <td colspan="4"> 
          <input name="busyType4" type="radio" onClick="sel1()" value="1" >专款查询
		  &nbsp;&nbsp;&nbsp;&nbsp;
		  <input name="busyType4" type="radio" onClick="sel2()" value="2" >一级账目项查询
		  &nbsp;&nbsp;&nbsp;&nbsp;
		  <input name="busyType4" type="radio" onClick="sel3()" value="3" checked>二级账目项查询
		  &nbsp;&nbsp;&nbsp;&nbsp;
		  <input name="busyType4" type="radio" onClick="sel4()" value="4">三级账目项查询
		</td>
     </tr>
    </tbody>
  </table>
	
	<div class="title">
			<div id="title_zi">请输入查询条件</div>
		</div>
	<table cellspacing="0">
    <tr>
		<td class="blue" >
			模糊检索
		</td>
		<td colspan="3">
			<input type="text" id="searchTextrpt" name="searchTextrpt" 
			 value="请输入账目项名称" 
			 size="40"
			 style="padding-top:3px;"
			 onFocus="frm.searchTextrpt.value='';clearResults();"
			onpropertychange="blurSearchFunc('rpt_type','searchTextrpt')" />
		</td>
	</tr>
	<tr>
		<td class="blue">二级账目项名称</td>
		<td>
			<select name=rpt_type style='width:400px'>
				<!--wanghfa 20100602 解耦修改 start-->
				<wtc:qoption name="TlsPubSelBoss" outnum="2">
					<wtc:sql>select trim(show_id),trim(show_id)||'-->'||trim(show_name) from sbillcodenew where show_level='2'</wtc:sql>
				</wtc:qoption>
				<!--wanghfa 20100602 解耦修改 end-->
			</select>
		</td>
	</tr> 


  </table>
 


  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
	  <input type="button" name="query" class="b_foot" value="查询" onclick="docheck3()" >
       
          &nbsp;
          <input type="button" name="return1" class="b_foot" value="清除" onclick="doclear()" >
          &nbsp;
		      <input type="button" name="return2" class="b_foot" value="关闭" onClick="removeCurrentTab()" >
      </td>
    </tr>
  </table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %>
  <%@ include file="/npage/public/pubSearchText.jsp" %>
</form>
 </BODY>
</HTML>