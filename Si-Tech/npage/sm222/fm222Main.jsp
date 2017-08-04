<%
  /*
   * 功能: gaopeng 2015/03/06 10:23:14 关于增加前台及客服界面同步特服业务的需求
   * 版本: 1.0
   * 日期: 2015/02/11 14:57:30
   * 作者: gaopeng
   * 版权: si-tech
   
   
    -------------------------修改-----------何敬伟(hejwa) 2015-4-22 16:21:35-------------------
		关于增加前台及客服界面同步特服业务的补充需求
		在页面的下半部分增加查询功能
		
	  -------------------------后台人员：王文刚--------------------------------------------
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
    
    String loginNo     = (String)session.getAttribute("workNo");
 		String noPass      = (String)session.getAttribute("password");
 		
		String opCode     = (String)request.getParameter("opCode");
		String opName     = (String)request.getParameter("opName");	 
		
				//当前时间
		String currentDate = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		//31天前的时间
		Calendar now =Calendar.getInstance();  
		now.setTime(new java.util.Date());  
		now.set(Calendar.DATE,now.get(Calendar.DATE)-31);  
		String b31_Date = new java.text.SimpleDateFormat("yyyyMMdd").format( now.getTime());
		
		
		String loginAccept = getMaxAccept();
%>
  	
<html>
<head>
	<title><%=opName%></title>
	<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
	<script src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js" type="text/javascript"></script>
	<script language="javascript">
		
		$(document).ready(function(){
			
		});
	
		
		
		/*2015/02/11 17:14:37 gaopeng 确认方法*/
		function doCfm(){
			
			var run_code_now = $("#run_code_now").val();
			run_code_now = run_code_now.split("-->")[0];
			/*ajax start*/
			var getdataPacket = new AJAXPacket("/npage/sm222/fm222Cfm.jsp","正在获得数据，请稍候......");
			
			var iLoginAccept = "<%=loginAccept%>";
			var iChnSource = "01";
			var iOpCode = "<%=opCode%>";
			var iLoginNo = "<%=loginNo%>";
			var iLoginPwd = "<%=noPass%>";
			var iPhoneNo = $.trim($("#phoneNo").val());
			var iUserPwd = "";
			var specialProduct = $("select[name='specialProduct']").find("option:selected").val();
			
			getdataPacket.data.add("iLoginAccept",iLoginAccept);
			getdataPacket.data.add("iChnSource",iChnSource);
			getdataPacket.data.add("iOpCode",iOpCode);
			getdataPacket.data.add("iLoginNo",iLoginNo);
			getdataPacket.data.add("iLoginPwd",iLoginPwd);
			getdataPacket.data.add("iPhoneNo",iPhoneNo);
			getdataPacket.data.add("iUserPwd",iUserPwd);
			
			getdataPacket.data.add("specialProduct",specialProduct);
			getdataPacket.data.add("run_code_now",run_code_now);
			
			
			core.ajax.sendPacket(getdataPacket,doRetCfm);
			getdataPacket = null;
			
		}
		
		
		
		function doRetCfm(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			//retMsg = retMsg.replace("SUCCESS","");
			
			var run_code_now = $("#run_code_now").val();
			run_code_now = run_code_now.split("-->")[0];
			
			if(retCode == "000000"){
				if(run_code_now == "A"){
					rdShowMessageDialog(""+retMsg,2);
				}else{
					rdShowMessageDialog("HLR同步成功!",2);	
				}
				window.location.reload();
			}else{
				
				rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,1);
				window.location.reload();
				
			}
			
		}
		
		
	//ajax查询HLR数据同步记录	
	function qryFunc(){
		var beginDate = $("#beginDate").val();
		var endDate   = $("#endDate").val();
		
		
				
		if($("#phoneIn").val().trim()==""&&$("#oprLoginNo").val().trim()==""){
			rdShowMessageDialog("手机号和工号最少输入一项");
			return;
		}
		
		if($("#phoneIn").val().trim()!=""){//不为空时校验手机号
			if(!forMobil(document.f1.phoneIn))  return false;
		}
		
		if(beginDate==""){
			rdShowMessageDialog("请选择开始时间");
			return;
		}
		
		if(endDate==""){
			rdShowMessageDialog("请选择结束时间");
			return;
		}

		if(beginDate>endDate){
			rdShowMessageDialog("开始时间不能大于结束时间");
			return;
		}
		
		
		var packet = new AJAXPacket("fm222_1.jsp","正在执行,请稍后...");
			packet.data.add("opCode","<%=opCode%>");// 
			packet.data.add("phoneNo",$("#phoneIn").val().trim());//
			packet.data.add("oprLoginNo",$("#oprLoginNo").val().trim());//
			packet.data.add("beginDate",beginDate+"000000");//
			packet.data.add("endDate",endDate+"235959");//
			core.ajax.sendPacket(packet,doQryFunc);
			packet = null; 
	}
	
	
	
