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
		String opCode = "zgad";
		String opName = "集团产品转账冲正";
		Calendar today = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
		String dtime = sdf.format(today.getTime());
    today.add(Calendar.MONTH,-12);
    /*默认，12个月之前*/
    String startTime = sdf.format(today.getTime());
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String work_no = (String)session.getAttribute("workNo");
	String org_code = (String)session.getAttribute("orgCode");
 
	String regionCode=(String)session.getAttribute("regCode");
%>
<HTML>
<HEAD>
<script language="JavaScript">
 
function xnjttj()
{
	var jtcpzh = document.form1.jtcpzh.value;	 
	var jtkhid = document.form1.jtkhid.value; 
	if(jtcpzh=="" ||jtkhid=="")
	{
		rdShowMessageDialog("请输入集团产品账号和集团客户ID");
		return false;
	}	
	else
	{
		document.form1.action="zgad_2.jsp?jtcpzh="+jtcpzh+"&jtkhid="+jtkhid;
		document.form1.submit();
	}
}
 


 function doclear() {
 		frm.reset();
 }
   
  
 
 </script> 
 
<title>黑龙江BOSS-普通缴费</title>
</head>
<BODY>
<form  action="" method="post" name="form1">
		
		<%@ include file="/npage/include/header.jsp" %>   
  	<input type="hidden" name="rpt_code" value="0">
	<input type="hidden" name="rpt_code1" value="1">

	<input type="hidden" name="workNo" value="<%=work_no%>">
	<input type="hidden" name="org_code" value="<%=org_code%>">
	<input type="hidden" name="org_code1" value="<%=org_code.substring(0,2).trim()%>">
 
 
	
  <table cellspacing="0">
    
	<tr>
		<td class="blue">集团产品账号</td>
		<td>
			<input type="text"   name="jtcpzh"  >
		</td>
		<td class="blue">集团客户id</td>
		<td>
			<input type="text"   name="jtkhid" >
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