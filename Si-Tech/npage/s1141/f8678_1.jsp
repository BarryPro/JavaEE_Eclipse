<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
/********************
 version v2.0
������: si-tech
********************/
%>

<html  xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
%>

<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.text.*" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>

<%
  String loginNo = (String)session.getAttribute("workNo");
  String loginName = (String)session.getAttribute("workName");
  String regionCode = (String)session.getAttribute("regCode");
  String groupId = (String)session.getAttribute("groupId");
  String orgCode = (String)session.getAttribute("orgCode");
  String opCode = "8678";
  String opName = "���ֻ�G3������";
    
  String retFlag="",retmsg="";
  String[] paraAray1 = new String[3];
  String phoneNo = request.getParameter("srv_no");
  String opcode = request.getParameter("opcode");
  String passwordFromSer="";

  paraAray1[0] = phoneNo;		/* �ֻ�����   */
  paraAray1[1] = opcode; 	    /* ��������   */
  paraAray1[2] = loginNo;	    /* ��������   */

  for(int i=0; i<paraAray1.length; i++)
  {
	if( paraAray1[i] == null )
	{
	  paraAray1[i] = "";

	}
  }
 /* ��������� �����룬������Ϣ���ͻ��������ͻ���ַ��֤�����ͣ�֤�����룬ҵ��Ʒ�ƣ�
 			�����أ���ǰ״̬��VIP���𣬵�ǰ����,����Ԥ��
 */

  //retList = impl.callFXService("s1141Qry", paraAray1, "14","phone",phoneNo);
%>
  
  <wtc:service name="s1141Qry" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="14" >
	<wtc:param value="<%=paraAray1[0]%>"/>
    <wtc:param value="<%=paraAray1[1]%>"/>
	<wtc:param value="<%=paraAray1[2]%>"/>
	</wtc:service>
	<wtc:array id="tempArr" scope="end"/>
	
<%	
  String  bp_name="",bp_add="",cardId_type="",cardId_no="",sm_code="",region_name="",run_name="",vip="",posint="",prepay_fee="";
  //String[][] tempArr= new String[][]{};
  String errCode = retCode1;
  String errMsg = retMsg1;
  
  System.out.println("errCode1======"+errCode);
  System.out.println("errMsg1======="+errMsg);
  if(tempArr[0][1]==null)
  {
	if(!retFlag.equals("000001"))
	{
	   System.out.println("retFlag========"+retFlag);
	   retFlag = "000001";
	   retmsg = "s1141Qry��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
    }    
  }
  else
  {
	if(!errCode.equals("000000")){%>
		<script language="JavaScript">
			rdShowConfirmDialog("������룺<%=errCode%>��������Ϣ��<%=errMsg%>")
			history.go(-1);
		</script>
	<%}
	else
	{
	    bp_name = tempArr[0][2];           //��������
	    bp_add = tempArr[0][3];            //�ͻ���ַ
	    cardId_type = tempArr[0][4];       //֤������
	    cardId_no = tempArr[0][5];         //֤������
	    sm_code = tempArr[0][6];           //ҵ��Ʒ��
	    region_name = tempArr[0][7];       //������
	    run_name = tempArr[0][8];          //��ǰ״̬
	    vip = tempArr[0][9];               //vip����
	    posint = tempArr[0][10];           //��ǰ����
	    prepay_fee = tempArr[0][11];       //����Ԥ��
	    passwordFromSer = tempArr[0][12];  //����
	}
  }

%>

<%
//******************�õ�����������***************************//
String printAccept="";
printAccept = getMaxAccept();
  //������Ʒ��
  String sqlAgentCode = " select  unique a.brand_code,trim(b.brand_name) from dphonesalecode a,schnresbrand b where a.region_code='" + regionCode + "' and a.sale_type='26' and a.brand_code=b.brand_code and valid_flag='Y'and is_valid='1'";
 
  //����������
  String sqlPhoneType = "select unique a.type_code,trim(b.res_name), b.brand_code from dphonesalecode a,schnrescode_chnterm b where a.region_code='" + regionCode + "' and  a.type_code=b.res_code and a.brand_code=b.brand_code and valid_flag='Y' and a.sale_type='26' and is_valid='1'";
 
  //Ӫ������
  String sqlsaleType = "select unique a.sale_code,trim(a.sale_name), a.brand_code,a.type_code from dphonesalecode a where a.region_code='" + regionCode + "' and a.sale_type='26' and valid_flag='Y'";

  //Ӫ����ϸ
  String sqlsaledet = "select sale_price,prepay_gift,consume_term,prepay_limit,active_term,market_price,sale_price+prepay_gift+prepay_limit,sale_code from dphoneSaleCode  where region_code='" + regionCode + "' and sale_type='26' and valid_flag='Y'";
  
