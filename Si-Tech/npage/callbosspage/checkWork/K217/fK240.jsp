<%
  /*
   * 功能: 差错类别定义
   * 版本: 1.0
   * 日期: 2008/11/05
   * 作者: kouwb
   * 版权: si-tech
  */
%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	request.setCharacterEncoding("gb2312");
	
	String opCode = "K240";
	String opName = "差错类别定义";
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode=org_code.substring(0,2);
	String workNo = (String)session.getAttribute("workNo");
	String sql = "";
	
	org_code = "01";
%>

<wtc:service name="sK240Qry"  routerKey="region"  routerValue="<%=regionCode%>"  outnum="5">
</wtc:service>
<wtc:array id="result" scope="end"/>

<html>
	<head>
		<title>差错类别定义</title> 

<script type="text/javascript" src="<%=request.getContextPath()%>/njs/csp/checkWork_dialog.js"></script>
		
<script language="javascript">
var prevclick = "";
function tdop(){
		event.srcElement.style.color='red';
		
		if(prevclick != "" && prevclick != event.srcElement.id)
				document.all[""+prevclick].style.color = "#003399";
		prevclick = event.srcElement.id;				
}
	
function add_data(){
		var h=390;
		var w=500;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var cssv = "dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:yes;location:no;status:yes;help:no";
		var retValue = "";
		retValue = window.showModalDialog("fK240_update.jsp?op=add","",cssv);
		
		if(typeof(retValue) != "undefined"){
				retValue = trim(retValue);
				if(retValue != ""){
						var arr = retValue.split("~");
						similarMSNPop(arr[1] + "[" + arr[0] + "]");   
						if(arr[0] == "000000"){
								var tr = document.all.ErrTable.insertRow();
								var td = tr.insertCell();
								var td1 = tr.insertCell();
								var td2 = tr.insertCell();
								var td3 = tr.insertCell();
								var td4 = tr.insertCell();
								td.innerText = arr[2];
								td1.innerText = arr[3]==""?"  ":arr[3];
								td2.innerText = arr[4];
								td3.innerText = arr[5];
								td4.innerText = arr[6];
								td.id = "tdata" + document.form1.data_rows.value;
								td.className = "blue";
								td1.className = "blue";
								td2.className = "blue";
								td3.className = "blue";
								td4.className = "blue";
								td.style.cursor = "hand";
								td.onclick = function(){
								tdop(this);
						}
						td.onmouseover = function(){
						this.style.backgroundColor="#ececec";
				}
				td.onmouseout = function(){
				this.style.backgroundColor="#F7F7F7";
		}
		
		document.form1.data_rows.value = document.form1.data_rows.value + 1;
		try{window.parent.frames.leftFrame.window.location.reload(true);}catch(e){alert(e.message)}      			
}
	
function mod_data(){
		if(prevclick.indexOf("tdata")==-1){
				similarMSNPop("请选择修改差错类别！");
		}else{
				var error_class_name = trim(document.all[""+prevclick].innerText);
				var note = trim(document.all[""+prevclick].nextSibling.innerText);
				var error_class_id = trim(document.all[""+prevclick].nextSibling.nextSibling.innerText);
				var parent_error_class_id = trim(document.all[""+prevclick].nextSibling.nextSibling.nextSibling.innerText);
				var valid_flag = trim(document.all[""+prevclick].nextSibling.nextSibling.nextSibling.nextSibling.innerText);
				var param = "&error_class_name=" + error_class_name +
										"&note=" + note +
										"&error_class_id=" + error_class_id +
										"&parent_error_class_id=" + parent_error_class_id +
										"&valid_flag=" + valid_flag;
		    var h=390;
		    var w=500;
		    var t=screen.availHeight/2-h/2;
		    var l=screen.availWidth/2-w/2;
		    var cssv = "dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:yes;location:no;status:yes;help:no";
		    var retValue = "";
		    retValue = window.showModalDialog("fK240_update.jsp?op=mod" + param,"",cssv);
				if(typeof(retValue) != "undefined"){
						retValue = trim(retValue);
						if(retValue != ""){
								var arr = retValue.split("~");
								similarMSNPop(arr[1] + "[" + arr[0] + "]");
								if(arr[0] == "000000"){
											document.all[""+prevclick].innerText = arr[2];
											document.all[""+prevclick].nextSibling.innerText = arr[3]==""?"  ":arr[3];
											document.all[""+prevclick].nextSibling.nextSibling.innerText = arr[4];
											document.all[""+prevclick].nextSibling.nextSibling.nextSibling.innerText = arr[5];
											document.all[""+prevclick].nextSibling.nextSibling.nextSibling.nextSibling.innerText = arr[6];
											try{window.parent.frames.leftFrame.window.location.reload(true);}catch(e){alert(e.message)}
								}
						}
				}  
		} 				
}
	
function del_data(){
		var myPacket = new AJAXPacket("fK240I_AddMod.jsp","正在提交，请稍候......");
		myPacket.data.add("retType","del");
		myPacket.data.add("login_no","<%=workNo%>");
		myPacket.data.add("error_class_id",trim(document.all[""+prevclick].nextSibling.nextSibling.innerText));
		core.ajax.sendPacket(myPacket,doProcess);
		myPacket=null;				
}
	
	
function doProcess(packet){
		var retType = packet.data.findValueByName("retType");		
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");		
		
		if(retCode=='000000'){
				similarMSNPop(retMsg + "[" + retCode + "]");
				document.all[""+prevclick].nextSibling.nextSibling.nextSibling.nextSibling.innerText = "N";
		} else {
				similarMSNPop(retMsg + "[" + retCode + "]");
		}
}				
	
function ltrim(s){
		return s.replace( /^\s*/, ""); 
} 

function rtrim(s){
		return s.replace( /\s*$/, ""); 
} 

function trim(s){
		return rtrim(ltrim(s)); 
}						
</script>

	</head>
	<body>
		<form name="form1" method="POST">
			<%@ include file="/npage/include/header.jsp" %>	
				<div class="title"><div style="float:left">差错类别定义</div>
						<div style="float:right">
							<input type="button" name="add" class="b_foot" value="新增" onclick="add_data()"/>
							<input type="button" name="mod" class="b_foot" value="修改" onclick="mod_data()"/>
							<input type="button" name="del" class="b_foot" value="删除" onclick="del_data()"/>
						</div>
				</div>
				<table id="ErrTable" cellspacing="0">
					<tr>
						<td style="background-color:#ececec">
							<div align="left">名称</div>
						</td>
						<td style="background-color:#ececec">
							<div align="left">描述</div>
						</td>
						<td style="background-color:#ececec">
							<div align="left">编号</div>
						</td>
						<td style="background-color:#ececec">
							<div align="left">上层节点</div>
						</td>
						<td style="background-color:#ececec">
							<div align="left">是否可用</div>
						</td>
					</tr>
<%
	int i = 0;
	for(i=0;i<result.length;i++){	
%>
					<tr>
						<td id="tdata<%=i%>" class="blue" style="cursor:hand" onclick="tdop(this)" onmouseover="javascript:this.style.backgroundColor='#ececec';" onmouseout="javascript:this.style.backgroundColor='#F7F7F7'">
							<%=result[i][0]%>
						</td>
						<td class="blue">
							<%=(result[i][1]==null||result[i][1].equals(""))?"&nbsp;&nbsp;":result[i][1]%>
						</td>
						<td class="blue">
							<%=result[i][2]%>
						</td>
						<td class="blue">
							<%=result[i][3]%>
						</td>
						<td class="blue">
							<%=result[i][4]%>
						</td>
					</tr>
<%
	}
%>
				</table>
				<input type="hidden" name="data_rows" value="<%=i%>"/>
			<%@ include file="/npage/include/footer.jsp" %>
		</form>
	</body>
</html>
