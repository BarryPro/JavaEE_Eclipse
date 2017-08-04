<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp"%>

<%
	String opCode = request.getParameter("opCode");
	opCode = (opCode==null||"".equals(opCode))?"e487":opCode;
	String opName = request.getParameter("opName");
	opName = (opName==null||"".equals(opName))?"工作区通讯管理":opName;
	
	String  powerCode = session.getAttribute("powerCode")==null?"":((String)session.getAttribute("powerCode")).trim();//角色代码

	String orgCode =  (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	
	
%>

	<head>
		<title><%=opName%></title>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	</head>
	
	<script>
		
		function addTemplate(){
			var path = "commun_add.jsp?opCode=<%=opCode%>";
			var retInfo = window.open(path,"","dialogWidth:45;dialogHeight:35;");			 
		}
			
		//查询
		function queryTemplate(){
			document.qrycommunFrm.submit();
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
       

		//编辑
		function editTemp(commun_seq){
			var path = "commun_add.jsp?opCode=<%=opCode%>&commun_seq="+commun_seq;
			var retInfo = window.open(path,"","dialogWidth:45;dialogHeight:35;");			 
			 
		}
		
		//删除
		function delTemp(tempId){
			if(rdShowConfirmDialog("确认要删除吗？")==1)
       		{
				var delPacket = new AJAXPacket("commun_op.jsp","正在执行,请稍后...");
		      	delPacket.data.add("opType", "delete");
		      	delPacket.data.add("wkSeq", tempId);
		      	core.ajax.sendPacket(delPacket,doProcess,true);
		      	delPacket = null; 
		    }
			
		}
		
$(document).ready(function(){
	$("select").width("150");
	$("input[type='text']").width("150");
	$("#wkCode").focus();
});
	</script>
	<body>
		
		<form name="qrycommunFrm" action="commun_main.jsp" method=post>
			<%@ include file="/npage/include/header_mop.jsp"%>
			
					<div class="title"> 
							<div id="title_zi">
								工作区通讯查询
							</div>
					</div>
						<table cellspacing="0">
							<tr>
								<td class="blue">工作区编码</td>
								<td class="blue"><input type="text"  v_must=1 v_type="string" v_maxlength="20" name="wkCode" id="wkCode"/></td>
								<td class="blue">工作区名称</td>
								<td class="blue"><input type="text" v_must=1 v_type="string" v_maxlength="20" name="wkName" id="wkName"/></td>
							</tr>
							<tr>
								<td class="blue">是否有效</td>
								<td class="blue">
									<select id="wkShow" name="wkShow">
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
								<td class="blue">&nbsp;</td>
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
								工作区通讯信息列表
							</div>
						</div>
						<table id="mTable" cellspacing="0">
							<tr>
								<th>
									工作区编号
								</th>
								<th>
									工作区名称
								</th>
								<th>
									通讯字段
								</th>
								<th>
									是否有效
								</th>
								<th>
									操作
								</th>
							</tr>
							<%
								//点击查询时，获取提交的值，然后进行过滤查询
								String wkCode = request.getParameter("wkCode")==null?"":((String)request.getParameter("wkCode")).trim();
								String wkName = request.getParameter("wkName")==null?"":(request.getParameter("wkName")).trim();
								String wkShow = request.getParameter("wkShow")==null?"":(request.getParameter("wkShow")).trim();
								System.out.println("----------------wkCode--------------"+wkCode);
								String sql = "select to_char(seq),wkspace_code,wkspace_name,field,is_effect from dcommunicate where ";
								if(!"".equals(wkCode)){
									sql +=" wkspace_code='"+wkCode.trim() +"' and ";
								}
								if(!"".equals(wkName)){
									sql += " wkspace_name like '%"+wkName.trim()+"%' and ";
								}
								if(!"".equals(wkShow)){
									sql +=" is_effect='"+wkShow+"' and ";
								}
								sql+=" 1 = 1 ";
								//out.println(sql);
								
							%>
								
							<wtc:service name="TlsPubSelCrm" outnum="5" routerKey="region" routerValue="<%=regionCode %>">
								<wtc:param value="<%=sql%>" />
							</wtc:service>
							<wtc:array id="communList" scope="end"/>
							<%			
							
							if("000000".equals(retCode)){ 
								for(int i=0;i<communList.length;i++){
									%>
									<tr>
										<td class='blue'><%=communList[i][1]%></td>
										<td class='blue'><%=communList[i][2]%></td>
										<td class='blue'><%=communList[i][3]%></td>
										<td class='blue'><%="1".equals(communList[i][4])?"是":"否"%></td>
										<td class='blue'>
											<img src='<%=request.getContextPath()%>/images/ico_edit.gif'  onclick="editTemp('<%=communList[i][0]%>')" style='cursor:hand' alt='修改'/>&nbsp;&nbsp;&nbsp;
	               							<img src='<%=request.getContextPath()%>/images/ico_delete.gif'  style='cursor:hand' alt='删除' onclick="delTemp('<%=communList[i][0]%>')"/>
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