%> 
<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode2" retmsg="retMsg2" outnum="2">
    <wtc:sql><%=sqlAgentCode%></wtc:sql>
	</wtc:pubselect>
<wtc:array id="agentCodeArr" scope="end"/>

<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode3" retmsg="retMsg3" outnum="3">
    <wtc:sql><%=sqlPhoneType%></wtc:sql>
	</wtc:pubselect>
<wtc:array id="phoneTypeArr" scope="end"/>

<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode4" retmsg="retMsg4" outnum="4">
    <wtc:sql><%=sqlsaleType%></wtc:sql>
	</wtc:pubselect>
<wtc:array id="saleTypeArr" scope="end"/>

<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode4" retmsg="retMsg4" outnum="8">
	<wtc:sql><%=sqlsaledet%></wtc:sql>
	</wtc:pubselect>
<wtc:array id="saledetStr" scope="end"/>

<head>
<title>���ֻ�G3������</title>
<META content="no-cache" http-equiv="Pragma">
<META content="no-cache" http-equiv="Cache-Control">
<META content="0" 	     http-equiv="Expires" >
<meta http-equiv="Content-Type" content="text/html; charset=GBK">

<script language=javascript>
 
  onload=function()
  {
  	 
  }
  
 function doProcess(packet){
 		var retType = packet.data.findValueByName("retType");
    	var retCode = packet.data.findValueByName("retCode");
    	var retMessage = packet.data.findValueByName("retMessage");
    	var retResult = packet.data.findValueByName("retResult");

    	if(retType == "checkAward")
		{
			var retCode = packet.data.findValueByName("retCode"); 
			var retMessage = packet.data.findValueByName("retMessage");
    		window.status = "";
    		if(retCode!="000000"){
    			rdShowConfirmDialog(retMessage);
    			document.all.need_award.checked = false;
    			document.all.award_flag.value = 0;
    			return ;
    		}
    		document.all.award_flag.value = 1;
    	}else{
			if(retResult == "000000"){
					rdShowMessageDialog("IMEI��У��ɹ�1��",2);
					document.frm.confirm.disabled=false;
					document.frm.IMEINo.readOnly=true;
					return ;
			}else if(retResult == "000001"){
					rdShowMessageDialog("IMEI��У��ɹ�2��",2);
					document.frm.confirm.disabled=false;
					document.frm.IMEINo.readOnly=true;
					return ;
			}else if(retResult == "000003"){
					rdShowMessageDialog("IMEI�Ų���ӪҵԱ����Ӫҵ����IMEI����ҵ�������Ͳ�����");
					document.frm.confirm.disabled=true;
					return false;
			}else{
					rdShowMessageDialog("IMEI�Ų����ڻ����Ѿ�ʹ�ã�");
					document.frm.confirm.disabled=true;
					return false;
			}
		}
 }
 function viewConfirm()
{
	if(document.frm.IMEINo.value=="")
	{
		document.frm.confirm.disabled=true;
	}
}
//***IMEI ����У��
 function checkimeino()
{
	 if (document.frm.IMEINo.value.length == 0) {
      rdShowMessageDialog("IMEI���벻��Ϊ�գ����������� !!");
      document.frm.IMEINo.focus();
      document.frm.confirm.disabled = true;
	  return false;
     }
	var myPacket = new AJAXPacket("queryimei.jsp","����У��IMEI��Ϣ�����Ժ�......");
	myPacket.data.add("imei_no",(document.all.IMEINo.value).trim());
	myPacket.data.add("brand_code",(document.all.agent_code.options[document.all.agent_code.selectedIndex].value).trim());
	myPacket.data.add("style_code",(document.all.phone_type.options[document.all.phone_type.selectedIndex].value).trim());
	myPacket.data.add("opcode",(document.all.opcode.value).trim());
	myPacket.data.add("retType","getImei");
	
	core.ajax.sendPacket(myPacket);
	myPacket=null;
}
 </script>
