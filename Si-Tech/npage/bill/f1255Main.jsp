<%
    /********************
     version v2.0
     ������: si-tech
			*
			*update:zhanghonga@2008-09-18 ҳ�����,�޸���ʽ
			*
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%		
	String opCode = "1255";//modify by qidp "1250=>1255"
	String opName = "��������";	    
  String loginNo = (String)session.getAttribute("workNo");
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = orgCode.substring(0,2);
  String aftertrim = (String)session.getAttribute("powerRight");
  /* liujian ��ȫ�ӹ��޸� 2012-4-6 16:18:13 begin */
	String op_strong_pwd = (String) session.getAttribute("password");
  /* liujian ��ȫ�ӹ��޸� 2012-4-6 16:18:13 end */
%>

<%
  String retFlag="",retMsg="";//�����ж�ҳ��ս���ʱ����ȷ��
/****************���ƶ�����õ����롢���������� ����Ϣ s1255Init***********************/
  String[] paraAray1 = new String[3];
  String phoneNo = WtcUtil.repNull(request.getParameter("srv_no"));
  String passwordFromSer="";
  paraAray1[0] = phoneNo;	/* �ֻ�����   */ 
  paraAray1[1] = loginNo; 	/* ��������   */
  paraAray1[2] = orgCode;	/* ��������   */	
  for(int i=0; i<paraAray1.length; i++)
  {		
	if( paraAray1[i] == null )
	{
	  paraAray1[i] = "";
	}
  }
  //retList = impl.callFXService("s1255Init", paraAray1, "27","phone",phoneNo);
%>
	<wtc:service name="s1255Init" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="27" >
		<wtc:param value=""/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=op_strong_pwd%>"/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=paraAray1[2]%>"/>
	</wtc:service>
	<wtc:array id="s1255InitArr" scope="end"/>
<%
  String  bp_name="",sm_code="",family_code="",rate_code="",op_type="2",bigCust_flag="",sm_name="",rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="",prepay_fee="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="",group_type_code="",group_type_name="",imain_stream="",next_main_stream="",hand_fee="",favorcode="",card_no="",print_note="";
  int errCode = retCode1==""?999999:Integer.parseInt(retCode1);
  String errMsg = retMsg1;
  if(errCode!=0){
  	retFlag=retFlag.equals("1")?retFlag:"1";
  	retMsg = "s1255Init��ѯ���������Ϣʧ��!<br>errCode: " + errCode + "<br>errMsg: " + errMsg ;
%>
		<script language="javascript">
			rdShowMessageDialog("<%=retMsg%>");
			parent.removeTab('<%=opCode%>');
		</script>
<%
	return;
  }
  
  if(s1255InitArr==null||s1255InitArr.length==0)
  {
		if(!retFlag.equals("1"))
		{
	   retFlag = "1";
	   retMsg = "s1255Init��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg: " + errMsg ;
    }    
  }else if(s1255InitArr.length>0){
	    bp_name = s1255InitArr[0][3];//��������
	    bp_add = s1255InitArr[0][4];//�ͻ���ַ
	    passwordFromSer = s1255InitArr[0][2];//����
	    sm_code = s1255InitArr[0][11];//ҵ�����
	    sm_name = s1255InitArr[0][12];//ҵ���������
	    hand_fee = s1255InitArr[0][13];//������
	    favorcode = s1255InitArr[0][14];//�Żݴ���
	    rate_code = s1255InitArr[0][5];//�ʷѴ���
	    rate_name = s1255InitArr[0][6];//�ʷ�����
	    next_rate_code = s1255InitArr[0][7];//�����ʷѴ���
	    next_rate_name = s1255InitArr[0][8];//�����ʷ�����
	    bigCust_flag = s1255InitArr[0][9];//��ͻ���־
	    bigCust_name = s1255InitArr[0][10];//��ͻ�����
	    lack_fee = s1255InitArr[0][15];//��Ƿ��
	    prepay_fee = s1255InitArr[0][16];//��Ԥ��
	    cardId_type = s1255InitArr[0][17];//֤������
	    cardId_no = s1255InitArr[0][18];//֤������
	    cust_id = s1255InitArr[0][19];//�ͻ�id
	    cust_belong_code = s1255InitArr[0][20];//�ͻ�����id
	    group_type_code = s1255InitArr[0][21];//���ſͻ�����
	    group_type_name = s1255InitArr[0][22];//���ſͻ���������
	    imain_stream = s1255InitArr[0][23];//��ǰ�ʷѿ�ͨ��ˮ
	    next_main_stream = s1255InitArr[0][24];//ԤԼ�ʷѿ�ͨ��ˮ
	    print_note = s1255InitArr[0][25];//��������
  }
   //�Ż���Ϣ
  String[][] favInfo = (String[][])session.getAttribute("favInfo");   //���ݸ�ʽΪString[0][0]---String[n][0]
  String handFee_Favourable = "readonly";        //a230  ������
  int infoLen = favInfo.length;
  String tempStr = "";
  for(int i=0;i<infoLen;i++){
    tempStr = (favInfo[i][0]).trim();
		if(tempStr.compareTo(favorcode) == 0){
      handFee_Favourable = "";
    }
  }
