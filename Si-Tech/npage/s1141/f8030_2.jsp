<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-5
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
%>

<%@ page import="com.sitech.boss.common.viewBean.comImpl"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.*" %>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="com.sitech.boss.common.viewBean.comImpl"%>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%@ page import="java.math.*"%>


<%		
	String opCode = "8031";
	String opName = "�����û�Ԥ�滰����������";
	String loginNo = (String)session.getAttribute("workNo");
	String regionCode = (String)session.getAttribute("regCode");
%>
<%
	String retFlag="",retMsg="";
	String[] paraAray1 = new String[4];
	String phoneNo = request.getParameter("phoneNo");
	String opcode = request.getParameter("opcode");
	String backaccept = request.getParameter("backaccept");
	String passwordFromSer="";
	String payType="",Response_time="",TerminalId="",Rrn="",Request_time="";
	String[][] result = new String[][]{};
	String awardName = new String();
	String sqlStr = "select res_info from wawarddata where flag = 'Y' and phone_no = '"+phoneNo+"'"+" and login_accept="+backaccept;
	//ArrayList retArray = impl.sPubSelect("1",sqlStr);
	String groupId = (String)session.getAttribute("groupId");
	String orgCode = (String)session.getAttribute("orgCode");
%>

		<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t1" scope="end"/>

<%  

  if(result_t1 != null&&result_t1.length>0)
  {
	  awardName = result_t1[0][0];		  
	  System.out.println("awardName2="+awardName);

  	if(!awardName.equals("")){
%>
		  <script language="JavaScript" >
		  rdShowMessageDialog("���û����ڴ���Ʒͳһ�����н���<%=awardName%>�콱������д���Ʒͳһ������������ȷ����Ʒ���");
			//history.go(-1);
			</script>
<%	}
	}
  
  paraAray1[0] = phoneNo;		/* �ֻ�����   */ 
  paraAray1[1] = opcode; 	    /* ��������   */
  paraAray1[2] = loginNo;	    /* ��������   */
  paraAray1[3] = backaccept;	    /* ������ˮ   */

  for(int i=0; i<paraAray1.length; i++)
  {		
	if( paraAray1[i] == null )
	{
	  paraAray1[i] = "";
	  
	}
  }
 /* ������� �����룬������Ϣ���ͻ��������ͻ���ַ��֤�����ͣ�֤�����룬ҵ��Ʒ�ƣ�
 			�����أ���ǰ״̬��VIP���𣬵�ǰ����,����Ԥ��
 */

  //retList = impl.callFXService("s8031Init", paraAray1, "32","phone",phoneNo);
  
%>

    <wtc:service name="s8031Init" outnum="37" retmsg="msg2" retcode="code2" routerKey="phone" routerValue="<%=phoneNo%>">
			<wtc:param value="<%=paraAray1[0]%>" />
			<wtc:param value="<%=paraAray1[1]%>" />	
			<wtc:param value="<%=paraAray1[2]%>" />	
			<wtc:param value="<%=paraAray1[3]%>" />	
		</wtc:service>
		<wtc:array id="result_t2" scope="end"/>

