 <%
	/********************
	 version v2.0
	������: si-tech
	update:zhangshuaia@2009-08-10 ҳ�����,�޸���ʽ
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%@ page language="java" import="java.sql.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="org.apache.log4j.Logger"%>

<html>
	<head> 
	<title>Ӫ�������ͳ�ֵ����ֵ</title>
	<%@ include file="../../npage/s4140/head_4141_1_javascript.htm" %>
<%
  	//String opCode = "4141";		
  	String opCode = "zgag";		
	String opName = "Ӫ�������ͳ�ֵ����ֵ";	//header.jsp��Ҫ�Ĳ���
	//activePhone = request.getParameter("activePhone");
	String ReqPageName=WtcUtil.repNull(request.getParameter("ReqPageName"));
	
	String work_no = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String org_Code = (String)session.getAttribute("orgCode");
    String regionCode = org_Code.substring(0,2);
    String groupId = (String)session.getAttribute("groupId");
	String contextPath = request.getContextPath();
	String phoneNo = (String)request.getParameter("activePhone");
%>
<script language=javascript>

</script>
<!--20091220 end -->


<script type="text/javascript" src="/npage/s3000/js/S3000.js"></script>
<script language=javascript>

function docomm(subButton)
{
	//ȷ��flag �жϲ���
	var phone_no  = document.all.phone_no.value;
	var card_no  =  document.all.card_no.value;
	if(card_no=="")
	{
		rdShowMessageDialog("�������ֵ������!");
		document.all.card_no.focus();
		return false;
	}
	else
	{
		frm.action="zgag_2.jsp?phone_no="+phone_no+"&card_no="+card_no;
		frm.submit();
	}
	
} 
 
function inits()
{
	document.all.card_no.focus();
}
</script>


</head>
<body onload="inits()">
<form name="frm" method="POST" >

	<%@ include file="/npage/include/header.jsp" %>     	
	<div class="title">
		<div id="title_zi">Ӫ�������ͳ�ֵ����ֵ</div>
	</div>
	<table>
	<tr >
			<td width="15%" class="blue" nowrap>�û�����</td>
			<td><input type="text" name="phone_no" id="phone_no" value="<%=phoneNo%>" readonly>&nbsp;&nbsp;</td>
	</tr>
	<tr >
			<td width="15%" class="blue" nowrap>��ֵ������</td>
			<td><input type="text" name="card_no" id="card_no_id" >&nbsp;&nbsp;</td>
	</tr>
 
		 
		</table>
 
		<table  cellspacing="0" >
			<tr>
				<td id="footer">     
					<input type=button name="confirm"class="b_foot"  value="��ѯ" onClick="docomm()">    
					<input type=button name=back value="���" class="b_foot" onmouseup="clearnew()" onClick="clearnew()">
					<input type=button name=qryP value="�ر�" class="b_foot" onClick="removeCurrentTab();">             
				</td>
			</tr>
		</table>
<%@ include file="/npage/include/footer.jsp" %>   
</form>
</body>
</html> 