<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/se112/public_title_name.jsp"%>
<%@ include file="/npage/se112/footer.jsp"%>
<%@page import="com.sitech.crmpd.core.bean.MapBean"%>
<%@page import="java.util.*"%>
<%@page import="com.sitech.crmpd.core.util.SiUtil"%>

<%
	String meansId = request.getParameter("meansId");
	String phoneNo = request.getParameter("svcNum");
	String act_type = request.getParameter("act_type").trim();
	String reginCode = request.getParameter("reginCode");
	String loginNo = request.getParameter("loginNo");
	String password = request.getParameter("password");
	String pay_moneycould = request.getParameter("pay_moneycould");
	System.out.println("act_type=AAAAAAAAAAAAAAAAAAAAAA====" + act_type);
	System.out.println("=++=======phoneNo=====" + phoneNo);	
	System.out.println("=++=======reginCode=====" + reginCode);	
	System.out.println("===++=====loginNo=====" + loginNo);	
	System.out.println("==++======password=====" + password);	
	System.out.println("=++=======pay_moneycould=====" + pay_moneycould);
	
 %>	
<html>
	<head>
	<title></title>
	</head>
	<body>
		<div id="operation">
		<form method="post" name="frm1147" action="">
				
				<div id="operation_table">
					 <div class="title">
						<div class="text">
							以旧换新机型添加模式
						</div>
					</div>
					<div class="input">
					<table>
						<tr>
							<th>手动添加机型</th>
							<td>
								<input type="button" class="b_text" name="verify" id="verify" onclick="addRow()" value="增加"/>
							</td>
							<th>选择添加机型</th>
							<td>
								<input type="button" class="b_text" name="verify" id="verify" onclick="chooseRes()" value="选择"/>
							</td>
						</tr>
					</table>
					<div class="title">
					<div class="text">
						终端信息
					</div>
					</div>
						<table id="resTable">						
							<tr>
								<th>品牌</th>
								<th>机型</th>
								<th>抵扣金额</th>
								<th>操作</th>
							</tr>									
						</table>							
						</div>
					<div id="operation_button"><!-- disabled="disabled" -->
						<input type="button" class="b_foot" value="确定" id="btnSubmit"
							name="btnSubmit" onclick="btnRsSubmit()" />
						<input type="button" class="b_foot" value="关闭" id="btnCancel"
							name="btnCancel" onclick="closeWin()" />
					</div>
				</div>
			</form>
		</div>
	</body>
	<script type="text/javascript">
	
    function addRow() {  //到增加记录页面
        var rowTab = document.getElementById("resTable");
        var tr1 =  rowTab.insertRow();
        tr1.align="center";
        
        var td1 = document.createElement("td");
        	td1.align="center";
            td1.innerHTML="<input type='text' name='resBrand'  value=''/>";
        
        var td2 = document.createElement("td");
        	td2.align="center";
            td2.innerHTML="<input type='text' name='resType'  value=''/>";
        
        var td3 = document.createElement("td");
        	td3.align="center";
            td3.innerHTML= "<input type='text' name = 'resCost'  value='' onkeyup='checkRow(this);'/>";
            
        var td4 = document.createElement("td");
        	td4.align="center";
            td4.innerHTML="<input type='button' value='删除' class='b_text' onclick='removeRow(this)' />";
        
        tr1.appendChild(td1);
        tr1.appendChild(td2);
        tr1.appendChild(td3);
        tr1.appendChild(td4);
    }
	
	
	function removeRow(obj){
		var tab = obj.parentNode.parentNode.parentNode.parentNode;
		tab.deleteRow(obj.parentNode.parentNode.rowIndex);
	}
	
	function checkRow(obj){
		obj.value=obj.value.replace(/[^\.\d]/g,'');
		if(obj.value.split('.').length>2){
		  obj.value=obj.value.split('.')[0]+'.'+obj.value.split('.')[1];
		}
	}
	
	function btnRsSubmit(){
		var resBrandStr ="";
		var resTypeStr ="";
		var resCostStr ="";
		var split = "";
		var costSum=0;
		var show_desc="";
		var pay_moneycould = "<%=pay_moneycould%>";
		//品牌
		var resBrand = document.getElementsByName("resBrand");
		//机型
		var resType = document.getElementsByName("resType");
		//金额
		var resCost = document.getElementsByName("resCost");
		
		if(resBrand.length == 0){
			showDialog("请添加“以旧换新”机型，再点击确定按钮!",0);
		 	return false;	
		}
		
		for(var j =0;j<resBrand.length;j++){
			if(resBrand[j].value == ""){
				showDialog("添加的第"+(j+1)+"款机型,品牌不能为空，请填写!",0);
		 		return false;
			}
			if(resType[j].value == ""){
				showDialog("添加的第"+(j+1)+"款机型,型号不能为空，请填写!",0);
		 		return false;
			}
			if(resCost[j].value == ""){
				showDialog("添加的第"+(j+1)+"款机型,抵扣金额不能为空，请填写!",0);
		 		return false;
			}
		
			resBrandStr = resBrandStr + split + resBrand[j].value;
			resTypeStr = resTypeStr + split + resType[j].value;
			resCostStr = resCostStr + split + resCost[j].value;
			show_desc = show_desc +"#"+(j+1)+". 品牌："+resBrand[j].value+"，机型："+resType[j].value+"，抵扣金额："+resCost[j].value+" 元";
			costSum= costSum+parseFloat(resCost[j].value);
			split = "#";
		}
		
		if(parseFloat(pay_moneycould) < parseFloat(costSum)){
			showDialog("抵扣金额累计值大于此终端营销活动用户缴纳金额，不允许办理!",0);
		 	return false;	
		}
		
		show_desc = show_desc.substring(1,show_desc.length).replace( /#/g, "<br>");
		//alert(show_desc);
		parent.addOldResData(show_desc,resBrandStr,resTypeStr,resCostStr);
		//展现
		parent.oldRes_Checkfuc();
		closeDivWin();
	
	}
	
	//终端
	function chooseRes(){
		window.open("<%=request.getContextPath()%>/npage/se112/hljclientList.jsp",'选择终端','width=550px,height=620px');
	}
	
	
	function addhljClient(clientList){
		var gift = clientList.split(";");
		for(i=0;i<gift.length-1;i++){
			var giftPar = gift[i].split(",");
			
			var rowTab = document.getElementById("resTable");
        	var tr1 =  rowTab.insertRow();
        	tr1.align="center";
        
        	var td1 = document.createElement("td");
        	td1.align="center";
            td1.innerHTML="<input type='text' name='resBrand'  value='"+trim(giftPar[0])+"'/>";
        
        	var td2 = document.createElement("td");
        	td2.align="center";
            td2.innerHTML="<input type='text' name='resType'  value='"+trim(giftPar[1])+"'/>";
        
        	var td3 = document.createElement("td");
        	td3.align="center";
            td3.innerHTML="<input type='text' name='resCost'  value='' onkeyup='checkRow(this);'/>";
            
       		var td4 = document.createElement("td");
        	td4.align="center";
            td4.innerHTML="<input type='button' value='删除' class='b_text' onclick='removeRow(this)' />";
        
	        tr1.appendChild(td1);
	        tr1.appendChild(td2);
	        tr1.appendChild(td3);
	        tr1.appendChild(td4);
		}
	}
	
	function closeWin(){
		closeDivWin();
	}
	
	</script>
</html>