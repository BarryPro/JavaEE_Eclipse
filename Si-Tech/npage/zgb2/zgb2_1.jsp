<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-15 ҳ�����,�޸���ʽ
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*" %> 
<%@ page import="java.util.*" %>
<%
String opCode = "zgb2";
String opName = "��ֵ˰רƱ��������ȡ��";
String workno = (String)session.getAttribute("workNo");
String contextPath = request.getContextPath();
String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
%> 
<HTML>
<HEAD>
<script language="JavaScript">
 function doclear() {
 		frm.reset();
 }


 function inits()
 {
	 //document.getElementById("query_id").disabled=true;
 }
 function sel1()
 {
	window.location.href='zg12_1.jsp';
 }
 function sel2()
 {
	 window.location.href='zg12_tax.jsp';
 }
 function doQry(phone_no)
 {
	document.frm.action="zgb2_2.jsp";
	document.frm.submit();
 }
 </script> 
 
<title>������BOSS-��ͨ�ɷ�</title>
</head>
<BODY onload="inits()">
<form action="" method="post" name="frm">
		
<%@ include file="/npage/include/header.jsp" %>   
   
 
 
  </table>
  <table cellSpacing="0">
    <tr>
		<td>
			��ǰ����:<%=workno%>
		</td>
	</tr>
	<tr>
		<td>
			ע��:ֻ��ɾ���ù���������Ŀ��߼�¼.
		</td>
	</tr>
	<tr>
		<td>��ʼʱ�� 
			<input type="text"   name="begin_time" value=<%=dateStr%> size="8" maxlength="8">
		</td>
	</tr>
	<tr>
		<td>����ʱ�� 
			<input type="text"   name="end_time" value=<%=dateStr%> size="8" maxlength="8">
		</td>
	</tr>
	<tr> 
      <td id="footer"> 
	 	 
 
	  <input type="button" id="query_id" name="query" class="b_foot" value="��ѯ" onclick="doQry()" >
          &nbsp;
		    <input type="button" name="return1" class="b_foot" value="���" onclick="doclear()" >
          &nbsp;
		      <input type="button" name="return2" class="b_foot" value="�ر�" onClick="removeCurrentTab()" >
	  
      </td>
    </tr>
  </table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %>
</form>
 </BODY>
</HTML>