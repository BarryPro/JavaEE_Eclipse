<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
	<%
		response.setHeader("Pragma","No-Cache");
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0);
  %>
  <%
		String opName      = "新版促销品统一付奖";
		String opCode      = request.getParameter("opcode");
		String strPhoneNo  = request.getParameter("phoneno");
		String packetCode  = request.getParameter("packetCode");
		String tmpresCode  = request.getParameter("tmpresCode");
		String num         = request.getParameter("num");       //第几条记录
		String operFlag         = request.getParameter("operFlag");  //getAward：领奖 conditions：有条件、无条件上线
		String regCode    = (String)session.getAttribute("regCode");
		//tmpresCode =packetCode.substring(1, packetCode.length()); 
		/*
    if("getAward".equals(operFlag)){
      tmpresCode =packetCode.substring(1, packetCode.length()); 
    }else{
      tmpresCode = packetCode;
    }*/

		String  inParams [] = new String[2];
    inParams[0] = " select a.package_name,b.res_code,d.res_name,b.res_sum,c.res_type "
                  +"from dbgiftrun.RS_PROGIFT_PACKAGE_INFO a, dbgiftrun.RS_PROGIFT_PACKAGE_DETAIL b ,dbgiftrun.RS_PROGIFT_PT_INFO c,dbgiftrun.rs_code_info d "
                  +"where a.package_code = b.package_code "
                  +"and b.res_code = c.res_code "
                  +"and c.res_code = d.res_code "
                  +"and a.package_code =:packagecode";
    inParams[1] = "packagecode="+tmpresCode;
	%>
	
  <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="5"> 
    <wtc:param value="<%=inParams[0]%>"/>
    <wtc:param value="<%=inParams[1]%>"/> 
  </wtc:service>  
  <wtc:array id="s6842SelDetArr"  scope="end"/>
	
	<%  int errCode = retCode==""?999999:Integer.parseInt(retCode);
			String errMsg = "";
			if(s6842SelDetArr.length == 0){
				errMsg = "s6842SelDet查询促销品列表为空!<br> errCode:"+errCode+"<br>errMsg:"+retMsg;
		  }else if(errCode != 0||errCode!=000000){
		  	errMsg = "s6842SelDet查询促销品列表失败!<br> errCode:"+errCode+"<br>errMsg:"+retMsg;
		  }
		  System.out.println("--diling--f2266_getItemNew.jsp---2266---sql1="+inParams[0]);
		  System.out.println("--diling--f2266_getItemNew.jsp---2266---sql2="+inParams[1]);
		  System.out.println("--diling--f2266_getItemNew.jsp---2266---f2266_getItemNew.jsp-------tmpresCode="+tmpresCode);
	%>
	<%
  String showName = "手机充值卡卡号";
  String  inParams1 [] = new String[2];
  inParams1[0] = "SELECT CASE "
               +" WHEN a.res_type LIKE 'w%' THEN "
               +" 'WLAN充值卡卡号' when a.res_type like 'd%' then '手机充值卡卡号' when a.res_type like 'l%' then '流量卡充值卡卡号'  "
               +" ELSE "
               +" '卡折卡号' "
               +" END "
               +" FROM dbgiftrun.RS_PROGIFT_PT_INFO a "
               +" WHERE a.res_Code =:rescode  ";
  inParams1[1] = "rescode="+s6842SelDetArr[0][1];
  
	%>
  <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1"> 
    <wtc:param value="<%=inParams1[0]%>"/>
    <wtc:param value="<%=inParams1[1]%>"/> 
  </wtc:service>  
  <wtc:array id="ret"  scope="end"/>
<%
  if("000000".equals(retCode1)){
    if(ret.length>0){
      showName = ret[0][0];
    }
  }
%>
<html>
	<head>
		<title>礼品列表查询</title>
	</head>
