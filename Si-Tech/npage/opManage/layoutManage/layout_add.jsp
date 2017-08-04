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
<body>
<form method="post" name="frm"  >
	<%@ include file="/npage/include/header_pop.jsp" %>
			<div id="mInput">
				<div class="title">
					<div id="title_zi">添加布局模板</div>
				</div>
				<div class="input">
					<table cellspacing="0">
						<tr>
							<td class="blue">布局模板编号</td>
							<td class="blue">
								<select id="mCode">
										<option value='0'>0</option>
										<option value='1'>1</option>
										<option value='2'>2</option>
										<option value='3'>3</option>
									</select>
							</td>
							<td class="blue">布局模板名称</td>
							<td class="blue"><input type="text" v_must=1 v_type="string" v_maxlength="32" id="mName" value=""/><font class="orange">*</font></td>
						</tr>
						<tr>
							
							<td class="blue">是否发布</td>
							<td class="blue">
							    <select id="mShow">
										<option value="0">否</option>	
										<option value="1" selected>是</option>
								</select>
							</td>
							<td class="blue">&nbsp;</td>
							<td class="blue">&nbsp;</td>
							
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
<script type="text/javascript">
var ser;
var checkMCode = "";
var retVal = "";//返回父页面的值
$(document).ready(function(){
	$("select").width("150");
	$("input[type='text']").width("150");
});
$(document).ready(function(){
	if(<%=layout_css!=""%>){
		document.getElementById('mCode').value ='<%=mCode%>';
		document.getElementById('mName').value ='<%=mName%>';
		document.getElementById('mShow').value ='<%=mShow%>';
		document.getElementById('update').style.display = "";
		document.all.mCode.disabled=true;

	}else{
		document.getElementById('add').style.display = "";
	}

})
 

//添加关联模块，将信息返回到前面页面的列表
function doAdd()
{
	/*
	if(!check(frm)){
		return false;
	}
	*/
	
	var mCode = document.getElementById('mCode').value;
	var mName = document.getElementById('mName').value.trim();
    var mShow = document.getElementById('mShow').value;
	if(mName==""){
		rdShowMessageDialog("请填写布局模板名称");
		document.getElementById('mName').value = "";
		document.getElementById('mName').focus();
		return false;
	}
    if(rdShowConfirmDialog("布局编号新增后不能修改，确认要新增吗？")==1)
    {
		//检测该mCode是否已经存在 调用layout_op.jsp?opType=check----
		doCheck();
		if(checkMCode=="1"){//不存在返回true，则进行添加
	  		//调用 layout_op.jsp?opType=add,进行添加操作
			  var chkPacket = new AJAXPacket("layout_op.jsp","正在执行,请稍后...");
		  	chkPacket.data.add("opType", "add");
		  	chkPacket.data.add("mCode", mCode.trim());
		  	chkPacket.data.add("mName", mName.trim());
		  	chkPacket.data.add("mShow", mShow.trim());
		 	  core.ajax.sendPacket(chkPacket,doFunction,true);
		  	chkPacket = null;  
		}else if(checkMCode=="0"){
			rdShowMessageDialog("布局模板已经存在，请重新输入！",0);
			document.getElementById('mCode').value="0";
			document.getElementById('mCode').focus();
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
    var mCode = document.getElementById('mCode').value;
	var mName = document.getElementById('mName').value.trim();
    var mShow = document.getElementById('mShow').value;
	if(mName==""){
		rdShowMessageDialog("请填写布局模板名称");
		document.getElementById('mName').value = "";
		document.getElementById('mName').focus();
		return false;
	}
	if(rdShowConfirmDialog("确认要修改吗？")==1)
    {
		//调用 layout_op.jsp?opType=update,进行修改操作
		var chkPacket = new AJAXPacket("layout_op.jsp","正在执行,请稍后...");
	  	chkPacket.data.add("opType", "update");
	  	chkPacket.data.add("mCode", mCode.trim());
	  	chkPacket.data.add("mName", mName.trim());
	  	chkPacket.data.add("mShow", mShow.trim());
	 	core.ajax.sendPacket(chkPacket,doFunction,true);
	  	chkPacket = null; 
	}
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
       }else if(opType.trim()=="update"){
       		if(retCode=="000000"){                
	              rdShowMessageDialog("修改布局模板成功！",2);
	              window.opener.queryTemplate();
				  window.close();
	        }
       }else if(opType.trim()=="add"){
       		if(retCode=="000000"){                
	              rdShowMessageDialog("新增布局模板成功！",2);
				  window.opener.queryTemplate();
				  window.close(); 
	        }
       }
   }


</script> 
</body>
</html>