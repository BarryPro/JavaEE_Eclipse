<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����: ����Ԥ���8379
   * �汾: 1.0
   * ����: 2010/3/12
   * ����: sunaj
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>

<%
	String opCode="8379";
	String opName="����Ԥ���";
	
	String loginNo = (String)session.getAttribute("workNo");
	String loginName = (String)session.getAttribute("workName");
	String loginNoPass = (String)session.getAttribute("password");
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = (String)session.getAttribute("regCode");
	String[][] favInfo = (String[][])session.getAttribute("favInfo");  	//���ݸ�ʽΪString[0][0]---String[n][0]
    String iPhoneNo = request.getParameter("srv_no");
    System.out.println("------------===============------------------------------   "+orgCode + "   "+regionCode +"    "+iPhoneNo);
	String iOpCode = request.getParameter("opcode");
	String groupId = (String)session.getAttribute("groupId");
	int recordNum=0;
	int i=0;

	/*begin huangrong add ��ѯ�û��������к�����ʱ�� 2011-4-26 16:53*/
	String Infosql="SELECT subStr(belong_code,1,2),ceil(months_between(SYSDATE,open_time)) FROM dCustMsg  WHERE phone_no='"+iPhoneNo+"'";
	String cust_belongCode="";
	String cust_openTime="";	
	int opTimeTotal=0;
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="InfoRetCode" retmsg="InfoRetMsg" outnum="2">
	<wtc:sql><%=Infosql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="InfosqlStr" scope="end" />

<%
	if(InfoRetCode.equals("000000"))
	{
		if(InfosqlStr!=null && InfosqlStr.length>0)
	  	{
				cust_belongCode=InfosqlStr[0][0];
				cust_openTime=InfosqlStr[0][1];
				opTimeTotal=Integer.parseInt(cust_openTime);
			}	
	}else
	{
%>	
			<script language="JavaScript">
				rdShowMessageDialog("������룺<%=InfoRetCode%>��������Ϣ��<%=InfoRetMsg%>",0);
				history.go(-1);
			</script>
<%
	}
		/*end huangrong add ��ѯ�û��������к�����ʱ�� 2011-4-26 16:53*/


	String 	retFlag="",retMsg="",sqlStr="";
	String  bp_name="",sm_code="",family_code="",rate_code="",bigCust_flag="",sm_name="";
	String  rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="";
	String  prepay_fee="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="";
	String  group_type_code="",group_type_name="",imain_stream="",next_main_stream="",hand_fee="";
	String  favorcode="",card_no="",print_note="",contract_flag="",high_flag="",passwordFromSer="";
	String  point_note="",open_time="";
	Date    date = new Date();
	SimpleDateFormat df  = new SimpleDateFormat("yyyyMM");
	GregorianCalendar gc = new GregorianCalendar();
	gc.setTime(date); 
	String  time=df.format(gc.getTime());
	System.out.println("time =========================================== "+ time);

	String PrintAccept="";
    PrintAccept = getMaxAccept();

	String  inputParsm [] = new String[4];
	inputParsm[0] = iPhoneNo;
	inputParsm[1] = loginNo;
	inputParsm[2] = orgCode;
	inputParsm[3] = iOpCode;
	System.out.println("phoneNO === "+ iPhoneNo);

//	  retList = co2.callFXService("s2289Qry", inputParsm, "30","phone",iPhoneNo);
%>
	<wtc:service name="s2289Qry" routerKey="region" routerValue="<%=regionCode%>" outnum="31" retcode="retCode" retmsg="retMsg1">

		<wtc:param value=" "/>
		<wtc:param value="01"/>
		<wtc:param value="<%=iOpCode%>"/>
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=loginNoPass%>"/>
		<wtc:param value="<%=iPhoneNo%>"/>
		<wtc:param value=" "/>
		<wtc:param value="<%=orgCode%>"/>
	</wtc:service>
	<wtc:array id="tempArr" scope="end"/>
