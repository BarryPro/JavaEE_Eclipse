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
		String opCode = "zg44";
		String opName = "虚拟集团关系配置";
		Calendar today = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
		String dtime = sdf.format(today.getTime());
    today.add(Calendar.MONTH,-12);
    /*默认，12个月之前*/
    String startTime = sdf.format(today.getTime());
	activePhone = request.getParameter("activePhone");	
%>
<HTML>
<HEAD>
<script language="JavaScript">
 
function xnjttj()
{
	//alert("1");
	var select_id = document.all.user_check[document.all.user_check.selectedIndex].value;
    //alert(select_id);
	var unit_id = document.frm.phoneNo.value;
	var cxhm = document.frm.cxhm.value;
 
	if(unit_id=="" &&select_id=="1")
	{
		rdShowMessageDialog("请输入虚拟集团编号!");
		return false;
	}
	else if(cxhm=="" && select_id=="2")
	{
		rdShowMessageDialog("请输入虚拟成员号码!");
		return false;
	}
	else
	{
		document.frm.action="zg44_qry.jsp?unit_id="+unit_id+"&select_id="+select_id+"&cxhm="+cxhm;
		//alert(document.frm.action);
		document.frm.submit();
	}
	
	
}
 


 function doclear() {
 		frm.reset();
 }
   
 function sel1() {
 		window.location.href='zg44_1.jsp';
 }

 function sel2(){
    window.location.href='zg44_3.jsp';
 }
 function sel3(){
    window.location.href='zg44_cx.jsp';
 }
 function sel4(){
    window.location.href='zg44_del.jsp';
 }

 function check_user()
 {
	var user_check = document.all.user_check[document.all.user_check.selectedIndex].value;
	if(user_check=="1")
	{
		//alert("密码校验");
		document.getElementById("userpasswd").style.display="block";
		document.getElementById("userid").style.display="none";
	}
	else
	{
		//alert("身份证号码");
		document.getElementById("userpasswd").style.display="none";
		document.getElementById("userid").style.display="block";
	}	
 }
 </script> 
 
<title>黑龙江BOSS-普通缴费</title>
</head>
<BODY>
<form action="" method="post" name="frm">
		
		<%@ include file="/npage/include/header.jsp" %>   
  	<div class="title">
			<div id="title_zi">请选择配置方式</div>
	</div>
	
	<table cellspacing="0">
      <tbody> 
	 
      <tr> 
        <td class="blue" width="15%">配置方式</td>
        <td colspan="4"> 
        	<q vType="setNg35Attr">
          <input name="busyType1" id="busyType1" type="radio" onClick="sel1()" value="1" >虚拟集团添加 
        </q>
 
          <q vType="setNg35Attr">
          <input name="busyType2" type="radio" onClick="sel2()" value="2"> 集团成员添加
          </q>
         
		  <q vType="setNg35Attr">
          <input name="busyType2" type="radio" onClick="sel4()" value="4"> 虚拟集团查询及删除
          </q>
		  <q vType="setNg35Attr">
          <input name="busyType2" type="radio" onClick="sel3()" value="3" checked> 集团成员关系查询
          </q>
		   <!--
		  <q vType="setNg35Attr">
          <input name="busyType2" type="radio" onClick="sel4()" value="4"> 集团成员关系删除
          </q>
			-->
     </tr>
	   
    </tbody>
  </table>
	
  <table cellspacing="0">
    <tr> 
	   <td class="blue"  colspan="3">	
			<select name="user_check"  class="button" onChange="check_user()">查询方式
				<option value="1" selected>按虚拟号码查询</option>
				<option value="2">按虚拟成员号码查询</option>
			</select> 
	   </td>	
	  
    </tr>
    
	<tr id="userpasswd" style="display:block">	
       <td class="blue" width="15%">虚拟集团账号</td>
       <td> 
         <input class="button"type="text" name="phoneNo" size="14" maxlength="14"  onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13) check_HidPwd();">
       </td>
    </tr>

	<tr id="userid" style="display:none">
      <td class="blue" width="15%">虚拟成员号码</td>
      <td> 
        <input class="button"type="text" name="cxhm" size="14" maxlength="14"  onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13) check_HidPwd();">
      </td>
    </tr>

  </table>

  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" name="query" class="b_foot" value="虚拟集团成员查询" onclick="xnjttj()" >
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