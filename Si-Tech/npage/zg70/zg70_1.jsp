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
		String opCode = "zg70";
		String opName = "省级工号关系配置";
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
	var login_no = document.all.login_no.value;
	if(login_no=="")
    {
		rdShowMessageDialog("请输入省级工号!");
		return false;
	}
	else
	{
		//1. 展示结果 如果未添加 则可展示添加按钮 如果已添加则展示删除按钮；
		//2. 上线前跟宫剑确认下 是否省级工号的退费权限都按照800001的 都不判断工号权限(跨地市那种)
		document.frm.action="zg70_2.jsp?sjgh="+login_no;
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
  	
	
	<div class="title">
			<div id="title_zi">请输入工号</div>
	</div>
	

	
  <table cellspacing="0">
    <tr> 
      <td class="blue" width="15%">省级工号</td>
      <td> 
        <input class="button"type="text" name="login_no" size="14" maxlength="6" >
      </td>
      
    </tr>
	
  </table>

  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" name="query" class="b_foot" value="查询" onclick="xnjttj()" >
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