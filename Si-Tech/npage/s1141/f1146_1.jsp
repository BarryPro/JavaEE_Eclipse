<%
/********************
 version v2.0
������: si-tech
update:yanpx@2008-10-08
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode = "1146";     //ģ�����
  String opName = "��������"; //ģ������

  String loginNo = (String)session.getAttribute("workNo");
  String loginName = (String)session.getAttribute("workName");
  String powerCode= (String)session.getAttribute("powerCode");
  String orgCode = (String)session.getAttribute("orgCode");
  String ip_Addr = (String)session.getAttribute("ipAddr");
  String regionCode = orgCode.substring(0,2);
  String loginNoPass = (String)session.getAttribute("password");
  String op_code=request.getParameter("opCode");
  String groupId = (String)session.getAttribute("groupId");
	String payType="",Response_time="",TerminalId="",Rrn="",Request_time="";
%>
<%
  String retFlag="",retMsg="";
  //SPubCallSvrImpl impl = new SPubCallSvrImpl();
  //ArrayList retList = new ArrayList();
  //String[] paraAray1 = new String[4];
  String phoneNo = request.getParameter("srv_no");
  String opcode = request.getParameter("opcode");
  String backaccept= request.getParameter("backaccept");
  String passwordFromSer="";

  /*liyan add at 20090317*/
  String back_type = request.getParameter("back_type");
  System.out.println("back_type="+back_type);
  String new_opCode = opcode;
  if (back_type.equals("1"))
  {
  		new_opCode = "7971"; //������۳���
  }
  System.out.println("new_opCode="+new_opCode);
  /*liyan add end at 20090317*/

 // paraAray1[0] = phoneNo;		/* �ֻ�����   */
 // paraAray1[1] = opcode; 	    /* ��������   */
 // paraAray1[2] = loginNo;	    /* ��������   */
 // paraAray1[3] = backaccept;

  /*****��÷ ��� 20060605*****/
  //ArrayList retArray = new ArrayList();
  //String[][] result = new String[][]{};
  //SPubCallSvrImpl callView = new SPubCallSvrImpl();
  String sqlStr = "";
  String awardName="";
  sqlStr = "select award_name from wawardpay where phone_no ='"+phoneNo+"'"+
		    " and login_accept="+backaccept  ;
	//System.out.println(sqlStr);
%>
<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="retArray" scope="end"/>
<%
System.out.println("**************************1");

  if(retArray!=null&& retArray.length > 0){
  	awardName = retArray[0][0];
  	System.out.println("awardName="+awardName);
  %>
  <script language="JavaScript" >

  //rdShowMessageDialog("���û�Ϊ���н��û����н���ƷΪ��"<%=awardName%>", ���û�������𷵻ؽ�Ʒ���ټ����������ҵ��");
   	if(rdShowConfirmDialog("���û�Ϊ���н��û����н���ƷΪ��<%=awardName%> ���û�������𷵻ؽ�Ʒ���ټ����������ҵ��")!=1)
		{
			location='f1145_login.jsp?activePhone=<%=phoneNo%>';
		}
	</script>

<%}
  //sunzx add at 20070904
  sqlStr = "select res_info from wawarddata where flag = 'Y' and phone_no = '"+phoneNo+"'"+
		    " and login_accept="+backaccept  ;

  //retArray = callView.sPubSelect("1",sqlStr);
%>
<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="retArray" scope="end"/>
<%
	System.out.println("**************************2");
  if(retArray != null && retArray.length > 0)
  {
  	System.out.println("123");
	  awardName = retArray[0][0];

	  System.out.println("awardName2="+awardName);

  	if(!awardName.equals("")){
%>
		  <script type="text/javascript" src="../../js/common/redialog/redialog.js"></script>
		  <script language="JavaScript" >

		  rdShowMessageDialog("���û����ڴ���Ʒͳһ�����н���<%=awardName%>�콱������д���Ʒͳһ������������ȷ����Ʒ���",1);
			location='f1145_login.jsp?activePhone=<%=phoneNo%>';
			</script>
<%	}
	}
	//sunzx add end
