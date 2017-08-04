<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp"%>

<%
	String opCode = request.getParameter("opCode");
	opCode = (opCode==null||"".equals(opCode))?"e491":opCode;
	String opName = request.getParameter("opName");
	opName = (opName==null||"".equals(opName))?"页面导航管理":opName;
	
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
		function addNav(){
			var path = "funcnav_add.jsp";
			var retInfo = window.open(path,"","dialogWidth:45;dialogHeight:35;");			 
			 
		}
			
		//查询
		function queryNav(){
			document.qryfuncnavFrm.submit();
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
       				queryNav();
       			}else{
       				rdShowMessageDialog("删除失败!<br>错误代码："+retCode+"<br>错误信息："+retMsg,0);
       				return false;
       			}
       			
       	   }
       }
       

		//编辑
		function editFuncnav(funcnav_seq){
			var path = "funcnav_add.jsp?funcnav_seq="+funcnav_seq;
			var retInfo = window.open(path,"","dialogWidth:45;dialogHeight:35;");			 
		 
		}
		
		//删除
		function delFuncnav(function_seq){
			if(rdShowConfirmDialog("确认要删除吗？")==1)
       		{
				var delPacket = new AJAXPacket("funcnav_op.jsp","正在执行,请稍后...");
		      	delPacket.data.add("opType", "delete");
		      	delPacket.data.add("function_seq", function_seq);
		      	core.ajax.sendPacket(delPacket,doProcess,true);
		      	delPacket = null; 
		    }
			
		}
		

	</script>
	<body>
		
		<form name="qryfuncnavFrm" action="funcnav_main.jsp" method=post>
			<%@ include file="/npage/include/header_mop.jsp"%>
			
					<div class="title"> 
							<div id="title_zi">
								页面导航管理
							</div>
					</div>
						<table cellspacing="0">
							<tr>
								<td class="blue">功能编码</td>
								<td class="blue"><input type="text" name="functionCode" id="functionCode"/></td>
								<td class="blue">功能名称</td>
								<td class="blue"><input type="text" name="functionName" id="functionName"/></td>
							</tr>
							<tr>
								<td class="blue">是否启用</td>
								<td class="blue">
									<select id="is_use" name="is_use">
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
								<td>&nbsp;</td>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td class="blue" colspan="4" style="text-align:center">
									<input type="button" class="b_foot" value="查 询" onclick="queryNav()" />
									<input type="button" class="b_foot" value="新 增" onclick="addNav()" />
								</td>
							</tr>
						</table>
					</div>
					
					<div id="Operation_Table">
						<div class="title">
							<div id="title_zi">
								页面导航信息列表
							</div>
						</div>
						<table id="mTable" cellspacing="0">
							<tr>
								<th>
									功能编码
								</th>
								<th>
									业务名称
								</th>
								<th>
									导航路径
								</th>
								<th>
									是否启用
								</th>
								<th>
									操作
								</th>
							</tr>
							<%
								//点击查询时，获取提交的值，然后进行过滤查询
								String functionCode = request.getParameter("functionCode")==null?"":((String)request.getParameter("functionCode")).trim();
								String functionName = request.getParameter("functionName")==null?"":((String)request.getParameter("functionName")).trim();
								String is_use = request.getParameter("is_use")==null?"":(request.getParameter("is_use")).trim();
								
								String sql = " select to_char(a.nav_seq),a.function_code,b.function_name,a.nav_path,a.is_use,to_char(a.op_time,'yyyy-mm-ss hh24:mi:ss') from dfuncnavmsg a ,sfunccodenew b where  ";
								if(!"".equals(functionCode)){
									sql +=" a.function_code='"+functionCode.trim() +"' and ";
								}
								if(!"".equals(functionName)){
									sql +=" b.function_name like '%"+functionName+"%' and ";
								}
								if(!"".equals(is_use)){
									sql +=" a.is_use='"+is_use+"' and ";
								}
								sql+=" a.function_code=b.function_code  ";
								System.out.println(sql);
								
							%>
								
							<wtc:service name="TlsPubSelCrm" outnum="6" routerKey="region" routerValue="<%=regionCode %>">
								<wtc:param value="<%=sql%>" />
							</wtc:service>
							<wtc:array id="funcnavList" scope="end"/>
							<%			
							
							if("000000".equals(retCode)){ 
								for(int i=0;i<funcnavList.length;i++){
									%>
									<tr>
										<td class='blue'><%=funcnavList[i][1]%></td>
										<td class='blue'><%=funcnavList[i][2]%></td>
										<td class='blue'><%=funcnavList[i][3]%></td>
										<td class='blue'><%="1".equals(funcnavList[i][4])?"是":"否"%></td>
										<td class='blue'>
											<img src='<%=request.getContextPath()%>/images/ico_edit.gif'  onclick="editFuncnav('<%=funcnavList[i][0]%>')" style='cursor:hand' alt='修改'/>&nbsp;&nbsp;&nbsp;
	               							<img src='<%=request.getContextPath()%>/images/ico_delete.gif'  style='cursor:hand' alt='删除' onclick="delFuncnav('<%=funcnavList[i][0]%>')"/>
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
