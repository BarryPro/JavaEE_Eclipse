
<%
	/*
	 * 功能： 成员号码
	 * 版本： v1.0
	 * 日期： 2012-10-07
	 */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/se112/public_title_name.jsp"%>
<%@ include file="/npage/se112/footer.jsp"%>
<%@page import="com.sitech.crmpd.core.bean.MapBean"%>
<%@page import="java.util.*"%>
<%@page import="com.sitech.crmpd.core.util.SiUtil"%>
<%
	String meansId = request.getParameter("meansId");
	System.out.println("--------------------------------------------------------meansId=" + meansId);
	String xml = request.getParameter("memNumber");
	System.out.println("--------------------------------------------------------memNumber=" + xml);
 	MapBean mb = new MapBean();
 %>	
 <%@ include file="getMapBean.jsp"%>
 <%
	String isMem = null;
	String memNumber = null;
	String memType = null;
	String memPrice = null;
	
	if(null != mb){
		isMem = mb.getString("OUT_DATA.B32.IS_MEM");
		memNumber = mb.getString("OUT_DATA.B32.MEM_NUMBER");
		memType = mb.getString("OUT_DATA.B32.MEM_TYPE");
		memPrice = mb.getString("OUT_DATA.B32.MEM_PRICE");
	}
	
	isMem = (isMem.split("\\("))[1];
	
	if(isMem.endsWith(")")){
		isMem = isMem.substring(0,isMem.length()-1);
	}
	
	memType = (memType.split("\\("))[1];
	if(memType.endsWith(")")){
		memType = memType.substring(0,memType.length()-1);
	}
	
	System.out.println("--------------------------------------------------------isMem=" + isMem);
	System.out.println("--------------------------------------------------------memNumber=" + memNumber);
	System.out.println("--------------------------------------------------------memType=" + memType);
	System.out.println("--------------------------------------------------------memPrice=" + memPrice);
	
	
	String[] memPriceStrs = memPrice.split("\\+");

 %>
<html>
	<head>
	<title></title>
	</head>
	<body>
		<div id="operation">
		<form method="post" name="frm4938" action="">
				<div id="operation_table">
					 <div class="title">
						<div class="text">
							成员号码
						</div>
					</div>
					<div class="input">
					<table id = "phoneTable">
								<tr>
									<th>
										专款金额
									</th>
									<th>
										手机号码
									</th>
									<th>
										服务密码
									</th>
									<th colspan = "2">
										操作				
									</th>
								</tr>
						<%
						if(isMem != null && memNumber != null && memType != null && memPrice != null ){
							if(memType.equals("0")){//固定人数
								for(int i = 0;i<memPriceStrs.length;i++){
						%>
								<tr>
									<td>
										<input type="text" name = "memSpecialFunds" id ="memSpecialFunds<%=i%>" readonly value = "<%= memPriceStrs[i]%>"/>						
									</td>
									<td>
										<input type="text" name = "memPhoneNo" id ="memPhoneNo<%=i%>" maxLength='11'/>				
									</td>
									<td>
										<input type="password" name = "mempwd" id ="mempwd<%=i%>" maxLength='6' onclick="get_password('<%=i %>')"/>				
									</td>
									<td colspan = "2">
										<input type="button" class="b_text" value="校验"  onclick="validPhone('<%=i %>')" />
										<input name="isValid" id="isValid<%=i %>" type="hidden" value = "N">	
										<input name="hiddmem" id="hiddmem<%=i %>" type="hidden" >
									</td>
								</tr>
								
							<%
								}
							}
						}else{
						%>
							<span>数据配置错误，请联系管理员！</span>
						<% 
						}
						%>	
						</table>

					<div id="operation_button">
						<input type="button" class="b_foot"   value="确定" id="btnSubmit"
							name="btnSubmit" onclick="btnRsSubmit()" />
						<input type="button" class="b_foot" value="关闭" id="btnCancel"
							name="btnCancel" onclick="closeWin()" />
						<%
						if(memType != null && memType.equals("1")){
						%>
						<input type="button" class="b_foot" value="增加" id="btnCancel"
							name="btnCancel" onclick="addPhone()" />
						<%
						}
						%>
					</div>
				</div>
			</form>
		</div>
	</body>
<script type="text/javascript">

var trNum = 0;
function addPhone(){
	trNum++;
	var phoneTab = document.getElementById("phoneTable");
	var tabTr = phoneTab.insertRow();
	tabTr.id = "tabTr"+trNum;
	tabTr.insertCell().innerHTML = "<input name='memSpecialFunds' id='memSpecialFunds" + trNum + "' type='text'>";
	tabTr.insertCell().innerHTML = "<input name='memPhoneNo' id='memPhoneNo" + trNum + "' type='text' maxLength='11' >";
	tabTr.insertCell().innerHTML = "<input name='mempwd' id='mempwd" + trNum + "' type='password' maxLength='6' onclick='get_password(" + trNum + ")'>";
	tabTr.insertCell().innerHTML = "<input type='button' class='b_text' value='校验' onclick='validPhone(" + trNum + ")'>"
									+ "<input name='hiddmem' id='hiddmem" + trNum + "' type='hidden' >"
									+ "<input name='isValid' id='isValid" + trNum + "' type='hidden' value = 'N'>";
	tabTr.insertCell().innerHTML = "<input type='button' class='b_text' value='删除' onclick='delPhone(" + tabTr.id + ")'>";
	
}

