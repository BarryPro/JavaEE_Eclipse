<%
/********************
 version v2.0
������: si-tech
********************/
%>
<%
/********************
* author:zhaohaitao
* update:2008.12.2
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  response.setDateHeader("Expires", 0);

%>

<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.crmpd.boss.bo.ContactInfo"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>

<%		
  String opCode = "1205";
  String opName = "�����������ײ�����";
  
  String loginNo = (String)session.getAttribute("workNo");
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = (String)session.getAttribute("regCode");
 
%>
<%
  String retFlag="",retMsg="";//�����ж�ҳ��ս���ʱ����ȷ��
/****************���ƶ�����õ����롢���������� ����Ϣ s1205InitEx***********************/
  String[] paraAray1 = new String[4];
  String phoneNo = request.getParameter("srv_no");
  String returnPage = request.getParameter("returnPage");
  String passwordFromSer="";
  
  paraAray1[0] = phoneNo;		/* �ֻ�����   */ 
  paraAray1[1] = loginNo; 	    /* ��������   */
  paraAray1[2] = orgCode;	    /* ��������   */
  paraAray1[3] = "1205";	    /* ��������   */
  for(int i=0; i<paraAray1.length; i++)
  {		
	if( paraAray1[i] == null )
	{
	  paraAray1[i] = "";
	}
  }
  //retList = impl.callFXService("s1205InitEx", paraAray1, "27","phone",phoneNo);
%>
  <wtc:service name="s1205Init" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="27" >
	<wtc:param value="<%=paraAray1[0]%>"/>
    <wtc:param value="<%=paraAray1[1]%>"/>
	<wtc:param value="<%=paraAray1[2]%>"/>
	<wtc:param value="<%=paraAray1[3]%>"/>
  </wtc:service>
  <wtc:array id="tempArr" scope="end"/>
<%
  String  bp_name="",sm_code="",family_code="",rate_code="",bigCust_flag="",sm_name="",rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="",prepay_fee="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="",group_type_code="",group_type_name="",imain_stream="",next_main_stream="",hand_fee="",favorcode="",card_no="",print_note="";
  //String[][] tempArr= new String[][]{};
  String errCode = retCode1;
  String errMsg = retMsg1;
  System.out.println("errCode========="+errCode);
  System.out.println("errMsg========="+errMsg);
 
  if(tempArr[0][1] == null)
  {
	if(!retFlag.equals("1"))
	{
	   retFlag = "1";
	   retMsg = "s1205Init��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
    }    
  }else if(!(tempArr[0][1] == null))
  {
	if (errCode.equals("000000")){
	    
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
	    print_note = tempArr[0][25];//��������
	  }
	else{
		if(!retFlag.equals("1"))
		{
		   retFlag = "1";
	       retMsg = "s1205InitEx��ѯ���������Ϣʧ��!<br>errCode: " + errCode + "<br>errMsg: " + errMsg;
		}
	}
 }
 //********************�õ�ӪҵԱȨ�ޣ��˶����룬�������Ż�Ȩ��*****************************//   
  String tempStr = "";
%>

<head>
<title>�����������ײ�</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<script type="text/javascript" src="../../npage/s3000/js/S3000.js"></script>

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

  //core.loadUnit("debug");
  //core.loadUnit("rpccore");
  
  onload=function()
  {	
  	  //core.rpc.onreceive = doProcess;	
  } 
  
  //---------------RPC������ added by hanfa 20070116 begin------------------

  function doProcess(packet)
  {   	
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
	}
 }
 //---------------RPC������ added by hanfa 20070116 end ------------------ 
	
  //***
  function frmCfm(){
 	frm.submit();
	return true;
  }
  //***//У��
  function check(){
 	with(document.frm){	
	  if(order_code.value==""){
	    rdShowMessageDialog("��ѡ�񷽰�����!");
		order_code.focus();
		return false;
	  }
	  if((prepay_fee.value-should_fee.value)<0){
	    rdShowMessageDialog("���Ŀ���Ԥ���С�ڰ���ѽ����Ƚ���!");
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
    var iOpCode = "1205";//iOpCode 
	//iAddStr��ʽ ��������| ����Ԥ��| �µ���| ��������
	var iAddStr =  document.frm.order_code.value + "|" + document.frm.should_fee.value + "|" +  document.frm.mon_base_fee.value + "|" + document.frm.consume_term.value + "|" ; //iAddStr
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
    var i8 =   "<%=sm_code+"--"+sm_name%>";  //   ҵ��Ʒ��
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
	frm.action = "f1270_3.jsp";
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
  	getAfterPrompt();
	//controlButt(subButton);//��ʱ���ư�ť�Ŀ�����
	//У��
	if(!check()) return false;
	setOpNote();//Ϊ��ע��ֵ
	//Ϊ��һ��ҳ����֯���ݲ���
	setParaForNext();
    //�ύ��
    frmCfm();	
	return true;
  }
/**�ɷ������붯̬�õ�����Ԥ�桢����桢�µ��ߡ����ײʹ��롢���������Ϣ**/
 function setSomeInfo(){
   var tempStr = document.frm.order_code_1.value;
   var order_code,prepay_fee,consume_term,mon_base_fee,mode_code;
   order_code = oneTokSelf(tempStr,"~",1);//��������
   prepay_fee = oneTokSelf(tempStr,"~",2);//Ԥ���
   consume_term = oneTokSelf(tempStr,"~",3);//��������
   mon_base_fee = oneTokSelf(tempStr,"~",4);//�µ���
   mode_code = oneTokSelf(tempStr,"~",5);//���ʷѺ���
   mode_name = oneTokSelf(tempStr,"~",6);//���ʷ�����

   document.frm.order_code.value = order_code;
   document.frm.should_fee.value = prepay_fee;
   document.frm.consume_term.value = consume_term;
   document.frm.mon_base_fee.value = mon_base_fee;
   document.frm.new_rate_code_1.value = mode_code + "--" + mode_name;
   document.frm.new_rate_code.value = mode_code;

   return true; 
}
/**��ѯ��������**/
function getOrderCode()
{ 
  	//���ù���js�õ���������
    var pageTitle = "���������ѯ";  
    var fieldName = "��������|��������|Ԥ���|��������|�µ���|���ײʹ���|���ײ�����|";
    var sqlStr = "select a.order_code,a.order_name,a.prepay_fee,a.consume_term,a.mon_base_fee,a.mode_code,a.mode_code||'--'||c.mode_name from sMachOrderCode a,cBillBbChg b, sBillModeCode c where a.region_code=b.region_code and a.region_code=c.region_code  and a.mode_code=c.mode_code and a.mode_code=b.new_mode and a.region_code='<%=orgCode.substring(0,2)%>'  and a.flag='1' and b.op_code='a205' and b.old_mode = '<%=java.net.URLEncoder.encode(rate_code)%>' and a.order_code like '" + codeChg("%"+document.frm.order_code.value+"%") + "'	order by a.order_code ";   
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "7|0|1|2|3|4|5|6|";    
    var retToField = "order_code|order_name|should_fee|consume_term|mon_base_fee|new_rate_code|new_rate_name|";
    if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)); 
    getMidPrompt("10442",codeChg(document.getElementById("new_rate_code").value),"orderCode");
}