<%
  String errCode = retCode;
  String errMsg = retMsg1;

  System.out.println("errCode="+errCode);
  System.out.println("errMsg ="+errMsg);

  if(tempArr.length==0)
  {
	   retFlag = "1";
	   retMsg = "s2289Qry��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
  }
  else 
  {
	  if (errCode.equals( "000000") && tempArr.length>0){
	  	if(!(tempArr==null)){
		    bp_name = tempArr[0][3];           //��������
		    bp_add = tempArr[0][4];            //�ͻ���ַ
		    passwordFromSer = tempArr[0][2];   //����
		    sm_code = tempArr[0][11];          //ҵ�����
		    sm_name = tempArr[0][12];          //ҵ���������
		    hand_fee = tempArr[0][13];     	   //������
		    favorcode = tempArr[0][14];     	//�Żݴ���
		    rate_code = tempArr[0][5];    		 //�ʷѴ���
		    rate_name = tempArr[0][6];    		//�ʷ�����
		    next_rate_code = tempArr[0][7];		//�����ʷѴ���
		    next_rate_name = tempArr[0][8];		//�����ʷ�����
		    bigCust_flag = tempArr[0][9];		//��ͻ���־
		    bigCust_name = tempArr[0][10];		//��ͻ�����
		    lack_fee = tempArr[0][15];			//��Ƿ��
		    prepay_fee = tempArr[0][16];		//��Ԥ��
		    cardId_type = tempArr[0][17];		//֤������
		    cardId_no = tempArr[0][18];			//֤������
		    cust_id = tempArr[0][19];			//�ͻ�id
		    cust_belong_code = tempArr[0][20];	//�ͻ�����id
		    group_type_code = tempArr[0][21];	//���ſͻ�����
		    group_type_name = tempArr[0][22];	//���ſͻ���������
		    imain_stream = tempArr[0][23];		//��ǰ�ʷѿ�ͨ��ˮ
		    next_main_stream = tempArr[0][24];	//ԤԼ�ʷѿ�ͨ��ˮ
		    print_note = tempArr[0][25];		//�������
		    contract_flag = tempArr[0][27];		//�Ƿ������˻�
		    high_flag = tempArr[0][28];			//�Ƿ��и߶��û�
		    point_note = tempArr[0][29];		//����������ʾ
		    open_time = tempArr[0][30];			//����ʱ��
		    System.out.println("====wanghfa==== �ʷѴ��� = " + rate_code);
		    System.out.println("====wanghfa==== �ʷ����� = " + rate_name);
		    System.out.println("====wanghfa==== �����ʷѴ��� = " + next_rate_code);
		    System.out.println("====wanghfa==== �����ʷ����� = " + next_rate_name);
	 	}
	}else{%>
			<script language="JavaScript">
				rdShowMessageDialog("������룺<%=errCode%>��������Ϣ��<%=errMsg%>",0);
				history.go(-1);
			</script>
      <%}
 }
%>

	
<%
	/* ����Ԥ���Ӫ����ҵ�񷽰���ѯ����(s8379QryType) ningtn */
	String  s8379QryTypeParsm [] = new String[7];
	/* 0	"��ˮ			��iLoginAccept��" */
	s8379QryTypeParsm[0] = PrintAccept;
	/* 1	"������ʾ	��iChnSource��" */
	s8379QryTypeParsm[1] = "01";
	/* 2	"��������	��opCode��" */
	s8379QryTypeParsm[2] = opCode;
	/* 3	"����			��iLoginNo��" */
	s8379QryTypeParsm[3] = loginNo;
	/* 4	"��������	��iLoginPwd��" */
	s8379QryTypeParsm[4] = loginNoPass;
	/* 5	"�û�����	��iPhoneNo��" */
	s8379QryTypeParsm[5] = iPhoneNo;
	/* 6	"�û�����	��iUserPwd��" */
	s8379QryTypeParsm[6] = "";
