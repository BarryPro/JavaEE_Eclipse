<%
/********************
 *version v2.0
 *������: si-tech
 *update by qidp @ 2008-12-23 ҳ�����,�޸���ʽ
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%
    String opCode = "1201";
    String opName = "�����а���";

    String loginNo = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String powerCode= (String)session.getAttribute("powerCode");
    String orgCode = (String)session.getAttribute("orgCode");
    String ip_Addr = (String)session.getAttribute("ip_Addr");
    String regionCode = orgCode.substring(0,2);
    String loginNoPass = (String)session.getAttribute("password");
    String aftertrim = ((String)session.getAttribute("powerRight")).trim();
    System.out.println("---------------������-----"+aftertrim);
%>
<%
  String retFlag="",retMsg="";//�����ж�ҳ��ս���ʱ����ȷ��
/****************���ƶ�����õ����롢���������� ����Ϣ s1201Init***********************/
  //SPubCallSvrImpl impl = new SPubCallSvrImpl();
  //ArrayList retList = new ArrayList();
  String[] paraAray1 = new String[4];
  String phoneNo = request.getParameter("srv_no");
  String passwordFromSer="";

  paraAray1[0] = phoneNo;	/* �ֻ�����   */
  paraAray1[1] = loginNo; 	/* ��������   */
  paraAray1[2] = orgCode;	/* ��������   */
  paraAray1[3] = "1201";	/* ��������   */
  for(int i=0; i<paraAray1.length; i++)
  {
	if( paraAray1[i] == null )
	{
	  paraAray1[i] = "";
	}
  }
  //retList = impl.callFXService("s1201Init", paraAray1, "27","phone",phoneNo);
%>

    <wtc:service name="s1201Init" routerKey="phone" routerValue="<%=phoneNo%>" retcode="s1201InitCode" retmsg="s1201InitMsg" outnum="27">
        <wtc:params value="<%=paraAray1%>"/>
    </wtc:service>
    <wtc:array id="s1201InitArr" scope="end" />

