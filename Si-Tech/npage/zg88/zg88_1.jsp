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

    String opCode="zg88";
	String opName="���ּ���������";	
 
    String workNo=(String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String regionCode=(String)session.getAttribute("regCode");
	String contextPath = request.getContextPath();
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
 	<input type="hidden" name="opcode" value = "zg88" >
	<input type="hidden" name="opname" value = "���ּ���������" >
	<%@ include file="/npage/include/header.jsp" %>
  
<div id="Operation_Table0"> 
<div class="title">
	<div id="title_zi">���ּ���������</div>
</div>	 
	
	<table cellspacing="0" id="tabList">
			<tr> 
			  <td class="blue">�ֻ�����</td>
				<td class="blue">	
					<input type="text" name="phone_no" maxlength="14">
				</td>            
			</tr> 
			  
		<tr >
			<td align=center colspan=4><input type=button class="b_foot" name="check2" value="��ѯ" id="cz" onclick="docfm()" >
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
		//var ThirdClass_new = 
		var phone_no = document.all.phone_no.value;
		//var beizhu = document.all.beizhu.value;
		if(phone_no=="")
		{
			rdShowMessageDialog("�������ֻ�����!");
			return false;
		}	
		/*
		else if(beizhu=="")
		{
			rdShowMessageDialog("�����뱸ע��Ϣ");
			return false;
		}*/
		else
		{
			var actions = "zg88_qry.jsp";
			document.all.frm.action=actions;
			document.all.frm.submit();
		}
	}
          
 

</script>
 
 