<script language="JavaScript">

<!--
  //����Ӧ��ȫ�ֵı���
  var SUCC_CODE	= "0";   		//�Լ�Ӧ�ó�����
  var ERROR_CODE  = "1";			//�Լ�Ӧ�ó�����
  var YE_SUCC_CODE = "0000";		//����Ӫҵϵͳ������޸�

  var oprType_Add = "a";
  var oprType_Upd = "u";
  var oprType_Del = "d";
  var oprType_Qry = "q";

  var arrPhoneType = new Array();//�������ͺŴ���
  var arrPhoneName = new Array();//�������ͺ�����
  var arrAgentCode = new Array();//�����̴���
  var selectStatus = 0;

  var arrsalecode =new Array();
  var arrsaleName=new Array();
  var arrsalebarnd=new Array();
  var arrsaletype=new Array();
  
  var arrdetphone  = new Array();     /*������*/
  var arrdetprepay = new Array();     /*����*/
  var arrdetconsume= new Array();     /*������������*/
  var arrdetnet    = new Array();     /*����������*/
  var arrdetactive = new Array();     /*��������������*/
  var arrdetmarket = new Array();     /*�г���*/
  var arrdetcash   = new Array();     /*Ӧ�����*/
  var arrdetsalecode=new Array();     /*Ӫ������*/

<%
  for(int i=0;i<phoneTypeArr.length;i++)
  {
	out.println("arrPhoneType["+i+"]='"+phoneTypeArr[i][0]+"';\n");
	out.println("arrPhoneName["+i+"]='"+phoneTypeArr[i][1]+"';\n");
	out.println("arrAgentCode["+i+"]='"+phoneTypeArr[i][2]+"';\n");
  }
  for(int l=0;l<saleTypeArr.length;l++)
  {
	out.println("arrsalecode["+l+"]='"+saleTypeArr[l][0]+"';\n");
	out.println("arrsaleName["+l+"]='"+saleTypeArr[l][1]+"';\n");
	out.println("arrsalebarnd["+l+"]='"+saleTypeArr[l][2]+"';\n");
	out.println("arrsaletype["+l+"]='"+saleTypeArr[l][3]+"';\n");
  }
   for(int l=0;l<saledetStr.length;l++)
  {
	out.println("arrdetphone["+l+"]='"+saledetStr[l][0]+"';\n");
	out.println("arrdetprepay["+l+"]='"+saledetStr[l][1]+"';\n");
	out.println("arrdetconsume["+l+"]='"+saledetStr[l][2]+"';\n");
	out.println("arrdetnet["+l+"]='"+saledetStr[l][3]+"';\n");
	out.println("arrdetactive["+l+"]='"+saledetStr[l][4]+"';\n");
	out.println("arrdetmarket["+l+"]='"+saledetStr[l][5]+"';\n");
	out.println("arrdetcash["+l+"]='"+saledetStr[l][6]+"';\n");
	out.println("arrdetsalecode["+l+"]='"+saledetStr[l][7]+"';\n");
   }
