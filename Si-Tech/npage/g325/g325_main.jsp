<%
  /*
   * ���Ժ�λ����Ϣ��������
   * ����: 20121212
   * ����: zhouby
   */
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  response.setHeader("Pragma","No-Cache"); 
  response.setHeader("Cache-Control","No-Cache");
  response.setDateHeader("Expires", 0);
  request.setCharacterEncoding("GBK");
%>
<html>
<head>
<title>���Ժ�λ����Ϣ��������</title>
<%
	String opCode="g325";
	String opName="���Ժ�λ����Ϣ��������";
	
	String workNo=(String)session.getAttribute("workNo");
	String regionCode=(String)session.getAttribute("regCode");
%>
<script language="javascript">
	
	function controlBtn(flag) {
			$("#submitBtn").attr("disabled", flag);
			$("#closeBtn").attr("disabled", flag);
	}
	
	function doCfm() {
		controlBtn('disabled');
		if (document.getElementById("fileName").value.length == 0) {
				rdShowMessageDialog("��ѡ���ϴ����ļ���", 1);
				controlBtn('');
				return false;
		}
		document.frm.action = "g325_cfm.jsp";
		document.frm.submit();
	}
	
	function closeWindow() {
			if(window.opener == undefined) {
					removeCurrentTab();
			} else {
					window.close();
			}
	}
</script>
</head>
<body>
<form name="frm" method="post" ENCTYPE="multipart/form-data">
 	<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>">
 	<input type="hidden" name="opName" id="opName" value="<%=opName%>">
	
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">ѡ��¼���ļ�</div>
	</div>
	
		<table cellspacing="0">
			<tr>
				<td class="blue" width="20%">�ļ�</td>
				<td width="80%">
					<input type="file" name="fileName" id="fileName" class="button" style='border-style:solid;border-color:#7F9DB9;border-width:1px;font-size:12px;' />
				</td>
			</tr>
			<tr>
				<td class="blue">�ļ�˵��</td>
				<td>&nbsp;
					һ.�������ļ�����Ϊ�ı��ļ�����׺.txt��<br>&nbsp;
						��.��˳��<br>&nbsp;
						1.�ֻ�����2.���ģʽ���ͣ�����Ϊ01��GPRSΪ02������Ϊ[��վ]03������[С��]04��3.��ţ��Զ˺���Ϊdx001��dx005��APN����ڵ�Ϊgprs001����վΪjz001��С��Ϊxq001��4.��Ӧ�ĺ���</br>&nbsp;
						��.ÿ��֮��ʹ�á�~���ָ�<br>&nbsp;
						��.ÿ���Զ˺����APN����ռһ��<br>&nbsp;
						��.ʾ�����£�<br>&nbsp;
						�绰���룺12345678901 ���ģʽ������ ��1���Զ˺���Ϊ 1234567 <br>&nbsp;
						�绰���룺12345678901 ���ģʽ������ ��2���Զ˺���Ϊ 2234567 <br>&nbsp;
						�绰���룺12345678901 ���ģʽ������ ��3���Զ˺���Ϊ 3234567 <br>&nbsp;
						�绰���룺12345678901 ���ģʽ������ ��4���Զ˺���Ϊ 4234567 <br>&nbsp;
						�绰���룺12345678901 ���ģʽ������ ��5���Զ˺���Ϊ 5234567 <br>&nbsp;
						�绰���룺12345678901 ���ģʽ��GPRS APN��������Ϊ 6234567 <br>&nbsp;
						�绰���룺12345678901 ���ģʽ������ ��վ����Ϊ sdf65678 <br>&nbsp;
						�绰���룺12345678901 ���ģʽ������ С������Ϊ sdf61233 <br>&nbsp;
						12345678901~01~dx001~1234567<br>&nbsp;
						12345678901~01~dx002~2234567<br>&nbsp;
						12345678901~01~dx003~3234567<br>&nbsp;
						12345678901~01~dx004~4234567<br>&nbsp;
						12345678901~01~dx005~5234567<br>&nbsp;
						12345678901~02~gprs001~6234567<br>&nbsp;
						12345678901~03~jz001~sdf65678<br>&nbsp;
						12345678901~04~xq001~sdf61233<br>&nbsp;
						��.һ�������������ޣ�50��<br>&nbsp;
				</td>
			</tr>
			<tr>
				<td colspan="3" align="center" id="footer">
					<input class="b_foot" type=button name="submitBtn" id="submitBtn" value="�ϴ�" onClick="doCfm(this)">    
					<input class="b_foot" type=button name="closeBtn" id="closeBtn" value="�ر�" onClick="closeWindow();">
				</td>
			</tr>
		</table>
	<%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>