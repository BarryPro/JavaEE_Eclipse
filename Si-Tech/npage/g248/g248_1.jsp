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
<title>�ֹ���ֵ����ֵ</title>
<%
    //String opCode="8379";
	//String opName="����Ԥ���";

    String opCode="g248";
	String opName="�ֹ���ֵ����ֵ";	
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
<body  >
<form action="" name="frm" method="POST">
 	<input type="hidden" name="opcode" value = "g248" >
	<input type="hidden" name="opname" value = "�ֹ���ֵ����ֵ" >
	<%@ include file="/npage/include/header.jsp" %>

<div id="Operation_Table0"> 
<div class="title">
	<div id="title_zi">�ֹ���ֵ����ֵ</div>
</div>	 
	<table cellspacing="0" id="tabList">
	   
		<tr >
			<td class="blue" >��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�� <input type="text" name="kahao"> 
	 &nbsp;&nbsp;&nbsp;
			 ��&nbsp;&nbsp;&nbsp;&nbsp;�� <input type="password" name="kamima"    maxlength="18">
			 &nbsp;&nbsp;&nbsp;
			 ��&nbsp;&nbsp;&nbsp;&nbsp;ֵ <input type="text" name="kamianzhi">
			 &nbsp;&nbsp;&nbsp;
			 �ֻ����� <input type="text" name="phoneNo" maxlength="11">
			 </td>
		</tr>
		 
		 
		<tr>
			<td align=center><input type=button class="b_foot" name="check2" value="��ֵ" id="cz" onclick="docfm()" >
			 
			
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
		if(document.all.kamima.value=="" ||document.all.kahao.value==""||document.all.kamianzhi.value=="")
		{
			rdShowMessageDialog("�������ֵ���š�����ֵ�ͳ�ֵ������!");
			return false;
		}
		else if(document.all.phoneNo.value=="")
		{
			rdShowMessageDialog("�������ֵ���ֻ�����!");
			return false;
		}
		else
		{
			var	prtFlag = rdShowConfirmDialog("�Ƿ�ȷ����ֵ��");
			if (prtFlag==1)
			{
				var actions = "g248_2.jsp?phoneNo="+document.all.phoneNo.value+"&cardNo="+document.all.kahao.value+"&kmm="+document.all.kamima.value+"&kmz="+document.all.kamianzhi.value;
				document.all.frm.action=actions;
				document.all.frm.submit();
			}
			
		}
		
	}
 
</script>
 
 