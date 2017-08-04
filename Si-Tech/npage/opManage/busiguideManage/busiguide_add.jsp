<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<head>
<%
	String opName="新增业务向导";
	String busiguide_seq = request.getParameter("busiguide_seq")!=null?(String)request.getParameter("busiguide_seq"):"";
	String orgCode =  (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String guideCode = "";
	String tempName = "";
	String is_effect = "";
	String detail = "";
	if(!"".equals(busiguide_seq)){
		String sql = "select to_char(seq),op_code,template_id,detail,is_effect from dbusiguidemsg where seq=:busiguide_seq";
		String param = "busiguide_seq="+busiguide_seq;
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
			guideCode  = workspace[0][1];  
			tempName  = workspace[0][2];  
			detail   = workspace[0][3]; 
			is_effect  = workspace[0][4];
		}
	}
%>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>新增业务向导</title>
	<script language="javascript" type="text/javascript" src="/njs/si/autocomplete.js"></script>
	<script language="javascript" type="text/javascript" src="/njs/si/common.js"></script>
</head>
<body  ONKEYDOWN="CHECKKEY()">
<form method="post" name="frm">

	<%@ include file="/npage/include/header_pop.jsp" %>
			<div id="mInput">
				<div class="title">
					<div id="title_zi">添加业务向导</div>
				</div>
				<div class="input">
					<table cellspacing="0">
						<tr>
							<td class="blue">关联业务</td>
							<td class="blue">
								<input type="text" v_must=1 v_type="string" v_maxlength="5" id="guideCode" name="guideCode" value="" onchange="doCheck()"/>
								<!--<input type='text' id='tb' onFocus="clearQuickNav()"  style='font-family:verdana;width:120px;font-size:12px'  value=''/> 
						  		<input type='hidden' id='tb_h'    value='-1'/>
						  		<input type='hidden' id='guideCode'  name='function_code'  value=""/> -->
								<font class="orange">*</font>
								<span id="checkMsg" style="color:orange"></span>
							</td>
							<td class="blue">向导模板</td>
							<td class="blue">
								<select id="tempName" v_must=1 name="tempName" width=80>
								<option selected>请选择</option>
	             	<%
	             			String sqlStr ="select distinct template_id,template_name from dbusiguidetemp order by template_id "; 
	             	%>
							 	<wtc:qoption name="TlsPubSelCrm" outnum="2" routerKey="region" routerValue="<%=regionCode %>">
								 <wtc:sql><%=sqlStr%></wtc:sql>
							  </wtc:qoption>
             		</select>
								<font class="orange">*</font></td>
						</tr>
						<tr>
							<td class="blue">是否启用</td>
							<td class="blue">
							    <select id="is_effect">
										<option value="0">否</option>	
										<option value="1" selected>是</option>
								</select>
							</td>		
							<td class="blue">业务描述</td>	
							<td class="blue"><input type="text" id="detail"  v_must="1" v_type="string" v_maxlength="64" name="detail" value=""/><font class="orange">*</font></td>					
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
 	function CHECKKEY(){
 if (event.keyCode == 13 && event.ctrlKey)
 {
 	if(<%=busiguide_seq!=""%>){
 		doUpate();
 		}else{
 			doAdd();
 		}
 }
}
var ser;
var checkguideCode = false;
var retVal = "";//返回父页面的值
$(document).ready(function(){
	$("select").width("150");
	$("input[type='text']").width("150");
});
	