/*liyan add at 20090317 ���ڶ�������opcode��Ϊnew_opCode */
%>
<wtc:service  name="s1142Qry" routerKey="phone" routerValue="<%=phoneNo%>" outnum="29"  retcode="errCode" retmsg="errMsg">
	<wtc:param  value=""/>
	<wtc:param  value="01"/>
	<wtc:param  value="<%=new_opCode%>"/>
	<wtc:param  value="<%=loginNo%>"/>
	<wtc:param  value="<%=loginNoPass%>"/>
	<wtc:param  value="<%=phoneNo%>"/>
	<wtc:param  value=""/>
	<wtc:param  value="<%=backaccept%>"/>
</wtc:service>
<wtc:array id="retList" scope="end"/>
<%

 /* ��������� �����룬������Ϣ���ͻ��������ͻ���ַ��֤�����ͣ�֤�����룬ҵ��Ʒ�ƣ�
 			�����أ���ǰ״̬��VIP���� ����ǰ���֣��û�Ԥ�棬
 			Ӫ����������Ӧ���������������������ͻ��ѣ����ѻ�����
 */
  String bp_name="",bp_add="",cardId_type="",cardId_no="",sm_code="",region_name="",run_name="",vip="",posint="",prepay_fee="";
  String sale_name="",sum_money="",scard_money="",card_num="",pay_money="",used_point="",card_money="",type_name="";
  String vspec_name="",vmode_code="",vused_date="",vspec_fee="";

	/**
	 for(int i=0;i<retList.length;i++){
	 	for(int m=0;m<retList[i].length;m++){
	 		System.out.println("##################retList["+i+"]["+m+"]--->"+retList[i][m]);
	 	}
	 }
	 */
System.out.println("**************************3");
  if(retList == null)
  {
	if(!retFlag.equals("1"))
	{
		 System.out.println("retFlag="+retFlag);
	   retFlag = "1";
	   retMsg = "s12fbInit��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
    }
  }else if(!(retList == null))
  {System.out.println("errCode="+errCode);
  System.out.println("errMsg="+errMsg);
  if(!errCode.equals("000000")&&!errCode.equals("0") ){%>
<script language="JavaScript">
<!--
  	rdShowMessageDialog("������룺<%=errCode%>������Ϣ��<%=errMsg%>");
  	 history.go(-1);
  	//-->
  </script>
  <%}
  System.out.println("**************************4");
	if (errCode.equals("000000")||errCode.equals("0")){
	System.out.println("**************************%%%%%");
	  bp_name =retList[0][2];
	  bp_add = retList[0][3];
	  cardId_type = retList[0][4];
	  cardId_no = retList[0][5];
	  sm_code = retList[0][6];
	  region_name = retList[0][7];
	  run_name = retList[0][8];
	  vip = retList[0][9];
	  posint = retList[0][10];
	  prepay_fee = retList[0][11];
	   sale_name = retList[0][12];
	   sum_money = retList[0][13];
	  scard_money = retList[0][14];
	  card_num = retList[0][15];
	   pay_money = retList[0][16];
	  used_point = retList[0][17];
	  card_money = retList[0][18];
	  type_name = retList[0][19];
	  vspec_name = retList[0][20];
	  vused_date = retList[0][21];
	  vspec_fee = retList[0][22];
	  if(vspec_fee.equals("")){vspec_fee="0";}
	  vmode_code = retList[0][23];

		    ///////<!-- ningtn add for pos start @ 20100520 -->
				if(retList[0][24] != null && retList[0][24].trim().length() > 0){
					payType = retList[0][24].trim();
				}else{
					payType = "0";
				}
				Response_time = retList[0][25].trim();
				TerminalId = retList[0][26].trim();
				Rrn = retList[0][27].trim();
				Request_time = retList[0][28].trim();
				
				System.out.println("payType : " + payType);
				System.out.println("Response_time : " + Response_time);
				System.out.println("TerminalId : " + TerminalId);
				System.out.println("Rrn : " + Rrn);
				System.out.println("Request_time : " + Request_time);
				///////<!-- ningtn add for pos end @ 20100520 -->

	  pay_money=""+(Float.parseFloat(pay_money)-Float.parseFloat(vspec_fee));
	  /*pay_money=""+(Integer.parseInt(pay_money)-Integer.parseInt(vspec_fee));*/
	}else{
		//if(!retFlag.equals("1"))
		//{
		  // retFlag = "1";
	      // retMsg = "s126bInit��ѯ���������Ϣʧ��!<br>errCode: " + errCode + "<br>errMsg: " + errMsg;
		//}
	}
  }

%>
 <%  //�Ż���Ϣ//********************�õ�ӪҵԱȨ�ޣ��˶����룬�������Ż�Ȩ��*****************************//
  String Handfee_Favourable = "readonly";        //a230  ������
System.out.println("**************************5");
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
<html>
<head>
<title><%=opName%></title>
<META content="no-cache" http-equiv="Pragma">
<META content="no-cache" http-equiv="Cache-Control">
<META content="0" 	     http-equiv="Expires" >
<meta http-equiv="Content-Type" content="text/html; charset=GBK">


 <script language=javascript>

 function doProcess(packet){

 	var retType = packet.data.findValueByName("retType");
    	var retCode = packet.data.findValueByName("retCode");
    	var retMessage = packet.data.findValueByName("retMessage");

    	if(retCode!=0){
    		rdShowMessageDialog(retMessage);
    		return ;
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




<%
/*
  for(int i=0;i<phoneTypeStr.length;i++)
  {
	out.println("arrPhoneType["+i+"]='"+phoneTypeStr[i][0]+"';\n");
	out.println("arrPhoneName["+i+"]='"+phoneTypeStr[i][1]+"';\n");
	out.println("arrAgentCode["+i+"]='"+phoneTypeStr[i][2]+"';\n");
  }
  for(int l=0;l<saleTypeStr.length;l++)
  {
	out.println("arrsalecode["+l+"]='"+saleTypeStr[l][0]+"';\n");
	out.println("arrsaleName["+l+"]='"+saleTypeStr[l][1]+"';\n");
	out.println("arrsalebarnd["+l+"]='"+saleTypeStr[l][2]+"';\n");
	out.println("arrsaletype["+l+"]='"+saleTypeStr[l][3]+"';\n");

  }
  */
%>

  //***
  function frmCfm(){
 		/* ningtn add for pos start @ 20100520 */
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
			  /* ningtn add for pos end @ 20100520 */
  }
  /* ningtn add for pos start @ 20100520 */
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
	/* ningtn add for pos start @ 20100520 */
 //***
 function printCommit()
 {
 	getAfterPrompt();
  //У��
  //if(!check(frm)) return false;

  with(document.frm){

	opNote.value=phone_no.value+"����"+opNote.value+"ҵ��";
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
	var h=188;
	var w=350;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var pType="subprint";
	var billType="1"; //1��� 3�վ� 2��Ʊ
	var printStr = printInfo(printType);
	var sysAccept = document.all.login_accept.value;

	var mode_code=null;
	var fav_code=null;
	var area_code=null

	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
	var path = path + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo=<%=phoneNo%>&submitCfm=" + submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr ;
	var ret=window.showModalDialog(path,printStr,prop);
	//alert(path);
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

	cust_info+="�ֻ����룺    "+document.all.phone_no.value+"|";
	cust_info+="�ͻ�������   "+document.all.cust_name.value+"|";
	cust_info+="�ͻ���ַ��    "+document.all.cust_addr.value+"|";
	cust_info+="֤�����룺   "+document.all.cardId_no.value+"|";

	if (<%=new_opCode%> =="1146")
	{
		opr_info+="ҵ�����ͣ������������"+"|";
	}
	else if(<%=new_opCode%> =="7971")
	{
		opr_info+="ҵ�����ͣ�����Ӫ�������¹��ջ�����"+"|";
	}
	opr_info+="ҵ����ˮ��"+document.all.login_accept.value+"|";
	opr_info+="�ֻ��ͺ�: "+document.all.type_name.value+"|";

	//retInfo+=document.all.work_no.value+' '+'<%=loginName%>'+"|";
	//retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	//retInfo+="�û����룺"+document.all.phone_no.value+"|";
	//retInfo+="�û�������"+document.all.cust_name.value+"|";
	//retInfo+="�û���ַ��"+document.all.cust_addr.value+"|";
	//retInfo+="֤�����룺"+document.all.cardId_no.value+"|";
	//retInfo+=" "+"|";
	//retInfo+=" "+"|";
	//retInfo+=" "+"|";
	//retInfo+=" "+"|";
	//retInfo+="ҵ�����ͣ������������"+"|";
  	//retInfo+="ҵ����ˮ��"+document.all.login_accept.value+"|";
  	//retInfo+="�ֻ��ͺ�: "+document.all.type_name.value+"|";

  	//if(parseInt(document.all.card_money.value,10)==0){
  		//retInfo+="�˿�ϼƣ�"+document.all.sum_money.value+"Ԫ������Ԥ�滰��"+document.all.pay_money.value+"Ԫ"+"|";
  	//}else{
  		//retInfo+="�˿�ϼƣ�"+document.all.sum_money.value+"Ԫ������Ԥ�滰��"+document.all.pay_money.value+"Ԫ����"+document.all.cardy.value+"|";
	//}

	var jkinfo="";
	if(parseInt(document.all.card_money.value,10)==0){
		jkinfo="�˿�ϼƣ�"+document.all.sum_money.value+"Ԫ ����Ԥ�滰��"+document.all.pay_money.value+"Ԫ";
	}else{
		jkinfo+="�˿�ϼƣ�"+document.all.sum_money.value+"Ԫ ����Ԥ�滰��"+document.all.pay_money.value+"Ԫ��"+document.all.cardy.value;
	}
	if(document.all.spec_fee.value!="0"){
		jkinfo+="��"+(document.all.spec_name.value).trim();
	}
	//retInfo+=jkinfo+"|";
	opr_info+=jkinfo+"|";

	//retInfo+=" "+"|";
	//retInfo+=" "+"|";
	//retInfo+=" "+"|";
	//retInfo+=" "+"|";
	//retInfo+=" "+"|";
	//retInfo+=" "+"|";
	//retInfo+=" "+"|";
	//retInfo+=" "+"|";
	//retInfo+=" "+"|";
	//retInfo+=" "+"|";
	//retInfo+=" "+"|";
	//retInfo+=" "+"|";
	//retInfo+=" "+"|";
	//retInfo+=" "+"|";
	//retInfo+=" "+"|";
	//retInfo+=" "+"|";
	//retInfo+=" "+"|";
	//retInfo+=" "+"|";

	//retInfo+="��ע����ӭ���μ�'��������'�����Ļ���Ԥ�����δ�������ǰ�����˿"+"|";
	//retInfo+="�����������û���SIM���۳�����30���ڣ����ڷ���Ϊԭ�������SIM���𻵻���������"+"|";
	//retInfo+="�����SIM�޷�ʹ�ã��ҹ�˾��Ϊ����Ѳ�����"+"|";
	note_info1+="��ע��"+"|";
	//retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	//alert(retInfo)
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
<form name="frm" method="post" action="f1146_2.jsp" onKeyUp="chgFocus(frm)">
<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">�û���Ϣ</div>
	</div>
    <table cellspacing="0" >
		  <tr>
	        <td class="blue">��������</td>
	        <td>
	        <% if (new_opCode.equals("1146")){%>
			     �����������
			<% }
			else if (new_opCode.equals("7971")) { %>
				 ����Ӫ�������¹��ջ�����
			<% } %>
	        </td>
	        <td>&nbsp;</td>
	        <td>&nbsp;</td>
      </tr>
      <tr>
          <td class="blue">�ͻ�����</td>
          <td>
						  <input name="cust_name" value="<%=bp_name%>" type="text" Class="InputGrey" v_must=1 readonly id="cust_name" maxlength="20" v_name="����">
          </td>
          <td class="blue">�ͻ���ַ</td>
          <td>
						  <input name="cust_addr" value="<%=bp_add%>" type="text" Class="InputGrey" v_must=1 readonly id="cust_addr" maxlength="20" >
          </td>
       </tr>
       <tr>
           <td class="blue">֤������</td>
           <td>
						  <input name="cardId_type" value="<%=cardId_type%>" type="text" Class="InputGrey" v_must=1 readonly id="cardId_type" maxlength="20" >
           </td>
	         <td class="blue">֤������</td>
	         <td>
						  <input name="cardId_no" value="<%=cardId_no%>" type="text" Class="InputGrey" v_must=1 readonly id="cardId_no" maxlength="20" >
           </td>
           </tr>
       <tr>
           <td class="blue">ҵ��Ʒ��</td>
           <td>
						  <input name="sm_code" value="<%=sm_code%>" type="text" Class="InputGrey" v_must=1 readonly id="sm_code" maxlength="20" >
           </td>
           <td class="blue">����״̬</td>
			     <td>
						  <input name="run_type" value="<%=run_name%>" type="text" Class="InputGrey" v_must=1 readonly id="run_type" maxlength="20" >
            </td>
      </tr>
      <tr>
            <td class="blue">VIP����</td>
            <td>
							  <input name="vip" value="<%=vip%>" type="text" Class="InputGrey" v_must=1 readonly id="vip" maxlength="20" >
							  <font class="orange">*</font>
            </td>
            <td class="blue">����Ԥ��</td>
            <td>
							  <input name="prepay_fee" value="<%=prepay_fee%>" type="text" Class="InputGrey" v_must=1 readonly id="prepay_fee" maxlength="20" >
							  <font class="orange">*</font>
            </td>
      </tr>
   </table>
</div>
<div id="Operation_Table">
<div class="title">
<div id="title_zi">ҵ�����</div>
</div>
   <table cellspacing="0">
      <tr>
            <td class="blue">Ӫ������ </td>
            <td colspan="3">
							  <input type="text" name="sale_code" size="60" readonly id="sale_code"  v_name="Ӫ������" value="<%=sale_name%>" >
							  <font class="orange">*</font>
						</td>
      </tr>
       <tr>
             <td class="blue">���Ϳ�����</td>
            <td>
							  <input name="card_money" type="text"  id="card_money" v_type="money" v_must=1   readonly v_name="������" value="<%=card_money%>" >
							  <font class="orange">*</font>
						</td>
            <td class="blue">���ͻ���</td>
            <td>
							  <input name="pay_money" type="text"   id="pay_money" v_type="0_9" v_must=1   v_name="���ͻ���" readonly value="<%=pay_money%>">
							  <font class="orange">*</font>
						</td>
       </tr>

        <tr>

            <td class="blue">���Ϳ�����Ϣ</td>
            <td colspan="3">
			  				<input type="text" name="card_info"  size="80" id="card_info"  readonly v_name="���Ϳ�����Ϣ" value="<%=card_num%>">
			  				<font class="orange">*</font>
						</td>

        </tr>
        <tr>
            <td class="blue">��������ҵ��</td>
            <td>
			  				<input type="text" name="spec_name"   id="spec_name" value="<%=vspec_name%>" readonly v_name="��������ҵ��" >
							  <font class="orange">*</font>
						</td>
            <td class="blue">���</td>
            <td>
							  <input type="text" name="spec_fee"   id="spec_fee"  value="<%=vspec_fee%>" readonly v_name="���" >
							  <font class="orange">*</font>
						</td>
       </tr>
       <tr>
            <td class="blue">����ʱ��</td>
            <td>
							  <input name="used_date" type="text"  id="used_date"   value="<%=vused_date%>"  readonly v_name="����ʱ��" >
							  <font class="orange">*</font>
						</td>
            <td>&nbsp;</td>
            <td>
							  <input name="mode_code" type="hidden"   id="mode_code"   value="<%=vmode_code%>"  v_name="�ײʹ���" readonly>
							  <font class="orange"></font>
						</td>
       </tr>
          <tr>
            <td class="blue">Ӧ�����</td>
            <td>
						  <input name="sum_money" type="text"  id="sum_money" readonly value="<%=sum_money%>">
						  <font class="orange">*</font>
						</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td class="blue" >��ע</td>
            <td colspan="3">
            	 <% if (new_opCode.equals("1146")){%>
			     <input name="opNote" type="text"  id="opNote" size="60" maxlength="60" value="�����������" >
			<% }
			else if (new_opCode.equals("7971")) { %>
             <input name="opNote" type="text"  id="opNote" size="60" maxlength="60" value="����Ӫ�������¹��ջ�����" >
            <% } %>
            </td>
          </tr>
          <tr>
            <td colspan="4" align="center">
                <input name="confirm" type="button" class="b_foot" index="2" value="ȷ��&��ӡ" onClick="printCommit()">
                <input name="reset" type="reset" class="b_foot" value="���" >
                <input name="back" onClick="history.go(-1)" type="button" class="b_foot" value="����">
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
		<input type="hidden" name="op_code" value="<%=op_code%>" >
		<input type="hidden" name="new_opCode" value="<%=new_opCode%>">
		<!-- ningtn add for pos start @ 20100520 -->
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
		<!-- ningtn add for pos start @ 20100520 -->
    <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
<%@ include file="/npage/public/hwObject.jsp" %> 
<!-- **** ningtn add for pos @ 20100520 ******���ؽ��пؼ�ҳ BankCtrl ******** -->
<%@ include file="/npage/public/posCCB.jsp" %>
<!-- **** ningtn add for pos @ 20100520 ******���ع��пؼ�ҳ KeeperClient ******** -->
<%@ include file="/npage/public/posICBC.jsp" %>
</html>


