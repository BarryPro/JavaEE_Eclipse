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

  String opCode = "1143";
  String opName = "���ֻ���";

  String retFlag="",retmsg="";
  String[] paraAray1 = new String[3];
  String phoneNo = request.getParameter("srv_no");
  String opcode = request.getParameter("opcode");
  String passwordFromSer="";
  
  String groupId = (String)session.getAttribute("groupId");
  String orgCode =(String)session.getAttribute("orgCode");
  String loginPwd    = (String)session.getAttribute("password");
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

		<wtc:param value=" "/>
		<wtc:param value="01"/>		
		<wtc:param value="<%=paraAray1[1]%>"/>
		<wtc:param value="<%=paraAray1[2]%>"/>
		<wtc:param value="<%=loginPwd%>"/>										
		<wtc:param value="<%=paraAray1[0]%>"/>
		<wtc:param value=""/>
		
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
System.out.println("sysAccept==================="+printAccept);
  //�ֻ�Ʒ��
  String sqlAgentCode = " select  unique a.brand_code,trim(b.brand_name) from sPhoneSalCfg a,schnresbrand b where a.region_code='" + regionCode + "' and a.sale_type='2' and a.brand_code=b.brand_code and valid_flag='Y' and a.spec_type like 'P%' and is_valid='1'";
  System.out.println("sqlAgentCode====="+sqlAgentCode);
  //ArrayList agentCodeArr = co.spubqry32("2",sqlAgentCode);
 %>
  <wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode2" retmsg="retMsg2" outnum="2">
    <wtc:sql><%=sqlAgentCode%>
    </wtc:sql>
	</wtc:pubselect>
	<wtc:array id="agentCodeArr" scope="end"/>

<%
  System.out.println("errorCode2=========="+retCode2);
  System.out.println("errorMsg2=========="+retMsg2);
  //�ֻ�����
  String sqlPhoneType = "select unique a.type_code,trim(b.res_name), b.brand_code from sPhoneSalCfg a,schnrescode_chnterm b where a.region_code='" + regionCode + "' and  a.type_code=b.res_code and a.brand_code=b.brand_code and valid_flag='Y' and a.sale_type='2' and a.spec_type like 'P%' and is_valid='1'";
  System.out.println("sqlPhoneType====="+sqlPhoneType);
  //ArrayList phoneTypeArr = co.spubqry32("3",sqlPhoneType);
 %>
  <wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode3" retmsg="retMsg3" outnum="3">
    <wtc:sql><%=sqlPhoneType%>
    </wtc:sql>
	</wtc:pubselect>
	<wtc:array id="phoneTypeArr" scope="end"/>
 <%
  System.out.println("errorCode3=========="+retCode3);
  System.out.println("errorMsg3=========="+retMsg3);
  //Ӫ������
  String sqlsaleType = "select unique a.sale_code,trim(a.sale_name), a.brand_code,a.type_code from sPhoneSalCfg a where a.region_code='" + regionCode + "' and a.sale_type='2' and valid_flag='Y' and a.spec_type like 'P%'";
  System.out.println("sqlsaleType====="+sqlsaleType);
  //ArrayList saleTypeArr = co.spubqry32("4",sqlsaleType);
%>
 <wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode4" retmsg="retMsg4" outnum="4">
    <wtc:sql><%=sqlsaleType%>
    </wtc:sql>
	</wtc:pubselect>
	<wtc:array id="saleTypeArr" scope="end"/>
<%
	System.out.println("errorCode4=========="+retCode4);
    System.out.println("errorMsg4=========="+retMsg4);
