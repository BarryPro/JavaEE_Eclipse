<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<head>
	<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
		String opName="角色权限管理";
		
		String workNo = (String)session.getAttribute("workNo");
		String orgCode =  (String)session.getAttribute("orgCode");
		String regionCode = orgCode.substring(0,2);
		String  powerCode = session.getAttribute("powerCode")==null?"":((String)session.getAttribute("powerCode")).trim();//角色代码
 
	%>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
	<title><%=opName%></title>
	 <style>	
		#rootTree {
			height: 300px;
			border: 1px solid #95CBDD;
			border-top: 0;
			overflow: auto;
			background-color: #F7F7F7;
			padding: 4px 0px 1px 0px;
			width:100%;
			font: 12px Verdana, Arial, Helvetica, sans-serif,"宋体"，"黑体";
		}
	</style>
	<script language="javascript" type="text/javascript">		
		var roleStr = "";
		
		//获取选中的树节点		
		function getTreeValue()
		{
		    var treeStr="";		 	    
		    var theme_role_tree = document.getElementsByName("theme_role_tree");
		    for(var i=0;i<theme_role_tree.length;i++){
		    	if(theme_role_tree[i].checked){
		    		treeStr += theme_role_tree[i].value +"~";
		    	}
		    }
		    return treeStr;
		}

		//默认显示设置取值
		function reloadOpt(mod1,mod2){
		  var m1 = g(mod1);
		  var m2 = g(mod2);
		  m2.options.length=0;
		  for(i=0; i<m1.options.length; i++){
		      var varItem = new Option(m1.options[i].text, m1.options[i].value); 
		      m2.options.add(varItem);
		  }
		}
		
		//select左右换
		function optionChg(mod1,mod2){
	      var m1=g(mod1);
	      var m2=g(mod2);
	      if(m1.tagName!='SELECT' || m2.tagName!='SELECT'){ 
	          return;
	      }else{
	          if(m1.selectedIndex>-1){
				    for(var i=m1.options.length-1; i>=0; i--){ 
				      if(m1[i].selected == true){
				      	 var varItem = new Option(m1.options[i].text, m1.options[i].value); 
				      	 m2.options.add(varItem);
				         m1.options[i]=null;
				      } 
				   } 
	          }
	      }
	      reloadOpt('moduleHide','moduleHide1'); 
	  	}
	  
		function g(o){
			return document.getElementById(o);
	 	}	
	 	
	 	function doSubmit(){
	 		updRoleStr();
	 		var treeStr = roleStr;
	 		if(treeStr==""){
	 			rdShowMessageDialog("请选择角色！",1);
	 			return;
	 		}
	 		var optLength = document.getElementById("moduleHide").options.length;
	 		if(optLength==0){
	 			rdShowMessageDialog("当前主题为空！",1);
	 			return;
	 		}
	 		if(rdShowConfirmDialog("确认要设置默认主题为“"+$("#moduleHide1 option:selected").text()+"”吗？")==1)
	       	{
		 		//对当前主题进行组装，用~隔开
		 		var optVal = "";
		 		var defaultVal = "";
		 		for(var i=0;i<optLength;i++){
		 			var val = document.getElementById("moduleHide").options[i].value;
		 			optVal += val+"~";
		 			if(val == g("moduleHide1").value){
		 				defaultVal = defaultVal + "1" +"~"
		 			}else{
		 				defaultVal = defaultVal + "0" +"~"
		 			}
		 		}
		 		
		 				g("doSet").disabled = "disabled";
		 				var submitPacket = new AJAXPacket("theme_op.jsp","正在执行,请稍后...");
		      	submitPacket.data.add("opType", "setRole");
		      	submitPacket.data.add("selectValue", optVal);
		      	submitPacket.data.add("treeValue", treeStr);
		      	submitPacket.data.add("defaulttheme", defaultVal);	 
		      	submitPacket.data.add("moduleHide1", g("moduleHide1").value);     	
		      	core.ajax.sendPacket(submitPacket,doProcess,true);
		      	delPacket = null; 
	    	}
	 	}
	 	
	 	function doProcess(packet)      
 		{
	       var opType = packet.data.findValueByName("opType"); 
	       var retCode = packet.data.findValueByName("retCode"); 
	       var retMsg = packet.data.findValueByName("retMsg"); 
	      
	       if(opType=="setRole"){
       			if(retCode=="000000"){
       				rdShowMessageDialog("主题设置成功！",2);
       				g("doSet").disabled = "";
       				window.opener.queryTemplate();
       				window.close();
       			}else{
       				rdShowMessageDialog("主题设置失败！",0);	
       				g("doSet").disabled = "";
       			}
       			
       	   }
       }
function queryPowerCode(str){
	var path = "/npage/opManage/roleTree/roletree.jsp";
	window.open(path,'_blank','height=600,width=300,scrollbars=yes');
}       

