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
							�Ծɻ��»������ģʽ
						</div>
					</div>
					<div class="input">
					<table>
						<tr>
							<th>�ֶ���ӻ���</th>
							<td>
								<input type="button" class="b_text" name="verify" id="verify" onclick="addRow()" value="����"/>
							</td>
							<th>ѡ����ӻ���</th>
							<td>
								<input type="button" class="b_text" name="verify" id="verify" onclick="chooseRes()" value="ѡ��"/>
							</td>
						</tr>
					</table>
					<div class="title">
					<div class="text">
						�ն���Ϣ
					</div>
					</div>
						<table id="resTable">						
							<tr>
								<th>Ʒ��</th>
								<th>����</th>
								<th>�ֿ۽��</th>
								<th>����</th>
							</tr>									
						</table>							
						</div>
					<div id="operation_button"><!-- disabled="disabled" -->
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
	
    function addRow() {  //�����Ӽ�¼ҳ��
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
            td4.innerHTML="<input type='button' value='ɾ��' class='b_text' onclick='removeRow(this)' />";
        
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
		//Ʒ��
		var resBrand = document.getElementsByName("resBrand");
		//����
		var resType = document.getElementsByName("resType");
		//���
		var resCost = document.getElementsByName("resCost");
		
		if(resBrand.length == 0){
			showDialog("����ӡ��Ծɻ��¡����ͣ��ٵ��ȷ����ť!",0);
		 	return false;	
		}
		
		for(var j =0;j<resBrand.length;j++){
			if(resBrand[j].value == ""){
				showDialog("��ӵĵ�"+(j+1)+"�����,Ʒ�Ʋ���Ϊ�գ�����д!",0);
		 		return false;
			}
			if(resType[j].value == ""){
				showDialog("��ӵĵ�"+(j+1)+"�����,�ͺŲ���Ϊ�գ�����д!",0);
		 		return false;
			}
			if(resCost[j].value == ""){
				showDialog("��ӵĵ�"+(j+1)+"�����,�ֿ۽���Ϊ�գ�����д!",0);
		 		return false;
			}
		
			resBrandStr = resBrandStr + split + resBrand[j].value;
			resTypeStr = resTypeStr + split + resType[j].value;
			resCostStr = resCostStr + split + resCost[j].value;
			show_desc = show_desc +"#"+(j+1)+". Ʒ�ƣ�"+resBrand[j].value+"�����ͣ�"+resType[j].value+"���ֿ۽�"+resCost[j].value+" Ԫ";
			costSum= costSum+parseFloat(resCost[j].value);
			split = "#";
		}
		
		if(parseFloat(pay_moneycould) < parseFloat(costSum)){
			showDialog("�ֿ۽���ۼ�ֵ���ڴ��ն�Ӫ����û����ɽ����������!",0);
		 	return false;	
		}
		
		show_desc = show_desc.substring(1,show_desc.length).replace( /#/g, "<br>");
		//alert(show_desc);
		parent.addOldResData(show_desc,resBrandStr,resTypeStr,resCostStr);
		//չ��
		parent.oldRes_Checkfuc();
		closeDivWin();
	
	}
	
	//�ն�
	function chooseRes(){
		window.open("<%=request.getContextPath()%>/npage/se112/hljclientList.jsp",'ѡ���ն�','width=550px,height=620px');
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
            td4.innerHTML="<input type='button' value='ɾ��' class='b_text' onclick='removeRow(this)' />";
        
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