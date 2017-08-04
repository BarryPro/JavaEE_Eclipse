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
		String opCode = "d568";
		String opName = "自助终端缴费信息查询";
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
	
  if(document.frm.check_code.value=="" && document.frm.check_no.value=="" &&document.frm.loginno.value=="" &&document.frm.phoneno.value=="")
  {
      rdShowMessageDialog("请至少输入发票代码、发票号码、受理工号或缴费号码中的一项作为查询条件!");
     	document.frm.check_code.focus();
     	return false;
  }
  if(document.frm.print_begin.value=="" &&document.frm.print_end.value=="")
  {
      rdShowMessageDialog("打印开始和结束时间怎么确定?");
     	document.frm.print_begin.focus();
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
		if(month_1>12){
			rdShowMessageDialog("打印开始与打印结束时间间隔不可以大于12个月!");
			return false;
		}
	   document.frm.action="d568_2.jsp?check_code="+document.frm.check_code.value+"&check_no="+document.frm.check_no.value+"&loginno="+document.frm.loginno.value+"&phoneno="+document.frm.phoneno.value;
	   document.frm.query.disabled=true;
	   document.frm.submit();
 
	 
 } 
//计算月差的函数
function DateDiff2(date1,date2){
	  var year1 =  date1.substr(0,4);
	  var year2 =  date2.substr(0,4); 
	  var month1 = date1.substr(4,2);
	  var month2 = date2.substr(4,2);
	  
	  var len=(year2-year1)*12+(month2-month1);
	  
	  return len;


}
 


 
 
  function doclear() {
 		frm.reset();
 }


//获取开始结束时间段
function GetDateT(){
	
  var d,s;
  d = new Date();
  //取年份
  s = d.getYear().toString() ;
  //取月份
  if(d.getMonth()<9){
		s = s + "0"+((d.getMonth() + 1).toString()) ;
  }
  else{
		s = s + ((d.getMonth() + 1).toString()) ;
  }
  //取日期
  /*if(d.getDate()<10){
	  s = s+"0"+d.getDate().toString() ;
  }
  else{
	  s = s+d.getDate().toString() ;
  }*/
  document.getElementById("edate").value=s ;
  //开始时间 超级麻烦的算法
  var s1,s2;
  alert("d.getMonth is "+d.getMonth());
  if(d.getMonth()>5 ){ // 这个值 稍后再算下
		s2 = d.getMonth() + 1-12;
		if(s2<10){
		 s2 = "0"+s2.toString();
		}
		s1 = d.getYear().toString() ;
  }
  else if(d.getMonth()< 5){
    s2 = d.getMonth() + 1+12-12;
		if(s2<10){
		s2 = "0"+s2.toString();
		}
		s1 = (d.getYear()-1).toString() ;
  }
  else{
	  s2 = 12;
	  s1 = (d.getYear()-1).toString() ;
  }
  s1 = s1 + s2 ;//取月份
  //取日期
  /*
  if(d.getDate() <10 ){
		s1 = s1+ "0"+d.getDate().toString() ;
  }
  else{
		s1 = s1+ d.getDate().toString() ;
  }*/
  document.getElementById("bdate").value=s1 ;
  alert('full is '+s);
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
      <td class="blue" width="15%">发票代码</td>
      <td> 
        <input class="button"type="text" name="check_code" size="20" maxlength="12"  onKeyPress="return isKeyNumberdot(0)" >
      </td>
      <td class="blue">发票号码</td>
      <td> 
        <input type="text" name="check_no" size="20" maxlength="20" onKeyPress="return isKeyNumberdot(0)" >
      </td>
       
    </tr>
	<tr>
		<td class="blue">打印开始月份</td>
      <td> 
        <input type="text" name="print_begin" id = "bdate" value="<%=startTime%>" size="20" maxlength="6" onKeyPress="return isKeyNumberdot(0)" >
      </td>
       <td class="blue">打印结束月份</td>
      <td> 
        <input type="text" name="print_end" id= "edate" value="<%=dtime%>" size="20" maxlength="6" onKeyPress="return isKeyNumberdot(0)"  >
      </td>
	</tr>

	<tr>
		<td class="blue">受理工号</td>
      <td> 
        <input type="text" name="loginno" size="20" maxlength="20"  >
      </td>
       <td class="blue">缴费号码</td>
      <td> 
        <input type="text" name="phoneno" value="<%=activePhone%>" readonly size="20" maxlength="20" onKeyPress="return isKeyNumberdot(0)"  >
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