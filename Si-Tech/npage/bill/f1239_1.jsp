<%
/********************
 version v2.0
开发商: si-tech
update:yanpx@2008-9-16
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
	String opCode = "1239";//模块代码
  String opName = "亲情号码变更";//模块名称
%>

<html xmlns="http://www.w3.org/1999/xhtml">
 <head>
	<title><%=opName%></title>
	<%@ include file="/npage/include/public_title_name.jsp" %>
 </head>

<SCRIPT type=text/javascript>
onload = function(){
  document.all.mphone_no.focus();
}
//----------------验证及提交函数-----------------
var subButt2;
function controlButt(subButton){
	subButt2 = subButton;
	subButt2.disabled = true;
	setTimeout("subButt2.disabled = false",3000);
}
function query(subButton)
{
  	controlButt(subButton);//延时控制按钮的可用性
	if($("input[@name='opFlag'][@checked]").val() == "查询"){
		return false;
	}else if(check(frm1239))
	{
		frm1239.action="f1239_query.jsp";
		frm1239.submit();	
	}
}
function opChange(){
	var opValue = $("input[@name='opFlag'][@checked]").val();
	if(opValue == "查询"){
		getQueryDate();
	}else{
		$("#queryMsg").hide("fast");
		$("#btnSpan").show();
	}
}
function getQueryDate(){
	var getdataPacket = new AJAXPacket("f1239_getDate.jsp","正在获得数据，请稍候......");
	getdataPacket.data.add("phoneNo","<%=activePhone%>");
	core.ajax.sendPacket(getdataPacket,setQueryDate);
	getdataPacket = null;
}
function setQueryDate(packet){
	var retCode = "";
	var retMsg = "";
	//从f1239_getDate.jsp 获取数据
	retCode = packet.data.findValueByName("retcode");
	retMsg = packet.data.findValueByName("retmsg");
	if("000000" == retCode){
		var offerMsg = packet.data.findValueByName("offerMsg");
		var arrMsg 		= packet.data.findValueByName("arrMsg");
		var hisArrMsg 	= packet.data.findValueByName("hisArrMsg");
		var timeArrMsg = packet.data.findValueByName("timeArrMsg");
		var rowStr = "";
		
		rowStr = "<tr><th>销售品名称</th><th>现绑定电话数</th><th>最大绑定电话数</th><th>手续费</th></tr>";
		for(var i = 0; i < offerMsg.length; i++){
			rowStr += "<tr>";
			for(var j = 0; j < offerMsg[i].length; j++){
				rowStr += "<td>" + offerMsg[i][j] + "</td>";
			}
			rowStr += "</tr>";
		}
		$("#offerDetail").empty();
		$("#offerDetail").append(rowStr);
		
		rowStr = "<tr><th>绑定电话号码</th><th>生效时间</th><th>失效时间</th><th>操作工号</th><th>操作时间</th><th>销售品名称</th></tr>";
		for(var i = 0; i < arrMsg.length; i++){
			rowStr += "<tr>";
			for(var j = 0; j < arrMsg[i].length+2; j++){
				//alert(j);
				if(j==1)
				{
					rowStr += "<td>" + timeArrMsg[i][0] + "</td>";
					//alert(timeArrMsg[i][0]+"---生效时间");
				}
				if(j==2)
				{
					rowStr += "<td>" + timeArrMsg[i][1] + "</td>";
					//alert(timeArrMsg[i][1]+"---失效时间");
				}
				else if(j!=1 && j!=2 && j<2 ){
				rowStr += "<td>" + arrMsg[i][j] + "</td>";
				//alert(arrMsg[i][j]+"---正常");
				}
				else if (j>2)
					{
						rowStr += "<td>" + arrMsg[i][j-2] + "</td>";
					}
			}
			rowStr += "</tr>";
		}
		$("#nowDetail").empty();
		$("#nowDetail").append(rowStr);
		
		rowStr = "<tr><th>绑定电话号码</th><th>操作工号</th><th>操作时间</th><th>历史状态</th><th>销售品名称</th></tr>";
		for(var i = 0; i < hisArrMsg.length; i++){
			rowStr += "<tr>";
			for(var j = 0; j < hisArrMsg[i].length; j++){
				rowStr += "<td>" + hisArrMsg[i][j] + "</td>";
			}
			rowStr += "</tr>";
		}
		//$("#hisDetail tr:gt(0)").empty();
		$("#hisDetail").empty();
		$("#hisDetail").append(rowStr);
		
		//赋值结束，修改样式
		$("#queryMsg").show("fast");
		$("#btnSpan").hide();
	}else{
		rdShowMessageDialog("查询用户亲情畅聊套餐失败！"+ retMsg + "[" + retCode + "]");
		frm1239.reset();
	}
}
$(document).ready(function(){
	$("#queryMsg").hide();
});
</SCRIPT>

<body onMouseDown="hideEvent()" onKeyDown="hideEvent()">
<form method="post" name="frm1239"  onKeyUp="chgFocus(frm1239)">
	<%@ include file="/npage/include/header.jsp" %>
	    <div class="title">
			<div id="title_zi">亲情号码变更</div>
		</div>
		<table cellspacing="0">
			<tr> 
				<td class="blue"> 操作类型 </td>
				<td>
					<input type="radio" name="opFlag" value="新增" checked class="radio" onclick="opChange()"/> 新增
					<input type="radio" name="opFlag" value="修改" class="radio" onclick="opChange()"/> 修改
					<input type="radio" name="opFlag" value="删除" class="radio" onclick="opChange()"/>删除
					<input type="radio" name="opFlag" value="查询" class="radio" onclick="opChange()"/> 查询
				</td>
			</tr>	
			<tr> 		 
				<td class="blue"> 亲情主卡 </td>
				<td> 
					<input name="mphone_no" id="mphone_no" v_type="mobphone" v_must=1 v_minlength=11 v_maxlength=11  v_name="手机号码"  maxlength=11  value="<%=activePhone%>" readonly Class="InputGrey"/>   
				</td>
			</tr>
		</table>
		<div id="queryMsg" style="display:none;">
			<div class="title">
				<div id="title_zi">亲情号码查询</div>
			</div>
			<table cellspacing="0" id="offerDetail">
			</table>
			<div class="title">
				<div id="title_zi">当前亲情号码明细</div>
			</div>
			<table cellspacing="0" id="nowDetail">
			</table>
			<div class="title">
				<div id="title_zi">最近6个月办理记录</div>
			</div>
			<table cellspacing="0" id="hisDetail">
			</table>
		</div>
		<table cellspacing="0" id="btnSpan">
			<tr> 
				<td align="center" id="footer">
				<input class="b_foot" name="queryAll" type="button" value="确认" onclick="query(this)"/>
				<input class="b_foot" name="reset1"   type="button" onClick="frm1239.reset();" value="清除"/>
				<input class="b_foot" name="back"   onclick="parent.removeTab(<%=opCode%>);" type="button" value="关闭"/>
				</td>
			</tr>
		</table>

<%@ include file="../../npage/common/pwd_comm.jsp" %>
<%@ include file="/npage/include/footer_simple.jsp" %> 
</form>
</body>
</html>
