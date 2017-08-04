<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp"%>

<%
	String opCode = request.getParameter("opCode");
	opCode = (opCode==null||"".equals(opCode))?"e489":opCode;
	String opName = request.getParameter("opName");
	opName = (opName==null||"".equals(opName))?"内容管理":opName;
	
	String  powerCode = session.getAttribute("powerCode")==null?"":((String)session.getAttribute("powerCode")).trim();//角色代码

	String orgCode =  (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String workNo = (String)session.getAttribute("workNo");
	
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
		function addContent(){
			var path = "content_add.jsp";
			var retInfo = window.open(path,"","dialogWidth:45;dialogHeight:35;");			 
		}
			
		//查询
		function queryContent(){
			document.qrycontentFrm.submit();
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
       				queryContent();
       			}else{
       				rdShowMessageDialog("删除失败!<br>错误代码："+retCode+"<br>错误信息："+retMsg,0);
       				return false;
       			}
       			
       	   }
       }
       

		//编辑
		function editContent(content_seq){
			var path = "content_add.jsp?content_seq="+content_seq;
			var retInfo = window.open(path,"","dialogWidth:45;dialogHeight:35;");			 
		}
		
		//删除
		function delContent(tempId){
			if(rdShowConfirmDialog("确认要删除吗？")==1)
       		{
				var delPacket = new AJAXPacket("content_op.jsp","正在执行,请稍后...");
		      	delPacket.data.add("opType", "delete");
		      	delPacket.data.add("content_seq", tempId);
		      	core.ajax.sendPacket(delPacket,doProcess,true);
		      	delPacket = null; 
		    }
			
		}
		

	</script>
	<body>
		
		<form name="qrycontentFrm" action="content_main.jsp" method=post>
			<%@ include file="/npage/include/header_mop.jsp"%>
			
					<div class="title"> 
							<div id="title_zi">
								内容查询
							</div>
					</div>
						<table cellspacing="0">
							<tr>
								
								<td class="blue">内容名称</td>
								<td class="blue"><input type="text" v_must=1 v_type="string" v_maxlength="20" name="content_name" id="content_name"/></td>
								<td class="blue">工作台角色&nbsp;</td>
								<td class="blue">
									<input type="text"  name="mrole" id="mrole"/>
								</td>
							</tr>
							<tr>
								
								<td class="blue">是否发布</td>
								<td class="blue" colspan=3>
									<select id="is_effect" name="is_effect">
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
							</tr>
							<tr>
								<td class="blue" colspan="4" style="text-align:center">
									<input type="button" class="b_foot" value="查询" onclick="queryContent()" />
									<input type="button" class="b_foot" value="新增" onclick="addContent()" />
								</td>
							</tr>
						</table>
					</div>
					
					<div id="Operation_Table">
						<div class="title">
							<div id="title_zi">
								内容信息列表
							</div>
						</div>
						<table id="mTable" cellspacing="0">
							<tr>
								 
								<th>
									内容ID
								</th>
								<th>
									内容名称
								</th>
								<th>
									内容样式
								</th>
								<th>
									详细信息
								</th>
								<th>
									是否发布
								</th>
								<th>
									版本号
								</th>
								<th>
									工作台角色
								</th>
								<th>
									操作
								</th>
							</tr>
							<%
								//点击查询时，获取提交的值，然后进行过滤查询
								String content_id = request.getParameter("content_id")==null?"":((String)request.getParameter("content_id")).trim();
								String content_name = request.getParameter("content_name")==null?"":(request.getParameter("content_name")).trim();
								String con_type = request.getParameter("con_type")==null?"":(request.getParameter("con_type")).trim();
								String is_effect = request.getParameter("is_effect")==null?"":(request.getParameter("is_effect")).trim();
								String mRole = request.getParameter("mrole")==null?"":(request.getParameter("mrole")).trim();
								
								String sql = "select to_char(seq),content_type,content_id,content_name,content_detail,is_effect,version,to_char(op_time,'yyyy-mm-dd hh24:mi:ss') ,content_cls,op_roleid from dcontentmsg where op_roleid like '%"+mRole+"%'   and ";
								if(!"".equals(content_id)){
									sql +=" content_id='"+content_id.trim() +"' and ";
								}
								if(!"".equals(content_name)){
									sql += " content_name like '%"+content_name.trim()+"%' and ";
								}
								
								
								if(!"".equals(is_effect)){
									sql +=" is_effect='"+is_effect+"' and ";
								}
								sql+=" 1=1 order by op_roleid desc";
								//out.println(sql);
								
							%>
								
							<wtc:service name="TlsPubSelCrm" outnum="10" routerKey="region" routerValue="<%=regionCode %>">
								<wtc:param value="<%=sql%>" />
							</wtc:service>
							<wtc:array id="contentList" scope="end"/>
							<%			
							
							if("000000".equals(retCode)){ 
								String idStr = "";
								for(int i=0;i<contentList.length;i++){
										String con_type_name = "";
										String conCls = "";
										if(contentList[i][8].trim().equals("")){
											conCls = "无";
										}else{
											conCls = contentList[i][8];
										}
										idStr = contentList[i][2].trim();
										if(idStr.equals("p_busiguide")){
											idStr = "业务向导 ";
										}else if(idStr.equals("p_privset")){
											idStr = "全部功能 ";
										}else if(idStr.equals("p_callUserInfo")){
											idStr = "用户信息 ";
										}else if(idStr.equals("p_sysmenu")){
											idStr = "系统菜单 ";
										}else if(idStr.equals("p_commfunc")){
											idStr = "常用功能 ";
										}
									%>
									<tr>
										<td class='blue'><%=idStr%></td>
										
										<td class='blue'><%=contentList[i][3]%></td>
										<td class='blue'><%=conCls%></td>
										<td class='blue'><%=contentList[i][4]%></td>
										<td class='blue'><%="1".equals(contentList[i][5])?"是":"否"%></td>
										<td class='blue'><%=contentList[i][6]%></td>
										<td class='blue'><%=contentList[i][9]%></td>
										<td class='blue'>
											<img src='<%=request.getContextPath()%>/images/ico_edit.gif'  onclick="editContent('<%=contentList[i][0]%>')" style='cursor:hand' alt='修改'/>&nbsp;&nbsp;&nbsp;
	               							<img src='<%=request.getContextPath()%>/images/ico_delete.gif'  style='cursor:hand' alt='删除' onclick="delContent('<%=contentList[i][0]%>')"/>
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
