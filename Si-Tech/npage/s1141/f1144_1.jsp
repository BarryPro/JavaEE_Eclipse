<%
/********************
 version v2.0
 ������: si-tech
 update zhaohaitao at 2008.11.26
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
%>

<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>


<%
  String OpCode ="1144";
  String opCode = "1144";
  String opName = "���ֻ�������";

  String loginNo = (String)session.getAttribute("workNo");
  String loginName = (String)session.getAttribute("workName");
  String regionCode = (String)session.getAttribute("regCode");
  
  String orgCode = (String)session.getAttribute("orgCode");
  String groupId = (String)session.getAttribute("groupId");
  String loginNoPass = ((String)session.getAttribute("password")); 
%>
<%
  String retFlag="",retMsg="";
  String[] paraAray1 = new String[8];
  String phoneNo = request.getParameter("srv_no");
  String opcode = request.getParameter("opcode");
  String backaccept= request.getParameter("backaccept");
  String passwordFromSer="";

  paraAray1[0] = phoneNo;		/* �ֻ�����   */
  paraAray1[1] = opcode; 	    /* ��������   */
  paraAray1[2] = loginNo;	    /* ��������   */
  paraAray1[3] = backaccept;  
  paraAray1[4] = "01";          /* ����       */
  paraAray1[5] = loginNoPass; /* ��������   */
  paraAray1[6] = "";          /* �ֻ�����   */
  paraAray1[7] = "";          /* ����ˮ   */

  /*****��÷ ��� 20060605*****/

  String sqlStr = "";
  String awardName="";
  sqlStr = "select award_name from wawardpay where phone_no ='"+phoneNo+"'"+
		    " and login_accept="+backaccept  ;

  //retArray = callView.sPubSelect("1",sqlStr);
 %>
    <wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCodeNo" retmsg="retMsgNo" outnum="1">
    <wtc:sql><%=sqlStr%>
    </wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result" scope="end"/>
 <%
  //result = (String[][])retArray.get(0);
  if(result != null && result.length > 0)
  	awardName = result[0][0];
    System.out.println("awardName="+awardName);

  if(!awardName.equals("")){
 %>
  //rdShowMessageDialog("���û�Ϊ���н��û����н���ƷΪ��"<%=awardName%>", ���û�������𷵻ؽ�Ʒ���ټ����������ҵ��");
   if(rdShowConfirmDialog("���û�Ϊ���н��û����н���ƷΪ��<%=awardName%> ���û�������𷵻ؽ�Ʒ���ټ����������ҵ��")!=1)
	{
		location='f1143_login.jsp';
	}

	</script>

<%}
  //sunzx add at 20070904
  sqlStr = "select res_info from wawarddata where flag = 'Y' and phone_no = '"+phoneNo+"'"+
		    " and login_accept="+backaccept  ;

  //retArray = callView.sPubSelect("1",sqlStr);
%>
   <wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCodeNo2" retmsg="retMsgNo2" outnum="2">
     <wtc:sql><%=sqlStr%>
     </wtc:sql>
     </wtc:pubselect>
   <wtc:array id="result2" scope="end"/>
<%
  if(result2 != null && result2.length > 0)
  {
	  awardName = result2[0][0];
	  System.out.println("awardName2="+awardName);
  	  if(!awardName.equals("")){
%>
		  <script language="JavaScript" >
		  	rdShowMessageDialog("���û����ڴ���Ʒͳһ�����н���<%=awardName%>�콱������д���Ʒͳһ������������ȷ����Ʒ���");
			location='f1143_login.jsp';
		  </script>
<%	  }
  }
/*****��÷ ��� 20060605*******/

  for(int i=0; i<paraAray1.length; i++)
  {
	if( paraAray1[i] == null )
	{
	  paraAray1[i] = "";
	}
  }
 /* ��������� �����룬������Ϣ���ͻ��������ͻ���ַ��֤�����ͣ�֤�����룬ҵ��Ʒ�ƣ�
 			�����أ���ǰ״̬��VIP���� ����ǰ���֣��û�Ԥ�棬
 			Ӫ����������Ӧ���������������������ͻ��ѣ����ѻ�����
 */
  //retList = impl.callFXService("s1142Qry", paraAray1, "24","phone",phoneNo);
