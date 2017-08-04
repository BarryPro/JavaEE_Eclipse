<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<head>
<%
	String opName="新增工作区通讯";
	String commun_seq = request.getParameter("commun_seq")!=null?(String)request.getParameter("commun_seq"):"";
	String orgCode =  (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String wkCode = "";
	String wkName = "";
	String wkShow = "";
	String wkField = "";
	if(!"".equals(commun_seq)){
		String sql = "select to_char(seq),wkspace_code,wkspace_name,field,is_effect from dcommunicate where seq=:commun_seq";
		String param = "commun_seq="+commun_seq;
		System.out.println(param);
		%>
		<wtc:service name="TlsPubSelCrm" outnum="5" routerKey="region" routerValue="<%=regionCode %>">
			<wtc:param value="<%=sql%>" />
			<wtc:param value="<%=param%>" />
		</wtc:service>
		<wtc:array id="workspace" scope="end"/>
		<%		
				System.out.println(retCode);
		if("000000".equals(retCode)){ 
			wkCode  = workspace[0][1];  
			wkName  = workspace[0][2];  
			wkField   = workspace[0][3]; 
			wkShow  = workspace[0][4];
		}
	}
%>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>工作区模块设置</title>
</head>
<body  >
<form method="post" name="frm">

	<%@ include file="/npage/include/header_pop.jsp" %>
			<div id="mInput">
				<div class="title">
					<div id="title_zi">添加工作区模块</div>
				</div>
				<div class="input">
					<table cellspacing="0">
						<tr>
							<td class="blue">工作区编码</td>
							<td class="blue">
								<!--input type="text" v_must=1 v_type="string" v_maxlength="16" maxlength="16" id="wkCode" value=""/><font class="orange">*</font-->
								<select id="wkCode" onchange="setNameAndFieId()">
									<option value="">--请选择--</option>
									<option value="e487">e487</option>
									<option value="e484">e484</option>
									<option value="e485">e485</option>
								</select>
							</td>
							<td class="blue">工作区名称</td>
							<td class="blue"><input type="text" v_must=1 v_type="string" v_maxlength="64" id="wkName" readOnly value=""/><font class="orange">*</font></td>
						</tr>
						<tr>
							<td class="blue">通讯字段</td>
							<td class="blue">
								<!--input type="text" v_must=1 v_type="string" v_maxlength="1024" id="wkField" value=""/><font class="orange">*</font-->
								<select id="wkField" >
									<option value="">--请选择--</option>
								</select>
								</td>					
							<td class="blue">是否启用</td>
							<td class="blue">
							    <select id="wkShow">
										<option value="0">否</option>	
										<option value="1" selected>是</option>
								</select>
							</td>							
						</tr>
												
						<tr>
							<td colspan="4" class="blue" style="text-align:center">
								<input class="b_foot" name="add"  id="add" style="display:none" type=button value="增加" onclick="doAdd()">
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
	$("#add").bind("mousemove", function(){
		$("#ts").show();
		var dd=document.all.ts;
		dd.style.top=event.clientY;
		dd.style.left=event.clientX;
	}) ;
	$("#add").bind("mouseout", function(){
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
 		if(<%=commun_seq!=""%>){
 			doUpate();
 		}else{
 			doAdd();
 		}
	}
});


</script>
<script type="text/javascript">
function setNameAndFieId(){
	$("#wkField").empty();//每次进来清空
	if(document.getElementById('wkCode').value=="e487"){
		$("#wkName").val("工作区通讯管理");
		var opt = $("<option>").text("工作区编码").val("wkCode");
		$("#wkField").append(opt);
				opt = $("<option>").text("工作区名称").val("wkName");
		$("#wkField").append(opt);				
	}else if(document.getElementById('wkCode').value=="e484"){
		$("#wkName").val("布局管理");
		var opt = $("<option>").text("布局模板编号").val("mCode");
		$("#wkField").append(opt);
				opt = $("<option>").text("布局模板名称").val("mName");
		$("#wkField").append(opt);
	}else if(document.getElementById('wkCode').value=="e485"){
		$("#wkName").val("主题管理");
		var opt = $("<option>").text("主题编号").val("tCode");
		$("#wkField").append(opt);
				opt = $("<option>").text("主题名称").val("tName");
		$("#wkField").append(opt);
			  opt = $("<option>").text("工作台角色").val("mrole");
		$("#wkField").append(opt);
	}else if(document.getElementById('wkCode').value==""){
		$("#wkName").val("");
		var opt = $("<option>").text("--请选择--").val("");
		$("#wkField").append(opt);
	}
}	
	
	function CHECKKEY(){
 if (event.keyCode == 13 && event.ctrlKey)
 {
 	if(<%=commun_seq!=""%>){doUpate();}else{doAdd();}
 
 }
}
var ser;
var checkwkCode = false;
var retVal = "";//返回父页面的值

