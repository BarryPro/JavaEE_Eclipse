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

<%
  String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	
	String workNo=(String)session.getAttribute("workNo");
	String regionCode=(String)session.getAttribute("regCode");
%>
<title><%=opName%></title>
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
		document.frm.action = "fg863Upload.jsp?pcode=" + $('select').val()+"&filenamelujing="+document.getElementById("fileName").value;
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
				<td class="blue" width="14%">��ѡ����Ҫ��ӵ��ط�</td>
				<td class="blue" width="36%">
				  <select name="pcode">
				    <option value="GPRS">����GPRS</option>
				    <option value="1009">���Ӷ���Ϣ</option>
				    <option value="1068">���ӿ��ӵ绰</option>
				    <option value="1053">���ӹر�����</option>
				    <option value="LDXS">����������ʾ</option>
				    <option value="1025">����ʡ������</option>
				    <option value="1026">���ӹ�������</option>
				  </select>
				</td>
				
				<td class="blue" width="14%">�ļ�</td>
				<td width="36%">
					<input type="file" name="fileName" id="fileName" class="button" style='border-style:solid;border-color:#7F9DB9;border-width:1px;font-size:12px;' />
				</td>
			</tr>
			<tr>
				<td class="blue">�ļ�˵��</td>
				<td colspan="3">&nbsp;
					һ.�������ļ�����Ϊ�ı��ļ�����׺.txt��.TXT��<br>&nbsp;
					��.��ҳ�湦�ܽ��ܴ����ط�BOSS�ٵ���������ڹ��ʳ�;���������ι��ܲ�����������ӣ�����й�˾���û���ʵ����ǰ̨���� <br>&nbsp;    
					��.ÿ��ֻ�ܴ���һ���ط����ļ�����������5000�У�ϵͳ���봦��ʱ�䷶Χ��0��3���ӣ�������ʾ�����£�<br>&nbsp;
					1�������������GPRS/����Ϣ/���ӵ绰/�ر�����/������ʾ���ܣ��ϴ����ı���ʽ����:   <br>&nbsp;                             
					13904510000#     <br>&nbsp;                             
					13904510001#      <br>&nbsp;                            
					2��ʡ������/�������� ��Ҫ�ο�ʡ��˾ÿ���·��Ĳ���ȶ��ļ������ļ�����ʾ��<br>&nbsp;
					���� BOSS�� [13904510000 BOSS:2 HLR:3]<br>&nbsp;
					���� BOSS�� [13904510001 BOSS:* HLR:3]  <br>&nbsp;                  
					ѡ��ҳ����ӹ������Ρ�����HLR:2����ѡ�����ʡ�����Ρ������ϴ����ı���Ҫ����BOSS�Ĵ��룬��ʽ����: <br>&nbsp;
					13904510000,2#   <br>&nbsp;                       
					12345678901,*#<br>&nbsp;
					3�����й�˾������ɺ���Ҫ������֤�ط����������������⼰ʱ��ʡ��˾������<br>&nbsp;           
				</td>
			</tr>
			<tr>
				<td align="center" colspan="4" id="footer">
				  <input class="b_foot" type=button name="submitBtn" id="submitBtn" value="�ϴ�" onClick="doCfm(this)">    
				  <input class="b_foot" type=button name="closeBtn" id="closeBtn" value="�ر�" onClick="closeWindow();">
				</td>
			</tr>
		</table>
	<%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>                                        