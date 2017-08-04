<%
/********************
 
 -------------------------创建-----------何敬伟(hejwa) 2015/3/19 9:10-------------------
 中测功能
 -------------------------后台人员：liyang--------------------------------------------
 
 
********************/
%>
              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
<script type="text/javascript" src="/njs/extend/My97DatePicker/WdatePicker.js"></script>

<%
	String opCode    = WtcUtil.repNull(request.getParameter("opCode"));
	String opName    = WtcUtil.repNull(request.getParameter("opName"));
	  
	String workNo    = (String)session.getAttribute("workNo");
	String password  = (String)session.getAttribute("password");
	String workName  = (String)session.getAttribute("workName");
	String orgCode   = (String)session.getAttribute("orgCode");
	String ipAddrss  = (String)session.getAttribute("ipAddr");
	String regionCode = (String)session.getAttribute("regCode");
	
	String phoneNo = request.getParameter("activePhone");
  
%> 
		<wtc:service name="sUserInfoQry" outnum="30" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="0" />
			<wtc:param value="01" />
			<wtc:param value="<%=opCode%>" />
			<wtc:param value="<%=workNo%>" />
			<wtc:param value="<%=password%>" />
			<wtc:param value="<%=phoneNo%>" />
			<wtc:param value="" />						
		</wtc:service>
		<wtc:array id="serverResult" scope="end"  />
<%
	if(!"000000".equals(code)){
	%>
	<script>
		rdShowMessageDialog("查询用户信息失败：<%=code%>,<%=msg%>");
		parent.removeTab("<%=opCode%>");
	</script>
	<%
	}
%>

<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<script type="text/javascript" src="/njs/extend/My97DatePicker/WdatePicker.js"></script>
<SCRIPT language=JavaScript>

$(document).ready(function(){
	query();
});

//重置刷新页面
function reSetThis(){
	  location = location;	
}
 