%>  
  <wtc:service name="s1142Qry" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="29" >
	<wtc:param value="<%=paraAray1[7]%>"/>
	<wtc:param value="<%=paraAray1[4]%>"/>
	<wtc:param value="<%=paraAray1[1]%>"/>
	<wtc:param value="<%=paraAray1[2]%>"/>
	<wtc:param value="<%=paraAray1[5]%>"/>
	<wtc:param value="<%=paraAray1[0]%>"/>
	<wtc:param value="<%=paraAray1[6]%>"/>
	<wtc:param value="<%=paraAray1[3]%>"/>
	</wtc:service>
  <wtc:array id="tempArr" scope="end"/>
<%
  String  bp_name="",bp_add="",cardId_type="",cardId_no="",sm_code="",region_name="",run_name="",vip="",posint="",prepay_fee="";
  String sale_name="",sum_money="",scard_money="",card_num="",pay_money="",used_point="",card_money="",type_name="";
  String vspec_name="",vmode_code="",vused_date="",vspec_fee="";
	String payType="",Response_time="",TerminalId="",Rrn="",Request_time="";
  String errCode = retCode1;
  String errMsg = retMsg1;
  if(tempArr == null)
  {
	if(!retFlag.equals("1"))
	{
	   System.out.println("retFlag="+retFlag);
	   retFlag = "1";
	   retMsg = "s12fbInit��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
    }
  }else if(!(tempArr == null))
  {
  	System.out.println("errCode="+errCode);
  	System.out.println("errMsg="+errMsg);
  	if(!errCode.equals("000000")){%>
    	<script language="JavaScript">
    	<!--
  	  	rdShowMessageDialog("������룺<%=errCode%>������Ϣ��<%=errMsg%>",0);
  	  	history.go(-1);
  		//-->
        </script>
  <%}
	if (errCode.equals("000000")){

	    bp_name = tempArr[0][2];                //��������
	    System.out.println(bp_name);
	    bp_add = tempArr[0][3];                 //�ͻ���ַ
	    cardId_type = tempArr[0][4];            //֤������
	    cardId_no = tempArr[0][5];              //֤������
	    sm_code = tempArr[0][6];                //ҵ��Ʒ��
	    region_name = tempArr[0][7];            //������
	    run_name = tempArr[0][8];               //��ǰ״̬
	    vip = tempArr[0][9];                    //�֣ɣм���
	    posint = tempArr[0][10];                //��ǰ����
	    prepay_fee = tempArr[0][11];            //����Ԥ��
	    sale_name = tempArr[0][12];             //Ӫ��������
	    sum_money = tempArr[0][13];             //Ӧ�����
	    scard_money = tempArr[0][14];           //����
	    card_num = tempArr[0][15];              //��������
	    pay_money = tempArr[0][16];             //���ͻ���
	    used_point = tempArr[0][17];            //���ѻ�����
	    card_money = tempArr[0][18];            //�����
	    type_name = tempArr[0][19];             //�����
	    vspec_name = tempArr[0][20];            //����ҵ������
	    vused_date = tempArr[0][21];            //����ʱ��
	    vspec_fee = tempArr[0][22].trim();      //���
	    if(vspec_fee.equals("")){vspec_fee="0";}
	    vmode_code = tempArr[0][23];            //���
	    pay_money=""+(Float.parseFloat(pay_money)-Float.parseFloat(vspec_fee));
	    
			///////<!-- ningtn add for pos start @ 20100414 -->
			if(tempArr[0][24] != null && tempArr[0][24].trim().length() > 0){
				payType = tempArr[0][24].trim();
			}else{
				payType = "0";
			}
			Response_time = tempArr[0][25].trim();
			TerminalId = tempArr[0][26].trim();
			Rrn = tempArr[0][27].trim();
			Request_time = tempArr[0][28].trim();
			
			System.out.println("payType : " + payType);
			System.out.println("Response_time : " + Response_time);
			System.out.println("TerminalId : " + TerminalId);
			System.out.println("Rrn : " + Rrn);
			System.out.println("Request_time : " + Request_time);
			///////<!-- ningtn add for pos end @ 20100414 -->
	}
  }

%>

