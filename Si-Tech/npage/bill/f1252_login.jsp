<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����: ��ܰ��ͥȡ��1252
   * �汾: 1.0
   * ����: 2008/12/24
   * ����: leimd
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<% request.setCharacterEncoding("GBK");%>

<%
	String opCode="1252";
	String opName="��ܰ��ͥȡ��";
	String phoneNo = (String)request.getParameter("activePhone");
	String work_no =(String)session.getAttribute("workNo");    		         //����
	String loginName =(String)session.getAttribute("workName");               //��������
	String[][]  favInfo = (String[][])session.getAttribute("favInfo");		//�Ż�Ȩ����Ϣ
	String regionCode = (String)session.getAttribute("regCode");
	String org_Code =(String)session.getAttribute("orgCode");				//�������루�������룩
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>��ܰ��ͥȡ�� </title>
<%
	boolean workNoFlag=false;
	if(work_no.substring(0,1).equals("k"))
	  workNoFlag=true;
	
    String[] favStr=new String[favInfo.length];
	for(int i=0;i<favStr.length;i++)
	 favStr[i]=favInfo[i][0].trim();
%>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language="javascript">
  onload=function()
  {
	  self.status="";
	  document.all.srv_no.focus();
  }

//----------------��֤���ύ����-----------------
function doCfm(subButton)
{
	controlButt(subButton);					//��ʱ���ư�ť�Ŀ�����
  if(check(frm))
  {
	  frm.action="f1252Main.jsp";
	  frm.submit();	
  }
}
</script>
</head>
<body>
<form name="frm" method="POST">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">ѡ�����</div>
	</div>
	<table cellspacing="0">
		<tr> 
			<td class="blue" width="20%">�ֻ�����(����) </td>
			<td> 
				<input type="text" size="12" name="srv_no" v_must="1" id="srv_no" value=<%=phoneNo%> class="InputGrey" readOnly>
				<font color="orange">*</font>
			</td>
		</tr>
		<tr> 
			<td colspan="2" align="center" id="footer"> 
				<input class="b_foot" type=button name="confirm" value="ȷ��" onClick="doCfm(this)" index="2">    
				<input class="b_foot" type=button name=qryP value="�ر�" onClick="removeCurrentTab()">
			</td>
		</tr>
	</table>
 	<%@ include file="../../npage/common/pwd_comm.jsp" %>
 	<%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>