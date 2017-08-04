<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp"%>

<%
	String opCode = request.getParameter("opCode");
	opCode = (opCode==null||"".equals(opCode))?"8207":opCode;
	String opName = request.getParameter("opName");
	opName = (opName==null||"".equals(opName))?"业务向导管理":opName;
	
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
	$("select").width("150");
	$("input[type='text']").width("150");
});
	
		//新增模板
		function addTemp(){
				var path = "template_add.jsp";
				var retInfo = window.showModalDialog(path,"","dialogWidth:45;dialogHeight:35;");			 
		}
		
		
		//模板管理
		function tempManage(){
				var path = "template_manage.jsp";
				var retInfo = window.showModalDialog(path,"","dialogWidth:45;dialogHeight:35;");			
		}
		//查询
		function queryTemp(){
			document.qryTempFrm.submit();
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
       				queryTemp();
       			}else{
       				rdShowMessageDialog("删除失败!<br>错误代码："+retCode+"<br>错误信息："+retMsg,0);
       				return false;
       			}
       			
       	   }
       }
       

		//编辑
		function editTemp(template_id){
			var path = "template_add.jsp?template_id="+template_id;
			var retInfo = window.showModalDialog(path,"","dialogWidth:45;dialogHeight:35;");			 
			if(typeof(retInfo)=="undefined")      
    		{   
    			return false;   
    		}
    		if(retInfo){//返回成功结果，重新查询页面
    			queryTemp();
    		}
		}
		
		//删除
		function delTemp(tempId){
			if(rdShowConfirmDialog("删除模板会把对应步骤删除，确认要删除吗？")==1)
      {
						var delPacket = new AJAXPacket("template_op.jsp","正在执行,请稍后...");
		      	delPacket.data.add("opType", "delete");
		      	delPacket.data.add("template_id", tempId);
		      	core.ajax.sendPacket(delPacket,doProcess,true);
		      	delPacket = null; 
		  }
			
		}
		
		function showStep(template_id){
				var path = "busiguide_showstep.jsp?template_id="+template_id;
				//alert(path);
				//window.open(path);
				var retInfo = window.showModalDialog(path,"","dialogWidth:15;dialogHeight:25;");	
		}
	</script>
	<body>
		
		<form name="qryTempFrm" action="template_manage.jsp" method=post>
				<%@ include file="/npage/include/header_pop.jsp" %>
			
					<div class="title"> 
							<div id="title_zi">
								业务向导模板查询
							</div>
					</div>
						<table cellspacing="0">
							<tr>
								<td class="blue">模板ID</td>
								<td class="blue"><input type="text"  name="temp_id" id="temp_id"/></td>
								<td class="blue">模板名称</td>
								<td class="blue"><input type="text" name="temp_name" id="temp_name"/></td>
							</tr>
							<tr>
								<td class="blue" colspan="4" style="text-align:center">
									<input type="button" class="b_foot" value="查询" onclick="queryTemp()" />	
									<input type="button" class="b_foot" value="新增模板" onclick="addTemp()" />
								</td>
							</tr>
						</table>
					</div>
					
					<div id="Operation_Table">
						<div class="title">
							<div id="title_zi">
								向导模板列表（双击预览步骤）
							</div>
						</div>
						<table id="mTable" cellspacing="0">
							<tr>
								<th>
									模板ID
								</th>
								<th>
									模板名称
								</th>
								<th>
									步骤总数
								</th>
								<th>
									操作
								</th>
							</tr>
							<%
								//点击查询时，获取提交的值，然后进行过滤查询
								String temp_id = request.getParameter("temp_id")==null?"":((String)request.getParameter("temp_id")).trim();
								String temp_name = request.getParameter("temp_name")==null?"":(request.getParameter("temp_name")).trim();
																
								String sql = " select a.template_id,a.template_name,(select to_char(count(*)) from  dbusiguidetemp where template_id=a.template_id) stepcount from  dbusiguidetemp a where ";
								if(!"".equals(temp_id)){
									sql +=" a.template_id='"+temp_id.trim() +"' and ";
								}
								if(!"".equals(temp_name)){
									sql += " a.template_name like '%"+temp_name.trim()+"%' and ";
								}
	
								sql+=" 1=1 group by a.template_id,a.template_name ";
								System.out.println(sql);
								
							%>
								
							<wtc:service name="TlsPubSelCrm" outnum="3" routerKey="region" routerValue="<%=regionCode %>">
								<wtc:param value="<%=sql%>" />
							</wtc:service>
							<wtc:array id="templateList" scope="end"/>
							<%			
							System.out.println("---------"+retCode);
							if("000000".equals(retCode)){ 
								for(int i=0;i<templateList.length;i++){
									%>
									<tr ondblclick="showStep('<%=templateList[i][0]%>')" style="cursor: pointer;">
										<td class='blue'><%=templateList[i][0]%></td>
										<td class='blue'><%=templateList[i][1]%></td>
										<td class='blue'><%=templateList[i][2]%></td>
										<td class='blue'>
											<img src='<%=request.getContextPath()%>/images/ico_edit.gif'  onclick="editTemp('<%=templateList[i][0]%>')" style='cursor:hand' alt='修改'/>&nbsp;&nbsp;&nbsp;
	               							<img src='<%=request.getContextPath()%>/images/ico_delete.gif'  style='cursor:hand' alt='删除' onclick="delTemp('<%=templateList[i][0]%>')"/>
	               						</td>
	               					</tr>	
									<%
								}
							}
							%>		
						
						</table>					
					
				<%@ include file="/npage/include/footer_pop.jsp" %>
		</form>
	</body>
</html>
