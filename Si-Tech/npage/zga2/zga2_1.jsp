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
	 
		String opCode = "zga2";
		String opName = "校园赠卡充值明细报表";
		Calendar today = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
		String dtime = sdf.format(today.getTime());
    today.add(Calendar.MONTH,-12);
    /*默认，12个月之前*/
    String startTime = sdf.format(today.getTime());
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String work_no = (String)session.getAttribute("workNo");
	String org_code = (String)session.getAttribute("orgCode");
	String rpt_right= (String)session.getAttribute("rptRight");
	String regionCode=(String)session.getAttribute("regCode");
%>
<HTML>
<HEAD>
<script language="JavaScript">
 
function xnjttj()
{
	var login_no = document.all.login_no.value;
	//alert("login_no is "+login_no);
	if(document.form1.all("begin_time").value.length == 8)
			  document.form1.begin_time.value=document.form1.begin_time.value+" 00:00:00";
		  if(document.form1.all("end_time").value.length == 8)
			  document.form1.end_time.value=document.form1.end_time.value+" 23:59:59";

		  if(!check(form1))
		  {
			return false;
		  }

		  var begin_time=document.form1.begin_time.value;
		  var end_time=document.form1.end_time.value;
		  if(begin_time>end_time)
		  {
			rdShowMessageDialog("开始时间比结束时间大");
			return false;
		  }
		  with(document.forms[0])
		  {
			//alert(document.form1.region_code.value);
			  hTableName.value="RPT003";
				//hParams1.value= "dbcustadm.prc_zg47_rpt('"+document.form1.workNo.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"' ";
			  
				hParams1.value= "dbcustadm.prc_zga2_rpt('"+document.form1.workNo.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"','"+document.form1.org_code1.value+"','"+document.form1.login_no.value+"'";
			 // alert(hParams1.value);
			  submit();
		  }
	
}
 


 function doclear() {
 		frm.reset();
 }
   
 function getLoginInfo()
 {
	 document.all.login_no.value="<%=work_no%>";
	 document.all.login_name.value="";
 }
 function getLoginNo()
 {
	 var login_no = document.all.login_no.value;
	 if(login_no=="")
	 {
		rdShowMessageDialog("请输入工号信息!");
		return false;
	 }
	 else
	 {
		var pageTitle = "营业员查询";
		var fieldName = "营业员工号|营业员名称";
		/****************************************************
		var sqlStr=" select rtrim(login_no),rtrim(login_name)   from dloginmsg" +
							 " where org_code like '" +document.all.district_code.value+document.all.town_code.value+
							 "%' ";
		*****************************************************/
		var sqlStr=" select rtrim(login_no),rtrim(login_name)   from dloginmsg" +
							 " where  vilid_flag='1' ";
		if("<%=rpt_right%>" >= "9")
		{
			sqlStr = sqlStr + " and login_no = '<%=work_no%>'";
		}
		
		if(document.form1.login_no.value != "")
		{
			sqlStr = sqlStr + " and login_no like '" + document.form1.login_no.value + "%'";
		}
		sqlStr = sqlStr + " order by login_no" ;
		var selType = "S";    //'S'单选；'M'多选
		var retQuence = "0|1";
		var retToField = "login_no|login_name";
		PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);
	 }	
 }
 </script> 
 
<title>黑龙江BOSS-普通缴费</title>
</head>
<BODY>
<form  action="../rpt/print_rpt_boss.jsp" method="post" name="form1">
		
		<%@ include file="/npage/include/header.jsp" %>   
  	<input type="hidden" name="rpt_code" value="0">
	<input type="hidden" name="rpt_code1" value="1">
	<input type="hidden" name="rpt_right" value="<%=rpt_right.trim()%>">
	<input type="hidden" name="workNo" value="<%=work_no%>">
	<input type="hidden" name="org_code" value="<%=org_code%>">
	<input type="hidden" name="org_code1" value="<%=org_code.substring(0,2).trim()%>">
	<input type="hidden" name="hDbLogin" value ="dbchange">
	<input type="hidden" name="hParams1" value="">
	<input type="hidden" name="op_code" value="zg47">
	<input type="hidden" name="login_accept" value="">
	<input type="hidden" name="hTableName" value=""> 
	
  <table cellspacing="0">
    <tr>
		<td class="blue">营 业 员</td>
		<td colspan="3">
			<input type="text" name="login_no" class="button" maxlength="6" size="8" onChange="changeLoginNo()">
			<input type="text" name="login_name" class="button" disabled>
			<input name="loginNoQuery" class="b_text" type="button" onClick="getLoginNo()" value="查询">
			<input type="button" class="b_text" value="当前营业员" onclick="getLoginInfo()" />
		</td>
	</tr> 
	<tr>
		<td class="blue">开始时间</td>
		<td>
			<input type="text"   name="begin_time" value=<%=dateStr%> size="17" maxlength="17">
		</td>
		<td class="blue">结束时间</td>
		<td>
			<input type="text"   name="end_time" value=<%=dateStr%> size="17" maxlength="17">
		</td>
	</tr>
  </table>

  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" name="query" class="b_foot" value="报表查询" onclick="xnjttj()" >
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