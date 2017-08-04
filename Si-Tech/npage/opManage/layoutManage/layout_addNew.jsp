<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<head>
<%
	String opName="新增布局模板";
	String layout_css = request.getParameter("layout_css")!=null?(String)request.getParameter("layout_css"):"";
	String orgCode =  (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String mCode = "";
	String mName = "";
	String mShow = "";
	if(!"".equals(layout_css)){
		String sql = "select layout_css,layout_name,is_effect from dlayoutmsg where layout_css=:layout_css";
		String param = "layout_css="+layout_css;
		%>
		<wtc:service name="TlsPubSelCrm" outnum="3" routerKey="region" routerValue="<%=regionCode %>">
			<wtc:param value="<%=sql%>" />
			<wtc:param value="<%=param%>" />
		</wtc:service>
		<wtc:array id="layout" scope="end"/>
		<%				
		if("000000".equals(retCode)){ 
			mCode  = layout[0][0];  
			mName  = layout[0][1];  
			mShow   = layout[0][2];   

		}
	}
%>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>布局模板设置</title>

</head>
<body >
<form method="post" name="frm"  >
	<%@ include file="/npage/include/header_pop.jsp" %>
			<div id="mInput">
				<div class="title">
					<div id="title_zi">添加布局模板</div>
				</div>
					<table cellspacing="0">
						<tr>
							<td class="blue" width="25%">布局模板编号</td>
							<td class="blue" width="25%">
								<input type='text' id="mCode" maxlength="10" onclick="showBGuidStep(2);"><font class="orange">*</font>
							</td>
							<td class="blue" width="25%">布局模板名称</td>
							<td class="blue" width="25%"><input type="text" v_must=1 v_type="string" maxlength="32" id="mName" onclick="showBGuidStep(3);"  value=""/><font class="orange">*</font></td>
						</tr>
						<tr>
							
							<td class="blue">是否发布</td>
							<td class="blue">
							    <select id="mShow">
										<option value="0">否</option>	
										<option value="1" selected>是</option>
								</select>
							</td>
							<td class="blue">默认面板</td>
							<td class="blue"> 
								<select id="defLay" onchange="setLay()">
										<option value='0'>工作区最大化</option>
										<option value='1' selected>显示全部</option>
										<option value='2'>无菜单</option>
										<option value='3'>无树</option>
								</select>
							</td>
							
						</tr>
						<tr>	
							<td  class="blue">
							选择显示的面板		
							</td>
							<td colspan="3">
									<input type="checkbox" id="layche" onclick="showBGuidStep(4);" name="layche" value="0">工作区最大化
									<input type="checkbox" id="layche" onclick="showBGuidStep(4);" name="layche" value="1">显示全部
									<input type="checkbox" id="layche" onclick="showBGuidStep(4);" name="layche" value="2">无菜单
									<input type="checkbox" id="layche" onclick="showBGuidStep(4);" name="layche" value="3">无树			
							</td>
						</tr>
					</table>
					<div class="title">
					<div id="title_zi">工作区设置</div>
				</div>
				<table cellspacing="0">
						<tr>
							<th width="5%">
									选择<input type="checkbox" id="defChecbox" name="defChecbox" onclick="setWche(this)">
								</th>
								<th width="20%">
									模块编号
								</th>
								<th width="20%">
									模块名称
								</th>
								<th width="20%">
									模块路径
								</th>
								<th width="20%">
									工作台角色
								</th>
								  
								<th>
									 长度
								</th>
							</tr>
							<wtc:pubselect name="sPubSelect" outnum="4" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  		<wtc:sql>select wkspace_id,wkspace_name,IS_EFFECT,wkspace_src from dwkspacemsg</wtc:sql>
 		</wtc:pubselect>
	<wtc:array id="result_th" scope="end"/>
		
		<%
		String outStr = "";
		for(int ih=0;ih<result_th.length;ih++){
		 	outStr += "<tr>";
		 	outStr += "<td><input type='checkbox' onclick='showBGuidStep(5);' id='wche' name='wche' value='"+result_th[ih][0]+"'></td>";
			outStr += "<td class='blue'>"+result_th[ih][0]+"</td>";
			outStr += "<td class='blue'>"+result_th[ih][1]+"</td>";
			outStr += "<td class='blue'>"+("0".equals(result_th[ih][2])?"否":"是")+"</td>";
			outStr += "<td class='blue'>"+result_th[ih][3]+"</td>";
			outStr += "<td><select ><option value='1'>半长</option><option value='2'>全长</option></select></td>";
		 	outStr += "</tr>";
		}
		 out.print(outStr);
		%>
				</table>
					<table cellspacing="0">
						<tr>
							<td  id="footer">
								<input class="b_foot"    id="addbut"  type=button value="保存" onclick="addCfm()" >
							   
							  	<input class="b_foot" name="third" type=button value="关闭" onclick="javascript:window.close();">
							</td>
						</tr>
					</table>

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
});
$(document).keydown(function(event){
	if (event.keyCode == 13 && event.ctrlKey){
 		 addCfm();
	}
});
</script>

