<%
/********************
 version v2.0
������: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%
	request.setCharacterEncoding("GBK");
%>

<%
	String opCode = "126b";
	String opName = "Ԥ�滰������";
	    
  String loginNo = (String)session.getAttribute("workNo");
  String loginName = (String)session.getAttribute("workName");  
  String  powerCode= (String)session.getAttribute("powerCode");
  String orgCode = (String)session.getAttribute("orgCode");
  String ip_Addr = (String)session.getAttribute("ipAddr");
  String regionCode= (String)session.getAttribute("regCode");
  
%>
<%
  String retFlag="",retMsg="";//�����ж�ҳ��ս���ʱ����ȷ��
/****************���ƶ�����õ����롢���������� ����Ϣ s126bInitEx***********************/
  String[] paraAray1 = new String[4];
  String phoneNo = request.getParameter("srv_no");
  String passwordFromSer="";
  
  paraAray1[0] = phoneNo;		/* �ֻ�����   */ 
  paraAray1[1] = loginNo; 	    /* ��������   */
  paraAray1[2] = orgCode;	    /* ��������   */
  paraAray1[3] = "126b";	    /* ��������   */
  for(int i=0; i<paraAray1.length; i++)
  {		
	if( paraAray1[i] == null )
	{
	  paraAray1[i] = "";
	}
  }

%>

<wtc:service name="s126bInitEx" routerKey="phone" routerValue="<%=phoneNo%>" retcode="errCode" retmsg="errMsg" outnum="29" >
	<wtc:param value="<%=paraAray1[0]%>"/>
	<wtc:param value="<%=paraAray1[1]%>"/>
	<wtc:param value="<%=paraAray1[2]%>"/>
	<wtc:param value="<%=paraAray1[3]%>"/>
</wtc:service>
<wtc:array id="retList" scope="end"/>

<%
  String  bp_name="",sm_code="",family_code="",rate_code="",bigCust_flag="",sm_name="",rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="",prepay_fee="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="",group_type_code="",group_type_name="",imain_stream="",next_main_stream="",hand_fee="",favorcode="",card_no="",print_note="",contract_flag="",high_flag="";
  
  if(retList == null)
  {
	if(!retFlag.equals("1"))
	{
	   retFlag = "1";
	   retMsg = "s126bInitEx��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
    }    
  }else if(!(retList == null))
  {
	if (errCode.equals("0")||errCode.equals("000000")){
	  if(!(retList[0][3]==null)){
	    bp_name = retList[0][3];//��������
	  }
	  
	  if(!(retList[0][4]==null)){
	    bp_add = retList[0][4];//�ͻ���ַ
	  }
	  
	  if(!(retList[0][2]==null)){
	    passwordFromSer = retList[0][2];//����
	  }
	  
	  if(!(retList[0][11]==null)){
	    sm_code = retList[0][11];//ҵ�����
	  }
	  
	  if(!(retList[0][12]==null)){
	    sm_name = retList[0][12];//ҵ���������
	  }
	  
	  if(!(retList[0][13]==null)){
	    hand_fee = retList[0][13];//������
	  }
	  
	  if(!(retList[0][14]==null)){
	    favorcode = retList[0][14];//�Żݴ���
	  }
	  
	  if(!(retList[0][5]==null)){
	    rate_code = retList[0][5];//�ʷѴ���
	  }
	  
	  if(!(retList[0][6]==null)){
	    rate_name = retList[0][6];//�ʷ�����
	  }
	  
	  if(!(retList[0][7]==null)){
	    next_rate_code = retList[0][7];//�����ʷѴ���
	  }
	  
	  if(!(retList[0][8]==null)){
	    next_rate_name = retList[0][8];//�����ʷ�����
	  }
	  
	  if(!(retList[0][9]==null)){
	    bigCust_flag = retList[0][9];//��ͻ���־
	  }
	  
	  if(!(retList[0][10]==null)){
	    bigCust_name = retList[0][10];//��ͻ�����
	  }
	  
	  if(!(retList[0][15]==null)){
	    lack_fee = retList[0][15];//��Ƿ��
	  }
	  
	  if(!(retList[0][16]==null)){
	    prepay_fee = retList[0][16];//��Ԥ��
	  }
	  
	  if(!(retList[0][17]==null)){
	    cardId_type = retList[0][17];//֤������
	  }
	  
	  if(!(retList[0][18]==null)){
	    cardId_no = retList[0][18];//֤������
	  }
	  
	  if(!(retList[0][19]==null)){
	    cust_id = retList[0][19];//�ͻ�id
	  }
	  
	  if(!(retList[0][20]==null)){
	    cust_belong_code = retList[0][20];//�ͻ�����id
	  }
	  
	  if(!(retList[0][21]==null)){
	    group_type_code = retList[0][21];//���ſͻ�����
	  }
	  
	  if(!(retList[0][22]==null)){
	    group_type_name = retList[0][22];//���ſͻ���������
	  }
	  
	  if(!(retList[0][23]==null)){
	    imain_stream = retList[0][23];//��ǰ�ʷѿ�ͨ��ˮ
	  }
	  
	  if(!(retList[0][24]==null)){
	    next_main_stream = retList[0][24];//ԤԼ�ʷѿ�ͨ��ˮ
	  }
	  
	  if(!(retList[0][25]==null)){
	    print_note = retList[0][25];//�������
	  }
	  
	  if(!(retList[0][27]==null)){
	    contract_flag = retList[0][27];//�Ƿ������˻�
	  }
	  
	  if(!(retList[0][28]==null)){
	    high_flag = retList[0][28];//�Ƿ��и߶��û�
	  }

	}else{
		if(!retFlag.equals("1"))
		{
		   retFlag = "1";
	       retMsg = "s126bInitEx��ѯ���������Ϣʧ��!<br>errCode: " + errCode + "<br>errMsg: " + errMsg;
		}
	}
  }
