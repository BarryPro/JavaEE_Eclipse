<%
/********************
 version v2.0
������: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

	<%
		response.setHeader("Pragma","No-Cache");
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0);

		String opName      = "�°����Ʒͳһ����";
		String loginNo     = (String)session.getAttribute("workNo");
		String strPhoneNo  = request.getParameter("phoneno");
		String opCode      = request.getParameter("opcode");
		String projectCode = request.getParameter("projectCode"); // Ӫ��������
		String gradeCode   = request.getParameter("gradeCode");     // �ȼ�����
		String num         = request.getParameter("num");                 //�ڼ�����¼
		String packetCode  = request.getParameter("packetCode");
		String loginPwd    = (String)session.getAttribute("password");
		// δ�õ� ��̬��
		String projectCodeFlag = projectCode.substring(0,1);

		System.out.println("############################################");
	  System.out.println("##############"+projectCode+"#################");
	  System.out.println("##############"+gradeCode+"#################");
	  System.out.println("##############"+num+"#################");
	  System.out.println("##############"+packetCode+"#################");
	  System.out.println("###############################################");
	%>
	<wtc:service name="s6842SelDet" routerKey="phone" routerValue="<%=strPhoneNo%>" outnum="19" >
	    	
	  <wtc:param value=" "/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=loginNo%>"/>	
		<wtc:param value="<%=loginPwd%>"/>		
		<wtc:param value="<%=strPhoneNo%>"/>	
		<wtc:param value=" "/>	
		<wtc:param value="<%=projectCode%>"/>
	  <wtc:param value="<%=gradeCode%>"/>
			
	 </wtc:service>
	<wtc:array id="s6842SelDetArr" scope="end"/>
	<%  int errCode = retCode==""?999999:Integer.parseInt(retCode);
			String errMsg = "";
			if(s6842SelDetArr == null){
				errMsg = "s6842SelDet��ѯ����Ʒ�б�Ϊ��!<br> errCode:"+errCode+"<br>errMsg:"+retMsg;
		  }else if(errCode != 0){
		  	errMsg = "s6842SelDet��ѯ����Ʒ�б�ʧ��!<br> errCode:"+errCode+"<br>errMsg:"+retMsg;
		  }
	%>


<html>
	<head>
		<title>��Ʒ�б��ѯ</title>
	</head>
<body>
<form name="frm" method="POST">
<%@ include file="/npage/include/header_pop.jsp" %>
  <table cellspacing="0">
  	<tr align="center">
  		<th>ѡ��</th>
        <th>�������</th>
        <th>����Ʒ����</th>
        <th>����Ʒ����</th>
        <th>����</th>
        <th>�ֻ���ֵ������</th>
    </tr>

		<%
			String tbclass="";
			for(int j=0;j<s6842SelDetArr.length;j++){
				tbclass = j%2==0 ? "Grey" : "";
		%>
		<tr>
    	<td><input type="checkbox" name="listbox" value="<%=j%>" onclick="doSelect(this.value,this.checked)"></td>
    	<td><input type="hidden" name="PacketCode<%=j%>" value="<%=s6842SelDetArr[j][0]%>"><%=s6842SelDetArr[j][1]%></td>
    	<td><%=s6842SelDetArr[j][2]%></td>
    	<td><%=s6842SelDetArr[j][3]%></td>
    	<td><%=s6842SelDetArr[j][4]%></td>
    	<td>
    		<%if(!"-1".equals(s6842SelDetArr[j][5])){%>
    		<input type="text"   name="card_no<%=j%>" size="27" value="" readonly/><font color="orange">*</font>
    		<input type="button" name="card_no_qry<%=j%>" class="b_text" value="��ѯ" onClick="queryCard('<%=j%>')" disabled/>
    		<%}else{%>
    		<input type="hidden" name="card_no<%=j%>" size="20" value="NO" />
    		<%}%>
    		&nbsp;
      	<input type="hidden" name="cardType">
				<input type="hidden" name="valuebox0<%=j%>" value="<%=s6842SelDetArr[j][0]%>"><!--���code-->
				<input type="hidden" name="valuebox1<%=j%>" value="<%=s6842SelDetArr[j][1]%>"><!--���name-->
				<input type="hidden" name="valuebox2<%=j%>" value="<%=s6842SelDetArr[j][2]%>"><!--����Ʒcode-->
				<input type="hidden" name="valuebox3<%=j%>" value="<%=s6842SelDetArr[j][3]%>"><!--����Ʒname-->
				<input type="hidden" name="valuebox4<%=j%>" value="<%=s6842SelDetArr[j][4]%>"><!--����-->
				<input type="hidden" name="valuebox5<%=j%>" value="<%=s6842SelDetArr[j][5]%>"><!--�мۿ���ʶ-->
			</td>
    	</tr>
		<%
			}
		%>

	  <tr id="OpNote" style="display:">
    	<td align="center">��   ע</td>
      <td colspan="5">
      	<input name="opNote" type="text" id="opNote" class="button" size="60" maxlength="60" onFocus="setOpNote();" readonly>
    	</td>
    </tr>
    </table>



  <table cellspacing="0">
    <tr>
    	<td colspan="4" id="footer">
				<div align="center">
					<input name="confirm" class="b_foot" id="confirm" type="button"  value="ȷ��" onClick="reValue()" >&nbsp;
					<input name="reset" class="b_foot" type="button" value="�ر�" onClick="window.close();">&nbsp;
				</div>
			</td>
   	</tr>
	</TABLE>
	<input type="hidden" name="projectCode" value="<%=projectCode%>">
  <input type="hidden" name="gradeCode" value="<%=gradeCode%>">
	<input type="hidden" name="opcode" value="<%=opCode%>">
	<input type="hidden" name="phoneNo" value="<%=strPhoneNo%>">
<%@ include file="/npage/include/footer_pop.jsp" %>
</form>
</body>
</html>



<script type="text/javascript">
onload=function(){
	if('<%=errCode%>' != 0){
		rdShowMessageDialog("<%=errMsg%>");
	}
	var list = document.all.listbox;
	for(var j = 0; j < <%=s6842SelDetArr.length%>; j++){
		if(document.getElementById('PacketCode'+j).value == '<%=packetCode%>'){
			document.getElementsByName('listbox')[j].checked=true;
		}
	}
	showQueryCardButton();
}

function checkOneMsg(){
	for(var j = 0; j < <%=s6842SelDetArr.length%>; j++){
		if(document.getElementsByName('listbox')[j].checked) return true;
	}
	return false;
}
//if it is the card,check it's value
function checkCardIfHave(){
	for(var j = 0; j < <%=s6842SelDetArr.length%>; j++){
		if(document.getElementsByName('listbox')[j].checked){
			var cardVal = document.getElementById('card_no'+j).value;
			if(cardVal !='NO' && (cardVal == null || cardVal =='')){
				return false;
			}
		}
	}
	return true;
}
//ѡ���
function doSelect(i,k){
	var arr = document.getElementsByTagName('tr');
	var packetCode = arr[parseInt(i)+1].childNodes[1].firstChild.value; // ��code
	for(var j = 1; j < arr.length-2; j++){
		var tmpCode = arr[j].childNodes[1].firstChild;
		if(tmpCode.value == packetCode){// ͬһ�����µ���Ʒ
			if(k){
				arr[j].firstChild.firstChild.checked = 'checked';
			}else{
				arr[j].firstChild.firstChild.checked = false;
			}
		}else{ // ��ͬһ�����µ���Ʒ
			arr[j].firstChild.firstChild.checked = false;
		}
	}
	hiddenQueryCardButto();
	showQueryCardButton();
}
function showQueryCardButton(){
	for(var j = 0; j < <%=s6842SelDetArr.length%>; j++){
		if(document.getElementsByName('listbox')[j].checked && document.getElementById('card_no'+j).value != 'NO'){
			document.getElementById('card_no_qry'+j).disabled=false;
		}
	}
}
function hiddenQueryCardButto(){
	for(var j = 0; j < <%=s6842SelDetArr.length%>; j++){
		if(document.getElementById('card_no'+j).value != 'NO'){
			document.getElementById('card_no_qry'+j).disabled=true;
			document.getElementById('card_no'+j).value="";
		}
	}
}

/*��ѯ�ֻ���ֵ��*/
function queryCard(obj)
{
	//alert("��ѡ���"+obj+"����¼");
  document.all.confirm.disabled = false;
  var t = obj;
    var card_num = document.getElementById("valuebox4"+obj).value;
    var libaodaima = document.getElementById("valuebox2"+obj).value;
	var card_type = document.getElementById("valuebox5"+obj).value;//�мۿ�����
	//alert("card_num="+card_num+"card_type="+card_type);
	var ret = window.showModalDialog("./f6842_query_card.jsp?card_num="+card_num+"&card_type="+card_type+"&libaodaima="+libaodaima,"","dialogHeight:600px; dialogWidth:550px; dialogLeft:400px; dialogTop:400px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no");
	//var ret = window.open("./f6842_query_card.jsp?card_num="+card_num+"&card_type="+card_type);
	if(ret){
		document.getElementById("card_no"+obj).value = ret;//��ʼ����-��������
		document.getElementsByName('listbox')[obj].checked=true;
	}
}