%>
	<wtc:service name="s8379QryType" routerKey="region" routerValue="<%=regionCode%>" 
		 outnum="2" retcode="retCodex1" retmsg="retMsgx1">
		<wtc:param value="<%=s8379QryTypeParsm[0]%>"/>
		<wtc:param value="<%=s8379QryTypeParsm[1]%>"/>
		<wtc:param value="<%=s8379QryTypeParsm[2]%>"/>
		<wtc:param value="<%=s8379QryTypeParsm[3]%>"/>
		<wtc:param value="<%=s8379QryTypeParsm[4]%>"/>
		<wtc:param value="<%=s8379QryTypeParsm[5]%>"/>
		<wtc:param value="<%=s8379QryTypeParsm[6]%>"/>
	</wtc:service>
	<wtc:array id="resultx1" scope="end"/>
<%
		System.out.println("===== s8379QryType ===" + retCodex1 + "," + retMsgx1);
		if(!"000000".equals(retCodex1)){
%>
			<script language="javascript">
				rdShowMessageDialog("������룺" + retCodex1 + "��������Ϣ��" + retMsgx1,0);
				document.location = "f8379_login.jsp";
			</script>
<%
		}
		
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>����Ԥ���</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language="JavaScript">
<!--
  var arrbrandcode = new Array();//�ֻ��ͺŴ���
  var arrbrandname = new Array();//�ֻ��ͺ�����
  var arrbrandmoney = new Array();//�����̴���

  var arrPhoneType = new Array();//�ֻ��ͺŴ���
  var arrPhoneName = new Array();//�ֻ��ͺ�����
  var arrAgentCode = new Array();//�����̴���
  var selectStatus = 0;

  var arrsalecode =new Array();
  var arrsaleName=new Array();
  var arrsalebarnd=new Array();
  var arrsaletype=new Array();
  var arrtypemoney=new Array();
  var arrsalemoney=new Array();

  var arrdetbase=new Array();
  var arrdetfree=new Array();
  var arrdetfavour=new Array();
  var arrdetconsume=new Array();
  var arrdetmonbase=new Array();
  var arrdetmode=new Array();
  var arrdetsummoney=new Array();
  var arrdetsalecode=new Array();


  //--------2---------��֤��ťר�ú���-------------

function frmCfm()
{
	///////<!-- ningtn add for pos start @ 20100930 -->
	document.all.payType.value = document.all.payTypeSelect.value;
	if(document.all.payType.value=="BX")
	{
		/*set �������*/
		var transerial    = "000000000000";  	                    //����Ψһ�� ������ȡ��
		var trantype      = "00";         //��������
		var bMoney        = document.all.sumMoney.value; 				//�ɷѽ��
		if(bMoney.indexOf(".") == -1) bMoney=bMoney+"00";
		var tranoper      = "<%=loginNo%>";                       //���ײ���Ա
		var orgid         = "<%=groupId%>";                       //ӪҵԱ��������
		var trannum       = "<%=iPhoneNo%>";                      //�绰����
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
		var bMoney        = document.all.sumMoney.value;         /*���׽�� */
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
		var phoneNo       = "<%=iPhoneNo%>";                       /*���׽ɷѺ� */       
		var toBeUpdate    = "";						                        /*Ԥ���ֶ� */         
		var posFlag = ICBCCommon(transType,bMoney,response_time,rrn,instNum,terminalId,request_time,workno,orgCode,groupId,phoneNo,toBeUpdate);									
		if(icbcTran=="succ") posSubmitForm();
	}else{
		posSubmitForm();
	}
	
	//////<!-- ningtn add for pos end @ 20100930 -->
}
/* ningtn add for pos start @ 20100930 */
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
	/* ningtn add for pos start @ 20100930 */
 function chkType()
 {
 	document.all.giftCode.value ="";
 	document.all.giftName.value ="";
 	document.all.baseFee.value ="";
 	document.all.freeFee.value ="";
 	document.all.markSubtract.value ="";
 	document.all.baseTerm.value ="";
 	document.all.freeTerm.value ="";
 	document.all.sumMoney.value ="";
 	document.all.payFee.value ="";
 	document.all.Month_Basefee.value ="";
 	

 }