%>
<head>
<title>���ֻ���</title>
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

		if(retType == "getcard"){
    		if(retCode!="000000"){
    			return;
    		}

    	document.all.price.value="";
		document.all.price.value = packet.data.findValueByName("phonemoney");
		document.all.card_info.value="";
    	document.all.card_info.value = packet.data.findValueByName("cardvalue");
    	document.all.pay_money.value="";
    	document.all.pay_money.value = packet.data.findValueByName("prepay_gift");
		document.all.card_money.value="";
    	document.all.card_money.value = packet.data.findValueByName("cardshould");
    	document.all.card_dz.value="";
    	document.all.card_dz.value = packet.data.findValueByName("cardmoney");
    	document.all.cardy.value="";
    	document.all.cardy.value = packet.data.findValueByName("cardy");
		document.all.mode_code.value="";
    	document.all.mode_code.value = packet.data.findValueByName("vmode_code");
    	document.all.spec_name.value="";
    	document.all.spec_name.value = packet.data.findValueByName("vspec_name");
    	document.all.spec_fee.value="";
    	document.all.spec_fee.value = (packet.data.findValueByName("vspec_fee")).trim();
    	if(document.all.spec_fee.value==""){document.all.spec_fee.value="0";}
    	document.all.used_date.value = packet.data.findValueByName("vused_date");
    	document.all.card_type.value = packet.data.findValueByName("vcard_type");

    	}else if(retType == "checkAward")
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

  var arrPhoneType = new Array();//�ֻ��ͺŴ���
  var arrPhoneName = new Array();//�ֻ��ͺ�����
  var arrAgentCode = new Array();//�����̴���
  var selectStatus = 0;

  var arrsalecode =new Array();
  var arrsaleName=new Array();
  var arrsalebarnd=new Array();
  var arrsaletype=new Array();

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
%>

  //***
  function frmCfm(){
		///////<!-- ningtn add for pos start @ 20100408 -->
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
		
		//////<!-- ningtn add for pos end @ 20100408 -->
  }
 //***
 	/* ningtn add for pos start @ 20100414 */
	function posSubmitForm(){
		frm.submit();
		return true;
	}
	function getSysDate()
	{
		var myPacket = new AJAXPacket("../s1300/s1300_getSysDate.jsp","���ڻ��ϵͳʱ�䣬���Ժ�......");
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
	/* ningtn add for pos start @ 20100414 */
 
 function printCommit()
 {
  getAfterPrompt();
  document.frm.confirm.disabled=true; /*diling add for ���:�ύ���ύ��ť�û�@2012/5/21*/
  //У��
  //if(!check(frm)) return false;
  with(document.frm){
    if(cust_name.value==""){
	  rdShowMessageDialog("����������!");
      cust_name.focus();
	  return false;
	}
	if(agent_code.value==""){
	  rdShowMessageDialog("�������ֻ�Ʒ��!");
      agent_code.focus();
	  return false;
	}
	if(phone_type.value==""){
	  rdShowMessageDialog("�������ֻ��ͺ�!");
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
	opNote.value=phone_no.value+"������ֻ���ҵ��";
	phone_typename.value=document.all.agent_code.options[document.all.agent_code.selectedIndex].text+document.all.phone_type.options[document.all.phone_type.selectedIndex].text;
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
   var opCode="1143";                                         //��������
   var phoneNo=document.all.phone_no.value;                   //�ͻ��绰
       /* ningtn */
    var iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
		var accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" +$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();
    /* ningtn */

   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
   var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm+"&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr;
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

	opr_info+="ҵ�����ͣ����ֻ���"+"|";
    opr_info+="ҵ����ˮ��"+document.all.login_accept.value+"|";
    opr_info+="�ֻ��ͺ�: "+document.all.agent_code.options[document.all.agent_code.selectedIndex].text+document.all.phone_type.options[document.all.phone_type.selectedIndex].text+"      IMEI�룺"+document.frm.IMEINo.value+"|";

	var jkinfo="";
	if(parseInt(document.all.card_money.value,10)==0){
		jkinfo="�ɿ�ϼƣ�"+document.all.sum_money.value+"Ԫ ��:Ԥ�滰�� "+document.all.pay_money.value+"Ԫ";
	}else{
		jkinfo+="�ɿ�ϼƣ�"+document.all.sum_money.value+"Ԫ ��:Ԥ�滰�� "+document.all.pay_money.value+"Ԫ��"+document.all.cardy.value;
	}
	if(document.all.spec_fee.value!="0"){
		jkinfo+="��"+(document.all.spec_name.value).trim()+" "+document.all.spec_fee.value+"Ԫ"+"|";
	}
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
 	 document.frm.confirm.disabled=true;
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
  document.frm.confirm.disabled=true;
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

	var getNote_Packet = new AJAXPacket("f1141_getcardrpc.jsp","���ڻ��Ӫ����ϸ�����Ժ�......");
  getNote_Packet.data.add("retType","getcard");
	getNote_Packet.data.add("saletype","2");
	getNote_Packet.data.add("regionCode","<%=regionCode%>");
	getNote_Packet.data.add("salecode",document.all.sale_code.value);
	core.ajax.sendPacket(getNote_Packet);
	getNote_Packet=null;
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
 	 	 packet.data.add("op_code","1143");
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

 		if(parseInt(used_point.value,10)>100000){
 			rdShowConfirmDialog("�������Ѳ��ܴ���100000");
 			used_point.value="";
 			return false;
 		}

 		if(parseInt(used_point.value,10)>parseInt(point.value,10)){
 			rdShowConfirmDialog("�������Ѳ��ܴ��ڵ�ǰ����");
 			used_point.value="";
 			return false;
 		}

    point_money.value=parseFloat(used_point.value,10)*(1.5/100);


 		if (price.value==""){price.value="0";}
 		if (card_money.value==""){card_money.value="0";}
 		if (spec_fee.value==""){spec_fee.value="0";}
 		if (pay_money.value==""){pay_money.value="0";}
 		max_money.value=parseFloat(price.value)-parseFloat(card_money.value)-parseFloat(spec_fee.value)-parseFloat(pay_money.value);

 		if(parseFloat(point_money.value)>parseFloat(max_money.value)){
 			rdShowConfirmDialog("�������ѳ�ֽ��("+point_money.value+")���ܴ����ֻ�����ͻ��ѡ�Ԥ����������ĺϼ�("+max_money.value+")");
 			used_point.value="";
 			return false;
 		}

 		sum_money.value=parseFloat(price.value)-parseFloat(point_money.value);
 		return true;
 	}
 }
//-->
</script>
</head>
<body>
<form name="frm" method="post" action="f1143_2.jsp" onKeyUp="chgFocus(frm)">

	<%@ include file="/npage/include/header.jsp" %>

		<div class="title">
			<div id="title_zi">���ֻ���</div>
		</div>

        <table cellspacing="0">
		  <tr>
            <td class="blue">��������</td>
            <td colspan="3">���ֻ���</td>
          </tr>
          <tr>
            <td class="blue">�ͻ�����</td>
            <td>
			  <input name="cust_name" value="<%=bp_name%>" type="text" v_must=1 readonly Class="InputGrey" id="cust_name" maxlength="20" >

            </td>
            <td class="blue">�ͻ���ַ</td>
            <td>
			  <input name="cust_addr" value="<%=bp_add%>" type="text" v_must=1 readonly Class="InputGrey" id="cust_addr" maxlength="30" size="40">
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
            <td class="blue">�ֻ�Ʒ��</td>
            <td>
			  <SELECT id="agent_code" name="agent_code" v_must=1  onchange="selectChange(this, phone_type, arrPhoneName, arrAgentCode);">
			    <option value ="">--��ѡ��--</option>
                <%for(int i = 0 ; i < agentCodeArr.length ; i ++){%>
                 <option value="<%=agentCodeArr[i][0]%>"><%=agentCodeArr[i][1]%></option>
                <%}%>
        </select>
			  <font class="orange">*</font>
			</td>
	    <td class="blue">�ֻ��ͺ�</td>
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
            <td class="blue">������</td>
            <td >
			  <input name="price" type="text" id="price" v_type="money" v_must=1   readonly Class="InputGrey">
			</td>
            <td class="blue">���ͻ���</td>
            <td>
			  <input name="pay_money" type="text" id="pay_money" v_type="0_9" v_must=1 readonly Class="InputGrey">

			</td>
          </tr>
          <tr>
            <td class="blue" nowrap>���Ϳ�����</td>
            <td colspan="3">
			  <input name="card_money" type="text" id="card_money" v_type="money" v_must=1 readonly Class="InputGrey">
			</td>

          </tr>
           <tr>

            <td class="blue" nowrap>���Ϳ�����Ϣ</td>
            <td colspan="3">
			  <input type="text" name="card_info"  id="card_info"  readonly Class="InputGrey">
			</td>

          </tr>
          <tr>

            <td class="blue" nowrap>��������ҵ��</td>
            <td>
			  <input type="text" name="spec_name" id="spec_name"  readonly Class="InputGrey">
			</td>
            <td class="blue">���</td>
            <td>
			  <input type="text" name="spec_fee" id="spec_fee"  readonly Class="InputGrey">
			</td>
          </tr>
          <tr>
            <td class="blue">����ʱ��</td>
            <td >
			  <input name="used_date" type="text" id="used_date"    readonly Class="InputGrey">

			</td>
            <td class="blue">�ײʹ���</td>
            <td>
			  <input name="mode_code" type="text" id="mode_code"  readonly Class="InputGrey">

			</td>
          </tr>
          <tr>
          <td class="blue">���ѻ���</td>
          <td><input type="text" name="used_point" id="used_point" onchange="pointchange()" >
          <font class="orange">*</font>
          </td>
            <td class="blue">Ӧ�����</td>
            <td >
			  <input name="sum_money" type="text" id="sum_money" readonly Class="InputGrey">

			  <input name="max_money" type="hidden" value="" readonly Class="InputGrey">
			</td>
          </tr>
          <!-- ningtn add for pos start @ 20100414 -->
					<TR>
						<TD class="blue">�ɷѷ�ʽ</TD>
						<TD colspan="3">
							<select name="payTypeSelect" >
								<option value="0">�ֽ�ɷ�</option>
								<option value="BX">��������POS���ɷ�</option>
								<option value="BY">��������POS���ɷ�</option>
							</select>
						</TD>
					</TR>
					<!-- ningtn add for pos end @ 20100414 -->
         <tr>
			<td class="blue">
				<div align="left">IMEI��</div>
            </TD>
            <TD colspan="3">
				<input name="IMEINo" type="text" v_type="0_9"  maxlength=15 value="" onblur="viewConfirm()">
				<input name="checkimei" class="b_text" type="button" value="У��" onclick="checkimeino()">
                <font class="orange">*</font>
            </TD>
          </TR>
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
            <td class="blue">��ע</td>
            <td colspan="3">
             <input name="opNote" type="text" id="opNote" size="60" maxlength="60" value="���ֻ���" >
            </td>
          </tr>
<jsp:include page="/npage/public/hwReadCustCard.jsp">
	<jsp:param name="hwAccept" value="<%=printAccept%>"  />
	<jsp:param name="showBody" value="01"  />
</jsp:include>
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
    <input type="hidden" name="card_dz" >
    <input type="hidden" name="point_money" >
    <input type="hidden" name="sale_type" value="2" >
    <input type="hidden" name="phone_typename" >
    <input type="hidden" name="cardy" >
    <input type="hidden" name="card_type" >
    
    <!-- ningtn add for pos start @ 20100414 -->		
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
		<!-- ningtn add for pos end @ 20100414 -->
    <%@ include file="/npage/include/footer.jsp" %>
</form>
<!-- **** ningtn add for pos @ 20100414 ******���ؽ��пؼ�ҳ BankCtrl ******** -->
<%@ include file="/npage/public/posCCB.jsp" %>
<!-- **** ningtn add for pos @ 20100414 ******���ع��пؼ�ҳ KeeperClient ******** -->
<%@ include file="/npage/public/posICBC.jsp" %>
</body>
<%@ include file="/npage/public/hwObject.jsp" %> 
</html>