//查询动态展示IMEI号码列表，回调
function doQryFunc(packet){
	var code = packet.data.findValueByName("code"); //返回代码
	var msg  = packet.data.findValueByName("msg"); //返回信息
	if(code=="000000"){//查询成功后动态展示列表
			var retArray = packet.data.findValueByName("retArray");
			//获取数组成功，动态拼接列表
			var trObjdStr = "";
			//第二次以后查询会有多余行数据，所以删除除了title以外行的数据
			$("#upgMainTab tr:gt(0)").remove();
			
			for(var i=0;i<retArray.length;i++){
								
				if(retArray[i][3]!="0"){
					trObjdStr += "<tr>"+
												 "<td>"+retArray[i][0]+"</td>"+  
												 "<td>"+retArray[i][1]+"</td>"+  
												 "<td>"+retArray[i][2]+"</td>"+  
												 "<td>"+retArray[i][3]+"</td>"+  
												 "<td>"+retArray[i][4]+"</td>"+  
												 "<td>"+retArray[i][5]+"</td>"+  
												 "<td>"+retArray[i][9]+"</td>"+  
												 "<td>"+retArray[i][6]+"</td>"+  
												 "<td>"+retArray[i][7]+"</td>"+  
												 "<td>"+retArray[i][8]+"</td>"+  
										 "</tr>";
				}
			}
			//将拼接的行动态添加到table中
			$("#upgMainTab tr:eq(0)").after(trObjdStr);
	}else{
		  rdShowMessageDialog("查询失败，"+code+"："+msg,0);
	}
}