function getInfo_code(){
	var projectTypeVal =  document.frm.projectType.value;
	
	var path = "<%=request.getContextPath()%>/npage/s1141/f8379_getInfo.jsp";
  path = path + "?iProjectType=" + projectTypeVal + "&opCode=" + "<%=opCode%>";
  path = path + "&phoneNo=" + <%=iPhoneNo%> + "&opName=" + "<%=opName%>";
  retInfo = window.showModalDialog(path,"","dialogWidth:"+80);
  
	if(retInfo ==undefined){
		return false;
	}
  var retToField = "giftCode|giftName|payFee|baseFee|freeFee|markSubtract|baseTerm|freeTerm|returnFee|returnTerm|sumMoney|Month_Basefee|";//���ظ�ֵ����	
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
	document.all.systemNote.value = "����Ԥ���������룺"+document.all.giftCode.value;
	getNode();
}

function getNode()
{
	var packet = new AJAXPacket("getDoNote.jsp","����ȡ��ע��Ϣ�����Ժ�......");
	packet.data.add("projectType", document.frm.projectType.value);
	packet.data.add("code", document.frm.giftCode.value);
  core.ajax.sendPacket(packet,doGetOper);
  packet = null;	
}

function doGetOper(packet){
		var active_note = packet.data.findValueByName("active_note");
	  document.all.systemNote1.value=active_note;
	
}


function doProcess(packet)
{
	var retType = packet.data.findValueByName("retType");
	var num = packet.data.findValueByName("num");
	if(retType=="1")
	{
		document.all.Flag.value=num;
	}
}

function businessCheck(){
		
		var projectTypeVal = document.all.projectType.value;
		var giftCodeVal = document.all.giftCode.value;
		var returnFeeVal = document.all.returnFee.value
		var accountMarkVal = document.all.accountMark.value;
		var myPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/s1141/f8379_check.jsp","����У��ҵ�����ƣ����Ժ�......");
		myPacket.data.add("opCode","<%=opCode%>");
		myPacket.data.add("opName","<%=opName%>");
		myPacket.data.add("phoneNo","<%=iPhoneNo%>");
		myPacket.data.add("iOldMode","<%=rate_code%>");
		myPacket.data.add("iProjectType",projectTypeVal);
		myPacket.data.add("vProjectCode",giftCodeVal);
		myPacket.data.add("iReturnFee",returnFeeVal);
		myPacket.data.add("iAccountMark",accountMarkVal);
		core.ajax.sendPacket(myPacket,doCheck);
}
function doCheck(packet){
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	$("#checkHidden").val(retCode);
	if("000000" != retCode){
		rdShowMessageDialog(retCode + ":" + retMsg);
		return false;
	}
}

function printCommit()
{
	
	getAfterPrompt();
 	if(!checkElement(document.all.phoneNo)) return;
	if(document.all.giftCode.value=="")
	{
		rdShowMessageDialog("������Ӫ������!");
		document.all.giftCode.focus();
		return false;
	} 
	if(parseFloat(document.all.markSubtract.value)>0)
	{  
		if(parseFloat(document.all.accountMark.value) < parseFloat(document.all.markSubtract.value))
		{
			rdShowMessageDialog("�û���ǰ����С�ڿۼ�����,������ѡ��!");
			return false;
		}
	}
	businessCheck();
	if("000000" != $("#checkHidden").val()){
		return false;
	}
	document.all.commit.disabled = true;//Ϊ��ֹ����ȷ��

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
   var h=180;
   var w=350;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;

  	var pType="subprint";             				 		//��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
	var billType="1";              				 			//Ʊ�����ͣ�1���������2��Ʊ��3�վ�
	var sysAccept =<%=PrintAccept%>;             			//��ˮ��
	var printStr = printInfo(printType);			 		//����printinfo()���صĴ�ӡ����
	var mode_code=null;           							//�ʷѴ���
	var fav_code=null;                				 		//�ط�����
	var area_code=null;             				 		//С������
	var opCode="8379" ;                   			 		//��������
	var phoneNo="<%=iPhoneNo%>";                  	 		//�ͻ��绰
    var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";  
    var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
    path+="&mode_code="+mode_code+
			"&fav_code="+fav_code+"&area_code="+area_code+
			"&opCode=<%=opCode%>&sysAccept="+sysAccept+
			"&phoneNo="+document.frm.phoneNo.value+
			"&submitCfm="+submitCfm+"&pType="+
			pType+"&billType="+billType+ "&printInfo=" + printStr; 
     var ret=window.showModalDialog(path,printStr,prop);
     return ret;
    
}

