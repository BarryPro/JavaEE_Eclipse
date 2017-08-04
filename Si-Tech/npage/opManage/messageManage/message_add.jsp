<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<head>
<%
	String opName="创建消息";
	
	String orgCode =  (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	
	String groupId = (String)session.getAttribute("groupId");
	String workNo = (String)session.getAttribute("workNo");
	
	
	String  powerCode = session.getAttribute("powerCode")==null?"":((String)session.getAttribute("powerCode")).trim();//角色代码
	
	//是否有发送系统消息权限控制
	boolean showSysMsg = false;
	String qryPowerSql = "select sysmsg_send from doppowermng where power_code=:power_code";
	String qryPowerParam = "power_code="+powerCode;
	%>
	<wtc:service name="TlsPubSelCrm" outnum="1" routerKey="region" routerValue="<%=regionCode %>">
		<wtc:param value="<%=qryPowerSql%>" />
		<wtc:param value="<%=qryPowerParam%>" />						
	</wtc:service>
	<wtc:row id="qryPowerRet" start="0"  length="1">
	<%
	if("000000".equals(retCode)){
		if(qryPowerRet.length>0){
			if("1".equals(qryPowerRet[0].trim())){
				showSysMsg = true;
			}
		}
	}
	%>
	</wtc:row>
	
	 
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>创建消息</title>
<script src="<%=request.getContextPath()%>/njs/extend/mztree/MzTreeView12.js" type="text/javascript"></script>
 
</head>
<body >
<form method="post" name="frm">
	<%@ include file="/npage/include/header_pop.jsp" %>
			<div id="mInput">
				<div class="title">
					<div id="title_zi">创建消息</div>
				</div>
				<div class="input">
					<table cellspacing="0">
						<tr>
							<td class="blue" width="10%">消息类别</td>
							<td class="blue"  width="20%">
								<select id="msg_type" name="msg_type" onchange="chgType()">
									    <%if(showSysMsg){%>
										<option value="0" >系统消息</option>
										<%}%>
										<option value="1" selected>个人消息</option>
								</select>
							</td>	
							</td>
							<td class="blue" id="send_no"  width="13%">接收人工号</td>
							<td class="blue">
								<input type="text" v_must=1 v_type="string" maxlength="6" name="receive_no" id="receive_no" value=""/>
								<input type="text" style="display:none" name="receive_name" id="receive_name" value="" readonly="readonly"/>
								<input type="hidden" name="receive_role" id="receive_role" value=""/>
								<input type="button"  style="display:none" name="addRole" id="addRole" class="b_text"  onclick="showRoleTree()" value="增加角色">
								<font class="orange">*</font>
							</td>
						</tr>
						 
						<tr>							
							<td class="blue">消息内容</td>
							<td class="blue"  colspan="3">
							    <textarea class="required" cols="70" rows="10" id="msgContent"></textarea><font class="orange">*</font>
							</td>
						</tr>
						</table>
						
						 					
							
						<table>						
						<tr>
							<td colspan="4" class="blue" id="footer" align="center">
								<input class="b_foot" name="add"  id="add" type=button value="发 送" onclick="doAdd()">
								<input class="b_foot" name="reset"  id="reset" type=reset value="关闭" onclick="window.close()">
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
});
$(document).keydown(function(event){
	if (event.keyCode == 13 && event.ctrlKey){
 		 doAdd();
	}
});
</script>
<script type="text/javascript">
	

$(document).ready(function(){
	$("select").width("130");
	$("input[type='text']").width("150");
});
	var roleStr = "";
