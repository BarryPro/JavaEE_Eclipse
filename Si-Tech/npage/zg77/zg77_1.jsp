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
		String opCode = "zg77";
		String opName = "集团发票打印取消";
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
 
function zg45qry(opcode)
{
	var invoice_number = document.frm.invoice_number.value;
	var invoice_code = document.frm.invoice_code.value;
	var begin_ym = document.frm.begin_ym.value;
	var end_ym = document.frm.end_ym.value; 
	if(invoice_number=="")
	{
		rdShowMessageDialog("请输入发票号码!");
		return false;
	}
	else if (invoice_code=="")
	{
		rdShowMessageDialog("请输入发票代码!");
		return false;
	}
	else if (begin_ym=="")
	{
		rdShowMessageDialog("请输入查询开始年月!");
		return false;
	}
	else if (end_ym=="")
	{
		rdShowMessageDialog("请输入查询结束年月!");
		return false;
	}
	else
	{
		document.frm.action="zg77_2.jsp?invoice_number="+invoice_number+"&invoice_code="+invoice_code+"&op_code="+opcode+"&begin_ym="+begin_ym+"&end_ym="+end_ym;
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
      <td class="blue" width="15%">发票号码</td>
      <td> 
        <input class="button"type="text" name="invoice_number" size="20" maxlength="20"  onKeyPress="return isKeyNumberdot(0)">
      </td>
    </tr>
	<tr> 
      <td class="blue" width="15%">发票代码</td>
      <td> 
        <input class="button"type="text" name="invoice_code" size="20" maxlength="20"  onKeyPress="return isKeyNumberdot(0)" >
      </td>
    </tr>
	<!--xl add for liugang 增加时间按钮 begin-->
	<tr> 
      <td class="blue" width="15%">查询开始时间</td>
      <td> 
        <input class="button"type="text" name="begin_ym" size="20" maxlength="6"  onKeyPress="return isKeyNumberdot(0)" >(YYYYMM)
      </td>
    </tr>
	<tr> 
      <td class="blue" width="15%">查询结束时间</td>
      <td> 
        <input class="button"type="text" name="end_ym" size="20" maxlength="6"  onKeyPress="return isKeyNumberdot(0)" >(YYYYMM)
      </td>
    </tr>
	<!--end of liugang 查询按钮-->

  </table>

  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" name="query" class="b_foot" value="预开发票信息查询" onclick="zg45qry('zg45')" >
          &nbsp;
		  <input type="button" name="query" class="b_foot" value="集团发票打印信息查询" onclick="zg45qry('1322')" >
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