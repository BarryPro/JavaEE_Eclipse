<% 
  /*
   * 功能: 产品销售代理商配置 
　 * 版本: v1.00
　 * 日期: 2012-7-12 11:10:19
　 * 作者: liujian
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
   *  
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<META http-equiv=Content-Type content="text/html; charset=GBK">
<head>


<%
String opCode = request.getParameter("opCode");
String opName = request.getParameter("opName");
String work_no = (String) session.getAttribute("workNo");
String loginNoPass = (String)session.getAttribute("password");
String org_code = (String) session.getAttribute("orgCode");

%>
<title><%=opName%></title>
<script type="text/javascript" src="/npage/public/pubLightBox.js"></script>	
<script language=javascript>
$(function() {
	$('#opCode').val("<%=opCode%>");
	$('#opName').val("<%=opName%>");
	$('#attrSearch').click(function() {
		document.attrIframe.location='fe931_iframe.jsp?opCode=<%=opCode%>&proType=' + $('#proType').val();
	//	showBox();	
	});
});	
function showBox() {
	showLightBox();
}

function hideBox() {
	hideLightBox();	
}
function cfm() {
	if(rdShowConfirmDialog('确认提交吗？')==1){
		$('#valText').val('');
		$('#checkedText').val('');
		window.frames["attrIframe"].submitRst();
	}
}
function resetPage() {
	location.reload();
}
function submit() {
	var packet = new AJAXPacket("fe931_2.jsp","正在获得相关信息，请稍候......");
	var _data = packet.data;
	_data.add("opCode","<%=opCode%>");
	_data.add("proType",$('#proType').val());
	_data.add("valText",$('#valText').val());
	_data.add("checkedText",$('#checkedText').val());
	core.ajax.sendPacket(packet);
	packet = null;
}
function doProcess(packet) {
	var retCode = packet.data.findValueByName("retcode");
	var retMsg = packet.data.findValueByName("retMsg");
	if(retCode == "000000") {
		rdShowMessageDialog("设置成功！");
		location.reload();
	}else {
		rdShowMessageDialog("错误代码：" + retCode + "，错误信息：" + retMsg,0);	
	}
}
</script>

</head>
<body>
<form name="frm" action="" method="post" >
<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
			<div id="title_zi">查询条件</div>
		</div>
		<input type="hidden" value=""  id="opCode" name="opCode" />
		<input type="hidden" value=""  id="opName" name="opName" />
		<input type="hidden" value=""  id="checkedText" name="checkedText" />
		<input type="hidden" value=""  id="valText" name="valText" />
		
		<div>
			<table cellspacing=0>
			    <tr>
			        <td class='blue'>产品类型</td>
			        <td >
			           <select id="proType">
			           		<option value="0">本地产品</option>	
			           		<option value="1">全网产品</option>	
			           </select> 
			           <input type="button" value="查询" id="attrSearch" class="b_text"/>
			        </td>
			    </tr>
			</table>
		</div>
		<IFRAME frameBorder=0 id="attrIframe" name="attrIframe" style="HEIGHT: 10px; WIDTH: 100%; Z-INDEX: 2">
		</IFRAME>
		<table id="footerTable" style="display:none">
			<tr>
				<td colspan="4" align="center" id="footer">
					<input class="b_foot" type="button" name="submitBtn" id="submitBtn" value="确认" onclick="cfm();" />
					<input class="b_foot" type="button" name="backBtn" id="backBtn" value="重置" onclick="resetPage();" />
					<input class="b_foot" type="button" name="closeBtn" id="closeBtn" value="关闭" onclick="removeCurrentTab();" />
				</td>
			</tr>
		</table>			
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>