<%
  String  bp_name="",sm_code="",rate_code="",bigCust_flag="",sm_name="",rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="",prepay_fee="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="",group_type_code="",group_type_name="",imain_stream="",next_main_stream="",hand_fee="",favorcode="",card_no="",print_note="";
  //String[][] tempArr= new String[][]{};
  //int errCode = impl.getErrCode();
  //String errMsg = impl.getErrMsg();

  String errCode = s1201InitCode;
  String errMsg = s1201InitMsg;
  if(s1201InitArr == null)
  {
	if(!retFlag.equals("1"))
	{
	   retFlag = "1";
	   retMsg = "s1201Init��ѯ���������ϢΪ��!";
    }
  }else{
	if (errCode.equals("000000")){
	  if(!(s1201InitArr[0][3].equals(""))){
	    bp_name = s1201InitArr[0][3];//��������
	  }

	  if(!(s1201InitArr[0][4].equals(""))){
	    bp_add = s1201InitArr[0][4];//�ͻ���ַ
	  }

	  if(!(s1201InitArr[0][2].equals(""))){
	    passwordFromSer = s1201InitArr[0][2];//����
	  }

	  if(!(s1201InitArr[0][11].equals(""))){
	    sm_code = s1201InitArr[0][11];//ҵ�����
	  }

	  if(!(s1201InitArr[0][12].equals(""))){
	    sm_name = s1201InitArr[0][12];//ҵ���������
	  }

	  if(!(s1201InitArr[0][13].equals(""))){
	    hand_fee = s1201InitArr[0][13];//������
	  }

	  if(!(s1201InitArr[0][14].equals(""))){
	    favorcode = s1201InitArr[0][14];//�Żݴ���
	  }

	  if(!(s1201InitArr[0][5].equals(""))){
	    rate_code = s1201InitArr[0][5];//�ʷѴ���
	  }

	  if(!(s1201InitArr[0][6].equals(""))){
	    rate_name = s1201InitArr[0][6];//�ʷ�����
	  }

	  if(!(s1201InitArr[0][7].equals(""))){
	    next_rate_code = s1201InitArr[0][7];//�����ʷѴ���
	  }

	  if(!(s1201InitArr[0][8].equals(""))){
	    next_rate_name = s1201InitArr[0][8];//�����ʷ�����
	  }

	  if(!(s1201InitArr[0][9].equals(""))){
	    bigCust_flag = s1201InitArr[0][9];//��ͻ���־
	  }

	  if(!(s1201InitArr[0][10].equals(""))){
	    bigCust_name = s1201InitArr[0][10];//��ͻ�����
	  }

	  if(!(s1201InitArr[0][15].equals(""))){
	    lack_fee = s1201InitArr[0][15];//��Ƿ��
	  }

	  if(!(s1201InitArr[0][16].equals(""))){
	    prepay_fee = s1201InitArr[0][16];//��Ԥ��
	  }

	  if(!(s1201InitArr[0][17].equals(""))){
	    cardId_type = s1201InitArr[0][17];//֤������
	  }

	  if(!(s1201InitArr[0][18].equals(""))){
	    cardId_no = s1201InitArr[0][18];//֤������
	  }

	  if(!(s1201InitArr[0][19].equals(""))){
	    cust_id = s1201InitArr[0][19];//�ͻ�id
	  }

	  if(!(s1201InitArr[0][20].equals(""))){
	    cust_belong_code = s1201InitArr[0][20];//�ͻ�����id
	  }

	  if(!(s1201InitArr[0][21].equals(""))){
	    group_type_code = s1201InitArr[0][21];//���ſͻ�����
	  }

	  if(!(s1201InitArr[0][22].equals(""))){
	    group_type_name = s1201InitArr[0][22];//���ſͻ���������
	  }

	  if(!(s1201InitArr[0][23].equals(""))){
	    imain_stream = s1201InitArr[0][23];//��ǰ�ʷѿ�ͨ��ˮ
	  }

	  if(!(s1201InitArr[0][24].equals(""))){
	    next_main_stream = s1201InitArr[0][24];//ԤԼ�ʷѿ�ͨ��ˮ
	  }

	  if(!(s1201InitArr[0][25].equals(""))){
	    print_note = s1201InitArr[0][25];//��������
	  }

	}else{
		if(!retFlag.equals("1"))
	    {
	       retFlag = "1";
	       retMsg = "s1201Init��ѯ���������Ϣʧ��!<br>" + "errCode: " + errCode + "<br>errMsg: " + errMsg;
        }
	}
  }

////******************�õ�����������***************************//
//  comImpl co=new comImpl();
//  //�ʷѴ���
//  String sqlNewRateCode  = "";
//  sqlNewRateCode  = "select c.mode_code||'~'||a.pay_type||'~'||round(months_between(a.end_time,a.begin_time)),  c.mode_code||'--'||c.mode_name from sbillmoderelease a,sbillmodecode c where substr(a.group_id,1,2)=c.region_code and a.mode_code=c.mode_code and c.region_code ='" + orgCode.substring(0,2) + "' and a.mode_code in ( select new_mode from cBillBbChg  where region_code='" +  orgCode.substring(0,2) + "' and op_code='1201' and POWER_RIGHT <=" + aftertrim + " and old_mode='" + rate_code + "')";
//  System.out.println("sqlNewRateCode=============" + sqlNewRateCode);
//  ArrayList newRateCodeArr  = co.spubqry32("2",sqlNewRateCode );
//  String[][] newRateCodeStr  = (String[][])newRateCodeArr.get(0);
//  //���ݿ�����
//  String sqlCardType  = "";
//  sqlCardType  = "select card_type||'~'||year_fee||'~'||card_name, card_type||'--'||card_name from sDataCardYear " ;
//  ArrayList cardTypeArr  = co.spubqry32("2",sqlCardType );
//  String[][] cardTypeStr  = (String[][])cardTypeArr.get(0);

%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>�����а���</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">

<script language="JavaScript">
  <%if(retFlag.equals("1")){%>
    rdShowMessageDialog("<%=retMsg%>");
    history.go(-1);
  <%}%>

