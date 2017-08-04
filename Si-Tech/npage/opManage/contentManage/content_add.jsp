<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<head>
<%
	String opName="新增内容";
	String content_seq = request.getParameter("content_seq")!=null?(String)request.getParameter("content_seq"):"";
	String orgCode =  (String)session.getAttribute("orgCode");
	String workNo = (String)session.getAttribute("workNo");
	String regionCode = orgCode.substring(0,2);
	String content_type = "";
	String content_id = "";
	String content_name = "";
	String content_detail = "";
	String is_effect = "";
	String content_cls = "";
	String opRoleId = "";
	if(!"".equals(content_seq)){
		String sql = "select to_char(seq),content_type,content_id,content_name,content_detail,is_effect,version,to_char(op_time,'yyyy-mm-dd hh24:mi:ss'),content_cls,op_roleid from dcontentmsg where seq=:content_seq  ";
		String param = "content_seq="+content_seq;
		System.out.println(param);
		%>
		<wtc:service name="TlsPubSelCrm" outnum="10" routerKey="region" routerValue="<%=regionCode %>">
			<wtc:param value="<%=sql%>" />
			<wtc:param value="<%=param%>" />
		</wtc:service>
		<wtc:array id="workspace" scope="end"/>
		<%		
				System.out.println(retCode);
		if("000000".equals(retCode)){ 
			content_type  = workspace[0][1];  
			content_id  = workspace[0][2];  
			content_name   = workspace[0][3]; 
			content_detail  = workspace[0][4];
			is_effect = workspace[0][5];
			content_cls = workspace[0][8];
			opRoleId = workspace[0][9];
			
		}
	}
	if("".equals(content_cls)) content_cls = "无";
	System.out.println("--------------content_cls--------------------"+content_cls);
%>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>内容设置</title>
</head>
<body >
<form method="post" name="frm">

	<%@ include file="/npage/include/header_pop.jsp" %>
			<div id="mInput">
				<div class="title">
					<div id="title_zi">添加内容</div>
				</div>
				<div class="input">
					<table cellspacing="0">
						<tr>
							<td class="blue" width="10%">内容ID</td>
							<td class="blue"  width="40%">
									
								<select id="content_id">
										<option value='c_busiguide'>业务向导</option>
										<option value='c_privset'>全部功能</option>
										<option value='c_callUserInfo'>用户信息</option>
										<option value='c_sysmenu'>系统菜单</option>
										<option value='c_commfunc'>常用功能</option>
									</select>	
									<span id="checkMsg" style="color:orange"></span>
							</td>
							<td class="blue"  width="10%">内容名称</td>
							<td class="blue"  width="40%"><input type="text" maxlength="4" v_must=1 v_type="string" v_maxlength="64" id="content_name" value=""/><font class="orange">*</font></td>
						</tr>
						<tr>
							 	<td class="blue">内容样式</td>
							<td>
								<select id="conCls" name="conCls">	
									<option value="ico_fav">ico_fav</option>
									<option value="ico_buGu">ico_buGu</option>
									<option value="ico_user">ico_user</option>
									<option value="ico_tree">ico_tree</option>
								</select>		
							</td>
							<td class="blue">是否发布</td>
							<td class="blue">
							    <select id="is_effect">
										<option value="0">否</option>	
										<option value="1" selected>是</option>
								</select>
							</td>							
						</tr>
						<tr>
							
							<td class="blue">详细信息&nbsp;</td>
							<td class="blue" ><input type="text" v_must=1 v_type="string" v_maxlength="512"  size="60" id="content_detail" value=""/><font class="orange">*</font></td>					
							
						<td class="blue">选择角色</td>
								 
							<td>
								<input type="text" name="oproleidshow" value="<%=opRoleId%>" readOnly >
								<input type="hidden" name="oproleidhide" >
								<input type="button" class="b_text" onclick="queryPowerCode('frm')" value="选择角色">
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
 		if(<%=content_seq!=""%>){
 			doUpate();
 		}else{
			doAdd();
		}
	}
});
</script>

<script type="text/javascript">
 