//********************�õ�ӪҵԱȨ�ޣ��˶����룬�������Ż�Ȩ��*****************************//   
   //�Ż���Ϣ
  //String[][] favInfo = (String[][])arrSession.get(3);   //���ݸ�ʽΪString[0][0]---String[n][0]
  String[][] favInfo = (String[][])session.getAttribute("favInfo");
  boolean pwrf = false;//a272 ��������֤
  String handFee_Favourable = "readonly";        //a230  ������
  int infoLen = favInfo.length;
  String tempStr = "";
  for(int i=0;i<infoLen;i++)
  {
    tempStr = (favInfo[i][0]).trim();
    if(tempStr.compareTo("a272") == 0)
    {
      pwrf = true;
    }
	if(tempStr.compareTo(favorcode) == 0)
    {
      handFee_Favourable = "";
    }
  }
  /*
  String passTrans = WtcUtil.repNull(request.getParameter("cus_pass")); 
  if(!pwrf)
  {
     String passFromPage=Encrypt.encrypt(passTrans);
     if(0==Encrypt.checkpwd2(passwordFromSer.trim(),passFromPage))	{
	   if(!retFlag.equals("1"))
	   {
	      retFlag = "1";
          retMsg = "�������!";
	   }
	    
    }       
  }
  */
//******************�õ�����������***************************//
  
  /*comImpl co=new comImpl();*/
  //�������� 
  String sqlMachineType  = "";  
  sqlMachineType  = "select machine_type ,flag from sMachOrderCode where region_code='?' and op_code='126b'  group by machine_type,flag order by machine_type" ;
  System.out.println("sqlMachineType==" + sqlMachineType);

%>
	<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phoneNo%>" retcode="machineRetCode" retmsg="machineRetMsg" outnum="2">
		<wtc:sql><%=sqlMachineType%></wtc:sql>
		<wtc:param value="<%=regionCode%>"/>
	</wtc:pubselect>
	<wtc:array id="machineTypeStr" scope="end"/>
<%
  //�������� 
  String sqlOrderCode  = "";  
  /*sqlOrderCode  = "select a.order_code||'~'||a.prepay_fee||'~'||a.base_fee||'~'||a.free_fee||'~'||a.consume_term||'~'||a.mon_base_fee||'~'||a.mode_code||'~'||a.machine_fee||'~'||nvl(b.flag_code,'xxxx'),  a.order_code||'~'||a.order_name,a.machine_type,a.flag  from sMachOrderCode a, (select region_code,mode_code,flag_code from sModeFlagCode where region_code='?' and op_code='126b') b  where a.region_code='?' and a.op_code='126b' and (a.flag='9' or (a.flag='0' and a.mode_code in (select new_mode from cBillBbChg where op_code='126b' and old_mode='?' and region_code='?'))  ) and  a.mode_code=b.mode_code(+) order by a.flag,a.machine_type,a.order_code";*/
  sqlOrderCode  = "SELECT a.order_code||'~'||a.prepay_fee||'~'||a.base_fee||'~'||a.free_fee||'~'||a.consume_term||'~'||a.mon_base_fee||'~'||a.mode_code||'~'||a.machine_fee||'~'||NVL(b.flag_code,'xxxx'),  a.order_code||'~'||a.order_name,a.machine_type,a.flag  FROM smachordercode a, (SELECT t.region_code, to_char(s.offer_id) mode_code, flag_code FROM sofferflagcode s, sregioncode t where s.group_id = t.group_id and t.region_code = '?') b WHERE a.region_code = '?' AND a.op_code = '126b' AND (a.flag = '9' OR (a.flag = '0' AND to_number(a.mode_code) IN (SELECT offer_z_id FROM product_offer_relation WHERE offer_a_id = to_number('?') and relation_type_id = 2))) AND trim(a.mode_code) = trim(b.mode_code(+)) ORDER BY a.flag, a.machine_type, a.order_code";
  
  System.out.println("sqlOrderCode==" + sqlOrderCode);
  System.out.println(regionCode+"|"+regionCode+"|"+rate_code+"|"+regionCode);
