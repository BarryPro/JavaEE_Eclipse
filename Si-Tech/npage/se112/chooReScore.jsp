<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/se112/public_title_name.jsp"%>
<%@ include file="/npage/se112/footer.jsp"%>
<%@page import="com.sitech.crmpd.core.bean.MapBean"%>
<%@page import="java.util.*"%>
<%@page import="com.sitech.crmpd.core.util.SiUtil"%>
<%
	//update by songjia for hlj
	
	String xml = request.getParameter("reScore");
	String meansId = request.getParameter("meansId");
	String vCurPoint = request.getParameter("vCurPoint");
	String subScore=request.getParameter("subScore");
	String brandId=request.getParameter("brandId");
	String payMoney = request.getParameter("payMoney");
	String resourcefee = request.getParameter("resourcefee");
	String gScore = request.getParameter("gScore");
	String isRealName=request.getParameter("isRealName");
	System.out.println("-------brandId =" + brandId);
	System.out.println("-------subScore =" + subScore);
	System.out.println("-------现金金额 payMoney =" + payMoney);
	System.out.println("-------购机款 resourcefee =" + resourcefee);
	System.out.println("reScore_____________________" + xml);
	System.out.println("-------积分值 gScore =" + gScore);
	System.out.println("-------是否实名制 isRealName =" + isRealName);
	System.out.println("---222222----是否实名制 isRealName =" + isRealName);
 	MapBean mb = new MapBean();
 %>	
 <%@ include file="getMapBean.jsp"%>
 <%		
	Iterator it =null;
	
	List cashList = null;
		if(null != mb){
		cashList = mb.getList("OUT_DATA.H14");
		System.out.println("_________cashList________" + cashList.toString());
		
		if(null!=cashList)
			it =cashList.iterator();
	}


 %>
