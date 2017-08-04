<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page  contentType="text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="com.sitech.boss.util.page.*"%>
<%
	String opCode = "e492";
	String opName = "日志管理";
	
	String  powerCode = session.getAttribute("powerCode")==null?"":((String)session.getAttribute("powerCode")).trim();//角色代码
	String orgCode =  (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String workNo = (String)session.getAttribute("workNo");	
	
	
	//点击查询时，获取提交的值，然后进行过滤查询
	String log_type = request.getParameter("log_type")==null?"queryLog":request.getParameter("log_type");
	String login_no = request.getParameter("login_no")==null?"":((String)request.getParameter("login_no")).trim();
	String workbench = request.getParameter("workbench")==null?"":((String)request.getParameter("workbench")).trim();
	String ipAddress = request.getParameter("ipAddress")==null?"":(request.getParameter("ipAddress")).trim();
	String login_status = request.getParameter("login_status")==null?"":(request.getParameter("login_status")).trim();

	String beginDate = request.getParameter("beginDate")==null?"":(request.getParameter("beginDate")).trim();
	String endDate = request.getParameter("endDate")==null?"":(request.getParameter("endDate")).trim();		
	
	//分页功能变量
	int iPageNumber = request.getParameter("pageNumber") == null ? 1: Integer.parseInt(request.getParameter("pageNumber"));
  int iPageSize = 30;
  int iStartPos = (iPageNumber - 1) * iPageSize;
  int iEndPos = iPageNumber * iPageSize;	
  int totalNum = 0;
%>

	<head>
		<title><%=opName%></title>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		<META content=no-cache http-equiv=Pragma>
		<META content=no-cache http-equiv=Cache-Control>
		<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
		<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/My97DatePicker/WdatePicker.js"></script>
	</head>
	
	<script>
	
			
		function doProcess(packet)      
 		{
	       var opType = packet.data.findValueByName("opType"); 
	       var retCode = packet.data.findValueByName("retCode"); 
	       var retLog = packet.data.findValueByName("retLog"); 
	       var tempInfos = packet.data.findValueByName("tempInfos"); 
	      
	       if(opType=="delete"){
       			if(retCode=="000000"){
       				rdShowMessageDialog("操作成功！",2);
       				queryLog();
       			}else{
       				rdShowMessageDialog("操作失败!<br>错误代码："+retCode+"<br>错误信息："+retLog,0);
       				return false;
       			}
       	 }
     }
       		
		//删除
		function delLog(){
				var LogVal = "";
				f=document.getElementsByName("delSel");
					for( i=0 ; i<f.length ; i++) {
						if(f[i].checked==true){//组装选中数据
							LogVal = LogVal + ""+f[i].value.trim() +"~";
						}
				}
				if(LogVal==""){
					rdShowMessageDialog("请选择要删除的数据！",1);
					return false;
				}
				var delFlag = "";
				var log_type =  $('input[name=log_type]:checked').val();
  				if(log_type=="relog"){//访问日志
  					delFlag = "0";
  				}else{
  					delFlag = "1";
  				}
				if(rdShowConfirmDialog("确认要删除选择的日志吗？")==1){
					var delPacket = new AJAXPacket("log_op.jsp","正在执行,请稍后...");
			      	delPacket.data.add("opType", "delete");
			      	delPacket.data.add("wkSeq", LogVal);
			      	delPacket.data.add("delFlag", delFlag);
			      	core.ajax.sendPacket(delPacket,doProcess,true);
			      	delPacket = null; 
			  }		
		}
		
		function changeLogInfo(logType){
				if(logType=="queryLog"){//访问日志
					$("#log_list").text("系统访问日志列表");
					$("#queryLogTr").css("display","");
					$("#opLogTr").css("display","none");
				}else if(logType=="opLog"){//操作日志
					$("#log_list").text("系统操作日志列表");
					$("#opLogTr").css("display","");
					$("#queryLogTr").css("display","none");
				}
		}
		
		function queryLog(){
			 var log_type =  $('input[name=log_type]:checked').val();
			 document.qryLogFrm.action="log_main.jsp?log_type="+log_type;
			 document.qryLogFrm.submit();
		}
		
		//选择全部
		function setdelSelChecked(checkedVal) {
			f=document.getElementsByName("delSel");
			for( i=0 ; i<f.length ; i++) {
				if(checkedVal){
					f[i].checked=true;
				}else{
					f[i].checked=false;
				}
			}			
		}
			
		$(document).ready(function(){
		  var log_type =  $('input[name=log_type]:checked').val();
  		if(log_type=="queryLog"){//访问日志
					$("#log_list").text("系统访问日志列表");
					$("#queryLogTr").css("display","");
					$("#opLogTr").css("display","none");
					$("#reLogTr").css("display","none");
					$('#statusTR').show();
			}else if(log_type=="opLog"){//操作日志
					$("#log_list").text("系统操作日志列表");
					$("#opLogTr").css("display","");
					$("#queryLogTr").css("display","none");
					$("#reLogTr").css("display","none");
					$('#statusTR').hide();
			}else{
					$("#log_list").text("恢复删除的日志列表");
					$("#reLogTr").css("display","");
					$("#queryLogTr").css("display","none");
					$("#opLogTr").css("display","none");
					$('#statusTR').hide();
			}
			
			$("select").width("30");
			$("#login_status").width("150");
			$("#login_no").focus();
			
		});
		
		function selectType(log_type){
				if(log_type=='queryLog'){
						$('#statusTR').show();
						$('#mTable').hide();
						
				}else if(log_type=='opLog'){
					  $('#statusTR').hide();
					  $('#mTable').hide();
				}else{
					 $('#statusTR').hide();
					  $('#mTable').hide();
				}
				queryLog();
		}
		$(document).ready(function(){
			if("<%=log_type%>".trim()=="relog"){
				$("#delRecode").val("恢复");
				$("#delLogThorom").show();
			}else{
				$("#delRecode").val("删除");
				$("#delLogThorom").hide();
			}
		});
		
		function toExcele(){
			/* 
			
			var item=document.getElementById("mTable"); 
			var Lenr = item.rows.length; 
			for (var i=0;i<Lenr;i++) 
			{ 
			   var Lenc = item.rows(i).cells.length; 
			   for (j=1;j<Lenc;j++) 
			   { 
			  	oSheet.Cells(i+1,j+1).value = item.rows(i).cells(j).innerText; 
			   } 
			} 
			
			*/	
			var oXL = new ActiveXObject("Excel.Application"); 
			var oWB = oXL.Workbooks.Add(); 
			var oSheet = oWB.ActiveSheet;
			var hi = 1;
			$("#mTable tr:visible").each(function(i,n){
				var lLen = 0;
				if(i==0){
					lLen = $(this).find("th").length;
				}else{
					lLen = $(this).find("td").length;
				}
				if(typeof $(n).find("input").attr("checked")!="undefined"){
					hi++;
				}
				if(i==0){
					for(var h=1;h<lLen;h++){
						oSheet.Cells(i+1,h+1).value = $(this).find("th:eq("+h+")").text();
					}
				}else{
					for(var h=1;h<lLen;h++){
						if(typeof $(n).find("input").attr("checked")!="undefined"){
							oSheet.Cells(hi,h+1).value = $(this).find("td:eq("+h+")").text();
						}
					}
				}
				
			});
			 
			oXL.Visible = true; 
			oXL.Quit();
			oXL=null;
		}
		
	
	</script>
	<body>
		
		<form name="qryLogFrm" action="" method=post>
			<%@ include file="/npage/include/header_mop.jsp"%>
					
					<div class="title"> 
							<div id="title_zi">
								日志管理
							</div>							
					</div>
						<table cellspacing="0">
							<tr>
								<td class="blue">
									操作类型
								</td>
								<td class="blue" colspan="3">
									<input type="radio" name="log_type" id="log_type" value="queryLog"  <%if("queryLog".equals(log_type)){%>checked="checked"<%}%>  onclick="selectType(this.value)"/>系统访问日志
									<input type="radio" name="log_type" id="log_type" value="opLog"  <%if("opLog".equals(log_type)){%>checked="checked"<%}%> onclick="selectType(this.value)"/>系统操作日志
									
									<input type="radio" name="log_type" id="log_type" value="relog" <%if("relog".equals(log_type)){%>checked="checked"<%}%>  onclick="selectType(this.value)"/>日志恢复
								</td>
							</tr>
							<tr>
								<td class="blue" width="15%">工号</td>
								<td class="blue" width="35%">
									<input type="text"  v_must=1 v_type="string" v_maxlength="20" name="login_no" id="login_no" value=""/><input type="text"  v_must=1 v_type="string" v_maxlength="20" name="receive_no" id="receive_no" style="display:none"/>
								</td>
								<td class="blue" width="15%">IP地址</td>
								<td class="blue" width="35%">
									<input type="text"  v_must=1 v_type="string" v_maxlength="20" name="ipAddress" id="ipAddress" value=""/><input type="text"  v_must=1 v_type="string" v_maxlength="20" name="receive_no" id="receive_no" style="display:none"/>
								</td>
							</tr>
							
							<tr>
								<td class="blue">开始时间</td>
								<td class="blue">
									<input type="text"  v_must=1 v_type="string" v_maxlength="20" name="beginDate" id="beginDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',autoPickDate:true,onpicked:function(){}})"/>
								</td>
								<td class="blue">结束时间</td>
								<td class="blue">
									<input type="text"  v_must=1 v_type="string" v_maxlength="20" name="endDate" id="endDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',autoPickDate:true,onpicked:function(){}})"/>
								</td>
							</tr>							
							<tr id="statusTR">								
								<td class="blue" width="15%">登陆状态</td>
								<td class="blue" width="35%">
									<select id="login_status" name="login_status">
										<option value="" selected>
											全部
										</option>
										<option value="Y" >
											已登录
										</option>
										<option value="N">
											已登出
										</option>
									</select>
								</td>
								<td class="blue" width="15%">&nbsp;</td>
								<td class="blue" width="35%">&nbsp;</td>
							</tr>
							<tr>
								<td class="blue" colspan="4" style="text-align:center">
									<input type="button" class="b_foot" value="查 询" onclick="queryLog()" />
									<input type="reset" class="b_foot" value="重 置" />
								</td>
							</tr>
						</table>
					</div>
					
				<div id="Operation_Table">
						<div class="title">
							<div id="title_zi">	
								 <div id="log_list">						
								   系统访问日志列表		
							   </div>				
							</div>
						</div>
						<table id="mTable" cellspacing="0">
							<tr id="queryLogTr">
								<th width="6%">
									<input type="checkbox" name="selAll"  id="selAll"  onclick="setdelSelChecked(this.checked);"/>全选
								</th>
								<th nowrap="nowrap">
									工号
								</th>
								<th nowrap="nowrap">
									系统角色
								</th>
								<th nowrap="nowrap">
									角色名称
								</th>
								<th nowrap="nowrap">
									IP地址
								</th>
								<th nowrap="nowrap">
									状态
								</th>
								<th nowrap="nowrap">
									登录时间
								</th>
								<th nowrap="nowrap">
									登出时间
								</th>
								<th nowrap="nowrap">
									在线时间（秒）
								</th>
							</tr>
							
							<tr id="opLogTr" style="display:none">
								 <th width="6%">
									<input type="checkbox" name="selAll"  id="selAll"  onclick="setdelSelChecked(this.checked);"/>全选
								</th>
								 
								<th nowrap="nowrap">
									操作工号
								</th>
								<th nowrap="nowrap">
									操作代码
								</th>
								<th nowrap="nowrap">
									操作名称
								</th>
								<th nowrap="nowrap">
									操作信息
								</th>
								<th nowrap="nowrap">
									操作人员IP
								</th>
								<th nowrap="nowrap">
									操作时间
								</th>
							</tr>
							
							<tr id="reLogTr" style="display:none">
								 <th width="6%">
									<input type="checkbox" name="selAll"  id="selAll"  onclick="setdelSelChecked(this.checked);"/>全选
								</th>
								 
								<th nowrap="nowrap">
									操作工号
								</th>
								<th nowrap="nowrap">
									操作代码
								</th>
								<th nowrap="nowrap">
									操作名称
								</th>
								<th nowrap="nowrap">
									操作信息
								</th>
								<th nowrap="nowrap">
									操作人员IP
								</th>
								<th nowrap="nowrap">
									操作时间
								</th>
							</tr>
							
							<%				
							
								//查询总数
								String countSql = "select to_char(count(*)) from wOpLoginCheck where ";
								
								//分页查询						
								String sql = " select * from (select a.*, rownum id from(select to_char(total_date),to_char(login_accept),login_no,"+
														 " op_code,to_char(login_date,'yyyy-mm-dd hh24:mi:ss'),ip_address,login_status,to_char(logout_date,'yyyy-mm-dd hh24:mi:ss'),"+
														 " op_role_id,(select s.power_name from spowercode s where trim(s.power_code)=op_role_id) op_role_name,to_char(online_date),op_type,to_char(op_time,'yyyy-mm-dd hh24:mi:ss'),op_note,"+
														 " (select function_name from sfunccodenew c where c.function_code=op_code) op_name from wOpLoginCheck where  ";
								
								if("queryLog".equals(log_type)){//访问日志
							 	 		countSql = countSql + " op_type='0' and (isdel is null or isdel= '0' )  and ";
							 	 		sql      = sql      + " op_type='0' and (isdel is null or isdel  = '0')   and ";
							 	}else if("opLog".equals(log_type)){//操作日志
							 	 		countSql = countSql + " op_type='1'  and (isdel is null or isdel  = '0' )  and ";
							 	 		sql      = sql      + " op_type='1'  and (isdel is null or isdel  = '0' )  and ";
							 	}else{           //恢复日志
							 			countSql = countSql + "  isdel = '1'  and ";
							 	 		sql      = sql      + "  isdel = '1'  and ";
							 	}
							 	
							 	if(!"".equals(login_no)){
							 		  countSql = countSql + " login_no='"+login_no+ "' and ";
							 	 		sql = sql + " login_no='"+login_no+"' and ";
							 	}
							 	
							 	if(!"".equals(ipAddress)){
							 			countSql = countSql + " ip_address='"+ipAddress+ "' and ";
							 	 		sql = sql + " ip_address='"+ipAddress+"' and ";
							 	}
							 	
							 	if(!"".equals(beginDate)){
							 			countSql = countSql + " login_date>to_date('"+beginDate+"','yyyy-mm-dd hh24:mi:ss') and ";
							 	 		sql = sql + " login_date>to_date('"+beginDate+"','yyyy-mm-dd hh24:mi:ss') and ";
							 	}
							 	
							 	if(!"".equals(endDate)){
							 			countSql = countSql + " login_date<to_date('"+endDate+"','yyyy-mm-dd hh24:mi:ss') and ";
							 	 		sql = sql + " login_date<to_date('"+endDate+"','yyyy-mm-dd hh24:mi:ss') and ";
							 	}
							 	
							 	if(!"".equals(login_status)){
							 			countSql = countSql + " login_status='"+login_status+ "' and ";
							 	 		sql = sql + " login_status='"+login_status+"' and ";
							 	}
							 	countSql = countSql + " 1=1 ";
							 	
							 	sql=sql.trim();
							 	String tempStr = sql.substring(sql.length()-3,sql.length());
							 	System.out.println("-----------tempStr-----------"+tempStr);
							 	if(tempStr.equals("and")){
							 		sql =sql.substring(0,sql.length()-3);
							 	}
							 	sql = sql + "  order by login_accept desc) a) where id <= " + iEndPos + " and id > " + iStartPos ;
								System.out.println("sql-------->"+sql);
								//out.println("countSql-------->"+countSql);
							%>
							<wtc:service name="TlsPubSelCrm" outnum="1" routerKey="region" routerValue="<%=regionCode %>">
								<wtc:param value="<%=countSql%>" />						
							</wtc:service>
							<wtc:array id="logCount" scope="end"/>
									
							<wtc:service name="TlsPubSelCrm" outnum="16" routerKey="region" routerValue="<%=regionCode %>">
								<wtc:param value="<%=sql%>" />						
							</wtc:service>
							<wtc:array id="logList" scope="end"/>
							<%			
							System.out.println("log_main.jsp----logCount="+logCount[0][0]);	
							if("000000".equals(retCode)){ 
								 if(logList.length>0){
								 totalNum = logList.length;
								 	for(int i=0;i<logList.length;i++){
								 		if("queryLog".equals(log_type)){//访问日志
								 		%>
								 		<tr>
								 			<td><input type="checkbox" id="delSel" value="<%=logList[i][1]%>"></td>
									 		<td><%=logList[i][2]%></td>
									 		<td><%=logList[i][8]%></td>
									 		<td><%=logList[i][9]%></td>
									 		<td><%=logList[i][5]%></td>
									 		<td><%="Y".equals(logList[i][6])?"已登录":"已登出"%></td>
									 		<td><%=logList[i][4]%></td>	
									 		<td><%=(logList[i][7]==null||"".equals(logList[i][7]))?"&nbsp;":logList[i][7]%></td>
									 		<td><%=logList[i][10]%></td>
								 		</tr>
								 		<%
								 		}else if("opLog".equals(log_type))  {
								 			%>
								 			<tr>
								 				<td><input type="checkbox" id="delSel" value="<%=logList[i][1]%>"></td>
									 			<td><%=logList[i][2]%></td>
									 			<td><%=logList[i][3]%></td>
									 			<td><%=logList[i][14]%></td>
									 			<td><%=logList[i][13]%></td>
									 			<td><%=logList[i][5]%></td>	
									 			<td><%=logList[i][12]%></td>
								 			</tr>
								 			<%
								 		}else{
								 		%>
								 		<tr>
								 				<td><input type="checkbox" id="delSel" value="<%=logList[i][1]%>"></td>
									 			<td><%=logList[i][2]%></td>
									 			<td><%=logList[i][3]%></td>
									 			<td><%=logList[i][14]%></td>
									 			<td><%=logList[i][13]%></td>
									 			<td><%=logList[i][5]%></td>	
									 			<td><%=logList[i][12]%></td>
								 			</tr>
								 		<%
								 		}
								 		
								 	}								 
								 }
							}
							%>		
						</table>
					</table>
						<tr>
							<td colspan="10" id="op_page"  align="center">
								
							<%
							
								int iQuantity = 0;
								System.out.println("log_main.jsp----totalNum="+totalNum);	
								if(totalNum>0){
									iQuantity = Integer.parseInt(logCount[0][0].trim());;
								}
								Page pg = new Page(iPageNumber, iPageSize, iQuantity);
								PageView view = new PageView(request, out, pg);
								view.setVisible(true, true, 0, 0);
							%>
							</td>
				   </tr>	
				</table>
				<table>
				<tr>
				   	<td class='blue' id= "footer">
						 		
						<input type="button" class="b_foot"      id="delRecode"    value="删除"           onclick="delLog()" />
						<input type="button" class="b_foot_long" id="delLogThorom" value="彻底删除"      onclick='delLogT()'  />
						<input type="button" class="b_foot_long" id="toExcel"     value="导出EXCEL"       onclick="toExcele()" />
						 		
					</td>
				</tr>
				</table>		
									
					
			<%@ include file="/npage/include/footer.jsp"%>
		</form>
		<script>
				function delLogT(){
	var LogVal = "";
				f=document.getElementsByName("delSel");
					for( i=0 ; i<f.length ; i++) {
						if(f[i].checked==true){//组装选中数据
							LogVal = LogVal + ""+f[i].value.trim() +"~";
						}
				}
				if(LogVal==""){
					rdShowMessageDialog("请选择要删除的数据！",1);
					return false;
				}
				if(rdShowConfirmDialog("确认要彻底删除选择的日志吗？")==1){
					var delPacket = new AJAXPacket("log_op.jsp","正在执行,请稍后...");
			      	delPacket.data.add("opType", "delete");
			      	delPacket.data.add("wkSeq", LogVal);
			      	delPacket.data.add("delFlag", "a");
			      	core.ajax.sendPacket(delPacket,doDelLogThorom,true);
			      	delPacket = null; 
			  }		
}		
function doDelLogThorom(packet){
	var retCode = packet.data.findValueByName("retCode"); 	
	 var retMsg = packet.data.findValueByName("retMsg"); 
	if(retCode=="000000"){
       				rdShowMessageDialog("操作成功！",2);
       				location = location;
       			}else{
       				rdShowMessageDialog("操作失败!<br>错误代码："+retCode+"<br>错误信息："+retMsg,0);
       				return false;
       			}
}
			</script>
	</body>
</html>
