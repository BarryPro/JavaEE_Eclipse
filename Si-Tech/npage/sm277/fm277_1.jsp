<%
/********************
 
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa) 2015-7-10 14:13:47-------------------
 物联网业务开通优化需求
 我要新增一个界面 2级TAB，进来先做个查询，把信息展示，点确认，调用服务。
 -------------------------后台人员：李艳--------------------------------------------
 update 2017-01-20 关于物联卡功能优化的需求 增加批量导入功能 liangyl
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%
	String opCode    = WtcUtil.repNull(request.getParameter("opCode"));
	String opName    = WtcUtil.repNull(request.getParameter("opName")); 
	String workNo    = (String)session.getAttribute("workNo");
	String password  = (String)session.getAttribute("password");
	String workName  = (String)session.getAttribute("workName");
	String orgCode   = (String)session.getAttribute("orgCode");
	String ipAddrss  = (String)session.getAttribute("ipAddr");
	String currentDate = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
%> 
<%@ page contentType="text/html;charset=GBK"%>
<head><title><%=opName%></title>
<script type="text/javascript" src="/njs/extend/My97DatePicker/WdatePicker.js"></script>
<script language=JavaScript>

$(function(){
	batchBut();
})
//重置刷新页面
function reSetThis(){
	  location = location;	
}

//查询动态展示IMEI号码列表
function go_query(){
	
	var packet = new AJAXPacket("fm277_2.jsp","正在执行,请稍后...");
			packet.data.add("opCode","<%=opCode%>");//opcode
			packet.data.add("phoneNo",$("#phoneIn").val());// 
			core.ajax.sendPacket(packet,do_query);
			packet = null; 
}
//查询动态展示IMEI号码列表，回调
function do_query(packet){
	var code = packet.data.findValueByName("code"); //返回代码
	var msg = packet.data.findValueByName("msg"); //返回信息
	
	if(code=="000000"){//查询成功后动态展示列表
			var retArray = packet.data.findValueByName("retArray");
			//获取数组成功，动态拼接列表
			var trObjdStr = "";
			//第二次以后查询会有多余行数据，所以删除除了title以外行的数据
			$("#upgMainTab tr:gt(0)").remove();
			
			for(var i=0;i<retArray.length;i++){
				 var td_4 = "";
				 if(retArray[i][4]=="01"){//01开通，显示暂停按钮
				 	td_4 = "<input type='button' class='b_text' value='暂停' onclick='go_offer_upg(\""+retArray[i][5]+"\",\"m277\")' >";
				 }else if(retArray[i][4]=="04"){//04暂停，显示恢复按钮
				 	td_4 = "<input type='button' class='b_text' value='恢复' onclick='go_offer_upg(\""+retArray[i][5]+"\",\"m278\")' >";
				 }
														 
						trObjdStr += "<tr>"+
														 "<td>"+retArray[i][0]+"</td>"+ //
														 "<td>"+retArray[i][1]+"</td>"+ //
														 "<td>"+retArray[i][2]+"</td>"+ //
														 "<td>"+retArray[i][3]+"</td>"+//
														 "<td>"+td_4+"</td>"+//
												 "</tr>";
			}
			//将拼接的行动态添加到table中
			$("#upgMainTab tr:eq(0)").after(trObjdStr);
	}else{
		  rdShowMessageDialog("查询失败，"+code+"："+msg,0);
	}
}

//暂停
function go_offer_upg(param,opcode){
		var packet = new AJAXPacket("fm277_3.jsp","正在执行,请稍后...");
				packet.data.add("opCode",opcode);//opcode
				packet.data.add("param",param);// 
				packet.data.add("phoneNo",$("#phoneIn").val());// 
				core.ajax.sendPacket(packet,do_offer_upg);
				packet = null; 
}

function do_offer_upg(packet){
	var code = packet.data.findValueByName("code"); //返回代码
	var msg  = packet.data.findValueByName("msg"); //返回信息
	if(code=="000000"){
		 rdShowMessageDialog("操作成功",2);
		 reSetThis();
	}else{
		 rdShowMessageDialog("操作失败，"+code+"："+msg,0);
	}
}

function batchBut(){
	var opType = $("input[type='radio'][name='opType']:checked").val();
	if(opType=="1"){
		$("#phoneInTr").show();
		$("div[id='title_zi']").eq(1).show();
		$("#upgMainTab").show();
		$("#footerTr").show();
		
		$("#batchFileTr").hide();
		$("#operTr").hide();
		$("#promptTr").hide();
		$("#footer2Tr").hide();
	}
	else if(optype="2"){
		$("#phoneInTr").hide();
		$("div[id='title_zi']").eq(1).hide();
		$("#upgMainTab").hide();
		$("#footerTr").hide();
		
		$("#batchFileTr").show();
		$("#operTr").show();
		$("#promptTr").show();
		$("#footer2Tr").show();
	}
}

function doCfm(){
	if($("#batchFile").val().length<1){
		rdShowMessageDialog("请上传文件!");
		$("#batchFile")[0].focus();
		return false;
	}
	//var fileVal = getFileName($("#feefile").val());
	var fileVal = getFileExt($("#batchFile").val());
	if("txt" == fileVal){
		//扩展名是txt
	}else{
		rdShowMessageDialog("上传文件的扩展名不正确,只能是后缀为txt类型文件！",0);
		return false;
	}
	$("#importBut").attr("disabled",true);
	$("#msgFORM").attr("action","fm277Cfm.jsp");
	$("#msgFORM").submit();
}

function getFileExt(obj)
{
    var pos = obj.lastIndexOf(".");
    return obj.substring(pos+1);
}

</script>
</head>	
<body>
<form id="msgFORM" name="msgFORM" action="" method="post" enctype="multipart/form-data"> 
<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi">查询条件</div></div>
<table cellspacing="0">
	<tr>
		<td class="blue" width="50%" colspan="2">页面操作</td>
	    <td class="blue" colspan="2">
			<input type="radio" name="opType" value="1" checked="checked" onclick="batchBut()"/>单个号码
			<input type="radio" name="opType" value="2" onclick="batchBut()"/>批量导入
	    </td>
	</tr>
	<tr id="operTr" style="display: none">
	    <td class="blue" width="30%">操作类型</td>
		<td>
			<select id="operType" name="operType">
				<option value="m277">暂停</option>
				<option value="m278">恢复</option>
			</select>
		</td>
		<td class="blue" width="30%">业务类别</td>
		<td>
		   <select id="busiType" name="busiType">
				<option value="I00010100035">GPRS基础服务产品</option>
				<option value="I00010100085">数据通信服务</option>
			</select>
		</td>
	</tr>
	<tr id="phoneInTr">
	    <td class="blue" width="30%" colspan="2">手机号码</td>
		<td colspan="2">
		   <input type="text" name="phoneIn" id="phoneIn" value="<%=activePhone%>" readonly="readonly" class="InputGrey" /> 
		</td>
	</tr>
	<tr id="batchFileTr" style="display: none;">
	  	<td class="blue" width="30%" colspan="2"><font id="leadLable">批量文件</font></td>
		<td colspan="2">
	    	<input type="file" id="batchFile" name="batchFile"/> 
	  	</td>
	</tr>
	<tr id="promptTr" style="display: none;">
		<td align="left" colspan="4">
		<font id="prompt" color="red">
		请上传txt文件,文件中每个号码占一行,一次最多导入500个手机号码,格式如: <br/>
		1064804510001|<br/>
		14704510001|
		</font></td>
	</tr>
</table>

<div class="title"><div id="title_zi">资费列表</div></div>
<table cellspacing="0" id="upgMainTab">
    <tr>
        <th width="15%">资费编码</th>
        <th width="20%">资费名称</th>
        <th width="25%">开始时间</th>
        <th width="25%">结束时间</th>	
        <th >操作</th>
    </tr>
</table>
<table cellspacing="0">
	 <tr id="footerTr">
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="查询" onclick="go_query()"/>
	 		<input type="button" class="b_foot" value="重置" onclick="reSetThis()"/> 
			<input type="button" class="b_foot" value="关闭" onclick="removeCurrentTab()"/> 
	 	</td>
	</tr>
	<tr id="footer2Tr" style="display: none">
		<td id="footer">
		 	<input type="button" id="importBut" class="b_foot" value="批量提交" onclick="doCfm()"/> 
		 	<input type="button" class="b_foot" value="重置" onclick="reSetThis()"/> 
			<input type="button" class="b_foot" value="关闭" onclick="removeCurrentTab()"/> 
	 	</td>
 	</tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>