//查询集团信息查询
function query(){
	var packet = new AJAXPacket("fm247_2.jsp","正在执行,请稍后...");
			packet.data.add("opCode","<%=opCode%>");//opcode
			packet.data.add("phoneNo",$("#phoneNo").val().trim());
			core.ajax.sendPacket(packet,doQuery);
			packet = null; 
}
//查询集团信息查询，回调
function doQuery(packet){
	var code = packet.data.findValueByName("code"); //返回代码
	var msg = packet.data.findValueByName("msg"); //返回信息
	if(code=="000000"){//查询成功后动态展示列表
			var retArray = packet.data.findValueByName("retArray");
			//获取数组成功，动态拼接列表
			var trObjdStr = "";
			//第二次以后查询会有多余行数据，所以删除除了title以外行的数据
			$("#mainTab tr:gt(0)").remove();
			
			for(var i=0;i<retArray.length;i++){
			
			 var td0 = "<select value='"+retArray[i][7]+"' disabled='disabled' ><option>"+retArray[i][7]+"</option></select>";
			 var td1 = "<select value='"+retArray[i][8]+"' disabled='disabled' ><option>"+retArray[i][8]+"</option></select>";
			 
			 var op_sel_1 = "";
			 var op_sel_2 = "";
			 var op_sel_3 = "";
			 var op_sel_4 = "";
			 var op_sel_5 = "";
			 var op_sel_6 = "";
			 var op_sel_7 = "";
			 var op_sel_8 = "";
			 var op_sel_9 = "";
			 
			 if(retArray[i][10]==1){
			 	op_sel_1 = "selected";
			 }
			 if(retArray[i][10]==2){
			 	op_sel_2 = "selected";
			 }
			 if(retArray[i][10]==3){
			 	op_sel_3 = "selected";
			 }
			 if(retArray[i][10]==4){
			 	op_sel_4 = "selected";
			 }
			 if(retArray[i][10]==5){
			 	op_sel_5 = "selected";
			 }
			 if(retArray[i][10]==6){
			 	op_sel_6 = "selected";
			 }
			 if(retArray[i][10]==7){
			 	op_sel_7 = "selected";
			 }
			 if(retArray[i][10]==8){
			 	op_sel_8 = "selected";
			 }
			 if(retArray[i][10]==9){
			 	op_sel_9 = "selected";
			 }
			 
			 var td3 = "<select disabled='disabled' >"+
			 		"<option value='1' "+op_sel_1+">1</option>"+
			 		"<option value='2' "+op_sel_2+">2</option>"+
			 		"<option value='3' "+op_sel_3+">3</option>"+
			 		"<option value='4' "+op_sel_4+">4</option>"+
			 		"<option value='5' "+op_sel_5+">5</option>"+
			 		"<option value='6' "+op_sel_6+">6</option>"+
			 		"<option value='7' "+op_sel_7+">7</option>"+
			 		"<option value='8' "+op_sel_8+">8</option>"+
			 		"<option value='9' "+op_sel_9+">9</option>"+
			 	  "</select>";
			
			 var op_sel_10A = "";
			 var op_sel_10E = "";
			 if("10A"==retArray[i][14]){
			 	op_sel_10A = "selected";
			 }else if("10E"==retArray[i][14]){
			 	op_sel_10E = "selected";
			 }
			 
			 			 	  
			var td4 = "<select disabled='disabled' >"+
			 		"<option value='10A' "+op_sel_10A+">正常</option>"+
			 		"<option value='10E' "+op_sel_10E+">作废</option>"+
			 	  "</select>";			 	  
			 	  
			var td5="<input size='20' disabled='disabled'  value='"+retArray[i][11]+"'>";
			var td6="<input size='20' disabled='disabled'  value='"+retArray[i][12]+"'>";
			
			trObjdStr += "<tr>"+
					 "<td>"+td0+"</td>"+ 
					 "<td>"+td1+"</td>"+ 
					 "<td>"+td3+"</td>"+ 
					 "<td>"+td4+"</td>"+ 
					 "<td>"+td5+"</td>"+ 
					 "<td>"+td6+"</td>"+ 
					 "<td><input type=\"button\" value=\"修改\" class=\"b_text\" onclick=\"update(this)\"> <input type=\"button\" value=\"保存\" class=\"b_text\" onclick=\"upd_save(this)\" style='display:none'></td>"+
					 "<td style='display:none'>"+retArray[i][7]+"</td>"+ 
				 "</tr>";
			}
			//将拼接的行动态添加到table中
			$("#mainTab tr:eq(0)").after(trObjdStr);
			$("#phoneNo").attr("readOnly","readOnly");//成功后手机号不能修改，因为修改记录时候用到
	}else{
		  rdShowMessageDialog("查询失败，"+code+"："+msg,0);
	}
}



