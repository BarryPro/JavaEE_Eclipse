<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-15 ҳ�����,�޸���ʽ
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
		String opCode = "zgbb";
		String opName = "Ԥ��רƱͳ�Ʊ���";
		Calendar today = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
		String dtime = sdf.format(today.getTime());
    today.add(Calendar.MONTH,-12);
    /*Ĭ�ϣ�12����֮ǰ*/
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
			rdShowMessageDialog("��ʼʱ��Ƚ���ʱ���");
			return false;
		  }
		  with(document.forms[0])
		  {
			//alert(document.form1.region_code.value);
			  hTableName.value="RPT003";
				//hParams1.value= "dbcustadm.prc_zg47_rpt('"+document.form1.workNo.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"' ";
			  
				hParams1.value= "dbcustadm.prc_zpyk_rpt('"+document.form1.workNo.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"'";
			  //alert(hParams1.value);
			  submit();
		  }
	
}
 


 function doclear() {
 		frm.reset();
 }
   
  
 
 </script> 
 
<title>������BOSS-��ͨ�ɷ�</title>
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
		<td class="blue">��ʼʱ��</td>
		<td>
			<input type="text"   name="begin_time" value=<%=dateStr%> size="17" maxlength="17">
		</td>
		<td class="blue">����ʱ��</td>
		<td>
			<input type="text"   name="end_time" value=<%=dateStr%> size="17" maxlength="17">
		</td>
	</tr>
  </table>

  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" name="query" class="b_foot" value="�����ѯ" onclick="xnjttj()" >
          &nbsp;
          <input type="button" name="return1" class="b_foot" value="���" onclick="doclear()" >
          &nbsp;
		      <input type="button" name="return2" class="b_foot" value="�ر�" onClick="removeCurrentTab()" >
      </td>
    </tr>
  </table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %>
</form>
 </BODY>
</HTML>