%>
  <wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phoneNo%>" retcode="orderRetCode" retmsg="orderRetMsg" outnum="4">
		<wtc:sql><%=sqlOrderCode%></wtc:sql>
		<wtc:param value="<%=regionCode%>"/>
		<wtc:param value="<%=regionCode%>"/>
		<wtc:param value="<%=rate_code%>"/>
	</wtc:pubselect>
	<wtc:array id="orderCodeStr" scope="end"/>
<%
  /****�õ���ӡ��ˮ****/
  String printAccept="";
  printAccept = getMaxAccept(); 
%>

<head>
<title>Ԥ�滰������</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
 
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

  var arrMachineType = new Array();//��������
  var arrFlagOne = new Array();//�۷ѷ�ʽ1
  var arrOrderCode = new Array();//��������
  var arrOrderName = new Array();//��������
  var arrMachineTypeTwo = new Array();//��������2
  var arrFlagTwo = new Array();//�۷ѷ�ʽ2
  //��ӡʹ�ñ���
  var modedxpay =""; 
  var goodbz    =""; 
  var bdbz      =""; 
  var bdts      =""; 
  var exeDate   ="";


  <%  
  for(int i=0;i<machineTypeStr.length;i++)
      {
	    out.println("arrMachineType["+i+"]='"+machineTypeStr[i][0]+"';\n");
	    out.println("arrFlagOne["+i+"]='"+machineTypeStr[i][1]+"';\n");
      } 

  for(int i=0;i<orderCodeStr.length;i++) 
      {
	    out.println("arrOrderCode["+i+"]='"+orderCodeStr[i][0]+"';\n");
	    out.println("arrOrderName["+i+"]='"+orderCodeStr[i][1]+"';\n");
		out.println("arrMachineTypeTwo["+i+"]='"+orderCodeStr[i][2]+"';\n");
		out.println("arrFlagTwo["+i+"]='"+orderCodeStr[i][3]+"';\n");
      }
 
  %>

  //---------1------RPC������------------------
  function doProcess(packet){
	//ʹ��RPC��ʱ��,��������������Ϊ��׼ʹ��.
	var errorCode = packet.data.findValueByName("errorCode");
	var errorMsg =  packet.data.findValueByName("errorMsg");
	var verifyType = packet.data.findValueByName("verifyType");
	var flag_code =  packet.data.findValueByName("flag_code");
	var flag_code_name =  packet.data.findValueByName("flag_code_name");
	var rate_code =  packet.data.findValueByName("rate_code");
	self.status="";
	if(verifyType=="confirm"){
		if( parseInt(errorCode) == 0 ){
		//rdShowMessageDialog("��Ϣ���أ���ȷ��!");
		document.frm.flag_code.value=flag_code;
		document.frm.flag_code_name.value=flag_code_name;
		//document.frm.rate_code.value=rate_code;
		
		var myPacket = new AJAXPacket("a26bFlag.jsp","���ڲ�ѯ�ͻ������Ժ�......");
		myPacket.data.add("org_Code",document.all.org_Code.value.trim());
		myPacket.data.add("temp8",document.all.new_rate_code_1.value.trim());
		core.ajax.sendPacket(myPacket);
		myPacket = null;
		
		setTimeout("getFlagCode1();",100);
		
		}else{
		rdShowMessageDialog("<br>������룺"+errorCode+"</br>������Ϣ��"+errorMsg);
		return false;
		}
	}
    
     else if(verifyType == "1295chgSim"){

	    var flag_code  = packet.data.findValueByName("flag_code");
	
		document.all.flag_code_no.value = flag_code;	
     }
    			
  }
  
 function getFlagCode1(){
	if (/*document.frm.back_flag_code.value == 2 || */document.frm.flag_code.value != 'xxxx') {
 	document.frm.flag_code.value="";
	document.frm.flag_code_name.value="";
	document.frm.rate_code.value="";  
	}
}

  /**************/