//更改积分计划，动态添加一行
function update(bt){
	var trObj         = $(bt).parent().parent();
	
	trObj.find("td:eq(2)").find("select").removeAttr("disabled");
	trObj.find("td:eq(3)").find("select").removeAttr("disabled");
	trObj.find("td:eq(4)").find("input").removeAttr("disabled");
	trObj.find("td:eq(5)").find("input").removeAttr("disabled");
	
	//去除修改按钮，添加保存按钮
	trObj.find("td:eq(6)").find("input:eq(0)").hide();
	trObj.find("td:eq(6)").find("input:eq(1)").show();
	
} 
//修改保存
function upd_save(bt){
	var trObj         = $(bt).parent().parent();
	var iScoreRule    = trObj.find("td:eq(0)").find("select").val();
	var iScoreName    = trObj.find("td:eq(1)").find("select").val();
	var iPriority     = trObj.find("td:eq(2)").find("select").val();
	var iStatus       = trObj.find("td:eq(3)").find("select").val();
	var iScoreRuleOld = trObj.find("td:eq(7)").text();
	var iEffDate      = trObj.find("td:eq(4)").find("input").val();
	var iExpDate      = trObj.find("td:eq(5)").find("input").val();
	
	if(iScoreRule==""){
		rdShowMessageDialog("请输入积分计划编码");
		return;
	}

	var reg1 = /^[a-zA-Z0-9]+$/;
	if(!reg1.test(iScoreRule)){
		rdShowMessageDialog("积分计划编码只能是数字与字母的组合");
		return;
	}
	
		
	if(iScoreName==""){
		rdShowMessageDialog("请输入积分计划名称");
		return;
	}
	
	var reg31 = /^((((1[6-9]|[2-9]\d)\d{2})(0?[13578]|1[02])(0?[1-9]|[12]\d|3[01]))|(((1[6-9]|[2-9]\d)\d{2})(0?[13456789]|1[012])(0?[1-9]|[12]\d|30))|(((1[6-9]|[2-9]\d)\d{2})0?2(0?[1-9]|1\d|2[0-8]))|(((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))0?229)) (([1-2][0-4]:[0-5][0-9]:[0-5][0-9])|0[1-9]:[0-5][0-9]:[0-5][0-9])$/;
	
	if(!reg31.test(iEffDate)){	
		rdShowMessageDialog("开始时间格式为 yyyyMMdd HH:mm:ss");
		return;
	}
	if(!reg31.test(iExpDate)){	
		rdShowMessageDialog("开始时间格式为 yyyyMMdd HH:mm:ss");
		return;
	}
		
	if(iEffDate>iExpDate){
		rdShowMessageDialog("开始时间不能大于结束时间");
		return;
	}
	
	var packet = new AJAXPacket("fm247_3.jsp","正在执行,请稍后...");
			packet.data.add("opCode","<%=opCode%>");//opcode
			packet.data.add("phoneNo",$("#phoneNo").val().trim());//手机号
			packet.data.add("iOpType","U");//修改的类型为U
			packet.data.add("iScoreRule",iScoreRule);//
			packet.data.add("iScoreName",iScoreName);//
			packet.data.add("iPriority",iPriority);//
			packet.data.add("iStatus",iStatus);//
			packet.data.add("iScoreRuleOld",iScoreRuleOld);//
			packet.data.add("iEffDate",iEffDate);//
			packet.data.add("iExpDate",iExpDate);//
			core.ajax.sendPacket(packet,doUpd_save);
			packet = null; 
}
function doUpd_save(packet){
	var code = packet.data.findValueByName("code"); //返回代码
	var msg = packet.data.findValueByName("msg"); //返回信息
	if(code=="000000"){
		rdShowMessageDialog("修改成功",2);
		query();
	}else{
		rdShowMessageDialog("修改失败："+code+msg,0);
	}
}

//新增积分计划，动态添加一行
function add(){

	 var td0 = "<select  >"+
					 		"<option value='JFJS000' >JFJS000</option>"+
					 	  "</select>";
	 var td1 = "<select  >"+
					 		"<option value='基本积分计算' >基本积分计算</option>"+
					 	  "</select>";
	 var td3 = "<select  >"+
	 		"<option value='1' >1</option>"+
	 		"<option value='2' >2</option>"+
	 		"<option value='3' >3</option>"+
	 		"<option value='4' >4</option>"+
	 		"<option value='5' >5</option>"+
	 		"<option value='6' >6</option>"+
	 		"<option value='7' >7</option>"+
	 		"<option value='8' >8</option>"+
	 		"<option value='9' >9</option>"+
	 	  "</select>";
	
	 			 	  
	var td4 = "<select >"+
	 		"<option value='10A' >正常</option>"+
	 		"<option value='10E' >作废</option>"+
	 	  "</select>";	
			 	  
			 	  
	var inHtml_j = "<tr>"+
		       		"<td>"+td0+"</td>"+ 
				"<td>"+td1+"</td>"+ 
				"<td>"+td3+"</td>"+ 
				"<td>"+td4+"</td>"+ 
				"<td>&nbsp;</td>"+ 
				"<td>&nbsp;</td>"+ 
				"<td><input type=\"button\" value=\"保存\" class=\"b_text\" onclick=\"add_save(this)\"></td>"+
		       "</tr>";
	$("#mainTab tr:eq(0)").after(inHtml_j);
} 

