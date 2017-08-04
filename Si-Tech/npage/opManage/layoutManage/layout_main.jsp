<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp"%>

<%
	String opCode = request.getParameter("opCode");
	opCode = (opCode==null||"".equals(opCode))?"e484":opCode;
	String opName = request.getParameter("opName");
	opName = (opName==null||"".equals(opName))?"布局管理":opName;
	String  powerCode = session.getAttribute("powerCode")==null?"":((String)session.getAttribute("powerCode")).trim();//角色代码
	String regionCode = (String)session.getAttribute("regCode");
 %>
	<head>
		<title><%=opName%></title>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	</head>
	
	
	<body>
		
		<form name="qryLayoutFrm" action="layout_main.jsp" method=post>
			<%@ include file="/npage/include/header_mop.jsp"%>
			
					<div class="title"> 
							<div id="title_zi">
								布局模板查询
							</div>
					</div>
						<table cellspacing="0">
							<tr>
								<td class="blue">布局模板编号</td>
								<td class="blue"><input type="text"  v_must=1 v_type="string" v_maxlength="20" name="mCode" id="mCode"/></td>
								<td class="blue">布局模板名称</td>
								<td class="blue"><input type="text" v_must=1 v_type="string" v_maxlength="20" name="mName" id="mName"/></td>
							</tr>
							<tr>
								<td class="blue">是否发布</td>
								<td class="blue">
									<select id="mShow" name="mShow">
										<option value="" selected>
											请选择
										</option>
										<option value="0" >
											否
										</option>
										<option value="1">
											是
										</option>
									</select>
								</td>
								<td class="blue">&nbsp;</td>
								<td class="blue">
									&nbsp;</td>
							</tr>
							<tr>
								<td class="blue" colspan="4" style="text-align:center">
									<input type="button" class="b_foot" value="查询" onclick="queryTemplate()" />
									<input type="button" class="b_foot" value="新增模板" onclick="addTemplate()" />
									<input type="button" class="b_foot_long"  value="角色权限管理" onclick="roleManage()" />
								</td>
							</tr>
						</table>
					</div>
					<div id="Operation_Table">
					<div class="title">
							<div id="title_zi">
								布局模板列表
							</div>
						</div>
						
						<table cellspacing="0" >
							<th width="20%">
									布局模板编号
								</th>
								<th width="20%">
									布局模板名称
								</th>
								<th width="20%">
									是否发布
								</th>
								<th width="20%">
									版本号
								</th>
								<th width="20%">
									操作
								</th>
	<%
	String querySql = "select layout_model_id,layout_model_NAME,IS_EFFECT,VERSION from DLAYOUTmodel where ";
	String mCode = request.getParameter("mCode")==null?"":(request.getParameter("mCode")).trim();
	String mShow = request.getParameter("mShow")==null?"":(request.getParameter("mShow")).trim();
	String mName = request.getParameter("mName")==null?"":(request.getParameter("mName")).trim();
	
	if(!"".equals(mCode)){
		querySql +=" layout_model_id='"+mCode+"' and ";
	}
	if(!"".equals(mName)){
		querySql +=" layout_model_NAME like '%"+mName+"%' and ";
	}
	if(!"".equals(mShow)){
		querySql +=" IS_EFFECT='"+mShow+"' and ";
	}
	querySql += "1=1";
	%>
	<wtc:pubselect name="sPubSelect" outnum="4" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  		<wtc:sql><%=querySql%></wtc:sql>
 		</wtc:pubselect>
	<wtc:array id="result_th" scope="end"/>
		
		<%
		String outStr = "";
		for(int ih=0;ih<result_th.length;ih++){
		 	outStr += "<tr>";
			outStr += "<td class='blue'>"+result_th[ih][0]+"</td>";
			outStr += "<td class='blue'>"+result_th[ih][1]+"</td>";
			outStr += "<td class='blue'>"+("0".equals(result_th[ih][2])?"否":"是")+"</td>";
			outStr += "<td class='blue'>"+result_th[ih][3]+"</td>";
			outStr += "<td><img src='/images/ico_edit.gif'    onclick=\"editTemp('"+result_th[ih][0]+"')\" style='cursor:hand' alt='修改'/>&nbsp;&nbsp;&nbsp;"+
	               		  "<img src='/images/ico_delete.gif'  style='cursor:hand' alt='删除' onclick=\"delTempMod('"+result_th[ih][0]+"')\"/>"+
						"</td>";
		 	outStr += "</tr>";
		}
		 
		 out.print(outStr);
		%>
						</table>
					</div>
					 
			<%@ include file="/npage/include/footer.jsp"%>
		</form>
		<script>
		$(document).ready(function(){
			$("select").width("50");
	$("#mShow").width("150");
	$("input[type='text']").width("150");
	$("#mCode").focus();
});
		function addTemplate(){
			parent.showBusiGuideStep("e484",1);
			var path = "layout_addNew.jsp";
			var retInfo = window.open(path,"","dialogWidth:45;dialogHeight:40;");			 
			 
		}
		function editTemp(modelId){
			var path = "layout_updNew.jsp?modelId="+modelId;
			var retInfo = window.open(path,"","dialogWidth:45;dialogHeight:40;");	
		}	
		//查询
		function queryTemplate(){
			document.qryLayoutFrm.submit();
		}
		
		function doProcess(packet)      
 		{
	       var opType = packet.data.findValueByName("opType"); 
	       var retCode = packet.data.findValueByName("retCode"); 
	       var retMsg = packet.data.findValueByName("retMsg"); 
	       var tempInfos = packet.data.findValueByName("tempInfos"); 
	      
	       if(opType=="delete"){
       			if(retCode=="000000"){
       				rdShowMessageDialog("删除成功！",2);
       				queryTemplate();
       			}else{
       				rdShowMessageDialog("删除失败!<br>错误代码："+retCode+"<br>错误信息："+retMsg,0);
       				return false;
       			}
       			
       	   }
       	   
       	    if(opType=="updlen"){
       			if(retCode=="000000"){
       				rdShowMessageDialog("修改成功！",2);
       				queryTemplate();
       			}else{
       				rdShowMessageDialog("修改失败!<br>错误代码："+retCode+"<br>错误信息："+retMsg,0);
       				return false;
       			}
       	   }
       }
       
        //角色管理
	    function roleManage(){
	    	var path = "layout_role.jsp";	
			window.open(path,"","dialogWidth:55;dialogHeight:40;scroll:no;");
		}
		
		function modelManage(){
			var path = "modelManage.jsp";	
			window.open(path,"","dialogWidth:55;dialogHeight:40;scroll:no;");
		}
		
	 
		
		//删除
		function delTemp(tempId,mRole,isDefault){
				if(rdShowConfirmDialog("确认要删除工作台角色布局吗？")==1)
	       		{
					var delPacket = new AJAXPacket("layout_op.jsp","正在执行,请稍后...");
			      	delPacket.data.add("opType", "delete");
			      	delPacket.data.add("mCode", tempId);
			      	delPacket.data.add("mRole", mRole);
			      	core.ajax.sendPacket(delPacket,doProcess,true);
			      	delPacket = null; 
			    }
		}
		
		function delTempMod(layoutId){
			//alert("layoutId|"+layoutId);
			if(rdShowConfirmDialog("确认要删除布局模板吗？")==1)
	       		{
					var delPacket = new AJAXPacket("delModelCfm.jsp","正在执行,请稍后...");
			      	delPacket.data.add("modeid", layoutId);
			      	core.ajax.sendPacket(delPacket,doDelTempMod);
			      	delPacket = null; 
			    }
		}
		function doDelTempMod(packet){
	       var retCode = packet.data.findValueByName("retCode"); 
	       var retMsg = packet.data.findValueByName("retMsg"); 
	       if(retCode=="000000"){
       				rdShowMessageDialog("删除成功！",2);
       				location=location;
       			}else{
       				rdShowMessageDialog("修改失败!<br>错误代码："+retCode+"<br>错误信息："+retMsg,0);
       				return false;
       			}
		}
  
	</script>
	</body>
</html>
