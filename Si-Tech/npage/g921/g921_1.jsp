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
		String opCode = "g921";
		String opName = "飞豆充值记录查询";
		Calendar today = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
		String dtime = sdf.format(today.getTime());
    today.add(Calendar.MONTH,-5);
    /*默认，12个月之前*/
    String startTime = sdf.format(today.getTime());
	activePhone = request.getParameter("activePhone");	
%>
<HTML>
<HEAD>
<script language="JavaScript">
<!--	








function check_HidPwd()
{
  if(document.frm.phoneno.value=="")
  {
     rdShowMessageDialog("请输入服务号码!");
     document.frm.phoneno.focus();
     return false;
  }
  

  if( document.frm.phoneno.value!="" && document.frm.phoneno.value.length != 11 )
  {
     rdShowMessageDialog("服务号码只能是11位!");
     document.frm.phoneno.value = "";
     document.frm.phoneno.focus();
     return false;
  }
	            
	
}

 function docheck()
{
	
  if(document.frm.phoneno.value=="")
  {
		rdShowMessageDialog("请输入查询手机号码!");
     	document.frm.phoneno.focus();
     	return false;
  }
 
		var s_begin = document.frm.print_begin.value;
		var s_end = document.frm.print_end.value;
  
        
		if(((/^20[0-9][0-9]((0[1-9])|(1[0-2]))$/.test(s_begin)) == false) )
		{
			rdShowMessageDialog("打印开始时间格式不正确!请按YYYYMM格式输入!");
			document.frm.print_begin.value="";
			document.frm.print_begin.focus();
			return false;
		}
		if(((/^20[0-9][0-9]((0[1-9])|(1[0-2]))$/.test(s_end)) == false) )
		{
			rdShowMessageDialog("打印结束时间格式不正确!请按YYYYMM格式输入!");
			document.frm.print_end.value="";
			document.frm.print_end.focus();
			return false;
		}
 
		//增加 开始时间>结束时间的话 报错~
		if(s_begin>s_end)
		{
			rdShowMessageDialog("打印开始时间不可以大于结束时间!");
			return false;
		}
		//增加 结束时间-开始时间>12的限制
 
		var month_1 =  DateDiff2(s_begin,s_end);
		//alert("月份差是 "+month_1);
		if(month_1>6){
			rdShowMessageDialog("打印开始与打印结束时间间隔不可以大于6个月!");
			return false;
		}
 
	   document.frm.action="g921_2.jsp?phoneno="+document.frm.phoneno.value;
 
	   //document.frm.query.disabled=true;
	   document.frm.submit();
	 
 } 
//计算月差的函数
function DateDiff2(date1,date2){
	  var year1 =  date1.substr(0,4);
	  var year2 =  date2.substr(0,4); 
	  var month1 = date1.substr(4,2);
	  var month2 = date2.substr(4,2);
	  
	  var len=(year2-year1)*6+(month2-month1);
	  
	  return len;


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
      <td class="blue" width="15%">手机号码</td>
      <td colspan=3> 
        <input class="button"type="text" name="phoneno" size="20" maxlength="11" value="<%=activePhone%>" readonly  onKeyPress="return isKeyNumberdot(0)" >
      </td>
      
    </tr>
	<tr>
		<td class="blue">查询开始年月</td>
      <td> 
        <input type="text" name="print_begin" id = "bdate" value="<%=startTime%>" size="20" maxlength="6" onKeyPress="return isKeyNumberdot(0)" readonly>
      </td>
       <td class="blue">查询结束年月</td>
      <td> 
        <input type="text" name="print_end" id= "edate" value="<%=dtime%>" size="20" maxlength="6" onKeyPress="return isKeyNumberdot(0)"  readonly>
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