<script type="text/javascript">
var checkMCode = "";

function showBGuidStep(step){
	window.opener.parent.showBusiGuideStep("e484",step);
}
$(document).ready(function(){
	$("select").width("50");
	$("#defLay").width("150");
	$("#mShow").width("150");
	$("input[type='text']").width("150");
	setLay();
});
 

function setLay(){
	var id=$("#defLay").val();
	
	$("[name='layche'][value='"+id+"']").attr("checked",true);
	$("[name='layche'][value!='"+id+"']").attr("checked",false);
	
	$("[name='layche'][value='"+id+"']").attr("disabled",true);
	$("[name='layche'][value!='"+id+"']").attr("disabled",false);
	 
}
function setWche(bt){
	var bolFlag = $(bt).attr("checked");
	if(bolFlag){
		$("[name='wche']").attr("checked",true);
	}else{
		$("[name='wche']").attr("checked",false);
	}
}
//添加关联模块，将信息返回到前面页面的列表
function addCfm()
{
	/*
	if(!check(frm)){
		return false;
	}
	*/
	
	var mCode = document.getElementById('mCode').value.trim();
	var mName = document.getElementById('mName').value.trim();
    if(mCode==""){
		rdShowMessageDialog("请填写布局模板ID");
		document.getElementById('mCode').value = "";
		document.getElementById('mCode').focus();
		return false;
	}
    if(mName==""){
		rdShowMessageDialog("请填写布局模板名称");
		document.getElementById('mName').value = "";
		document.getElementById('mName').focus();
		return false;
	}
	
	 var mm = /^\w+$/;
			if(!mm.test(mCode)){
				rdShowMessageDialog("模板ID只能输入字母或数字");
				document.getElementById('mCode').value = "";
				document.getElementById('mCode').focus();
				return;
			}
		
		//检测该mCode是否已经存在 调用layout_op.jsp?opType=check----
		doCheck();
		if(checkMCode=="1"){//不存在返回true，则进行添加
	  		//调用 layout_op.jsp?opType=add,进行添加操作
	  		var laycStr    = "";
	  		var wcheStr    = "";
	  		var wcheLenStr = "";
	  		$("[name='layche'][checked]").each(function(){
	  			laycStr+=$(this).val()+"~";
	  		});
			
			$("[name='wche'][checked]").each(function(){
	  			wcheStr    += $(this).val()+"~";
	  			wcheLenStr += $(this).parent().parent().find("select").val()+"~";
	  		});
	  		if(wcheStr==""){
	  			if(rdShowConfirmDialog("确定工作区不配置工作模块么？")!=1){
	  				return;
	  			}
	  		}
	  		
	  		//alert("laycStr|"+laycStr+"\nwcheStr|"+wcheStr+"\nwcheLenStr|"+wcheLenStr);
			var chkPacket = new AJAXPacket("modelAddCfm.jsp","正在执行,请稍后...");
		  	chkPacket.data.add("mCode", mCode.trim());
		  	chkPacket.data.add("mName", mName.trim());
		  	chkPacket.data.add("mShow", $("#mShow").val());
		  	chkPacket.data.add("defLay", $("#defLay").val());
		  	chkPacket.data.add("laycStr",laycStr);
		  	chkPacket.data.add("wcheStr",wcheStr);
		  	chkPacket.data.add("wcheLenStr",wcheLenStr);
		 	core.ajax.sendPacket(chkPacket,doAddCfm);
		  	chkPacket = null;  
		}else if(checkMCode=="0"){
			rdShowMessageDialog("布局模板已经存在，请重新输入！",0);
			document.getElementById('mCode').value="";
			document.getElementById('mCode').focus();
			return false;
		} 
}
function doAddCfm(packet){
    var retCode = packet.data.findValueByName("retCode"); 
    var retMsg  = packet.data.findValueByName("retMsg"); 
    if(retCode=="000000"){
    	window.opener.parent.showBusiGuideStep("e484",6);
    	rdShowMessageDialog("操作成功",2);
    	window.opener.queryTemplate();
    	window.close();
    }else{
    	rdShowMessageDialog("操作失败",0);
    }
}
    
//保存修改后的内容
function doUpate()
{
}


function doCheck()//校验模板是否存在
{     
      var mCode = document.getElementById('mCode').value;
      var chkPacket = new AJAXPacket("layout_op.jsp","正在校验,请稍后...");
      chkPacket.data.add("opType", "check");
      chkPacket.data.add("mCode", mCode.trim());
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
	                checkMCode = "1";
	          	}else if(isAdd=="1"){//等于1时输入主题已经存在
	          		checkMCode = "0";
	          	}else{//未知错误
	          		checkMCode = "2";
	          	}
	        }
       }
    }
 
</script> 
</body>
</html>