<!--
  //����Ӧ��ȫ�ֵı���
  var SUCC_CODE	= "0";   		//�Լ�Ӧ�ó�����
  var ERROR_CODE  = "1";			//�Լ�Ӧ�ó�����
  var YE_SUCC_CODE = "0000";	 	//����Ӫҵϵͳ������޸�

  var oprType_Add = "a";
  var oprType_Upd = "u";
  var oprType_Del = "d";
  var oprType_Qry = "q";

  var arrContractNo = new Array();//�ϲ���ͬ��
  var arrPayType = new Array();//��������

  //core.loadUnit("debug");
  //core.loadUnit("rpccore");

  onload=function()
  {
	  //core.rpc.onreceive = doProcess;
  }
  //---------1------RPC������------------------
  function doProcess(packet){

  	//added by hanfa 20070116 begin
  	var vRetPage=packet.data.findValueByName("rpc_page");

  	if(vRetPage == "querySmcode")
	{
		var errCode = packet.data.findValueByName("errCode");
	    var errMsg = packet.data.findValueByName("errMsg");
		var m_smCode = packet.data.findValueByName("m_smCode");
		self.status="";

		if(errCode == 0)
		{
			document.all.m_smCode.value = m_smCode;
		}else
		{
			rdShowMessageDialog("����:"+ errCode + "->" + errMsg,0);
			return false;
		}
	}//added by hanfa 20070116 end
	else
	{
		//ʹ��RPC��ʱ��,��������������Ϊ��׼ʹ��.
		var errorCode = packet.data.findValueByName("errorCode");
		var errorMsg =  packet.data.findValueByName("errorMsg");
		var verifyType = packet.data.findValueByName("verifyType");
		var bind_cust_name = "";
		arrContractNo = packet.data.findValueByName("arrContractNo");
		arrPayType = packet.data.findValueByName("arrPayType");
		bind_cust_name = packet.data.findValueByName("bind_cust_name");

		self.status="";
		if(verifyType=="confirm"){
		  if( parseInt(errorCode) == 0 ){
			 document.frm.bind_cust_name.value = bind_cust_name;
			 document.frm.ifValid.value="1";
			 rdShowMessageDialog("��֤�ɹ�!",2);
		  }else{
			document.frm.ifValid.value="0";
			rdShowMessageDialog("������룺"+errorCode+"������Ϣ��"+errorMsg,0);
			return false;
		  }
	    }
  	}
  }
  /**************/
  function commitRpc()
  {
	if(!checkElement(document.frm.bind_phone_no))
	{
		return false;
	}
	var phoneNo = document.frm.bind_phone_no.value;
	var myPacket = new AJAXPacket("f1203RpcConfirm.jsp");
	myPacket.data.add("verifyType","confirm");
	myPacket.data.add("loginNo","<%=loginNo%>");
	myPacket.data.add("loginNoPass","<%=loginNoPass%>");
	myPacket.data.add("opCode","1201");
	myPacket.data.add("orgCode","<%=orgCode%>");
	myPacket.data.add("phoneNo",phoneNo);
	core.ajax.sendPacket(myPacket);
 	myPacket = null;
  }
  //***
  function frmCfm(){
 	frm.submit();
	return true;
  }
  //***//У��
  function check(){
 	with(document.frm){

	  if(conf_flag.value=="")
	  {
	    rdShowMessageDialog("��ѡ��ϻ���־!");
	    conf_flag.focus();
	    return false;
	  }

	  if(conf_flag.value=="01")//�ϻ�
	  {

	    if(!checkElement(bind_phone_no)) return false;

		if(!(document.frm.ifValid.value=="1"))
		{
			rdShowMessageDialog("����֤���ֻ�����!");
			return false;
		}
	  }

	  if(new_rate_code_1.value==""){
	    rdShowMessageDialog("��ѡ�����ʷѴ���!");
		new_rate_code_1.focus();
		return false;
	  }
	  if(card_type_1.value==""){
	    rdShowMessageDialog("��ѡ�����ݿ�����!");
		card_type_1.focus();
		return false;
	  }
	}

	var now_rate_code = "<%=rate_code%>";
    var next_rate_code = "<%=next_rate_code%>";
	var new_rate_code = document.frm.new_rate_code.value;
    if(now_rate_code==next_rate_code && now_rate_code==new_rate_code){
	  rdShowMessageDialog("��ǰ�ʷѡ������ʷѡ����ʷ����߲�����ȫ��ͬ����ȷ��!");
	  return false;
	}

	return true;
  }

  //�����һ����ťʱ,Ϊ��һ��ҳ����֯����
  function setParaForNext(){
    var iOpCode = "1201";//iOpCode
	//iAddStr��ʽ pay_type|year_fee|prepay_fee|year_month|card_type|card_name|bind_cust_name| ����card_type��card_name��bind_cust_name������E�а���
	var iAddStr = document.frm.pay_type.value + "|" + document.frm.year_fee.value + "|" +  document.frm.year_fee.value + "|" + (Math.round(document.frm.year_month.value)+Math.round(1)) + "|" + document.frm.card_type.value + "|" + document.frm.card_name.value+"~"+document.frm.conf_flag.value + "~" + document.frm.bind_phone_no.value + "~" +  "" + "|" + document.frm.bind_cust_name.value + ""; //iAddStr
	var belong_code = "<%=cust_belong_code%>"; //belong_code
    var i2 =  "<%=cust_id%>"  ; //�ͻ�ID
   // var i16 = "<%=rate_code+"--"+rate_name%>";//�����ײʹ��루�ϣ�
   var i16 = "<%=rate_code%>";
    var ip = document.frm.new_rate_code.value;//�������ײʹ���(��)
    var i1 = document.frm.phoneNo.value;//  �ֻ�����
    var i4 = "<%=bp_name%>";//  �ͻ�����
    var i5 = "<%=bp_add%>";//  �ͻ���ַ
    var i6 = "<%=cardId_type%>";//   ֤������
    var i7 = "<%=cardId_no%>";//  ֤������
    var ipassword = ""; // ����
    var group_type = "<%=group_type_code+"--"+group_type_name%>";//���ſͻ����
    var ibig_cust = "<%=bigCust_flag+"--"+bigCust_name%>";// ��ͻ����
    var i18 =  "<%=next_rate_code + "--" + next_rate_name%>"; //�������ײͣ�
    var i19 =  "<%=hand_fee%>";//   ������
    var i20 =  "<%=hand_fee%>";  // ���������
    var i8 =   "<%=sm_name%>";  //   ҵ��Ʒ��
    var do_note = document.frm.opNote.value;// �û���ע��
    var favorcode =  "<%=favorcode%>";  // �������Ż�Ȩ��
    var maincash_no = "<%=rate_code%>";//�����ײʹ��루�ϣ�
    var imain_stream = "<%=imain_stream%>"; //��ǰ���ʷѿ�ͨ��ˮ
    var next_main_stream = "<%=next_main_stream%>";//ԤԼ���ʷѿ�ͨ��ˮ

	var str = "iOpCode="+iOpCode+
		                              "&iAddStr="+iAddStr +
				                      "&belong_code="+belong_code +
				                      "&i2="+i2 +
				                      "&i16="+i16 +
				                      "&ip="+ip +
				                      "&i1="+i1 +
				                      "&i4="+i4 +
				                      "&i5="+i5 +
				                      "&i6="+i6 +
				                      "&i7="+i7 +
				                      "&ipassword="+ipassword +
				                      "&group_type="+group_type +
				                      "&ibig_cust="+ibig_cust +
				                      "&i18="+i18 +
				                      "&i19="+i19 +
				                      "&i20="+i20 +
				                      "&i8="+i8 +
				                      "&do_note="+do_note +
				                      "&favorcode="+favorcode +
				                      "&maincash_no="+maincash_no +
				                      "&imain_stream="+imain_stream +
				                      "&next_main_stream="+next_main_stream;

	//alert(str);
	document.frm.iOpCode.value = iOpCode;
	document.frm.iAddStr.value = iAddStr;
	document.frm.belong_code.value = belong_code;
	document.frm.i2.value = i2;
	document.frm.i16.value = i16;
	document.frm.ip.value = ip;
	document.frm.i1.value = i1;
	document.frm.i4.value = i4;
	document.frm.i5.value = i5;
	document.frm.i6.value = i6;
	document.frm.i7.value = i7;
	document.frm.ipassword.value = ipassword;
	document.frm.group_type.value = group_type;
	document.frm.ibig_cust.value = ibig_cust;
	document.frm.i18.value = i18;
	document.frm.i19.value = i19;
	document.frm.i20.value = i20;
	document.frm.i8.value = i8;
	document.frm.do_note.value = do_note;
	document.frm.favorcode.value = favorcode;
    document.frm.maincash_no.value = maincash_no;
	document.frm.imain_stream.value = imain_stream;
	document.frm.next_main_stream.value = next_main_stream;
	frm.action = "fa270_3_year.jsp";
  }

  /***** �ύǰ����Ʒ��ת����ʾ��Ϣ added by hanfa 20070118 begin *****/
  function submitCfm(subButton)
  {
  		if(document.all.smCode.value == "zn" && document.all.m_smCode.value == "gn")
  		{
  			//ѦӢ�� 20070716 R_HLJMob_cuisr_CRM_PD3_2007_226@���ڻ��������������������� zn->gn ���ֲ�����
  		}
  		else
  		{
	  		if((document.all.m_smCode.value !="") && (document.all.m_smCode.value != document.all.smCode.value))
	  			rdShowMessageDialog("�ò����漰��Ʒ�Ʊ�����������л��֣���Mֵ�������ʷ���Ч�Ĵ��³����㣬������ʱ�һ�");
  		}
		printCommit(subButton);
  }
  /***** �ύǰ����Ʒ��ת����ʾ��Ϣ added by hanfa 20070118 end *****/

  function printCommit(subButton){
	controlButt(subButton);//��ʱ���ư�ť�Ŀ�����
	//У��
	if(!check()) return false;
	setOpNote();//Ϊ��ע��ֵ
	//Ϊ��һ��ҳ����֯���ݲ���
	setParaForNext();
    //�ύ��
    frmCfm();
	return true;
  }