%>

<%/*******«ѧ�20060301add,��ѯ����ʱ�� *****  begin******/
	String[] inParas1 =new String[]{""};
	String showopentime = "";
	inParas1[0]="select to_char(a.open_time,'YYYY-MM-DD HH24:MI:SS') from dcustinnet a,dCustMsg b where a.id_no=b.id_no and substr(b.run_code,2,1)<'a' and b.phone_no='"+phoneNo+"'";
	//value = viewBean.callService("0", null, "sPubSelect", "1", inParas1);
%>
	<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phoneNo%>"  retcode="retCode2" retmsg="retMsg2" outnum="1">
	<wtc:sql><%=inParas1[0]%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result" scope="end" />
<%
	if(result==null||result.length==0)
		showopentime ="δ�鵽";
	else if(result.length==1)
		showopentime = result[0][0];
	else
		showopentime ="����������ʱ��";
 /*****«ѧ�20060301add,��ѯ����ʱ�� ***** end******/
%>

<html>
<head>
<title>��������</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<script language="JavaScript">

  <%if(retFlag.equals("1")){%>
    rdShowMessageDialog("<%=retMsg%>");
    parent.removeTab('<%=opCode%>')
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
			rdShowMessageDialog("����:"+ errCode + "->" + errMsg);
			return false;
		}  
	}//added by hanfa 20070116 end   
	else
	{   	
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
			 document.frm.flag_code.value=flag_code;
			 document.frm.flag_code_name.value=flag_code_name;
			 document.frm.rate_code.value=rate_code;  
			 
	    var myPacket = new AJAXPacket("1255Flag.jsp","���ڲ�ѯ�ͻ������Ժ�......");
			myPacket.data.add("org_Code",document.all.org_Code.value.trim());
			myPacket.data.add("new_rate_code",document.all.new_rate_code.value.trim());
			core.ajax.sendPacket(myPacket);
			myPacket=null;
		
			setTimeout("getFlagCode1();",100);
		
			 
		  }else{
				rdShowMessageDialog("<br>������룺"+errorCode+"</br>������Ϣ��"+errorMsg);
				return false;
		  }		
	    }
	 
	    else if(verifyType=="1295chgSim"){
				var back_flag_code  = packet.data.findValueByName("flag_code");
				document.all.back_flag_code.value = back_flag_code;	
	    } 
	 }   				
  }
  
  function getFlagCode1(){
		if (document.frm.back_flag_code.value == 2 || document.all.ipTd.colSpan == "1") {
	 		document.frm.flag_code.value="";
			document.frm.flag_code_name.value="";
			document.frm.rate_code.value="";  
		}
	}
  
  
  /**************/
  function commitRpc()
  {	
	var flag_code = document.frm.flag_code_1.value;
	var myPacket = new AJAXPacket("f1255RpcConfirm.jsp","���ڻ��С����Ϣ�����Ժ�......");
	
	myPacket.data.add("verifyType","confirm");
	myPacket.data.add("flag_code",flag_code);
 	
	core.ajax.sendPacket(myPacket);
 	myPacket=null; 	  		
  }	
  
  //***
  function frmCfm(){
	 	frm.submit();
		return true;
  }
  //***//У��
  function check(){
 	with(document.frm){	  
	  if(new_rate_code.value==""){
	    rdShowMessageDialog("��ѡ�����ʷѴ���!");
			new_rate_code.focus();
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
    
	var prepay_fee = document.frm.prepay_fee.value;
	var year_fee = document.frm.year_fee.value;
	if((year_fee-prepay_fee)>0){
	  rdShowMessageDialog("��ǰ���С�ڰ�������Ƚ���!");
	  return false;
	}

	return true;
  }

  //�����һ����ťʱ,Ϊ��һ��ҳ����֯����
  function setParaForNext(){ 
    var iOpCode = "1255";//iOpCode
		//iAddStr��ʽ pay_type|year_fee|prepay_fee|year_month|card_type|card_name ����card_type��card_name������E�а���
		var iAddStr = document.frm.pay_type.value + "|" + document.frm.year_fee.value + "|" +  "0" + "|" + document.frm.year_month.value + "|" + "" + "|" + ""; //iAddStr
		var belong_code = "<%=cust_belong_code%>"; //belong_code 
    var i2 =  "<%=cust_id%>"  ; //�ͻ�ID
    var i16 = "<%=rate_code+"--"+rate_name%>";//�����ײʹ��루�ϣ�
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
    
    var flag_code = document.frm.flag_code.value; 
    var rate_code = document.frm.rate_code.value;
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
		frm.action = "f1270_3_year.jsp";
  }

  /***** �ύǰ����Ʒ��ת����ʾ��Ϣ added by hanfa 20070117 *****/ 
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
  
  function printCommit(subButton){
  	
  	if(document.all.new_rate_code.value.trim().len()==0){
  			rdShowMessageDialog("���ײʹ��벻��Ϊ��!");
  			return false;
  	}
  	
  	
	  if(document.frm.flag_code_1.value!="xxxx"){
			if(document.frm.flag_code.value.length == 0){
			  rdShowMessageDialog("С�������ѡ!");
			  return false;
		  }
	  }
	  
	setOpNote();//Ϊ��ע��ֵ
	
	document.frm.iAddRateStr.value = document.frm.rate_code.value + "$" + document.frm.flag_code.value;
	//У��
	if(!check()) return false;
	//Ϊ��һ��ҳ����֯���ݲ���
	setParaForNext();
  //�ύ��
  frmCfm();	
	return true;
  }
 
/**��ѯ���ײ�**/
function getNewRateCode()
{ 
  	//���ù���js�õ����ײʹ���
    var pageTitle = "�ʷѴ����ѯ";
    var fieldName = "�ʷѴ���|�ʷ�����|��С���|��������|���ѷ�ʽ|С������|�ʷ�����|";
	var sqlStr = "select c.mode_code, c.mode_name, a.prepay_least, months_between(a.end_time,a.begin_time),a.pay_type,nvl(b.flag_code,'xxxx'),c.note    from sbillmoderelease a,sbillmodecode c, (select region_code,mode_code,flag_code from sModeFlagCode where region_code='<%=orgCode.substring(0,2)%>' and op_code='1255') b where sysdate between c.start_time and c.stop_time and substr(a.group_id,1,2)=c.region_code and a.mode_code=c.mode_code and c.region_code ='<%=orgCode.substring(0,2)%>' and a.mode_code in ( select new_mode from cBillBbChg  where region_code='<%=orgCode.substring(0,2)%>' and district_code in('<%=orgCode.substring(2,4)%>','99') and op_code='1255' and POWER_RIGHT <= <%=aftertrim%>  and old_mode='<%=java.net.URLEncoder.encode(rate_code)%>' and new_mode like '" + codeChg("%"+document.frm.new_rate_code.value+"%")+  "') and a.mode_code=b.mode_code(<%=java.net.URLEncoder.encode("+")%>) order by a.mode_code";
	
	/*note:��ΪsBillModeRelease��sbillModeCode����ȡmode_nameӰ���ٶȣ����԰�mode_name�Ƶ�sbillModeRelease�е�note*/
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "6|0|1|2|3|4|5|";
    var retToField = "new_rate_code|new_rate_name|year_fee|year_month|pay_type|flag_code_1|";
    
    if(!PubSimpSele(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)) return false;
    //��̬�ı�С������Ŀɼ���,������rpcΪС�����븳ֵ
    if(document.frm.flag_code_1.value=='xxxx')
	{
		document.all.ipTd.colSpan = "3";
		//document.all.flagCodeTextTd.style.display = "none";
		//document.all.flagCodeTd.style.display = "none";
		document.frm.flag_code.value="";
		document.frm.flag_code_name.value="";
		document.frm.rate_code.value="";
	}else
	{
		commitRpc();//��ѯС������
		document.all.ipTd.colSpan = "1";
		document.all.flagCodeTextTd.style.display = "";
		document.all.flagCodeTd.style.display = "";
	}
	getMidPrompt("10442",codeChg(document.getElementById("new_rate_code").value),"ipTd");
}

function changeRateCode()
{
    document.frm.flag_code.value="";
	document.frm.flag_code_name.value="";
	document.frm.rate_code.value="";
}

function getFlagCode()
{ 
  	//���ù���js
    var pageTitle = "�ʷѲ�ѯ";
    var fieldName = "С������|�ʷ�����|�ʷѴ���";//����������ʾ���С����� 
    var sqlStr ="select a.flag_code, a.flag_code_name,a.rate_code from sRateFlagCode a, sBillModeDetail b where a.region_code=b.region_code and a.rate_code=b.detail_code and b.detail_type='0' and a.region_code='" + codeChg(document.frm.org_Code.value.substring(0,2)) + "' and b.mode_code='" + codeChg(document.frm.new_rate_code.value) + "' order by a.flag_code" ;
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "0|1|2";//�����ֶ�
    var retToField = "flag_code|flag_code_name|rate_code";//���ظ�ֵ����
    
    if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
    document.all.rate_code_tmp.value = document.all.rate_code.value;
    getMidPrompt("10702",codeChg(document.all.flag_code.value),"flagCodeTd");
}

function codeChg(s)
{
  var str = s.replace(/%/g, "%25").replace(/\+/g, "%2B").replace(/\s/g, "+"); // % + \s
  str = str.replace(/-/g, "%2D").replace(/\*/g, "%2A").replace(/\//g, "%2F"); // - * /
  str = str.replace(/\&/g, "%26").replace(/!/g, "%21").replace(/\=/g, "%3D"); // & ! =
  str = str.replace(/\?/g, "%3F").replace(/:/g, "%3A").replace(/\|/g, "%7C"); // ? : |
  str = str.replace(/\,/g, "%2C").replace(/\./g, "%2E").replace(/#/g, "%23"); // , . #
  return str;
}

function PubSimpSele(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "<%=request.getContextPath()%>/npage/public/fPubSimpSel_1270.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType + "&opCode=1255";  
    retInfo = window.showModalDialog(path,"","dialogWidth:70");
    if(retInfo ==undefined)      
    {   return false;   }
    var chPos_field = retToField.indexOf("|");
    var chPos_retStr;
    var valueStr;
    var obj;
    while(chPos_field > -1)
    {
        obj = retToField.substring(0,chPos_field);
        chPos_retInfo = retInfo.indexOf("|");
        valueStr = retInfo.substring(0,chPos_retInfo);
        document.all(obj).value = valueStr;
        retToField = retToField.substring(chPos_field + 1);
        retInfo = retInfo.substring(chPos_retInfo + 1);
        chPos_field = retToField.indexOf("|");        
    }
    
    //added by hanfa 20070117
    if(document.all.new_rate_code.value != "")
    {
    	querySmcode();
    }
	return true;
}
/******Ϊ��ע��ֵ********/
function setOpNote(){
	if(document.frm.opNote.value=="")
	{
	  document.frm.opNote.value = "����;"+document.frm.phoneNo.value+";��ǰ<%=rate_code%>;��:"+document.frm.new_rate_code.value; 
	}
	return true;
}
//-->

  //������������ѯ�ʷѴ�����Ӧ��Ʒ�ƴ��� added by hanfa 20070117
  function querySmcode()
  {
	  var myPacket = new AJAXPacket("querySmcode_rpc.jsp","���ڻ����Ϣ�����Ժ�......");
	  myPacket.data.add("modeCode",document.all.new_rate_code.value.trim());
	  core.ajax.sendPacket(myPacket);
	  myPacket=null;
  }
  
</script>
</head>


<body>
<form name="frm" method="post">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
    <div id="title_zi">�������</div>
</div>
<!-- added by hanfa 20070117-->
<input type="hidden" name="smCode" value="<%=sm_code%>">
<input type="hidden" name="m_smCode" value="">
<table cellspacing="0">
<tr>
    <td class="blue">��������</td>
    <td colspan="3"><font class="orange">����</font></td>
</tr>
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
        <input name="sm_name" type="text" id="sm_name" value="<%=sm_code + "--" + sm_name%>" class="InputGrey" readonly>
    </td>
    <td class="blue">��ͻ���־</td>
    <td>
        <input name="bigCust_flag" type="text" id="bigCust_flag" value="<%=bigCust_flag+"--"+bigCust_name%>" class="InputGrey" readonly>
    </td>
</tr>
<tr>
    <td class="blue">��ǰ���ײ�</td>
    <td>
        <input name="rate_name" type="text" id="rate_name" size="40" value="<%=rate_code+"--"+rate_name%>" class="InputGrey" readonly>
    </td>
    <td class="blue">�������ײ�</td>
    <td>
        <input name="next_rate_name" type="text" id="next_rate_name" size="40" value="<%=next_rate_code+"--"+next_rate_name%>" class="InputGrey" readonly>
    </td>
</tr>
<tr>
    <td class="blue">δ���ʻ���</td>
    <td>
        <input name="lack_fee" type="text" id="lack_fee" value="<%=lack_fee%>" class="InputGrey" readonly>
    </td>
    <td class="blue">��תԤ��</td>
    <td>
        <input name="prepay_fee" type="text" id="prepay_fee" value="<%=prepay_fee%>" class="InputGrey" readonly>
    </td>
</tr>
<tr id="note1">    <!-- «ѧ�add20060301 begin -->
    <td class="blue" noWrap>����ʱ��</td>
    <td noWrap colspan="3">
        <input type="text" class="InputGrey" readonly name="showopentime" value="<%=showopentime%>" size="20" maxlength="20">
    </td>
</tr>
<!-- «ѧ�add20060301 end -->

<tr>
    <td class="blue">���ײʹ���</td>
    <td colspan="3" id="ipTd">
        <input type="text" name="new_rate_code" id="new_rate_code" size="8" maxlength="8" v_must=1  onChange="changeRateCode()" v_name="���ײʹ���">
        <input type="text" name="new_rate_name" id="new_rate_name" size="18" v_name="���ײ�����">
        <font class="orange">*</font>
        <input type="hidden" size="17" name="rate_code" id="rate_code" readonly index="6">
        &nbsp;&nbsp;
        <input name="newRateCodeQuery" type="button" style="cursor:hand" onClick="getNewRateCode()" class="b_text" value=��ѯ>
    </td>
    <TD id="flagCodeTextTd" style="display:none" class="blue">С������</TD>
    <TD id="flagCodeTd" style="display:none">
        <input type="text" name="flag_code" size="8" maxlength="10" readonly>
        <input type="text" name="flag_code_name" size="18" readonly>&nbsp;&nbsp;
        <input type="hidden" name="iAddRateStr">
        <input name="newFlagCodeQuery" type="button" style="cursor:hand" onClick="getFlagCode()" class="b_text" value=ѡ��>
    </TD>
</tr>
<tr>
    <td class="blue">��������</td>
    <td>
        <input name="year_month" type="text" id="year_month" class="InputGrey" readonly>
    </td>
    <td class="blue">������</td>
    <td>
        <input name="year_fee" type="text" id="year_fee" class="InputGrey" readonly>
    </td>
</tr>
<tr>
	<!-- dujl �޸�class="button" 20090428 -->
    <td class="blue">��ע</td>
    <td colspan="3">
        <input name="opNote" type="text" id="opNote" size="60" maxlength="60" class="button" >
    </td>
</tr>
<tr>
    <td colspan="4" id="footer">
        <div align="center">
            <!-- modified by hanfa 20070117 -->
            <input name="next" id="next" type="button" class="b_foot" value="��һ��" onClick="submitCfm(this)">
            &nbsp;
            <input name="reset" type="reset" class="b_foot" value="���">
            &nbsp;
            <input name="closeButton" type="button" class="b_foot" value="����" onclick="javascript:history.go(-1);">
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
<input type="hidden" name="pay_type">
<input type="hidden" name="flag_code_1">
<input type="hidden" name="org_Code" value="<%=orgCode%>">
<input type="hidden" name="back_flag_code" value="">
<input type="hidden" name="print_note" value="<%=print_note%>">
<input type="hidden" name="rate_code_tmp" value="">
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>