$(document).ready(function(){
	if(<%=busiguide_seq!=""%>){
		document.getElementById('guideCode').value ='<%=guideCode%>';
		document.getElementById('tempName').value ='<%=tempName%>';
		document.getElementById('is_effect').value ='<%=is_effect%>';
		document.getElementById('detail').value ='<%=detail%>';
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
		var guideCode = document.getElementById('guideCode').value;
		var tempName = document.getElementById('tempName').value;
  	var is_effect = document.getElementById('is_effect').value;
  	var detail = document.getElementById('detail').value;   
  	
  	if(tempName.trim().len()==0){
  		rdShowMessageDialog("请选择业务向导模板！",1);
			document.getElementById('tempName').focus();
			return false;
  	} 

	if(checkguideCode){//不存在返回true，则进行添加
			document.getElementById('add').disabled = "disabled";
			//调用 busiguide_op.jsp?opType=add,进行添加操作
			var addPacket = new AJAXPacket("busiguide_op.jsp","正在执行,请稍后...");
	  	addPacket.data.add("opType", "add");
	  	addPacket.data.add("guideCode", guideCode.trim());
	  	addPacket.data.add("tempName", tempName.trim());
	  	addPacket.data.add("detail", detail.trim());
	  	addPacket.data.add("is_effect", is_effect.trim());
	 		core.ajax.sendPacket(addPacket,doFunction,true);
	  	addPacket = null;  
	}else{
		rdShowMessageDialog("业务向导已经存在，请重新输入！",0);
		document.getElementById('guideCode').value="";
		document.getElementById('guideCode').focus();
		return false;
	}
	
}

    
//保存修改后的内容
function doUpate()
{
	if(!check(frm)){
			return false;
	}
	var guideCode = document.getElementById('guideCode').value;
	var tempName = document.getElementById('tempName').value;
	var is_effect = document.getElementById('is_effect').value;
	var detail = document.getElementById('detail').value;
    
  if(tempName.trim().len()==0){
  		rdShowMessageDialog("请选择业务向导模板！",1);
			document.getElementById('tempName').focus();
			return false;
  	} 


    if(rdShowConfirmDialog("确认要修改吗？")==1)
    {
    	document.getElementById('update').disabled = "disabled";
		//调用 workspace_op.jsp?opType=update,进行修改操作
		var updatePacket = new AJAXPacket("busiguide_op.jsp","正在执行,请稍后...");
	  	updatePacket.data.add("opType", "update");
	  	updatePacket.data.add("busiguide_seq", '<%=busiguide_seq%>');
	  	updatePacket.data.add("guideCode", guideCode.trim());
	  	updatePacket.data.add("tempName", tempName.trim());
	  	updatePacket.data.add("detail", detail.trim());
	  	updatePacket.data.add("is_effect", is_effect.trim());
	 	 core.ajax.sendPacket(updatePacket,doFunction,true);
	  	updatePacket = null; 
	}
}


function doCheck()//校验模板是否存在
{     
      var guideCode = document.getElementById('guideCode').value;
      <%if(!"".equals(busiguide_seq)){%>//若是修改
	   	if(guideCode!="<%=guideCode%>"){
	  	<%}%>
	    if(guideCode.trim().length > 0){
	      var chkPacket = new AJAXPacket("busiguide_op.jsp","正在验证,请稍后...");
	      chkPacket.data.add("opType", "check");
	      chkPacket.data.add("guideCode", guideCode.trim());
	      core.ajax.sendPacket(chkPacket,doFunction,false);
	      chkPacket = null; 
      }
      <%if(!"".equals(busiguide_seq)){%>//若是修改
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
	              checkguideCode = true;
	              $("#checkMsg").text("");
	          }else{
	          		checkguideCode = false;
	          		$("#checkMsg").text((document.getElementById('guideCode').value).trim()+"已经存在！");
	          }
	        }
       }else if(opType.trim()=="update"){
       		if(retCode=="000000"){                
	              rdShowMessageDialog("修改成功！",2);
				 		 		window.returnValue=true;
				  			window.close();
	        }else{
	        		rdShowMessageDialog("修改失败！",0);
	        		document.getElementById('update').disabled = "";
	        }
       }else if(opType.trim()=="add"){
       		if(retCode=="000000"){                
	              rdShowMessageDialog("新增成功！",2);
				  			window.returnValue=true;
				  			window.close(); 
	        }else{
	        		rdShowMessageDialog("新增失败！",0);
	        		document.getElementById('add').disabled = "";
	        }
       }
   }


 		/** 快速导航  begin **/
		var quickFlag = true;
		function clearQuickNav()
		{
	 		document.getElementById('tb').value="";
	 		qnav();
		}
	
	function qnav(){
		
		if(parent.parent.content_array==undefined)
		{
				parent.parent.document.getElementById('tb').focus();
				rdShowMessageDialog("请先激活快速转入功能!");
		}
		if(quickFlag&&parent.parent.content_array!=undefined)
		{
				firstFlag = false;
				quickFlag=false;
				op_array = parent.parent.op_array;
				content_array = parent.parent.content_array;
				var obj = actb(document.getElementById('tb'),document.getElementById('tb_h'),op_array);
		}

	}
	
	function quicknav(arr)
	{
		
	}
	/** 快速导航  end **/
</script> 
</body>
</html>