<html>
	<head>
	<title>抵消积分</title>
	</head>
	<body onload ="comit();" >
		<div id="operation">
		<form method="post" name="frm1147" action="">
				
				<div id="operation_table">
					<%
					String scoreType ="";
						if(null!=it){
						while(it.hasNext()){
						Map stMap = mb.isMap(it.next());
						if(null==stMap) continue;
						scoreType=(String)stMap.get("IS_SCORE") == null?"":(String)stMap.get("IS_SCORE");
						System.out.println("-----------------scoreType ="+scoreType);
						if("1".equals(scoreType)){
						%>
						 <div class="title">
							<div class="text">
								积分抵消购机款详细信息
							</div>
						</div>
						
						<%	
						}else if("2".equals(scoreType)){
						%>
							 <div class="title">
								<div class="text">
									积分抵消现金详细信息
								</div>
							</div>
							
						<%	
						}else if("3".equals(scoreType)){
						%>
							 <div class="title">
								<div class="text">
									积分抵消宽带包年款详细信息
								</div>
							</div>
							
						<%	
						}
					 %>
					 <div class="input">
					   <table>
					   		<tr>
								<th>当前积分</th>
								<td>
									<input type="text" name="vCurPoint" id="vCurPoint" value="<%=vCurPoint%>" readonly/>
								</td>
							</tr>
							<tr>
								<th>可抵消积分值</th>
								<td>
									<%
										if(null!=gScore&&!"".equals(gScore)&&!"null".equals(gScore)){
									%>
											<input type="text" name="scoreValue" id="scoreValue" value="<%=gScore %>"  readonly="readonly" onfocus="clear_do()"/>
											<input type="button" class="b_text" name="verify" id="verify" onclick="comit()" value="计算" />
									<%}else{%>
											<input type="text" name="scoreValue" id="scoreValue" value="" onfocus="clear_do()"/>
											<input type="button" class="b_text" name="verify" id="verify" onclick="comit()" value="计算" 
											<%if("0".equals(scoreType)) out.print("readonly") ;%>
											/>
									<%}%>
									<font style="color:red"><b>*</b></font>
								</td>
							</tr>
							<tr>
								<th>可抵消金额</th>
								<td>
									<input type="text" name="scoreMoney" readonly id="scoreMoney" value=""/>
								</td>
							</tr>

						<%}
						}%>
						</table>
						</div>
					<div id="operation_button">
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
	 function btnRsSubmit(){
	 	var scoreType = "<%=scoreType%>";
		var scoreValue = document.getElementById("scoreValue").value;
		var scoreMoney = document.getElementById("scoreMoney").value;
		if(scoreValue==null||scoreValue=="")
		{
			showDialog("请填写抵消积分!",0);
		 	return false;
		}
		//xin
		if(scoreValue>0 && "<%=isRealName%>" == "非实名"){ 
			showDialog("提醒进行实名登记后方可进行积分兑换操作!",0);
			return false;
		}
		if(scoreMoney==null||scoreMoney=="")
		{
			showDialog("请计算金额!",0);
		 	return false;
		}
		if("<%=subScore%>"!=null&&"<%=subScore%>"!=""&&"<%=subScore%>"!="null"){
			var a=parseFloat("<%=vCurPoint%>")-parseFloat("<%=subScore%>");
			if(parseFloat(scoreValue)>parseFloat(a)){
				showDialog("用户当前积分不足,请重新输入!",0);
		 		return false;
			}
		}
		if(parseFloat(scoreValue)>parseFloat("<%=vCurPoint%>"))
		{
			showDialog("用户当前积分不足,请重新输入!",0);
		 	return false;
		}
		if(parseFloat(scoreMoney)>parseFloat("<%=payMoney%>") && scoreType =="2")
		{
			showDialog("自动计算的积分超出可抵扣的金额,请重新输入!",0);
		 	return false;
		}

		if(scoreType == "1"){
			scoreType = "购机款";
		}
		if(scoreType == "2"){
			scoreType = "现金";
		}
		if(scoreType == "3"){
			scoreType = "宽带包年款";
		}
		var Desc = "积分值："+scoreValue+"，抵消"+scoreType+scoreMoney+"元";
		parent.document.getElementById("H14Score<%=meansId%>").innerHTML = Desc;	
		//提交报文
		if("<%=subScore%>"!=null&&"<%=subScore%>"!=""){
			parent.subScoreDisable();
		}
		if("<%=scoreType%>" == "3"){
			parent.subH14ScoreDisable();
		}
		parent.h14ScoreData(scoreValue,scoreMoney,"<%=scoreType%>");
		parent.counteractIntegral_Checkfuc();
		closeDivWin();
	}
	 
	function closeWin(){
		closeDivWin();
	}
	
	var tt =0;
	function comit(){
		if("<%=scoreType%>"=="1"){
			var packet = null;
			var scoreValue = $("#scoreValue").val();
			if(scoreValue!='0' && tt !=0){
				var f=scoreValue.substring(scoreValue.length-2,scoreValue.length);
				if (trim(f)!='00')
				{
					showDialog("抵消积分值必须为100的整数倍!",0);
					return false;
				}
				if(scoreValue.length=='2')
				{
					showDialog("抵消积分值必须为100的整数倍!",0);
					return false;
				}
				var dn="<%=brandId%>";
				packet = new AJAXPacket("scoreValueComit.jsp","请稍后...");
				packet.data.add("field_en_name",dn);
				packet.data.add("scoreValue",scoreValue);
				core.ajax.sendPacketHtml(packet,doComitCat,true);
				packet =null;
			}
			if(scoreValue =='0'){
				 document.getElementById("scoreMoney").value=scoreValue;
			}
		}else if("<%=scoreType%>"=="2"){
			var scoreValue = $("#scoreValue").val();
			var vCurPoint = "<%=vCurPoint%>";//当前客户总积分
			var ss = "";//模除100			
			if(scoreValue == ""){
				ss = vCurPoint%100;
				scoreValue = vCurPoint - ss;
				$("#scoreValue").val(scoreValue);
			}
			if(scoreValue!='0'  && tt !=0){
			    var f=scoreValue.substring(scoreValue.length-2,scoreValue.length);
				if (trim(f)!='00'){
					showDialog("抵消积分值必须为100的整数倍!",0);
					return false;
				}
				if(scoreValue.length=='2'){
					showDialog("抵消积分值必须为100的整数倍!",0);
					return false;
				}
			
				packet = new AJAXPacket("scoreValueComit.jsp","请稍后...");
				packet.data.add("field_en_name","cash");
				packet.data.add("scoreValue",scoreValue);
				core.ajax.sendPacketHtml(packet,cashDoComitCat,true);
				packet =null;
			}
			if(scoreValue =='0'){
				 document.getElementById("scoreMoney").value=scoreValue;
			}
			
			<%-- var d=scoreValue/100*1.2;
			if(parseFloat(d)>parseFloat("<%=payMoney%>") && tt !=0){
				showDialog("您输入的积分超出可抵扣的金额,请重新输入!",0);
				return false;
			}
			document.getElementById("scoreMoney").value=d; --%>
			
		}else if("<%=scoreType%>"=="3"){
			var scoreValue = $("#scoreValue").val();
			var vCurPoint = "<%=vCurPoint%>";//当前客户总积分
			var ss = "";//模除100			
			if(scoreValue == ""){
				ss = vCurPoint%100;
				scoreValue = vCurPoint - ss;
				$("#scoreValue").val(scoreValue);
			}
			if(scoreValue!='0'  && tt !=0){
			    var f=scoreValue.substring(scoreValue.length-2,scoreValue.length);
				if (trim(f)!='00'){
					showDialog("抵消积分值必须为100的整数倍!",0);
					return false;
				}
				if(scoreValue.length=='2'){
					showDialog("抵消积分值必须为100的整数倍!",0);
					return false;
				}
			
				packet = new AJAXPacket("scoreValueComit.jsp","请稍后...");
				packet.data.add("field_en_name","net");
				packet.data.add("scoreValue",scoreValue);
				core.ajax.sendPacketHtml(packet,netDoComitCat,true);
				packet =null;
			}
			if(scoreValue =='0'){
				 document.getElementById("scoreMoney").value=scoreValue;
			}
			
		}
		tt++;
	}
	function doComitCat(data){
		var idAndName =data.split(",");
		var c = $("#scoreValue").val();
		a=idAndName[0];
		b=idAndName[1];
		//var d=c/a*b;
		var d = numMulti(parseFloat(c/a),parseFloat(b));
		if(parseFloat(d)>parseFloat("<%=resourcefee%>")){
			showDialog("您输入的积分超出可抵扣的购机款,请重新输入!",0);
			return false;
		}
		document.getElementById("scoreMoney").value=d;
	}
	
	function cashDoComitCat(data){
		var idAndName =data.split(",");
		var c = $("#scoreValue").val();
		a=idAndName[0];
		b=idAndName[1];
		var d = numMulti(parseFloat(c/a),parseFloat(b));
		
		if(parseFloat(d)>parseFloat("<%=payMoney%>")){
			showDialog("您输入的积分超出可抵扣的金额,请重新输入!",0);
			return false;
		}
		document.getElementById("scoreMoney").value=d;
	}
	
	function netDoComitCat(data){
		var idAndName =data.split(",");
		var c = $("#scoreValue").val();
		a=idAndName[0];
		b=idAndName[1];
		var d=c/a*b;
		document.getElementById("scoreMoney").value=d;
	}
	
	function clear_do(){
		document.getElementById("scoreMoney").value="";
	}
	
	
	/*
	 *js小数计算精度问题:除法处理，避免数据相处小数点后产生多位数和计算精度损失
	 *@param num1 被除数|num2 除数
	*/
	function numDiv(num1,num2){
		var baseNum1 = 0,baseNum2 = 0;
		var baseNum3,baseNum4;
		try{
			baseNum1 = num1.toString().split(".")[1].length;
		}catch(e){
			baseNum1 = 0;
		}
		try{
			baseNum2 = num2.toString().split(".")[1].length;
		}catch(e){
			baseNum2 = 0;
		}
		
		with(Math){
			baseNum3 = Number(num1.toString().replace(".",""));
			baseNum4 = Number(num2.toString().replace(".",""));
			return (baseNum3/baseNum4)*pow(10,baseNum2-baseNum1);
		}
	}
	
	/*
	 *js小数计算精度问题:乘法运算，避免数据相处小数点后产生多位数和计算精度损失
	 *@param num1 被乘数|num2 乘数
	*/
	function numMulti(num1,num2){
		var baseNum = 0;
		try{
			baseNum += num1.toString().split(".")[1].length;
		}catch(e){
			
		}
		try{
			baseNum += num2.toString().split(".")[1].length;
		}catch(e){
			
		}
		
		return Number(num1.toString().replace(".",""))*Number(num2.toString().replace(".",""))/Math.pow(10,baseNum);
		
	}
	</script>
</html>