function commitRpc()
{	
	var flag_code = document.frm.flag_code_1.value;
	var new_rate_code = document.frm.new_rate_code.value;
	var myPacket = new AJAXPacket("fa255RpcConfirm.jsp","���ڻ��С����Ϣ�����Ժ�......");
	myPacket.data.add("verifyType","confirm");
	myPacket.data.add("flag_code",flag_code);
	myPacket.data.add("new_rate_code",new_rate_code);
	
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
	  if(op_type.value==""){
	    rdShowMessageDialog("��ѡ��۷����!");
		op_type.focus();
		return false;
	  }
	  if(machine_type.value==""){
	    rdShowMessageDialog("��ѡ���������!");
		machine_type.focus();
		return false;
	  }
	  if(order_code_1.value==""){
	    rdShowMessageDialog("��ѡ�񷽰�����!");
		order_code_1.focus();
		return false;
	  }
	}
	var now_rate_code = "<%=rate_code%>";
    var next_rate_code = "<%=next_rate_code%>";
	var new_rate_code = document.frm.new_rate_code.value;
    if(document.frm.op_type.value=="0" && now_rate_code==next_rate_code && now_rate_code==new_rate_code){
	  rdShowMessageDialog("��ǰ�ʷѡ������ʷѡ����ʷ����߲�����ȫ��ͬ����ȷ��!");
	  return false;
	}

    var prepay_fee = "<%=prepay_fee%>";
	var should_fee = document.frm.should_fee.value;
	<%if(contract_flag.equals("N")){%>
		if(should_fee-prepay_fee>0)
		{
		  rdShowMessageDialog("��ǰԤ��С��Ԥ�����Ƚɷ�!");
		  return false;
		}
	<%}%>


	return true;
  }

  //�����һ����ťʱ,Ϊ��һ��ҳ����֯����
  function setParaForNext(){ 
    var iOpCode = "126b";//iOpCode
	//iAddStr��ʽ flag,machine_type,order_code,prepay_fee,base_fee,free_fee,consume_term,mon_base_fee,machine_fee
	var iAddStr = document.frm.op_type.value + "|" + document.frm.machine_type.value + "|" +  document.frm.order_code.value + "|" + document.frm.should_fee.value + "|" + document.frm.base_fee.value + "|" + document.frm.free_fee.value + "|" + document.frm.consume_term.value + "|" + document.frm.mon_base_fee.value + "|" + document.frm.machine_fee.value + "|" ; //iAddStr
	var belong_code = "<%=cust_belong_code%>"; //belong_code 
    var i2 =  "<%=cust_id%>"  ; //�ͻ�ID
    var i16 = "<%=rate_code+"--"+rate_name%>";//�����ײʹ��루�ϣ�
    var ip = document.frm.new_rate_code.value;//�������ײʹ���(��)
    var i1 = document.frm.phoneNo.value;//  �ֻ�����
    var i5 = "<%=bp_add%>";//  �ͻ���ַ
    var i6 = "<%=cardId_type%>";//   ֤������
    var i7 = "<%=cardId_no%>";//  ֤������
    var ipassword = ""; // ����
    var group_type = "<%=group_type_code+"--"+group_type_name%>";//���ſͻ����
    var ibig_cust = "<%=bigCust_flag+"--"+bigCust_name%>";// ��ͻ����
    var i18 =  "<%=next_rate_code + "--" + next_rate_name%>"; //�������ײͣ�
    var i19 =  "<%=hand_fee%>";//   ������
    var i20 =  "<%=hand_fee%>";  // ���������
    var i8 =   "<%=sm_code+"--"+sm_name%>";  //   ҵ��Ʒ��
    var do_note = document.frm.opNote.value;// �û���ע��
    var favorcode =  "<%=favorcode%>";  // �������Ż�Ȩ��
    var maincash_no = "<%=rate_code%>";//�����ײʹ��루�ϣ�
    var imain_stream = "<%=imain_stream%>"; //��ǰ���ʷѿ�ͨ��ˮ
    var next_main_stream = "<%=next_main_stream%>";//ԤԼ���ʷѿ�ͨ��ˮ	

	/*var str = "iOpCode="+iOpCode+
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
	
	alert(str);*/
	document.frm.iOpCode.value = iOpCode;
	document.frm.iAddStr.value = iAddStr;
	document.frm.belong_code.value = belong_code;
	document.frm.i2.value = i2;
	document.frm.i16.value = i16;
	document.frm.ip.value = ip;
	document.frm.i1.value = i1;
	//document.frm.i4.value = i4;
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
	frm.action = "fa270_3.jsp";
  }
          
  function printCommit(subButton){
	document.frm.next.disabled=true;
	document.frm.iAddRateStr.value = document.frm.rate_code.value + "$" + document.frm.flag_code.value;
	//У��
	if(!check()) 
	{
	    document.frm.next.disabled=false;
        return false;
	}
	setOpNote();//Ϊ��ע��ֵ
	//Ϊ��һ��ҳ����֯���ݲ���
	setParaForNext();
    //�ύ��
	frmCfm();
	return true;
  }
