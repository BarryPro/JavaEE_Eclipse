<%
/********************
 version v2.0
������: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<%
  response.setDateHeader("Expires", 0);
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="java.util.*"%>
<%
  String opCode = (String)request.getParameter("opCode");
  String opName = (String)request.getParameter("opName");
  String loginNo = (String)session.getAttribute("workNo");
  String loginName = (String)session.getAttribute("workName");
  String powerCode= (String)session.getAttribute("powerCode");
  String orgCode = (String)session.getAttribute("orgCode");
  String ip_Addr = (String)session.getAttribute("ipAddr");
  String regionCode = orgCode.substring(0,2);
  
	/* liujian ��ȫ�ӹ��޸� 2012-4-6 16:18:13 begin */
//String loginNoPass = (String)session.getAttribute("password");
	String op_strong_pwd = (String) session.getAttribute("password");
  /* liujian ��ȫ�ӹ��޸� 2012-4-6 16:18:13 end */
  
  String aftertrim = (String)session.getAttribute("powerRight");
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region"  routerValue="<%=regionCode%>" id="loginAccept"/>	
<%
  String retFlag="",retMsg="";//�����ж�ҳ��ս���ʱ����ȷ��
/****************���ƶ�����õ����롢���������� ����������Ϣ����Ϣ s1259Init***********************/
  String[] paraAray1 = new String[4];
  String phoneNo = request.getParameter("srv_no");
  String broadPhone = request.getParameter("broadPhone");
  String passwordFromSer="";

  paraAray1[0] = phoneNo;	/* �ֻ�����   */ 
  paraAray1[1] = loginNo; 	/* ��������   */
  paraAray1[2] = orgCode;	/* ��������   */
  paraAray1[3] = opCode;	/* ��������   */
  for(int i=0; i<paraAray1.length; i++)
  {		
	if( paraAray1[i] == null )
	{
	  paraAray1[i] = "";
	}
  }
  
  
  

  System.out.println("-----------------------------paraAray1[3]------------------------"+paraAray1[3]);
  System.out.println("-----------------------------paraAray1[0]------------------------"+paraAray1[0]);
  System.out.println("-----------------------------paraAray1[1]------------------------"+paraAray1[1]);
  System.out.println("-----------------------------paraAray1[2]------------------------"+paraAray1[2]);
  
  
  
%>
<wtc:service name="s1259Init" routerKey="phone" routerValue="<%=phoneNo%>" outnum="42" retmsg="errMsg" retcode="errCode">
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value="<%=paraAray1[3]%>"/>
			<wtc:param value="<%=paraAray1[1]%>"/>	
			<wtc:param value="<%=op_strong_pwd%>"/>
			<wtc:param value="<%=paraAray1[0]%>"/>
			<wtc:param value=""/>
			<wtc:param value="<%=paraAray1[2]%>"/>	
			 
</wtc:service>
	<wtc:array id="tempArr" start="0"  length="41" scope="end"/>
<%
		
				
System.out.println("-----------------------------tempArr[0][19]------------------------"+tempArr[0][19]);

  String  bp_name="",sm_code="",rate_code="",bigCust_flag="",sm_name="",rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="",prepay_fee="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="",group_type_code="",group_type_name="",imain_stream="",next_main_stream="",hand_fee="",favorcode="",card_no="",prepay_act_fee="",prepay_year_fee="",begin_time="",end_time="",leave_fee="",before_rate_code="",before_rate_name="",pay_type="",print_note="";
  if(tempArr == null)
  {
	if(!retFlag.equals("1"))
	{
	   retFlag = "1";
	   retMsg = "s1259Init��ѯ���������ϢΪ��!<br>" + "errCode: " + errCode + "<br>errMsg: " + errMsg;
    }    
  }else if(!(tempArr == null))
  {
	if (errCode.equals("0")||errCode.equals("000000")){
	    bp_name = tempArr[0][3];//��������
	    bp_add = tempArr[0][4];//�ͻ���ַ
	    passwordFromSer = tempArr[0][2];//����
	    sm_code = tempArr[0][11];//ҵ�����
	    sm_name = tempArr[0][12];//ҵ���������
	    hand_fee = tempArr[0][13];//������
	    favorcode = tempArr[0][14];//�Żݴ���
	    rate_code = tempArr[0][5];//�ʷѴ���
	    rate_name = tempArr[0][6];//�ʷ�����
	    next_rate_code = tempArr[0][7];//�����ʷѴ���
	    next_rate_name = tempArr[0][8];//�����ʷ�����
	    bigCust_flag = tempArr[0][9];//��ͻ���־
	    bigCust_name = tempArr[0][10];//��ͻ�����
	    lack_fee = tempArr[0][15];//��Ƿ��
	    prepay_fee = tempArr[0][16];//��Ԥ��
	    cardId_type = tempArr[0][17];//֤������
	    cardId_no = tempArr[0][18];//֤������
	    cust_id = tempArr[0][19];//�ͻ�id
	    cust_belong_code = tempArr[0][20];//�ͻ�����id
	    group_type_code = tempArr[0][21];//���ſͻ�����
	    group_type_name = tempArr[0][22];//���ſͻ���������
	    imain_stream = tempArr[0][23];//��ǰ�ʷѿ�ͨ��ˮ
	    next_main_stream = tempArr[0][24];//ԤԼ�ʷѿ�ͨ��ˮ
	    prepay_year_fee = tempArr[0][25];//����Ԥ���
	    prepay_act_fee = tempArr[0][26];//ʵ��Ԥ���
	    begin_time = tempArr[0][27];//��ʼʱ��
	    end_time = tempArr[0][28];//����ʱ��
	    before_rate_code = tempArr[0][29];//�������ǰ�ʷѴ���
	    before_rate_name = tempArr[0][30];//�������ǰ�ʷ�����
	    pay_type = tempArr[0][32];//���ѷ�ʽ
	    leave_fee = tempArr[0][33];//ʣ����
	    print_note = tempArr[0][38];//��������
	    
	}else{
		if(!retFlag.equals("1"))
	    {
	       retFlag = "1";
	       retMsg = "s1259Init��ѯ���������Ϣʧ��!<br>" + "errCode: " + errCode + "<br>errMsg: " + errMsg;
        }
	}
  }
  