function printInfo(printType)
{
	var cust_info="";  				//�ͻ���Ϣ
	var opr_info="";   				//������Ϣ
	var note_info1=""; 				//��ע1
	var note_info2=""; 				//��ע2
	var note_info3=""; 				//��ע3
	var note_info4=""; 				//��ע4
	var retInfo = "";  				//��ӡ����
	var base_fee = document.all.baseFee.value;
	var free_fee = document.all.freeFee.value;
	var pay_fee  = document.all.payFee.value;
	var prepay_fee=document.all.sumMoney.value;
	var return_fee= document.all.returnFee.value;
	var return_term=document.all.returnTerm.value;
	var free_term=document.all.freeTerm.value;
	var month_basefee=document.all.Month_Basefee.value;

	var note=document.all.systemNote1.value;
	
	cust_info+="�ֻ����룺"+document.all.phoneNo.value+"|";
	cust_info+="�ͻ�������"+document.all.custName.value+"|";
	cust_info+="�ͻ���ַ��"+document.all.i5.value+"|";
	cust_info+="֤�����룺"+document.all.i7.value+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
		
    if("<%=regionCode%>"=="01" && document.all.giftCode.value=="0019" && document.all.projectType.value=="0002")
    {
    	opr_info+="�û�Ʒ�ƣ�"+document.all.smName.value+"    ҵ�����ͣ�����Ԥ���"+"|";
  		opr_info+="ҵ����ˮ��"+document.all.login_accept.value+"|";
  		opr_info+="ҵ������ʱ�䣺<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>"+"|";
    	opr_info+="�˻Ԥ���" +free_fee+"Ԫ��" + free_fee +"Ԫ�Ԥ�������"+free_term +
    	           "������������ϣ����ں�δ������ϣ�ϵͳ�ջء�����"+month_basefee+
    	           "Ԫ(��"+month_basefee+"Ԫ)����������" +return_fee+"Ԫ���ѣ���������"+return_term+
    	           "���¡�" + "|";
    	if(note.length>0)
    	{
    		note_info1+="��ע��"+note+"|";
    	}
    }
    else if("<%=regionCode%>"=="08" && document.all.projectType.value=="0080")
    {
    	
    	var bussName = ''; //ҵ������
    	var preTime = '';
    	var noteMsg = '';
    	if(document.all.giftCode.value == '0004'){
    		bussName = '60Ԫ������120Ԫ����';
    		preTime = 'Ԥ��ʼʱ�䣺2011��01��01��  Ԥ������ʱ�䣺2011��07��01��';
    		notemsg = '�û�����60ԪԤ���� 2011��01��01�����·���ÿ�·���20Ԫ��3���·��꣬�����ʱ��6���£��������Ѳ���ϵͳ�Զ����գ���';
    	}
    	
  		opr_info+="ҵ������ʱ�䣺<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>     �û�Ʒ�ƣ�<%=sm_name%>"+"|";
   		
   		opr_info+="����ҵ��"+bussName+"   ������ˮ��"+document.all.login_accept.value+"|";
  		
  		opr_info+=preTime+"|";
   		retInfo+=" "+"|";
   		if(note.length>0)
    	{
    		note_info1+="��ע��"+note+"|";
    	}
  	  note_info1+="��ܰ��ʾ��|";
   		note_info1+="1���û�����Ԥ���ˡ���ת������δʹ���꣬ϵͳ�Զ����ա�|";
   		note_info1+="2��"+notemsg+"|";
   		note_info1+="3���������ѵ�ʹ�����ȼ������ֽ�Ԥ������������ʹ�������Ļ��ѣ�|";
   		note_info1+=" "+"|";	
   	
    }
    else
    {
    	opr_info+="�û�Ʒ�ƣ�"+document.all.smName.value+"    ҵ�����ͣ�����Ԥ���"+"|";
  		opr_info+="ҵ����ˮ��"+document.all.login_accept.value+"|";
  		opr_info+="ҵ������ʱ�䣺<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>"+"|";
    	opr_info+="�������ƣ�"+document.all.giftName.value+"|";
		if(prepay_fee>0)
		{
			opr_info+="Ԥ���"+prepay_fee+"Ԫ ";
			if(base_fee)
			{
				opr_info+="����Ԥ�棺"+base_fee+"Ԫ ";
			}
			if(free_fee>0)
			{
				opr_info+="�Ԥ�棺"+free_fee+"Ԫ ";
			}
			if(pay_fee>0)
			{
				opr_info+="�ֽ�"+pay_fee+"Ԫ "+"|";
			}
			if(return_fee>0)
			{
				opr_info+="ÿ������Ԥ��"+return_fee+"Ԫ "+" ����Ԥ���������"+document.all.returnTerm.value+"����|";
			}
		}else
		{
			if(return_fee>0)
			{
				opr_info+="ÿ������Ԥ��"+return_fee+"Ԫ "+" ����Ԥ���������"+document.all.returnTerm.value+"����|";
			}
		}
		retInfo+=" "+"|";
	  if(note.length>0)
  	{
  		note_info1+="��ע��"+note+"|";
  	}
  	else
  	{
			note_info1+="��ע������Ԥ��ר�������Ч�����˲�ת"+"|";
		}
		
		retInfo+=" "+"|";
		retInfo+=" "+"|";
		retInfo+=" "+"|";
		retInfo+=" "+"|";
		retInfo+=" "+"|";
    }

	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
    return retInfo;
}
//-->
</script>
</head>
<body>
<form name="frm" method="post" action="f8379_2.jsp" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">ҵ����ϸ</div>
	</div>
