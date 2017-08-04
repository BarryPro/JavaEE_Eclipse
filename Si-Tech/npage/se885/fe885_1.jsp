<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	String workNo = (String)session.getAttribute("workNo");
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<script src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js" type="text/javascript"></script>
		<script language="javascript">
			function doReset(){
				window.location.href = "fe885_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>"
			}
			function quechoosee(qryButton) {
			 /* 按钮延迟 */
  			controlButt(qryButton);
				var phoneNos = $("#phoneNo").val();
				var operType = $.trim($("#operType").val());
				var startTime = $.trim($("#startTime").val());
				var endTime = $.trim($("#endTime").val());
				if(!check(frm)){
					return false;
				}
				var myPacket = new AJAXPacket("fe885_qry.jsp","正在查询，请稍候......");
				myPacket.data.add("PhoneNo",phoneNos);
				myPacket.data.add("operType",operType);
				myPacket.data.add("startTime",startTime);
				myPacket.data.add("endTime",endTime);
				myPacket.data.add("opCode","<%=opCode%>");
				core.ajax.sendPacketHtml(myPacket,checkSMZValue,true);
				getdataPacket = null;
			}
			function checkSMZValue(data){
				//找到添加表格的div
				var markDiv=$("#gongdans"); 
				//清空原有表格
				markDiv.empty();
				markDiv.append(data);
				var retCode = $("#retCode").val();
				var retMsg = $("#retMsg").val();
				if(retCode!="000000"){
					rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
					window.location.href="fe885_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
				}
			}
		</script>
	<body>
		<form name="frm" method="POST" action="">
		<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
	  	<table cellspacing="0" >
				<tr>
					<td class="blue" width="15%">用户手机号码</td>
					<td>
						<input name="phoneNo" type="text"   id="phoneNo" value=""  v_type="mobphone"  maxlength="11" size="17" v_must="1" />
					</td>
					<td class="blue" width="15%">处理方式</td>
					<td>
						 <select align="left" id="operType" name="operType" style="width:200px">
						 	<option value="" selected>全部</option>
              <option value="01">停短信</option>
              <option value="02" >恢复短信</option>
              <option value="03">停语音</option>
              <option value="04">恢复语音</option>
              <option value="05">关闭主叫号码所有功能（即停机）</option>
              <option value="06">开启主叫号码所有功能（即开机）</option>
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
	       		<img id = "imgCustEnd" 
							onclick="WdatePicker({el:'endTime',startDate:'%y%M%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"
	 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
						<font class="orange">(yyyymmdd)</font>	
		    	</td>
		    </tr>
			</table>
	 		<table cellspacing="0">
				<tr>
					<td noWrap id="footer">
						<div align="center">
							<input type="button"  name="quchoose" class="b_foot" value="查询" onclick="quechoosee(this)" />
							&nbsp;
							<input name="back" onClick="doReset()" type="button" class="b_foot"  value="清除">
							&nbsp;
							<input type="button" name="close" class="b_foot" value="关闭" onClick="removeCurrentTab();"/>
						</div>
					</td>
				</tr>
			</table>
			<div id="gongdans"></div>	  
 			<%@ include file="/npage/include/footer.jsp" %>
		</form>
	</body>
</html>