<%
//******************�õ�����������***************************//
String printAccept="";
printAccept = getMaxAccept();
System.out.println(printAccept);
/*
  comImpl co=new comImpl();
  //�ֻ�Ʒ��
  String sqlAgentCode = " select  unique a.brand_code,trim(b.brand_name) from sPhoneSalCfg a,sphbrandcode b where a.region_code='" + regionCode + "' and a.sale_type='0' and a.brand_code=b.brand_code and valid_flag='Y'";
  System.out.println("sqlAgentCode====="+sqlAgentCode);
  ArrayList agentCodeArr = co.spubqry32("2",sqlAgentCode);
  String[][] agentCodeStr = (String[][])agentCodeArr.get(0);
  //�ֻ�����
  String sqlPhoneType = "select unique a.type_code,trim(b.type_name), b.brand_code from sPhoneSalCfg a,stypecode b where a.region_code='" + regionCode + "' and  a.type_code=b.type_code and a.brand_code=b.brand_code and valid_flag='Y'";
  System.out.println("sqlPhoneType====="+sqlPhoneType);
  ArrayList phoneTypeArr = co.spubqry32("3",sqlPhoneType);
  String[][] phoneTypeStr = (String[][])phoneTypeArr.get(0);
  //Ӫ������
  String sqlsaleType = "select unique a.sale_code,trim(a.sale_name), a.brand_code,a.type_code from sPhoneSalCfg a where a.region_code='" + regionCode + "' and a.sale_type='0' and valid_flag='Y'";
  System.out.println("sqlsaleType====="+sqlsaleType);
  ArrayList saleTypeArr = co.spubqry32("4",sqlsaleType);
  String[][] saleTypeStr = (String[][])saleTypeArr.get(0);
 */
%>
<head>
<title>���ֻ�������</title>
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

    if(retCode!=0){
    	rdShowConfirmDialog(retMessage);
    	retrun ;
    }
    if(retType == "getcard"){

    	document.all.price.value = packet.data.findValueByName("phonemoney");
    	document.all.card_info.value = packet.data.findValueByName("cardvalue");
    	document.all.pay_money.value = packet.data.findValueByName("prepay_gift");
    	document.all.sum_money.value = packet.data.findValueByName("phonemoney");
    	document.all.card_money.value = packet.data.findValueByName("cardshould");
    	document.all.card_dz.value = packet.data.findValueByName("cardmoney");
    	document.all.cardy.value = packet.data.findValueByName("cardy");
    }
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

  //***
  function frmCfm(){

		/* ningtn add for pos start @ 20100408 */
		if(document.all.payType.value=="BX")
	  	{
	    		/*set �������*/
					var transerial    = "000000000000";  	                     //����Ψһ�� ������ȡ��
					var trantype      = "01";                                  //��������
					var bMoney        = "<%=sum_money%>";					 							 //�ɷѽ��
					if(bMoney.indexOf(".") == -1) bMoney=bMoney+"00";
					var tranoper      = "<%=loginNo%>";                        //���ײ���Ա
					var orgid         = "<%=groupId%>";                        //ӪҵԱ��������
					var trannum       = "<%=phoneNo%>";                    		 //�绰����
					getSysDate();       /*ȡbossϵͳʱ��*/
					var respstamp     = document.all.Request_time.value;       //�ύʱ��
					var transerialold = "<%=Rrn%>";			                               //ԭ����Ψһ��,�ڽɷ�ʱ�����
					var org_code      = "<%=orgCode%>";                        //ӪҵԱ����						
					CCBCommon(transerial,trantype,bMoney,tranoper,orgid,trannum,respstamp,transerialold,org_code);
					if(ccbTran=="succ") posSubmitForm();
	  	}
			else if(document.all.payType.value=="BY")
			{
					var transType     = "04";																	/*�������� */         
					var bMoney        = "<%=sum_money%>";							          /*���׽�� */         
					if(bMoney.indexOf(".") == -1) bMoney=bMoney+"00";
					var response_time = "<%=Response_time%>";                 /*ԭ�������� */       
					var rrn           = "<%=Rrn%>";                           /*ԭ����ϵͳ������ */ 
					var instNum       = "";                                   /*���ڸ������� */     
					var terminalId    = "<%=TerminalId%>";                    /*ԭ�����ն˺� */
					getSysDate();       //ȡbossϵͳʱ��                                            
					var request_time  = document.all.Request_time.value;      /*�����ύ���� */     
					var workno        = "<%=loginNo%>";                       /*���ײ���Ա */       
					var orgCode       = "<%=orgCode%>";                       /*ӪҵԱ���� */       
					var groupId       = "<%=groupId%>";                       /*ӪҵԱ�������� */   
					var phoneNo       = "<%=phoneNo%>";                   		/*���׽ɷѺ� */       
					var toBeUpdate    = "";						                        /*Ԥ���ֶ� */         
					var posFlag = ICBCCommon(transType,bMoney,response_time,rrn,instNum,terminalId,request_time,workno,orgCode,groupId,phoneNo,toBeUpdate);									
					if(icbcTran=="succ") posSubmitForm();
			}else{
					posSubmitForm();
			}
			/* ningtn add for pos end @ 20100408 */
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
  with(document.frm){
	opNote.value=phone_no.value+"������ֻ�������ҵ��";
	//phone_typename.value=document.all.agent_code.options[document.all.agent_code.selectedIndex].text+document.all.phone_type.options[document.all.phone_type.selectedIndex].text;
  }
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

   var pType="subprint";                                         // ��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
   var billType="1";                                          // Ʊ�����ͣ�1���������2��Ʊ��3�վ�
   var sysAccept=document.all.login_accept.value;             // ��ˮ��
   var printStr=printInfo(printType);                         //����printinfo()���صĴ�ӡ����
   var mode_code=null;                                        //�ʷѴ���
   var fav_code=null;                                         //�ط�����
   var area_code=null;                                        //С������
   var opCode="1144";                                         //��������
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

	opr_info+="ҵ�����ͣ����ֻ�������"+"|";
    opr_info+="ҵ����ˮ��"+document.all.login_accept.value+"|";
    opr_info+="�ֻ��ͺ�: "+document.all.type_name.value+"|";

	var jkinfo="";
	if(parseInt(document.all.card_money.value,10)==0){
		jkinfo+="�˿�ϼƣ�"+document.all.sum_money.value+"Ԫ������Ԥ�滰��"+document.all.pay_money.value+"Ԫ";
	}else{
		jkinfo+="�˿�ϼƣ�"+document.all.sum_money.value+"Ԫ������Ԥ�滰��"+document.all.pay_money.value+"Ԫ����"+document.all.cardy.value;
	}
	if(document.all.spec_fee.value!="0"){
		jkinfo+="��"+(document.all.spec_name.value).trim()+" "+parseInt(document.all.spec_fee.value,10)+"Ԫ";
	}
	opr_info+=jkinfo+"|";
    note_info1="��ע��"+document.all.opNote.value+"|";
	//retInfo=cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
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
 }
 function salechage(){

	var getNote_Packet = new AJAXPacket("f1141_getcardrpc.jsp","���ڻ��Ӫ����ϸ�����Ժ�......");
    getNote_Packet.data.add("retType","getcard");
	getNote_Packet.data.add("saletype","0");
	getNote_Packet.data.add("regionCode","<%=regionCode%>");
	getNote_Packet.data.add("salecode",document.all.sale_code.value);
	core.ajax.sendPacket(getNote_Packet);
	getNote_Packet=null;
 }