%>

  //***
  function frmCfm(){
		///////<!-- ningtn add for pos start @ 20100722 -->
		document.all.payType.value = document.all.payTypeSelect.value;
		if(document.all.payType.value=="BX")
  		{
    		/*set �������*/
			var transerial    = "000000000000";  	                    //����Ψһ�� ������ȡ��
			var trantype      = "00";         //��������
			var bMoney        = document.all.sum_money.value; 				//�ɷѽ��
			if(bMoney.indexOf(".") == -1) bMoney=bMoney+"00";
			var tranoper      = "<%=loginNo%>";                       //���ײ���Ա
			var orgid         = "<%=groupId%>";                       //ӪҵԱ��������
			var trannum       = "<%=phoneNo%>";                       //�绰����
			getSysDate();       /*ȡbossϵͳʱ��*/
			var respstamp     = document.all.Request_time.value;      //�ύʱ��
			var transerialold = "";																		//ԭ����Ψһ��,�ڽɷ�ʱ�����
			var org_code      = "<%=orgCode%>";                       //ӪҵԱ����						
			CCBCommon(transerial,trantype,bMoney,tranoper,orgid,trannum,respstamp,transerialold,org_code);
			if(ccbTran=="succ") posSubmitForm();
  		}
		else if(document.all.payType.value=="BY")
		{
			var transType     = "05";					/*�������� */         
			var bMoney        = document.all.sum_money.value;         /*���׽�� */
			if(bMoney.indexOf(".") == -1) bMoney=bMoney+"00";         
			var response_time = "";                								 		/*ԭ�������� */				
			var rrn           = "";                           				/*ԭ����ϵͳ������ */ 
			var instNum       = "";                                   /*���ڸ������� */     
			var terminalId    = "";                    								/*ԭ�����ն˺� */			
			getSysDate();       																			//ȡbossϵͳʱ��                                            
			var request_time  = document.all.Request_time.value;      /*�����ύ���� */     
			var workno        = "<%=loginNo%>";                        /*���ײ���Ա */       
			var orgCode       = "<%=orgCode%>";                       /*ӪҵԱ���� */       
			var groupId       = "<%=groupId%>";                       /*ӪҵԱ�������� */   
			var phoneNo       = "<%=phoneNo%>";                       /*���׽ɷѺ� */       
			var toBeUpdate    = "";						                        /*Ԥ���ֶ� */         
			var posFlag = ICBCCommon(transType,bMoney,response_time,rrn,instNum,terminalId,request_time,workno,orgCode,groupId,phoneNo,toBeUpdate);									
			if(icbcTran=="succ") posSubmitForm();
		}else{
			posSubmitForm();
		}
		
		//////<!-- ningtn add for pos end @ 20100722 -->
  }
  /* ningtn add for pos start @ 20100722 */
	function posSubmitForm(){
		frm.submit();
		return true;
	}
	function getSysDate()
	{
		var myPacket = new AJAXPacket("../public/pos_getSysDate.jsp","���ڻ��ϵͳʱ�䣬���Ժ�......");
		myPacket.data.add("verifyType","getSysDate");
		core.ajax.sendPacket(myPacket,doSetStsDate);
		myPacket = null;
	}
	function doSetStsDate(packet){
		var verifyType = packet.data.findValueByName("verifyType");
		var sysDate = packet.data.findValueByName("sysDate");
		if(verifyType=="getSysDate"){
			document.all.Request_time.value = sysDate;
			return false;
		}
	}
	function padLeft(str, pad, count)
	{
			while(str.length<count)
			str=pad+str;
			return str;
	}
	function getCardNoPingBi(cardno)
	{
			var cardnopingbi = cardno.substr(0,6);
			for(i=0;i<cardno.length-10;i++)
			{
				cardnopingbi=cardnopingbi+"*";
			}
			cardnopingbi=cardnopingbi+cardno.substr(cardno.length-4,4);
			return cardnopingbi;
	}
	/* ningtn add for pos start @ 20100722 */
 //***
 function printCommit()
 {
  getAfterPrompt();
  //У��
  //if(!check(frm)) return false;
  with(document.frm){
    if(cust_name.value==""){
	  rdShowMessageDialog("����������!");
      cust_name.focus();
	  return false;
	}
	if(agent_code.value==""){
	  rdShowMessageDialog("������������Ʒ��!");
      agent_code.focus();
	  return false;
	}
	if(phone_type.value==""){
	  rdShowMessageDialog("�������������ͺ�!");
      phone_type.focus();
	  return false;
	}
	if(sale_code.value==""){
	  rdShowMessageDialog("������Ӫ������!");
      sale_code.focus();
	  return false;
	}
	if(used_point.value==""){
	rdShowMessageDialog("���������ѻ���!");
      used_point.focus();
	  return false;
	}
	if (IMEINo.value.length == 0) {
      rdShowMessageDialog("IMEI���벻��Ϊ�գ����������� !!");
      IMEINo.focus();
      confirm.disabled = true;
	  return false;
     }
	opNote.value=phone_no.value+"������ֻ�G3������ҵ��";
	phone_typename.value=document.all.agent_code.options[document.all.agent_code.selectedIndex].text+document.all.phone_type.options[document.all.phone_type.selectedIndex].text;
	document.all.confirm.disabled=true;
  }
  if(!pointchange()) return false;

 //��ӡ�������ύ��
  var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
  if(typeof(ret)!="undefined")
  {
    if((ret=="confirm"))
    {
      if(rdShowConfirmDialog('ȷ�ϵ��������')==1)
      {
	    	frmCfm();
      }
	}
	if(ret=="continueSub")
	{
      if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
      {
	    frmCfm();
      }
	}
	else{
		if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
      	{
	    	frmCfm();
      	}	
	}
  }
  else
  {
     if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
     {
	   frmCfm();
     }
  }
  return true;
}
function showPrtDlg(printType,DlgMessage,submitCfm)
{  //��ʾ��ӡ�Ի���
   var h=210;
   var w=400;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;

   var pType="subprint";                                      // ��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
   var billType="1";                                          //  Ʊ�����ͣ�1���������2��Ʊ��3�վ�
   var sysAccept=document.all.login_accept.value;             // ��ˮ��
   var printStr=printInfo(printType);                         //����printinfo()���صĴ�ӡ����
   var mode_code=null;                                        //�ʷѴ���
   var fav_code=null;                                         //�ط�����
   var area_code=null;                                        //С������
   var opCode="8678";                                         //��������
   var phoneNo=document.all.phone_no.value;                   //�ͻ��绰

   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
   var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
   path+=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
   var ret=window.showModalDialog(path,printStr,prop);
   return ret;
}