<%  
  String  bp_name="",bp_add="",cardId_type="",cardId_no="",sm_code="",region_name="",run_name="",vip="",posint="",prepay_fee="",sale_name="",sum_pay="",card_no="",card_num="",limit_pay="",use_point="",card_summoney="",mach="",machine_type="", vUnitId="",vUnitName="",vUnitAddr="",vUnitZip="",vServiceNo="",vServiceName="",vContactPhone="",vContactPost="", vProductId="",vProductCode="",vTargetName="",vProductName="";
  String errCode = code2;
  String errMsg = msg2;
  if(result_t2 == null)
  {
	if(!retFlag.equals("1"))
	{
		System.out.println("retFlag="+retFlag);
	   retFlag = "1";
	   retMsg = "s8031Init��ѯ���������ϢΪ��!<br>errCode " + errCode + "<br>errMsg+" + errMsg;
    }    
  }else if(!(result_t2 == null))
  {System.out.println("errCode="+errCode);
  System.out.println("errMsg="+errMsg);
  if(!errCode.equals("000000")){%>
<script language="JavaScript">
<!--
  	rdShowMessageDialog("�������<%=errCode%>������Ϣ<%=errMsg%>",0);
  	 history.go(-1);
  	//-->
  	
  </script>
  <%}
	if (errCode.equals("000000")){
	    bp_name = result_t2[0][2];//��������
	    bp_add = result_t2[0][3];//�ͻ���ַ
	    cardId_type = result_t2[0][4];//֤������
	    cardId_no = result_t2[0][5];//֤������
	    sm_code = result_t2[0][6];//ҵ��Ʒ��
	    region_name = result_t2[0][7];//������
	    run_name = result_t2[0][8];//��ǰ״̬
	    vip = result_t2[0][9];//�֣ɣм���
	    posint = result_t2[0][10];//��ǰ����
	    prepay_fee = result_t2[0][11];//����Ԥ��
	    sale_name = result_t2[0][12];//Ӫ��������
	    sum_pay = result_t2[0][13];//Ӧ�����
	    card_no = result_t2[0][14];//����
	    card_num = result_t2[0][15];//��������
	    limit_pay = result_t2[0][16];//Ԥ�滰��
	    use_point = result_t2[0][17];//���ѻ�����
	    card_summoney = result_t2[0][18];//�����ܽ��
	    machine_type = result_t2[0][19];//��������
	    vUnitId = result_t2[0][20];//����ID
	    vUnitName = result_t2[0][21];//��������
	    vUnitAddr = result_t2[0][22];//��λ��ַ
	    vUnitZip = result_t2[0][23];//��λ�ʱ�
	    vServiceNo = result_t2[0][24];//���Ź���
	    vServiceName = result_t2[0][25];//���Ź�������
	    vContactPhone = result_t2[0][26];//��ϵ�绰
	    vContactPost = result_t2[0][27];//��ϵ�ʱ�
	    vProductId = result_t2[0][28];//��Ʒid
	    vProductCode = result_t2[0][29];//��Ʒ����
	    vTargetName = result_t2[0][30];//�ն�Ӫ��Ŀ��
	    vProductName= result_t2[0][31];//��Ʒ����
		///////<!-- ningtn add for pos start @ 20100722 -->
		if(result_t2[0][32] != null && result_t2[0][32].trim().length() > 0){
			payType = result_t2[0][32].trim();
		}else{
			payType = "0";
		}
		Response_time = result_t2[0][33].trim();
		TerminalId = result_t2[0][34].trim();
		Rrn = result_t2[0][35].trim();
		Request_time = result_t2[0][36].trim();
		
		System.out.println("payType : " + payType);
		System.out.println("Response_time : " + Response_time);
		System.out.println("TerminalId : " + TerminalId);
		System.out.println("Rrn : " + Rrn);
		System.out.println("Request_time : " + Request_time);
		///////<!-- ningtn add for pos end @ 20100722 -->
	double mach_fee;
	double sum=0.00;
	double limit=0.00;

	sum=Double.parseDouble(sum_pay);
	limit=Double.parseDouble(limit_pay);
	mach_fee=sum-limit;
	DecimalFormat currencyFormatter = new DecimalFormat("0.00");
	currencyFormatter.format(mach_fee);
	mach=currencyFormatter.format(mach_fee)+"";
	/*mach =String.valueOf(mach_fee);*/
	System.out.println("mach="+mach);
	}else{
		
	}
  }

%>
 <%
// **************�õ�������ˮ***************//
String printAccept="";
printAccept = getMaxAccept();
System.out.println(printAccept);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Ԥ�滰���Żݹ���</title>
<META content="no-cache" http-equiv="Pragma">
<META content="no-cache" http-equiv="Cache-Control">
<META content="0" 	     http-equiv="Expires" > 
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="JavaScript">