/*
 function getSum(){
   with(document.frm){
	   if(!(num.value=="") && !(price.value=="")){
         if(!checkElement("num")) return false;
	     if(!checkElement("price")) return false;
	     sum_money.value = num.value * price.value;
	   }
   }
 }
 */
//-->
</script>
</head>
<body>
<form name="frm" method="post" action="f1144_2.jsp" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>

		<div class="title">
			<div id="title_zi">���ֻ�������</div>
		</div>

        <table cellspacing="0">
		  <tr>
            <td class="blue">��������</td>
            <td colspan="3">���ֻ�������</td>
          </tr>
          <tr>
            <td class="blue">�ͻ�����</td>
            <td>
			  <input name="cust_name" value="<%=bp_name%>" type="text" Class="InputGrey" v_must=1 readonly id="cust_name">
            </td>
            <td class="blue">�ͻ���ַ</td>
            <td>
			  <input name="cust_addr" value="<%=bp_add%>" type="text" Class="InputGrey" v_must=1 readonly id="cust_addr">
            </td>
          </tr>
          <tr>
            <td class="blue">֤������</td>
            <td>
			  <input name="cardId_type" value="<%=cardId_type%>" type="text" Class="InputGrey" v_must=1 readonly id="cardId_type">
            </td>
            <td class="blue">֤������</td>
            <td>
			  <input name="cardId_no" value="<%=cardId_no%>" type="text" Class="InputGrey" v_must=1 readonly id="cardId_no">
            </td>
          </tr>
          <tr>
            <td class="blue">ҵ��Ʒ��</td>
            <td>
			  <input name="sm_code" value="<%=sm_code%>" type="text" Class="InputGrey" v_must=1 readonly id="sm_code">
            </td>
            <td class="blue">����״̬</td>
            <td>
			  <input name="run_type" value="<%=run_name%>" type="text" Class="InputGrey" v_must=1 readonly id="run_type">
            </td>
          </tr>
          <tr>
            <td class="blue">��ǰ����</td>
            <td>
			  <input name="posint" value="<%=posint%>" type="text" Class="InputGrey" v_must=1 readonly id="posint">
            </td>
            <td class="blue">����Ԥ��</td>
            <td>
			  <input name="prepay_fee" value="<%=prepay_fee%>" type="text" Class="InputGrey" v_must=1 readonly id="prepay_fee">
            </td>
          </tr>
          <tr>
            <td class="blue">Ӫ������</td>
            <td colspan="3">
			  <input type="text" name="sale_code" Class="InputGrey" readonly id="sale_code" value="<%=sale_name%>" >
			</td>
          </tr>
          <tr>
             <td class="blue">���Ϳ�����</td>
             <td>
			  <input name="card_money" type="text" Class="InputGrey" id="card_money" v_type="money" v_must=1 readonly value="<%=card_money%>">
			</td>
            <td class="blue">���ͻ���</td>
            <td>
			  <input name="pay_money" type="text" Class="InputGrey" id="pay_money" v_type="0_9" v_must=1 readonly value="<%=pay_money%>">
			</td>
          </tr>
          <tr>
            <td class="blue">���Ϳ�����Ϣ</td>
            <td colspan="3">
			  <input type="text" name="card_info" Class="InputGrey" id="card_info"  readonly value="<%=card_num%>">
			</td>
          </tr>
          <tr>
            <td class="blue">��������ҵ��</td>
            <td>
			  <input type="text" name="spec_name" Class="InputGrey" id="spec_name" value="<%=vspec_name%>" readonly>
			</td>
            <td class="blue">���</td>
            <td>
			  <input type="text" name="spec_fee" Class="InputGrey" id="spec_fee"  value="<%=vspec_fee%>" readonly>
			</td>
          </tr>
          <tr>
            <td class="blue">����ʱ��</td>
            <td >
			  <input name="used_date" type="text" Class="InputGrey" id="used_date"   value="<%=vused_date%>"  readonly>
			</td>
            <td class="blue">�ײʹ���</td>
            <td>
			  <input name="mode_code" type="text" Class="InputGrey" id="mode_code"   value="<%=vmode_code%>" readonly>
			</td>
          </tr>
          <tr>
            <td class="blue">Ӧ�����</td>
            <td colspan="3">
			  <input name="sum_money" type="text" Class="InputGrey" id="sum_money" readonly value="<%=sum_money%>">
			</td>
          </tr>
          <tr style="display:none">
            <td class="blue">��ע</td>
            <td colspan="3">
             <input name="opNote" type="text" id="opNote" value="���ֻ�������">
            </td>
          </tr>