function doAdd()
{
		var receive = "";//接受角色或工号
		
		var receive_no = document.getElementById('receive_no').value;
		var receive_role =roleStr;
		var msg_type = document.getElementById('msg_type').value;
	  var msgContent = document.getElementById('msgContent').value;
	
  	if(msg_type.trim().length == 0)
    {
        rdShowMessageDialog("请选择消息类型！",1);
        document.getElementById('msg_type').focus();
        return false;
    }
    else
    {
    		if(msg_type==0){
    			if(receive_role.trim().length == 0){
	        	rdShowMessageDialog("请输入接收角色！",1);
	        	//document.getElementById('receive_name').focus();
	      		return false;
		      	}else{
		      		receive = receive_role;
		      	}
    		}else{
	    		if(receive_no.trim().length == 0){
		        	rdShowMessageDialog("请输入接收人工号！",1);
		        	document.getElementById('receive_no').focus();
		      		return false;
		      	}else{
		      		receive = receive_no;
		      	}
      		}	
    }
    if(msgContent.trim().length==0)
    {
    		rdShowMessageDialog("内容不能为空！",1);
        document.getElementById('msgContent').focus();
        return false;
    }
    
    if(msgContent.trim().len()>1024)
    {
    		rdShowMessageDialog("内容长度超长！",1);
        document.getElementById('msgContent').focus();
        return false;
    }
    	
  	$("#add").attr("disabled","disabled");
  	//调用 message_op.jsp?opType=add,进行添加操作
		var addPacket = new AJAXPacket("message_op.jsp","正在执行,请稍后...");
  	addPacket.data.add("opType", "add");
  	addPacket.data.add("receive_no", receive.trim());
  	addPacket.data.add("msg_type", msg_type.trim());
  	addPacket.data.add("msgContent", msgContent);
	 	core.ajax.sendPacket(addPacket,doFunction,true);
	  addPacket = null;  
	
}

//校验发送，（暂时不用，可给任何人发送）
function checkAdd(receive_no,receive_role){
		receive_no = receive_no.replace(",","~");
		receive_role = receive_role.replace(",","~");
		
		var chkPacket = new AJAXPacket("message_op.jsp","正在执行,请稍后...");
  	chkPacket.data.add("opType", "check");
  	chkPacket.data.add("receive_no", receive_no.trim());
  	chkPacket.data.add("receive_role", receive_role.trim());
  	chkPacket.data.add("groupId", "<%=groupId%>");
	 	core.ajax.sendPacket(chkPacket,doFunction,true);
	  chkPacket = null;  
}

 function doFunction(packet)      
 {
       var opType = packet.data.findValueByName("opType"); 
       var retCode = packet.data.findValueByName("retCode"); 
       var retMsg = packet.data.findValueByName("retMsg"); 
       if(opType.trim()=="add"){
       		if(retCode=="000000"){                
	              rdShowMessageDialog("发送消息成功！",2);
							  window.returnValue=true;
							  window.close(); 
	        }else{
	        			rdShowMessageDialog("发送失败！",0);
	        			$("#add").attr("disabled","");
	        }
       }
   }


	function chgType(){
		var val = $("#msg_type").val();
		if(val=="0"){//系统消息，按照角色发布
				$("#send_no").text("接收角色");
				$("#receive_no").hide();
				$("#receive_name").show();
				
				$("#addRole").show();
				
		}else{
			  $("#send_no").text("接收人工号");
			  $("#receive_name").hide();
				$("#receive_no").show();
				$("#addRole").hide();
		}
	}
	
function showRoleTree(){
	var path = "/npage/opManage/roleTree/roletree.jsp?formFlag=frm";
	window.open(path,'_blank','height=600,width=300,scrollbars=yes');
}
function setRolefunc(retRoleId,retRoleName,retRoleTypeName,retPowerDes){
	//alert("setRolefunc->\nretRoleId|"+retRoleId+"\nretRoleName|"+retRoleName+"\nretRoleTypeName|"+retRoleTypeName+"\nretPowerDes|"+retPowerDes);
	roleStr = retRoleId;
	$("#receive_name").val(retRoleId+"->"+retRoleName);
} 
	function closeTree(){
			$("#rootTrees").hide();
	}
	
	//功能树确定
	function selectTreeRole(){
		 var treeIdStr = getTreeValue();
		 var treeNameStr = "";
		 $("#receive_role").val(treeIdStr);
		 $("#rootTrees").hide();
		 
	}
	
		//获取选中的树节点		
		function getTreeValue(nId,nName)
		{		
		    $("#receive_name").val(nName);
		    $("#receive_role").val(nId);
		    $("#rootTrees").hide();
		}
</script> 
</body>
</html>