<!--
 
  
  function frmCfm(){
		/* ningtn add for pos start @ 20100722 */
		if(document.all.payType.value=="BX")
		{
			/*set �������*/
			var transerial    = "000000000000";  	                  	//����Ψһ�� ������ȡ��
			var trantype      = "01";                                  	//��������
			var bMoney        = "<%=sum_pay%>";					 		//�ɷѽ��
			if(bMoney.indexOf(".") == -1) bMoney=bMoney+"00";
			var tranoper      = "<%=loginNo%>";                        	//���ײ���Ա
			var orgid         = "<%=groupId%>";                        	//ӪҵԱ��������
			var trannum       = "<%=phoneNo%>";                    		//�绰����
			getSysDate();       /*ȡbossϵͳʱ��*/
			var respstamp     = document.all.Request_time.value;       	//�ύʱ��
			var transerialold = "<%=Rrn%>";			    				//ԭ����Ψһ��,�ڽɷ�ʱ�����
			var org_code      = "<%=orgCode%>";                        	//ӪҵԱ����						
			CCBCommon(transerial,trantype,bMoney,tranoper,orgid,trannum,respstamp,transerialold,org_code);
			if(ccbTran=="succ") posSubmitForm();
		}
		else if(document.all.payType.value=="BY")
		{
			var transType     = "04";																	/*�������� */         
			var bMoney        = "<%=sum_pay%>";							/*���׽�� */         
			if(bMoney.indexOf(".") == -1) bMoney=bMoney+"00";
			var response_time = "<%=Response_time%>";                 	/*ԭ�������� */       
			var rrn           = "<%=Rrn%>";                           	/*ԭ����ϵͳ������ */ 
			var instNum       = "";                                   	/*���ڸ������� */     
			var terminalId    = "<%=TerminalId%>";                    	/*ԭ�����ն˺� */
			getSysDate();       //ȡbossϵͳʱ��                                            
			var request_time  = document.all.Request_time.value;      	/*�����ύ���� */     
			var workno        = "<%=loginNo%>";                       	/*���ײ���Ա */       
			var orgCode       = "<%=orgCode%>";                       	/*ӪҵԱ���� */       
			var groupId       = "<%=groupId%>";                       	/*ӪҵԱ�������� */   
			var phoneNo       = "<%=phoneNo%>";                   		/*���׽ɷѺ� */       
			var toBeUpdate    = "";						          		/*Ԥ���ֶ� */         
			var posFlag = ICBCCommon(transType,bMoney,response_time,rrn,instNum,terminalId,request_time,workno,orgCode,groupId,phoneNo,toBeUpdate);									
			if(icbcTran=="succ") posSubmitForm();
		}else{
			posSubmitForm();
		}
		/* ningtn add for pos end @ 20100722 */
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
  
 //��ӡ�������ύ��
  var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes"); 
  
  
  if(typeof(ret)!="undefined")
  {
    if((ret=="1"))
    {
      if(rdShowConfirmDialog('ȷ�ϵ��������')==1)
      {
	    frmCfm();
      }
	}
	if(ret=="0")
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
   
     var printStr = printInfo();
	 //alert(printStr);
   
     var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
     
     var pType="subprint";                     // ��ӡ����print ��ӡ subprint �ϲ���ӡ
     var billType="1";                      //  Ʊ������1���������2��Ʊ��3�վ�
     var sysAccept =document.all.login_accept.value;                       // ��ˮ��
     var printStr = printInfo(printType);   //����printinfo()���صĴ�ӡ����
     var mode_code=null;                        //�ʷѴ���
     var fav_code=null;                         //�ط�����
     var area_code=null;                        //С������
     var opCode =   "<%=opCode%>";                           //��������
     var phoneNo = "<%=phoneNo%>";                             //�ͻ��绰
         /* ningtn */
    var iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
		var accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" +$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();
    /* ningtn */
     
    var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm+"&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr;
		var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);  

}

function printInfo(printType)
{
  

      	var retInfo = "";
		var note_info1 = "";
		var note_info2 = "";
		var note_info3 = "";
		var note_info4 = "";
		var opr_info = "";
		var cust_info = "";
		
	cust_info+="�ֻ����룺"+document.all.phone_no.value+"|";
	cust_info+="�ͻ�������"+document.all.cust_name.value+"|";
	cust_info+="��ϵ�˵绰��"+'<%=vContactPhone%>'+"|";
	cust_info+="�ͻ���ַ��"+document.all.cust_addr.value+"|";
	opr_info+="�������룺"+'<%=vContactPost%>'+"|";
	opr_info+="��λ��ַ��"+'<%=vUnitAddr%>'+"|";
	opr_info+="�������룺��"+'<%=vUnitZip%>'+"|";
	opr_info+="�ͻ�����"+'<%=vServiceName%>'+"|";
	opr_info+="ҵ�����༯�ſͻ��ֻ�������"+"|";
  	opr_info+="ҵ����ˮ��"+document.all.login_accept.value+"|";
  	opr_info+="�ֻ��ͺţ�"+document.all.machine_type.value+"|";
 	
 	
 	
 	
 	
 	/*opr_info+="�˿�ϼƣ�"+document.all.sum_money.value+"Ԫ����Ԥ�滰��"+"<%=limit_pay%>"+"Ԫ"+"|";*/
 	if("<%=payType%>"=="9"){//tianyang add for ֧Ʊ
 		opr_info+="�˿�ϼƣ�֧Ʊ"+document.all.sum_money.value+"Ԫ����Ԥ�滰��"+"<%=limit_pay%>"+"Ԫ"+"|";
 	}else if("<%=payType%>"=="BX"||"<%=payType%>"=="BY"){
 		opr_info+="�˿�ϼƣ�ˢ��"+document.all.sum_money.value+"Ԫ����Ԥ�滰��"+"<%=limit_pay%>"+"Ԫ"+"|";
 	}else{
 		opr_info+="�˿�ϼƣ��ֽ�"+document.all.sum_money.value+"Ԫ����Ԥ�滰��"+"<%=limit_pay%>"+"Ԫ"+"|";
 	}
 	
 	
 	
 	
	opr_info+="ҵ��ִ��ʱ�䣺"+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd ", Locale.getDefault()).format(new java.util.Date())%>'+"|";
    
    note_info1+="��ע:"+"|";
   
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //�ѡ�#"�滻Ϊurl��ʽ

    return retInfo;
		
}


