<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����: ����Ԥ��� 8379
   * �汾: 1.0
   * ����: 2010/3/12
   * ����: sunaj
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%
	request.setCharacterEncoding("GBK");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>�ں��ײ�ҵ���ѯ</title>
<%
	String opCode="zg53";
	String opName="�ں��ײ�ҵ���ѯ";	
	String phoneNo = (String)request.getParameter("activePhone");
    String workNo=(String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String regionCode=(String)session.getAttribute("regCode");
 
%>
<%
  /****�õ���ӡ��ˮ****/
  String printAccept="";
  printAccept = getMaxAccept();

 
%>
 		
 
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

</head>  
<body>
<form action="/npage/rpt/print_rpt_crm.jsp" method="post" name="frm" >
 	<input type="hidden" name="opcode" value = "zg53" >
	<input type="hidden" name="opname" value = "�ں��ײ�ҵ���ѯ" >
	<input type="hidden" name="hParams1" value="">
	<input type="hidden" name="hTableName" value="">
	<input type="hidden" name="hDbLogin" value ="dbchange">
	<%@ include file="/npage/include/header.jsp" %>

<div id="Operation_Table0"> 
<div class="title">
	<div id="title_zi">�ں��ײ�ҵ���ѯ</div>
</div>	 
	<table cellspacing="0" id="tabList">
	   
		<tr >
			<td align=center colspan=2><input type=button class="b_foot" name="check2" value="��ѯ" id="cz" onclick="docfm()" >

			</td>
		<tr>
		</tr>
		
	</table>
</div>
 
 
 
</table>
 
 
    <%@ include file="../../npage/common/pwd_comm.jsp" %>
    <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>
<script language="javascript">
 
	function docfm()
	{
		document.frm.hTableName.value="rfo006";
		document.frm.hParams1.value= "dbcustadm.PRC_zg53_RPT('<%=workNo%>','<%=workNo%>'";	
		//document.frm.hParams1.value= "dbcustadm.PRC_zg53_RPT('<%=workNo%>','<%=workNo%>','<%=printAccept%>')";	
		document.frm.check2.disabled=true;
		document.all.frm.submit();
	}

</script>
 
 