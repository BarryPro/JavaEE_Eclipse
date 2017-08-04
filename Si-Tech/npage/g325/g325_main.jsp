<%
  /*
   * 测试号位置信息批量导入
   * 日期: 20121212
   * 作者: zhouby
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
<title>测试号位置信息批量导入</title>
<%
	String opCode="g325";
	String opName="测试号位置信息批量导入";
	
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
				rdShowMessageDialog("请选择上传的文件！", 1);
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
				<td>&nbsp;
					一.所导入文件必须为文本文件（后缀.txt）<br>&nbsp;
						二.列顺序：<br>&nbsp;
						1.手机号码2.监控模式类型（短信为01，GPRS为02，语音为[基站]03，语音[小区]04）3.序号（对端号码为dx001到dx005，APN接入节点为gprs001，基站为jz001，小区为xq001）4.对应的号码</br>&nbsp;
						三.每列之间使用“~”分隔<br>&nbsp;
						四.每个对端号码或APN号码占一行<br>&nbsp;
						五.示例如下：<br>&nbsp;
						电话号码：12345678901 监控模式：短信 第1个对端号码为 1234567 <br>&nbsp;
						电话号码：12345678901 监控模式：短信 第2个对端号码为 2234567 <br>&nbsp;
						电话号码：12345678901 监控模式：短信 第3个对端号码为 3234567 <br>&nbsp;
						电话号码：12345678901 监控模式：短信 第4个对端号码为 4234567 <br>&nbsp;
						电话号码：12345678901 监控模式：短信 第5个对端号码为 5234567 <br>&nbsp;
						电话号码：12345678901 监控模式：GPRS APN接入点号码为 6234567 <br>&nbsp;
						电话号码：12345678901 监控模式：语音 基站号码为 sdf65678 <br>&nbsp;
						电话号码：12345678901 监控模式：语音 小区号码为 sdf61233 <br>&nbsp;
						12345678901~01~dx001~1234567<br>&nbsp;
						12345678901~01~dx002~2234567<br>&nbsp;
						12345678901~01~dx003~3234567<br>&nbsp;
						12345678901~01~dx004~4234567<br>&nbsp;
						12345678901~01~dx005~5234567<br>&nbsp;
						12345678901~02~gprs001~6234567<br>&nbsp;
						12345678901~03~jz001~sdf65678<br>&nbsp;
						12345678901~04~xq001~sdf61233<br>&nbsp;
						六.一次批量导入上限：50条<br>&nbsp;
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