<%
/********************
 version v2.0
������: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
%>

<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>


<%		
  		String opCode = "7956";
		String opName = "���������ѣ����·���������";
	    
	String loginName = WtcUtil.repNull((String)session.getAttribute("workName"));	
	String loginNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
  String powerCode= WtcUtil.repNull((String)session.getAttribute("powerCode")); 
  String orgCode = WtcUtil.repNull((String)session.getAttribute("orgCode"));
  String ip_Addr = WtcUtil.repNull((String)session.getAttribute("ipAddr")); 
  String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
  String loginNoPass = ((String)session.getAttribute("password"));       
  /**** tianyang add for pos start ****/
  String groupId = WtcUtil.repNull((String)session.getAttribute("groupId"));
  System.out.println("groupId="+groupId);
  /**** tianyang add for pos end ****/
  /* ningtn pos ���ճ��� */
	String cccTime=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date());
	/* �Ƿ���ճ����ı�ʶ  -1���ճ��� ; 0���ճ��� */
	int isNextDay = 999;
%>
<%

String retFlag="",retMsg="";
  ArrayList retList = new ArrayList();
  String[] paraAray1 = new String[8];
  String phoneNo = request.getParameter("srv_no");
  String opcode = request.getParameter("opcode");
  String backaccept = request.getParameter("backaccept");
  String passwordFromSer="";
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone" routerValue="<%=phoneNo%>" id="printAccept"/>
<%
  
  paraAray1[0] = phoneNo;		/* �ֻ�����   */ 
  paraAray1[1] = opcode; 	    /* ��������   */
  paraAray1[2] = loginNo;	    /* ��������   */
  paraAray1[3] = backaccept;	    /* ������ˮ   */
  paraAray1[4] = "01";          /* ����       */
  paraAray1[5] = loginNoPass; /* ��������   */
  paraAray1[6] = "";          /* �ֻ�����   */
  paraAray1[7] = printAccept; /* ����ˮ   */
