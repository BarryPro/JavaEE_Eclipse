<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����: ����Ԥ������8380
   * �汾: 1.0
   * ����: 2010/3/18
   * ����: sunaj
   * ��Ȩ: si-tech
   * update:
  */
%>

<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>

<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*" %>

<%
  	String opCode="8380";
	String opName="����Ԥ������";
	String loginNo = (String)session.getAttribute("workNo");
	String loginName = (String)session.getAttribute("workName");
	String regionCode = (String)session.getAttribute("regCode");
	String orgCode = (String)session.getAttribute("orgCode");
	String groupId = (String)session.getAttribute("groupId");
	/* liujian ��ȫ�ӹ��޸� 2012-4-6 16:18:13 begin */
	String op_strong_pwd = (String) session.getAttribute("password");
  /* liujian ��ȫ�ӹ��޸� 2012-4-6 16:18:13 end */
%>
<%
	String retFlag="",retMsg="";
	String phoneNo =(String)request.getParameter("srv_no");	//�ֻ�����
	String opcode = request.getParameter("opcode");
	String backaccept = request.getParameter("backaccept"); 
	String payType="",Response_time="",TerminalId="",Rrn="",Request_time="";
	String[] paraAray1 = new String[8];
	paraAray1[0] = " ";	   
	paraAray1[1] = "01";
	paraAray1[2] = opcode;
	paraAray1[3] = loginNo;	
	paraAray1[4] = op_strong_pwd;    
	paraAray1[5] = phoneNo;		
	paraAray1[6] = " "; 	    
	paraAray1[7] = backaccept;	   
		
/*****��÷ ��� 20060605*****/

	String sqlStr = "";
	String awardName="";
	String[] inParam = new String[2];
	inParam[0] = "select award_name from wawardpay where phone_no =:phoneNo"+"and login_accept=:backaccept";
	inParam[1] = "phoneNo="+phoneNo+",backaccept="+backaccept;
%>
	<wtc:service name="TlsPubSelCrm"  outnum="1" retcode="retCode1" retmsg="retMsg1">
		<wtc:param value="<%=inParam[0]%>"/>
		<wtc:param value="<%=inParam[1]%>"/> 
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%	  
	if(retCode1.equals("000000")||retCode1.equals("0")&&result.length>0)
	{
  		awardName = result[0][0];
  		System.out.println("awardName="+awardName);
	}
 	if(!awardName.equals("")){
  %>
	<script language="JavaScript" >
	   	if(rdShowConfirmDialog("���û�Ϊ���н��û����н���ƷΪ��<%=awardName%> ���û�������𷵻ؽ�Ʒ���ټ����������ҵ��")!=1)
		{
			location="f8379_login.jsp?activePhone=<%=phoneNo%>";
		}
	</script>

<%}
	String[] inParam1 = new String[2];
	inParam1[0] = "select res_code from wAwardData where phone_no =:phoneNo"+"and login_accept=:backaccept"+" and flag = 'Y'";
	inParam1[1] = "phoneNo="+phoneNo+",backaccept="+backaccept;
%>
	<wtc:service name="TlsPubSelCrm"  outnum="1" retcode="retCode2" retmsg="retMsg2">
		<wtc:param value="<%=inParam1[0]%>"/>
		<wtc:param value="<%=inParam1[1]%>"/> 
	</wtc:service>
	<wtc:array id="result1" scope="end"/>
<%	  
	if(retCode2.equals("000000")||retCode2.equals("0")&&result1.length>0)
	{
  		awardName = result1[0][0];
  		System.out.println("res_code="+awardName);
	}
  
 	if(!awardName.equals("")){
  	%>
	<script language="JavaScript" >
		rdShowMessageDialog("���û��ڴ���Ʒͳһ���������,���ܽ��г�����");
		location="f8379_login.jsp?activePhone=<%=phoneNo%>";
	</script>
<%}
 