function printCommitTwo(subButton){
	document.frm.commit.disabled=true;
	//У��
	if(!check()) 
	{
		document.frm.commit.disabled=false;
	    return false;
	}
	setOpNote();//Ϊ��ע��ֵ
	frm.action = "fa26bConfirm_1.jsp";
    frmCfm();
		
	return true;
}

function showPrtDlg(printType,DlgMessage,submitCfm)
{  //��ʾ��ӡ�Ի��� 
		    
	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;

	var printStr = printInfo();
	var old_code = "<%=rate_code%>"; //���ʷѴ���
	var new_code = document.all.new_rate_code.value; //���ʷѴ���
	var pType="subprint";              // ��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
	var billType="1";               //  Ʊ�����ͣ�1���������2��Ʊ��3�վ�
	var sysAccept="<%=printAccept%>";               // ��ˮ��
	var mode_code=codeChg(new_code)+"~";               //�ʷѴ���
	var fav_code=null;                 //�ط�����
	var area_code=document.all.flag_code.value;             //С������
	var opCode="1270";                   //��������
	var phoneNo=document.all.i1.value;                  //�ͻ��绰
     var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
      var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
	  path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+document.all.phoneNo.value+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;

	 var ret=window.showModalDialog(path,printStr,prop);
     return ret;
}

function printInfo(printType)
{ 	

		var cust_info="";
		var opr_info="";
		var note_info1="";
		var note_info2="";
		var note_info3="";
		var note_info4="";
		
		var retInfo = ""; 
		
		cust_info+="�ֻ����룺"+document.frm.phoneNo.value+"|";
		cust_info+="�ͻ�������"+document.frm.bp_name.value+"|";
		cust_info+="�ͻ���ַ��"+"<%=bp_add%>"+"|";
		cust_info+="֤�����룺"+document.frm.cardId_no.value+"|";
		
      opr_info+="ҵ������:         Ԥ���������¿۷�"+"|";
      if(goodbz=="Y"){
      opr_info+="��ˮ: "+"<%=printAccept%>"+"       �������ѽ�"+modedxpay+"Ԫ"+"|";
      }else{
      opr_info+="��ˮ:             "+"<%=printAccept%>"+"|";
      }
      opr_info+="ҵ������: Ԥ�滰�����ֻ�"+"    �ֻ��ͺ�: " + document.all.machine_type.value+"|";
      opr_info+="�µ���: "+document.all.mon_base_fee.value+"Ԫ    Ԥ�滰��: "+document.all.should_fee.value+"Ԫ    "+"����:  ����Ԥ��: "+document.all.base_fee.value+"Ԫ  �Ԥ��: "+document.all.free_fee.value+"Ԫ|";
      opr_info+="ҵ��ִ��ʱ��:  "+exeDate+"      ����Ԥ������:  "+document.all.consume_term.value+"����|";
		 /*******��ע��**********/
	  	if(bdbz=="Y"){
      	note_info1+=bdts+"|";
      }else{
	  	note_info1+=" "+"|";
	  	}
	  /**********������*********/
      note_info1+="<%=print_note%>"+"|";
      //if(document.all.modestr.value.length>0){
      // note_info1+="���ʷ���Чʱ����ȡ���Ŀ�ѡ�ʷ�:"+document.all.modestr.value+"|";
      //}else{
      note_info1+=" "+"|";
      //}
      if(goodbz=="Y"){
			note_info1+="��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��"+"|";
	  }
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	    return retInfo;

	  return retInfo;
}
//�ֽ��ַ���
function oneTokSelf(str,tok,loc)
{
	var temStr=str;
	var temLoc;
	var temLen;
	for(ii=0;ii<loc-1;ii++)
	{
		temLen=temStr.length;
		temLoc=temStr.indexOf(tok);
		temStr=temStr.substring(temLoc+1,temLen);
	}
	if(temStr.indexOf(tok)==-1){
		return temStr;
	}else{
		return temStr.substring(0,temStr.indexOf(tok));
	}
}