/*****��÷ ��� 20060605*****/
  ArrayList retArray = new ArrayList();
  String[][] result = new String[][]{};
  String sqlStr = "";
  String awardName="";
  sqlStr = "select award_name from wawardpay where phone_no ='"+phoneNo+"'"+
		    " and login_accept="+backaccept ;
		%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="RetCode1" retmsg="RetMsg1" outnum="1">
	<wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result11" scope="end" />
		<%
	if(result11.length>0) {
  result = result11;
  awardName = result[0][0];	
  System.out.println("awardName="+awardName);
  }
  
  

  if(!awardName.equals("")){
  %>
<script type="text/javascript" src="../../js/common/redialog/redialog.js"></script>	
<script language="JavaScript" >


   if(rdShowConfirmDialog("���û�Ϊ���н��û����н���ƷΪ��<%=awardName%> ���û�������𷵻ؽ�Ʒ���ټ����������ҵ��")!=1)
	{	
		location='f7955_login.jsp?activePhone=<%=paraAray1[0]%>';
	}
	  
	</script>
  
<%}


  /*sunzx add at 20070904  */
  sqlStr = "select res_info from wawarddata where flag = 'Y' and phone_no = '"+phoneNo+"'"+
		    " and login_accept="+backaccept  ;
		

  %>
  	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="RetCode1" retmsg="RetMsg1" outnum="1">
	<wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result22" scope="end" />
  <%
  if(result22.length>0)
  {
	  result = result22;
	  awardName = result[0][0];	
	  
	  System.out.println("awardName2="+awardName);
	
	  if(!awardName.equals("")){
%>
		  <script type="text/javascript" src="../../js/common/redialog/redialog.js"></script>	
		  <script language="JavaScript" >
		
		  rdShowMessageDialog("���û����ڴ���Ʒͳһ�����н���<%=awardName%>�콱������д���Ʒͳһ������������ȷ����Ʒ���");
			location='f7955_login.jsp?activePhone=<%=paraAray1[0]%>';
			</script>
<%	}
	}
	//sunzx add end

  /*****��÷ ��� 20060605*******/
  for(int i=0; i<paraAray1.length; i++)
  {		
	if( paraAray1[i] == null )
	{
	  paraAray1[i] = "";
	  
	}
  }
 /* ��������� �����룬������Ϣ���ͻ��������ͻ���ַ��֤�����ͣ�֤�����룬ҵ��Ʒ�ƣ�
 			�����أ���ǰ״̬��VIP���𣬵�ǰ����,����Ԥ��
 			�����ѣ������������·ݣ�WLANҵ��Ѻ�WLANҵ��������·�
 			//huangrong update s1142Qry���εĸ��� 31-->35
 */

  //retList = impl.callFXService("s1142Qry", paraAray1, "31","phone",phoneNo);
  
  %>
  
  <wtc:service name="s1142Qry" routerKey="phone" routerValue="<%=phoneNo%>"  retcode="errCode" retmsg="errMsg"  outnum="35" >
	<wtc:param value="<%=paraAray1[7]%>"/>
	<wtc:param value="<%=paraAray1[4]%>"/>
	<wtc:param value="<%=paraAray1[1]%>"/>
	<wtc:param value="<%=paraAray1[2]%>"/>
	<wtc:param value="<%=paraAray1[5]%>"/>
	<wtc:param value="<%=paraAray1[0]%>"/>
	<wtc:param value="<%=paraAray1[6]%>"/> 
	<wtc:param value="<%=paraAray1[3]%>"/>
	</wtc:service>
	<wtc:array id="result22222" scope="end" />
  
  
  
  
  
  <%
  String bp_name="",bp_add="",cardId_type="",cardId_no="",sm_code="",region_name="",run_name="",vip="",posint="",prepay_fee="",sale_name="",sum_pay="",card_no="",card_num="",limit_pay="",use_point="",card_summoney="",mach="",machine_type="" ;
  String payType="",Response_time="",TerminalId="",Rrn="",Request_time="";
  String TVprice ="",TVtime="";
  String phoneNetPrice="",phoneNetTime="",wlanPrice="",wlanTime="";
  String[][] tempArr= new String[][]{};

   if(result22222.length<=0)
  {
	if(!retFlag.equals("1"))
	{
		System.out.println("retFlag="+retFlag);
	   retFlag = "1";
	   retMsg = "s1142Qry��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
    }    
  }else 
  {System.out.println("errCode="+errCode);
  System.out.println("errMsg="+errMsg);
  if(!"000000".equals(errCode)){%>
<script language="JavaScript">
<!--
  	rdShowMessageDialog("������룺<%=errCode%>������Ϣ��<%=errMsg%>",0);
  	 history.go(-1);
  	//-->
  </script>
  <%}
else {
	   tempArr = result22222;
	  if(!(tempArr==null)){
	    bp_name = tempArr[0][2];//��������
	    System.out.println(bp_name);
	  }

	  if(!(tempArr==null)){
	    bp_add = tempArr[0][3];//�ͻ���ַ
	  }

	  if(!(tempArr==null)){
	    cardId_type = tempArr[0][4];//֤������
	  }

	  if(!(tempArr==null)){
	    cardId_no = tempArr[0][5];//֤������
	  }

	  if(!(tempArr==null)){
	    sm_code = tempArr[0][6];//ҵ��Ʒ��
	  }

	  if(!(tempArr==null)){
	    region_name = tempArr[0][7];//������
	  }

	  if(!(tempArr==null)){
	    run_name = tempArr[0][8];//��ǰ״̬
	  }

	  if(!(tempArr==null)){
	    vip = tempArr[0][9];//�֣ɣм���
	  }

	  if(!(tempArr==null)){
	    posint = tempArr[0][10];//��ǰ����
	  }

	  if(!(tempArr==null)){
	    prepay_fee = tempArr[0][11];//����Ԥ��
	  }

	  if(!(tempArr==null)){
	    sale_name = tempArr[0][12];//Ӫ��������
	  }

	  if(!(tempArr==null)){
	    sum_pay = tempArr[0][13];//Ӧ�����
	  }

	  if(!(tempArr==null)){
	    card_no = tempArr[0][14];//����
	  }

	  if(!(tempArr==null)){
	    card_num = tempArr[0][15];//��������
	  }

	  if(!(tempArr==null)){
	    limit_pay = tempArr[0][16];//Ԥ�滰��
	  }

	  if(!(tempArr==null)){
	    use_point = tempArr[0][17];//���ѻ�����
	  }

	  if(!(tempArr==null)){
	    card_summoney = tempArr[0][18];//�����ܽ��
	  }
	 
	  if(!(tempArr==null)){
	    machine_type = tempArr[0][19];//��������
	  }
	  
	  /**** tianyang add for pos start ****/

	  if(!(tempArr==null)){
	    payType = tempArr[0][24].trim();
	    System.out.println("------payType------"+payType);
	  }

	  if(!(tempArr==null)){
	    Response_time = tempArr[0][25].trim();
	    System.out.println("------Response_time------"+Response_time);
	  }

	  if(!(tempArr==null)){
	    TerminalId = tempArr[0][26].trim();
	    System.out.println("------TerminalId------"+TerminalId);
	  }

	  if(!(tempArr==null)){
	    Rrn = tempArr[0][27].trim();
	    System.out.println("------Rrn------"+Rrn);
	  }

	  if(!(tempArr==null)){
	    Request_time = tempArr[0][28].trim();
	    System.out.println("------Request_time------"+Request_time);
	  }
	  if(Request_time.length() > 0){
			isNextDay = Request_time.substring(0,8).compareTo(cccTime);
		}else{
			isNextDay = 0;
		}
	  /*wangdana add for �ֻ�����@20100629*/

	  if(!(tempArr==null)){
	    TVprice = tempArr[0][29];//�ֻ����ӷ�
	    System.out.println("TVprice"+TVprice);
	  }
	  else
	  	{
	  		System.out.println("TVprice erro");
	  		}

	  if(!(tempArr==null)){
	    TVtime = tempArr[0][30];//�ֻ���������ʱ��
	    System.out.println(TVtime);
	  }

	  /*begin huangrong add for �����ѣ������������·ݣ�WLANҵ��Ѻ�WLANҵ��������·� 2011-7-4 */  
	  if(!(tempArr==null)){
	    phoneNetPrice = tempArr[0][31];//�ֻ��������ܷ�
	    System.out.println("phoneNetPrice"+phoneNetPrice);
	  }
	  else
	  	{
	  		System.out.println("phoneNetPrice erro");
	  		}

	  if(!(tempArr==null)){
	    phoneNetTime = tempArr[0][32];//�ֻ��������ܷ���������
	    System.out.println(phoneNetTime);
	  }	  
	  
	  if(!(tempArr==null)){
	    wlanPrice = tempArr[0][33];//WLAN���ܷ�
	    System.out.println("wlanPrice"+wlanPrice);
	  }
	  else
	  	{
	  		System.out.println("wlanPrice erro");
	  		}

	  if(!(tempArr==null)){
	    wlanTime = tempArr[0][34];//WLAN���ܷ���������
	    System.out.println(wlanTime);
	  }		   
	  /*end huangrong add for �����ѣ������������·ݣ�WLANҵ��Ѻ�WLANҵ��������·� 2011-7-4 */	  
	  
	  	  
	  /**** tianyang add for pos end ****/
	    
	  

	double mach_fee=0.00;
	double sum=0.00;
	double limit=0.00;
	double TVfee=0.00;
	double phoneNetfee=0.00;
	double wlanfee=0.00;

	sum=Double.parseDouble(sum_pay);
	System.out.println("sum="+sum);
	limit=Double.parseDouble(limit_pay);
	TVfee=Double.parseDouble(TVprice);

	
	//huangrong add �ֻ��������ܷѺ�wlan���ܷ�
	phoneNetfee=Double.parseDouble(phoneNetPrice);
	wlanfee=Double.parseDouble(wlanPrice);	
	
	mach_fee=sum-limit-TVfee-phoneNetfee-wlanfee;//huangrong update ���Ӷ��ֻ��������ܷѺ�wlan���ܷѵĿۼ���
	System.out.println("mach_fee="+mach_fee);
	//mach =String.valueOf(mach_fee);
	DecimalFormat currencyFormatter = new DecimalFormat("0.00");
	currencyFormatter.format(mach_fee);
	System.out.println("mach_fee="+currencyFormatter.format(mach_fee));
	mach=currencyFormatter.format(mach_fee)+"";
	System.out.println("mach="+mach);
	}
  }

