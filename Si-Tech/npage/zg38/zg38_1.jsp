<%
/********************
 version v2.0
������: si-tech
*
*update:huangqi@2014-07-03 MAS�����ʷѰ����������ѯ
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
	  String opCode = "zg38";
    String opName = "���Ű����˻�����ѯ";
		String orgCode     = (String)session.getAttribute("orgCode");
		String regionCode  = orgCode.substring(0,2);
		String workno      = (String)session.getAttribute("workNo");
		String workname    = (String)session.getAttribute("workName");
		String nopass      = (String)session.getAttribute("password");

		String[] inParam = new String[2];
		inParam[0]="select region_code,region_name from sregioncode order by region_code asc ";
		
%>
<HTML>
<HEAD>
<script language="JavaScript">
 function docheck()
 {
	var unitid = document.getElementById("unitid").value;
	//alert("unitid is "+unitid);	
	if(unitid=="")
	{
		rdShowMessageDialog("�����뼯�ű���!");
		return false;
	}
	else
	{
		document.frm.action="zg38_2.jsp?unitid="+unitid;
		document.frm.submit();
	}
}
	
  function doclear() {
 		frm.reset();
 }

 </script> 
 
<title>������BOSS-��ͨ�ɷ�</title>
</head>
<BODY>
<form action="" method="post" name="frm">
		
		<%@ include file="/npage/include/header.jsp" %>   
  	<div class="title">
			<div id="title_zi">�����뼯�ű���</div>
		</div>
	<table cellspacing="0">
    
	<tr> 
  	<td  class="blue" width="15%">�����뼯�ű��룺</td>
  	<td> 
  		<input type="text" id="unitid" name="unitid" size="20" maxlength="20" style="ime-mode:disabled"    >
  	</td>
 	</tr>
  </table>
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" name="query" class="b_foot" value="��ѯ" onclick="docheck()" >
          &nbsp;
          <input type="button" name="return1" class="b_foot" value="����" onclick="doclear()" >
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