/*****��÷ ��� 20060605*******/
  for(int i=0; i<paraAray1.length; i++)
  {
	if( paraAray1[i] == null )
	{
	  paraAray1[i] = "";

	}
  }

%>
	<wtc:service name="s8380Qry" routerKey="phone" routerValue="<%=phoneNo%>" outnum="27" retcode="retCode" retmsg="retMsg1">
		<wtc:param value="<%=paraAray1[0]%>"/>
		<wtc:param value="<%=paraAray1[1]%>"/>
		<wtc:param value="<%=paraAray1[2]%>"/>
		<wtc:param value="<%=paraAray1[3]%>"/>
		<wtc:param value="<%=paraAray1[4]%>"/>
		<wtc:param value="<%=paraAray1[5]%>"/>
		<wtc:param value="<%=paraAray1[6]%>"/>
		<wtc:param value="<%=paraAray1[7]%>"/>
	</wtc:service>
	<wtc:array id="tempArr" scope="end"/>
<%
  	String  bp_name="",bp_add="",cardId_type="",cardId_no="",sm_code="",region_name="",run_name="";
  	String  vip="",posint="",prepay_fee="",sale_name="",sum_pay="",card_no="",card_num="",limit_pay="";
  	String  use_point="",card_summoney="",mach="",machine_type="",basefee="",freefee="",usedpoint="" ;
  	String  base_term="",free_term="",return_fee="",return_term="",pay_fee="";
	String  errCode = retCode;
	String  errMsg = retMsg1;
	if(tempArr == null)
	{
		if(!retFlag.equals("1"))
		{
			System.out.println("retFlag="+retFlag);
		   	retFlag = "1";
		   	retMsg = "s8380Qry��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
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
		if( errCode.equals("000000")&&tempArr.length>0 ){
		    bp_name = tempArr[0][2];			//��������
		    bp_add = tempArr[0][3];				//�ͻ���ַ
		    cardId_type = tempArr[0][4];		//֤������
		    cardId_no = tempArr[0][5];			//֤������
		    sm_code = tempArr[0][6];			//ҵ��Ʒ��
		    region_name = tempArr[0][7];		//������
		    run_name = tempArr[0][8];			//��ǰ״̬
		    vip = tempArr[0][9];				//�֣ɣм���
		    posint = tempArr[0][10];			//��ǰ����
		    prepay_fee = tempArr[0][11];		//����Ԥ��
		    sale_name = tempArr[0][12];			//Ӫ��������
		    sum_pay = tempArr[0][13];			//Ӧ�����
		    basefee = tempArr[0][14];			//����Ԥ��
		    freefee = tempArr[0][15];			//�Ԥ��
		    usedpoint = tempArr[0][16];			//���ѻ���
		    base_term = tempArr[0][17];			//��������
		    free_term = tempArr[0][18];			//�����
		    pay_fee   = tempArr[0][19];			//�ֽ�
		    return_fee = tempArr[0][20];	    //����Ԥ���
		    return_term = tempArr[0][21];	    //����Ԥ�������
		    ///////<!-- ningtn add for pos start @  -->
			if(tempArr[0][22] != null && tempArr[0][22].trim().length() > 0){
				payType = tempArr[0][22].trim();
			}else{
				payType = "0";
			}
			Response_time = tempArr[0][23].trim();
			TerminalId = tempArr[0][24].trim();
			Rrn = tempArr[0][25].trim();
			Request_time = tempArr[0][26].trim();
			
			System.out.println("payType : " + payType);
			System.out.println("Response_time : " + Response_time);
			System.out.println("TerminalId : " + TerminalId);
			System.out.println("Rrn : " + Rrn);
			System.out.println("Request_time : " + Request_time);
			///////<!-- ningtn add for pos end @  -->
		}
  }

%>

<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="printAccept"/>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>����Ԥ������</title>
<META content="no-cache" http-equiv="Pragma">
<META content="no-cache" http-equiv="Cache-Control">
<META content="0" 	     http-equiv="Expires" >
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<script type="text/javascript" src="../../npage/s3000/js/S3000.js"></script>
<script language="JavaScript" src="../../npage/s1400/pub.js"></script>
<script language="JavaScript">

<!--
  function frmCfm(){
		/* ningtn add for pos start @  */
		if(document.all.payType.value=="BX")
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
		else if(document.all.payType.value=="BY")
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
		/* ningtn add for pos end @  */
  }
  /* ningtn add for pos start @  */
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
	/* ningtn add for pos start @  */
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
	var sysAccept =<%=printAccept%>;             			//��ˮ��
	var printStr = printInfo(printType);			 		//����printinfo()���صĴ�ӡ����
	var mode_code=null;           							//�ʷѴ���
	var fav_code=null;                				 		//�ط�����
	var area_code=null;             				 		//С������
	var opCode="8380" ;                   			 		//��������
	var phoneNo="<%=phoneNo%>";                  	 		//�ͻ��绰

	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
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

	
	cust_info+="�ֻ����룺"+document.all.phone_no.value+"|";
	cust_info+="�ͻ�������"+document.all.cust_name.value+"|";
	//cust_info+="�ͻ���ַ��"+document.all.cust_addr.value+"|";
	//cust_info+="֤�����룺"+document.all.cardId_no.value+"|";

	opr_info+="ҵ�����ͣ�����Ԥ���--����"+"|";
	opr_info+="�������ƣ�"+document.all.sale_name.value+"|";
  	opr_info+="ҵ����ˮ��"+document.all.login_accept.value+"|";
  	opr_info+="ҵ�����ʱ�䣺<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>"+"|";
  	if(document.all.sum_money.value > 0 )
  	{
  		opr_info+="��Ԥ��"+document.all.sum_money.value+"Ԫ"+"|";
  	}

    retInfo=strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
    return retInfo;	
}


