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
	//System.out.println("����ǰ��"+mm1);
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
	//System.out.println("���ú�"+mm2);
	//System.out.println("##################�ܵ���ʱ�䣺"+(mm2-mm1)+"����");
%>


<script type="text/javascript">

/*-----------��������----------------*/
var opInfo=function(){
	this.opContent;
	this.orderArrayId;//��������
	this.prodInfo;//��Ʒ��Ϣ
	this.zfInfo;//�Է���Ϣ
	this.ffInfo;//������Ϣ
	this.bzInfo;//��ע��Ϣ
	
}

/*------------������Ϣ------------*/
var otherInfo=function(){
	this.countNum="1";
	this.mode_code1="null";
	this.fav_code1="null";
	this.area_code1="null";
}
/*------------��������Ϣ------*/
var doPerson=function(){
	this.pName="";//����������
	this.idNo="";//���������
	this.idType="";//������֤������
	this.admissibility="";//�����˼���ַ
}


//ʧ�ܵ���
function deleteFail(loginAccept,orderArrayId,opCode,billType){
	if(billType==null) billType="1";
	var noprint_Packet = new AJAXPacket("/npage/public/print/fPubSaveNoPrint.jsp","���ڴ�ӡ�����Ժ�......");
	noprint_Packet.data.add("opCode",opCode);
	noprint_Packet.data.add("billType","1");
	noprint_Packet.data.add("login_accept",loginAccept);
	noprint_Packet.data.add("arrayOrderId",orderArrayId);
	core.ajax.sendPacket(noprint_Packet,doNoPrint);
	noprint_Packet=null;
}

function doNoPrint(packet){
}
//�ϴ����ĵ���
function pubPrintDetail(phoneNo,custOrderId){
	var h=150;
	var w=350;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	var path = "<%=request.getContextPath()%>/npage/public/print/EltPrint_pub.jsp?servOrderId="+custOrderId+"&phoneNo="+phoneNo;
	window.showModalDialog(path,"pubprint",prop);


}

//��Ʊ��ӡ
function printDetailBill(phoneNo,custOrderId, custName,opType,amount,city,accept,        detail,dlgInfo,     mode_code,fav_code,area_code,memo){
	//var regionCode="<%=print_regionCode%>";
	var dlgMsg="Ʊ�����ݣ�"+dlgInfo+"<br>ȷʵҪ��ӡ��Ʊ��";
	if(mode_code==null) mode_code="null";
	if(fav_code==null) fav_code="null";
	if(area_code==null) area_code="null";
	
	//alert("memo|"+memo);
	var printStr=phoneNo+" #"+opType+" #"+custName+" #"+detail+" #"+amount+" #"+city+" #"+accept+" #"+memo+" #";

	var ret=pubPrintElt("2",phoneNo,"",custOrderId,"","1","<%=print_regionCode%>",printStr,"N",dlgMsg,"Yes",accept,mode_code,fav_code,area_code);
	return ret;
}

//�վݴ�ӡ
function printDetailBill2(phoneNo,custOrderId,custName,opType,amount,city,accept,detail,dlgInfo,mode_code,fav_code,area_code){
	//var regionCode="<%=print_regionCode%>";
	var dlgMsg="<font style='color:red;'>�վ����ݣ�</font>"+dlgInfo+"<br>ȷʵҪ��ӡ�վ���";
	if(mode_code==null) mode_code="null";
	if(fav_code==null) fav_code="null";
	if(area_code==null) area_code="null";

	var printStr=phoneNo+" #"+opType+" #"+custName+" #"+detail+" #"+amount+" #"+city+" #"+accept+" #";
	//alert(printStr);

	var ret=pubPrintElt("3",phoneNo,"",custOrderId,"","1","<%=print_regionCode%>",printStr,"N",dlgMsg,"Yes",accept,mode_code,fav_code,area_code);
	return ret;
}

function pubPrintElt(billType,SphoneNo,EphoneNo,orderArrayId,servOrderId,countNum,regionCode,printStr,printType,dlgMessage,submitCfm,accept,mode_code,fav_code,area_code){
	if(printType=="Y" && billType=="1"){//�жϺϴ�
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
	var subprint_Packet = new AJAXPacket("<%=request.getContextPath()%>/npage/public/print/savePrint.jsp","���ڴ�ӡ�����Ժ�......");
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
		alert("�洢��ӡ����"+retMsg);
	}
	setLoginAccept(retVal);

}


</script>