/**�����ʷѴ��붯̬�õ��������͡��������ڵ���Ϣ**/
 function setSomeInfo(){
   var tempStr = document.frm.new_rate_code_1.value;
   var newRateCode = oneTok(tempStr,"~",1);//���ʷѺ���
   var payType =  oneTok(tempStr,"~",2);//��������
   var yearMonth =  oneTok(tempStr,"~",3);//��������

   document.frm.new_rate_code.value = newRateCode;
   document.frm.pay_type.value = payType;
   document.frm.year_month.value = yearMonth;

   if(document.frm.new_rate_code_1.value != "") //added by hanfa 20070118
   {
   		querySmcode();
   }
   getMidPrompt("10442",codeChg(newRateCode),"ipTd");
   return true;
}
/**�����ݿ����͵õ����������Ϣ**/
 function setYearFee(){
   var tempStr = document.frm.card_type_1.value;
   prepay_fee="<%=prepay_fee%>";
   var cardType = oneTok(tempStr,"~",1);//���ݿ�����
   var shouldYearFee =  oneTok(tempStr,"~",2);//��С������
   var cardName = oneTok(tempStr,"~",3);//���ݿ�����
   document.frm.card_type.value = cardType;
   document.frm.year_fee.value = shouldYearFee;
   document.frm.card_name.value = cardName;

   return true;
}
/******Ϊ��ע��ֵ********/
function setOpNote(){
	if(document.frm.opNote.value=="")
	{
	  document.frm.opNote.value = "��E;"+document.frm.phoneNo.value+";��:"+document.frm.card_type.value+";��ǰ:<%=rate_code%>;��:"+document.frm.new_rate_code.value;
	}
	return true;
}
/**�ɺϻ���־��̬�ı���ֻ����еĿɼ���**/
function controlBindPhoneNoTrView(){
  var conf_flag = document.frm.conf_flag.value;
  if(conf_flag=="00")
  {
    document.all.bindPhoneNoTr.style.display = "none";
  }else if(conf_flag=="01")
  {
    document.all.bindPhoneNoTr.style.display = "";
  }
  return true;
}

  //������������ѯ�ʷѴ�����Ӧ��Ʒ�ƴ��� added by hanfa 20070117
  function querySmcode()
  {
	  var myPacket = new AJAXPacket("querySmcode_rpc.jsp","���ڻ����Ϣ�����Ժ�......");
	  myPacket.data.add("modeCode",(document.all.new_rate_code.value).trim());
	  core.ajax.sendPacket(myPacket);
	  myPacket = null;
  }