/**�ɷ������붯̬�õ�����Ԥ�桢����桢�µ��ߡ����ײʹ��롢���������Ϣ**/
 function setSomeInfo(){
   var tempStr = document.frm.order_code_1.value;
   var order_code,prepay_fee,base_fee,free_fee,consume_term,mon_base_fee,mode_code,machine_fee,flag_code;
   
   order_code = oneTokSelf(tempStr,"~",1);//��������
   prepay_fee = oneTokSelf(tempStr,"~",2);//Ԥ���
   base_fee = oneTokSelf(tempStr,"~",3);//����Ԥ��
   free_fee = oneTokSelf(tempStr,"~",4);//�����
   consume_term = oneTokSelf(tempStr,"~",5);//��������
   mon_base_fee = oneTokSelf(tempStr,"~",6);//�µ���
   mode_code = oneTokSelf(tempStr,"~",7);//���ʷѺ���
   machine_fee = oneTokSelf(tempStr,"~",8);//������
   flag_code = oneTokSelf(tempStr,"~",9);//flag_code

   document.frm.order_code.value = order_code;
   document.frm.should_fee.value = prepay_fee;
   document.frm.base_fee.value = base_fee;
   document.frm.free_fee.value = free_fee;
   document.frm.consume_term.value = consume_term;
   document.frm.mon_base_fee.value = mon_base_fee;
   document.frm.new_rate_code_1.value = mode_code;
   document.frm.new_rate_code.value = mode_code;
   document.frm.machine_fee.value = machine_fee;
   document.frm.flag_code_1.value = flag_code;

	
   //��̬�ı�С������Ŀɼ���,������rpcΪС�����븳ֵ
		if(flag_code=='xxxx')
		{
			
			document.all.flagCodeTr.style.display = "none";
			document.frm.flag_code.value="";
			document.frm.flag_code_name.value="";
			document.frm.rate_code.value="";
		}else
		{
			
			commitRpc();//��ѯС������			
			document.all.flagCodeTr.style.display = "";
			
			document.frm.flag_code.value="";
			document.frm.flag_code_name.value="";
			document.frm.rate_code.value="";  
		}		
		return true; 
}



function getFlagCode()
{ 
  	//���ù���js
    var pageTitle = "�ʷѲ�ѯ";
    var fieldName = "С������|С������";//����������ʾ���С����� 
    //var sqlStr ="select a.flag_code, a.flag_code_name,a.rate_code from sRateFlagCode a, sBillModeDetail b where a.region_code=b.region_code and a.rate_code=b.detail_code and b.detail_type='0' and a.region_code='" + codeChg(document.frm.org_Code.value.substring(0,2)) + "' and b.mode_code='" + codeChg(document.frm.new_rate_code_1.value) + "' order by a.flag_code" ;
    //var sqlStr ="select a.flag_code, a.flag_code_name from sofferflagcode a, PRODUCT_OFFER b where a.offer_id = b.offer_id and b.offer_id = " + document.frm.new_rate_code_1.value + " order by a.flag_code";
    var sqlStr ="select a.flag_code, a.flag_code_name from sofferflagcode a, sregioncode b where a.group_id = b.group_id and a.offer_id = " + document.frm.new_rate_code_1.value + " and b.region_code = '" + document.frm.org_Code.value.substring(0,2) + "'";
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "0|1";//�����ֶ�
    var retToField = "flag_code|flag_code_name";//���ظ�ֵ����
    if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}

