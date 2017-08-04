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
		String opCode = "zg61";
		String opName = "月结发票作废";
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
	//取单选框
	var radiArr = document.getElementsByName("zflx");
	var radios="";
	for(var i=0;i<radiArr.length;i++)
    {
		if(radiArr[i].checked)
        {
			radios=radiArr[i].value;
			//alert("test "+radios);
		}
	}
	//var invoice_number = document.all.invoice_number.value;
	//var invoice_code = document.all.invoice_code.value;
	var phone_no = document.all.phone_no.value;
	var year_month = document.all.year_month.value;
	var zfyy = document.all.zfyy.value;
	/*if(invoice_number=="")
	{
		rdShowMessageDialog("请输入通用机打发票号码!");
		return false;
	}
	else if(invoice_code=="")
	{
		rdShowMessageDialog("请输入通用机打发票代码!");
		return false;
	} */
	if(phone_no=="")
	{
		rdShowMessageDialog("请输入用户手机号码!");
		return false;
	}
	else if(year_month=="")
	{
		rdShowMessageDialog("请输入月结发票打印年月!");
		return false;
	}
	else if(zfyy=="")
	{
		rdShowMessageDialog("请输入作废原因!");
		return false;
	}
	else
	{
		//alert("go?");
		document.frm.action="zg61_2.jsp?phone_no="+phone_no+"&year_month="+year_month+"&zfyy="+zfyy+"&radios="+radios;
		//alert(document.frm.action);
		document.frm.submit();
	}
	
	
}
 


 function doclear() {
 		frm.reset();
 }
   
  
 
 </script> 
 
<title>黑龙江BOSS-普通缴费</title>
</head>
<BODY>
<form action="" method="post" name="frm">
		
		<%@ include file="/npage/include/header.jsp" %>   
  	 
	
  <table cellspacing="0">
     

	<tr> 
      <td class="blue" width="15%">用户号码</td>
      <td> 
        <input class="button"type="text" name="phone_no" size="20"  colspan=2   onKeyPress="return isKeyNumberdot(0)"  >
      </td>
	  
    </tr>
	<tr> 
      <td class="blue" width="15%">月结发票打印的账单年月</td>
      <td> 
        <input class="button"type="text" name="year_month" maxlength=6  colspan=2   onKeyPress="return isKeyNumberdot(0)"  >
      </td>
    </tr>
	 
	<tr> 
      <td class="blue" width="15%">作废类型</td>
      <td> 
        <input class="button" name="zflx" type="radio" value="0" checked >卡纸<q>
		<input class="button" name="zflx" type="radio" value="1">白屏<q>
      </td>
    </tr> 
	<tr> 
      <td class="blue" width="15%">作废原因</td>
      <td> 
        <input class="button"type="text" name="zfyy" size="30" maxlength=15  colspan=2   >
      </td>
    </tr> 

  </table>

  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" name="query" class="b_foot" value="作废" onclick="xnjttj()" >
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