<table cellspacing="0">
	<tr>
		<td class="blue">��������</td>
		<td colspan="3">
			<select id=projectType name=projectType onChange="chkType()">
<%
				recordNum = resultx1.length;
				for(i=0;i<recordNum;i++)
				{
					out.println("<option class='button' value='" + resultx1[i][0] + "'>" + resultx1[i][0]+"-->"+resultx1[i][1] + "</option>");
				}
		   %>
		   </select>
		</td>
	</tr>
	<tr>
		<td class="blue">�ֻ�����</td>
		<td width="39%">
			<input class="InputGrey" type="text" v_must="1" v_type="mobphone" v_must=1 name="phoneNo" value="<%=iPhoneNo%>" id="phoneNo" onBlur="if(this.value!=''){if(checkElement(document.all.phoneNo)==false){return false;}}" maxlength=11 index="3" readonly >
		</td>
		<td class="blue">�ͻ�����</td>
		<td>
			<input name="custName" type="text" class="InputGrey" id="custName" value="<%=bp_name%>" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">Ʒ������</td>
		<td>
			<input name="smName" type="text" class="InputGrey" id="smName" value="<%=sm_name%>" readonly>
		</td>
		<td class="blue">�ʷ�����</td>
		<td>
			<input name="offerName" type="text" class="InputGrey" id="offerName" value="<%=rate_name%>" size ="40" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">����Ԥ��</td>
		<td>
			<input name="prepayFee" type="text" class="InputGrey" id="prepayFee" value="<%=prepay_fee%>" readonly>
		</td>
		<td class="blue">��ǰ����</td>
		<td>
			<input name="accountMark" type="text" class="InputGrey" id="accountMark" value="<%=print_note%>" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">��������</td>
		<td>
			<input class="InputGrey" type="text" name="giftCode" id="giftCode" readonly>
			<input class="b_text" type="button" name="query" value="��ѯ" onClick="getInfo_code()" >
				<font color="orange">*</font>
		</td>
		<td class="blue">��������</td>
		<td>
			<input name="giftName" type="text" class="InputGrey" id="giftName" v_type="string" v_must=1 value="" size ="40" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">����Ԥ��</td>
		<td>
			<input name="baseFee" type="text" class="InputGrey" id="baseFee" readonly>
		</td>
		<td class="blue">������������</td>
		<td>
			<input name="baseTerm" type="text" class="InputGrey" id="baseTerm" readonly>
		</td>
	</tr>
	<tr>	
		<td class="blue">�Ԥ��</td>
		<td>
			<input name="freeFee" type="text" class="InputGrey" id="freeFee"   readonly>
		</td>
		<td class="blue">���������</td>
		<td>
			<input name="freeTerm" type="text" class="InputGrey" id="freeTerm"   readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">ÿ������Ԥ���</td>
		<td>
			<input name="returnFee" type="text" class="InputGrey" id="returnFee"   readonly>
		</td>
		<td class="blue">����Ԥ�������</td>
		<td>
			<input name="returnTerm" type="text" class="InputGrey" id="returnTerm"   readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">�ֽ�</td>
		<td>
			<input name="payFee" type="text" class="InputGrey" id="payFee"   readonly>
		</td>
		<td class="blue">�ۼ�����</td>
		<td>
			<input name="markSubtract" type="text" class="InputGrey" id="markSubtract"   readonly>
		</td>
	</tr>
	<tr>
	<!-- ningtn add for pos start @ 20100930 -->
		<td class="blue">�ɷѷ�ʽ</td>
		<td>
			<select name="payTypeSelect" >
				<option value="0">�ֽ�ɷ�</option>
				<option value="BX">��������POS���ɷ�</option>
				<option value="BY">��������POS���ɷ�</option>
			</select>
		</td>
	<!-- ningtn add for pos start @ 20100930 -->
		<td class="blue">Ӧ�ս��</td>
		<td>
			<input name="sumMoney" type="text" class="InputGrey" id="sumMoney"   readonly>
		</td>
	</tr>  
	<tr>
		<td class="blue">ϵͳ��ע</td>
		<td colspan="3">
			<input name="systemNote" type="text" class="InputGrey" id="systemNote"  size="40" readonly>
			<input NAME="systemNote1" id="systemNote1" type="hidden" readonly>
		</td>
	</tr>
	<tr>
		<td colspan="4" align="center" id="foot">
			&nbsp;
			<input name="commit" id="commit" type="button" class="b_foot"   value="ȷ��&��ӡ" onClick="printCommit();">
			&nbsp;
			<input name="reset" type="reset" class="b_foot" value="���" >
			&nbsp;
			<input name="back" onClick="history.go(-1)" type="button" class="b_foot" value="����">
			&nbsp;
		</td>
	</tr>	
</table>
	<!-- ningtn add for pos start @ 20100930 -->		
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
	<!-- ningtn add for pos end @ 20100930 -->

<div name="licl" id="licl">	
		<input type="hidden" name="Month_Basefee" id="Month_Basefee">
		<input type="hidden" name="iOpCode" value="8379">
		<input type="hidden" name="return_page" value="/npage/s1141/f8379_login.jsp">
		<input type="hidden" name="login_accept" value="<%=PrintAccept%>">
		<input type="hidden" name="i5" value="<%=bp_add%>">
		<input type="hidden" name="i7" value="<%=cardId_no%>">
		<input type="hidden" name="Flag">
		<input type="hidden" name="checkHidden" id="checkHidden" />

</div>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
<!-- **** ningtn add for pos @ 20100930 ******���ؽ��пؼ�ҳ BankCtrl ******** -->
<%@ include file="/npage/public/posCCB.jsp" %>
<!-- **** ningtn add for pos @ 20100930 ******���ع��пؼ�ҳ KeeperClient ******** -->
<%@ include file="/npage/public/posICBC.jsp" %>
</body>
</html>
