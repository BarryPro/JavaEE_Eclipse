<%
	
	String print_orgCode = (String) session.getAttribute("orgCode");
    String print_regionCode = print_orgCode.substring(0, 2);
	String f_gCustId=request.getParameter("gCustId");
	System.out.println("******************"+f_gCustId);
	if(f_gCustId==null)
		f_gCustId="0";
%>

	<wtc:utype name="sQryCustInfo" id="retCustInfos" scope="end"  routerKey="region" routerValue="<%=print_regionCode%>">
		 <wtc:uparam value="<%=f_gCustId%>" type="LONG"/>    
	</wtc:utype>


<script type="text/javascript">

var opInfo=function(opContent,orderArrayId,prodInfo,zfInfo,ffInfo,bzInfo){
	this.opContent=opContent;
	this.orderArrayId=orderArrayId;//定单子项
	this.prodInfo=prodInfo;//产品信息
	this.zfInfo=zfInfo;//自费信息
	this.ffInfo=ffInfo;//付费信息
	this.bzInfo=bzInfo;//备注信息
	
}

var otherInfo=function(){
	this.countNum="null";
	this.mode_code1="null";
	this.fav_code1="null";
	this.area_code1="null";
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

<%if(retCustInfos.getSize("2")>0){%>
 function printDetail(SphoneNo,EphoneNo,opInfo,otherInfo,printType){
	var regionCode="<%=print_regionCode%>";
	var cust_info=""; //客户信息
	var opr_info=""; //操作信息
	var retInfo = "";  //打印内容
	var cust_info="";
	var orderArrayId=opInfo.orderArrayId;
	var countNum=otherInfo.countNum;

	cust_info+="客户号码："+SphoneNo+"|";
	cust_info+="客户名称："+"<%=retCustInfos.getValue("2.0.4")%>"+"|";
	cust_info+="证件类型："+"<%=retCustInfos.getValue("2.0.11")%>"+"|";
	cust_info+="客户地址："+"<%=retCustInfos.getValue("2.0.10")%>"+"|";
	cust_info+="证件号码："+"<%=retCustInfos.getValue("2.0.12")%>"+"|";
	cust_info+="客户标志码："+" "+"|";

	var opr_info="";
	opr_info+="产品信息："+opInfo.prodInfo+"|";
	opr_info+="资费信息："+opInfo.zfInfo+"|";
	opr_info+="负费信息："+opInfo.ffInfo+"|";
	var backInfo="备注信息："+opInfo.bzInfo;
	
	var mode_code=otherInfo.mode_code1;//资费代码
	var fav_code=otherInfo.fav_code1;//特服代码b
	var area_code=otherInfo.area_code1;//小区代码
	if(mode_code==null) mode_code="null";
	if(fav_code==null) fav_code="null";
	if(area_code==null) area_code="null";
	var printStr=cust_info+"＃"+opr_info+"＃"+backInfo+"＃"+"登记事项："+opInfo.opContent+"＃"+"客户信息"+"＃";
	var ret=pubPrintElt("1",SphoneNo,EphoneNo,orderArrayId,"",countNum,regionCode,printStr,printType,"确实要打印电子免填单吗？","Yes",mode_code,fav_code,area_code);
	return ret;
}

function printDetailBill(phoneNo,custOrderId,custName,phoneType,big,small,detail1,detail2,opNote,mode_code,fav_code,area_code){
	var regionCode="<%=print_regionCode%>";
	var formname=document.frm;
	var cust_info=""; //客户信息
	var note_info=opNote;
	var retInfo = "";  //打印内容

	var cust_info="";
	cust_info+="手机号码："+phoneNo+"|";
	cust_info+="客户姓名："+custName+"|";
	cust_info+="卡号类型："+phoneType+"|";

	if(mode_code==null) mode_code="null";
	if(fav_code==null) fav_code="null";
	if(area_code==null) area_code="null";

	var printStr=cust_info+"#"+big+"#"+small+"#"+detail1+"#"+detail2+"#"+note_info+"#";
	
	var ret=pubPrintElt("2",phoneNo,"",custOrderId,"","1",regionCode,printStr,"N","确实要打印发票吗？","Yes",mode_code,fav_code,area_code);
	return ret;
}


function pubPrintElt(billType,SphoneNo,EphoneNo,orderArrayId,servOrderId,countNum,regionCode,printStr,printType,dlgMessage,submitCfm,mode_code,fav_code,area_code){
	printStr=printStr.replace(new RegExp("#","gm"),"%23");
	var h=150;
	var w=350;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	var path = "<%=request.getContextPath()%>/npage/public/print/EltPrint_jc.jsp?DlgMsg=" + dlgMessage+ "&submitCfm=" + submitCfm+"&orderArrayId="+orderArrayId+"&countNum="+countNum+"&regionCode="+regionCode;
	var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code	="+area_code+"&opCode=<%=opCode%>"+"&SphoneNo="+SphoneNo+"&EphoneNo="+EphoneNo+"&submitCfm="+submitCfm+"&pType="+printType+"&billType="+billType+"&printInfo=" + printStr+"&servOrderId="+servOrderId;
	var ret=window.showModalDialog(path,printStr,prop);
	return ret;
}

<%}%>



</script>