function printInfo(printType)
{
    var cust_info=""; //�ͻ���Ϣ
	var opr_info=""; //������Ϣ
	var note_info1=""; //��ע1
	var note_info2=""; //��ע2
	var note_info3=""; //��ע3
	var note_info4=""; //��ע4
    var retInfo = "";  //��ӡ����
	
	cust_info+="�ֻ����룺"+document.all.phone_no.value+"|";
	cust_info+="�ͻ�������"+document.all.cust_name.value+"|";
	cust_info+="�ͻ���ַ��"+document.all.cust_addr.value+"|";
	cust_info+="֤�����룺"+document.all.cardId_no.value+"|";
	
	opr_info+="ҵ�����ͣ����ֻ�G3������"+"|";
    opr_info+="ҵ����ˮ��"+document.all.login_accept.value+"|";
    opr_info+="������Ʒ���ͺţ�"+document.all.agent_code.options[document.all.agent_code.selectedIndex].text+document.all.phone_type.options[document.all.phone_type.selectedIndex].text+"��IMEI�룺"+document.frm.IMEINo.value+"|";

	var jkinfo="";
	jkinfo+="�ɿ�ϼƣ�"+document.all.sum_money.value+"Ԫ ���У����� "+document.all.pay_money.value+"Ԫ����"+document.all.Consume_Term.value+"�������ͣ�";
	jkinfo+=document.all.Consume_Term.value+"�������������"+"��������"+document.all.net_money.value+"Ԫ���һ�����"+document.all.used_point.value+"��|";
	
	opr_info+=jkinfo+"|";
	
	note_info1="��ע��"+"|";
	
	//retInfo=cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
	
    if(document.all.award_flag.value == "1")
	{
		retInfo+= "�Ѳ���������Ʒ�"+"|";
	}
	else
	{
		retInfo+= " "+"|";
	}
	//alert(retInfo);
    return retInfo;	
}

//-->
</script>

<script language="JavaScript">
<!--
/****************����agent_code��̬����phone_type������************************/
 function selectChange(control, controlToPopulate, ItemArray, GroupArray)
 {
   var myEle ;
   var x ;
   // Empty the second drop down box of any choices
   for (var q=controlToPopulate.options.length;q>=0;q--) controlToPopulate.options[q]=null;
   // ADD Default Choice - in case there are no values

   myEle = document.createElement("option") ;
   myEle.value = "";
   myEle.text ="--��ѡ��--";
   controlToPopulate.add(myEle) ;
   for ( x = 0 ; x < ItemArray.length  ; x++ )
   {
      if ( GroupArray[x] == control.value )
      {
        myEle = document.createElement("option") ;
        myEle.value = arrPhoneType[x] ;
        myEle.text = ItemArray[x] ;
        controlToPopulate.add(myEle) ;
      }
   }
   
   document.all.need_award.checked = false;   
   document.all.award_flag.value = 0;

 }
 function typechange(){

 	var myEle1 ;
   	var x1 ;
   	for (var q1=document.all.sale_code.options.length;q1>=0;q1--) document.all.sale_code.options[q1]=null;
   	myEle1 = document.createElement("option") ;
    	myEle1.value = "";
        myEle1.text ="--��ѡ��--";
        document.all.sale_code.add(myEle1) ;

   	for ( x1 = 0 ; x1 < arrsaletype.length  ; x1++ )
   	{
      		if ( arrsaletype[x1] == document.all.phone_type.value  && arrsalebarnd[x1] == document.all.agent_code.value)
      		{
        		myEle1 = document.createElement("option") ;
        		myEle1.value = arrsalecode[x1];
        		myEle1.text = arrsaleName[x1];
        		document.all.sale_code.add(myEle1) ;
      		}
   	}
   	document.all.need_award.checked = false;   
    document.all.award_flag.value = 0;
 }
