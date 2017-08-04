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
	this.orderArrayId=orderArrayId;//��������
	this.prodInfo=prodInfo;//��Ʒ��Ϣ
	this.zfInfo=zfInfo;//�Է���Ϣ
	this.ffInfo=ffInfo;//������Ϣ
	this.bzInfo=bzInfo;//��ע��Ϣ
	
}

var otherInfo=function(){
	this.countNum="null";
	this.mode_code1="null";
	this.fav_code1="null";
	this.area_code1="null";
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

<%if(retCustInfos.getSize("2")>0){%>
 function printDetail(SphoneNo,EphoneNo,opInfo,otherInfo,printType){
	var regionCode="<%=print_regionCode%>";
	var cust_info=""; //�ͻ���Ϣ
	var opr_info=""; //������Ϣ
	var retInfo = "";  //��ӡ����
	var cust_info="";
	var orderArrayId=opInfo.orderArrayId;
	var countNum=otherInfo.countNum;

	cust_info+="�ͻ����룺"+SphoneNo+"|";
	cust_info+="�ͻ����ƣ�"+"<%=retCustInfos.getValue("2.0.4")%>"+"|";
	cust_info+="֤�����ͣ�"+"<%=retCustInfos.getValue("2.0.11")%>"+"|";
	cust_info+="�ͻ���ַ��"+"<%=retCustInfos.getValue("2.0.10")%>"+"|";
	cust_info+="֤�����룺"+"<%=retCustInfos.getValue("2.0.12")%>"+"|";
	cust_info+="�ͻ���־�룺"+" "+"|";

	var opr_info="";
	opr_info+="��Ʒ��Ϣ��"+opInfo.prodInfo+"|";
	opr_info+="�ʷ���Ϣ��"+opInfo.zfInfo+"|";
	opr_info+="������Ϣ��"+opInfo.ffInfo+"|";
	var backInfo="��ע��Ϣ��"+opInfo.bzInfo;
	
	var mode_code=otherInfo.mode_code1;//�ʷѴ���
	var fav_code=otherInfo.fav_code1;//�ط�����b
	var area_code=otherInfo.area_code1;//С������
	if(mode_code==null) mode_code="null";
	if(fav_code==null) fav_code="null";
	if(area_code==null) area_code="null";
	var printStr=cust_info+"��"+opr_info+"��"+backInfo+"��"+"�Ǽ����"+opInfo.opContent+"��"+"�ͻ���Ϣ"+"��";
	var ret=pubPrintElt("1",SphoneNo,EphoneNo,orderArrayId,"",countNum,regionCode,printStr,printType,"ȷʵҪ��ӡ���������","Yes",mode_code,fav_code,area_code);
	return ret;
}

function printDetailBill(phoneNo,custOrderId,custName,phoneType,big,small,detail1,detail2,opNote,mode_code,fav_code,area_code){
	var regionCode="<%=print_regionCode%>";
	var formname=document.frm;
	var cust_info=""; //�ͻ���Ϣ
	var note_info=opNote;
	var retInfo = "";  //��ӡ����

	var cust_info="";
	cust_info+="�ֻ����룺"+phoneNo+"|";
	cust_info+="�ͻ�������"+custName+"|";
	cust_info+="�������ͣ�"+phoneType+"|";

	if(mode_code==null) mode_code="null";
	if(fav_code==null) fav_code="null";
	if(area_code==null) area_code="null";

	var printStr=cust_info+"#"+big+"#"+small+"#"+detail1+"#"+detail2+"#"+note_info+"#";
	
	var ret=pubPrintElt("2",phoneNo,"",custOrderId,"","1",regionCode,printStr,"N","ȷʵҪ��ӡ��Ʊ��","Yes",mode_code,fav_code,area_code);
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

