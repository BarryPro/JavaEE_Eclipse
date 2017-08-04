<%
  /*
   * 功能:
   * 版本: 1.0
   * 日期: 
   * 作者: 2017-01-19 liangyl 关于优化光猫管理系统补充需求的函
   * 版权: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%@ page import="java.text.SimpleDateFormat"%>
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
	SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	String newTime=sdf1.format(new Date());
%>
<html>
<head>
<title><%=opName%></title>
<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
<script src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js" type="text/javascript"></script>
<script language="javascript">
		
function gom447Qry(){
	var broadAccount = $("#broadAccount").val();
	if(broadAccount.length ==0){
		rdShowMessageDialog("请填写宽带账号！",1);
		return false;
	}
	
	var getdataPacket = new AJAXPacket("fm447Qry_1.jsp","正在获得数据，请稍候......");
	var iLoginAccept = "<%=loginAccept%>";
	var iChnSource = "01";
	var iOpCode = "<%=opCode%>";
	var iLoginNo = "<%=loginNo%>";
	var iLoginPwd = "<%=noPass%>";
	var iPhoneNo ="";
	var iUserPwd = "";
	var iCfmLogin = broadAccount;
	
	getdataPacket.data.add("iLoginAccept",iLoginAccept);
	getdataPacket.data.add("iChnSource",iChnSource);
	getdataPacket.data.add("iOpCode",iOpCode);
	getdataPacket.data.add("iLoginNo",iLoginNo);
	getdataPacket.data.add("iLoginPwd",iLoginPwd);
	getdataPacket.data.add("iPhoneNo",iPhoneNo);
	getdataPacket.data.add("iUserPwd",iUserPwd);
	getdataPacket.data.add("iCfmLogin",iCfmLogin);
	
	core.ajax.sendPacket(getdataPacket,doQry);
	getdataPacket = null;
}
		
function doQry(packet){
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	var retArray = packet.data.findValueByName("retArray");
	
	if(retCode == "000000"){
		$("#resultContent").show();
		$("#appendBody").empty();
		var appendTh = 
			"<tr>"
			+"<th width='25%'>故障ONT</th>"
			+"<th width='25%'>替换ONT</th>"
			+"<th width='25%'>操作时间</th>"
			+"<th width='15%'>金额</th>"
			+"<th width='10%'>打印免填单</th>"
			+"</tr>";
		$("#appendBody").append(appendTh);	
		var dyPhone="";
		var geshu=0;
		for(var i=0;i<retArray.length;i++){
			var str=retArray[i][5]=="Y"?"disabled='disabled'":"";
			var appendStr = "<tr>";
			appendStr += "<td width='25%'>"+retArray[i][0]+"</td>"
			+"<td width='25%'>"+retArray[i][1]+"</td>"
			+"<td width='25%'>"+retArray[i][2]+"</td>"
			+"<td width='25%'>"+retArray[i][3]+"</td>"
			+"<td width='25%'><input type=\"button\" "+str+" class=\"b_foot_long\" value=\"打印收据\" onclick=\"daYin('"+retArray[i][4]+"','"+retArray[i][3]+"','"+retArray[i][6]+"','"+retArray[i][7]+"','"+retArray[i][8]+"')\"/></td>"
			appendStr +="</tr>";
			$("#appendBody").append(appendStr);
		}
		if(dyPhone!=""){
			dyPhone=dyPhone.substring(0,dyPhone.length-1);
		}
		var appendStr2 = "<tr>";
		appendStr2 += "<td  align=\"center\" colspan=\"8\"></td>";
		appendStr2 +="</tr>";
		$("#appendBody").append(appendStr2);
		
		$("#excelExp").attr("disabled","");
		
	}else{
		$("#resultContent").hide();
		$("#appendBody").empty();
		$("#excelExp").attr("disabled","disabled");
		rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,1);
		
	}
}
		
function daYin(liushui,jine,idtype,idnum,userPhoneNum){
	var billFlag=sm447_show_Bill_Prt(liushui,jine,idtype,idnum,userPhoneNum);
	gom447Cfm(liushui);
	
}
function sm447_show_Bill_Prt(liushui,jine,idtype,idnum,userPhoneNum){
	//0|身份证 1|军官证 2|户口簿 3|港澳通行证 
	//4|警官证 5|台湾通行证 6|外国公民护照 7|其它 
	//8|营业执照 9|护照 A|组织机构代码 B|单位法人证书 C|介绍信 
	var idTypeStr="";
	if(idtype=="0"){
		idTypeStr="身份证";
	}
	else if(idtype=="1"){
		idTypeStr="军官证";
	}
	else if(idtype=="2"){
		idTypeStr="户口簿";
	}
	else if(idtype=="3"){
		idTypeStr="港澳通行证 ";
	}
	else if(idtype=="4"){
		idTypeStr="警官证";
	}
	else if(idtype=="5"){
		idTypeStr="台湾通行";
	}
	else if(idtype=="6"){
		idTypeStr="外国公民护照";
	}
	else if(idtype=="7"){
		idTypeStr="其它";
	}
	else if(idtype=="8"){
		idTypeStr="营业执照";
	}
	else if(idtype=="9"){
		idTypeStr="护照";
	}
	else if(idtype=="A"){
		idTypeStr="组织机构代码";
	}
	else if(idtype=="B"){
		idTypeStr="单位法人证书";
	}
	else if(idtype=="C"){
		idTypeStr="介绍信";
	}
	else{
		idTypeStr="身份证";
	}
	var  billArgsObj = new Object();
	$(billArgsObj).attr("10001","<%=loginNo%>");     //工号
	$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
	$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
	$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
	$(billArgsObj).attr("10005","客户名称");   //客户名称
	$(billArgsObj).attr("10006","宽带设备更换收据补打");    //业务类别
	
	$(billArgsObj).attr("10008",userPhoneNum);    //用户号码
	$(billArgsObj).attr("10015", jine);   //本次发票金额
	$(billArgsObj).attr("10016", jine);   //大写金额合计
	$(billArgsObj).attr("10017",jine);        //本次缴费：现金
	/*10028 10029 不打印*/
	$(billArgsObj).attr("10028","");   //参与的营销活动名称：
	$(billArgsObj).attr("10029","");	 //营销代码	
	$(billArgsObj).attr("10030",liushui);   //流水号：--业务流水
	$(billArgsObj).attr("10036","m432");   //操作代码
	/**/
	/*型号不打*/
	$(billArgsObj).attr("10061","");	       //型号
	$(billArgsObj).attr("10062","");	//税率
	$(billArgsObj).attr("10063","");	//税额	   
 	$(billArgsObj).attr("10071","6");	//
	$(billArgsObj).attr("10076",jine);	//大写金额合计
		
	$(billArgsObj).attr("10083",idTypeStr); //证件类型
	$(billArgsObj).attr("10084",idnum); //证件号码
	$(billArgsObj).attr("10086", "尊敬的客户，如您办理业务退订、取消等中止业务使用的操作时，请携带本收据、有效身份证件、办理业务时所得魔百和终端到移动指定自有营业厅办理押金退还手续。宽带终端押金返还截止日期：用户离网后90天内（包括90天）。"); //备注
	$(billArgsObj).attr("10065", $("#broadAccount").val()); //宽带账号
	$(billArgsObj).attr("10087", "000000"); //imei号码
	$(billArgsObj).attr("10041", "宽带设备更换收据补打");           //品名规格
	$(billArgsObj).attr("10042","台");                   //单位
	$(billArgsObj).attr("10043","1");	                   //数量
	$(billArgsObj).attr("10044",jine);	                //单价
	 			
	$(billArgsObj).attr("10085", "zsj"); //宽带费用收取方式 只弹出打印收据的框
	$(billArgsObj).attr("10072","1"); //1--正常发票  2--冲正类发票  2--退费类发票
	$(billArgsObj).attr("10088","m447"); //收据模块
	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
	//var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=" + "确实要进行发票打印吗？";
	$(billArgsObj).attr("11213","REC");  //新版发票新增票据标志位，默认空位发票 REC == 只有 打印纸质收据
	var path = "/npage/public/billPrtNew/Bill_ELE_Prt.jsp?dlgMsg=" + "确实要进行发票打印吗？";
	var loginAccept = "<%=loginAccept%>";
	var path = path +"&loginAccept="+loginAccept+"&opCode=<%=opCode%>&submitCfm=submitCfm";
	var ret = window.showModalDialog(path,billArgsObj,prop);
}