<body>
<form name="frm" method="POST">
<%@ include file="/npage/include/header_pop.jsp" %>
  <table cellspacing="0">
  	<tr align="center">
  		<th>选择</th>
        <th>礼包名称</th>
        <th>促销品代码</th>
        <th>促销品名称</th>
        <th>数量</th>
        <th><%=showName%></th>
    </tr>

		<%
			String tbclass="";
			for(int j=0;j<s6842SelDetArr.length;j++){
				tbclass = j%2==0 ? "Grey" : "";
				
				System.out.println("-------------2266---diling----s6842SelDetArr["+j+"][0]="+s6842SelDetArr[j][0]);
				System.out.println("-------------2266---diling----s6842SelDetArr["+j+"][1]="+s6842SelDetArr[j][1]);
				System.out.println("-------------2266---diling----s6842SelDetArr["+j+"][2]="+s6842SelDetArr[j][2]);
				System.out.println("-------------2266---diling----s6842SelDetArr["+j+"][3]="+s6842SelDetArr[j][3]);
				System.out.println("-------------2266---diling----s6842SelDetArr["+j+"][4]="+s6842SelDetArr[j][4]);
		%>
		<tr>
    	<td><input type="checkbox" name="listbox" value="<%=j%>" onclick="doSelect(this.value,this.checked)"></td>
    	<td><input type="hidden" name="PacketCode<%=j%>" value="<%=packetCode%>"><%=s6842SelDetArr[j][1]%></td>
    	<td><%=s6842SelDetArr[j][1]%></td>
    	<td><%=s6842SelDetArr[j][2]%></td>
    	<td><%=s6842SelDetArr[j][3]%></td>
    	<td>
    		<%if(!"-1".equals(s6842SelDetArr[j][4])){%>
    		<input type="text"   name="card_no<%=j%>" size="27" value="" readonly/><font color="orange">*</font>
    		<input type="button" name="card_no_qry<%=j%>" class="b_text" value="查询" onClick="queryCard('<%=j%>')" disabled/>
    		<%}else{%>
    		<input type="hidden" name="card_no<%=j%>" size="20" value="NO" />
    		<%}%>
    		&nbsp;
      	<input type="hidden" name="cardType">
				<input type="hidden" name="valuebox0<%=j%>" value="<%=packetCode%>"><!--礼包code-->
				<input type="hidden" name="valuebox1<%=j%>" value="<%=s6842SelDetArr[j][0]%>"><!--礼包name-->
				<input type="hidden" name="valuebox2<%=j%>" value="<%=s6842SelDetArr[j][1]%>"><!--促销品code-->
				<input type="hidden" name="valuebox3<%=j%>" value="<%=s6842SelDetArr[j][2]%>"><!--促销品name-->
				<input type="hidden" name="valuebox4<%=j%>" value="<%=s6842SelDetArr[j][3]%>"><!--数量-->
				<input type="hidden" name="valuebox5<%=j%>" value="<%=s6842SelDetArr[j][4]%>"><!--有价卡标识-->
			</td>
    	</tr>
		<%
			}
		%>

	  <tr id="OpNote" style="display:">
    	<td align="center">备   注</td>
      <td colspan="5">
      	<input name="opNote" type="text" id="opNote" class="button" size="60" maxlength="60" onFocus="setOpNote();" readonly>
    	</td>
    </tr>
    </table>



  <table cellspacing="0">
    <tr>
    	<td colspan="4" id="footer">
				<div align="center">
					<input name="confirm" class="b_foot" id="confirm" type="button"  value="确认" onClick="reValue()" >&nbsp;
					<input name="reset" class="b_foot" type="button" value="关闭" onClick="window.close();">&nbsp;
				</div>
			</td>
   	</tr>
	</TABLE>
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
//选择包
function doSelect(i,k){
	var arr = document.getElementsByTagName('tr');
	var packetCode = arr[parseInt(i)+1].childNodes[1].firstChild.value; // 包code
	for(var j = 1; j < arr.length-2; j++){
		var tmpCode = arr[j].childNodes[1].firstChild;
		if(tmpCode.value == packetCode){// 同一个包下的礼品
			if(k){
				arr[j].firstChild.firstChild.checked = 'checked';
			}else{
				arr[j].firstChild.firstChild.checked = false;
			}
		}else{ // 非同一个包下的礼品
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

/*查询手机充值卡*/
function queryCard(obj)
{
	//alert("您选择第"+obj+"条记录");
  document.all.confirm.disabled = false;
  var t = obj;
  var card_num = document.getElementById("valuebox4"+obj).value;
  var libaodaima = document.getElementById("valuebox2"+obj).value;
	var card_type = document.getElementById("valuebox5"+obj).value;//有价卡类型
	//alert("card_num="+card_num+"card_type="+card_type);
	var ret = window.showModalDialog("./f2266_query_cardNew.jsp?card_num="+card_num+"&card_type="+card_type+"&libaodaima="+libaodaima,"","dialogHeight:600px; dialogWidth:550px; dialogLeft:400px; dialogTop:400px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no");
	//var ret = window.open("./f6842_query_card.jsp?card_num="+card_num+"&card_type="+card_type);
	if(ret){
		document.getElementById("card_no"+obj).value = ret;//开始卡号-结束卡号
		document.getElementsByName('listbox')[obj].checked=true;
	}
}

function reValue(){
	with(document.frm)
	{
		if(!checkOneMsg()){
			rdShowMessageDialog("请选择至少一个促销品!");
			return false;
		}
		if(!checkCardIfHave()){
			rdShowMessageDialog("请输入充值卡号!");
			return false;
		}
	}
	setOpNote();//备注赋值
	//alert(document.frm.opNote.value);
	var retStr = retWindowVal();
  window.returnValue = retStr;
  window.close();
}


//若选择一个礼品，返回这个礼品的数量  若选择多个，返回1 若没选择，返回0
//第几条%包名%数量%卡号%包代码
function retWindowVal(){
	var m = 0;
	var k;    // 如果是一个礼品，存放数量
	var packageName;
	var packageCode;
	var card_no;    // 充值卡号
	var beginCardNo = "";
	var endCardNo = "";
	var tempCardNo;
	var zhekahao="";
	var glbStr;
	var list = document.getElementsByName('listbox');
	var giftName_sum =0 ;
	var giftName_all ="";
	var giftCardType ="" ;
	var gift_num = "";
	var v_cardNos = "";
    for(var i = 0; i < list.length; i++){
    	if(list[i].checked){
    		m++;
    		k = document.getElementById("valuebox4"+i).value;
    		packageName = document.getElementById("valuebox1"+i).value;
    		packageCode = document.getElementById("valuebox0"+i).value;
    		giftCardType = document.getElementById("valuebox5"+i).value;
    		//card_no = document.getElementById("card_no"+i).value;
    		//alert("cardNo: " + card_no);
    		tempCardNo = document.getElementById("card_no"+i).value;
    		if(tempCardNo != "NO" && tempCardNo.length > 2){
      		if(tempCardNo.indexOf(",") != -1) {
      		  zhekahao +=tempCardNo+"";
      		}else {
  	    		beginCardNo = beginCardNo + tempCardNo.substr(0,tempCardNo.indexOf("-")) + "|";
  	    		endCardNo = endCardNo + tempCardNo.substr(tempCardNo.indexOf("-") + 1,tempCardNo.length-tempCardNo.indexOf("-")-1) + "|";
  	    	  v_cardNos = v_cardNos + tempCardNo + "|" ;
  	    	  //alert("v_cardNos="+v_cardNos);
  	    	}
	    	}
			//liyana
    		 /*只显示中奖礼包中前六个实物礼品名称，加等号，中间逗号分割*/
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
	    //card_no = beginCardNo + "-" + endCardNo;
	    card_no = v_cardNos ;
	}else{
  	if(zhekahao !="") {
  	  card_no = zhekahao;
  	}else{
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
		giftName_all= giftName_all + "等" ;
	}
	 if (m==1)
	{
		gift_num = k +"个礼品";
	}

	if (m>1)
	{
		gift_num = "1个礼包包含"+giftName_sum+"个礼品";
	}


	giftName_all=giftName_all.slice(1);
	//k = m==1 ? k : '1';
	//alert("giftName_all="+giftName_all);
	// alert("giftName_sum="+giftName_sum);
	//alert('='+'<%=num%>'+'%'+packageName + '%' + k  + '%' + card_no + '%' + packageCode);
	//第几条%包名%数量%卡号%包代码%备注%卡类型
	//return '<%=num%>'+'%'+packageName + '%' + k  + '%' + card_no + '%' + packageCode;
	return '<%=num%>'+'%'+packageName + '%' + gift_num  + '%' + card_no + '%' + packageCode
			+ '%' + giftName_all + '%' + giftName_sum + '%'+ document.frm.opNote.value + '%'+giftCardType;
}

/******为备注赋值********/
function setOpNote(){
	if(document.frm.opNote.value==""){
		if (document.frm.opcode.value == "7514"){
	  	document.frm.opNote.value = "用户"+document.frm.phoneNo.value+"领奖冲正";
	  }else if (document.frm.opcode.value == "7515"){
	  	document.frm.opNote.value = "用户"+document.frm.phoneNo.value+"预约登记";
		}else{
			document.frm.opNote.value = "用户"+document.frm.phoneNo.value+"领奖";
		}
	}
	return true;
}
</script>