%>
 <%    

// **************�õ�������ˮ***************//
%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="printAccept" />
			<%
			System.out.println(printAccept);
			%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>���������ѣ����·�����</title>
<META content="no-cache" http-equiv="Pragma">
<META content="no-cache" http-equiv="Cache-Control">
<META content="0" 	     http-equiv="Expires" > 

<script language="JavaScript">
<!--
var isNextDay = "<%=isNextDay%>";


	function doProcess(packet){
		/*tianyang add for pos�ɷ� start*/
		var verifyType = packet.data.findValueByName("verifyType");
		if(verifyType=="getSysDate"){
			retType = "getSysDate";			
		}		
		if(retType == "getSysDate")
		{
			var sysDate = packet.data.findValueByName("sysDate");
			document.all.Request_time.value = sysDate;
			return ;
		}
		/**** tianyang add for pos end ****/
	}



	/*tianyang add POS�ɷ� start*/
	function getSysDate()
	{		
			var myPacket = new AJAXPacket("../public/pos_getSysDate.jsp","���ڻ��ϵͳʱ�䣬���Ժ�......");
			myPacket.data.add("verifyType","getSysDate");
			core.ajax.sendPacket(myPacket);
	  	myPacket =null;
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
	function posSubmitForm(){/* POS�ɷ��� ҳ���ύ  start*/
			frm.submit();
			return true;
	}
	/*tianyang add POS�ɷ� end*/
  
  function frmCfm(){
	  	if(document.all.payType.value=="BX" && isNextDay == "0")
	  	{
	    		/*set �������*/
					var transerial    = "000000000000";  	                     //����Ψһ�� ������ȡ��
					var trantype      = "01";                                  //��������
					var bMoney        = "<%=sum_pay%>";					 							 //�ɷѽ��
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
			else if(document.all.payType.value=="BY" && isNextDay == "0")
			{
					var transType     = "04";																	/*�������� */         
					var bMoney        = "<%=sum_pay%>";							          /*���׽�� */         
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
  }
 //***
 function printCommit()
 { 
  //У��
  //if(!check(frm)) return false;
  
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
   
   var printStr = printInfo(printType);
   /*
   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
   var path = "<%=request.getContextPath()%>/npage/innet/hljPrint.jsp?DlgMsg=" + DlgMessage;
   var path = path + "&printInfo=" + printStr + "&submitCfm=" + submitCfm;
   var ret=window.showModalDialog(path,"",prop);
   return ret;    
   */
   	var pType="subprint";             				 		//��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
		var billType="1";              				 			//Ʊ�����ͣ�1���������2��Ʊ��3�վ�
		var sysAccept =<%=printAccept%>;             			//��ˮ��
		var printStr = printInfo(printType);			 		//����printinfo()���صĴ�ӡ����
		var mode_code=null;           							//�ʷѴ���
		var fav_code=null;                				 		//�ط�����
		var area_code=null;             				 		//С������
		var opCode="7956" ;                   			 		//��������
		var phoneNo="<%=phoneNo%>";                  	 		//�ͻ��绰
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
		var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
		path+="&mode_code="+mode_code+
			"&fav_code="+fav_code+"&area_code="+area_code+
			"&opCode=<%=opCode%>&sysAccept="+sysAccept+
			"&phoneNo="+phoneNo+
			"&submitCfm="+submitCfm+"&pType="+
			pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,"",prop);
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

	//opr_info+='<%=loginNo%>'+' '+'<%=loginName%>'+"|";
//	opr_info+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	cust_info+="�ֻ����룺"+document.all.phone_no.value+"|";
	cust_info+="�ͻ�������"+document.all.cust_name.value+"|";
	cust_info+="�ͻ���ַ��"+document.all.cust_addr.value+"|";
	cust_info+="֤�����룺"+document.all.cardId_no.value+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	opr_info+="ҵ�����ͣ����������ѣ����·�����--����"+"|";
	opr_info+="ҵ����ˮ��"+document.all.login_accept.value+"|";
	opr_info+="�ֻ��ͺ�: "+"<%=machine_type%>"+"|";
	opr_info+="�˿�ϼƣ�"+document.all.sum_money.value+"Ԫ�������ͻ���"+"<%=limit_pay%>"+"Ԫ";

 	/*begin huangrong add ���ֻ����ӹ��ܷѣ��ֻ��������ܷѣ�WLAN���ܷ��в�Ϊ0��ʱ���չʾ*/ 	
  if(document.frm.TVprice.value!="0")
 	{
 		opr_info+="���ֻ����ӹ��ܷ�"+document.all.TVprice.value+"Ԫ";
 	}
 	if(document.frm.phoneNetPrice.value!="0" && document.frm.wlanPrice.value!="0")
 	{
 		opr_info+="���ֻ��������ܷ�"+document.all.phoneNetPrice.value+"��WLAN���ܷ�"+document.all.wlanPrice.value+"Ԫ";
 	}else
 	{
	 	if(document.frm.phoneNetPrice.value!="0")
	 	{
	 		opr_info+="���ֻ��������ܷ�"+document.all.phoneNetPrice.value+"Ԫ";
	 	}
	 	if(document.frm.wlanPrice.value!="0")
	 	{
	 		opr_info+="��WLAN���ܷ�"+document.all.wlanPrice.value+"Ԫ";
	 	} 		
 	}	
 	opr_info+="|";	
 	/*end huangrong add ���ֻ����ӹ��ܷѣ��ֻ��������ܷѣ�WLAN���ܷ��в�Ϊ0��ʱ���չʾ*/  
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";	
    retInfo=strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);

	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");

  return retInfo;

}


//-->
</script>

</head>
<body>
<form name="frm" method="post" action="f7956Cfm.jsp" >
	<%@ include file="/npage/include/header.jsp" %>  
 <div class="title">
		<div id="title_zi">���������ѣ����·�����</div>
	 </div>					
			<div id="showMsg"></div>

        <table >
		  <tr > 
            <td class="blue">�������ͣ�</td>
            <td class="blue">���������ѣ����·�����--����</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr > 
            <td class="blue">�ͻ�����:</td>
            <td>
			  <input name="cust_name" value="<%=bp_name%>" type="text" v_must=1 readonly id="cust_name" maxlength="20" v_name="����" Class="InputGrey" > 
			  <font class='orange'>*</font>
            </td>
            <td class="blue">�ͻ���ַ:</td>
            <td>
			  <input name="cust_addr" value="<%=bp_add%>" type="text" v_must=1 readonly id="cust_addr" maxlength="20" Class="InputGrey"> 
			   <font class='orange'>*</font>
            </td>
            </tr>
            <tr > 
            <td class="blue">֤������:</td>
            <td>
			  <input name="cardId_type" value="<%=cardId_type%>" type="text" v_must=1 readonly id="cardId_type" maxlength="20" Class="InputGrey"> 
			  <font class='orange'>*</font>
            </td>
            <td class="blue">֤������:</td>
            <td>
			  <input name="cardId_no" value="<%=cardId_no%>" type="text"  v_must=1 readonly id="cardId_no" maxlength="20" Class="InputGrey"> 
			   <font class='orange'>*</font>
            </td>
            </tr>
            <tr > 
            <td class="blue">ҵ��Ʒ��:</td>
            <td>
			  <input name="sm_code" value="<%=sm_code%>" type="text"  v_must=1 readonly id="sm_code" maxlength="20" Class="InputGrey"> 
			   <font class='orange'>*</font>
            </td>
            <td class="blue">����״̬:</td>
            <td>
			  <input name="run_type" value="<%=run_name%>" type="text"  v_must=1 readonly id="run_type" maxlength="20" Class="InputGrey"> 
			   <font class='orange'>*</font>
            </td>
            </tr>
            <tr > 
            <td class="blue">VIP����:</td>
            <td>
			  <input name="vip" value="<%=vip%>" type="text"  v_must=1 readonly id="vip" maxlength="20" Class="InputGrey"> 
			   <font class='orange'>*</font>
            </td>
            <td class="blue">����Ԥ��:</td>
            <td>
			  <input name="prepay_fee" value="<%=prepay_fee%>" type="text"  v_must=1 readonly id="prepay_fee" maxlength="20" Class="InputGrey"> 
			   <font class='orange'>*</font>
            </td>
            </tr>
           <tr > 
            <td class="blue">Ӫ��������</td>
            <td >
				<input name="sale_name" value="<%=sale_name%>" type="text"  v_must=1 readonly id="sale_name" maxlength="20" size="40" Class="InputGrey"> 
			    <font class='orange'>*</font>
			</td>
			<td class="blue">Ӧ�˽�</td>
            <td >
			  <input name="sum_money" type="text"  id="sum_money" value="<%=sum_pay%>" readonly Class="InputGrey">
			   <font class='orange'>*</font>
			</td>            
          </tr>
          <tr > 
            <td class="blue">�����</td>
            <td >
			  <input name="price" type="text" id="price" value="<%=mach%>" readonly   Class="InputGrey">
			   <font class='orange'>*</font>	
			</td>
            <td class="blue">���ͻ��ѣ�</td>
            <td>
			  <input name="limit_pay" type="text"   id="limit_pay" value="<%=limit_pay%>" readonly Class="InputGrey">
			   <font class='orange'>*</font>
			</td>
          </tr>
          
          <!--�ֻ������������� wangdana-->
          <tr > 
            <td class="blue">�ֻ����ӹ��ܷѣ�</td>
            <td >
			  <input name="TVprice" type="text" id="TVprice" value="<%=TVprice%>"   readonly v_name="�ֻ����ӹ��ܷ�" Class="InputGrey">
			  <font class='orange'>*</font>
			</td>
            <td class="blue">�ֻ������������ޣ�</td>
            <td>
			  <input name="TVtime" type="text"  id="TVtime"  value="<%=TVtime%>" v_type="0_9" v_must=1   v_name="����ʱ��" readonly Class="InputGrey">
			   <font class='orange'>*</font>
			</td>
          </tr>
		<!--begin huangrong add �����ѣ������������·ݣ�WLANҵ��Ѻ�WLANҵ��������·ݵ���Ϣչʾ 2011-6-29-->
    <tr> 
      <td class="blue">�ֻ��������ܷѣ�</td>
      <td >
			  <input name="phoneNetPrice" type="text" class="button" id="phoneNetPrice" value="<%=phoneNetPrice%>"  v_type="money" v_must=1   readonly v_name="������" >
			  <font color="#FF0000">*</font>	
			</td>
      <td class="blue">�ֻ������������ޣ�</td>
      <td>
			  <input name="phoneNetTime" type="text"  class="button" id="phoneNetTime" value="<%=phoneNetTime%>"  v_type="0_9" v_must=1   v_name="����ʱ��" readonly>
			  <font color="#FF0000">*</font>
			</td>
    </tr>  
    <tr> 
      <td class="blue">WLAN���ܷѣ�</td>
      <td >
			  <input name="wlanPrice" type="text" class="button" id="wlanPrice"  value="<%=wlanPrice%>"  v_type="money" v_must=1   readonly v_name="WLANҵ���" >
			  <font color="#FF0000">*</font>	
			</td>
      <td class="blue">WLAN�������ޣ�</td>
      <td>
			  <input name="wlanTime" type="text"  class="button" id="wlanTime" value="<%=wlanTime%>"  v_type="0_9" v_must=1   v_name="����ʱ��" readonly>
			  <font color="#FF0000">*</font>
			</td>
    </tr>                  
	  <!--end huangrong add �����ѣ������������·ݣ�WLANҵ��Ѻ�WLANҵ��������·ݵ���Ϣչʾ 2011-6-29-->                  
          <tr > 
            
            <td></td>
            <td></td>
          </tr> 
          <tr > 
            <td height="32"  class="blue">��ע��</td>
            <td colspan="3" height="32">
             <input name="opNote" type="text"  id="opNote" size="60" maxlength="60" value="���������ѣ����·�����--����" > 
            </td>
          </tr>
          <tr> 
            <td colspan="4"> <div align="center"> 
                <input name="confirm" type="button" class="b_foot" index="2" value="ȷ��&��ӡ" onClick="printCommit()">
                &nbsp; 
                <input name="reset" type="reset" class="b_foot" value="���" >
                &nbsp; 
                <input name="back" onClick="window.close()" type="button" class="b_foot" value="�ر�">
                &nbsp; </div></td>
          </tr>
        </table>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  <p>&nbsp;</p>  
  </td>
  </tr>
  </table>	
    <input type="hidden" name="phone_no" value="<%=phoneNo%>">
    <input type="hidden" name="work_no" value="<%=loginName%>">
	<input type="hidden" name="opcode" value="<%=opcode%>">
    <input type="hidden" name="login_accept" value="<%=printAccept%>">
	<input type="hidden" name="backaccept" value="<%=backaccept%>">
    <input type="hidden" name="card_dz" value="0" >
	<input type="hidden" name="sale_type" value="1" >
    <input type="hidden" name="used_point" value="0" >  
	<input type="hidden" name="point_money" value="0" > 
	<input type="hidden" name="machine_type" value="<%=machine_type%>" >
	<!-- tianyang add at 20100201 for POS�ɷ�����*****start*****-->
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
	<input type="hidden" name="isNextDay"  value="<%=isNextDay%>">
	<!-- tianyang add at 20100201 for POS�ɷ�����*****end*******-->
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
<!-- **** ningtn add for pos @ 20100430 ******���ؽ��пؼ�ҳ BankCtrl ******** -->
<%@ include file="/npage/public/posCCB.jsp" %>
<!-- **** ningtn add for pos @ 20100430 ******���ع��пؼ�ҳ KeeperClient ******** -->
<%@ include file="/npage/public/posICBC.jsp" %>

</html>