//新增保存
function add_save(bt){
	var trObj         = $(bt).parent().parent();
	var iScoreRule    = trObj.find("td:eq(0)").find("select").val();
	var iScoreName    = trObj.find("td:eq(1)").find("select").val();
	var iPriority     = trObj.find("td:eq(2)").find("select").val();
	var iStatus       = trObj.find("td:eq(3)").find("select").val();
	
	if(iScoreRule==""){
		rdShowMessageDialog("请输入积分计划编码");
		return;
	}
	
	var reg1 = /^[a-zA-Z0-9]+$/;
	if(!reg1.test(iScoreRule)){
		rdShowMessageDialog("积分计划编码只能是数字与字母的组合");
		return;
	}
	
	
	if(iScoreName==""){
		rdShowMessageDialog("请输入积分计划名称");
		return;
	}
	
	var packet = new AJAXPacket("fm247_4.jsp","正在执行,请稍后...");
			packet.data.add("opCode","<%=opCode%>");//opcode
			packet.data.add("phoneNo",$("#phoneNo").val().trim());//手机号
			packet.data.add("iOpType","I");//修改的类型为U
			packet.data.add("iScoreRule",iScoreRule);//
			packet.data.add("iScoreName",iScoreName);//
			packet.data.add("iPriority",iPriority);//
			packet.data.add("iStatus",iStatus);//
			packet.data.add("iScoreRuleOld","");//
			core.ajax.sendPacket(packet,doAdd_save);
			packet = null; 
}
function doAdd_save(packet){
	var code = packet.data.findValueByName("code"); //返回代码
	var msg = packet.data.findValueByName("msg"); //返回信息
	if(code=="000000"){
		rdShowMessageDialog("添加成功",2);
		query();
	}else{
		rdShowMessageDialog("添加失败："+code+msg,0);
	}
}
</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action="" method="post"> 
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi">查询条件</div></div>


<table cellSpacing="0">
	<tr>
	    <td class="blue" width="11%">手机号码</td>
		  <td width="22%">
			    <input type="text" name="phoneNo" id="phoneNo" value="<%=phoneNo%>" maxlength="11" class="InputGrey" readonly/> 
		  </td>
	</tr>
</table>



<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="新增" onclick="add()"               /> 
	 		<input type="button" class="b_foot" value="重置" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="关闭" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>

<div class="title"><div id="title_zi">基本信息</div></div>
<TABLE cellSpacing="0" >
    <tr>
    	<td class="blue">用户ID</td>
    	<td><%=serverResult[0][0]%></td>
    	<td class="blue">客户ID</td>
    	<td><%=serverResult[0][1]%></td>
    	<td class="blue">帐户ID</td>
    	<td><%=serverResult[0][2]%></td>
    </tr>
    <tr>
    	<td class="blue">业务品牌名称</td>
    	<td><%=serverResult[0][6]%></td>
    	<td class="blue">入网时间</td>
    	<td colspan="3"><%=serverResult[0][17]%></td>
    </tr>
    <tr>
    	<td class="blue">地市名称</td>
    	<td><%=serverResult[0][20]%></td>
    	<td class="blue">区县名称</td>
    	<td colspan="3"><%=serverResult[0][22]%></td>
    </tr>
</table>

<div class="title"><div id="title_zi">积分计划查询结果</div></div>
<TABLE cellSpacing="0" id="mainTab">
    <tr>
    	<th width="16%">积分计划编码</th>
        <th width="16%">积分计划名称</th>
        <th width="16%">积分计划优先级</th>
        <th width="16%">积分计划状态</th>
        <th width="15%">计划生效时间</th>
        <th width="15%">计划失效时间</th>
        <th>操作</th>
    </tr>
</table>


<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>