var ser;
var checkId = false;
var retVal = "";//返回父页面的值
function queryPowerCode(str){
	var path = "/npage/opManage/roleTree/roletree.jsp";
	window.open(path,'','height=600,width=300,scrollbars=yes');
}
function setRolefunc(retRoleId,retRoleName,retRoleTypeName,retPowerDes){
	document.all.oproleidshow.value=retRoleId+"->"+retRoleName;
	document.all.oproleidhide.value=retRoleId;
}
$(document).ready(function(){
	if(<%=content_seq!=""%>){
		setShow();
		
		document.all.oproleidhide.value='<%=opRoleId%>';
		document.all.oproleidshow.value='<%=opRoleId%>';
		document.getElementById('content_id').value ='<%=content_id%>';
		document.getElementById('content_name').value ='<%=content_name%>';
		document.getElementById('content_detail').value ='<%=content_detail%>';
		document.getElementById('is_effect').value ='<%=is_effect%>';
		document.getElementById('conCls').value ='<%=content_cls%>';
		document.getElementById('update').style.display = "";
		document.all.content_id.disabled=true;
	}else{
		document.getElementById('add').style.display = "";
		setShow();
	}
	
})
 $(document).ready(function(){
	$("select").width("150");
	$("input[type='text']").width("150");
});
function setShow(){
		document.getElementById("conCls").options.length=0;
        document.getElementById("conCls").options.add(new Option("全部功能样式","ico_fav")); 
        document.getElementById("conCls").options.add(new Option("全部功能样式1","ico_fav_o")); 
        document.getElementById("conCls").options.add(new Option("业务向导样式","ico_buGu")); 
        document.getElementById("conCls").options.add(new Option("业务向导样式1","ico_buGu_o")); 
        document.getElementById("conCls").options.add(new Option("常用功能样式","ico_user")); 
        document.getElementById("conCls").options.add(new Option("常用功能样式1","ico_user_o")); 
        document.getElementById("conCls").options.add(new Option("系统菜单样式","ico_tree")); 
        document.getElementById("conCls").options.add(new Option("系统菜单样式1","ico_tree_o"));
        document.getElementById("conCls").options.add(new Option("用户信息样式","ico_fav")); 
        document.getElementById("conCls").options.add(new Option("用户信息样式1","ico_fav_o"));
        document.getElementById("content_id").options.length=0;
        document.getElementById("content_id").options.add(new Option("业务向导","p_busiguide")); 
        document.getElementById("content_id").options.add(new Option("全部功能","p_privset")); 
        document.getElementById("content_id").options.add(new Option("用户信息","p_callUserInfo")); 
        document.getElementById("content_id").options.add(new Option("系统菜单","p_sysmenu")); 
        document.getElementById("content_id").options.add(new Option("常用功能","p_commfunc")); 
		
}
//添加关联模块，将信息返回到前面页面的列表
function doAdd()
{
		/*
		if(!check(frm)){
			return false;
		}
		*/
	    var content_id = document.getElementById('content_id').value;
		var content_name = document.getElementById('content_name').value.trim();
  		var is_effect = document.getElementById('is_effect').value;
		var content_detail = document.getElementById('content_detail').value;
		var oproleidshow = document.getElementById('oproleidshow').value;
		if(oproleidshow==""){
			rdShowMessageDialog("请选择角色");
			return false;
		}
    	if(content_name==""){
			rdShowMessageDialog("请填写内容名称");
			document.getElementById('content_name').value = "";
			document.getElementById('content_name').focus();
			return false;
		}
		if(content_detail==""){
			rdShowMessageDialog("请填写详细信息");
			document.getElementById('content_detail').value = "";
			document.getElementById('content_detail').focus();
			return false;
		}
    doCheck();
	//检测该wkCode是否已经存在 调用workspace_op.jsp?opType=check----
	if(checkId){//不存在返回true，则进行添加
			document.getElementById('add').disabled = "disabled";
			//调用 content_op.jsp?opType=add,进行添加操作
			var addPacket = new AJAXPacket("content_op.jsp","正在执行,请稍后...");
	  	addPacket.data.add("opType", "add");
	  	addPacket.data.add("content_id", content_id.trim());
	  	addPacket.data.add("content_name", content_name.trim());
	  	addPacket.data.add("is_effect", is_effect.trim());
	  	addPacket.data.add("content_detail", content_detail.trim());
	  	addPacket.data.add("conCls", document.getElementById('conCls').value);
	  	addPacket.data.add("oproleidhide",document.getElementById('oproleidhide').value);
	  	
	 	core.ajax.sendPacket(addPacket,doFunction);
	  	addPacket = null;  
	}else{
		rdShowMessageDialog("内容ID已经存在，请重新输入！",0);
		document.getElementById('content_id').value="c_busiguide";
		document.getElementById('content_id').focus();
		return false;
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
	    var content_id = document.getElementById('content_id').value;
		var content_name = document.getElementById('content_name').value.trim();
  		var is_effect = document.getElementById('is_effect').value;
		var content_detail = document.getElementById('content_detail').value;
		var oproleidshow = document.getElementById('oproleidshow').value;
		if(oproleidshow==""){
			rdShowMessageDialog("请选择角色");
			return false;
		}
    	if(content_name==""){
			rdShowMessageDialog("请填写内容名称");
			document.getElementById('content_name').value = "";
			document.getElementById('content_name').focus();
			return false;
		}
		if(content_detail==""){
			rdShowMessageDialog("请填写详细信息");
			document.getElementById('content_detail').value = "";
			document.getElementById('content_detail').focus();
			return false;
		}
		
    if(rdShowConfirmDialog("确认要修改吗？")==1)
    {
    	document.getElementById('update').disabled = "disabled";
			//调用 content_op.jsp?opType=update,进行修改操作
			var updatePacket = new AJAXPacket("content_op.jsp","正在执行,请稍后...");
	  	updatePacket.data.add("opType", "update");
	  	updatePacket.data.add("content_seq", '<%=content_seq%>');
	  	updatePacket.data.add("content_id", content_id.trim());
	  	updatePacket.data.add("content_name", content_name.trim());
	  	updatePacket.data.add("is_effect", is_effect.trim());
	  	updatePacket.data.add("content_detail", content_detail.trim());
	  	updatePacket.data.add("conCls", document.getElementById('conCls').value);
	  	updatePacket.data.add("oproleidhide",document.getElementById('oproleidhide').value);
	  	
	 		core.ajax.sendPacket(updatePacket,doFunction,true);
	  	updatePacket = null; 
	}
}


function doCheck()//校验模板是否存在
{     
    var content_id = document.getElementById('content_id').value;
    <%if(!"".equals(content_seq)){%>//若是修改
   	if(content_id!="<%=content_id%>"){
  	<%}%>
    if(content_id.trim().length > 0){
      var chkPacket = new AJAXPacket("content_op.jsp","正在验证,请稍后...");
      chkPacket.data.add("opType", "check");
      chkPacket.data.add("content_id", content_id.trim());
      chkPacket.data.add("oproleidhide",document.getElementById('oproleidhide').value);
      core.ajax.sendPacket(chkPacket,doFunction,false);
      chkPacket = null; 
    }
    <%if(!"".equals(content_seq)){%>//若是修改
    	}
  	<%}%>
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
	              checkId = true;
	              $("#checkMsg").text("");
	          }else{
	          		checkId = false;
	          		//$("#checkMsg").text((document.getElementById('content_id').value).trim()+"已经存在！");
	          }
	        }
       }else if(opType.trim()=="update"){
       		if(retCode=="000000"){                
	              rdShowMessageDialog("修改成功！",2);
				 		 		window.opener.queryContent();
				  			window.close();
	        }else{
	        		rdShowMessageDialog("修改失败！",0);
	        		document.getElementById('update').disabled = "";
	        }
       }else if(opType.trim()=="add"){
       		if(retCode=="000000"){                
	              rdShowMessageDialog("新增成功！",2);
				  			window.opener.queryContent();
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