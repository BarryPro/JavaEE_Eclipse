<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
/*
 *������������ѯ 
 *
 *��Ȩ��si-tech
 *
 *update:fengcj 2014-11-5
 *
 *content:
 */
%>

<%
	String opCode = "m291";
	String opName = "��������ѯ";
	String workNo = (String) session.getAttribute("workNo");
	String nopass = (String) session.getAttribute("password");
	String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = orgCode.substring(0,2);
	
%>
<HTML>
	<HEAD>
		<TITLE><%=opName%></TITLE>
		<META content=no-cache http-equiv=Pragma>
		<META content=no-cache http-equiv=Cache-Control>
		<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
	</HEAD>
	<script language="javascript">

		
		function comm()
		{
		
		   if($.trim($("#phone_no").val()) == "")
		   {
		   	rdShowMessageDialog("������벻��Ϊ�գ�");
			  return false;
		   }
		   alert(111111);
		   document.fr192.action = "fr192_2.jsp?phone_no="+$("#phone_no").val();
		   document.forms[0].submit();
		
		}
		
		

		</script>
	<body >
		<form method=post name="fr192" action="" >
			<input type=hidden id=workNo name=workNo value=<%=workNo%>>
			
			<%@ include file="/npage/include/header.jsp"%>
			<div class="title"><div id="title_zi"><%=opName%></div></div>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
          	<td width="40%" class="Blue">�ֻ�����</td>
          	<td width="60%">
							<input type="text" value="" name="phone_no"  id="phone_no" v_must=0 v_minlength=1 v_maxlength=40 v_type="string" onblur="checkElement(this)">
         	 	</td>
          
        </tr>   
        <TR>
        	<TD align="middle"  colspan="2" id="footer">
						<input  name="selectbutton" index="3" type="button"
								class="b_foot" value="��ѯ" onclick="comm();">
							&nbsp;&nbsp;	
						<input class="b_foot" name="back" type="button"
								value="���" onclick="window.location='fr192_1.jsp'">

					</TD>
				</TR>
		</table>
		</form>
		<%@ include file="/npage/include/footer.jsp" %> 
	</BODY>
</HTML>
