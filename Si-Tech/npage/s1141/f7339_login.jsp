<%
/********************
version v2.0
������: si-tech
update:anln@2009-02-23 ҳ�����,�޸���ʽ
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<head>
<title>�ֻ�֤ȯ��ҵ��Ӫ��</title>
<%
   String opCode = (String)request.getParameter("opCode");
   String opName = (String)request.getParameter("opName");
%>
<script type="text/javascript" src="/npage/s3000/js/S3000.js"></script>
<script language=javascript>
onload=function()
{
	document.all.srv_no.focus();
}

//----------------��֤���ύ����-----------------
function doCfm(subButton)
{
	  controlButt(subButton);//��ʱ���ư�ť�Ŀ�����
	  if(!check(frm)) return false; 
	  frm.action="f7339_1.jsp";	
	  if(document.all.saleType.value==""){
	  	rdShowMessageDialog("��ѡ��ҵ�����࣡");
	  	return false;
	  }
	  document.all.opcode.value=document.all.saleType.value.substring(0,4);
	  frm.submit();	
	  return true;
}
</script>
</head>
<body>	
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>  
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<div class="title">
			<div id="title_zi"><%=opName%></div>
	</div>   	
 	<input type="hidden" name="opcode" >
 	<table cellspacing="0">       
		<tr> 
			<td width="16%"  nowrap class="blue">�ֻ����� </td>           
			<td nowrap  >              
				<input   type="text" size="12" name="srv_no" id="srv_no" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1  maxlength="11" index="0" value =<%=activePhone%>  readonly class="InputGrey">
				<font class="orange">*</font>
			</td>           
		</tr>
		<tr> 
			<td width="16%"  nowrap class="blue">ҵ������ </td>		
			<td colspan="3">
				<select name="saleType" >
					<option value=""> ---��ѡ��--- </option>
					<option value="7339->�ֻ�֤ȯ">�ֻ�֤ȯ</option>
					<option value="7361->Ͷ��ͨ">Ͷ��ͨ</option>
					<option value="7362->ͬ��˳">ͬ��˳</option>		
				</select>
			</td>
		</tr>	  
   	</table>
	<table cellspacing="0">  
		<tr> 
		<td id="footer"> 		
			<input  class="b_foot" type=button name="confirm" value="ȷ��" onClick="doCfm(this)" index="2">    
			<input  class="b_foot" type=button name=back value="���" onClick="frm.reset()">
			<input  class="b_foot" type=button name=qryP value="�ر�" onClick="removeCurrentTab();">		
		</td>
	</tr>
	</table>
	 <%@ include file="/npage/include/footer.jsp" %>      
   </form>
</body>
</html>