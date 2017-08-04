<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<head>
<%
	String opName="新增主题模板";
	String theme_css = request.getParameter("theme_css")!=null?(String)request.getParameter("theme_css"):"";
	String orgCode =  (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String tCode = "";
	String tName = "";
	String tShow = "";
	if(!"".equals(theme_css)){
		String sql = "select theme_css,theme_name,is_effect from dthememsg where theme_css=:theme_css";
		String param = "theme_css="+theme_css;
		%>
		<wtc:service name="TlsPubSelCrm" outnum="4" routerKey="region" routerValue="<%=regionCode %>">
			<wtc:param value="<%=sql%>" />
			<wtc:param value="<%=param%>" />
		</wtc:service>
		<wtc:array id="theme" scope="end"/>
		<%				
		if("000000".equals(retCode)){ 
			tCode  = theme[0][0];  
			tName  = theme[0][1];  
			tShow  = theme[0][2]; 
		}
	}
%>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>主题模板设置</title>
</head>
<body>
<form method="post" name="frm">
	<%@ include file="/npage/include/header_pop.jsp" %>
			<div id="mInput">
				<div class="title">
					<div id="title_zi">添加主题</div>
				</div>
				<div class="input">
					<table cellspacing="0">
						<tr>
							<td class="blue">主题编号</td>
							<td class="blue">
								 
								<select id="tCode">
										<option value='default'>经典蓝</option>
										<option value='orange'>活泼橙</option>
									</select>
							</td>
							<td class="blue">主题名称</td>
							<td class="blue"><input type="text" v_must=1 v_type="string" v_maxlength="32" id="tName" value=""/><font class="orange">*</font></td>
						</tr>
						<tr>
												
							<td class="blue">是否发布</td>
							<td class="blue">
							    <select id="tShow">
										<option value="0">否</option>	
										<option value="1" selected>是</option>
								</select>
							</td>
							<td class="blue">&nbsp;</td>
							<td class="blue">&nbsp;</td>
						</tr>
												
						<tr>
							<td colspan="4" class="blue" style="text-align:center">
								<input class="b_foot" name="add"  id="addbut" style="display:none" type=button value="增加" onclick="doAdd()">
							  	&nbsp; 
							  	<input class="b_foot" name="update" id="update" style="display:none" type=button value="修改" onclick="doUpate()">
							  	&nbsp; 
							  	<input class="b_foot" name="third" type=button value="取消" onclick="javascript:window.close();">
							</td>
						</tr>
					</table>
				</div>
			</div>

	<%@ include file="/npage/include/footer_pop.jsp" %>
</form>
<div id="ts" style=" position:absolute;border:1px green solid; z-index:5; height:20px; font-size:12px; width:180px; display:none;">&nbsp;&nbsp;&nbsp;同时按下ctrl+enter也可提交</div>
<script>
$(document).ready(function(){
	$("#addbut").bind("mousemove", function(){
		$("#ts").show();
		var dd=document.all.ts;
		dd.style.top=event.clientY;
		dd.style.left=event.clientX;
	}) ;
	$("#addbut").bind("mouseout", function(){
		$("#ts").hide();
	}) ;
	$("#update").bind("mousemove", function(){
		$("#ts").show();
		var dd=document.all.ts;
		dd.style.top=event.clientY;
		dd.style.left=event.clientX;
	}) ;
	$("#update").bind("mouseout", function(){
		$("#ts").hide();
	}) ;
});
$(document).keydown(function(event){
	if (event.keyCode == 13 && event.ctrlKey){
		if(<%=theme_css!=""%>){
 			doUpate();
 		}else{
 			doAdd();
 		}
	}
});
</script>
<script type="text/javascript">
$(document).ready(function(){
	$("select").width("150");
	$("input[type='text']").width("150");
});
var ser;
var checktCode = "";
var retVal = "";//返回父页面的值

$(document).ready(function(){
	if(<%=theme_css!=""%>){
		document.getElementById('tCode').value ='<%=tCode%>';
		document.getElementById('tName').value ='<%=tName%>';
		document.getElementById('tShow').value ='<%=tShow%>';
		document.getElementById('update').style.display = "";
		document.all.tCode.disabled=true;
	}else{
		document.getElementById('add').style.display = "";
	}
})

//添加关联模块，将信息返回到前面页面的列表
function doAdd()
{
	var tCode = document.getElementById('tCode').value;
	var tName = document.getElementById('tName').value.trim();
    var tShow = document.getElementById('tShow').value;
	
	if(tName==""){
		rdShowMessageDialog("请填写主题名称");
		document.getElementById('tName').value = "";
		document.getElementById('tName').focus();
		return;
	}
    if(rdShowConfirmDialog("主题编号新增后不能修改，确认要新增吗？")==1)
    {
		//检测该tCode是否已经存在 调用theme_op.jsp?opType=check----
		doCheck();
		if(checktCode=="1"){//不存在返回true，则进行添加
	  		//调用 theme_op.jsp?opType=add,进行添加操作
			var chkPacket = new AJAXPacket("theme_op.jsp","正在执行,请稍后...");
		  	chkPacket.data.add("opType", "add");
		  	chkPacket.data.add("tCode", tCode.trim());
		  	chkPacket.data.add("tName", tName.trim());
		  	chkPacket.data.add("tShow", tShow.trim());
		 	core.ajax.sendPacket(chkPacket,doFunction,true);
		  	chkPacket = null;  
		}else if(checktCode=="0"){
			rdShowMessageDialog("主题已经存在，请重新输入！",0);
			document.getElementById('tCode').value="default";
			document.getElementById('tCode').focus();
			return false;
		}else{
			rdShowMessageDialog("系统错误，请联系系统管理员！",0);
			return false;
		}
	}
}

    
//保存修改后的内容
function doUpate()
{
	/*
	if(!check(frm)){
		return false;
	}
	*/
	var tCode = document.getElementById('tCode').value;
	var tName = document.getElementById('tName').value.trim();
  var tShow = document.getElementById('tShow').value;
	
	if(tName==""){
		rdShowMessageDialog("请填写主题名称");
		document.getElementById('tName').value = "";
		document.getElementById('tName').focus();
		return false;
	}
    
    if(rdShowConfirmDialog("确认要修改吗？")==1)
    {
		//调用 theme_op.jsp?opType=update,进行修改操作
		var chkPacket = new AJAXPacket("theme_op.jsp","正在执行,请稍后...");
	  	chkPacket.data.add("opType", "update");
	  	chkPacket.data.add("tCode", tCode.trim());
	  	chkPacket.data.add("tName", tName.trim());
	  	chkPacket.data.add("tShow", tShow.trim());
	 	core.ajax.sendPacket(chkPacket,doFunction,true);
	  	chkPacket = null; 
	}
}


function doCheck()//校验模板是否存在
{     
      var tCode = document.getElementById('tCode').value;
      var chkPacket = new AJAXPacket("theme_op.jsp","正在验证,请稍后...");
      chkPacket.data.add("opType", "check");
      chkPacket.data.add("tCode", tCode.trim());
      core.ajax.sendPacket(chkPacket,doFunction,false);
      chkPacket = null; 
}


 function doFunction(packet)      
 {
       var opType = packet.data.findValueByName("opType"); 
       var retCode = packet.data.findValueByName("retCode"); 
       var retMsg = packet.data.findValueByName("retMsg"); 
       if(opType.trim()=="check"){      	
	        if(retCode=="000000"){   
	        	var isAdd = packet.data.findValueByName("isAdd");  
	        	if(isAdd=="0"){  //等于0时不存在，可以继续添加         
	                checktCode = "1";
	          	}else if(isAdd=="1"){//等于1时输入主题已经存在
	          		checktCode = "0";
	          	}else{//未知错误
	          		checktCode = "2";
	          	}
	        }
       }else if(opType.trim()=="update"){
       		if(retCode=="000000"){                
	              rdShowMessageDialog("修改主题成功！",2);
				  window.opener.queryTemplate();
				  window.close();
	        }
       }else if(opType.trim()=="add"){
       		if(retCode=="000000"){                
	              rdShowMessageDialog("新增主题成功！",2);
				  window.opener.queryTemplate();
				  window.close(); 
	        }
       }
   }


</script> 
</body>
</html>