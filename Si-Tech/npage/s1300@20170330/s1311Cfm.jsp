<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-15 ҳ�����,�޸���ʽ
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/common/popup_window.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%
 	//����busy_type������opCode��opName
 	String opCode = "";
	String opName = "";
	String timeResult[][];
  String busy_type= WtcUtil.repNull(request.getParameter("busy_type"));

  /*************add by zhanghonga@2008-09-22,����busy_type������opCode��opName,����ͳһ�Ӵ���opcode,opname��¼����*****************/
  switch(Integer.parseInt(busy_type)){
  	case 1 :
  					opCode = "1302";
  					opName = "����ɷ�";
  					break;
  	case 2 :
  					opCode = "b924";
  					opName = "���ų�Ա�ֻ��˵�����";
  					break;
  	case 3 :
  					opCode = "1304";
  					opName = "�ɷ�(����)";
  					break;
  	case 5 :
  					opCode = "2327";
  					opName = "�ɷ�(�����˺�)";
  					break;
  	default:
  					opCode = "1302";
  					opName = "��ͨ�ɷ�";
  					break;
  }
  System.out.println("########################################s1311Cfm->opCode->"+opCode+"&opName->"+opName);
  /**************add end here******************/


  String phoneNo = request.getParameter("phoneNo");
	String contractno = request.getParameter("contractno");
 	String op_code  =request.getParameter("op_code");
 	String ispopmarket="0";//0 û�о��ֵ�Ӫ����Ϣ������1 �Ѿ��ھ���Ӫ����������Ϣ��������popup_windows
 	String hUserCheckCond = "";		/*�ж��û������Ƿ��*/
 	String hHasCheckCond = "";
	String dVipType = "0";
	String pay_code_num = "0";
	String num = "0";
  if (request.getParameter("ispopmarket") != null) {
     ispopmarket=request.getParameter("ispopmarket");
  }
	System.out.println("000---contractno=["+contractno+"]");
	System.out.println("000---phoneNo=["+phoneNo+"]");

  String[] inParas    = new String[]{""};
	String[] inParas1   = new String[]{""};//«ѧ�20060301add,���ڲ�ѯ����ʱ��
	String[] inParas2   = new String[2];
	String showopentime = "";
	String ret_showflag = "";
	String val_showflag = "";
	int showflag = 0;

	String count_num    = "0";
	String contract_num = "0";
	String busy_name    = "";
	String return_page  = "";
	String contractCount= "-1";
	System.out.println("3232---contractno=["+contractno+"]");
 
	if(busy_type.equals("2")) {

		System.out.println("222---contractno=["+contractno+"]");
		inParas2[0] = "select to_char(nvl(count(*),0)) from dConShort where contract_no = :contract_no";
		inParas2[1]="contract_no="+contractno;
%>
		<wtc:service name="TlsPubSelBoss" routerKey="phone" routerValue="<%=phoneNo%>"  retcode="retCode4" retmsg="retMsg4" outnum="1">
			<wtc:param value="<%=inParas2[0]%>"/>
			<wtc:param value="<%=inParas2[1]%>"/>
		</wtc:service>
		<wtc:array id="result" scope="end" />
<%
		
		if(result!=null){
			if (result.length>0) {
			   count_num = result[0][0];
			}
		}

		System.out.println("count_num=["+count_num+"]");
		if(count_num.equals("0")) {
			inParas2[0] = "select to_char(nvl(count(*),0)) from dconusermsg where contract_no = :contract_no and serial_no='0'";
			inParas2[1]="contract_no="+contractno;
		%>
			<wtc:service name="TlsPubSelBoss" routerKey="phone" routerValue="<%=phoneNo%>"  retcode="retCode4" retmsg="retMsg4" outnum="1">
				<wtc:param value="<%=inParas2[0]%>"/>
				<wtc:param value="<%=inParas2[1]%>"/>
			</wtc:service>
			<wtc:array id="result" scope="end" />
		<%
			
			if(result!=null){
				if (result.length>0) {
				   contract_num = result[0][0];
				}
			}
		}
		System.out.println("contract_num=["+contract_num+"]");
	}
	if(busy_type.equals("2")) {
		busy_name="���ų�Ա�ֻ��˵�����";
		return_page="s1311.jsp";
	}

  String workno = (String)session.getAttribute("workNo");
  String workname = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
  /*tianyang add for pos */
  String groupId = (String)session.getAttribute("groupId");
	String nopass = (String)session.getAttribute("password");
	String regionCode = org_code.substring(0,2);
	String districtCode = org_code.substring(2,4);  // liyan ���Ӳ���Ա��������

		//�Ż���Ϣ
		//����ӪҵԱ�Ż�Ȩ��
    String Delay_Favourable = "readonly";        //a040  ���ɽ���Ż�
    String Predel_Favourable = "readonly";       //a041  ����������Ż�
    String printNote ="0";

    String[][] favInfo = (String[][])session.getAttribute("favInfo");
		String[] favStr = new String[favInfo.length];
		for(int i = 0 ;i < favStr.length; i++){
			favStr[i] = favInfo[i][0].trim();

			if(favStr[i].equals("a040") )    Delay_Favourable = "";
      if(favStr[i].equals("a041"))     Predel_Favourable = "";
			if(favStr[i].equals("a092"))	   printNote ="1";
		}

	String TGroupFlag="" ;
	String TBigFlag  ="";
	String BigFlag = "0";

	StringBuffer accountstr    = new StringBuffer(80);            //���˻��ַ���
	StringBuffer namestr       = new StringBuffer(80);            //���˻������ַ���
	StringBuffer accounttypestr= new StringBuffer(80);            //�ʻ�����
	StringBuffer paytypestr    = new StringBuffer(80);            //���ѷ�ʽ
	StringBuffer shoudpaystr   = new StringBuffer(80);            //Ƿ��

	inParas = new String[6];
	inParas[0] = phoneNo;
	inParas[1] = contractno;
	inParas[2] = busy_type;
	inParas[3] = org_code;
	inParas[4] = nopass;
	inParas[5] = workno;

	String[][] result1  = null ;
	String[][] result2  = null;
	String[][] result3  = null;
	String[][] result4  = null;
	String iretCode = "";
	String iretMsg  = "";

  String[][] result5  = null;
  if(busy_type.equals("2")){
%>
	<wtc:service name="s1300_Valid1" routerKey="region" routerValue="<%=org_code.substring(0,2)%>" retcode="retCode5" retmsg="retMsg5" outnum="22">
	<wtc:param value="<%=inParas[0]%>"/>
	<wtc:param value="<%=inParas[1]%>"/>
	<wtc:param value="<%=inParas[2]%>"/>
	<wtc:param value="<%=inParas[3]%>"/>
	<wtc:param value="<%=inParas[4]%>"/>
	<wtc:param value="<%=inParas[5]%>"/>
	</wtc:service>
	<wtc:array id="sVerifyTypeArr1" start="0" length="10" scope="end"/>
	<wtc:array id="sVerifyTypeArr2" start="10" length="8" scope="end"/>
	<wtc:array id="sVerifyTypeArr3" start="18" length="1" scope="end"/>
	<wtc:array id="sVerifyTypeArr4" start="19" length="3" scope="end"/>
<%
		result1 = sVerifyTypeArr1;
		result2 = sVerifyTypeArr2;
		result3 = sVerifyTypeArr2;
		result4 = sVerifyTypeArr3;
		result5 = sVerifyTypeArr4;

		iretCode = retCode5;
		iretMsg = retMsg5;
	}

	String return_code = "999999";
	String ret_msg = "���÷���ʧ��";
	if(result1!=null&&result1.length>0){
		return_code = result1[0][0];
		ret_msg = result1[0][1];
	}

