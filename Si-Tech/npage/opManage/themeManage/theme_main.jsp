<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp"%>

<%
	String opCode = request.getParameter("opCode");
	opCode = (opCode==null||"".equals(opCode))?"e485":opCode;
	String opName = request.getParameter("opName");
	opName = (opName==null||"".equals(opName))?"主题管理":opName;
	
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
			$("#tCode").focus();
	$("select").width("150");
	$("input[type='text']").width("150");
});
		function addTemplate(){
			var path = "theme_add.jsp";
			var retInfo = window.open(path,"","dialogWidth:45;dialogHeight:35;");			 
		}
			
		//查询
		function queryTemplate(){
			document.qrythemeFrm.submit();
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
	    	var path = "theme_role.jsp";	
	    	// window.open(path);
			window.open(path,"","dialogWidth:55;dialogHeight:40;scroll:no;");
		}
		
		//编辑
		function editTemp(theme_css){
			var path = "theme_add.jsp?theme_css="+theme_css;
			var retInfo = window.open(path,"","dialogWidth:45;dialogHeight:35;");			 
		}
		
		//删除
		function delTemp(tempId,mRole,isDefault){
				if(rdShowConfirmDialog("确认要删除主题模板吗？")==1)
	       		{
					var delPacket = new AJAXPacket("theme_op.jsp","正在执行,请稍后...");
			      	delPacket.data.add("opType", "delete");
			      	delPacket.data.add("tCode", tempId);
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
			      	delPacket.data.add("delType", "t");
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
	</script>
	<body>
		
		<form name="qrythemeFrm" action="theme_main.jsp" method=post>
			<%@ include file="/npage/include/header_mop.jsp"%>
			
					<div class="title"> 
							<div id="title_zi">
								主题查询
							</div>
					</div>
						<table cellspacing="0">
							<tr>
								<td class="blue">主题编号</td>
								<td class="blue"><input type="text"  v_must=1 v_type="string" v_maxlength="20" name="tCode" id="tCode"/></td>
								<td class="blue">主题名称</td>
								<td class="blue"><input type="text" v_must=1 v_type="string" v_maxlength="20" name="tName" id="tName"/></td>
							</tr>
							<tr>
								<td class="blue">是否发布</td>
								<td class="blue">
									<select id="tShow" name="tShow">
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
								<td class="blue">工作台角色</td>
								<td class="blue">
									<input type="text"  name="mrole" id="mrole"/></td>
							</tr>
							<tr>
								<td class="blue" colspan="4" style="text-align:center">
									<input type="button" class="b_foot" value="查询" onclick="queryTemplate()" />
									<input type="button" class="b_foot" value="新增" onclick="addTemplate()" />
									<input type="button" class="b_foot_long"  value="角色权限管理" onclick="roleManage()" />
								</td>
							</tr>
						</table>
					</div>
					<div id="Operation_Table">
					<div class="title">
							<div id="title_zi">
								主题模板列表
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
									版本号
								</th>
								<th width="20%">
									操作
								</th>
								<%
								String tCode = request.getParameter("tCode")==null?"":((String)request.getParameter("tCode")).trim();
								String tName = request.getParameter("tName")==null?"":(request.getParameter("tName")).trim();
								String tShow = request.getParameter("tShow")==null?"":(request.getParameter("tShow")).trim();
								String mrole = request.getParameter("mrole")==null?"":(request.getParameter("mrole")).trim();
								int  the = 0;
								String sqlTheMode = "select a.theme_css,a.theme_name,a.is_effect,a.version from dthememsg a where";
								if(!"".equals(tCode)){
									the++;
									sqlTheMode +=" a.theme_css='"+tCode +"' and ";
								}
								if(!"".equals(tName)){
									the++;
									sqlTheMode += " a.theme_name like '%"+tName+"%' and ";
								}
								if(!"".equals(tShow)){
									the++;
									sqlTheMode +=" a.is_effect='"+tShow+"' and ";
								}
								if(the==0){
									sqlTheMode = "select a.theme_css,a.theme_name,a.is_effect,a.version from dthememsg a ";
								}else{
									sqlTheMode +="1=1";
								}
								//out.println("-----------sqlTheMode---------------"+sqlTheMode);
								%>
								
	<wtc:pubselect name="sPubSelect" outnum="4" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  		<wtc:sql><%=sqlTheMode%></wtc:sql>
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
								工作台角色主题列表
							</div>
						</div>
						<table id="mTable" cellspacing="0">
							<tr>
								<th width="20%">
									主题编号
								</th>
								<th width="20%">
									主题名称
								</th>
								<th width="20%">
									工作台角色
								</th>
								 
								<th width="20%">
									是否默认
								</th>
								<th width="20%">
									操作
								</th>
							</tr>
							<%
								//点击查询时，获取提交的值，然后进行过滤查询
																
								String sql = "select a.theme_css, a.theme_name, a.is_effect, b.is_default ,b.op_role from dthememsg a, dthemerole_rel b where a.IS_EFFECT='1' and ";
								
								/*
								if(!"".equals(tCode)){
									sql +=" a.theme_css='"+tCode +"' and ";
								}
								if(!"".equals(tName)){
									sql += " a.theme_name like '%"+tName+"%' and ";
								}
								if(!"".equals(tShow)){
									sql +=" a.is_effect='"+tShow+"' and ";
								}
								*/
								sql+=" a.theme_css = b.theme_css and b.op_role like '%"+mrole+"%'";
			
							%>
								
							<wtc:service name="TlsPubSelCrm" outnum="5" routerKey="region" routerValue="<%=regionCode %>">
								<wtc:param value="<%=sql%>" />
							</wtc:service>
							<wtc:array id="themeList" scope="end"/>
							<%			
							
							if("000000".equals(retCode)){ 
								for(int i=0;i<themeList.length;i++){
									%>
									<tr>
										<td class='blue'><%=themeList[i][0]%></td>
										<td class='blue'><%=themeList[i][1]%></td>
										<td class='blue'><%=themeList[i][4]%></td>
										<td class='blue'><%="1".equals(themeList[i][3])?"是":"否"%></td>
										<td class='blue'>
	               			<img src='<%=request.getContextPath()%>/images/ico_delete.gif'  style='cursor:hand' alt='删除' onclick="delTemp('<%=themeList[i][0]%>','<%=themeList[i][4]%>','<%=themeList[i][3]%>')"/>
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