function compRoleId(roleStr,retRoleId){
	var retVal = 0;
	var tempArr = roleStr.split("~");
	for(var i=0;i<tempArr.length;i++){
		if(tempArr[i]==retRoleId){
			retVal++;
			break;
		}
	}
	return retVal ;
}
function setRolefunc(retRoleId,retRoleName,retRoleTypeName,retPowerDes){
	//alert("setRolefunc->\nretRoleId|"+retRoleId+"\nretRoleName|"+retRoleName+"\nretRoleTypeName|"+retRoleTypeName+"\nretPowerDes|"+retPowerDes);
	if(compRoleId(roleStr,retRoleId)>0){
		rdShowMessageDialog("已有的角色记录，请重新选择");
		return;
	}
	var inHtml = "<tr>"+
					"<td width='30%'>"+
					retRoleId+
					"</td>"+
					"<td  width='60%'>"+
					retRoleName+
					"</td>"+
					"<td >"+
					"<input type='button' value='删除' class='b_text' onclick='delTr(this)'>"+
					"</td>"+
				"</tr>";
	$("#roleTab").append(inHtml);
	updRoleStr();
}

function updRoleStr(){
	$("#roleTab tr:gt(0)").each(function(){
		roleStr += $(this).find("td:eq(0)").text().trim()+"~";
	});
}
function delTr(bt){
	$(bt).parent().parent().remove();
	updRoleStr();
}
$(document).ready(function(){
	reloadOpt('moduleHide','moduleHide1');	
});	
 
	</script>
	
</head>
<body >
	<form method="post" name="frm" >
	<%@ include file="/npage/include/header_pop.jsp" %>
	
		<div style="width:38%;float:left;margin-right:10px">
			<div class="title" id="div_title">
				<div id="title_zi">
					角色选择&nbsp;<input type="button" class="b_text" onclick="queryPowerCode('frm')" value="增加角色">
				</div>
			</div>
			<div id="rootTree">
				<table cellspacing="0" id="roleTab">
				<tr>
					<th class="blue">
						角色代码
					</th>
					<th class="blue">
						角色名称
					</th>
					<th class="blue">
						操作
					</th>
				</tr>
				 
			</table>
				
			</div>
		</div>
	
		<div class="title">
			<div id="title_zi">
				角色主题配置
			</div>
		</div>
		<div style="float:right;margin-right:10px">
			<table cellspacing="0">
				<tr>
					<td class="blue">
						当前主题：
					</td>
					<td class="blue">
						&nbsp;
					</td>
					<td class="blue">
						可选主题：
					</td>
				</tr>
				<tr>
					<td class="blue">
						<select id="moduleHide" name="moduleHide" size="10" multiple="multiple" style="width: 200px;height: 150px;">
						 
						</select>
					</td>
					<td class="blue">
						<input type="button" class="b_text"  id="save" name="save"
							value=">>" onClick="optionChg('moduleHide','moduleShow');" />
						<br />
						<br />
						<input type="button" class="b_text"  id="save" name="save"
							value="<<" onClick=" optionChg('moduleShow','moduleHide');"/>
					</td>
					<td class="blue">
						<select id="moduleShow" name="moduleShow" size="10" multiple="multiple" style="width: 200px;height: 150px;">
						<%	
							String sqlStr2 ="select theme_css,theme_name from dthememsg where   is_effect='1' ";
          				%>
					 		<wtc:service name="TlsPubSelCrm" outnum="2" routerKey="region" routerValue="<%=regionCode %>">
						 		<wtc:param value="<%=sqlStr2%>" />
					 		</wtc:service>
					 		<wtc:array id="result_t2" scope="end"/>
					 		<%
					 		for(int i=0;i<result_t2.length;i++){
					 			out.print("<option value='"+result_t2[i][0]+"'>"+result_t2[i][1]+"</option>");
					 		}
					 		%>
						</select>
					</td>
				</tr>
			</table>
		</div>
			
	</div>		
	<div id="Operation_Table">
		<div class="title">
			<div id="title_zi">
				默认主题设置
			</div>
		</div>	
		<div style="float:right;margin-right:10px">			
			<table cellspacing="0">
				<tr>
					<td class="blue">
						请设置默认显示主题：
					</td>
				</tr>
				<tr>
					<td  class="blue">
						<select id="moduleHide1" name="moduleHide1" style="width: 200px">
						</select>
					</td>
				</tr>
			</table>
		</div>
	</div>		
	<div id="Operation_Table">
		<div style="float:right;margin-right:10px;">		
			<TABLE cellSpacing=0>       
	            <tr> 
	              <td align=center id="footer"> 
	               	<input type="button" class="b_foot" value="确定" id="doSet" name="doSet" onClick="doSubmit()" />
					<input type="button" class="b_foot" value="关闭" id="clears" name="clears" onClick="window.close();" />
	             </td>
	            </tr>
	        </TABLE>
		</div>

	<%@ include file="/npage/include/footer_pop.jsp" %>
	</form>
</body>
<div id="ts" style=" position:absolute;border:1px green solid; z-index:5; height:20px; font-size:12px; width:180px; display:none;">&nbsp;&nbsp;&nbsp;同时按下ctrl+enter也可提交</div>
<script>
$(document).ready(function(){
	$("#doSet").bind("mousemove", function(){
		$("#ts").show();
		var dd=document.all.ts;
		dd.style.top=event.clientY;
		dd.style.left=event.clientX;
	}) ;
	$("#doSet").bind("mouseout", function(){
		$("#ts").hide();
	}) ;
});
$(document).keydown(function(event){
	if (event.keyCode == 13 && event.ctrlKey){
 		 doSubmit();
	}
});
</script>
</html>