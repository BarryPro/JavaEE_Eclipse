<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����:��G3����������ͨ�ŷ�  8356
   * �汾: 1.0
   * ����: 2009/11/3
   * ����: sunaj
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%
  request.setCharacterEncoding("GBK");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>��G3������</title>
<%
    String opCode=(String)request.getParameter("opCode");
	String opName=(String)request.getParameter("opName");
    String workNoFromSession=(String)session.getAttribute("workNo");			//��������
	String phoneNo=(String)request.getParameter("activePhone");					//�ֻ�����
	boolean workNoFlag=false;
	if(workNoFromSession.substring(0,1).equals("k"))
	  workNoFlag=true;
%>


  </script>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script type="text/javascript" src="/npage/s3000/js/S3000.js"></script>
<script language=javascript>
  onload=function()
  {
		opchange();
  }

//----------------��֤���ύ����-----------------
function doCfm(subButton)
{
  controlButt(subButton);//��ʱ���ư�ť�Ŀ�����

  var radio1 = document.getElementsByName("opFlag");
  for(var i=0;i<radio1.length;i++)
  {
    if(radio1[i].checked)
	{
	  var opFlag = radio1[i].value;
	  if(opFlag=="one")
	  {
	  	
	    	frm.action="f8356_1.jsp";
	    	document.all.opCode.value="8356";
	    	
	  }else if(opFlag=="two")
	  {
	    if(document.all.backaccept.value==""){
	    	rdShowMessageDailog("������ҵ����ˮ��");
	    	return;
	    }
	    	frm.action="f8357_1.jsp";
	    	document.all.opCode.value="8357";
	  }
	}
  }
	    
	
 
  frm.submit();	
  return true;
}
function opchange(){
	 document.all.backaccept_id.style.display = "";
}
</script>
</head>
<body>
	
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">ѡ���������</div>
	</div>
<table cellspacing="0">
	<TR> 
		<TD class="blue">��������</TD>
		<TD>
			
			<input type="radio" name="opFlag" value="two" onclick="opchange()" checked>����
		</TD>
			<input type="hidden" name="opCode" >
	</TR> 
            
	<tr> 
		<td class="blue">�ֻ�����</td>
		<td nowrap> 
			<input class="InputGrey" readOnly type="text" size="12" name="srv_no" id="srv_no" value="<%=phoneNo%>" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1 maxlength="11" index="0">
			<font color="orange">*</font>
		</td>
	</tr>
	<TR style="display:none" id="backaccept_id"> 
		<TD class="blue">ҵ����ˮ</TD>
		<TD>
			<input class="button" type="text" name="backaccept" v_must=1 >
			<font color="orange">*</font>
		</TD>
	</TR> 
            
	<tr> 
		<td colspan="2" align="center" id="footer"> 
			<input class="b_foot" type=button name="confirm" value="ȷ��" onClick="doCfm(this)" index="2">    
			<input class="b_foot" type=button name=back value="���" onClick="frm.reset()">
			<input class="b_foot" type=button name=qryP value="�ر�" onClick="removeCurrentTab();">
		</td>
	</tr>
 </table>
   <%@ include file="/npage/include/footer_simple.jsp" %>
   </form>
</body>
</html>
