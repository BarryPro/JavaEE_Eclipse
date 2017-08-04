<%
	String f_workNo=(String) session.getAttribute("workNo");
	String print_orgCode = (String) session.getAttribute("orgCode");
    String print_regionCode = print_orgCode.substring(0, 2);
	String f_gCustId=request.getParameter("gCustId");
	String f_orderArrayId=request.getParameter("custOrderId");
	if(f_orderArrayId==null)
		f_orderArrayId="0";
	if(f_gCustId==null)
		f_gCustId="0";
	//long mm1=System.currentTimeMillis();
	//System.out.println("调用前："+mm1);
%>

	<wtc:pubselect name="sPubSelect" outnum="3" retval="buyPerson">
		<wtc:sql>
			SELECT a.cust_name,b.id_name,a.id_iccid
			FROM dborderadm.dCustOrderContactInfo a,sIdType b
			WHERE cust_order_id='?'
			AND b.id_type=a.id_type
			AND rela_type='2'
		</wtc:sql>
		<wtc:param value="<%=f_orderArrayId%>" />
	</wtc:pubselect>
	<wtc:array id="f_row" property="buyPerson" scope="end"/>
<%

	//long mm2=System.currentTimeMillis();
	//System.out.println("调用后："+mm2);
	//System.out.println("##################总调用时间："+(mm2-mm1)+"毫秒");
%>


<script type="text/javascript">

/*-----------受理内容----------------*/
var opInfo=function(){
	this.opContent;
	this.orderArrayId;//定单子项
	this.prodInfo;//产品信息
	this.zfInfo;//自费信息
	this.ffInfo;//付费信息
	this.bzInfo;//备注信息
	
}

/*------------其他信息------------*/
var otherInfo=function(){
	this.countNum="1";
	this.mode_code1="null";
	this.fav_code1="null";
	this.area_code1="null";
}
/*------------代办人信息------*/
var doPerson=function(){
	this.pName="";//代办人名称
	this.idNo="";//代办人身份
	this.idType="";//代办人证件类型
	this.admissibility="";//受理人及地址
}


//失败调用
function deleteFail(loginAccept,orderArrayId,opCode,billType){
	if(billType==null) billType="1";
	var noprint_Packet = new AJAXPacket("/npage/public/print/fPubSaveNoPrint.jsp","正在打印，请稍候......");
	noprint_Packet.data.add("opCode",opCode);
	noprint_Packet.data.add("billType","1");
	noprint_Packet.data.add("login_accept",loginAccept);
	noprint_Packet.data.add("arrayOrderId",orderArrayId);
	core.ajax.sendPacket(noprint_Packet,doNoPrint);
	noprint_Packet=null;
}

function doNoPrint(packet){
}
//合打最后的调用
function pubPrintDetail(phoneNo,custOrderId){
	var h=150;
	var w=350;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	var path = "<%=request.getContextPath()%>/npage/public/print/EltPrint_pub.jsp?servOrderId="+custOrderId+"&phoneNo="+phoneNo;
	window.showModalDialog(path,"pubprint",prop);


}

//发票打印
function printDetailBill(phoneNo,custOrderId, custName,opType,amount,city,accept,        detail,dlgInfo,     mode_code,fav_code,area_code,memo){
	//var regionCode="<%=print_regionCode%>";
	var dlgMsg="票据内容："+dlgInfo+"<br>确实要打印发票吗？";
	if(mode_code==null) mode_code="null";
	if(fav_code==null) fav_code="null";
	if(area_code==null) area_code="null";
	
	//alert("memo|"+memo);
	var printStr=phoneNo+" #"+opType+" #"+custName+" #"+detail+" #"+amount+" #"+city+" #"+accept+" #"+memo+" #";

	var ret=pubPrintElt("2",phoneNo,"",custOrderId,"","1","<%=print_regionCode%>",printStr,"N",dlgMsg,"Yes",accept,mode_code,fav_code,area_code);
	return ret;
}