/*���տ۷����̬�����еĿɼ��ԡ���ť�Ŀ�����*/
function controlByOpType(){
   var opType=document.frm.op_type.value;
  
   if(opType=="0")//���¿۷�
   {
      document.all.baseFeeTr.style.display="";
      document.all.monBaseFeeTr.style.display="";
	  document.all.machineFeeTr.style.display="none";
	  document.frm.next.disabled = false;
      document.frm.commit.disabled = true;
     
       <%if(!(regionCode.equals("01")||regionCode.equals("13")||regionCode.equals("04")||regionCode.equals("10"))){ %>
   	rdShowConfirmDialog("��ҵ��ֻ�Թ����������죬��ľ˹���ںӿ��ţ�");
   	history.go(-1);
  	<%}%>
   }else if(opType=="9")//�ǰ��¿۷�
   {
      document.all.baseFeeTr.style.display="none";
      document.all.monBaseFeeTr.style.display="none";
	  document.all.machineFeeTr.style.display="";
	  document.frm.next.disabled = true;
      document.frm.commit.disabled = false;
   }
   selectChange(null, document.frm.machine_type, arrMachineType, arrMachineType);
   //selectChange(null, document.frm.machine_type, arrMachineType, arrFlagOne);
   return true;
}
/****************���ݿ۷����̬���� machine_type������************************/
 function selectChange(control, controlToPopulate, itemArray, valueArray)
 {
   var opType = document.frm.op_type.value;

   var myEle ;
   var x ;
   // Empty the second drop down box of any choices
   for (var q=controlToPopulate.options.length;q>=0;q--) controlToPopulate.options[q]=null;
   // ADD Default Choice - in case there are no values
   myEle = document.createElement("option") ;
   myEle.value = "";
   myEle.text = "--��ѡ��--";
   controlToPopulate.add(myEle) ;
   for ( x = 0 ; x < itemArray.length  ; x++ )
   {
	   if(arrFlagOne[x]==opType)
	   {
          myEle = document.createElement("option") ;
          myEle.value = valueArray[x] ;
          myEle.text = itemArray[x] ;
          controlToPopulate.add(myEle) ;
	   }
   }
 } 
 /****************����machine_type��̬����order_code_1������************************/
 function selectChangeTwo(control, controlToPopulate, itemArray, valueArray)
 {
   var opType = document.frm.op_type.value;
   var machineType = document.frm.machine_type.value;
   
   /*var sel = document.frm.machine_type;
   var machineType = sel.options[sel.selectedIndex].text;*/
   
   var myEle ;
   var x ;
   // Empty the second drop down box of any choices
   for (var q=controlToPopulate.options.length;q>=0;q--) controlToPopulate.options[q]=null;
   // ADD Default Choice - in case there are no values
   myEle = document.createElement("option") ;
   myEle.value = ""; 
   myEle.text = "--��ѡ��--";
   controlToPopulate.add(myEle) ;
   for ( x = 0 ; x < itemArray.length  ; x++ )
   {
	   if(arrFlagTwo[x]==opType && arrMachineTypeTwo[x]==machineType)
	   {
          myEle = document.createElement("option") ;
          myEle.value = valueArray[x] ;
          myEle.text = itemArray[x] ;
          controlToPopulate.add(myEle) ;
	   }
   }
 } 
 /******Ϊ��ע��ֵ********/
function setOpNote(){
	if(document.frm.opNote.value=="")
	{
	   document.frm.opNote.value = document.frm.op_type.options[document.frm.op_type.selectedIndex].text+";"+document.frm.machine_type.value+";����:" +document.frm.order_code.value; 
	}
	return true;
}
//-->
</script>

<link rel="stylesheet" href="../../css/jl.css" type="text/css">
</head>


