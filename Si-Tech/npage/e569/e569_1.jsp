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
<title>Ͷ���˷�ͳ�Ʋ�ѯ</title>
<%
    //String opCode="8379";
	//String opName="����Ԥ���";

    String opCode="e569";
	String opName="Ͷ���˷�ͳ�Ʋ�ѯ";	
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
<form action="" name="frm" method="POST">
 	<input type="hidden" name="opcode" value = "e569" >
	<input type="hidden" name="opname" value = "Ͷ���˷�ͳ�Ʋ�ѯ" >
	<%@ include file="/npage/include/header.jsp" %>

<div id="Operation_Table0"> 
<div class="title">
	<div id="title_zi">Ͷ���˷�ͳ�Ʋ�ѯ</div>
</div>	 
	<table cellspacing="0" id="tabList">
	   
		<tr >
			<td class="blue" >
				ͳ�ƿ�ʼʱ�䣺<input type="text" name="beginYm" value="" maxlength=8>(YYYYMMDD)
			</td>
			<td class="blue" >
				ͳ�ƽ���ʱ�䣺<input type="text" name="endYm" value="" maxlength=8>(YYYYMMDD)
			</td>
		</tr>
		<tr >
			<td class="blue" colspan=2>
				ͳ&nbsp;��&nbsp;��&nbsp;��:&nbsp;&nbsp;&nbsp;<select id="selOp" name="tjtj">
					<option value="1">�ֻ���Ƶ����ý�壩</option>
					<option value="2">MDO</option>
					<option value="3">�ֻ����������</option>
					<option value="4">�ֻ���Ϸ</option>
				</select>
			</td>
			 
		</tr> 
		 
		<tr >
			<td align=center colspan=2><input type=button class="b_foot" name="check2" value="ͳ��" id="cz" onclick="docfm()" >
			<!--
			<input type=button class="b_foot" value="���ɱ���" onclick="printTable(tabList)" >
			-->
			
			<input type=reset class="b_foot" value="����" >
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
		var beginYm = document.all.beginYm.value;
		var objSel = document.getElementById("selOp");
		var tjtj1= objSel.options(objSel.selectedIndex).text;
		var endYm = document.all.endYm.value;
		if(beginYm=="")
		{
			rdShowMessageDialog("������ͳ�Ʋ�ѯ��ʼʱ��!");
			return false;
		}
		else if(document.all.endYm.value=="")
		{
			rdShowMessageDialog("������ͳ�Ʋ�ѯ����ʱ��!");
			return false;
		}	
		else
		{
			var actions = "e569_2.jsp?tjtj1="+tjtj1;
			document.all.frm.action=actions;
			document.all.frm.submit();
			
		}
		
		
	}

 

</script>
 
 