//-->
</script>
</head>
<body>
<form name="frm" method="post" action="f8031Cfm.jsp" onload="init()">
	<%@ include file="/npage/include/header.jsp" %>


	<div class="title">
		<div id="title_zi">�����û�Ԥ�滰���Żݹ�����������</div>
	</div>
        <table cellspacing="0" >
		  <tr> 
            <td class="blue">��������</td>
            <td class="blue">�����û�Ԥ�滰���Żݹ���--����</td>
            <td class="blue">&nbsp;</td>
            <td class="blue">&nbsp;</td>
          </tr>
          <tr> 
            <tr> 
            <td class="blue">����ID</td>
            <td class="blue">
			  <input name="vUnitId" value="<%=vUnitId%>" type="text"  v_must=1 readonly  Class="InputGrey" id="vUnitId" maxlength="20" v_name="����ID"> 
			  <font class="orange">*</font>
            </td>
            <td class="blue">��������</td>
            <td class="blue">
			  <input name="vUnitName" value="<%=vUnitName%>" type="text"  v_must=1 readonly Class="InputGrey" id="vUnitName" maxlength="20" size="38"> 
			  <font class="orange">*</font>
            </td>
            </tr>
			 <tr> 
            <td class="blue">��Ʒ����</td>
            <td class="blue">
			  <input name="vProductCode" value="<%=vProductName%>" type="text"  v_must=1 readonly  Class="InputGrey" id="vProductCode" maxlength="20" v_name="��Ʒ����"> 
			  <font class="orange">*</font>
            </td>
            <td class="blue">��ƷID</td>
            <td class="blue">
			  <input name="vProductId" value="<%=vProductId%>" type="text"  v_must=1 readonly  Class="InputGrey" id="vProductId" maxlength="20" > 
			  <font class="orange">*</font>
            </td>
            </tr>
			<tr> 
            <td class="blue">�ͻ�����</td>
            <td class="blue">
			  <input name="cust_name" value="<%=bp_name%>" type="text"  v_must=1 readonly  Class="InputGrey" id="cust_name" maxlength="20" v_name="����"> 
			  <font class="orange">*</font>
            </td>
            <td class="blue">�ͻ���ַ</td>
            <td class="blue">
			  <input name="cust_addr" value="<%=bp_add%>" type="text"  v_must=1 readonly  Class="InputGrey" id="cust_addr" maxlength="20" size="38"> 
			  <font class="orange">*</font>
            </td>
            </tr>
            <tr> 
            <td class="blue">֤������</td>
            <td class="blue">
			  <input name="cardId_type" value="<%=cardId_type%>" type="text"  v_must=1 readonly  Class="InputGrey" id="cardId_type" maxlength="20" > 
			  <font class="orange">*</font>
            </td>
            <td class="blue">֤������</td>
            <td class="blue">
			  <input name="cardId_no" value="<%=cardId_no%>" type="text"  v_must=1 readonly  Class="InputGrey" id="cardId_no" maxlength="20" > 
			  <font class="orange">*</font>
            </td>
            </tr>
            <tr> 
            <td class="blue">ҵ��Ʒ��</td>
            <td class="blue">
			  <input name="sm_code" value="<%=sm_code%>" type="text"  v_must=1 readonly  Class="InputGrey" id="sm_code" maxlength="20" > 
			  <font class="orange">*</font>
            </td>
            <td class="blue">����״̬</td>
            <td class="blue">
			  <input name="run_type" value="<%=run_name%>" type="text"  v_must=1 readonly  Class="InputGrey" id="run_type" maxlength="20" > 
			  <font class="orange">*</font>
            </td>
            </tr>
            <tr> 
            <td class="blue">VIP����</td>
            <td class="blue">
			  <input name="vip" value="<%=vip%>" type="text"  v_must=1 readonly  Class="InputGrey" id="vip" maxlength="20" > 
			  <font class="orange">*</font>
            </td>
            <td class="blue">����Ԥ��</td>
            <td class="blue">
			  <input name="prepay_fee" value="<%=prepay_fee%>" type="text"  v_must=1 readonly  Class="InputGrey" id="prepay_fee" maxlength="20" > 
			  <font class="orange">*</font>
            </td>
            </tr>
           <tr> 
            <td class="blue">Ӫ������</td>
            <td >
				<input name="sale_name" value="<%=sale_name%>" type="text"  v_must=1 readonly  Class="InputGrey" id="sale_name" maxlength="20" size="38"> 
			    <font class="orange">*</font>
			</td>
			<td  class="blue">Ӧ�˽��</td>
            <td >
			  <input name="sum_money" type="text"  id="sum_money" value="<%=sum_pay%>" readonly Class="InputGrey" >
			  <font class="orange">*</font>
			</td>            
          </tr>
          <tr> 
            <td  class="blue">������</td>
            <td >
			  <input name="price" type="text"  id="price" value="<%=mach%>" readonly  Class="InputGrey"  >
			  <font class="orange">*</font>	
			</td>
            <td class="blue">Ԥ�滰��</td>
            <td class="blue">
			  <input name="limit_pay" type="text"   id="limit_pay" value="<%=limit_pay%>" readonly Class="InputGrey" >
			  <font class="orange">*</font>
			</td>
          </tr>

          <tr> 
            <td height="32"   class="blue">��ע</td>
            <td colspan="4" height="32">
             <input name="opNote" type="text"  id="opNote" size="60" maxlength="60" value="�����û�Ԥ�滰���Żݹ���--����" readonly Class="InputGrey" > 
            </td>
            
          </tr>
