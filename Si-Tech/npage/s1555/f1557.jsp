<%
/********************
 version v2.0
 ������: si-tech
 ģ�飺ͳһ�콱
 update zhaohaitao at 2008.12.31
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>	
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.common.viewBean.comImpl"%>
<%
  request.setCharacterEncoding("GBK");
%>
<head>
<title>ͳһ�콱</title>
<%
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	String phoneNo = request.getParameter("activePhone");
%>

</script>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language=javascript>
  onload=function()
  {

  }

//----------------��֤���ύ����-----------------
function doCfm(subButton)
{
  controlButt(subButton);//��ʱ���ư�ť�Ŀ�����
  if(!check(frm)) return false;
  if (document.all.award_type.value==""){
  	rdShowMessageDialog("��ѡ��Ʒ���࣡");
  	return false;
  }
  if (document.all.award_type.value=="0001"){
  frm.action="f1557Main.jsp";}
  else if (document.all.award_type.value=="0002"){
  frm.action="fopen_query.jsp";
  }
  else if (document.all.award_type.value=="0003"){
  frm.action="fmark_query.jsp";
  }
  else if (document.all.award_type.value=="0004"){
  frm.action="fgift_query.jsp";
  }
  else if (document.all.award_type.value=="0005"){
  frm.action="fbargain_qry.jsp";
  }
  else if (document.all.award_type.value=="0006"){
  frm.action="f1444.jsp";
  }
  else if (document.all.award_type.value=="0007"){
  frm.action="fopengift.jsp";
  }
  frm.submit();	
  return true;
}
</script>
</head>
<body>
	
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>

<table cellspacing="0">
	<tr> 
		<td class="blue"> 
			<div align="left">�ֻ�����</div>
		</td>
		<td> 
			<div align="left"> 
			<input class="InputGrey" type="text" name="srv_no" id="srv_no" value="<%=phoneNo%>" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1 index="0" readOnly>
		</td>
	</tr>
	<tr>
		<td class="blue">��Ʒ����</td>
		<td colspan="3">
			<select  name="award_type" class="button"  >
			<option value="">--��ѡ��--</option>
				<wtc:qoption name="sPubSelect" outnum="2">
				<wtc:sql>select distinct awardtype_code,awardtype_name from sawardtype order by awardtype_code</wtc:sql>
				</wtc:qoption>
			<font color="orange">*</font>
		</td>
	</tr>
	<tr> 
	<td id="footer" colspan="2"> 
		<div align="center"> 
		<input class="b_foot" type=button name="confirm" value="ȷ��" onClick="doCfm(this)" index="2">    
		<input class="b_foot" type=button name=back value="���" onClick="frm.reset()">
		<input class="b_foot" type=button name=qryP value="�ر�" onClick="removeCurrentTab();">
		</div>
	</td>
	</tr>
</table>
    <%@ include file="/npage/include/footer_simple.jsp" %>   
    <input type="hidden" name="opCode" value="<%=opCode%>">
    <input type="hidden" name="opName" value="<%=opName%>">
   </form>
</body>
</html>
