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
		String opCode = "g925";
		String opName = "小额流量费用争议退费";
		Calendar today = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
		String dtime = sdf.format(today.getTime());
    today.add(Calendar.MONTH,-1);
    /*默认，12个月之前*/
    String startTime = sdf.format(today.getTime());
	//activePhone = request.getParameter("activePhone");	
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
		var year_month = document.all.year_month.value;	
	 
	  if(document.all.phone_no.value=="")
	  {
		  rdShowMessageDialog("请输入用户手机号码!");
			document.all.phone_no.focus();
			return false;
	  }
	  if(document.all.year_month.value=="")
	  {
		  rdShowMessageDialog("请输入查询统计年月!");
			document.all.year_month.focus();
			return false;
	  }		 
		   document.frm.action="g925_2.jsp?phoneno="+document.all.phone_no.value+"&year_month="+year_month;
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
			<div id="title_zi">请输入投诉用户手机号码</div>
		</div>
	<table cellspacing="0">
    <tr> 
      <td class="blue" width="15%">手机号码</td>
      <td> 
        <input class="button"type="text" name="phone_no" size="20" maxlength="11"  onKeyPress="return isKeyNumberdot(0)"   >
      </td>
       
      <td class="blue" width="15%">查询统计年月</td>
      <td> 
        <input class="button"type="text" name="year_month" size="20" maxlength="6" value="<%=startTime%>"  onKeyPress="return isKeyNumberdot(0)" >
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