function reValue(){
	with(document.frm)
	{
		if(!checkOneMsg()){
			rdShowMessageDialog("��ѡ������һ������Ʒ!");
			return false;
		}
		if(!checkCardIfHave()){
			rdShowMessageDialog("�������ֵ����!");
			return false;
		}
	}
	setOpNote();//��ע��ֵ
	var retStr = retWindowVal();
  window.returnValue = retStr;
  window.close();
}


//��ѡ��һ����Ʒ�����������Ʒ������  ��ѡ����������1 ��ûѡ�񣬷���0
//�ڼ���%����%����%����%������
function retWindowVal(){
	var m = 0;
	var k;    // �����һ����Ʒ���������
	var packageName;
	var packageCode;
	var card_no;    // ��ֵ����
	var beginCardNo = "";
	var endCardNo = "";
	var tempCardNo;
	var zhekahao="";
	var glbStr;
	var list = document.getElementsByName('listbox');
	var giftName_sum =0 ;
	var giftName_all ="";
	var gift_num = "";
    for(var i = 0; i < list.length; i++){
    	if(list[i].checked){
    		m++;
    		k = document.getElementById("valuebox4"+i).value;
    		packageName = document.getElementById("valuebox1"+i).value;
    		packageCode = document.getElementById("valuebox0"+i).value;
    		//card_no = document.getElementById("card_no"+i).value;
    		//alert("cardNo: " + card_no);
    		tempCardNo = document.getElementById("card_no"+i).value;
				//alert(tempCardNo);
    		if(tempCardNo != "NO" && tempCardNo.length > 2){
    		if(tempCardNo.indexOf(",") != -1) {   		
    		zhekahao +=tempCardNo+"";
    		}else {
	    		beginCardNo = beginCardNo + tempCardNo.substr(0,tempCardNo.indexOf("-")) + "|";
	    		endCardNo = endCardNo + tempCardNo.substr(tempCardNo.indexOf("-") + 1,tempCardNo.length-tempCardNo.indexOf("-")-1) + "|";
	    		}
	    	}
			//liyana
    		 /*ֻ��ʾ�н������ǰ����ʵ����Ʒ���ƣ��ӵȺţ��м䶺�ŷָ�*/
			if (i<=6)
			{
				giftName_all = giftName_all + ',' + document.getElementById("valuebox3"+i).value;
				//alert("giftName_all,1="+giftName_all);
			}


			giftName_sum = Number(giftName_sum) + Number(document.getElementById("valuebox4"+i).value) ;
			//alert("giftName_sum,2="+giftName_sum);
    	}

    }
    if(beginCardNo.length > 1 && endCardNo.length > 1){
	    card_no = beginCardNo + "-" + endCardNo;
	}else{
	if(zhekahao !="") {
	card_no=zhekahao;
	}else {
		card_no = tempCardNo;
		}
	}
	//alert("card_no " + card_no);
//	alert('M='+m);
	if(m == 0)
	{
		return 0;
	}
	if (m==7)
	{
		giftName_all= giftName_all + "��" ;
	}
	 if (m==1)
	{
		gift_num = k +"����Ʒ";
	}

	if (m>1)
	{
		gift_num = "1���������"+giftName_sum+"����Ʒ";
	}


	giftName_all=giftName_all.slice(1);
	//k = m==1 ? k : '1';
	//alert("giftName_all="+giftName_all);
	// alert("giftName_sum="+giftName_sum);
	//alert('='+'<%=num%>'+'%'+packageName + '%' + k  + '%' + card_no + '%' + packageCode);
	//�ڼ���%����%����%����%������
	//return '<%=num%>'+'%'+packageName + '%' + k  + '%' + card_no + '%' + packageCode;
	return '<%=num%>'+'%'+packageName + '%' + gift_num  + '%' + card_no + '%' + packageCode
			+ '%' + giftName_all + '%' + giftName_sum;
}

/******Ϊ��ע��ֵ********/
function setOpNote(){
	if(document.frm.opNote.value==""){
		if (document.frm.opcode.value == "7514"){
	  	document.frm.opNote.value = "�û�"+document.frm.phoneNo.value+"�콱����";
	  }else if (document.frm.opcode.value == "7515"){
	  	document.frm.opNote.value = "�û�"+document.frm.phoneNo.value+"ԤԼ�Ǽ�";
		}else{
			document.frm.opNote.value = "�û�"+document.frm.phoneNo.value+"�콱";
		}
	}
	return true;
}
</script>