<jsp:include page="/npage/public/hwReadCustCard.jsp">
	<jsp:param name="hwAccept" value="<%=printAccept%>"  />
	<jsp:param name="showBody" value="01"  />
</jsp:include>
          <tr>
            <td colspan="4">
            	<div align="center">
                <input name="confirm" type="button" class="b_foot" index="2" value="ȷ��&��ӡ" onClick="printCommit()">
                <input name="reset" type="reset" class="b_foot" value="���" >
                <input name="back" onClick="javascript:history.go(-1);" type="button" class="b_foot" value="����">
                </div>
            </td>
          </tr>
        </table>

    <input type="hidden" name="phone_no" value="<%=phoneNo%>">
    <input type="hidden" name="work_no" value="<%=loginName%>">
    <input type="hidden" name="login_accept" value="<%=printAccept%>">
    <input type="hidden" name="backaccept" value="<%=backaccept%>">
    <input type="hidden" name="card_dz" >
    <input type="hidden" name="used_point" value="0" >
    <input type="hidden" name="point_money" value="0" >
    <input type="hidden" name="opcode" value="<%=opcode%>">
    <input type="hidden" name="sale_type" value="0" >
    <input type="hidden" name="phone_typename" >
    <input type="hidden" name="cardy" value="<%=scard_money%>">
    <input type="hidden" name="type_name" value="<%=type_name%>">
    
    <!-- ningtn add for pos start @ 20100414 -->
			<input type="hidden" name="payType"  value="<%=payType%>" ><!-- �ɷ����� payType=BX �ǽ��� payType=BY �ǹ��� -->
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
		<!-- ningtn add for pos start @ 20100414 -->
    <%@ include file="/npage/include/footer.jsp" %>
    <%@ include file="../../npage/common/pwd_comm.jsp" %>
</form>
<!-- **** ningtn add for pos @ 20100414 ******���ؽ��пؼ�ҳ BankCtrl ******** -->
<%@ include file="/npage/public/posCCB.jsp" %>
<!-- **** ningtn add for pos @ 20100414 ******���ع��пؼ�ҳ KeeperClient ******** -->
<%@ include file="/npage/public/posICBC.jsp" %>
</body>
<%@ include file="/npage/public/hwObject.jsp" %> 
</html>


