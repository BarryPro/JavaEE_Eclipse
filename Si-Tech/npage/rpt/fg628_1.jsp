<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能: g628
   * 版本: 1.0
   * 日期: 2009/07/29
   * 作者: zhenghan
   * 版权: si-tech
   * update:
  */
%>
<%@ page contentType="text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<% request.setCharacterEncoding("GBK");%>
<%
	String opCode="g628";
	String opName="移动银行分期付款对账稽核报表";
	String work_no = (String)session.getAttribute("workNo");
	String rpt_right = (String)session.getAttribute("rptRight");
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode=(String)session.getAttribute("regCode");
	String town="";
    String sqlStr="";
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
%>
<script language="JavaScript">
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>移动银行分期付款对账稽核报表</TITLE>
</HEAD>
<body>
	
<%if(rpt_right.compareTo("9")>=0){%>
<script language="jscript">
	rdShowMessageDialog('您没有操作此报表的权限!');
	window.close();
</script>
<%}%>
	
<SCRIPT language="JavaScript">	
	
function doSubmit()
{

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
    if(document.form1.rpt_type.value==1)
    {
    	hTableName.value="rbo006";
		hParams1.value= "prc_g628_01('"+document.form1.workNo.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"','"+document.form1.region_code.value+"','"+document.form1.op_code.value+"'";
    }
    else if(document.form1.rpt_type.value==2)
    {
    	hTableName.value="rbo006";
		hParams1.value= "prc_g628_02('"+document.form1.workNo.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"','"+document.form1.region_code.value+"','"+document.form1.op_code.value+"'";
    }
    submit();
  }
}

</SCRIPT>

<FORM method=post name="form1" action="/npage/rpt/print_rpt.jsp">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">请选择条件</div>
	</div>
	<table cellSpacing="0">
		<tr>
			<td class="blue">操作报表</td>
			<td>
				<select name=rpt_type style="width:280px">
					<option class='button' value=1>1->移动银行分期付款对账稽核报表</option>
					<option class='button' value=2>2->移动银行分期付款对账差错数据明细报表</option>
				</select>
			</td>
			<td class="blue">报表格式</td>
			<td>
				<select name=rpt_format>
					<option class='button' value=10000>明细</option>
				</select>
			</td>
		</tr>
		<tr >
			<td class="blue" >地区</td>
			<td>
				<select id=region_code name=region_code>
					<option class='button' value='xx'>xx-- >全省</option>
					<wtc:qoption  name="sPubSelect"  routerKey="region"  routerValue="<%=regionCode%>"  outnum="2">
						<wtc:sql>
							select region_code,region_code||'-- >'||nvl(region_name,region_code) from sRegionCode where region_code<>'00' and use_flag='Y' Order By region_code
						</wtc:sql>
					</wtc:qoption>
				</select>
			</td>
			<td class="blue" >操作代码</td>
			<td>
				<select id=op_code name=op_code style="width:180px">
					<option class='button' value='xxxx'>xx-- >全部</option>
					<option class='button' value='8030'>8030-- >集团客户预存赠话机</option>
					<option class='button' value='e505'>e505-- >合约计划购机</option>
				</select>
			</td>
		</td>
		<tr>
			<td class="blue">开始时间</td>
			<td>
				<input type="text"    name="begin_time" value=<%=dateStr%> size="17" maxlength="17">
			</td>
			<td class="blue">结束时间</td>
			<td>
				<input type="text"    name="end_time" value=<%=dateStr%> size="17" maxlength="17">
			</td>
		</tr>
		<tr>
			<td colspan="4" align="center" id="footer">
			&nbsp; <input id=submits class="b_foot" name=submits onclick="return(doSubmit())" type=button value=确认>
			&nbsp; <input class="b_foot" name=reee  type=button onClick="form1.reset()" value=清除>
			&nbsp; <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=关闭>
			</td>
		</tr>
	</tr>
	<input type="hidden" name="workNo" value="<%=work_no%>">
      <input type="hidden" name="org_code" value="<%=org_code%>">
      <input type="hidden" name="rptRight" value="T">
      <input type="hidden" name="hDbLogin" value ="dbchange">
      <input type="hidden" name="hParams1" value="">
      <input type="hidden" name="hTableName" value="">
	</table>
	<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>