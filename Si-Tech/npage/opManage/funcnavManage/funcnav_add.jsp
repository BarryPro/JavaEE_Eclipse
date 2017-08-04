<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<head>
<%
	String opName="新增页面导航信息";
	String funcnav_seq = request.getParameter("funcnav_seq")!=null?(String)request.getParameter("funcnav_seq"):"";
	String orgCode =  (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String functionCode = "";
	String nav_path = "";
	String is_use = "";

	if(!"".equals(funcnav_seq)){
		String sql = "select to_char(nav_seq),function_code,nav_path,is_use,to_char(op_time,'yyyy-mm-ss hh24:mi:ss') from dfuncnavmsg  where nav_seq=:funcnav_seq";
		String param = "funcnav_seq="+funcnav_seq;
		System.out.println(param);
		%>
		<wtc:service name="TlsPubSelCrm" outnum="5" routerKey="region" routerValue="<%=regionCode %>">
			<wtc:param value="<%=sql%>" />
			<wtc:param value="<%=param%>" />
		</wtc:service>
		<wtc:array id="funcnavList" scope="end"/>
		<%		
				System.out.println(retCode);
		if("000000".equals(retCode)){ 
			if(funcnavList.length>0){
				functionCode  = funcnavList[0][1];  
				nav_path  = funcnavList[0][2];  
				is_use  = funcnavList[0][3];
			}
		}
	}
%>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>新增页面导航信息</title>
</head>
<body>
<form method="post" name="frm">

	<%@ include file="/npage/include/header_pop.jsp" %>
			<div id="mInput">
				<div class="title">
					<div id="title_zi">新增页面导航信息</div>
				</div>
				<div class="input">
					<table cellspacing="0">
						<tr>
							<td class="blue" width="10%">业务编码</td>
							<td class="blue" width="45%">
								<input type="text" v_must=1 v_type="string"   id="functionCode" name="functionCode" value="" onfocus="showNavInfo1()" size="100" /><font class="orange">*</font>
								<div class="orange" id="nav_path_info1" style="display:none">opcode之间使用英文分号（;）隔开，如： 1104;1100;d603</div>
								<div class="orange" id="nav_path_info2" style="display:none">opcode只能填写一个如：1100</div>
							</td>
						</tr>
						
						<tr>
							<td class="blue">导航路径</td>
							<td class="blue" ><input type="text"  v_must=1 v_type="string" v_maxlength="512"  id="nav_path" name="nav_path" value="" onfocus="showNavInfo()"  size="100"   /><font class="orange">*</font>
								<div class="orange" id="nav_path_info" style="display:none">节点之间用英文分号（;）隔开，如： 系统管理;OP管理;业务导航管理</div>
								</td>					
							
						</tr>
								<tr>
							<td class="blue"  width="10%">是否启用</td>
							<td class="blue"  width="35%">
							    <select id="is_use">
										<option value="0">否</option>	
										<option value="1" selected>是</option>
								</select>
							</td>							
						</tr>				
						<tr>
							<td colspan="2" class="blue" style="text-align:center">
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
 		if(<%=funcnav_seq!=""%>){
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
});
var ser;
var checkfunctionCode = false;
var retVal = "";//返回父页面的值

$(document).ready(function(){
	if(<%=funcnav_seq!=""%>){
		document.getElementById('functionCode').value ='<%=functionCode%>';
		document.getElementById('nav_path').value ='<%=nav_path%>';
		document.getElementById('is_use').value ='<%=is_use%>';

		document.getElementById('update').style.display = "";

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
	var functionCode = document.getElementById('functionCode').value;
	var nav_path = document.getElementById('nav_path').value;
  	var is_use = document.getElementById('is_use').value;

    
	//检测该functionCode是否已经存在 调用workspace_op.jsp?opType=check----
			document.getElementById('add').disabled = "disabled";
			//调用 workspace_op.jsp?opType=add,进行添加操作
			var addPacket = new AJAXPacket("funcnav_op.jsp","正在执行,请稍后...");
	  	addPacket.data.add("opType", "add");
	  	addPacket.data.add("functionCode", functionCode.trim());
	  	addPacket.data.add("nav_path", nav_path.trim());
	  	addPacket.data.add("is_use", is_use.trim());
	 		core.ajax.sendPacket(addPacket,doFunction,true);
	  	addPacket = null;  
	 
	
}

    
//保存修改后的内容
function doUpate()
{
	
	if(!check(frm)){
		return false;
	}
	
	var functionCode = document.getElementById('functionCode').value;
	var nav_path = document.getElementById('nav_path').value;
	var is_use =  document.getElementById('is_use').value;
	
    if(rdShowConfirmDialog("确认要修改吗？")==1)
    {
    	document.getElementById('update').disabled = "disabled";
		//调用 workspace_op.jsp?opType=update,进行修改操作
		var updatePacket = new AJAXPacket("funcnav_op.jsp","正在执行,请稍后...");
	  	updatePacket.data.add("opType", "update");
	  	updatePacket.data.add("function_seq", '<%=funcnav_seq%>');
	  	updatePacket.data.add("functionCode", functionCode.trim());
	  	updatePacket.data.add("nav_path", nav_path.trim());
	  	updatePacket.data.add("is_use", is_use.trim());
	 	  core.ajax.sendPacket(updatePacket,doFunction,true);
	  	updatePacket = null; 
	}
}


function doCheck()//校验模板是否存在
{     
      var functionCode = document.getElementById('functionCode').value;
      var chkPacket = new AJAXPacket("funcnav_op.jsp","正在验证,请稍后...");
      chkPacket.data.add("opType", "check");
      chkPacket.data.add("functionCode", functionCode.trim());
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
	              checkfunctionCode = true; 
	              $("#checkMsg").text("");
	          }else{
	          		checkfunctionCode = false;
	          		$("#checkMsg").text($.trim($("#functionCode").val())+"已经存在！");
	          }
	        }
       }else if(opType.trim()=="update"){
       		if(retCode=="000000"){                
	              rdShowMessageDialog("修改成功！",2);
				 		 		window.opener.queryNav();
				  			window.close();
	        }else{
	        		rdShowMessageDialog("修改失败！",0);
	        		document.getElementById('update').disabled = "";
	        }
       }else if(opType.trim()=="add"){
       		if(retCode=="000000"){                
	              rdShowMessageDialog("新增成功！",2);
				  			window.opener.queryNav();
				  			window.close(); 
	        }else{
	        		rdShowMessageDialog("新增失败！",0);
	        		document.getElementById('add').disabled = "";
	        }
       }
   }

	function showNavInfo(){
		 $("#nav_path_info").show();
	}
	function showNavInfo1(){
		if(<%=funcnav_seq!=""%>){
		 $("#nav_path_info2").show();
		}else{
		  $("#nav_path_info1").show();
		}
	}
	
</script> 
</body>
</html>