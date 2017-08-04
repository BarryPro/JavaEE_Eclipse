<%
/********************
 
 -------------------------创建-----------何敬伟(hejwa) 2015-5-28 14:22:50-------------------
 关于申请优化移动智能终端CRM系统的请示@需求讨论稿
 -------------------------后台人员：李阳--------------------------------------------
 
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
<HTML><HEAD><TITLE><%=opName%></TITLE>
<script type="text/javascript" src="/njs/extend/My97DatePicker/WdatePicker.js"></script>
<SCRIPT language=JavaScript>

//重置刷新页面
function reSetThis(){
	  location = location;	
}
 
//删除配置
function delAndroidFile(){
    if(rdShowConfirmDialog('确认删除记录吗？')!=1) return;
    
}
$(document).ready(function(){
});


//添加一行
function add(){
	var addTr_html = "<tr>"+
									 "<td align='center'><input type='text' maxlength='11' v_type='mobphone' onblur='checkElement(this)'></td>"+
									 "<td align='center'><input type='text' maxlength='6'  ></td>"+
									 "<td align='center'><input type='button' class='b_text' onclick='add_cfm(this)' value='保存'><input type='button' class='b_text' onclick='del(this)' value='删除'></td>"+
									 "</tr>";
	$("#upgMainTab tr:eq(0)").after(addTr_html);
}
//添加提交
function add_cfm(bt){
	var phone_no_i = $(bt).parent().prev().prev().find("input").val();
	var login_no_i = $(bt).parent().prev().find("input").val();
	
	if(phone_no_i.trim()==""){
		rdShowMessageDialog("请输入手机号码");
		return;
	}
	
	if(login_no_i.trim()==""){
		rdShowMessageDialog("请输入操作工号");
		return;
	}
	
	var packet = new AJAXPacket("fm271_2.jsp","正在执行,请稍后...");
			packet.data.add("opCode","<%=opCode%>");//opcode
			packet.data.add("phone_no_i",phone_no_i); 
			packet.data.add("login_no_i",login_no_i); 
			packet.data.add("iFlag","1"); /*0查询 1新增 2删除*/
			core.ajax.sendPacket(packet,do_add_cfm);
			packet = null; 
}
function do_add_cfm(packet){
		var code = packet.data.findValueByName("code"); //返回代码
		var msg  = packet.data.findValueByName("msg"); //返回信息
		if(code=="000000"){//成功去查询并刷新列表
			rdShowMessageDialog("添加成功",2);
			reSetThis();
		}else{
			rdShowMessageDialog("添加失败，"+code+"："+msg,0);
		}
}

//删除动态添加的行
function del(bt){
	$(bt).parent().parent().remove();
}


//查询配置
function query(){
	var phone_no_i = $("#phoneNo").val();
	var login_no_i = $("#oprLoginNo").val();
	
	if(phone_no_i.trim()==""&&login_no_i.trim()==""){
		rdShowMessageDialog("至少输入一个查询条件");
		return;
	}
	
		var packet = new AJAXPacket("fm271_2.jsp","正在执行,请稍后...");
			packet.data.add("opCode","<%=opCode%>");//opcode
			packet.data.add("phone_no_i",phone_no_i); 
			packet.data.add("login_no_i",login_no_i); 
			packet.data.add("iFlag","0"); /*0查询 1新增 2删除*/
			core.ajax.sendPacket(packet,do_query);
			packet = null; 
}

function do_query(packet){
	var code = packet.data.findValueByName("code"); //返回代码
	var msg  = packet.data.findValueByName("msg"); //返回信息
	if(code=="000000"){//查询成功后动态展示列表
			var retArray = packet.data.findValueByName("retArray");
			//获取数组成功，动态拼接列表
			var trObjdStr = "";
			//第二次以后查询会有多余行数据，所以删除除了title以外行的数据
			$("#upgMainTab tr:gt(0)").remove();
			
			for(var i=0;i<retArray.length;i++){
						trObjdStr += "<tr>"+
														 "<td align='center'>"+retArray[i][1]+"</td>"+ //手机号
														 "<td align='center'>"+retArray[i][0]+"</td>"+ //操作工号
														 "<td align='center'><input type=\"button\" value=\"删除\" class=\"b_text\" onclick=\"del_cfm('"+retArray[i][1]+"','"+retArray[i][0]+"')\"></td>"+//删除按钮
												 "</tr>";
			}
			//将拼接的行动态添加到table中
			$("#upgMainTab tr:eq(0)").after(trObjdStr);
	}else{
		  rdShowMessageDialog("查询失败，"+code+"："+msg,0);
	}
}


function del_cfm(phone_no_i,login_no_i){
	if(rdShowConfirmDialog('确认删除记录吗？')!=1) return;
	var packet = new AJAXPacket("fm271_2.jsp","正在执行,请稍后...");
			packet.data.add("opCode","<%=opCode%>");//opcode
			packet.data.add("phone_no_i",phone_no_i); 
			packet.data.add("login_no_i",login_no_i); 
			packet.data.add("iFlag","2"); /*0查询 1新增 2删除*/
			core.ajax.sendPacket(packet,do_del_cfm);
			packet = null; 
}
function do_del_cfm(packet){
		var code = packet.data.findValueByName("code"); //返回代码
		var msg  = packet.data.findValueByName("msg"); //返回信息
		if(code=="000000"){//成功去查询并刷新列表
			rdShowMessageDialog("删除成功",2);
			reSetThis();
		}else{
			rdShowMessageDialog("删除失败，"+code+"："+msg,0);
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
	    <td class="blue" width="20%">审核人手机号码</td>
		  <td width="30%">
			    <input type="text" name="phoneNo" id="phoneNo" value="" /> 
		  </td>
		  <td class="blue" width="20%">操作工号</td>
		  <td width="30%">
			    <input type="text" name="oprLoginNo" id="oprLoginNo" value=""   />  
		  </td>
	</tr>
</table>
<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="查询" onclick="query()"           />
	 		<input type="button" class="b_foot" value="添加" onclick="add()"           />
	 	</td>
	</tr>
</table>

<div class="title"><div id="title_zi">审核列表</div></div>
<TABLE cellSpacing="0" id="upgMainTab">
    <tr>
        <th width="35%">审核人手机号码</th>
        <th width="35%">操作工号</th>
        <th >操作</th>	
    </tr>
</table>

<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="重置" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="关闭" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>