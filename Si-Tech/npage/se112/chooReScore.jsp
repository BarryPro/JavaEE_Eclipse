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
	System.out.println("-------�ֽ��� payMoney =" + payMoney);
	System.out.println("-------������ resourcefee =" + resourcefee);
	System.out.println("reScore_____________________" + xml);
	System.out.println("-------����ֵ gScore =" + gScore);
	System.out.println("-------�Ƿ�ʵ���� isRealName =" + isRealName);
	System.out.println("---222222----�Ƿ�ʵ���� isRealName =" + isRealName);
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
	<title>��������</title>
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
								���ֵ�����������ϸ��Ϣ
							</div>
						</div>
						
						<%	
						}else if("2".equals(scoreType)){
						%>
							 <div class="title">
								<div class="text">
									���ֵ����ֽ���ϸ��Ϣ
								</div>
							</div>
							
						<%	
						}else if("3".equals(scoreType)){
						%>
							 <div class="title">
								<div class="text">
									���ֵ�������������ϸ��Ϣ
								</div>
							</div>
							
						<%	
						}
					 %>
					 <div class="input">
					   <table>
					   		<tr>
								<th>��ǰ����</th>
								<td>
									<input type="text" name="vCurPoint" id="vCurPoint" value="<%=vCurPoint%>" readonly/>
								</td>
							</tr>
							<tr>
								<th>�ɵ�������ֵ</th>
								<td>
									<%
										if(null!=gScore&&!"".equals(gScore)&&!"null".equals(gScore)){
									%>
											<input type="text" name="scoreValue" id="scoreValue" value="<%=gScore %>"  readonly="readonly" onfocus="clear_do()"/>
											<input type="button" class="b_text" name="verify" id="verify" onclick="comit()" value="����" />
									<%}else{%>
											<input type="text" name="scoreValue" id="scoreValue" value="" onfocus="clear_do()"/>
											<input type="button" class="b_text" name="verify" id="verify" onclick="comit()" value="����" 
											<%if("0".equals(scoreType)) out.print("readonly") ;%>
											/>
									<%}%>
									<font style="color:red"><b>*</b></font>
								</td>
							</tr>
							<tr>
								<th>�ɵ������</th>
								<td>
									<input type="text" name="scoreMoney" readonly id="scoreMoney" value=""/>
								</td>
							</tr>

						<%}
						}%>
						</table>
						</div>
					<div id="operation_button">
						 <input type="button" class="b_foot" value="ȷ��" id="btnSubmit"
							name="btnSubmit" onclick="btnRsSubmit()" />
						<input type="button" class="b_foot" value="�ر�" id="btnCancel"
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
			showDialog("����д��������!",0);
		 	return false;
		}
		//xin
		if(scoreValue>0 && "<%=isRealName%>" == "��ʵ��"){ 
			showDialog("���ѽ���ʵ���ǼǺ󷽿ɽ��л��ֶһ�����!",0);
			return false;
		}
		if(scoreMoney==null||scoreMoney=="")
		{
			showDialog("�������!",0);
		 	return false;
		}
		if("<%=subScore%>"!=null&&"<%=subScore%>"!=""&&"<%=subScore%>"!="null"){
			var a=parseFloat("<%=vCurPoint%>")-parseFloat("<%=subScore%>");
			if(parseFloat(scoreValue)>parseFloat(a)){
				showDialog("�û���ǰ���ֲ���,����������!",0);
		 		return false;
			}
		}
		if(parseFloat(scoreValue)>parseFloat("<%=vCurPoint%>"))
		{
			showDialog("�û���ǰ���ֲ���,����������!",0);
		 	return false;
		}
		if(parseFloat(scoreMoney)>parseFloat("<%=payMoney%>") && scoreType =="2")
		{
			showDialog("�Զ�����Ļ��ֳ����ɵֿ۵Ľ��,����������!",0);
		 	return false;
		}

		if(scoreType == "1"){
			scoreType = "������";
		}
		if(scoreType == "2"){
			scoreType = "�ֽ�";
		}
		if(scoreType == "3"){
			scoreType = "��������";
		}
		var Desc = "����ֵ��"+scoreValue+"������"+scoreType+scoreMoney+"Ԫ";
		parent.document.getElementById("H14Score<%=meansId%>").innerHTML = Desc;	
		//�ύ����
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
					showDialog("��������ֵ����Ϊ100��������!",0);
					return false;
				}
				if(scoreValue.length=='2')
				{
					showDialog("��������ֵ����Ϊ100��������!",0);
					return false;
				}
				var dn="<%=brandId%>";
				packet = new AJAXPacket("scoreValueComit.jsp","���Ժ�...");
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
			var vCurPoint = "<%=vCurPoint%>";//��ǰ�ͻ��ܻ���
			var ss = "";//ģ��100			
			if(scoreValue == ""){
				ss = vCurPoint%100;
				scoreValue = vCurPoint - ss;
				$("#scoreValue").val(scoreValue);
			}
			if(scoreValue!='0'  && tt !=0){
			    var f=scoreValue.substring(scoreValue.length-2,scoreValue.length);
				if (trim(f)!='00'){
					showDialog("��������ֵ����Ϊ100��������!",0);
					return false;
				}
				if(scoreValue.length=='2'){
					showDialog("��������ֵ����Ϊ100��������!",0);
					return false;
				}
			
				packet = new AJAXPacket("scoreValueComit.jsp","���Ժ�...");
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
				showDialog("������Ļ��ֳ����ɵֿ۵Ľ��,����������!",0);
				return false;
			}
			document.getElementById("scoreMoney").value=d; --%>
			
		}else if("<%=scoreType%>"=="3"){
			var scoreValue = $("#scoreValue").val();
			var vCurPoint = "<%=vCurPoint%>";//��ǰ�ͻ��ܻ���
			var ss = "";//ģ��100			
			if(scoreValue == ""){
				ss = vCurPoint%100;
				scoreValue = vCurPoint - ss;
				$("#scoreValue").val(scoreValue);
			}
			if(scoreValue!='0'  && tt !=0){
			    var f=scoreValue.substring(scoreValue.length-2,scoreValue.length);
				if (trim(f)!='00'){
					showDialog("��������ֵ����Ϊ100��������!",0);
					return false;
				}
				if(scoreValue.length=='2'){
					showDialog("��������ֵ����Ϊ100��������!",0);
					return false;
				}
			
				packet = new AJAXPacket("scoreValueComit.jsp","���Ժ�...");
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
			showDialog("������Ļ��ֳ����ɵֿ۵Ĺ�����,����������!",0);
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
			showDialog("������Ļ��ֳ����ɵֿ۵Ľ��,����������!",0);
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
	 *jsС�����㾫������:�����������������ദС����������λ���ͼ��㾫����ʧ
	 *@param num1 ������|num2 ����
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
	 *jsС�����㾫������:�˷����㣬���������ദС����������λ���ͼ��㾫����ʧ
	 *@param num1 ������|num2 ����
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