function salechage(){
	var x3; 	
	for ( x3 = 0 ; x3 < arrdetsalecode.length  ; x3++ )
   	{
      	if ( arrdetsalecode[x3] == document.all.sale_code.value )
      	{
      		document.all.price.value=arrdetphone[x3];
        	document.all.pay_money.value=arrdetprepay[x3];
        	document.all.Consume_Term.value=arrdetconsume[x3];
        	document.all.net_money.value=arrdetnet[x3];
        	document.all.Active_Term.value=arrdetactive[x3];
        	document.all.Market_Price.value=arrdetmarket[x3];
        	document.all.max_money.value=arrdetcash[x3];
      	}
	}
    document.all.opNote.value = "�û�"+document.all.phone_no.value+"������ֻ�G3������";
}
 
 function checkAward()
 {
 	 if(document.all.phone_type.value == "")
 	 {
 	 	 rdShowConfirmDialog("����ѡ�����");
 	 	 document.all.need_award.checked = false;
 	 	 document.all.award_flag.value = 0;
 	 	 return;
 	 }
 	 if(document.all.need_award.checked )
 	 {
 	 	 var packet = new AJAXPacket("phone_getAwardRpc.jsp","���ڻ�ý�Ʒ��ϸ�����Ժ�......");
 	 	 packet.data.add("retType","checkAward");
 	 	 packet.data.add("op_code","8678");
 	 	 packet.data.add("style_code",document.all.phone_type.value );
 	 	 
 	 	 core.ajax.sendPacket(packet);
 	 	 packet=null;
 	 	 
 	 }
 	 document.all.award_flag.value = 0;
 	 
 }
 
 function pointchange(){
 	 with(document.frm){

 		if (used_point.value==""){rdShowConfirmDialog("���������ѻ���");return;}
 		if(parseInt(used_point.value,10)%100 !=0){
 			rdShowConfirmDialog("�������ѱ�������������");
 			used_point.value="";
 			return false;
 		}
 		
 		if(parseInt(used_point.value,10)>parseInt(point.value,10)){
 			rdShowConfirmDialog("�������Ѳ��ܴ��ڵ�ǰ����");
 			used_point.value="";
 			return false;
 		}

 		if(sm_code.value=="���еش�")
			point_money.value=parseFloat(used_point.value,10)*(3/100);
 		else
 			point_money.value=parseFloat(used_point.value,10)*(5/100);

 		if (price.value==""){price.value="0";}
 		if (pay_money.value==""){pay_money.value="0";}
 		if(parseFloat(point_money.value)>parseFloat(price.value)){
 			rdShowConfirmDialog("�������ѳ�ֽ��("+point_money.value+")���ܴ�����������("+price.value+")");
 			used_point.value="";
 			return false;
 		}

 		sum_money.value=parseFloat(max_money.value)-parseFloat(point_money.value);
 		return true;
 	}
 }