//-->
</script>
</head>
<body>
<form name="frm" method="post" action="f8380_2.jsp" onload="init()">
	<%@ include file="/npage/include/header.jsp" %>
<table cellspacing="0">
	<tr>
		<td class="blue">��������</td>
		<td class="blue" colspan="3"><b>����Ԥ���--����</b></td>
	</tr>
	<tr>
		<td class="blue">�ͻ�����</td>
		<td>
			<input name="cust_name" value="<%=bp_name%>" type="text" class="InputGrey" v_must=1 readonly id="cust_name" maxlength="20">
			<font color="orange">*</font>
		</td>
		<td class="blue">�ͻ���ַ</td>
		<td>
			<input name="cust_addr" value="<%=bp_add%>" type="text" class="InputGrey" v_must=1 readonly id="cust_addr" size="40" maxlength="40" >
			<font color="orange">*</font>
		</td>
	</tr>
	<!--<tr>
		<td class="blue">֤������</td>
		<td>
			<input name="cardId_type" value="<%=cardId_type%>" type="text" class="InputGrey" v_must=1 readonly id="cardId_type" maxlength="20" >
			<font color="orange">*</font>
		</td>
		<td class="blue">֤������</td>
		<td>
			<input name="cardId_no" value="<%=cardId_no%>" type="text" class="InputGrey" v_must=1 readonly id="cardId_no" maxlength="20" >
			<font color="orange">*</font>
		</td>
	</tr>
	-->
	<tr>
		<td class="blue">ҵ��Ʒ��</td>
		<td>
			<input name="sm_code" value="<%=sm_code%>" type="text" class="InputGrey" v_must=1 readonly id="sm_code" maxlength="20" >
			<font color="orange">*</font>
		</td>
		<td class="blue">����״̬</td>
		<td>
			<input name="run_type" value="<%=run_name%>" type="text" class="InputGrey" v_must=1 readonly id="run_type" maxlength="20" >
			<font color="orange">*</font>
		</td>
	</tr>
	<tr>
		<!--<td class="blue">VIP����</td>
		<td>
			<input name="vip" value="<%=vip%>" type="text" class="InputGrey" v_must=1 readonly id="vip" maxlength="20" >
			<font color="orange">*</font>
		</td>
		-->
		<td class="blue">����Ԥ��</td>
		<td colspan="3">
			<input name="prepay_fee" value="<%=prepay_fee%>" type="text" class="InputGrey" v_must=1 readonly id="prepay_fee" maxlength="20" >
			<font color="orange">*</font>
		</td>
	</tr>
	<tr>
	<td class="blue">Ӫ������</td>
	<td>
		<input name="sale_name" value="<%=sale_name%>" type="text" class="InputGrey" v_must=1 readonly id="sale_name" maxlength="50" size="50">
		<font color="orange">*</font>
	</td>
	<td class="blue">Ӧ���ܽ��</td>
	<td >
		<input name="sum_money" type="text" class="InputGrey" id="sum_money" value="<%=sum_pay%>" readonly>
		<font color="orange">*</font>
	</td>
	</tr>
	<tr bgcolor="F5F5F5">
		<input name="price" type="hidden" class="button" id="price" value="<%=mach%>" readonly v_name="������" >
		<td class="blue">����Ԥ��</td>
		<td>
			<input name="Base_Fee" type="text"  class="InputGrey" id="Base_Fee" value="<%=basefee%>" readonly>
		</td>
		<td class="blue">������������</td>
		<td>
			<input name="Base_Term" type="text" class="InputGrey" id="Base_Term" value="<%=base_term%>" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">�Ԥ��</td>
		<td>
			<input name="Free_Fee" type="text"  class="InputGrey" id="Free_Fee" value="<%=freefee%>" readonly>
		</td>
		<td class="blue">���������</td>
		<td>
			<input name="Free_Term" type="text" class="InputGrey" id="Free_Term" value="<%=free_term%>" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">ÿ������Ԥ���</td>
		<td>
			<input name="Return_Fee" type="text" class="InputGrey" id="Return_Fee" value="<%=return_fee%>" readonly>
		</td>
		<td class="blue">����Ԥ�������</td>
		<td>
			<input name="Return_Term" type="text" class="InputGrey" id="Return_Term" value="<%=return_term%>" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">�ֽ�</td>
		<td>
			<input name="Pay_Fee" type="text"  class="InputGrey" id="Pay_Fee" value="<%=pay_fee%>" readonly>
		</td>
		<td class="blue">���ѻ���</td>
		<td>
			<input name="Mark_Subtract" type="text"  class="InputGrey" id="Mark_Subtract" value="<%=usedpoint%>" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">��ע</td>
		<td colspan="3">
			<input name="opNote" type="text" class="InputGrey" readOnly id="opNote" size="60" maxlength="60" value="����Ԥ���--����" >
		</td>
	</tr>
	<tr>
		<td colspan="4" align="center" id="footer"> 
			<input name="confirm" type="button" class="b_foot" index="2" value="ȷ��&��ӡ" onClick="printCommit()">
			&nbsp;
			<input name="reset" type="reset" class="b_foot" value="���" >
			&nbsp;
			<input name="back" onClick="removeCurrentTab()" type="button" class="b_foot" value="�ر�">
			&nbsp; 
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
	<!-- ningtn add for pos start @  -->
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
	<!-- ningtn add for pos start @  -->
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
<!-- **** ningtn add for pos @  ******���ؽ��пؼ�ҳ BankCtrl ******** -->
<%@ include file="/npage/public/posCCB.jsp" %>
<!-- **** ningtn add for pos @  ******���ع��пؼ�ҳ KeeperClient ******** -->
<%@ include file="/npage/public/posICBC.jsp" %>
</html>