//打开小键盘，输入密码
function get_password(trNum){
	//先将密码域置为只读
	$("#mempwd" + trNum).attr("readonly","readonly");
	//将密码域置为空
	$("#mempwd" + trNum).val("");
	
	var path = "<%=request.getContextPath() %>/npage/common/NumberDialog.jsp";
	var h=170;
    var w=470;
    var t=screen.availHeight/2-h/2;
    var l=screen.availWidth/2-w/2;
    var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:no; resizable:no;location:no;status:no";
	
	var password = window.showModalDialog(path,"",prop);
	if("" == password || "undefined" == password || "null" == password || "NULL" == password){
		showDialog("密码不能为空，请重新输入", 1);
	}else{
		//为密码域赋值
		$("#mempwd" + trNum).val(password);
	}
	
}//end of function

function validPhone(trNum){
	//alert("trNum=" + trNum);
	
	var msfstr = document.getElementById("memSpecialFunds" + trNum).value;
	var mpnstr = document.getElementById("memPhoneNo" + trNum).value;
	var mpdstr = document.getElementById("mempwd" + trNum).value;
	
	if(!validFormat(msfstr,mpnstr,mpdstr)){
		return;
	}
	if(msfstr%60!=0){
		showDialog("专款数必须为60的倍数，请修改！",1);
		return;
	}
	//-------------校验密码start----------------------------------------------------------------------------------------
	$.ajax({
		type: "POST",
		url: "<%=request.getContextPath()%>/f4938.do?operate=checkPassword",
		data : {
			'password' : mpdstr,
			'phone_no' : mpnstr
		},
		cache : false,
		success : function(resp) {
			//unLoading("ajaxLoadingDiv");//去掉等待
			var retStr = $.trim(resp);
			var retArr = retStr.split(':');
			if ("T" == retArr[0]) {//如果密码验证通过
				document.getElementById("hiddmem" + trNum).value = msfstr + "~" + mpnstr;
				document.getElementById("isValid" + trNum).value = "Y";
				document.getElementById("memSpecialFunds" + trNum).readOnly = true;
				document.getElementById("memPhoneNo" + trNum).readOnly = true;
				document.getElementById("mempwd" + trNum).readOnly = true;
				document.getElementById("mempwd" + trNum).onclick = "";
				$("#memSpecialFunds" + trNum).css("color","red");
				$("#memPhoneNo" + trNum).css("color","red");
				showDialog("校验通过",1);
			} else {//如果密码验证未通过
				//将密码域置为空
				$("#mempwd" + trNum).val("");
				//提示错误信息
				showDialog("密码验证未通过:" + retArr[1], 1);
			}
		}
	});
	//-------------校验密码end----------------------------------------------------------------------------------------
}

function validFormat(msfstr,mpnstr,mpdstr){
	if(msfstr.trim() == ""){
		showDialog("专款金额不能为空！",1);
		return false;
	}else if(mpnstr.trim() == ""){
		showDialog("手机号码不能为空！",1);
		return false;
	}else if(mpdstr.trim() == ""){
		showDialog("服务密码不能为空！",1);
		return false;
	}else if(mpdstr.trim().length != 6){
		showDialog("服务密码应为6位！",1);
		return false;
	}else if(!isTel(mpnstr.trim())){
		showDialog("请输入正确的手机号码格式！",1);
		return false;
	}else if(!isInt(msfstr.trim())){
		showDialog("请输入正确的金额格式！",1);
		return false;
	}
	return true;
}


function delPhone(tabtr){
	var rowNum = tabtr.rowIndex;
	var phoneTab = document.getElementById("phoneTable");
	phoneTab.deleteRow(rowNum);
}

function btnRsSubmit(){
	
	var memTable = document.getElementById("phoneTable");
	var tabRowNum = memTable.rows.length;
	if(tabRowNum < '2'){
		showDialog("请先添加成员信息！",1);
		return;
	}

	var isValidStrs = document.getElementsByName("isValid");
	for(var i=0;i<isValidStrs.length;i++){
		var isValidStr = isValidStrs[i].value;
		if(isValidStr == "N"){
			showDialog("有没有校验的手机号码，请先校验！",1);
			return;
		}
	}

	var desc = "";
	var printStr = "";
	var orderMemXML = "<%=isMem%>" + "@";
	
	var hiddenstr = document.getElementsByName("hiddmem");
	var hidnum = hiddenstr.length;
	var totalMoney = "0";
	
	for(var i=0;i<hidnum;i++){
		var hs = hiddenstr[i].value;
		var hsstr = hs.split("~");
		desc += "用户：" +　hsstr[1] + "的专款为" + hsstr[0] + "元;<\BR>";
		printStr += "用户：" +　hsstr[1] + "的专款为" + hsstr[0] + "元;";
		totalMoney = Number(totalMoney) + Number(hsstr[0]);
		orderMemXML += hsstr[1] + "#" + hsstr[0] + ",";
	}
	
	desc += "总计：" + totalMoney + "元";
	if(orderMemXML.charAt(orderMemXML.length - 1) == ","){
		orderMemXML = orderMemXML.substr(0,orderMemXML.length-1);
	}
	
	parent.memNumber_Checkfuc();
	parent.addMemNumberData(orderMemXML);
	parent.addShowMemInfo(desc, totalMoney, printStr);
	closeDivWin();
}


function closeWin(){
	closeDivWin();
}

function isTel(v){
	var mobilePatrn = /^((\(\d{3}\))|(\d{3}\-))?1[3,5,8]\d{9}$/;
	if(mobilePatrn.exec(v)) {
		return true;
	} else {
		return false;
	}
}

function isInt(v){
	var Int = /^[0-9]*[1-9][0-9]*$/;
	if(Int.exec(v)) {
		return true;
	} else {
		return false;
	}
}
	
</script>
</html>