//-->
</script>
</head>
<body>
<form name="frm" method="post" action="f8678_2.jsp" onKeyUp="chgFocus(frm)">
	
	<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">���ֻ�G3������</div>
		</div>
		
        <table cellspacing="0">
		  <tr>
            <td class="blue">��������</td>
            <td colspan="3">���ֻ�G3����������</td>           
          </tr>
          <tr>
            <td class="blue">�ͻ�����</td>
            <td>
			  <input name="cust_name" value="<%=bp_name%>" type="text" v_must=1 readonly Class="InputGrey" id="cust_name" maxlength="20" >
			  
            </td>
            <td class="blue">�ͻ���ַ</td>
            <td>
			  <input name="cust_addr" value="<%=bp_add%>" type="text" v_must=1 readonly Class="InputGrey" id="cust_addr" maxlength="50" size="50">			  
            </td>
          </tr>
            <tr>
            <td class="blue">֤������</td>
            <td>
			  <input name="cardId_type" value="<%=cardId_type%>" type="text" v_must=1 readonly Class="InputGrey" id="cardId_type" maxlength="20" >
			 
            </td>
            <td class="blue">֤������</td>
            <td>
			  <input name="cardId_no" value="<%=cardId_no%>" type="text" v_must=1 readonly Class="InputGrey" id="cardId_no" maxlength="20" >
			  
            </td>
            </tr>
            <tr>
            <td class="blue">ҵ��Ʒ��</td>
            <td>
			  <input name="sm_code" value="<%=sm_code%>" type="text" v_must=1 readonly Class="InputGrey" id="sm_code" maxlength="20" >
			  
            </td>
            <td class="blue">����״̬</td>
            <td>
			  <input name="run_type" value="<%=run_name%>" type="text" v_must=1 readonly Class="InputGrey" id="run_type" maxlength="20" >
            </td>
            </tr>
            <tr>
            <td class="blue">��ǰ����</td>
            <td>
			  <input name="point" value="<%=posint%>" type="text" v_must=1 readonly Class="InputGrey" id="point" maxlength="20" >
			  
            </td>
            <td class="blue">����Ԥ��</td>
            <td>
			  <input name="prepay_fee" value="<%=prepay_fee%>" type="text" v_must=1 readonly Class="InputGrey" id="prepay_fee" maxlength="20" >
			  
            </td>
            </tr>
             <tr>
            <td class="blue">������Ʒ��</td>
            <td>
			  <SELECT id="agent_code" name="agent_code" v_must=1  onchange="selectChange(this, phone_type, arrPhoneName, arrAgentCode);">
			    <option value ="">--��ѡ��--</option>
                <%for(int i = 0 ; i < agentCodeArr.length ; i ++){%>
                 <option value="<%=agentCodeArr[i][0]%>"><%=agentCodeArr[i][1]%></option>
                <%}%>
        </select>
			  <font class="orange">*</font>
			</td>
	    <td class="blue">�������ͺ�</td>
      <td>
			  <select size=1 name="phone_type" id="phone_type" v_must=1 onchange="typechange()">
        </select>
			  <font class="orange">*</font>
			</td>
      </tr>
      <tr>
        <td class="blue">Ӫ������</td>
        <td>
			  <select size=1 name="sale_code" id="sale_code" v_must=1 onchange="salechage()">
              </select>
			  <font class="orange">*</font>
			  </td>
			  <td colspan="2" class="blue">�Ƿ��������<input type="checkbox" name="need_award" onclick="checkAward()" />
				<input type="hidden" name="award_flag" value="0" />
		  	</td>
       </tr>
       <tr>
            <td class="blue">����������</td>
            <td >
			  <input Class="InputGrey" name="price" type="text" id="price" v_type="money" v_must=1   readonly >			  
			</td>
            <td class="blue">���ͻ���</td>
            <td>
			  <input Class="InputGrey" name="pay_money" type="text" id="pay_money" v_type="0_9" v_must=1 readonly >
			</td>
          </tr>
          <tr>
           <td class="blue">������������</td>
            <td>
				<input Class="InputGrey" name="Consume_Term" type="text"   id="Consume_Term" v_type="0_9" v_must=1   v_name="������������" readonly>
						</td>
            <td class="blue">��������</td>
            <td>
				<input Class="InputGrey" name="net_money" type="text"  id="net_money" v_type="money" v_must=1   readonly v_name="������������" >
			</td>
          </tr>
          <tr>
			<td class="blue">��������������</td>
            <td>
				<input Class="InputGrey" name="Active_Term" type="text"   id="Active_Term" v_type="0_9" v_must=1   v_name="��������������" readonly>
			</td>
			<td class="blue">���ѻ���</td>
          <td><input type="text" name="used_point" id="used_point" onchange="pointchange()" >
          <font class="orange">*</font>
          </td>
           </tr>
         <tr> 
          <td class="blue">Ӧ�����</td>
            <td >
			  <input Class="InputGrey" name="sum_money" type="text" id="sum_money" readonly>
			  <input name="max_money" type="hidden" value="" readonly Class="InputGrey">
			</td>
			<td class="blue">
				<div align="left">IMEI��</div>
            </TD>
            <TD colspan="3">
				<input name="IMEINo" type="text" v_type="0_9"  maxlength=15 value="" onblur="viewConfirm()">
				<input name="checkimei" class="b_text" type="button" value="У��" onclick="checkimeino()">
                <font class="orange">*</font>
            </TD>
          </TR>
          	<!-- ningtn add for pos start @ 20100722 -->
			<tr>
			<td class="blue">�ɷѷ�ʽ</td>
			<td colspan="3">
				<select name="payTypeSelect" >
					<option value="0">�ֽ�ɷ�</option>
					<option value="BX">��������POS���ɷ�</option>
					<option value="BY">��������POS���ɷ�</option>
				</select>
			</td>
			</tr>
			<!-- ningtn add for pos end @ 20100722 -->
		  <tr id=showHideTr >
			<TD class="blue">
				<div align="left">����ʱ��</div>
            </TD>
			<TD >
				<input name="payTime" type="text"  value="<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>">
				(������)<font class="orange">*</font>
			</TD>
			<TD class="blue">
				<div align="left">����ʱ��</div>
			</TD>
			<TD >
				<input name="repairLimit" v_type="date.month" size="10" type="text"  value="12" onblur="viewConfirm()">
				(����)<font class="orange">*</font>
			</TD>
          </TR>
		  <tr style="display:none">
            <td class="blue">�û���ע</td>
            <td colspan="3">
             <input name="opNote" type="text" id="opNote" size="60" maxlength="60" value="���ֻ�G3������" >
            </td>
          </tr>
          <tr>
            <td colspan="4" id="footer"> <div align="center">
                <input name="confirm" type="button" class="b_foot" index="2" value="ȷ��&��ӡ" onClick="printCommit()" disabled>
                &nbsp;
                <input name="reset" type="reset" class="b_foot" value="���" onclick="IMEINo.readOnly=false">
                &nbsp;
                <input name="back" onClick="javascript:history.go(-1);" type="button" class="b_foot" value="����">
                &nbsp; </div></td>
          </tr>
    </table>
    <input type="hidden" name="phone_no" value="<%=phoneNo%>">
    <input type="hidden" name="work_no" value="<%=loginName%>">
    <input type="hidden" name="login_accept" value="<%=printAccept%>">
    <input type="hidden" name="opcode" value="<%=opcode%>">
    <input type="hidden" name="Market_Price" >
    <input type="hidden" name="point_money" >
    <input type="hidden" name="sale_type" value="26" >
    <input type="hidden" name="phone_typename" >
    <!-- ningtn add for pos start @ 20100722 -->		
	<input type="hidden" name="payType"  value=""><!-- �ɷ����� payType=BX �ǽ��� payType=BY �ǹ��� -->			
	<input type="hidden" name="MerchantNameChs"  value=""><!-- �Ӵ˿�ʼ����Ϊ���в��� -->
	<input type="hidden" name="MerchantId"  value="">
	<input type="hidden" name="TerminalId"  value="">
	<input type="hidden" name="IssCode"  value="">
	<input type="hidden" name="AcqCode"  value="">
	<input type="hidden" name="CardNo"  value="">
	<input type="hidden" name="BatchNo"  value="">
	<input type="hidden" name="Response_time"  value="">
	<input type="hidden" name="Rrn"  value="">
	<input type="hidden" name="AuthNo"  value="">
	<input type="hidden" name="TraceNo"  value="">
	<input type="hidden" name="Request_time"  value="">
	<input type="hidden" name="CardNoPingBi"  value="">
	<input type="hidden" name="ExpDate"  value="">
	<input type="hidden" name="Remak"  value="">
	<input type="hidden" name="TC"  value="">
	<!-- ningtn add for pos end @ 20100722 -->
    <%@ include file="/npage/include/footer.jsp" %>   
</form>
</body>
<!-- **** ningtn add for pos @ 20100722 ******���ؽ��пؼ�ҳ BankCtrl ******** -->
<%@ include file="/npage/public/posCCB.jsp" %>
<!-- **** ningtn add for pos @ 20100722 ******���ع��пؼ�ҳ KeeperClient ******** -->
<%@ include file="/npage/public/posICBC.jsp" %>
</html>