function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "<%=request.getContextPath()%>/npage/public/fPubSimpSel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;  
    
    retInfo = window.showModalDialog(path);
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
    
    /******** added by hanfa 20070118 begin ***********/
    getModeCode();    
    if(document.frm.modeCode.value != "")
    {
    	querySmcode();
    } 
    /******** added by hanfa 20070118 end ***********/
    
	return true;
}


/******** �����ַ�������ʷѴ��� added by hanfa 20070118 begin ***********/
function getModeCode()
{
	var tempStr = document.frm.new_rate_name.value;
	var modeCode = "";
	modeCode = oneTokSelf(tempStr,"--",1);
	document.frm.modeCode.value = modeCode;	
}
/******** �����ַ�������ʷѴ���  added by hanfa 20070118 end ***********/


/******Ϊ��ע��ֵ********/
function setOpNote(){
	if(document.frm.opNote.value=="")
	{
		if ("<%=regionCode%>"=="03")
			document.frm.opNote.value = "����ҵ�����;��������:"+document.frm.order_code.value; 
		else
			document.frm.opNote.value = "�����ײ�;����:"+document.frm.phoneNo.value+";����:"+document.frm.order_code.value; 
	}
	return true;
}

  //������������ѯ�ʷѴ�����Ӧ��Ʒ�ƴ��� added by hanfa 20070117
  function querySmcode()
  {
	  var myPacket = new AJAXPacket("querySmcode_rpc.jsp","���ڻ����Ϣ�����Ժ�......");
	  myPacket.data.add("modeCode",(document.all.modeCode.value).trim());
	  core.ajax.sendPacket(myPacket);
	  myPacket=null;
  }
//-->
</script>
</head>

<body>
<form name="frm" method="post">
	
	<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">�����������ײ�</div>
		</div>
		
	<!-- added by hanfa 20070118-->
  	<input type="hidden" name="smCode" value="<%=sm_code%>">
  	<input type="hidden" name="modeCode" value="">
  	<input type="hidden" name="m_smCode" value=""> 	            
     
      <table cellspacing="0">
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
			<td class="blue">��������</td>
            <td colspan="3" id="orderCode">
			  <input type="text" name="order_code" id="order_code" size="8" maxlength="8" v_must=1>
			   <input type="text" name="order_name" id="order_name" size="18">
			   <font color="orange">*</font>			   
			   <input name="orderCodeQuery" type="button" class="b_text" style="cursor:hand" onClick="getOrderCode()" value=��ѯ>
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
		  <tr> 
            <td class="blue">�µ���</td>
            <td>
			  <input name="mon_base_fee" type="text" class="InputGrey" id="mon_base_fee" readonly>
			</td>
			<td class="blue">���ײʹ���</td>
            <td>
			  <input name="new_rate_name" type="text" class="InputGrey" id="new_rate_name" size="30" readonly>
			</td>            
          </tr>
          <tr style="display:none"> 
            <td class="blue">��ע</td>
            <td colspan="3">
             <input name="opNote" type="text" id="opNote" size="60" maxlength="60" value="" onFocus="setOpNote();"> 
            </td>
          </tr>
		  <tr> 
            <td colspan="4">
            	<div align="center">             
                <!-- modified by hanfa 20070118
				<input name="next" id="next" type="button" class="button"   value="��һ��" onClick="printCommit(this)" >
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
  <input type="hidden" name="return_page" value="<%=returnPage%>">	
  <input type="hidden" name="opCode" value="1205">	
  <input type="hidden" name="opName" value="<%=opName%>">
  <input type="hidden" name="print_note" value="<%=print_note%>"><!--��ӡ�������-->
  
    <%@ include file="/npage/include/footer.jsp" %>   
</form>
</body>
</html>