//收据打印
function printDetailBill2(phoneNo,custOrderId,custName,opType,amount,city,accept,detail,dlgInfo,mode_code,fav_code,area_code){
	//var regionCode="<%=print_regionCode%>";
	var dlgMsg="<font style='color:red;'>收据内容：</font>"+dlgInfo+"<br>确实要打印收据吗？";
	if(mode_code==null) mode_code="null";
	if(fav_code==null) fav_code="null";
	if(area_code==null) area_code="null";

	var printStr=phoneNo+" #"+opType+" #"+custName+" #"+detail+" #"+amount+" #"+city+" #"+accept+" #";
	//alert(printStr);

	var ret=pubPrintElt("3",phoneNo,"",custOrderId,"","1","<%=print_regionCode%>",printStr,"N",dlgMsg,"Yes",accept,mode_code,fav_code,area_code);
	return ret;
}

function pubPrintElt(billType,SphoneNo,EphoneNo,orderArrayId,servOrderId,countNum,regionCode,printStr,printType,dlgMessage,submitCfm,accept,mode_code,fav_code,area_code){
	if(printType=="Y" && billType=="1"){//判断合打
		pubPrintElt_ajax(billType,SphoneNo,EphoneNo,orderArrayId,servOrderId,countNum,regionCode,printStr,printType,dlgMessage,submitCfm,mode_code,fav_code,area_code)
	}else{
		printStr=printStr.replace(new RegExp("#","gm"),"%23");
		var h=150;
		var w=350;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
		var path = "<%=request.getContextPath()%>/npage/public/print/EltPrint_jc.jsp?DlgMsg=" + dlgMessage+ "&submitCfm=" + submitCfm+"&orderArrayId="+orderArrayId+"&countNum="+countNum+"&regionCode="+regionCode;
		var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code	="+area_code+"&opCode=<%=opCode%>"+"&SphoneNo="+SphoneNo+"&EphoneNo="+EphoneNo+"&submitCfm="+submitCfm+"&pType="+printType+"&billType="+billType+"&printInfo=" + printStr+"&servOrderId="+servOrderId+"&accept="+accept;
		var ret=window.showModalDialog(path,printStr,prop);
		return ret;
	}
}


function pubPrintElt_ajax(billType,SphoneNo,EphoneNo,orderArrayId,servOrderId,countNum,regionCode,printStr,printType,dlgMessage,submitCfm,mode_code,fav_code,area_code){
	var subprint_Packet = new AJAXPacket("<%=request.getContextPath()%>/npage/public/print/savePrint.jsp","正在打印，请稍候......");
	subprint_Packet.data.add("DlgMsg",dlgMessage);
	subprint_Packet.data.add("submitCfm",submitCfm);
	subprint_Packet.data.add("orderArrayId",orderArrayId);
	subprint_Packet.data.add("countNum",countNum);
	subprint_Packet.data.add("regionCode",regionCode);
	subprint_Packet.data.add("mode_code",mode_code);
	subprint_Packet.data.add("fav_code",fav_code);
	subprint_Packet.data.add("area_code",area_code);
	subprint_Packet.data.add("opCode","<%=opCode%>");
	subprint_Packet.data.add("SphoneNo",SphoneNo);
	subprint_Packet.data.add("EphoneNo",EphoneNo);
	subprint_Packet.data.add("submitCfm",submitCfm);
	subprint_Packet.data.add("pType",printType);
	subprint_Packet.data.add("billType",billType);
	subprint_Packet.data.add("regionCode",regionCode);
	subprint_Packet.data.add("printInfo",printStr);
	subprint_Packet.data.add("servOrderId",servOrderId);
	core.ajax.sendPacket(subprint_Packet,getLoginAceept,true);
	subprint_Packet=null;

}

function getLoginAceept(packet){
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	var retVal = packet.data.findValueByName("retVal");	
	if(retCode!="0"){
		alert("存储打印出错，"+retMsg);
	}
	setLoginAccept(retVal);

}


</script>

