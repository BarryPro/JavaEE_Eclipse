<%
  /*
   * 功能: WLan网络覆盖批量导入
   * 版本: 1.0
   * 日期: 20110715
   * 作者: wanghfa
   * 版权: si-tech
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
<title>WLan网络覆盖批量导入</title>
<%
	String opCode="e066";
	String opName="WLan网络覆盖批量导入";
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
			rdShowMessageDialog("请选择上传的文件！", 1);
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
		<div id="title_zi">选择录入文件</div>
	</div>
<table cellspacing="0">
	<tr>
		<td class="blue" width="20%">文件</td>
		<td width="80%">
			<input type="file" name="fileName" id="fileName" class="button" style='border-style:solid;border-color:#7F9DB9;border-width:1px;font-size:12px;' />
		</td>
	</tr>
	<tr>
		<td class="blue">文件说明</td>
		<td>一.所导入文件必须为文本文件(后缀.txt)</br>
&nbsp;二.列顺序：1.地市名称2.热点覆盖区域3.热点名称4.热点接入设计传输宽带5.热点实际接入传输带宽(M)6.热点传输接入设计类型（微波、光缆）7.热点实际传输接入类型8.热点传输带宽是否具备快速扩容能力9.最大满足传输带宽限制值（最大不得大于AP数乘以10M）10.热点核查是否通过11.热点地址12.覆盖区域13.覆盖区域(独立建筑物)14.city_code15.ADDRESS（地址描述）16.地址简称17.SSID（网络名称）</br>
&nbsp;三.每列之间使用“|”分隔</br>
&nbsp;四.示例如下：</br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;大庆|师范学院图书馆|师范学院图书馆|80M(按每个AP 4M 带宽设计)|50|光缆|光缆|是|200M|否|黑龙江省大庆市让胡路区西宾西路|图书馆109到109AP04|师范学院图书馆|459|109后门门口棚上AP04|师范学院图书馆|CMCC
		</td>
	</tr>
	<tr>
		<td colspan="3" align="center" id="footer">
			<input class="b_foot" type=button name="submitBtn" id="submitBtn" value="上传" onClick="doCfm(this)">    
			<input class="b_foot" type=button name="closeBtn" id="closeBtn" value="关闭" onClick="closeWindow();">
		</td>
	</tr>
</table>
<%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>
