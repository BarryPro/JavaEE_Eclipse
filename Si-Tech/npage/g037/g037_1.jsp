<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����: �����ز���ͳ�Ʊ���2148
   * �汾: 1.0
   * ����: 200/01/04
   * ����: leimd
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%	request.setCharacterEncoding("GBK");%>
<%@ page import="org.apache.log4j.Logger"%>
<%
	String opCode="g037";
	String opName="�м����в�����ϸ����";
	String work_no = (String)session.getAttribute("workNo");
	String rpt_right = (String)session.getAttribute("rptRight");
	String org_code = (String)session.getAttribute("orgCode");
    String sqlStr="";
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String[] inParas2 = new String[1];
	inParas2[0]="select bank_code,bank_name from QD_BANKCODE ";
	String[] inParas1 = new String[1];
	inParas1[0]="select region_code,region_name from sregioncode ";
 
%>
<wtc:service name="TlsPubSelBoss" routerKey="phone" routerValue="15004675829"  retcode="retCode1" retmsg="retMsg1" outnum="2">
	<wtc:param value="<%=inParas2[0]%>"/> 	
	</wtc:service>
<wtc:array id="ret_val" scope="end" />

<wtc:service name="TlsPubSelBoss" routerKey="phone" routerValue="15004675829"  retcode="retCode2" retmsg="retMsg2" outnum="2">
	<wtc:param value="<%=inParas1[0]%>"/> 	
	</wtc:service>
<wtc:array id="ret_val2" scope="end" />
<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD><TITLE>ʡ�����в�����ϸ����</TITLE>
</HEAD>
<body>
 
 

 	
<script src="invoice_boss.js" type="text/javascript"></script>		

<SCRIPT language="JavaScript">
function doSubmit()
{
	getAfterPrompt()
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
 
    select_boss(document.form1);
 
    document.form1.submit();
  
}

</SCRIPT> 

<FORM method=post name="form1" >
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">��ѡ���������</div>
	</div>

<table cellSpacing="0">
			

   <tr>
		<td  class="blue">��������</td>
		<td>
			<select name="bank_name" id= "selOp" >
				<!--
				<option value="0" selected></option>
				-->
				<%for(int i=0; i<ret_val.length; i++){%>
				<option value="<%=ret_val[i][0]%>">
				
				<%=ret_val[i][0]%>--><%=ret_val[i][1]%></option>
				<%}%>
 
			</select>
		</td>
		<td  class="blue">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��</td>
		<td>
			<select name="region_name"  >
				<!--
				<option value="0" selected></option>
				-->
				<%for(int i=0; i<ret_val2.length; i++){%>
				<option value="<%=ret_val2[i][0]%>">
				
				<%=ret_val2[i][0]%>--><%=ret_val2[i][1]%></option>
				<%}%>
 
			</select>
		</td>
		 
	</tr>
	 
	<tr>
		<td class="blue">��ʼʱ��</td>
		<td>
			<input type="text" v_type="date"  name="begin_time" value=<%=dateStr%> size="17" maxlength="17">
		</td>
		<td class="blue">����ʱ��</td>
		<td>
			<input type="text" v_type="date"  name="end_time" value=<%=dateStr%> size="17" maxlength="17">
		</td>
	</tr>
	<tr id="phone_head" style="display:none">
		<td class="blue">��ʼ�Ŷ�</td>
		<td>
			<input type="text" class="button" name="begin_phonehead"  size="17" maxlength="7" >
		</td>
		<td class="blue">��ʼ�Ŷ�</td>
		<td>
			<input type="text" class="button" name="end_phonehead"  size="17" maxlength="7"  >
		</td>
	</tr>
	<tr> 
		<td align="center" id="footer" colspan="4">
		&nbsp; <input id=submits class="b_foot" name=submits onclick="return(doSubmit())" type=button value=ȷ��>
		&nbsp; <input class="b_foot" name=reee  type=button onClick="form1.reset()" value=���>
		&nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=����>
		&nbsp; <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=�ر�>
		</td>
	</tr>
</table>
      <input type="hidden" name="workNo" value="<%=work_no%>">
      <input type="hidden" name="org_code" value="<%=org_code%>">
      <input type="hidden" name="hDbLogin" value ="dbchange">
      <input type="hidden" name="rptright" value="D">
      <input type="hidden" name="hParams1" value="">
      <input type="hidden" name="hTableName" value="">
  
  <%@ include file="/npage/public/pubSearchText.jsp" %>
	<%@ include file="/npage/include/footer.jsp" %> 
</FORM>
</BODY></HTML>
<script language="javascript">
/*----------------------------����RPC������������------------------------------------------*/

 onload=function(){
	form1.reset();
		
	}
 

 	
</script>
