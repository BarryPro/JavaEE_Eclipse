<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����: g628
   * �汾: 1.0
   * ����: 2009/07/29
   * ����: zhenghan
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@ page contentType="text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<% request.setCharacterEncoding("GBK");%>
<%
	String opCode="g628";
	String opName="�ƶ����з��ڸ�����˻��˱���";
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
<HEAD><TITLE>�ƶ����з��ڸ�����˻��˱���</TITLE>
</HEAD>
<body>
	
<%if(rpt_right.compareTo("9")>=0){%>
<script language="jscript">
	rdShowMessageDialog('��û�в����˱����Ȩ��!');
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
    rdShowMessageDialog("��ʼʱ��Ƚ���ʱ���");
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
		<div id="title_zi">��ѡ������</div>
	</div>
	<table cellSpacing="0">
		<tr>
			<td class="blue">��������</td>
			<td>
				<select name=rpt_type style="width:280px">
					<option class='button' value=1>1->�ƶ����з��ڸ�����˻��˱���</option>
					<option class='button' value=2>2->�ƶ����з��ڸ�����˲��������ϸ����</option>
				</select>
			</td>
			<td class="blue">�����ʽ</td>
			<td>
				<select name=rpt_format>
					<option class='button' value=10000>��ϸ</option>
				</select>
			</td>
		</tr>
		<tr >
			<td class="blue" >����</td>
			<td>
				<select id=region_code name=region_code>
					<option class='button' value='xx'>xx-- >ȫʡ</option>
					<wtc:qoption  name="sPubSelect"  routerKey="region"  routerValue="<%=regionCode%>"  outnum="2">
						<wtc:sql>
							select region_code,region_code||'-- >'||nvl(region_name,region_code) from sRegionCode where region_code<>'00' and use_flag='Y' Order By region_code
						</wtc:sql>
					</wtc:qoption>
				</select>
			</td>
			<td class="blue" >��������</td>
			<td>
				<select id=op_code name=op_code style="width:180px">
					<option class='button' value='xxxx'>xx-- >ȫ��</option>
					<option class='button' value='8030'>8030-- >���ſͻ�Ԥ��������</option>
					<option class='button' value='e505'>e505-- >��Լ�ƻ�����</option>
				</select>
			</td>
		</td>
		<tr>
			<td class="blue">��ʼʱ��</td>
			<td>
				<input type="text"    name="begin_time" value=<%=dateStr%> size="17" maxlength="17">
			</td>
			<td class="blue">����ʱ��</td>
			<td>
				<input type="text"    name="end_time" value=<%=dateStr%> size="17" maxlength="17">
			</td>
		</tr>
		<tr>
			<td colspan="4" align="center" id="footer">
			&nbsp; <input id=submits class="b_foot" name=submits onclick="return(doSubmit())" type=button value=ȷ��>
			&nbsp; <input class="b_foot" name=reee  type=button onClick="form1.reset()" value=���>
			&nbsp; <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=�ر�>
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