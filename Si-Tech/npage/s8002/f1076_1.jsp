<%
  /* *********************
   * ����: ����ҵ�����������Ʋ�������ѯ
   * �汾: 1.0
   * ����: 2010/07/12
   * ����: 
   * ��Ȩ: si-tech
   * *********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<head>
	<title>����ҵ�����������Ʋ���</title>
	<%
		String opCode = "1076";
		String opName = "����ҵ�����������Ʋ�������ѯ";
		String workNo = (String)session.getAttribute("workNo");
		String groupId = (String)session.getAttribute("groupId");
	%>
	<script language="javascript" type="text/javascript">
		$(document).ready(function(){
			var loginNo = "<%=workNo%>";
			var groupId = "<%=groupId%>";
			var inputSearchNo = $("#inputWorkNo").val();
			$("#confirm").click(function(){
				frameDiv.style.display="";
		    	frm.action="f1076_1_getMore.jsp?loginNo=" + loginNo +
		    				"&groupId=" + groupId + "&searchNo=" + $("#inputWorkNo").val() +
		    				"&timePoint=" + $("input[name='timePoint']:checked").val();
		    	frm.target="ifm";
		    	frm.submit();
			});
			$("#back").click(function(){
				var dirtPage = "/npage/s8002/f1076_login.jsp?opCode=<%=opCode%>";
				location = dirtPage;
			});
			$("#close").click(function(){
				removeCurrentTab();
			});
		});
	</script>
</head>
<body>
<form name="frm" method="POST" action="">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">����ҵ�����������Ʋ�������ѯ</div>
	</div>
	<table cellspacing="0">
		<tr>
			<td class="blue">ʱ���</td>
			<td>
				<input type="radio" name="timePoint" value="01" checked="checked" />1Сʱ 
				<input type="radio" name="timePoint" value="24" />24Сʱ
			</td>
			<td class="blue">����</td>
			<td>
				<input type="text" id="inputWorkNo" />
			</td>
		</tr>
		<tr>
			<td id="footer" colspan="4">
				<div align="center">
					<input class="b_foot" type="button" id="confirm" value="��ѯ" />    
					<input class="b_foot" type="button" id="back" value="����" />   
					<input class="b_foot" type="button" id="close" value="�ر�" />
				</div>
			</td>
		</tr>
	</table>
	<div id=frameDiv style="display:none">
		<iframe name="ifm" width="98%" height="380" align="center"
				frameborder="0" cellspacing="0" src="blank.htm">
		</iframe>
	</div>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>