<jsp:include page="/npage/public/hwReadCustCard.jsp">
	<jsp:param name="hwAccept" value="<%=printAccept%>"  />
	<jsp:param name="showBody" value="01"  />
</jsp:include>
          <tr> 
            <td colspan="4" id="footer"> <div align="center"> 
                <input name="confirm" type="button"  index="2" value="ȷ��&��ӡ" onClick="printCommit()" class="b_foot_long">
                &nbsp; 
                <input name="reset" type="reset"  value="���" class="b_foot">
                &nbsp; 
                <input name="back" onClick="history.go(-1)" type="button"  value="����" class="b_foot">
                &nbsp; </div></td>
          </tr>
        </table>

    <input type="hidden" name="phone_no" value="<%=phoneNo%>">
    <input type="hidden" name="opCode" value="<%=opCode%>">
    <input type="hidden" name="opName" value="<%=opName%>">
	<input type="hidden" name="opcode" value="<%=opcode%>">
    <input type="hidden" name="login_accept" value="<%=printAccept%>">
	<input type="hidden" name="backaccept" value="<%=backaccept%>">
    <input type="hidden" name="card_dz" value="0" >
	<input type="hidden" name="sale_type" value="1" >
    <input type="hidden" name="used_point" value="0" >  
	<input type="hidden" name="point_money" value="0" > 
	<input type="hidden" name="machine_type" value="<%=machine_type%>" >
	<!-- ningtn add for pos start @ 20100722 -->
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
	<!-- ningtn add for pos start @ 20100722 -->
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
<!-- **** ningtn add for pos @ 20100722 ******���ؽ��пؼ�ҳ BankCtrl ******** -->
<%@ include file="/npage/public/posCCB.jsp" %>
<!-- **** ningtn add for pos @ 20100722 ******���ع��пؼ�ҳ KeeperClient ******** -->
<%@ include file="/npage/public/posICBC.jsp" %>
<%@ include file="/npage/public/hwObject.jsp" %> 
</html>