//-->
</script>
</head>


<body>
<form name="frm" method="post">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
    <div id="title_zi">ҵ�����</div>
</div>
	<!-- added by hanfa 20070117-->
  	<input type="hidden" name="smCode" value="<%=sm_code%>">
  	<input type="hidden" name="m_smCode" value="">


      <table border="0" cellspacing="0">
		  <tr>
		    <td class="blue">�ֻ�����</td>
            <td>
			  <input name="phoneNo" type="text" id="phoneNo" value="<%=phoneNo%>" class="InputGrey" readonly>
			</td>
		    <td class="blue">��������</td>
            <td>
			  <input name="bp_name" type="text" id="bp_name" value="<%=bp_name%>" class="InputGrey" readonly>
			</td>
          </tr>
          <tr>
		    <td class="blue">ҵ������</td>
            <td>
			  <input name="sm_name" type="text" class="InputGrey" id="sm_name" value="<%=sm_code + "--" + sm_name%>" readonly>
			</td>
            <td class="blue">��ͻ���־</td>
            <td>
			<input name="bigCust_flag" type="text" class="InputGrey" id="bigCust_flag" value="<%=bigCust_flag+"--"+bigCust_name%>" readonly>
			</td>
          </tr>
          <tr>
            <td class="blue">��ǰ���ײ�</td>
            <td>
			  <input name="rate_name" type="text" class="InputGrey" id="rate_name" size="30" value="<%=rate_code+"--"+rate_name%>" readonly>
			</td>
			<td class="blue">�������ײ�</td>
            <td>
			  <input name="next_rate_name" type="text" class="InputGrey" id="next_rate_name" size="30"  value="<%=next_rate_code+"--"+next_rate_name%>" readonly>
			</td>
          </tr>
		  <tr>
            <td class="blue">δ���ʻ���</td>
            <td>
			  <input name="lack_fee" type="text" class="InputGrey" id="lack_fee" value="<%=lack_fee%>" readonly >
            </td>
            <td class="blue">����Ԥ��</td>
            <td>
			  <input name="prepay_fee" type="text" class="InputGrey" id="prepay_fee" value="<%=prepay_fee%>" readonly>
			</td>
          </tr>
		  <tr>
		    <td class="blue">���ݿ�����</td>
            <td>
			  <select  name="card_type_1" onChange="setYearFee();">
			    <option value="">--��ѡ��--</option>
                <wtc:qoption name="sPubSelect" outnum="2">
                    <wtc:sql>select card_type||'~'||year_fee||'~'||card_name, card_type||'--'||card_name from sDataCardYear</wtc:sql>
                </wtc:qoption>
              </select>
			  <font class="orange">*</font>
            </td>
            <td class="blue">������</td>
            <td>
			   <input name="year_fee" type="text" id="year_fee"  readonly>
			</td>
          </tr>
		  <tr>
            <td class="blue">���ײʹ���</td>
            <td id="ipTd">
			  <select  name="new_rate_code_1" id="new_rate_code_1" class="button" onChange="setSomeInfo();">
			    <option value="">--��ѡ��--</option>
                <wtc:qoption name="sPubSelect" outnum="2">

                    <wtc:sql> select a.offer_id ||'~'|| c.offer_attr_value || '~'|| b.offer_attr_value, a.offer_id ||'--'||a.offer_name from product_offer a, product_offer_attr b, product_offer_attr c where a.offer_id = b.offer_id and b.offer_attr_seq = '5080' and a.offer_id = c.offer_id and c.offer_attr_seq = '5060' and a.offer_id in (select offer_z_id from product_offer_relation c, sregioncode d where c.group_id = d.group_id and d.region_code = '?' and c.op_code = '1201' and c.right_limit <='?' and c.offer_a_id = to_number('?')) </wtc:sql>
                    <wtc:param value="<%=orgCode.substring(0,2)%>"/>
                    <wtc:param value="<%=aftertrim%>"/>
                    <wtc:param value="<%=rate_code%>"/>
                </wtc:qoption>
              </select>
			  <font class="orange">*</font>
            </td>
            <td class="blue">��������</td>
            <td>
			  <input name="year_month" type="text" id="year_month"  readonly>
			</td>
          </tr>
		  <tr>
            <td class="blue">�ϻ���־</td>
            <td colspan="3">
			  <select  name="conf_flag" onChange="controlBindPhoneNoTrView();">
			    <option value="">--��ѡ��--</option>
				<option value="00">��</option>
				<option value="01">��</option>
              </select>
			  <font class="orange">*</font>
            </td>
          </tr>
		  <tr id="bindPhoneNoTr" style="display:none">
            <td class="blue">���ֻ���</td>
            <td colspan="3">
			  <input   type="text" size="12" name="bind_phone_no" id="bind_phone_no" v_minlength=1 v_maxlength=11 v_type="mobphone"  v_name="���ֻ���" maxlength="11" index="0" style="ime-mode:disabled" onKeyPress="return isKeyNumberdot(0)">
              <font class="orange">*</font>
			  <input name="phoneValid" type="button" class="b_text" id="phoneValid" style="cursor:hand" onClick="commitRpc()" value="��֤"  >
            </td>
          </tr>
          <tr>
            <td class="blue">��ע</td>
            <td colspan="3">
             <input name="opNote" type="text" id="opNote" size="60" maxlength="60" readOnly>
            </td>
          </tr>
		  <tr>
            <td colspan="4" id="footer">
                <div align="center">
                <!-- modified by hanfa 20070118
				<input name="next" id="next" type="button" class="button"   value="��һ��" onClick="printCommit(this)">
				-->
				<!-- modified by hanfa 20070118 -->
				<input name="next" id="next" type="button" class="b_foot"   value="��һ��" onClick="submitCfm(this)">
                <input name="reset" type="reset" class="b_foot" value="���" >
                <input name="back" onClick="history.go(-1);" type="button" class="b_foot" value="����">
				</div>
			</td>
          </tr>
      </table>

  <input type="hidden" name="iOpCode">
  <input type="hidden" name="iAddStr">
  <input type="hidden" name="belong_code">
  <input type="hidden" name="i2">
  <input type="hidden" name="i16">
  <input type="hidden" name="ip">
  <input type="hidden" name="i1">
  <input type="hidden" name="i4">
  <input type="hidden" name="i5">
  <input type="hidden" name="i6">
  <input type="hidden" name="i7">
  <input type="hidden" name="ipassword">
  <input type="hidden" name="group_type">
  <input type="hidden" name="ibig_cust">
  <input type="hidden" name="i18">
  <input type="hidden" name="i19">
  <input type="hidden" name="i20">
  <input type="hidden" name="i8">
  <input type="hidden" name="do_note">
  <input type="hidden" name="favorcode">
  <input type="hidden" name="maincash_no">
  <input type="hidden" name="imain_stream">
  <input type="hidden" name="next_main_stream">
  <input type="hidden" name="new_rate_code">
  <input type="hidden" name="pay_type">
  <input type="hidden" name="card_type">
  <input type="hidden" name="card_name">
  <input type="hidden" name="bind_cust_name">

  <input type="hidden" name="print_note" value="<%=print_note%>">
  <input type="hidden" name="ifValid" value="0">
<%@ include file="/npage/include/footer_new.jsp" %>
</form>
</body>
</html>
