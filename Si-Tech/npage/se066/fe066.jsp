<%
  /*
   * ����: WLan���縲����������
   * �汾: 1.0
   * ����: 20110715
   * ����: wanghfa
   * ��Ȩ: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/common/pwd_comm.jsp" %>
<%
  response.setHeader("Pragma","No-Cache"); 
  response.setHeader("Cache-Control","No-Cache");
  response.setDateHeader("Expires", 0); 
  request.setCharacterEncoding("GBK");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>WLan���縲����������</title>
<%
	String opCode="e066";
	String opName="WLan���縲����������";
	String workNo=(String)session.getAttribute("workNo");
	String regionCode=(String)session.getAttribute("regCode");
%>

<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language="javascript">
	onload=function() {
	}
	
	function controlBtn(flag) {
		$("#submitBtn").attr("disabled", flag);
		$("#backBtn").attr("disabled", flag);
		$("#closeBtn").attr("disabled", flag);
	}
	
	function doCfm() {
		controlBtn(true);
		if (document.getElementById("fileName").value.length == 0) {
			rdShowMessageDialog("��ѡ���ϴ����ļ���", 1);
			controlBtn(false);
			return false;
		}
		document.frm.action = "fe066_cfm.jsp";
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
<form name="frm" method="POST" ENCTYPE="multipart/form-data">
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
		<td>һ.�������ļ�����Ϊ�ı��ļ�(��׺.txt)</br>
&nbsp;��.��˳��1.��������2.�ȵ㸲������3.�ȵ�����4.�ȵ������ƴ�����5.�ȵ�ʵ�ʽ��봫�����(M)6.�ȵ㴫�����������ͣ�΢�������£�7.�ȵ�ʵ�ʴ����������8.�ȵ㴫������Ƿ�߱�������������9.������㴫���������ֵ����󲻵ô���AP������10M��10.�ȵ�˲��Ƿ�ͨ��11.�ȵ��ַ12.��������13.��������(����������)14.city_code15.ADDRESS����ַ������16.��ַ���17.SSID���������ƣ�</br>
&nbsp;��.ÿ��֮��ʹ�á�|���ָ�</br>
&nbsp;��.ʾ�����£�</br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;����|ʦ��ѧԺͼ���|ʦ��ѧԺͼ���|80M(��ÿ��AP 4M �������)|50|����|����|��|200M|��|������ʡ�������ú�·��������·|ͼ���109��109AP04|ʦ��ѧԺͼ���|459|109�����ſ�����AP04|ʦ��ѧԺͼ���|CMCC
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
