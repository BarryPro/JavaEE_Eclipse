<%
   /*
   * ����: ���Ų�Ʒ��۵���
�� * �汾: v1.0
�� * ����: 2006/10/30
�� * ����: shibo
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>

<%
    //==============================��ȡӪҵԱ��Ϣ
    String workno = WtcUtil.repNull((String)session.getAttribute("workNo"));
    String workname = WtcUtil.repNull((String)session.getAttribute("workName"));
	String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String nopass = WtcUtil.repNull((String)session.getAttribute("password"));
    
    String opCode = "3518";
    String opName = "���Ų�Ʒ��۵���";
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<title>���Ų�Ʒ��۵���</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>
<BODY>
<FORM method="post" name="form1" >
<input type="hidden" name="id_no"  value="">
<input type="hidden" name="unit_id" value="">
<input type="hidden" name="cust_id" value="">
<input type="hidden" name="unit_name" value="">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">���Ų�Ʒ��۵���</div>
</div>
<table cellspacing=0>
    <tr> 
        <td width="18%" class="blue">֤������</td>
        <td colspan="3">
            <input type="text" name="id_iccid" maxlength="18" value="">
            <font class='orange'>*</font>
        </td>
    </tr>
    <tr id="footer"> 
        <td colspan="4" height="30">
            <input name="confirm" type="button" class="b_foot" value="��ѯ" onClick="doQuery()">
            <input name="reset" type="reset" class="b_foot" value="���" >
            <input name="back" onClick="removeCurrentTab()" type="button" class="b_foot" value="�ر�">
        </td>
    </tr>
</table>
<%@ include file="/npage/include/footer_simple.jsp" %>
</FORM> 
<SCRIPT LANGUAGE="JavaScript">

function doQuery()
{
	if(document.form1.id_iccid.value=="")
	{
		rdShowMessageDialog("֤�����벻��Ϊ��!",0);
		return;	
	}
	var path = "<%=request.getContextPath()%>/npage/s3518/f3518_query.jsp?id_iccid="+document.form1.id_iccid.value;
    window.open(path,'_blank','height=600,width=800,scrollbars=yes');
}

function doSubmit()
{
	document.form1.action="<%=request.getContextPath()%>/npage/s3518/f3518_main.jsp";	
	document.form1.submit();
}

</SCRIPT>
</body>
</html>