function gom447Cfm(liushui){
	var broadAccount = $("#broadAccount").val();
	if(broadAccount.length ==0){
		rdShowMessageDialog("请填写宽带账号！",1);
		return false;
	}
	
	var getdataPacket = new AJAXPacket("fm447Cfm.jsp","正在获得数据，请稍候......");
	var iLoginAccept = liushui;
	var iChnSource = "01";
	var iOpCode = "<%=opCode%>";
	var iLoginNo = "<%=loginNo%>";
	var iLoginPwd = "<%=noPass%>";
	var iPhoneNo ="";
	var iUserPwd = "";
	var iCfmLogin = broadAccount;
	
	getdataPacket.data.add("iLoginAccept",iLoginAccept);
	getdataPacket.data.add("iChnSource",iChnSource);
	getdataPacket.data.add("iOpCode",iOpCode);
	getdataPacket.data.add("iLoginNo",iLoginNo);
	getdataPacket.data.add("iLoginPwd",iLoginPwd);
	getdataPacket.data.add("iPhoneNo",iPhoneNo);
	getdataPacket.data.add("iUserPwd",iUserPwd);
	getdataPacket.data.add("iCfmLogin",iCfmLogin);
	
	core.ajax.sendPacket(getdataPacket,dom447Cfm);
	getdataPacket = null;
}
		
function dom447Cfm(packet){
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");	
	if(retCode == "000000"){
		gom447Qry();
	}else{
		rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,1);
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
		  		<td width="20%" class="blue">宽带终端</td>
				<td width="30%">
					<select id="broadTerminal" name="broadTerminal">
						<option value="ONT" selected="selected">ONT</option>
					</select>
					<font color="red">*</font>
				</td>
				<td width="20%" class="blue">宽带账号</td>
				<td width="30%">
					<input type="text" id="broadAccount" name="broadAccount" value=""/>
					<font color="red">*</font>
				</td>
		    </tr>
		    <tr>
				<td align=center colspan="4" id="footer">
					<input class="b_foot" name="sure"  type="button" value="查询" onclick="gom447Qry();"/>
					<!-- <input  name="back1"  class="b_foot" type="button" value="导出excel" id="excelExp" onclick="printTable(exportExcel)" disabled="disabled"/> -->
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
			<tbody id="appendBody"></tbody>
		</table>
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