<%
  /*
   * 功能:
   * 版本: 1.0
   * 日期: 
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
			
			
			var phoneNo = $.trim($("input[name='phoneNo']").val());
			if(phoneNo.length ==0 ){
				rdShowMessageDialog("请输入物联网号码！",1);
				return false;
			}
			
				/*ajax start*/
			var getdataPacket = new AJAXPacket("/npage/sm147/fm147Qry.jsp","正在获得数据，请稍候......");
			
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
			
			
			core.ajax.sendPacket(getdataPacket,doRetRegion);
			getdataPacket = null;
			
			
		}
		
	function doRetRegion(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			var infoArray = packet.data.findValueByName("infoArray");
			var retLength = packet.data.findValueByName("retLength");
		
		if(retCode == "000000" ){
			
				
				$("#resultContent").show();
				$("#appendBody").empty();
				$("#addNewCar").hide();
				var appendTh = 
					"<tr>"
					+"<th width='11%'>车主姓名</th>"
					+"<th width='11%'>车主身份证号</th>"
					+"<th width='12%'>车主手机号码</th>"
					+"<th width='11%'>终端模组序列号</th>"
					+"<th width='11%'>安装点</th>"
					+"<th width='11%'>安装人员</th>"
					+"<th width='11%'>安装人员联系方式</th>"
					+"<th width='11%'>车架号</th>"
					+"<th width='11%'>车牌号</th>"
					+"<th width='11%'>操作</th>"
					+"</tr>";
				$("#appendBody").append(appendTh);
				/*循环拼接tr td*/	
				if(retLength != "0"){
				for(var i=0;i<infoArray.length;i++){
				
					var ownername = infoArray[i][0];
					var ownerid = infoArray[i][1];
					var ownermobile = infoArray[i][2];
					var moduleserialnumber = infoArray[i][3];
					var installationpoints = infoArray[i][4];
					var installationperson = infoArray[i][5];
					var inspercontinfo = infoArray[i][6];
					var framenumber = infoArray[i][7];
					var platenumber = infoArray[i][8];
					
					var appendStr = "<tr>";
					
					appendStr += "<td width='11%'>"+ownername+"</td>"
											+"<td width='11%'>"+ownerid+"</td>"
											+"<td width='12%'>"+ownermobile+"</td>"
											+"<td width='11%'>"+moduleserialnumber+"</td>"
											+"<td width='11%'>"+installationpoints+"</td>"
											+"<td width='11%'>"+installationperson+"</td>"
											+"<td width='11%'>"+inspercontinfo+"</td>"
											+"<td width='11%'>"+framenumber+"</td>"
											+"<td width='11%'>"+platenumber+"</td>"
											+"<td width='11%'>"+"<input type='button' name='editIt' class='b_text' acValue='"+ownername+"|"+ownerid+"|"+ownermobile+"|"+moduleserialnumber+"|"+installationpoints+"|"+installationperson+"|"+inspercontinfo+"|"+framenumber+"|"+platenumber+"' value='修改' onclick='editSome(this.acValue)'/>"+"</td>"
					appendStr +="</tr>";	
										
					$("#appendBody").append(appendStr);
					/*不可以新增*/
					$("#addSome").attr("disabled","disabled");
					}
				}
			}else if(retCode == "m14703"){
					var appendStr = "<tr>";
					appendStr += "<td colspan='10' algin='center'><font color='red'>"+retMsg+"</font></td>"
					appendStr +="</tr>";	
					$("#appendBody").append(appendStr);
					/*可以增加*/
					$("#addSome").attr("disabled","");
				
			}else {
				$("#resultContent").hide();
				$("#appendBody").empty();
				$("#addNewCar").hide();
				rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,1);
			}
		}
		
		/*增加操作*/
		function showAdd(){
				$("#OwnerName").val("");
				$("#OwnerID").val("");
				$("#OwnerMobile").val("");
				$("#ModuleSerialNumber").val("");
				$("#InstallationPoints").val("");
				$("#InstallationPerson").val("");
				$("#InstalPerCon").val("");
				$("#FrameNumber").val("");
				$("#PlateNumber").val("");
				
				$("#doSubBtn").attr("opFlag","add");
				
				$("#addNewCar").show();
				
			
		}
		/*修改操作*/
		function editSome(tmpValue){
			
			var valueArray = tmpValue.split("|");
			var OwnerName = valueArray[0];
			var OwnerID = valueArray[1];
			var OwnerMobile = valueArray[2];
			var ModuleSerialNumber = valueArray[3];
			var InstallationPoints = valueArray[4];
			var InstallationPerson = valueArray[5];
			var InstalPerCon = valueArray[6];
			var FrameNumber = valueArray[7];
			var PlateNumber = valueArray[8];
			
			$("#OwnerName").val(OwnerName);
			$("#OwnerID").val(OwnerID);
			$("#OwnerMobile").val(OwnerMobile);
			$("#ModuleSerialNumber").val(ModuleSerialNumber);
			$("#InstallationPoints").val(InstallationPoints);
			$("#InstallationPerson").val(InstallationPerson);
			$("#InstalPerCon").val(InstalPerCon);
			$("#FrameNumber").val(FrameNumber);
			$("#PlateNumber").val(PlateNumber);
			
			$("#doSubBtn").attr("opFlag","edit");
			
			$("#addNewCar").show();
			
		}
		/*提交操作*/
		function doSub(opFlag){
			
			if(!check(f1)){
				return false;
			}
			var OwnerName = $("#OwnerName").val();
			var OwnerID = $("#OwnerID").val();
			var OwnerMobile = $("#OwnerMobile").val();
			var ModuleSerialNumber = $("#ModuleSerialNumber").val();
			var InstallationPoints = $("#InstallationPoints").val();
			var InstallationPerson = $("#InstallationPerson").val();
			var InstalPerCon = $("#InstalPerCon").val();
			var FrameNumber = $("#FrameNumber").val();
			var PlateNumber = $("#PlateNumber").val();
			
			var serviceName = "";
			if(opFlag == "add"){
				serviceName = "sM147ADD";
			}
			if(opFlag == "edit"){
				serviceName = "sM147Modify";
			}
			
			var phoneNo = $.trim($("input[name='phoneNo']").val());
			if(phoneNo.length ==0 ){
				rdShowMessageDialog("请输入物联网号码！",1);
				return false;
			}
			if(rdShowConfirmDialog("您确定提交么？") == 1){
				
				/*ajax start*/
				var getdataPacket = new AJAXPacket("/npage/sm147/fm147UorD.jsp","正在获得数据，请稍候......");
				
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
				
				getdataPacket.data.add("OwnerName",OwnerName);
				getdataPacket.data.add("OwnerID",OwnerID);
				getdataPacket.data.add("OwnerMobile",OwnerMobile);
				getdataPacket.data.add("ModuleSerialNumber",ModuleSerialNumber);
				getdataPacket.data.add("InstallationPoints",InstallationPoints);
				getdataPacket.data.add("InstallationPerson",InstallationPerson);
				getdataPacket.data.add("InstalPerCon",InstalPerCon);
				getdataPacket.data.add("FrameNumber",FrameNumber);
				getdataPacket.data.add("PlateNumber",PlateNumber);
				getdataPacket.data.add("serviceName",serviceName);
				getdataPacket.data.add("opFlag",opFlag);
				
				
				core.ajax.sendPacket(getdataPacket,doRetUorD);
				getdataPacket = null;
			}
		}
		
		function doRetUorD(packet){
			
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			var opFlag = packet.data.findValueByName("opFlag");
			if(opFlag == "add" && retCode == "000000"){
				
				rdShowMessageDialog("新增成功！",2);
				
			}else if(opFlag == "edit" && retCode == "000000"){
				
				rdShowMessageDialog("修改成功！",2);
				
			}else{
				rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,1);
				
			}
			window.location.reload();
			
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
	    	<td width="20%" class="blue">物联网号码</td>
	    	<td width="80%" colspan="3" >
	    		<input type="text" name="phoneNo" id="phoneNo"	value="" />&nbsp;
	    		<font color='red'>*</font>
	    	</td>
	    </tr>
	    <tr> 
			<td align=center colspan="4" id="footer">
				<input class="b_foot" name="sure"  type="button" value="查询"  onclick="doQry();">
				<input class="b_foot" id="addSome" name="addSome"  type="button" disabled="disabled" value="新增"  onclick="showAdd();">
				<input class="b_foot" name=close  onClick="removeCurrentTab()" type=button value=关闭>
				
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
	
		
		<table id="addNewCar" style="display:none">
			<tr>
			<td class="blue">车主姓名</td>
			<td><input type="text"  value="" name="OwnerName" id="OwnerName" v_must="1" maxlength="20" class="required" onblur="checkElement(this)"><font class="orange">*</font>  </td>
			<td class="blue">车主身份证号</td>
			<td><input type="text"  value="" name="OwnerID" id="OwnerID" v_must="1" maxlength="100" class="required" onblur="checkElement(this)"><font class="orange">*</font> </td>
			
		</tr>
		<tr>
				<td class="blue">车主手机号码</td>
				<td><input type="text"  value="" name="OwnerMobile" id="OwnerMobile" v_must="1" maxlength="20" class="required" onblur="checkElement(this)"><font class="orange">*</font> </td>
				<td class="blue">终端模组序列号</td>
				<td><input type="text"  value="" name="ModuleSerialNumber" id="ModuleSerialNumber" v_must="1" maxlength="30" class="required" onblur="checkElement(this)"><font class="orange">*</font> </td>
				
		</tr>
		<tr>
				<td class="blue">安装点</td>
				<td><input type="text"  value="" name="InstallationPoints" id="InstallationPoints" v_must="1" maxlength="50" class="required" onblur="checkElement(this)"><font class="orange">*</font> </td>
				<td class="blue">安装人员</td>
				<td><input type="text"  value="" name="InstallationPerson" id="InstallationPerson" v_must="1" maxlength="20" class="required" onblur="checkElement(this)"><font class="orange">*</font> </td>
		</tr>
		<tr>
				<td class="blue">安装人员联系方式</td>
				<td><input type="text"  value="" name="InstalPerCon" id="InstalPerCon" v_must="1" maxlength="50" class="required" onblur="checkElement(this)"><font class="orange">*</font> </td>
				<td class="blue">车架号</td>
				<td><input type="text"  value="" name="FrameNumber" id="FrameNumber"  maxlength="30"  onblur="checkElement(this)"></td>
				
		</tr>	
		<tr>
			<td class="blue">车牌号</td>
			<td colspan="3"><input type="text"  value="" name="PlateNumber" id="PlateNumber"  maxlength="15"  onblur="checkElement(this)"></td>	
		</tr>	
		<tr> 
			<td align=center colspan="4" id="footer">
				<input class="b_foot" name="doSubBtn" id="doSubBtn" opFlag=""  type="button" value="确定"  onclick="doSub(this.opFlag);">
				<input class="b_foot" name="cancels"  type="button" value="取消"  onclick="doCancel();">
			</td>
		</tr>
		<table>
	</div>


	<%@ include file="/npage/include/footer.jsp" %>
</form>
<script>
var excelObj;
function printTable(object)
{
	var obj=document.all.exportExcel2;
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
