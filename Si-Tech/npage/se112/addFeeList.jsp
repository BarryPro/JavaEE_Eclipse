<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/se112/public_title_name.jsp"%>
<%@ include file="/npage/se112/footer.jsp"%>
<%

	String actType = request.getParameter("actType")==null?"":request.getParameter("actType");
	String brandId =request.getParameter("brandId");//Ʒ��
	String mode_code =request.getParameter("mode_code");
	String powerRight=request.getParameter("powerRight");//�û�Ȩ��
	String belong_code=request.getParameter("belong_code");//�û�����
	String id_no=request.getParameter("id_no");//�û�����
	System.out.println("-------------------�ʷѷ�������ʷ�----------------");
%>
<html>
	<head>
		<title>�ʷ�ѡ����</title>
	</head>
	<body>
			<form name="frm" action="" method="post">
			<div id="operation">
				<div id="operation_table">
					<div class="input">
					<table>

						<tr id="mhcx">
							<td  colspan = "2">
								ģ����ѯ<input id="prodName"  value='' size="60" />
								<input type="button" id = "qrymhProdbtn" value="��ѯ" class="b_text" onclick="qrymhProd()"/>
							</td>
						<tr>
						<tr>	
							<td  colspan = "2" >
								�����ʷ�����<input id="tb"  value='--����ת��--' size="60" disabled = "true"/>
							<input type="hidden" id="tb_h"/>
							<input type="button" id = "qryPrdbtn" value="ȷ��" class="b_text" onclick="addFee()"/>
							</td>
						</tr>
					</table>
					<table id="prodTable" style="overflow-y:auto;">
						<tr>
							<td colspan="5" id="prcId">
								�����ʷ�ʵ��: 
							</td>
							<input type="hidden" name="prcNo"/>
							<input type="hidden" name="prcName"/>
							<input type="hidden" name="prcMoney"/>
							<input type="hidden" name="offSetType"/>
							<input type="hidden" name="offSetUnit"/>
							<input type="hidden" name="xqFlag"/>
						</tr>
					</table>
					<div id="operation_button">
						<input class="b_foot" type="button" name="qry" value="ȷ��"
							onclick="add_do()" />
						<input class="b_foot" type="button" name="re" value="ȡ��"
							onclick="window.close()" />
					</div>
					</div>	
				</div>
				</div>
			</form>
		
	</body>
</html>
<script language="JavaScript">

function qrymhProd(){
	var prodName = document.getElementById("prodName").value;
	if(trim(prodName) == ""){
		showDialog("�������ѯ����",1);
	}else{
		focusQuickNav();
	}
}
function feeList(prcId,prcName,prcMoney,offSetType,offSetUnit,xqFlag){
	var tab = document.all("prodTable");
	document.all("prcNo").value=trim(prcId);
	document.all("prcName").value=trim(prcName);
	document.all("prcMoney").value=trim(prcMoney);
	document.all("offSetType").value=trim(offSetType);
	document.all("offSetUnit").value=trim(offSetUnit);
	document.all("xqFlag").value=trim(xqFlag);
	document.getElementById("prcId").innerHTML="�����ʷ�ʵ��:"+prcName;
}
function add_do(){
	var prodPrcId = document.all("prcNo").value;
	if(prodPrcId==""||prodPrcId==null||prodPrcId==undefined){
		alert("��ѡ������ʷ�");
		return false;
	}

	var packet = new AJAXPacket("<%=request.getContextPath()%>/npage/se112/getPriFee.jsp","���Ժ�...");
	packet.data.add("id_no","<%=id_no%>");
	packet.data.add("actType","<%=actType%>");
	packet.data.add("brandId","<%=brandId%>");
	packet.data.add("mode_code","<%=mode_code%>");
	packet.data.add("powerRight","<%=powerRight%>");
	packet.data.add("belong_code","<%=belong_code%>");
	packet.data.add("prodPrcId",prodPrcId);
	packet.data.add("actType","<%=actType%>");
	core.ajax.sendPacketHtml(packet,getPriFeeDate,true);//�첽
	packet = null;
}


function getPriFeeDate(data){
	var prodPrcId = document.all("prcNo").value;
	var prodPrcName = document.all("prcName").value;
	var prcMoney = document.all("prcMoney").value;
	var offSetType = document.all("offSetType").value;
	var offSetUnit = document.all("offSetUnit").value;
	var xqFlag = document.all("xqFlag").value;
	var idAndName = data.split("~");
	if(trim(idAndName[0])!= '000000'){ 
		 showDialog(trim(idAndName[1]),1);
		 return false;
	}
	
	var prodPrcIdAndName = (trim(prodPrcName)).split("_");
	window.opener.addAddFee(prodPrcIdAndName[0],prodPrcIdAndName[1],prcMoney,offSetType,offSetUnit,idAndName[2],idAndName[3],idAndName[4],idAndName[5],idAndName[6],idAndName[7],idAndName[8],xqFlag);
	window.close();
}

function focusQuickNav(){
	var obj = document.getElementById("tb");
	obj.disabled=true;
	$("#qryPrdbtn").attr("disabled", "true");
	obj.value="���ݼ�����...";
	quickFlag = false;		
	getQuickNavData(obj);
	quickFlag = true;	
		//prodFlaginfo = bandFlag;	
}


function getQuickNavData(obj){ 
	var prodName = trim(document.getElementById("prodName").value);
	var packet = new AJAXPacket("<%=request.getContextPath()%>/npage/se112/getAddFee.jsp","���Ժ�...");
	packet.data.add("prodName",prodName);
	packet.data.add("actType","<%=actType%>");
	core.ajax.sendPacketHtml(packet,doProcessNav,true);//�첽
	packet = null;
}

var prodIdArr=new Array();
var prodNameArr=new Array();
var prodMoneyArr=new Array();
var offSetTypeArr=new Array();
var offSetUnitArr=new Array();
var xqFlagArr= new Array();
function doProcessNav(data){
	$("#tb").removeAttr("disabled");
	$("#qryPrdbtn").removeAttr("disabled");
	document.getElementById('tb').value="";
	var idAndName = data.split("#");
	if(trim(idAndName[0]) == '403013938' || trim(idAndName[0]) == '111111111'){ 
		 //showDialog(idAndName[1].trim(),1);
		 showDialog(trim(idAndName[1]),1,"closeFunc=reqryPrd()");
		 //reqryPrd();
	}else{
	prodIdArr = idAndName[0].split("^");
	prodNameArr = idAndName[1].split("^");
	prodMoneyArr = idAndName[2].split("^");
	offSetTypeArr = idAndName[3].split("^");
	offSetUnitArr = idAndName[4].split("^");
	xqFlagArr = idAndName[5].split("^");
    actb(document.getElementById('tb'),document.getElementById('tb_h'),prodNameArr);
    }
}

function addFee(){
	var idx = document.getElementById('tb_h').value;
	var feeName = document.getElementById('tb').value;
	if(prodIdArr[idx]!=undefined){
		feeList(prodIdArr[idx],feeName,prodMoneyArr[idx],offSetTypeArr[idx],offSetUnitArr[idx],xqFlagArr[idx]);
	}
}



</script>
