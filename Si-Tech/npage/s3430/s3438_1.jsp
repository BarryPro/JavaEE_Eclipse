<%
/*********************
 * update by qidp @ 2009-09-10 for �����°��Ʒ����
 *********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/public/checkPhone.jsp" %>
<%
    String workno = WtcUtil.repNull((String)session.getAttribute("workNo"));
    String workname = WtcUtil.repNull((String)session.getAttribute("workName"));
	String belongName = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	
	String opCode = "3438";
	String opName = "APN��Ϣ��ѯ";
%>

<html xmlns="http://www.w3.org/1999/xhtml">
    <HEAD><TITLE>������BOSS-APN��Ϣ��ѯ</TITLE>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
<script language="JavaScript"  src="/npage/s1300/common_1300.js"></script>

<script language="JavaScript">
function docheck() {
	with(document.forms[0]){
		if (!forMobil(document.all.phone_no))
			return false;
	}

 	document.form.action="s3438_2.jsp";
	form.submit();
}
</script>
</HEAD>
<BODY>
<FORM action="s3438_2.jsp" method=post name="form">
<INPUT TYPE="hidden" name="busyType" value="1">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">APN��Ϣ��ѯ</div>
</div>
              <table cellspacing=0>
                <tr>
                  <td class='blue' nowrap>��������</td>
            	<td>
              		APN��Ϣ��ѯ
				</td>
                  <td class='blue' nowrap>����</td>
                  <td><%=belongName%></td>
                </tr>

                <tr>
                  <td class='blue' nowrap>�������</td>
                  <td colspan=3>
                    <input type="text" name="phone_no" value="" maxlength="11">
                    <font class='orange'>*</font>
				  </td>
                </tr>
              </table>

              <table cellspacing=0>
                <tr id="footer">
                  <td>
                    <input class="b_foot" name=sure type="button" value="ȷ��" onclick="docheck()">
                    <input class="b_foot" name=reset type=reset value="�ر�" onclick="removeCurrentTab()">
                  </td>
                </tr>
              </table>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
 </BODY>
 </HTML>