$(document).ready(function(){
	$("select").width("150");
$("input[type='text']").width("150");
	if(<%=commun_seq!=""%>){
		
		document.getElementById('wkCode').value ='<%=wkCode%>';
		document.getElementById('wkName').value ='<%=wkName%>';
		document.getElementById('wkShow').value ='<%=wkShow%>';
		setNameAndFieId();
		document.getElementById('wkField').value ='<%=wkField%>';
		document.getElementById('update').style.display = "";
		document.getElementById('wkCode').disabled = true;
		document.getElementById('wkField').disabled = true;
		
	}else{
		document.getElementById('add').style.display = "";
	}
})

//添加关联模块，将信息返回到前面页面的列表
function doAdd()
{
	if(!check(frm)){
		return false;
	}
	
	var wkCode = document.getElementById('wkCode').value;
	var wkName = document.getElementById('wkName').value;
  	var wkShow = document.getElementById('wkShow').value;
  	var wkField = document.getElementById('wkField').value;
    if(wkCode==""){
    	rdShowMessageDialog("请选择工作区编码");
    	return;
    }
	//检测该wkCode是否已经存在 调用workspace_op.jsp?opType=check----
	doCheck();
	if(checkwkCode){//不存在返回true，则进行添加
			document.getElementById('add').disabled = "disabled";
			//调用 workspace_op.jsp?opType=add,进行添加操作
			var addPacket = new AJAXPacket("commun_op.jsp","正在执行,请稍后...");
	  	addPacket.data.add("opType", "add");
	  	addPacket.data.add("wkCode", wkCode.trim());
	  	addPacket.data.add("wkName", wkName.trim());
	  	addPacket.data.add("wkField", wkField.trim());
	  	addPacket.data.add("wkShow", wkShow.trim());
	 		core.ajax.sendPacket(addPacket,doFunction,true);
	  	addPacket = null;  
	}else{
		rdShowMessageDialog("工作区编码已经存在，请重新输入！",0);
		document.getElementById('wkCode').value="";
		document.getElementById('wkCode').focus();
		setNameAndFieId();
		return false;
	}
	
}

    
//保存修改后的内容
function doUpate()
{
	
	if(!check(frm)){
		return false;
	}
	
	var wkCode = document.getElementById('wkCode').value;
	var wkName = document.getElementById('wkName').value;
	var wkShow =  document.getElementById('wkShow').value;
	var wkField =  document.getElementById('wkField').value;
	
    if(rdShowConfirmDialog("确认要修改吗？")==1)
    {
    	document.getElementById('update').disabled = "disabled";
		//调用 workspace_op.jsp?opType=update,进行修改操作
		var updatePacket = new AJAXPacket("commun_op.jsp","正在执行,请稍后...");
	  	updatePacket.data.add("opType", "update");
	  	updatePacket.data.add("wkSeq", '<%=commun_seq%>');
	  	updatePacket.data.add("wkCode", wkCode.trim());
	  	updatePacket.data.add("wkName", wkName.trim());
	  	updatePacket.data.add("wkField", wkField.trim());
	  	updatePacket.data.add("wkShow", wkShow.trim());
	 	  core.ajax.sendPacket(updatePacket,doFunction,true);
	  	updatePacket = null; 
	}
}


function doCheck()//校验模板是否存在
{     
      var wkCode = document.getElementById('wkCode').value;
      var chkPacket = new AJAXPacket("commun_op.jsp","正在验证,请稍后...");
      chkPacket.data.add("opType", "check");
      chkPacket.data.add("wkCode", wkCode.trim());
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
	              checkwkCode = true;
	          	}
	        }
       }else if(opType.trim()=="update"){
       		if(retCode=="000000"){                
	              rdShowMessageDialog("修改成功！",2);
				 		 		window.opener.queryTemplate();
				  			window.close();
	        }else{
	        		rdShowMessageDialog("修改失败！",0);
	        		document.getElementById('update').disabled = "";
	        }
       }else if(opType.trim()=="add"){
       		if(retCode=="000000"){                
	              rdShowMessageDialog("新增成功！",2);
				  			window.opener.queryTemplate();
				  			window.close(); 
	        }else{
	        		rdShowMessageDialog("新增失败！",0);
	        		document.getElementById('add').disabled = "";
	        }
       }
   }


</script> 
</body>
</html>