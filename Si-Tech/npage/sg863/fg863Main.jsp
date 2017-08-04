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
				rdShowMessageDialog("请选择上传的文件！", 1);
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
		<div id="title_zi">选择录入文件</div>
	</div>
	
		<table cellspacing="0">
			<tr>
				<td class="blue" width="14%">请选择需要填加的特服</td>
				<td class="blue" width="36%">
				  <select name="pcode">
				    <option value="GPRS">增加GPRS</option>
				    <option value="1009">增加短消息</option>
				    <option value="1068">增加可视电话</option>
				    <option value="1053">增加关闭语音</option>
				    <option value="LDXS">增加来电显示</option>
				    <option value="1025">增加省内漫游</option>
				    <option value="1026">增加国内漫游</option>
				  </select>
				</td>
				
				<td class="blue" width="14%">文件</td>
				<td width="36%">
					<input type="file" name="fileName" id="fileName" class="button" style='border-style:solid;border-color:#7F9DB9;border-width:1px;font-size:12px;' />
				</td>
			</tr>
			<tr>
				<td class="blue">文件说明</td>
				<td colspan="3">&nbsp;
					一.所导入文件必须为文本文件（后缀.txt或.TXT）<br>&nbsp;
					二.该页面功能仅能处理特服BOSS少的情况，对于国际长途及国际漫游功能不可以批量添加，请地市公司与用户核实后在前台办理。 <br>&nbsp;    
					三.每次只能处理一种特服，文件行数限制在5000行（系统导入处理时间范围在0～3分钟），导入示例如下：<br>&nbsp;
					1、对于批量添加GPRS/短消息/可视电话/关闭语音/来电显示功能，上传的文本格式如下:   <br>&nbsp;                             
					13904510000#     <br>&nbsp;                             
					13904510001#      <br>&nbsp;                            
					2、省内漫游/国内漫游 需要参考省公司每月下发的差异比对文件，如文件内显示：<br>&nbsp;
					漫游 BOSS少 [13904510000 BOSS:2 HLR:3]<br>&nbsp;
					漫游 BOSS少 [13904510001 BOSS:* HLR:3]  <br>&nbsp;                  
					选择本页“填加国内漫游”（如HLR:2，就选择“填加省内漫游”），上传的文本中要附加BOSS的代码，格式如下: <br>&nbsp;
					13904510000,2#   <br>&nbsp;                       
					12345678901,*#<br>&nbsp;
					3、地市公司处理完成后，需要抽样验证特服添加情况，出现问题及时向省公司反馈。<br>&nbsp;           
				</td>
			</tr>
			<tr>
				<td align="center" colspan="4" id="footer">
				  <input class="b_foot" type=button name="submitBtn" id="submitBtn" value="上传" onClick="doCfm(this)">    
				  <input class="b_foot" type=button name="closeBtn" id="closeBtn" value="关闭" onClick="closeWindow();">
				</td>
			</tr>
		</table>
	<%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>                                        