<body>
<form name="frm" method="post">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">�ͻ���Ϣ</div>
	</div>
	<table cellspacing="0" >
			<tr>
				<td class="blue">�ֻ�����</td>
				<td>
				<input name="phoneNo" type="text" class="InputGrey" id="phoneNo" value="<%=phoneNo%>" readonly>
				</td> 
				<td class="blue">��������</td>
				<td>
				<input name="bp_name" type="text" class="InputGrey" id="bp_name" value="<%=bp_name%>" readonly>			  
				</td>           
			</tr>
			<tr> 
				<td class="blue">ҵ��Ʒ��</td>
				<td>
				<input name="sm_name" type="text" class="InputGrey" id="sm_name" value="<%=sm_code + "--" + sm_name%>" readonly>
				</td>
				<td class="blue">��ͻ���־</td>
				<td>
				<input name="bigCust_flag" type="text" class="InputGrey" id="bigCust_flag" value="<%=bigCust_flag+"--"+bigCust_name%>" readonly>
				</td>            
			</tr>
			<tr> 
				<td class="blue">֤������</td>
				<td>
				<input name="cardId_type" type="text" class="InputGrey" id="cardId_type" value="<%=cardId_type%>" readonly>
				</td>
				<td class="blue">֤������</td>
				<td>
				<input name="cardId_no" type="text" class="InputGrey" id="cardId_no" value="<%=cardId_no%>" readonly>
				</td>            
			</tr>
			<tr> 
				<td class="blue">��ǰ���ײ�</td>
				<td>
				<input name="rate_name" type="text" class="InputGrey" id="rate_name" size="40" value="<%=rate_code+"--"+rate_name%>" readonly>
				</td>
				<td class="blue">�������ײ�</td>
				<td>
				<input name="next_rate_name" type="text" class="InputGrey" id="next_rate_name" size="40"  value="<%=next_rate_code+"--"+next_rate_name%>" readonly>
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
				<td class="blue">�۷����</td>
				<td>
					<select name="op_type" class="InputGrey" onChange="controlByOpType();">
					<option value="">--��ѡ��--</option>
					<option value="0">���¿۷� </option>
					<option value="9">�ǰ��¿۷� </option>
					</select>
					<font class="orange">*</font>
				</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr >
				<td class="blue">�ֻ�����</td>
				<td>
				<select name="machine_type" class="InputGrey" onChange="selectChangeTwo(null, document.frm.order_code_1, arrOrderName,arrOrderCode);">
				<option value="">--��ѡ��--</option>				
				</select>
				<font class="orange">*</font>
				</td>
				<td class="blue">��������</td>
				<td>
				<select name="order_code_1" class="InputGrey" onChange="setSomeInfo();">
				<option value="">--��ѡ��--</option>
				</select>
				<font class="orange">*</font>
				</td> 
			</tr>
			<tr>
				<td class="blue">Ԥ���</td>
				<td>
				<input name="should_fee" type="text" class="InputGrey" id="should_fee" readonly>
				</td>
				<td class="blue">��������</td>
				<td>
				<input name="consume_term" type="text" class="InputGrey" id="consume_term" readonly>
				</td>  
			</tr>
			<tr id="baseFeeTr" style="display:none"> 
				<td class="blue">����Ԥ��</td>
				<td>
				<input name="base_fee" type="text" class="InputGrey" id="base_fee"   readonly>
				</td>
				<td class="blue">�Ԥ��</td>
				<td>
				<input name="free_fee" type="text" class="InputGrey" id="free_fee"   readonly>
				</td>             
			</tr>
			<tr id="monBaseFeeTr" style="display:none"> 
				<td class="blue">�µ���</td>
				<td>
				<input name="mon_base_fee" type="text" class="InputGrey" id="mon_base_fee"   readonly>
				</td>
				<td class="blue">���ײʹ���</td>
				<td>
				<input name="new_rate_code_1" type="text" class="InputGrey" id="new_rate_code_1" size="30"  readonly>
				</td>            
			</tr>
			<tr id="flagCodeTr" style="display:none">
				<TD class="blue">С������</TD>
				<TD >
				<input class="button" type="hidden" size="17" name="rate_code" id="rate_code" readonly index="6">
				<input type="text" name="flag_code" size="8" maxlength="10" readonly>
				<input type="text" name="flag_code_name" size="18" readonly >&nbsp;&nbsp;
				<input type="hidden" name="rate_code">
				<input type="hidden" name="iAddRateStr">
				<input name="newFlagCodeQuery" type="button" class="b_text"  style="cursor:hand" onClick="getFlagCode()" value=ѡ��>
				</TD> 
				<td>&nbsp;</td>
				<td>&nbsp;</td>            
			</tr>
			<tr id="machineFeeTr" style="display:none"> 
				<td class="blue">������</td>
				<td>
				<input name="machine_fee" type="text" class="InputGrey" id="machine_fee" readonly>
				</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>            
				</tr>
				<tr> 
				<td class="blue">��ע</td>
				<td colspan="3">
				<input name="opNote" type="text" id="opNote" size="60" maxlength="60" value="" onfocus="setOpNote()"> 
				</td>
			</tr>
			<tr> 
				<td colspan="4" id="footer"><div align="center"> 
				&nbsp; 
				<input name="next" id="next" type="button" class="b_foot" value="��һ��" onClick="printCommit(this)">
				&nbsp; 
				<input name="commit" id="commit" type="button" class="b_foot" value="ȷ��&��ӡ" onClick="printCommitTwo(this)">
				&nbsp; 
				<input name="reset" type="reset" class="b_foot" value="���" >
				&nbsp; 
				<input name="back" onClick="history.go(-1);" type="button" class="b_foot" value="����">
				&nbsp; 
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
  <input type="hidden" name="i4" value="<%=bp_name%>">
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
  <input type="hidden" name="flag_code_1"> 
<input type="hidden" name="org_Code" value="<%=orgCode%>">
<input type="hidden" name="flag_code_no" value="">
  <input type="hidden" name="order_code">
  <input type="hidden" name="print_note" value="<%=print_note%>">
  <input type="hidden" name="printAccept" value="<%=printAccept%>">
  <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
<script language="JavaScript">
  <%if((high_flag.trim()).equals("Y")){%>
    rdShowMessageDialog('��ʾ: ��ע��,���û�Ϊ�и߶��û���');
  <%}%>
</script>
