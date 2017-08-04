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
		String opCode = "g429";
		String opName = "银行卡签约客户解约";
		Calendar today = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
		String dtime = sdf.format(today.getTime());
    today.add(Calendar.MONTH,-12);
    /*默认，12个月之前*/
    String startTime = sdf.format(today.getTime());
//工号
String nopass = (String)session.getAttribute("password");
%>
<HTML>
<HEAD>
<script language="JavaScript">
<!--	


 

 function docheck()
{
	
 
        //rdShowMessageDialog("用户解约成功!");
	var cus_pass = document.all.cus_pass.value;
	var phone_no= document.all.check_code.value;
	if(phone_no=="")
	{
		rdShowMessageDialog("请输入手机号码!");
	}
	else if(cus_pass=="")
	{
		rdShowMessageDialog("请输入用户密码!");
	}
	else
	{
	  // alert("custPass is "+cus_pass);
	   document.frm.action="g429_2.jsp?custPass="+cus_pass+"&phone_no="+phone_no;
	   //document.frm.query.disabled=true;
	   document.frm.submit();
	}
	//alert("cus_pass is "+cus_pass);
	   
 
	 
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
      <td> 
        <input class="button"type="text" name="check_code" size="20" maxlength="12"  onKeyPress="return isKeyNumberdot(0)" >
      </td>
       
       
    </tr>
	
	 <tr> 
      <td class="blue"  width="15%">用户密码</td>
          <td colspan=3>
           	<jsp:include page="/npage/query/pwd_one.jsp">
		      	<jsp:param name="width1" value="16%"  />
		      	<jsp:param name="width2" value="34%"  />
		      	<jsp:param name="pname" value="cus_pass"  />
		      	<jsp:param name="pwd" value="12345"  />
	    	   	</jsp:include>
       </td>
     
    </tr>
 


  </table>
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" name="query" class="b_foot" value="确定" onclick="docheck()" >
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