%>

<%

//********************�õ�ӪҵԱȨ�ޣ��˶����룬�������Ż�Ȩ��*****************************//   
   //�Ż���Ϣ
  String[][] favInfo = (String[][])session.getAttribute("favInfo");   //���ݸ�ʽΪString[0][0]---String[n][0]
  boolean pwrf = true;//a272 ��������֤
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
  String passTrans=WtcUtil.repNull(request.getParameter("cus_pass")); 
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

%>


<head>
<title>������ǩ</title>
<script type="text/javascript" src="../../npage/s3000/js/S3000.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/npage/s1400/pub.js"></script>
 
<script language="JavaScript">
  <%if(retFlag.equals("1")){%>
     rdShowMessageDialog("<%=retMsg%>",0);
    //history.go(-1);
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

  onload=function()
  {		
  	/*getMidPrompt("10442","<%=rate_code%>","old_rate");
  	 getMidPrompt("10442","<%=next_rate_code%>","new_rate");*/		
  } 

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
		 document.frm.rate_code.value=rate_code;
		 //alert("document.frm.rate_code.value==="+document.frm.rate_code.value);
		 
    var myPacket = new AJAXPacket("1255Flag.jsp","���ڲ�ѯ�ͻ������Ժ�......");
	myPacket.data.add("org_Code",(document.all.org_Code.value).trim());
	myPacket.data.add("new_rate_code",(document.all.new_rate_code.value).trim());
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
  
  function getFlagCode1(){
	if (document.frm.back_flag_code.value == 2 || document.all.ipTd.colSpan == "1") {
 	document.frm.flag_code.value="";
		 document.frm.flag_code_name.value="";
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
	  if ( new_rate_code.value!=qry_ofr.value )
	  {
	  	rdShowMessageDialog("���ʷѴ�������ѯ!");
	  	new_rate_code.focus();
	  		return false;
	  }
	}
	var now_rate_code = "<%=rate_code%>";
    var next_rate_code = "<%=next_rate_code%>";
	var new_rate_code = document.frm.new_rate_code.value;
    if(now_rate_code==next_rate_code && now_rate_code==new_rate_code){
	  //rdShowMessageDialog("��ǰ�ʷѡ������ʷѡ����ʷ����߲�����ȫ��ͬ����ȷ��!");
	  //return false;
	}

	var prepay_fee = document.frm.prepay_fee.value;
	var year_fee = document.frm.year_fee.value;
  if((year_fee-prepay_fee)>0){
  	var showMsg = "<%=sm_code%>" == "kh"?"��ǰ����Ԥ��С�ڰ����·ѣ�����ͨ��zg62��������ͨ�������!":"��������ڵ�ǰ����Ԥ�棬����ͨ��e006�����п������!";
 	  rdShowMessageDialog(showMsg);
	  return false;
  }

	return true;
  }

  //�����һ����ťʱ,Ϊ��һ��ҳ����֯����
  function setParaForNext(){
    var iOpCode = "<%=opCode%>";//iOpCode    pay_type|year_fee|ʵ��Ԥ���|���� 
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
    
    var i18 = "";
    <%if((next_rate_code == null) || "".equals(next_rate_code)){%>
    	i18 =  ""; //�������ײͣ�
    <%}else{%>
    	i18 =  "<%=next_rate_code + "--" + next_rate_name%>"; //�������ײͣ�
    <%}%>
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
	document.frm.iph.value = ip;
	
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

  function printCommit(subButton){
  	var i16 = "<%=rate_code+"--"+rate_name%>";//�����ײʹ��루�ϣ�
	controlButt(subButton);//��ʱ���ư�ť�Ŀ�����
	document.frm.iAddRateStr.value = document.frm.rate_code_tmp.value + "$" + document.frm.flag_code.value;
	//alert("document.frm.iAddRateStr.value==="+document.frm.iAddRateStr.value);
	//У��
	if(!check()) return false;
	
	if(document.all.flag_code.value==""&&document.all.xiaoquCode.value=="Y"){
			rdShowMessageDialog("��ѡ��С������");
			document.all.flag_code.focus();
			return false;
		}
	setOpNote();//Ϊ��ע��ֵ
	//Ϊ��һ��ҳ����֯���ݲ���
	setParaForNext();
    //�ύ��
    frmCfm();	
	return true;
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
/**��ѯ���ײ�**/
function getNewRateCode()
{ 

  	//���ù���js�õ����ײʹ���
    var pageTitle = "�ʷѴ����ѯ";
 

     var fieldName = "�ʷѴ���|�ʷ�����|��С���|��������|���ѷ�ʽ|�ʷ�����|����С��|";
	  var sqlStr = "";
	  
	  //alert("sqlStr|"+sqlStr);
	
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "7|0|1|2|3|4|5|6|";
    
    var retToField = "new_rate_code|new_rate_name|year_fee|year_month|pay_type|flag_code_1|xiaoquCode|";

    if(!(PubSimpSele(pageTitle,fieldName,sqlStr,selType,retQuence,retToField))) return false;
    //��̬�ı�С������Ŀɼ���,������rpcΪС�����븳ֵ
    //alert("document.frm.xiaoquCode.value|"+document.frm.xiaoquCode.value);
    if(document.frm.xiaoquCode.value=='N')
	{
		document.all.ipTd.colSpan = "3";
    document.all.flagCodeTextTd.style.display = "none";
    document.all.flagCodeTd.style.display = "none";
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
	var rate_code=document.all.new_rate_code.value;
	document.all.qry_ofr.value=document.all.new_rate_code.value;
	getMidPrompt("10442",rate_code,"ipTd");
	
//}
	
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
    var fieldName = "С������|С������";//����������ʾ���С����� 
    var sqlStr = "select flag_code,flag_code_name from sofferflagcode where  group_id in (select e.parent_group_id from dChnGroupinfo e,dloginmsg f where e.group_id=f.group_id and f.login_no='<%=loginNo%>') and  offer_id ="+document.frm.new_rate_code.value;
    //var sqlStr ="select a.flag_code, a.flag_code_name,a.rate_code from sRateFlagCode a, sBillModeDetail b where a.region_code=b.region_code and a.rate_code=b.detail_code and b.detail_type='0' and a.region_code='" + codeChg(document.frm.org_Code.value.substring(0,2)) + "' and b.mode_code='" + codeChg(document.frm.new_rate_code.value) + "' order by a.flag_code" ;
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "0|1";//�����ֶ�
    var retToField = "flag_code|flag_code_name";//���ظ�ֵ����
    
    if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
    document.all.rate_code_tmp.value = document.all.rate_code.value;
	//alert("document.frm.rate_code.value==="+document.frm.rate_code.value);
	//alert("document.frm.rate_code_tmp.value==="+document.frm.rate_code_tmp.value);
	var flag_code=document.all.flag_code.value;
	getMidPrompt("10442",flag_code,"flagCodeTd");	
}



function PubSimpSele(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "fPubSimpSer_e974.jsp?offerId=<%=rate_code%>&newOfferId="+document.all.new_rate_code.value;
    path = path + "&sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType + "&opCode=<%=opCode%>";  
    retInfo = window.showModalDialog(path,"","dialogWidth:60");
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
	return true;
}
/******Ϊ��ע��ֵ********/
function setOpNote(){
	if(document.frm.opNote.value=="")
	{
	  document.frm.opNote.value = "��ǩ��"+document.frm.phoneNo.value+"����ǰ:<%=rate_code%>�����ײ�:"+document.frm.new_rate_code.value; 
	}
	return true;
}
//-->


</script>
</head>


<body>
<form name="frm" method="post">
<%@ include file="/npage/include/header.jsp" %>
<input type='hidden' id='qry_ofr' name='qry_ofr' value=''>
	<div class="title">
		<div id="title_zi">�ͻ���Ϣ</div>
	</div>
      <table cellspacing="0">
		  <tr>
		    <td class="blue">����˺�</td>
        <td>
        	<input name="broadPhone" id="broadPhone" type="text" 
        	 value="<%=broadPhone%>" readonly="readOnly" class="InputGrey"/>
			  	<input name="phoneNo" type="hidden" id="phoneNo" value="<%=phoneNo%>" /> 
				</td> 
		    <td class="blue">�ͻ�����</td>
            <td>
			  <input name="bp_name" type="text" class="InputGrey" id="bp_name" value="<%=bp_name%>" readonly>			  
			</td>           
          </tr>
          <tr> 
		    <td class="blue">ҵ��Ʒ��</td>
            <td>
			  <input name="sm_name" type="text" class="InputGrey" id="sm_name" value="<%=sm_code + "--" + sm_name%>" readonly>
			</td>
			<td class="blue">��ǰ���ײ�</td>
			<td>
				<input name="rate_name" type="text" class="InputGrey" 
					id="rate_name" size="30" value="<%=rate_code+"--"+rate_name%>" 
					readonly />
			</td>            
			</tr>

			<tr> 
				<td class="blue">����Ԥ��</td>
				<td>
				<input name="prepay_fee" type="text" class="InputGrey" id="prepay_fee" value="<%=prepay_fee%>" readonly>
				</td>
				<td class="blue">��ǰ������</td>
				<td>
					<input name="prepay_year_fee" type="text" class="InputGrey" id="prepay_year_fee"  value="<%=prepay_year_fee%>"  readonly>
				</td>
			</tr>
			<tr>
				<td class="blue">��ǰ���꿪ʼʱ��</td>
				<td>
					<input name="begin_time" type="text" class="InputGrey" id="begin_time" value="<%=begin_time%>"  readonly>
				</td>
				<td class="blue">��ǰ�������ʱ��</td>
				<td>
					<input name="end_time" type="text" class="InputGrey" id="end_time" value="<%=end_time%>" readonly>
				</td> 
			</tr>	

			<tr> 
				<td class="blue">���ײʹ���</td>
				<td colspan="3" id="ipTd">
					<input type="text" class="button" name="new_rate_code" id="new_rate_code" onChange="changeRateCode()" size="8" maxlength="8" v_must=1 v_name="���ײʹ���" >
					<input type="text" class="button" name="new_rate_name" id="new_rate_name" size="18"  v_name="���ײ�����">
					<font class="orange">*</font>
					&nbsp;&nbsp;
					<input name="newRateCodeQuery" type="button" class="b_text"  style="cursor:hand" onClick="getNewRateCode();" value=��ѯ>
				</td>
				<td id = "flagCodeTextTd" style="display:none" class="blue">С������</TD>
				<td id = "flagCodeTd" style="display:none">
					<input type="text" class="button" name="flag_code" size="8" maxlength="10" readonly>
					<input type="text" class="button" name="flag_code_name" size="18" readonly > 
					
					<font class="orange">*</font>
					<input type="hidden" name="rate_code">
					<input type="hidden" name="iAddRateStr">
					<input name="newFlagCodeQuery" type="button" class="b_text"  style="cursor:hand" onClick="getFlagCode()" value=ѡ��>
				</td> 
			</tr>
		  <tr>
		    <td class="blue" style="display:none">��������</td>
        <td style="display:none">
			  	<input name="year_month" type="text" class="InputGrey" id="year_month"  readonly>
				</td>
        <td class="blue">�����·�</td>
        <td colspan="3">
			  	<input name="year_fee" type="text" class="InputGrey" id="year_fee"  readonly>
				</td>
      </tr>	
			
			<tr> 
				<td class="blue">��ע��</td>
				<td colspan="3">
					<input name="opNote" type="text" class="button" id="opNote" size="60" maxlength="60" onFocus="setOpNote();" readonly> 
				</td>
			</tr>
			<tr> 
				<td colspan="4" id="footer">
					&nbsp; 
					<input name="next" id="next" type="button" class="b_foot"   value="��һ��" onClick="printCommit(this)">
					&nbsp; 
					<input name="reset" type="reset" class="b_foot" value="���" >
					&nbsp; 
					<input name="back" onClick="history.go(-1);" type="button" class="b_foot" value="����">
					&nbsp; 
				</td>
			</tr>
      </table>
  <input type="hidden" name="iOpCode">
  <input type="hidden" name="iAddStr">
  <input type="hidden" name="belong_code">
  <input type="hidden" name="i2">
  <input type="hidden" name="i16">
  <input type="hidden" name="iph">
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
  <input type="hidden" name="xiaoquCode" value="">
  <input type="hidden" name="geftFlag" value="0">
	<input type="hidden" name ="sm_code" value="<%=sm_code%>"/>
	<input type="hidden" name ="loginAccept" value="<%=loginAccept%>"/>
  
  <%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>

