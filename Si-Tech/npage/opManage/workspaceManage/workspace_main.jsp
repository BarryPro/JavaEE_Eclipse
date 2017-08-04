<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp"%>

<%
	String opCode = request.getParameter("opCode");
	opCode = (opCode==null||"".equals(opCode))?"e486":opCode;
	String opName = request.getParameter("opName");
	opName = (opName==null||"".equals(opName))?"工作区管理":opName;
	
	
	String  powerCode = session.getAttribute("powerCode")==null?"":((String)session.getAttribute("powerCode")).trim();//角色代码

	String orgCode =  (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	 
	%>

	<head>
		<title><%=opName%></title>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	</head>
	
	<script>
$(document).ready(function(){
	$("select").width("50");
	$("#wShow").width("150");
	$("input[type='text']").width("150");
	$("#wCode").focus();
	
});
		function addTemplate(){
			var path = "workspace_add.jsp";
			var retInfo = window.open(path,"","dialogWidth:45;dialogHeight:35;");			 
			 
		}
			
		//查询
		function queryTemplate(){
			document.qryworkspaceFrm.submit();
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
       	   
       	   
       	   
	       
       }
       
        //角色管理
	    function roleManage(){
	    	var path = "workspace_role.jsp";	
	    	//window.open(path);
				window.open(path,"","dialogWidth:55;dialogHeight:40;scroll:no;");
		}
		
		//编辑
		function editTemp(workspace_id){
			var path = "workspace_add.jsp?workspace_id="+workspace_id;
			var retInfo = window.open(path,"","dialogWidth:45;dialogHeight:35;");			 
			 
		}
		
		//删除
		function delTemp(tempId,mRole){
		
			if(rdShowConfirmDialog("确认要删除当前模块吗？")==1)
       		{
				var delPacket = new AJAXPacket("workspace_op.jsp","正在执行,请稍后...");
		      	delPacket.data.add("opType", "delete");
		      	delPacket.data.add("wCode", tempId);
		      	delPacket.data.add("mRole", mRole);
		      	core.ajax.sendPacket(delPacket,doProcess,true);
		      	delPacket = null; 
		    }
			
		}
		
	function delTempMod(layoutId){
			if(rdShowConfirmDialog("确认要删除布局模板吗？")==1)
	       		{
					var delPacket = new AJAXPacket("/npage/opManage/delModCfm.jsp","正在执行,请稍后...");
			      	delPacket.data.add("layoutId", layoutId);
			      	delPacket.data.add("delType", "w");
			      	core.ajax.sendPacket(delPacket,doDelTempMod,true);
			      	delPacket = null; 
			    }
		}
		
		function doDelTempMod(packet){
	       var retCode = packet.data.findValueByName("code"); 
	       var retMsg = packet.data.findValueByName("msg"); 
	       if(retCode=="000000"){
       				rdShowMessageDialog("删除成功！",2);
       				location=location;
       			}else{
       				rdShowMessageDialog("删除失败!<br>错误代码："+retCode+"<br>错误信息："+retMsg,0);
       				return false;
       			}
		}
function setThis(bt){
	$(bt).removeClass("InputGrey");
	$(bt).attr("readOnly","");
}		

var bt1 = ""; 
function saveThisUpd(bt,divid,roleid,oldOrder){
	var thisVal = $(bt).val();
	//alert("divid|"+divid+"\nroleid|"+roleid+"\nthisVal|"+thisVal);
	var mm = /^\d+$/;
	if(!mm.test(thisVal)){
		rdShowMessageDialog("排序代码只能输入数字，请重新输入");
		$(bt).val("");
		$(bt).focus();
		return;
	}else{
		if(oldOrder==thisVal){//数据没变
			$(bt).addClass("InputGrey");
			$(bt).attr("readOnly","readOnly");
			return;
		}
		var saveUpdPacket = new AJAXPacket("setOrderId.jsp","正在执行,请稍后...");
		    saveUpdPacket.data.add("divid", divid);
		    saveUpdPacket.data.add("roleid", roleid);
		    saveUpdPacket.data.add("orderid", thisVal);
		    core.ajax.sendPacket(saveUpdPacket,doSaveThisUpd);
		    delPacket = null; 
		    bt1 = bt;
		
	}
}
function doSaveThisUpd(packet){
	var retCode = packet.data.findValueByName("retCode"); 
	var retMsg = packet.data.findValueByName("retMsg"); 
	//alert("retCode|"+retCode+"\nretMsg|"+retMsg);
	if(retCode=="000000"){
		queryTemplate();
	}else{
		rdShowMessageDialog("修改排序代码出错，"+retCode+"："+retMsg,0);
		$(bt1).val("");
		$(bt1).focus();
		bt1 = "";
	}
}
	</script>
	<body>
		
		<form name="qryworkspaceFrm" action="workspace_main.jsp" method=post>
			<%@ include file="/npage/include/header_mop.jsp"%>
			
					<div class="title"> 
							<div id="title_zi">
								模块查询
							</div>
					</div>
						<table cellspacing="0">
							<tr>
								<td class="blue">模块编号</td>
								<td class="blue"><input type="text"  v_must=1 v_type="string" v_maxlength="20" name="wCode" id="wCode"/></td>
								<td class="blue">模块名称</td>
								<td class="blue"><input type="text" v_must=1 v_type="string" v_maxlength="20" name="wName" id="wName"/></td>
							</tr>
							<tr>
								<td class="blue">是否启用</td>
								<td class="blue">
									<select id="wShow" name="wShow">
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
									<input type="button" class="b_foot" value="新增" onclick="addTemplate()" />
								</td>
							</tr>
						</table>
					</div>
					<div id="Operation_Table">
					<div class="title">
							<div id="title_zi">
								工作区模块列表
							</div>
						</div>
						
						<table cellspacing="0" >
							<th width="20%">
									主题模板编号
								</th>
								<th width="20%">
									主题模板名称
								</th>
								<th width="20%">
									是否发布
								</th>
								<th width="20%">
									模块路径
								</th>
								<th width="20%">
									操作
								</th>
	<%
	String qrySql = "select wkspace_id,wkspace_name,IS_EFFECT,wkspace_src from dwkspacemsg where ";
	String wCode = request.getParameter("wCode")==null?"":((String)request.getParameter("wCode")).trim();
	String wName = request.getParameter("wName")==null?"":(request.getParameter("wName")).trim();
	String wShow = request.getParameter("wShow")==null?"":(request.getParameter("wShow")).trim();
	if(!"".equals(wCode)){
		qrySql +=" wkspace_id='"+wCode+"' and ";
	}
	if(!"".equals(wName)){
		qrySql +=" wkspace_name like '%"+wName+"%' and ";
	}
	if(!"".equals(wShow)){
		qrySql +=" IS_EFFECT='"+wShow+"' and ";
	}
	qrySql += "1=1";
	%>							
	<wtc:pubselect name="sPubSelect" outnum="4" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  		<wtc:sql><%=qrySql%></wtc:sql>
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
					<div id="Operation_Table">
						<div class="title">
							<div id="title_zi">
								工作台角色模块列表
							</div>
						</div>
						<table id="mTable" cellspacing="0">
							<tr>
								<th width="5%">
									模块编号
								</th>
								<th width="20%">
									模块名称
								</th>
								<th width="20%">
									模块路径
								</th>
								<th width="10%">
									工作台角色
								</th>
								<th width="10%">
									模块长度
								</th>
								
								<th width="10%">
									位置
								</th>
								  
								<th  >
									操作
								</th>
							</tr>
							<%
								//点击查询时，获取提交的值，然后进行过滤查询
								String sql = "select a.wkspace_id, a.wkspace_name, a.wkspace_src,a.is_effect, b.order_id ,b.op_role,b.WKSPACE_LEN from dwkspacemsg a, dwkspacerole_rel b where a.is_effect='1' and ";
								 
								sql+=" a.wkspace_id = b.wkspace_id  and b.op_role!='XXXXXX'  order by  b.op_role ,b.ORDER_ID ";

							%>
								
							<wtc:service name="TlsPubSelCrm" outnum="7" routerKey="region" routerValue="<%=regionCode %>">
								<wtc:param value="<%=sql%>" />
							</wtc:service>
							<wtc:array id="workspaceList" scope="end"/>
							<%			

							if("000000".equals(retCode)){ 
							String tempStr = "";
								for(int i=0;i<workspaceList.length;i++){
									if(workspaceList[i][6].trim().equals("1")){
										tempStr = "半长";
									}else{
										tempStr = "全长";
									}
									%>
									<tr>
										<td class='blue'><%=workspaceList[i][0]%>&nbsp;</td>
										<td class='blue'><%=workspaceList[i][1]%>&nbsp;</td>
										<td class='blue'><%=workspaceList[i][2]%>&nbsp;</td>
										<td class='blue'><%=workspaceList[i][5]%>&nbsp;</td>
										 <td class='blue'><%=tempStr%>&nbsp;</td>
										 <td class='blue'>
										 	<input type="text" value="<%=workspaceList[i][4]%>" class="InputGrey" readOnly
										 	size="2" onclick="setThis(this)" 
										 	maxlength="2"
										 			 onblur="saveThisUpd(this,'<%=workspaceList[i][0]%>','<%=workspaceList[i][5]%>','<%=workspaceList[i][4]%>')">&nbsp;
										 </td>
										<td class='blue'>
	               			<img src='<%=request.getContextPath()%>/images/ico_delete.gif'  style='cursor:hand' alt='删除' onclick="delTemp('<%=workspaceList[i][0]%>','<%=workspaceList[i][5]%>')"/>
	               		</td>
	               	</tr>	
									<%
								}
							}
							%>		
						
						</table>					
					
			<%@ include file="/npage/include/footer.jsp"%>
		</form>
	</body>
</html>
