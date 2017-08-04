<%
  /*
   * 功能: 关于优化客服CRM系统功能六月份第一次需求的函
   * 版本: 1.0
   * 日期: 2014/08/11 9:23:54
   * 作者: gaopeng
   * 版权: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    String regionCode = (String)session.getAttribute("regCode");
    String loginNo = (String)session.getAttribute("workNo");
 		String noPass = (String)session.getAttribute("password");
 		String groupID = (String)session.getAttribute("groupId");
 		String opCode = (String)request.getParameter("opCode");
		String opName = (String)request.getParameter("opName");
		String phoneNo = (String)request.getParameter("activePhone");
		String loginAccept = getMaxAccept();
		
		String inParamsRegion [] = new String[2];
		inParamsRegion[0] = "select t.region_code,t.region_code ||'-'|| t.region_name as recname from sregioncode t where 1=1 and t.use_flag =:useFlag order by t.region_code ";
		inParamsRegion[1] = "useFlag=Y";
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode_region" retmsg="retMessage_region" outnum="2"> 
    <wtc:param value="<%=inParamsRegion[0]%>"/>
    <wtc:param value="<%=inParamsRegion[1]%>"/> 
  </wtc:service>  
  <wtc:array id="result_region"  scope="end"/>
<%
	if("000000".equals(retCode_region) && result_region.length > 0){
		
	}else{
		%>
		<script language="javascript">
			rdShowMessageDialog("获取地市信息失败!",1);
			removeCurrentTab();
		</script>
		<%
	}
%>
  	
<html>
<head>
	<title><%=opName%></title>
	<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
	<script src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js" type="text/javascript"></script>
	<script language="javascript">
		
		$(document).ready(function(){
			
		});
		
		function doQry(){
			var phoneNo = $.trim($("#phoneNo").val());
			var selRegion = $("select[name='selRegion']").find("option:selected").val();
			var startTime = $.trim($("#startTime").val());
			var endTime = $.trim($("#endTime").val());
			/*必须同时输入*/
			if( (startTime.length == 0 && endTime.length != 0) || (startTime.length != 0 && endTime.length == 0) ){
				rdShowMessageDialog("结束时间和开始时间必须同时输入!");
      	return false;
			}
			/*如果选择了地市*/
			if(startTime.length == 0 || endTime.length == 0){
				rdShowMessageDialog("请输入开始时间或结束时间!");
    		return false;
			}
				
			/*如果开始结束时间均不是空*/
			if(startTime.length != 0 && endTime.length != 0){
				if(startTime > endTime){
					rdShowMessageDialog("开始时间不能大于结束时间!");
      		return false;
				}
				var startYear = startTime.substring(0,4);
				var endYear = endTime.substring(0,4);
				var startMonth = startTime.substring(4,6);
				var endMonth = endTime.substring(4,6);
				/*如果年份一样，则比较月份是否超过三个自然月，如果年份不一样 有几种情况 见以下*/
				if((Number(endMonth) - Number(startMonth) >= 1) && (startYear == endYear )){
					rdShowMessageDialog("时间差不能超过自然月!");
      		return false;
				}
				else if(startYear != endYear){
					rdShowMessageDialog("时间差不能超过自然月!");
    			return false;
				}
			}
			/*ajax start*/
			var getdataPacket = new AJAXPacket("/npage/sm199/fm199Qry.jsp","正在获得数据，请稍候......");
			var iLoginAccept = "<%=loginAccept%>";
			var iChnSource = "01";
			var iOpCode = "<%=opCode%>";
			var iLoginNo = "<%=loginNo%>";
			var iLoginPwd = "<%=noPass%>";
			var iPhoneNo = phoneNo;
			var iUserPwd = "";
			getdataPacket.data.add("iLoginAccept",iLoginAccept);
			getdataPacket.data.add("iChnSource",iChnSource);
			getdataPacket.data.add("iOpCode",iOpCode);
			getdataPacket.data.add("iLoginNo",iLoginNo);
			getdataPacket.data.add("iLoginPwd",iLoginPwd);
			getdataPacket.data.add("iPhoneNo",iPhoneNo);
			getdataPacket.data.add("iUserPwd",iUserPwd);
			getdataPacket.data.add("startTime",startTime);
			getdataPacket.data.add("endTime",endTime);
			getdataPacket.data.add("selRegion",selRegion);
			core.ajax.sendPacket(getdataPacket,doRetRegion);
			getdataPacket = null;
		}
		
		function doRetRegion(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			var infoArray = packet.data.findValueByName("infoArray");
			if(retCode == "000000"){
				$("#resultContent").show();
				$("#appendBody").empty();
				var appendTh = 
					"<tr>"
					+"<th>手机号码</th>"
					+"<th>归属地市</th>"
					+"<th>操作工号</th>"
					+"<th>操作时间 </th>"
					+"<th>不良信息类型</th>"
					+"<th>加解黑名单原因描述</th>"
					+"<th>处理方式</th>"
					+"</tr>";
					$("#appendBody").append(appendTh);
					if(infoArray.length > 0){
						for(var i=0;i<infoArray.length;i++){
							var msg0 = infoArray[i][0];
							var msg1 = infoArray[i][1];
							var showText1 = "";
							if(msg1 == "01"){
								showText1 = "垃圾短信";
							}
							if(msg1 == "02"){
								showText1 = "骚扰电话";
							}
							if(msg1 == "03"){
								showText1 = "垃圾彩信";
							}
							var msg2 = infoArray[i][2];
							var showText2 = "";
							if(msg2 == "01"){
								showText2 = "停短信";
							}
							if(msg2 == "03"){
								showText2 = "停语音";
							}
							if(msg2 == "05"){
								showText2 = "关闭主叫号码所有功能";
							}
							
							var msg3 = infoArray[i][3];
							var msg4 = infoArray[i][4];
							var msg5 = infoArray[i][5];
							var msg6 = infoArray[i][6];
							var msg7 = infoArray[i][7];
							var msg8 = infoArray[i][8];
							var appendStr = "<tr>";
							appendStr += "<td width='15%'>"+msg7+"</td>"
													+"<td width='15%'>"+msg8+"</td>"
													+"<td width='15%'>"+msg4+"</td>"
													+"<td width='15%'>"+msg5+"</td>"
													+"<td width='15%'>"+showText1+"</td>"
													+"<td width='25%'>"+msg3+"</td>"
													+"<td width='25%'>"+showText2+"</td>"
							appendStr +="</tr>";	
							$("#appendBody").append(appendStr);
						}
						$("#export").attr("disabled","");
					}else{
						var appendStr = "<tr>";
						appendStr += "<td width='15%' colspan='7' align='center'>没有查询结果！</td>"
						appendStr +="</tr>";	
						$("#appendBody").append(appendStr);
					}
			}else{
					$("#resultContent").hide();
					$("#appendBody").empty();
					$("#export").attr("disabled","disabled");
					rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,1);
					window.location.href="fm199Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
			}
		}
	</script>
	</head>
	<body>
		<form action="" method="post" name="f1">
		<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
		<div>
			<table>
		    <tr>
		  		<td width="20%" class="blue">地市</td>
		  		<td width="80%" colspan="3">
		  			<select name="selRegion">
		  				<option value="$$" selected>00--全省--</option>
		  				<%
		  					if("000000".equals(retCode_region) && result_region.length > 0){
		  						for(int i=0;i<result_region.length;i++){
		  						%>
		  							<option value="<%=result_region[i][0]%>"><%=result_region[i][1]%></option>
		  						<%
		  						}
		  					}
		  				%>
		  			</select>
		  		</td>
		    </tr>
		    <tr>
		    	<td width="20%" class="blue">开始时间</td>
		    	<td width=30%>
		    		<input name="startTime" type="text" id="startTime"  readonly
	        		onclick="WdatePicker({el:'startTime',startDate:'%y%M%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"
							v_type="date3" value=""  maxlength="19" />
	       		<img id = "imgCustStart" 
							onclick="WdatePicker({el:'startTime',startDate:'%y%M%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"
	 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
						<font class="orange">(yyyymmdd)</font>	
		    	</td>
		    	<td width=20% class="blue">结束时间</td>
		    	<td width=30%>
		    		<input name="endTime" type="text" id="endTime"  readonly
	        		onclick="WdatePicker({el:'endTime',startDate:'%y%M%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"
							v_type="date3" value=""  maxlength="19" />
	       		<img id = "imgCustStart" 
							onclick="WdatePicker({el:'endTime',startDate:'%y%M%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"
	 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
						<font class="orange">(yyyymmdd)</font>	
		    	</td>
		    </tr>
		    <tr> 
				<td align=center colspan="4" id="footer">
					<input class="b_foot" name="sure"  type="button" value="查询"  onclick="doQry();">&nbsp;&nbsp;
					<input class="b_foot" id="export" name="export"  type="button" value="导出EXCEL" disabled="disabled"  onclick="printTable();">&nbsp;&nbsp;
					<input class="b_foot" name="close"  onClick="removeCurrentTab()" type=button value=关闭>
					
				</td>
			</tr>
			</table>
		</div>
		<!-- 查询结果列表 -->
		<div id="resultContent" style="display:none">
			<div class="title">
				<div id="title_zi">查询结果列表</div>
			</div>
			<table id="exportExcel" name="exportExcel">
				<tbody id="appendBody">
				
				</tbody>
			</table>
		</div>
	<%@ include file="/npage/include/footer.jsp" %>
	</form>
	<script>
	var excelObj;
	function printTable()
	{
		var obj=document.all.exportExcel;
		rows=obj.rows.length;
		if(rows>0){
			try{
				excelObj = new ActiveXObject("excel.Application");
				excelObj.Visible = true;
				excelObj.WorkBooks.Add;
				  for(i=0;i<rows;i++){
				    cells=obj.rows[i].cells.length;
				    for(j=0;j<cells;j++)
				      excelObj.Cells(i+1,j+1).Value="'" + obj.rows[i].cells[j].innerText;
				}
			}
			catch(e){}
		} else {
			
		}
	}
	</script>
</body>
</html>