System.out.println("################################iretCode->"+iretCode+"&&&&iretMsg->"+iretMsg);
System.out.println("aaaaaaaaaaaaaaaaabusy_type="+busy_type);
 if(return_code.equals("000000")||return_code.equals("137111"))
{
 	String return_msg = null;
	String countName  = null;
	String userType   = null;
	String runname    = null;
	String predelFee  = "0";
	String phoneNum   = "1";
	String prepayFee  = "0";
	String contract   = null;
	String belongcode = null;


  String nobillpay  = null;   //δ���˻��ѣ�

  String credit     = null;   //������
	String menu       = null;   //�ײ�����
	String paytype    = null;   //��������


	String busitype   = null;   //ҵ�����
	String curbalanace= null;   //��ǰ�������
	String mhp        = null;   //�и߶˿ͻ�����
	String username   = null;   //�û�����
	String userprop   = null;   //�û�����
	String usernode   = "";     //�û���ע
  String showPrePay = "";     //��ʾԤ��


	double sDeservedFee = 0;    //�ϼ�Ӧ��
	double snobillpay   = 0;
	double sOweFee      = 0;    //Ƿ��
 	double sPayMoney    = 0;    //�ɷ�
	double sPredelFee   = 0;
	double sCredit      = 0;    //���ö�


	double sum_delayfee = 0.00;
	double sum_usefee   = 0.00;
	int flag=0;

 	if (return_code.equals("000000"))
	{

		return_msg = result1[0][1].trim();           //������Ϣ
		countName  = result1[0][2].trim();           //�ʻ�����
		userType   = result1[0][3].trim();           //�ʻ�����
		prepayFee  = result1[0][4].trim();		       //�ʻ�Ԥ���
		runname    = result1[0][5].trim();			     //δ���ʻ���
		phoneNum   = result1[0][6].trim();		       //�ֻ�����
		predelFee	 = result1[0][7].trim();
		contract   = result1[0][8].trim();		 	     //ð�߱�־
		belongcode = result1[0][9].trim();		       //��������

	   if(busy_type.equals("2"))
	   {
        nobillpay =  result4[0][0].trim();
	   }

		for (int i=0; i < result2.length;i++)
		{
			sum_usefee   = sum_usefee   + Double.parseDouble(result2[i][2]);
			sum_delayfee = sum_delayfee + Double.parseDouble(result2[i][3]);
		}

    sPredelFee = Double.parseDouble(predelFee);

		if (nobillpay != null) {
		    snobillpay =   Double.parseDouble(nobillpay);
		}

		if (credit != null) {
		    sCredit = Double.parseDouble(credit);
		}

		sOweFee = sum_delayfee+sum_usefee + sPredelFee + snobillpay - sCredit;
    System.out.println("sOweFee="+sOweFee+",sum_delayfee="+sum_delayfee+",sum_usefee="+sum_usefee+"snobillpay="+snobillpay+",sCredit="+sCredit);

		if (busy_type.equals("2") && result5[0][2].trim().equals("1"))
		{
			System.out.println("����һ���ߵ��ʻ��û��ɷ�");
			sOweFee = Double.parseDouble(result5[0][1]) + sPredelFee + snobillpay - sCredit;
		}

		if (sOweFee<=Double.parseDouble(prepayFee)){
		    sDeservedFee = 0;
		}else{
        sDeservedFee=sOweFee-Double.parseDouble(prepayFee);
    }

		sDeservedFee = (double) Math.round(sDeservedFee*100)/100;  //��������
		sPayMoney =Math.ceil(sDeservedFee);

	}else{//���˻�

		 flag = 1;
		 for(int i = 0; i < result3.length; i++){
	      accountstr.append(result3[i][0].trim());
				accountstr.append(",");

		    namestr.append(result3[i][1].trim());
				namestr.append(" ,");

	      accounttypestr.append(result3[i][2].trim());
				accounttypestr.append(" ,");

				paytypestr.append(result3[i][3].trim());
				paytypestr.append(" ,");

				shoudpaystr.append(result3[i][4].trim());
				shoudpaystr.append(" ,");
	   }
	}


/*���� 2006��12��11�� ����X_HLJMob_CRM_PD3_2006_370��������ҵ����������ʾ��Ϣ������.xls*/

/* dujl add at 20090506 for ���������ڿ�չ�еͶ�Ԥ�����������* start ********* */
	StringBuffer  insql = new StringBuffer();
	//wuxy alter 20090620 ���20���벻��dcustinnet��������
	if(busy_type.equals("1"))
	{
		/*insql.append("select to_char(add_months(open_time,3),'yyyymm'),to_char(sysdate,'yyyymm') ");
		insql.append(" From dcustmsg ");
		insql.append(" where phone_no='?' ");
		System.out.println("insql====="+insql);*/
		inParas2[0]="select to_char(add_months(open_time,3),'yyyymm'),to_char(sysdate,'yyyymm') From dcustmsg where phone_no=:phone_no";
		inParas2[1]="phone_no="+phoneNo;
%>
<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
	<wtc:param value="<%=inParas2[0]%>"/>
	<wtc:param value="<%=inParas2[1]%>"/>
</wtc:service>
<wtc:array id="timeResult1" scope="end" />
<%
	
  timeResult=timeResult1;
}else
	{
		insql.append("select to_char(sysdate,'yyyymm'),to_char(sysdate,'yyyymm') ");
		insql.append("  FROM dual ");
		System.out.println("insql====="+insql);
%>
<wtc:pubselect name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
<wtc:sql><%=insql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="timeResult1" scope="end" />
<%
 timeResult=timeResult1;
	}

/* dujl add at 20090506 for ���������ڿ�չ�еͶ�Ԥ�����������* end ********** */

/*������ 20070508 ����
ԭ��R_HLJMob_cuisr_CRM_PD3_2007_158@���������Ĭ�û����ѵ�����
*/

%>

<!--  ******fengry 20090812 add for �׸�����Ԥ����Ӫ��� begin******  -->
<wtc:service name="s1300Spec" routerKey="phone" routerValue="<%=phoneNo%>" retcode="SpecCode" retmsg="SpecMsg" outnum="4">
<wtc:param value="<%=workno%>"/>
<wtc:param value="<%=phoneNo%>"/>
</wtc:service>
<wtc:array id="SpecResult1" start="0" length="2" scope="end" />
<wtc:array id="SpecResult" start="2" length="2" scope="end" />

<%
	if(SpecCode.equals("130099"))
	{%>
		<script language=javascript>
			rdShowMessageDialog("<%=SpecMsg%>");
		</script>
<%}%>
<!--  ******fengry 20090812 add for �׸�����Ԥ����Ӫ��� end******  -->

<HTML>
<HEAD>
<title>��ͨ�ɷ�</title>
<script language="JavaScript"  src="/npage/s1300/common_1300.js"></script>
</head>
<SCRIPT LANGUAGE="JavaScript">
<!--
/*HARVEST ��÷ 20061031 ���Ϊ�˿�������332 �ж��û�����ʱ����н����*/
/*HARVEST ��÷ 20071030 ���Ϊ�˿�������343 �ж��û�����ʱ����н����*/

onload = function()
{
	init();
	/*xl 20100925 ��ľ˹�ϱ�ҵ���Ż�*/

	document.all.payMoney.focus();
}

function doProcess(packet){
	var num = packet.data.findValueByName("num");
	var giftflag = 	packet.data.findValueByName("giftflag");
	/*tianyang add for pos�ɷ� start*/
	var verifyType = packet.data.findValueByName("verifyType");
	var sysDate = packet.data.findValueByName("sysDate");
	/*tianyang add for pos�ɷ� end*/
	if(num>0){
		rdShowMessageDialog("�û��Ѿ�����λ�������ظ�����!");
		document.frm.pay_note.value="";
		document.frm.pay_note.focus();
		return false;

	}
	if(giftflag=="1"){
		rdShowMessageDialog("�û�����ʱ��Ͳ������Ͷ�Ӧʱ�䲻����������ѡ��!");
		document.frm.pay_note.value="";
		document.frm.pay_note.focus();
		return false;
	}
	/*tianyang add for pos�ɷ� start*/
	if(verifyType=="getSysDate"){
		document.all.Request_time.value = sysDate;
		return false;
	}
	/*tianyang add for pos�ɷ� end*/

}


/* ������˻�, �򵯳�����,���ͻ�ѡ���˻�*/
 function showSelWindow()
 {
		 var h=480;
		 var w=650;
		 var t=screen.availHeight/2-h/2;
		 var l=screen.availWidth/2-w/2;

		 var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
		 var returnValue=window.showModalDialog('getUserCount.jsp?accountstr=<%=accountstr%>&accounttypestr=<%=accounttypestr%>&paytypestr=<%=paytypestr%>&shoudpaystr=<%=shoudpaystr%>',"",prop);

 		 if(returnValue==null)
	   {
        rdShowMessageDialog("��û��ѡ���ʻ���");
        Window.location.href="s1311.jsp";
		 }
		 else
		 {
			  document.frm.contractno.value = returnValue;
				document.frm.action = "s1311Cfm.jsp?ispopmarket=<%=ispopmarket%>";
				document.frm.submit();
		 }

 }

 function init(){

	<%
		if(showflag ==1 ){
	%>
		rdShowMessageDialog("ע������15--25�������пͻ�!");
	<%
		}
  %>

		//�������ȱʡֵ�ǹ淶�е�Ҫ��
		<%
		if ( flag == 1 ){
		%>
			showSelWindow();
    <%
    	}
 		%>

  	if ("<%=runname%>"=="Ԥ��"){
		   rdShowMessageDialog("���û�ΪԤ���û���");
		}



}

function searchUnbillDetail() {
    var h=480;
    var w=650;
   	var t=screen.availHeight/2-h/2;
	  var l=screen.availWidth/2-w/2;

	  var prop = "dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";

	  var returnValue = window.showModalDialog('s1300UnbillDetail.jsp?phone_no=<%=phoneNo%>&contractno=<%=contract%>',"",prop);
}

function searchshowDetail() {
    var h=480;
    var w=650;
   	var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;

		var prop = "dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";

		var returnValue = window.showModalDialog('s1300_dconmsgpre.jsp?contractNo=<%=contract%>',"",prop);
}

//-->
</SCRIPT>

<BODY>
<FORM action="PayCfm1.jsp" method="post" name="frm">
<input type="hidden" name="op_code"  value="<%=op_code%>">
<input type="hidden" name="hUserCheckCond"  value="<%=hUserCheckCond%>">
<input type="hidden" name="hHasCheckCond"  value="<%=hHasCheckCond%>">
<input type="hidden" name="busy_type"  value="<%=busy_type%>">
<input type="hidden" name="unitcode" value="<%=org_code%>">
<input type="hidden" name="sumdelayfee"  value="<%=sum_delayfee%>">
<input type="hidden" name="op_code"  value="<%=op_code%>">
<input type="hidden" name="busy_type"  value="<%=busy_type%>">
<input type="hidden" name="unitcode" value="<%=org_code%>">
<input type="hidden" name="sumusefee"  value="<%=sum_usefee%>">
<input type="hidden" name="unbillfee"  value="<%=nobillpay%>">
<input type="hidden" name="belongcode"  value="<%=belongcode%>">
<input type="hidden" name="count_num"  value="<%=count_num%>">
<input type="hidden" name="contract_num"  value="<%=contract_num%>">
<input type="hidden" name="paySign"  value="">
<!-- dujl add at 20090506 for ���������ڿ�չ�еͶ�Ԥ�����������*****start*****-->
<input type="hidden" name="openTime"  value="<%=timeResult[0][0]%>">
<input type="hidden" name="nowTime"  value="<%=timeResult[0][1]%>">
<!-- dujl add at 20090506 for ���������ڿ�չ�еͶ�Ԥ�����������*****end*******-->

<!-- tianyang add at 20090928 for POS�ɷ�����*****start*****-->
<input type="hidden" name="MerchantNameChs"  value="">
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
<!-- tianyang add at 20090928 for POS�ɷ�����*****end*******-->


<%@ include file="/npage/include/header.jsp" %>

		<div class="title">
			<div id="title_zi">�û���Ϣ</div>
		</div>

              <table cellspacing="0">
              	<tr>
			            <td class="blue">����</td>
			            <td colspan="3"><%=org_code%>&nbsp;</td>
			          </tr>
                <tr>
                  <td class="blue" width="15%">��������</td>
                  <td width="35%">
                    <input type="text" readonly class="InputGrey" name="TbusyName"  value="<%=busy_name%>">
                  </td>
                  <td class="blue" width="15%">��������</td>
                  <td width="35%">
                    <input type="text" readonly class="InputGrey" name="PhoneNum" value="<%=phoneNum%>">
                  </td>
                </tr>
                <tr>
                  <td class="blue">�ʻ�����</td>
                  <td>
                    <input type="text" readonly class="InputGrey" name="contractno" onKeyPress="return isKeyNumberdot(0)" value="<%=contract%>">
                  </td>
                  <td class="blue">�ʻ�����</td>
                  <td>
                    <input type="text" name="countName"  readonly class="InputGrey" value="<%=countName%>">
                  </td>
                </tr>

                <tr id="bat_id">
                  <td class="blue">�û�Ԥ��</td>
                  <td>
                    <input type="text" readonly class="InputGrey" style="color:red" name="showPrePay" value="<%=showPrePay%>">
					<%
						if(busy_type.equals("1")) {
					%>
										<input type="button" class="b_text" name="showdetail" <%if (showPrePay.equals("0.00")) {%> disabled <%}%> class="b_text" value="��ϸ"  onClick="searchshowDetail()">
          <%
          	}
          %>
									</td>
				  				<td class="blue">�ɻ���Ԥ��</td>
                  <td>
                    <input type="text" readonly class="InputGrey" style="color:red" name="prepayFee" value="<%=prepayFee%>">
                  </td>
                </tr>
                <tr id="phoneId">
                  <td class="blue">�������</td>
                  <td>
                    <input type="text" readonly class="InputGrey" name="phoneNo" value="<%=phoneNo%>">
                  </td>
                  <td class="blue">��������</td>
                  <td>
                    <input type="text" readonly class="InputGrey" name="predelFee" value="<%=sPredelFee%>">
                  </td>
                </tr>


				   <%
				    	if(busy_type.equals("2")) {

				   %>
				        <tr id="phoneId">
				             <td class="blue">δ���ʻ���</td>
				             <td class="blue" >
				               <input type="text" readonly class="InputGrey" style="color:red" name="area" value="<%=result4[0][0]%>">
				             </td>
				               <!--20090325 liyan �����Ƿ��-->
				            <% if (result5[0][2].trim().equals("1")) {%>
				             <td class="blue">��ͻ���Ƿ��</td>
				             <td class="blue" ><input type="text" readonly class="InputGrey" name="allOweFee" value="<%=result5[0][1].trim()%>">(���������ɽ�)
 							</td>
				             <% }
				            else{ %>
				            	<td colspan="2">&nbsp;</td>
				            	<%}%>
				        </tr>
					<%
						}
					%>
					</table>

    			<%
    				if(busy_type.equals("1")){
   				%>
 							<table cellspacing="0">
                <tr>
                  <td class="blue" width="15%">δ���ʻ���</td>
                  <td width="35%">
                    <input type="text" readonly class="InputGrey" style="color:red" name="area" value="<%=nobillpay%>">
                	<%
		                 double nobillpaytemp = 0.0;
                     if (nobillpay != null) {
                         nobillpaytemp = Double.parseDouble(nobillpay);
					 						}
	                %>

					<input type="button" class="b_text" name="unbilldetail" <%if (nobillpaytemp == 0.0) {%> disabled <%}%> value="��ϸ" onClick="searchUnbillDetail()">
                  </td>
                  <td class="blue" width="15%">������</td>
                  <td width="35%">
                    <input type="text" readonly class="InputGrey" name="credit"  value="<%=credit%>">
                  </td>
                </tr>
                 <tr>
                  <td class="blue" width="15%">�ײ�����</td>
                  <td width="35%">
                    <input type="text" readonly class="InputGrey" name="menu" value="<%=menu%>">
                  </td>
                  <td class="blue">���ʽ</td>
                  <td>
                    <input type="text" readonly class="InputGrey" name="paytype"  value="<%=paytype%>">
                  </td>
                </tr>

                 <tr>
                  <td class="blue">ҵ��Ʒ��</td>
                  <td>
                    <input type="text" readonly class="InputGrey" name="busitype" value="<%=busitype%>">
                  </td>
                  <td class="blue">��ǰ�������</td>
                  <td>
                    <input type="text" readonly class="InputGrey" style="color:red" name="curbalanace"  value="<%=curbalanace%>">
                  </td>
				  			</tr>

                 <tr>
                  <td class="blue">�и߶˿ͻ�����</td>
                  <td>
                    <input type="text" readonly class="InputGrey" name="mhp" value="<%=mhp%>">
                  </td>
                  <td class="blue">�û�����</td>
                  <td>
                    <input type="text" readonly class="InputGrey" name="username"  value="<%=username%>">
                  </td>
				  			</tr>

                 <tr>
                  <td class="blue">����״̬</td>
                  <td>
                    <input type="text" readonly class="InputGrey" name="runname" value="<%=runname%>">
                  </td>
                  <td class="blue">�ͻ�����</td>
                  <td><input type="text" readonly class="InputGrey" name="userprop" value="<%=userprop%>">
                   </td>
                </tr>
								<tr id="note1">
                  <td class="blue">��������</td>
                  <td>
                    <input type="text" readonly class="InputGrey" name="belongcode" value="<%=belongcode%>">
                  </td>
								<!--  ******fengry 20090812 add for �׸�����Ԥ����Ӫ��� begin******  -->
									<td class="blue" noWrap>����Ԥ����������</td>
									<td noWrap>
										<select name="pay_note" onchange="checktype()">
											<option value="0" selected></option>
											<%for(int i=0; i<SpecResult.length; i++){%>
											<option value="<%=SpecResult[i][0]%>"> <%=SpecResult[i][0]%>--><%=SpecResult[i][1]%></option>
											<%}%>

                  				<%--<wtc:qoption name="sPubSelect_b" outnum="2">
														<wtc:sql>select type_id,type_id||'-->'||type_name from sPayAwardAllow where region_code='<%=regionCode%>' and (district_code='<%=districtCode%>' or district_code='XX')	and sysdate between begin_time and  end_time</wtc:sql>--%>
													<%--<wtc:sql>select type_id,type_id||'-->'||type_name from sPayAwardAllow where region_code='<%=regionCode%>' and sysdate between begin_time and  end_time</wtc:sql>--%>
													<%--</wtc:qoption>--%>
										</select>
									</td>
								<!--  ******fengry 20090812 add for �׸�����Ԥ����Ӫ��� end******  -->
								</tr>
							</table>
							<table cellspacing="0">
								<tr id="note1"><!-- «ѧ�add20060301 begin -->
				          <td class="blue" width="15%" noWrap>����ʱ��</td>
								  <td noWrap>
								  	<input type="text"  readonly class="InputGrey" name="showopentime" value="<%=showopentime%>" size="20" maxlength="20">
								  </td>
				<%
				  if(printNote.equals("1")){
				%>
				  				<td class="blue" width="15%" noWrap>�⳥����</td>
				 					<td width="35%">
										<select name="print_note" >
											<option value="0" selected></option>
											<option value="��˾�⳥����">��˾�⳥����</option>
											<option value="��˾����Ϣ��">��˾����Ϣ��</option>
											<option value="��˾�⳥��Ϣ��">��˾�⳥��Ϣ��</option>
											<option value="SP����Ϣ��">SP����Ϣ��</option>
											<option value="SP����Ϣ��">SP����Ϣ��</option>
										</select>
								  </td>
				<%
							}
				%>
			    			</tr><!-- «ѧ�add20060301 end -->
							</table>
							<table cellspacing="0">
                <tr nowrap>
                  <td class="blue" width="15%">��ע</td>
                  <td>
                    <textarea name="" rows="3" readonly cols="68"><%=usernode%></textarea>
				  				</td>
                </tr>
              </table>
      <%}%>


			<%
					if(flag==0){
			%>

			</div>
			<div id="Operation_Table">
			<div class="title">
				<div id="title_zi">Ƿ����Ϣ</div>
			</div>
              <table cellspacing="0">
                <tr align="center">
                  <th>�������</th>
                  <th>Ƿ����</th>
                  <th>Ƿ�ѽ��</th>
                  <th>���ɽ�</th>
                  <th>Ӧ�ս��</th>
                  <th>�Żݽ��</th>
                  <th>Ԥ�滮��</th>
                  <th>�½���</th>
                </tr>


     <%
     	String tbClass="";
		  for (int i=0;i<result2.length;i++) {
		  		if(i%2==0){
		  			tbClass="Grey";
		  		}
			    if (!result2[0][0].equals("000000")){
			%>
		   <tr align="center">
	            <td class="<%=tbClass%>"><%=result2[i][0]%></td>
	            <td class="<%=tbClass%>"><%=result2[i][1]%></td>
	            <td class="<%=tbClass%>"><%=result2[i][2]%></td>
	            <td class="<%=tbClass%>"><%=result2[i][3]%></td>
	            <td class="<%=tbClass%>"><%=result2[i][4]%></td>
	            <td class="<%=tbClass%>"><%=result2[i][5]%></td>
	            <td class="<%=tbClass%>"><%=result2[i][6]%></td>
	            <td class="<%=tbClass%>"><%=result2[i][7]%></td>
           </tr>
     <%
     			}
     		}
     %>
        </table>
			</div>
							<div id="Operation_Table">
							<div class="title">
								<div id="title_zi">�ɷ���Ϣ</div>
							</div>
              <table cellspacing="0">
                <tr>
                  <td class="blue" noWrap>�ϼ�Ӧ��</td>
                  <td noWrap>
                    <input type="text" name="totalFee" readonly class="InputGrey" value="<%=sDeservedFee%>">
                  </td>
                  <td class="blue" noWrap>���ɽ��Ż���</td>
                  <td noWrap>
                    <input type="text" name="delayRate" maxlength="10" value="0" onBlur="CheckRate(this, '���ɽ��Ż���')"    onKeyPress="return isKeyNumberdot(1)" <%=Delay_Favourable%> >
                  </td>
                  <td class="blue" noWrap>���������Ż���</td>
                  <td noWrap>
                    <input type="text" name="remonthRate" maxlength="10" value="0" onBlur="CheckRate(this, '���������Ż���')"   onKeyPress="return isKeyNumberdot(1)" <%=Predel_Favourable%>>
                  </td>
                </tr>

                <tr>
                  <td class="blue" noWrap>�ɷѷ�ʽ</td>
                  <td noWrap>
                    <select name="moneyType" onClick="selType()">
	                  <option value="0">�ֽ�ɷ�</option>
	                 
                     </select>
                  </td>
                  <td class="blue" noWrap>�ɷѽ��</td>
                  <td noWrap>
                    <input type="text" name="payMoney" maxlength="10"  onKeyPress="return isKeyNumberdot(1)" onKeyDown="if(event.keyCode==13) doprint();">
                    <font class="orange"><b>��<span id ="deservedPay"><%=sPayMoney%>0</span>��</b></font>
				  				</td>
                  <td class="blue" noWrap><input type=button class="b_text" style="cursor:hand" onClick="accountShoudFecth()" value="����">&nbsp;&nbsp;����</td>
                  <td noWrap><input name="shoudfetchmoney" size="5" maxlength="5" class="InputGrey" readOnly></td>
                </tr>

                <tr id="CheckId" style="display:none">
                  <td class="blue" noWrap>���д���</td>
                  <td noWrap>
                    <input name="BankCode" size="12" maxlength="12">
                    <input name="BankName" size="13" onKeyDown="if(event.keyCode==13)getBankCode();" >
                    <input name="bank1CodeQuery" type=button class="b_text" id="bankCodeQuery" style="cursor:hand" onClick="getBankCode()" value=��ѯ >
				  				</td>
                  <td class="blue" noWrap>֧Ʊ����</td>
                  <td noWrap>
                    <input type="text" name="checkNo" maxlength="20" value="" onKeyDown="if(event.keyCode==13)getcheckfee();" onChange="document.frm.currentMoney.value=''">
                    <input name=checkfeequery type=button class="b_text" style="cursor:hand" onClick="getcheckfee()" value=��ѯ>
                   </td>
                  <td class="blue" noWrap>���ý��</td>
                  <td noWrap>
                    <input type="textarea" readonly name="currentMoney">
                  </td>
                </tr>

								<tr id="POS_Id"  style="display:none" cellpadding="4">
                  <td class="blue" noWrap>���п���</td>
                  <td noWrap>
                    <input name="pos_code" size="16" type="text" maxlength="19" value="" onKeyDown="if(event.keyCode==13)getposcode();">
				  				</td>
                  <td class="blue" noWrap>������ˮ��</td>
                  <td colspan="3" noWrap>
                    <input type="text" name="pos_accept" maxlength="6" value="" size="6" onKeyDown="if(event.keyCode==13)getposcode();">
                   </td>
                </tr>

                <tr>
                  <td class="blue" noWrap>��ע��Ϣ</td>
                  <td noWrap colspan="5">
                    <input type="text" name="payNote" size="60" maxlength="50" class="InputGrey" readonly>
                  </td>
                </tr>

                <tr>
                  <td noWrap colspan="6" id="footer">
                    <div align="center">
                      <input type="button" name="print" class="b_foot" value="ȷ��&��ӡ" onClick="return doprint();"  >
                      &nbsp;
                      <input type="button" name="return1" class="b_foot" value="����" onClick="window.location.href='s1311.jsp'">
                      &nbsp;
                      <input type="button" name="close1" class="b_foot" value="�ر�" onClick="parent.removeTab('<%=opCode%>')">
                    </th>
                </tr>
              </table>

					<%@ include file="/npage/include/footer.jsp" %>
     <%
     			}
     %>
	</FORM>


<script language="javascript" >

<!--

var popupWindow  = null;

function popup_window(UserCheckCond)
{
	var i = 0;
	var	varString = "";

	popupWindow = window.open("", "12", "height=400, width=250, top=60,left=770, toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, status=no");
 	popupWindow.document.write("<TITLE>�������ƶ�ҵ������ҳ</TITLE>");
 	popupWindow.document.write("<BODY BGCOLOR=#ffffff>");
	popupWindow.document.write("<h3>�������ƶ�ҵ������ҳ!</h1>");
	popupWindow.document.write("<TABLE height=150 cellSpacing=0 cellPadding=0 width=300 border=0>");
	for(;UserCheckCond.indexOf("|") > 0;)
	{
		varString = UserCheckCond.substring(0,UserCheckCond.indexOf("|"));
		popupWindow.document.write("<TR>�� "+varString+"</TR>");
		UserCheckCond= UserCheckCond.substring(UserCheckCond.indexOf("|")+1,UserCheckCond.length);
	}
	popupWindow.document.write("</TABLE>");
	popupWindow.document.write("<CENTER><INPUT TYPE='BUTTON' VALUE='�ر�' onClick='window.close()'></CENTER>");
	popupWindow.document.write("</BODY>");
	popupWindow.document.write("</HTML>");
	popupWindow.document.close();

}

function popup_window_close()
{
	if (popupWindow != null)
	{
		popupWindow.close();
	}
}

function countPayMoney()
{
   var paymoney ;
   with(document.frm)
	{
	   paymoney = parseFloat(sumusefee.value) +parseFloat(unbillfee.value)+parseFloat(sumdelayfee.value)*(1-parseFloat(delayRate.value))  + parseFloat(predelFee.value)*(1-parseFloat(remonthRate.value)) - parseFloat(prepayFee.value);

		if(document.all.Area!=null){
			paymoney += parseFloat(area.value);
		}
		if(paymoney<0)   paymoney = 0;
        totalFee.value=formatAsMoney(paymoney);
	    payMoney.value = formatAsMoney(Math.ceil(paymoney));

	}
	  document.all.deservedPay.innerText = document.frm.payMoney.value;
}



 function CheckRate(obj , msg)
 {
     var i , j=0;
	 	 var derate = 0;


			if(!dataValid( 'b' , obj.value))
		   {
             rdShowMessageDialog("��������Ч��"+msg);
 	         	 obj.value = 0;
             countPayMoney();
	           obj.focus();
 	           return false;
		    }
		    derate= parseFloat(obj.value);

			if (  derate < 0  ||  derate> 1  )
			{
             rdShowMessageDialog(msg + "ֻ����0��1֮�䣡");
 	           obj.value = 0;
             countPayMoney();
 	           obj.focus();
 	           return false;
			}
        countPayMoney()	;
		return true;

}


 function doCheck()
 {

	 var paymoney;
	 var temp ;

     with(document.frm)
     {

 			 paymoney = payMoney.value;

   			if( paymoney=='')
		   {
               rdShowMessageDialog("�ɷѽ���Ϊ�գ����������� !");
   	           payMoney.focus();
 	           return false;
		    }

			if(!dataValid( 'b' , paymoney))
		   {
               rdShowMessageDialog("���������  "+ paymoney +" , ��������Ч�Ľɷѽ�");
   	           payMoney.focus();
 	           return false;
		    }


			if ( paymoney.indexOf(".")!=-1)
			{
				temp =  paymoney.substring(paymoney.indexOf(".")+1,paymoney.length);
 				if ( temp.length> 2 )
				{
					rdShowMessageDialog("�ɷѽ��С�����ֻ������2λ��");
					payMoney.focus();
					return false;
				}
			}

            if(parseFloat(paymoney) < 0)
		  	{
				rdShowMessageDialog(" �ɷѽ���Ϊ������");
                payMoney.focus();
                return false;
          	}

			if( parseFloat(paymoney) < parseFloat(totalFee.value) ) {
				rdShowMessageDialog("��ע�⣬�˱�ֻ�ǲ��ֽɷѣ��û�����Ƿ�ѣ�");
			}

			if( parseFloat(paymoney)> 100000 ) {
				rdShowMessageDialog("�ɷѽ��ܴ���100,000��");
				payMoney.focus();
                return false;
			}

			if (moneyType.value=="9")
			{

				if(currentMoney.value=="")
				{
					rdShowMessageDialog("��У��֧Ʊ���룡");
				   document.all.checkNo.focus();
				    return false;

				}
				if (parseFloat(currentMoney.value)<parseFloat(paymoney))
				{
					rdShowMessageDialog("��ע�⣬֧Ʊ���㣡");
				   document.all.checkNo.focus();
				   return false;
				}
			}
			if (moneyType.value=="8")
			{
				if(getposcode()==false)
					return false;
			}

              payMoney.value = formatAsMoney(paymoney);
 	}
 }


 function selType()
 {
      with(document.frm)
      {
	        if ( moneyType.value=="9" ){
							POS_Id.style.display="none";
							CheckId.style.display="block";
					}else if(moneyType.value=="8"){
				 			CheckId.style.display = "none";
							POS_Id.style.display="block";
					}else{
							POS_Id.style.display="none";
							CheckId.style.display="none";
					}
		 }

 }


  function conShort()
 {
	rdShowMessageDialog("���ʻ�����Ϊ������븶�ѣ������ýɡ��˷Ѷ��Ž��պ��룡");
	window.open("/npage/s1211/f1771.jsp?contractNo="+document.all.contractno.value,"","width=1000,height=600");
 }

  function doClose()
  {

  	<%
		if (ispopmarket.compareTo("0")==0){
	  %>
 		popup_window_close();
    <%
  	  }
 	  %>
  	window.close();
  }

/*tianyang add POS�ɷ� start*/
function getSysDate()
{
	var myPacket = new AJAXPacket("../s1300/s1300_getSysDate.jsp","���ڻ��ϵͳʱ�䣬���Ժ�......");
	myPacket.data.add("verifyType","getSysDate");
	core.ajax.sendPacket(myPacket);
	myPacket = null;

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
/*tianyang add POS�ɷ� end*/

 function doprint()
 {
 		getAfterPrompt();

   <%
		if (ispopmarket.compareTo("0")==0){
	  %>
 		popup_window_close();
    <%
  	  }
 	  %>
	if(document.frm.payNote.value.trim().len()==0){
		document.frm.payNote.value='<%=val_showflag%>';
	}

	if(document.frm.count_num.value ==0 && document.frm.contract_num.value>=2){
		conShort();
  }

	if(doCheck()==false)
			 return false;

			 var	prtFlag = rdShowConfirmDialog("���νɷѽ��"+document.frm.payMoney.value+"Ԫ,�Ƿ�ȷ���ɷѣ�");
		    if (prtFlag==1)
		    {

		    	/*liyan add pos�� 20090825 */
		    	if(document.frm.moneyType.value=="BX")
		    	{
		    		/*set �������*/
						var transerial    = "000000000000";  	                     //����Ψһ�� ������ȡ��
						var trantype      = "00";                                  //��������
						var bMoney        = document.all.payMoney.value;
						var tranamount    = padLeft(bMoney.replace(".",""),"0",12);//�ɷѽ��
						var tranoper      = "<%=workno%>";                         //���ײ���Ա
						var orgid         = "<%=groupId%>";                        //ӪҵԱ��������
						var trannum       = "<%=phoneNo%>";                        //�绰����
						getSysDate();       /*ȡϵͳʱ��*/
						var respstamp     = document.all.Request_time.value;       //�ύʱ��
						var transerialold = "";			                               //ԭ����Ψһ��,�ڽɷ�ʱ�����
						var org_code      = "<%=org_code%>";                       //ӪҵԱ����

						/* ���� posCCB.jsp �з������� IP���˿ڣ����ڶ˿� */
		    	  SetSysInfo();
		    	  /* ���ÿؼ������в������� */
						BankCtrl.SetTranData(transerial,trantype,tranamount,tranoper,orgid,trannum,respstamp,transerialold,org_code);

						/* ��ť��� */
						document.frm.print.disabled=true;
						document.frm.return1.disabled=true;
						document.frm.close1.disabled=true;

						/*���ÿ�ʼ����*/
						BankCtrl.StratTran();

		    	}
		    	else if(document.frm.moneyType.value=="BY")
					{
						var TransType     = padLeft("05"," ",2);                             /*�������� */
						var bMoney        = document.all.payMoney.value;
						var Amount        = padLeft(bMoney.replace(".",""),"0",12);          /*���׽�� */
						var OldAuthDate   = padLeft(""," ",8);                               /*ԭ�������� */
						var ReferNo       = padLeft(""," ",8);                               /*ԭ����ϵͳ������ */
						var InstNum       = padLeft(""," ",2);                               /*���ڸ������� */
						var oldterid      = padLeft(""," ",15);                              /*ԭ�����ն˺� */
						getSysDate();       /*ȡbossϵͳʱ��*/
						var requestTime   = padLeft(document.all.Request_time.value," ",14); /*�����ύ���� */
						var login_no      = padLeft("<%=workno%>"," ",6);                    /*���ײ���Ա */
						var org_code      = padLeft("<%=org_code%>"," ",9);                  /*ӪҵԱ���� */
						var org_id        = padLeft("<%=groupId%>"," ",10);                  /*ӪҵԱ�������� */
						var phone_no      = padLeft("<%=phoneNo%>"," ",15);                  /*���׽ɷѺ� */
						var toBeUpdate    = padLeft(""," ",100);                             /*Ԥ���ֶ� */
						var inputStr = TransType+Amount+OldAuthDate+ReferNo+InstNum+oldterid+requestTime+login_no+org_code+org_id+phone_no+toBeUpdate;

						/* ���� posICBC.jsp �з������� IP���˿ڣ����ڶ˿� �Լ��������*/
						var str = SetICBCCfg(inputStr);

						if(str.split("|").length==21)
						{
							if (str.split("|")[19] !="00")
							{
								rdShowMessageDialog("���з��ش���!<br>������룺"+str.split("|")[19]+"������Ϣ��"+str.split("|")[0]);
								document.frm.print.disabled=false;
								document.frm.return1.disabled=false;
								document.frm.close1.disabled=false;
							}else{
								document.all.MerchantNameChs.value = str.split("|")[10]+str.split("|")[11]; /*�̻����ƣ���Ӣ��)*/
								document.all.MerchantId.value      = str.split("|")[8];	    /*�̻�����*/
								document.all.TerminalId.value      = str.split("|")[7];	    /*�ն˱���*/
								document.all.IssCode.value         = str.split("|")[14];		/*�����к�*/
								document.all.AcqCode.value         = "ICBC";	              /*�յ��к�*/
								document.all.CardNo.value          = str.split("|")[3];			/*����*/
								document.all.BatchNo.value         = str.split("|")[13];		/*���κ�*/
								document.all.Response_time.value   = str.split("|")[1]+str.split("|")[2];   /*��Ӧ����ʱ��*/
								document.all.Rrn.value             = str.split("|")[6];	    /*�ο���*/
								document.all.AuthNo.value          = "";		                /*��Ȩ��*/
								document.all.TraceNo.value         = str.split("|")[12];		/*��ˮ��*/
								/*�ύʱ�� ͨ������  getSysDate() �Ѿ��õ�*/
								document.all.CardNoPingBi.value    = str.split("|")[4];     /*���׿��ţ����Σ�*/
								document.all.ExpDate.value         = str.split("|")[5];     /*��Ƭ��Ч��*/
								document.all.Remak.value           = str.split("|")[17];    /*��ע��Ϣ*/
								document.all.TC.value              = str.split("|")[9];     /*��Ҫ��ӡ������EMV���ף�оƬ����*/
								frm.submit();
							}
						}else{
							rdShowMessageDialog("����ֵ��������");
							document.frm.print.disabled=false;
							document.frm.return1.disabled=false;
							document.frm.close1.disabled=false;
						}
					}
					else
					{
		    		 document.frm.print.disabled=true;
						 document.frm.return1.disabled=true;
						 document.frm.close1.disabled=true;
						 frm.submit();
						 return true;
		    	}
				}
				else
				{
					return false;
				}
 	}

function getcheckfee()
{
	var bankcode = document.all.BankCode.value;
	var checkno = document.all.checkNo.value;
	if (bankcode=="")
	{
		rdShowMessageDialog("��������ѯ����!");
 	    return false;
	}
	if (trim(checkno)=="")
	{
		rdShowMessageDialog("������֧Ʊ����!");
		document.all.checkNo.value="";
	    document.all.checkNo.focus();
	     return false;
    }
 	var h=480;
	var w=650;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
	var str=window.showModalDialog('getcheckfee.jsp?bankcode='+bankcode+'&checkno='+checkno,"",prop);
	if( str==null )
		{
 	   		rdShowMessageDialog("û���ҵ���֧Ʊ����");
		    document.frm.currentMoney.value = "";
	   		document.frm.checkNo.focus();
	   		return false;
		}

		document.frm.currentMoney.value = str;
 		document.all.print.focus();
	    return true;
 }


function getposcode()
{
	var posCode = document.all.pos_code.value;
	var posAccept = document.all.pos_accept.value;
	if (trim(posCode)=="")
	{
		rdShowMessageDialog("���п��Ų���Ϊ��!");
		document.all.pos_code.value="";
	    document.all.pos_code.focus();
 	    return false;
	}
	if (trim(posAccept)==""||posAccept.length!=6)
	{
		rdShowMessageDialog("����������������ˮ��!");
		document.all.pos_accept.value="";
	    document.all.pos_accept.focus();
	     return false;
    }
	return true ;
}


function accountShoudFecth() {
     var temp1 = document.frm.payMoney.value;
	 var temp2 = document.frm.totalFee.value;
     var temp3 = Math.round((temp1 - temp2)*100)/100;

     document.frm.payMoney.value = document.frm.totalFee.value;
	 document.frm.shoudfetchmoney.value = temp3;
}

function getBankCode()
{
 		 var h=480;
		 var w=650;
		 var t=screen.availHeight/2-h/2;
		 var l=screen.availWidth/2-w/2;

	      var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
          var returnValue=window.showModalDialog('getBankCode.jsp?region_code=<%=org_code.substring(0,2)%>&district_code=<%=org_code.substring(2,4)%>&bank_name='+frm.BankName.value+'&bank_code='+frm.BankCode.value,"",prop);

          document.frm.currentMoney.value='';
 		  if(returnValue==null)
	     {
					rdShowMessageDialog("�����������û�в鵽��Ӧ�����У�");
					document.frm.BankCode.value="";
					document.frm.BankName.value="";
					return false;
		  }

 		  if(returnValue=="")
	     {
					rdShowMessageDialog("��û��ѡ�����У�");
					document.frm.BankCode.value="";
					document.frm.BankName.value="";
					return false;
		  }
		 else
		 {
			 var chPos_str = returnValue.indexOf(",");
			 document.frm.BankCode.value=returnValue.substring(0,chPos_str);
			 document.frm.BankName.value=returnValue.substring(chPos_str+1);
   		 }
}
/***HARVEST  wangmei 20060801 ���*****/
/*HARVEST ��÷ 20061031 ���Ϊ�˿�������332 �ж��û�����ʱ����н����*/

function checktype()
{
	if(document.frm.pay_note.value == "1000"){
		if(document.frm.busitype.value == "���еش�"){
			rdShowMessageDialog("���еش��û�����ѡ����н���ʽ��");
			document.frm.pay_note.value="";
			return false;
		}
	}
	if(document.frm.pay_note.value == "1001"){
		if(document.frm.busitype.value != "���еش�"){
			rdShowMessageDialog("���Ƕ��еش��û�����ѡ����н���ʽ��");
			document.frm.pay_note.value="";
			return false;
		}
	}

	/* wangmei 20070906 ��� ��ȫ��ͨvip�����ƻ�����ж�*/
	if(document.frm.pay_note.value == "1019"){
		if("<%=dVipType%>" == "0"){
			rdShowMessageDialog("�����ꡢ�����ͻ�����ѡ����н���ʽ��");
			document.frm.pay_note.value="";
			return false;
		}
		if("<%=pay_code_num%>" != "0"){
			rdShowMessageDialog("�ͻ������ظ�ѡ����н���ʽ��");
			document.frm.pay_note.value="";
			return false;
		}
		if("<%=num%>" != "0"){
			rdShowMessageDialog("���տͻ�����ѡ����н���ʽ��");
			document.frm.pay_note.value="";
			return false;
		}
	}

// dujl add at 20090506 for ���������ڿ�չ�еͶ�Ԥ�����������******start************
	if((document.frm.pay_note.value == "1039")&&(document.frm.openTime.value > document.frm.nowTime.value))
	{
		rdShowMessageDialog("���û�����ʱ�䲻��3���£����ܲ�����");
		document.frm.pay_note.value="";
		return false;
	}
// dujl add at 20090506 for ���������ڿ�չ�еͶ�Ԥ�����������******end**************


	if(document.frm.pay_note.value == "1021"||document.frm.pay_note.value == "1022"||document.frm.pay_note.value == "1023"){
		var phone_no = document.frm.phoneNo.value;
		var gift_type = document.frm.pay_note.value;
		var open_time = document.frm.showopentime.value;
		var checkPwd_Packet = new AJAXPacket("../s1300/pubCheckGift.jsp","���ڽ����н���Ϣ��ѯ�����Ժ�......");
		checkPwd_Packet.data.add("phone_no",phone_no);
		checkPwd_Packet.data.add("gift_type",gift_type);
		checkPwd_Packet.data.add("open_time",open_time);
		core.ajax.sendPacket(checkPwd_Packet);
		checkPwd_Packet=null;
	}

}

 -->
</script>

<!-- **********���ؽ��пؼ�ҳ BankCtrl ******** -->
<%@ include file="/npage/s1300/posCCB.jsp" %>
<script language="javascript" FOR="BankCtrl" event="Completed()" >
	str = BankCtrl.GetTranData();
	if(str.split("|").length==21)
	{
		if (str.split("|")[6] !="00")
		{
			rdShowMessageDialog("���з��ش���!<br>������룺"+str.split("|")[6]+"��������Ϣ��"+str.split("|")[7]+"��");
			document.frm.print.disabled=false;
			document.frm.return1.disabled=false;
			document.frm.close1.disabled=false;
		}else{
			document.all.MerchantNameChs.value = str.split("|")[9];  /*�̻����ƣ���Ӣ��)*/
			document.all.MerchantId.value      = str.split("|")[10]; /*�̻�����*/
			document.all.TerminalId.value      = str.split("|")[11]; /*�ն˱���*/
			document.all.IssCode.value         = str.split("|")[15]; /*�����к�*/
			document.all.AcqCode.value         = str.split("|")[16]; /*�յ��к�*/
			document.all.CardNo.value          = str.split("|")[8];	 /*����*/
			document.all.BatchNo.value         = str.split("|")[13]; /*���κ�*/
			document.all.Response_time.value   = str.split("|")[5];	 /*��Ӧ����ʱ��*/
			document.all.Rrn.value             = str.split("|")[14]; /*�ο���*/
			document.all.AuthNo.value          = "";                 /*��Ȩ��*/
			document.all.TraceNo.value         = str.split("|")[12]; /*��ˮ��*/
			/*�ύʱ�� ͨ������  getSysDate() �Ѿ��õ�*/
			document.all.CardNoPingBi.value    = getCardNoPingBi(str.split("|")[8]);/*���׿��ţ����Σ�*/
			document.all.ExpDate.value         = "";                 /*��Ƭ��Ч��*/
			document.all.Remak.value           = "";                 /*��ע��Ϣ*/
			document.all.TC.value              = "";                 /*��Ҫ��ӡ������EMV���ף�оƬ����*/
			frm.submit();
		}
	}else{
		rdShowMessageDialog("����ֵ��������");
		document.frm.print.disabled=false;
		document.frm.return1.disabled=false;
		document.frm.close1.disabled=false;
	}

</script>

<!-- **********���ع��пؼ�ҳ KeeperClient ******** -->
<%@ include file="/npage/s1300/posICBC.jsp" %>
</body>
</html>

<%} else { %>
	 <script language="JavaScript">
		rdShowMessageDialog("��ѯ����!<br>������룺'<%=return_code%>'��������Ϣ��'<%=SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(return_code))%>'��");
		window.location.href="<%=return_page%>";
	 </script>
<% } %>

