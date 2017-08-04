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
		String opCode = "g430";
		String opName = "签约用户扣费金额设置";
		Calendar today = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
		String dtime = sdf.format(today.getTime());
    today.add(Calendar.MONTH,-12);
    /*默认，12个月之前*/
    String startTime = sdf.format(today.getTime());
		
%>
<HTML>
<HEAD>
<script language="JavaScript">
<!--	


 

 function docheck()
{
	 var cus_pass = document.all.cus_pass.value;
	 var phone_no = document.all.phone_no.value;
	 if(phone_no=="")
	 {
		 rdShowMessageDialog("请输入手机号码!");
		 return false;
	 }	
	 if(cus_pass=="")
	 {
		rdShowMessageDialog("请输入用户密码!");
		return false;
	 }
	 var temp=document.getElementsByName("kg");
     var cg_select=document.getElementById("chs").value;
	 if(cg_select==0)
	 {
		 rdShowMessageDialog("请选择设置标识");
		 return false;
	 }	
	 //alert(cg_select);
	 var cg_radio="";
	 var values1 = document.all.values.value;

	 var values1_fz = document.all.values_fz.value;
	 if((cg_select=="1" &&values1=="")   )
	 {
		 rdShowMessageDialog("请输入设置金额 ");
		 return false;
	 }	
	 if(   (cg_select=="2" &&values1_fz=="") )
	 {
		 rdShowMessageDialog("请输入设置阀值");
		 return false;
	 }
	for (i=0;i<temp.length;i++){

  //遍历Radio

    if(temp[i].checked &&cg_select==3)

      {
		//  alert("你选择了"+temp[i].value);
		  cg_radio=	temp[i].value;
      //获取Radio的值

     // document.form2.textfield.value="你选择了"+temp[i].value;

      //传递给另外一个表单

      }

  }
		if(cg_select==3 &&cg_radio=="")
		{
			rdShowMessageDialog("请确认开关");
			return false;
		}

 
        //rdShowMessageDialog("用户解约成功!");
 
		document.frm.action="g430_2.jsp?kg="+cg_radio+"&flag="+cg_select+"&values="+values1+"&custPass="+cus_pass+"&phoneNo="+phone_no+"&value_fz="+values1_fz;
	   // alert("kg is "+cg_radio+" and flag is "+cg_select+" and values1 is "+values1);
	    document.frm.submit();
 
	 
 } 
 
 


 
 
  function doclear() {
 		frm.reset();
 }
	
	function inits()
	{
		document.getElementById("div1").style.display="none";
		document.getElementById("div2").style.display="none";
		document.getElementById("div3").style.display="none";
	}

	function changes()
	{
		var cg_id=document.getElementById("chs");
		var cg_txt = cg_id.options(cg_id.selectedIndex).text;
		//alert("cg_id is "+cg_id.value+" and cg_txt "+cg_txt);
		if(cg_id.value==3)
		{
			document.getElementById("div1").style.display="none";
			document.getElementById("div3").style.display="none";
			document.getElementById("div2").style.display="block";
			document.all.values.value="";//开关时 输入框值为空
		}
		if(cg_id.value==1) 
		{
			document.getElementById("div1").style.display="block";
			document.getElementById("div2").style.display="none";
			document.getElementById("div3").style.display="none";
			//document.all.values.value="";//设置 金额时 
		}
		if(cg_id.value==2) 
		{
			document.getElementById("div3").style.display="block";
			document.getElementById("div2").style.display="none";
			document.getElementById("div1").style.display="none";
			//document.all.values.value="";//设置阀值 
		}

	}


-->
 </script> 
 
<title>黑龙江BOSS-普通缴费</title>
</head>
<BODY onload="inits()">
<form action="" method="post" name="frm">
		
		<%@ include file="/npage/include/header.jsp" %>   
  	<div class="title">
			<div id="title_zi">请输入查询条件</div>
		</div>
	<table cellspacing="0">
    <tr> 
      
	  <td class="blue" width="15%">手机号码</td>
      <td> 
        <input class="button"type="text" name="phone_no" size="20" maxlength="12"  onKeyPress="return isKeyNumberdot(0)" >
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

	<tr> 
	  <td class="blue" width="15%">设置标识</td>
	  <td>
      <select id="chs" name="cg" onchange="changes()">
		<option value="0">请选择</option>
		<option value="1">金额</option>
		<option value="2">阀值</option>
		<option value="3">开关</option>
	  </select>
	 &nbsp;&nbsp;&nbsp;&nbsp;
        <div id="div1">
			<input class="button"type="text" name="values"  >
		</div>
		<div id="div3">
			<input class="button"type="text" name="values_fz"  >
		</div>
		<div id="div2">
			<input type="radio" name="kg" value="1" checked>开&nbsp;
			<input type="radio" name="kg" value="0">关
		</div>
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