function qryUserInfo(){
		if(!forMobil(document.f1.phoneNo))  return false;
		
		if($("#phoneNo").val().trim()==""){
			rdShowMessageDialog("请输入手机号");
			$("#phoneNo").focus();
			return;
		}
		
		var packet = new AJAXPacket("fm222_2.jsp","正在执行,请稍后...");
			packet.data.add("opCode","<%=opCode%>");// 
			packet.data.add("opName","<%=opName%>");// 
			packet.data.add("loginAccept","<%=loginAccept%>");// 
			packet.data.add("phoneNo",$("#phoneNo").val().trim());//
			core.ajax.sendPacket(packet,doQryUserInfo);
			packet = null; 
}
function doQryUserInfo(packet){
	var code = packet.data.findValueByName("code"); //返回代码
	var msg  = packet.data.findValueByName("msg"); //返回信息
	if(code=="000000"){ 
		  var custName      = packet.data.findValueByName("custName"); //
			var run_code      = packet.data.findValueByName("run_code"); //
			var run_code_last = packet.data.findValueByName("run_code_last"); //
			var run_name_last = packet.data.findValueByName("run_name_last"); //
			var run_code_now  = packet.data.findValueByName("run_code_now"); //
			var run_name_now  = packet.data.findValueByName("run_name_now"); //
			
			$("#custName").val(custName);
			$("#run_code_now").val(run_code_now+"-->"+run_name_now);
			if(run_code_now == "A"){
				/*关于在客服CRM系统中增加“VOLTE业务重置功能”的申请 用户当前状态为A时，增加volte特服选项*/
	  			$("select[name='specialProduct']").empty();
	  			$("select[name='specialProduct']").append("<option value='03'>短消息</option>");
	  			$("select[name='specialProduct']").append("<option value='55'>GPRS</option>");
	  			$("select[name='specialProduct']").append("<option value='19'>来电显示</option>");
	  			$("select[name='specialProduct']").append("<option value='28'>关闭语音</option>");
	  			$("select[name='specialProduct']").append("<option value='MY'>漫游类</option>");
	  			$("select[name='specialProduct']").append("<option value='00'>国际长途</option>");
	  			$("select[name='specialProduct']").append("<option value='29'>彩铃</option>");
	  			$("select[name='specialProduct']").append("<option value='99'>VOLTE</option>");
			}else{
				$("select[name='specialProduct']").empty();
  			$("select[name='specialProduct']").append("<option value='03'>短消息</option>");
  			$("select[name='specialProduct']").append("<option value='55'>GPRS</option>");
  			$("select[name='specialProduct']").append("<option value='19'>来电显示</option>");
  			$("select[name='specialProduct']").append("<option value='28'>关闭语音</option>");
  			$("select[name='specialProduct']").append("<option value='MY'>漫游类</option>");
  			$("select[name='specialProduct']").append("<option value='00'>国际长途</option>");
  			$("select[name='specialProduct']").append("<option value='29'>彩铃</option>");
				
			}
			
	}else{
		  rdShowMessageDialog("查询失败，"+code+"："+msg,0);
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
	  		<td width="20%" class="blue">手机号码</td>
	  		<td >
	  			<input type="text" id="phoneNo" name="phoneNo"  value="" maxlength="11" />
	  			<input class="b_foot" name="qryBtn" id="qryBtn"  type="button" value="查询"  onclick="qryUserInfo();" > 
				</td>
				<td width="20%" class="blue"><span id="si_show_span">特服产品</span></td>
	  		<td  width="30%">
	  			<select name="specialProduct" >
	  				<option value="03">短消息</option>
	  				<option value="55">GPRS</option>
	  				<option value="19">来电显示</option>
	  				<option value="28">关闭语音</option>
	  				<option value="MY">漫游类</option>
	  				<option value="00">国际长途</option>
	  				<option value="29">彩铃</option>
	  			</select>
	  		</td>
	    </tr>
	    <tr>
	  		<td width="20%" class="blue">客户名称</td>
	  		<td width="30%">
	  			<input type="text" id="custName" name="custName" class="InputGrey" readonly value=""/>
	  		</td>
	  		<td width="20%" class="blue">当前状态</td>
	  		<td width="30%">
	  			<input type="text" id="run_code_now" name="run_code_now" class="InputGrey" readonly value=""/>
	  		</td>
	    </tr>
	  </table>
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
	  <table>
	    <tr>
				<td align=center colspan="4" id="footer">
					<input class="b_foot" name="confirmBtn" id="confirmBtn"  type="button" value="确认"  onclick="doCfm();" >&nbsp;&nbsp;
					<input class="b_foot" name="resetBtn" id="resetBtn"  type="button" value="重置"  onclick="javascript:window.location.reload();">&nbsp;&nbsp;
					<input class="b_foot" name="close"  onClick="removeCurrentTab()" type="button" value="关闭">
					
				</td>
			</tr>
		</table>
	</div>
	
	<div class="title">
		<div id="title_zi">HLR数据同步记录查询</div>
	</div>
	<table cellSpacing="0">
	<tr>
	    <td class="blue" width="20%">手机号码</td>
		  <td width="30%">
			    <input type="text" name="phoneIn" id="phoneIn"  maxlength="11"  value=""/> 
		  </td>
		  <td class="blue" width="20%">操作工号</td>
		  <td width="30%">
			    <input type="text" name="oprLoginNo" id="oprLoginNo" maxlength="6" value=""/> 
		  </td>
	</tr>
	<tr>
		  <td class="blue" width="20%">开始时间</td>
		  <td width="30%">
			    <input type="text" name="beginDate" id="beginDate" value="<%=b31_Date%>"  onclick="WdatePicker({dateFmt:'yyyyMMdd',autoPickDate:true,onpicked:function(){}})" />  
		  </td>
		  <td class="blue" width="20%">结束时间</td>
		  <td width="30%"> 
			    <input type="text" name="endDate" id="endDate" value="<%=currentDate%>" onclick="WdatePicker({dateFmt:'yyyyMMdd',autoPickDate:true,onpicked:function(){}})" />   
		  </td>
	</tr>
</table>
		<table>
	    <tr>
				<td align=center colspan="4" id="footer">
					<input class="b_foot" name="qryBtn" id="qryBtn"  type="button" value="查询"  onclick="qryFunc();" > 
					
				</td>
			</tr>
		</table>
	
<TABLE cellSpacing="0" id="upgMainTab">
    <tr>
        <th width="12%">操作流水</th>
        <th width="12%">手机号码</th>
        <th width="8%">操作工号</th>
        <th width="8%">业务代码</th>	
        <th width="10%">业务名称</th>
        <th width="13%">操作时间</th>	
        <th width="10%">操作说明</th>
        <th width="13%">返回时间</th>
        <th width="8%">返回代码</th>
        <th >结果解析</th>
    </tr>
</table>

	<%@ include file="/npage/include/footer.jsp" %>
</form>
<script>
var excelObj;
function printTable(object)
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
