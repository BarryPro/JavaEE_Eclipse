<%
/********************
 version v2.0
 ������: si-tech
 update hejw@2009-1-12
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%
  response.setDateHeader("Expires", 0);
%>
<%
  String opCode = "8046";
  String opName = "Ӫ����ȡ��";
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%

  String loginNo = (String)session.getAttribute("workNo");
  String loginName =  (String)session.getAttribute("workName");
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = (String)session.getAttribute("regCode");

%>
<%
  /****�õ���ӡ��ˮ****/
  String printAccept="";
  printAccept = getMaxAccept();
%>
<%
  String retFlag="",retMsg="";//�����ж�ҳ��ս���ʱ����ȷ��

  String saleName = request.getParameter("saleName");

/****************���ƶ�����\Ӫ�������͵õ����롢���������� ����Ϣ s8046Init***********************/
  //SPubCallSvrImpl impl = new SPubCallSvrImpl();
  //ArrayList retList = new ArrayList();

  String saleType = request.getParameter("saleType");
  String phoneNo = request.getParameter("srv_no");
  String passwordFromSer="";

  String[] paraAray1 = new String[5];
  paraAray1[0] = phoneNo;		/* �ֻ�����   */
  paraAray1[1] = loginNo; 	    /* ��������   */
  paraAray1[2] = orgCode;	    /* ��������   */
  paraAray1[3] = "8046";	    /* ��������   */
  paraAray1[4] = saleType;		/* Ӫ�������� */

  for(int i=0; i<paraAray1.length; i++)
  {
	if( paraAray1[i] == null )
	{
	  paraAray1[i] = "";
	}
  }
  //retList = impl.callFXService("s8046Init", paraAray1, "33","phone",phoneNo);
  String  bp_name="",sm_code="",family_code="",rate_code="",bigCust_flag="",sm_name="",rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",spec_prepay="",other_prepay="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="",group_type_code="",group_type_name="",imain_stream="",next_main_stream="",hand_fee="",favorcode="",card_no="", order_code="", should_fee="",  consume_term="",  mon_base_fee="",  new_rate_code="",new_rate_name="",print_note="";
  String  breach_fee="",year_fee="";
  String loginAccept = "";
  //String[][] tempArr= new String[][]{};

 %>

		<wtc:service name="s8046Init" outnum="33" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paraAray1[0]%>" />
			<wtc:param value="<%=paraAray1[1]%>" />
			<wtc:param value="<%=paraAray1[2]%>" />
			<wtc:param value="<%=paraAray1[3]%>" />
			<wtc:param value="<%=paraAray1[4]%>" />
		</wtc:service>


		<wtc:array id="retList" scope="end" />

<%


  String errCode = code;
  String errMsg = msg;
  if(retList == null)
  {
	if(!retFlag.equals("1"))
	{
	   retFlag = "1";
	   retMsg = "s8046Init��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
    }
  }else if(!(retList == null))
  {
	if (errCode.equals("000000") ){
	    bp_name = retList[0][3];//��������
	    bp_add = retList[0][4];//�ͻ���ַ
	    passwordFromSer = retList[0][2];//����
	    sm_code = retList[0][11];//ҵ�����
	    sm_name = retList[0][12];//ҵ���������
	    hand_fee = retList[0][13];//������
	    favorcode = retList[0][14];//�Żݴ���
	    rate_code = retList[0][5];//�ʷѴ���
	    rate_name = retList[0][6];//�ʷ�����
	    next_rate_code = retList[0][7];//�����ʷѴ���
	    next_rate_name = retList[0][8];//�����ʷ�����
	    bigCust_flag = retList[0][9];//��ͻ���־
	    bigCust_name = retList[0][10];//��ͻ�����
	    spec_prepay = retList[0][15];//ר�����
	    other_prepay = retList[0][16];//�����ֽ����
	    cardId_type = retList[0][17];//֤������
	    cardId_no = retList[0][18];//֤������
	    cust_id = retList[0][19];//�ͻ�id
	    cust_belong_code = retList[0][20];//�ͻ�����id
	    group_type_code = retList[0][21];//���ſͻ�����
	    group_type_name = retList[0][22];//���ſͻ���������
	    imain_stream = retList[0][23];//��ǰ�ʷѿ�ͨ��ˮ
	    next_main_stream = retList[0][24];//ԤԼ�ʷѿ�ͨ��ˮ
	    loginAccept = retList[0][25];//��ˮ
	    System.out.println("loginAccept = " + loginAccept);
	    mon_base_fee = retList[0][26];//�µ�������
	    order_code = retList[0][27];//��������

	  /*tempArr = (String[][])retList.get(28);
	  if(!(tempArr==null)){
	    new_rate_code = tempArr[0][0];//���ײʹ���
	  }

	  tempArr = (String[][])retList.get(29);
	  if(!(tempArr==null)){
	    new_rate_name = tempArr[0][0];//���ײ�����
	  }*/

	    consume_term = retList[0][30];//����ʱ��
	    print_note = retList[0][32];//��������
	  /*
	  year_fee=String.valueOf((double) Double.parseDouble(prepay_fee) - Double.parseDouble(lack_fee));
	  breach_fee=String.valueOf((double) Double.parseDouble(year_fee)*3/10);
	  if ((Double.parseDouble(year_fee))<0)
	  {
	  	year_fee="0.00";
	  	breach_fee="0.00";
	  }*/
	}else{
		if(!retFlag.equals("1"))
		{
		   retFlag = "1";
	       retMsg = "s8046Init��ѯ���������Ϣʧ��!<br>errCode: " + errCode + "<br>errMsg: " + errMsg;
		}
	}
  }

  //******************�õ�����������***************************//
  //comImpl co=new comImpl();
  //�ʷѴ���
  String sqlNewRateCode = "";
  if(saleType.equals("06")||saleType.equals("15")||saleType.equals("16"))
  {
  /*
  	sqlNewRateCode = "select a.mode_code, a.mode_code||'--'||b.mode_name from ssaletype a, sbillmodecode b where a.region_code=b.region_code and a.mode_code=b.mode_code and a.region_code='" + regionCode + "' and a.sm_code='zz' and a.sale_type='" + saleType + "'";*/
  	sqlNewRateCode = "select a.mode_code, a.mode_code || '--' || b.offer_name from ssaletype a, product_offer b where trim(a.mode_code) = to_char(b.offer_id) and a.region_code = '" + regionCode + "' and a.sm_code='zz' and a.sale_type='" + saleType + "'";
  }
  else
  {
  /*
  	sqlNewRateCode = "select a.mode_code, a.mode_code||'--'||b.mode_name from ssaletype a, sbillmodecode b where a.region_code=b.region_code and a.mode_code=b.mode_code and a.region_code='" + regionCode + "' and a.sm_code='" + sm_code + "' and a.sale_type='" + saleType + "'";*/
  	sqlNewRateCode = "select a.mode_code, a.mode_code||'--'||b.offer_name from ssaletype a, product_offer b where trim(a.mode_code)=to_char(b.offer_id) and a.region_code='" + regionCode + "' and a.sm_code='" + sm_code + "' and a.sale_type='" + saleType + "'";
  }

  //ArrayList newRateCodeArr = co.spubqry32("2",sqlNewRateCode);
%>

	 <wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlNewRateCode%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="newRateCodeArr" scope="end"/>

<%


  String[][] newRateCodeStr = newRateCodeArr;


%>
<html>
<head>
<title>Ӫ����ȡ��</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
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

  onload=function()
  {
  }

  //***
  function frmCfm(){
 	frm.submit();
	return true;
  }
  //***//У��
  function check(){

	with(document.frm)
	{
	  if(new_rate_code.value=="")
	  {
	    rdShowMessageDialog("��ѡ�����ʷѴ���!");
		new_rate_code.focus();
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

	with(document.frm)
	{
		if(!forMoney(pay_phone_fee)) return false;
		if(!forMoney(pay_product_fee)) return false;

		if((parseFloat(spec_prepay.value) + parseFloat(other_prepay.value)) < (parseFloat(pay_phone_fee.value) + parseFloat(pay_product_fee.value)))
		{
			rdShowMessageDialog("���û���Ԥ����,���ȽɷѺ��ٰ���!",0);
			return false;
		}
	}

	return true;
  }

  //�����һ����ťʱ,Ϊ��һ��ҳ����֯����
  function setParaForNext(){

    var iOpCode = "8046";//iOpCode
	//iAddStr��ʽ Ӫ�������ʹ���|���ֻ���|������Ʒ��|��ˮ|�ֻ�����|��Ʒ����
	var iAddStr =  "<%=saleType%>|" + document.frm.pay_phone_fee.value + "|" +  document.frm.pay_product_fee.value + "|" + "<%=loginAccept%>|" + document.frm.phone_type.value + "|" + document.frm.product_type.value + "|"; //iAddStr
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
    var i18 =  "<%=next_rate_code + "--" + next_rate_name%>"; //�������ײ�
    var i19 =  "<%=hand_fee%>";//   ������
    var i20 =  "<%=hand_fee%>";  // ���������
    var i8 =   "<%=sm_code+"--"+sm_name%>";  //   ҵ��Ʒ��
    var smcode_xyz =   "<%=sm_name%>";  //   ҵ��Ʒ��
    var do_note = document.frm.opNote.value;// �û���ע
    var favorcode =  "<%=favorcode%>";  // �������Ż�Ȩ��
    var maincash_no = "<%=rate_code%>";//�����ײʹ��루�ϣ�
    var imain_stream = "<%=imain_stream%>"; //��ǰ���ʷѿ�ͨ��ˮ
    var next_main_stream = "<%=next_main_stream%>";//ԤԼ���ʷѿ�ͨ��ˮ
	var beforeOpCode = "1205";//����ʱ���Ͷ�Ӧ����ҵ���opCode

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
		                              "&beforeOpCode="+beforeOpCode +
				                      "&next_main_stream="+next_main_stream;

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
	document.frm.beforeOpCode.value = beforeOpCode;
	document.frm.smcode_xyz.value = smcode_xyz;
	frm.action = "f1270_3.jsp";

  }

  function printCommit(subButton){
	controlButt(subButton);//��ʱ���ư�ť�Ŀ�����
	//У��
	if(!check()) return false;
	setOpNote();//Ϊ��ע��ֵ
	//Ϊ��һ��ҳ����֯���ݲ���
	setParaForNext();
	if("<%=saleType%>"=="07")
		rdShowMessageDialog("���幦����ͨ��12530�����š���վ����ȡ��!");
    //�ύ��
	frmCfm();
	return true;
  }
/******Ϊ��ע��ֵ********/
function setOpNote(){

	if(document.frm.opNote.value=="")
	{
	  	document.frm.opNote.value = "<%=saleName%>ȡ��; �ֻ�����:<%=phoneNo%>";

	}
	return true;

}
function getmidpromt(){
	var newcode=codeChg(document.frm.new_rate_code.value);
	getMidPrompt("10442",newcode,"ipTd");
}

//-->
</script>


</head>


<body>
<form name="frm" method="post"    >
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">Ӫ����ȡ��</div>
	</div>
      <table cellspacing="0">
		  <tr>
		    <td class="blue">�ֻ�����</td>
            <td>
			  <input name="phoneNo" type="text"  id="phoneNo"  value ="<%=phoneNo%>"  Class="InputGrey" readOnly  >
			</td>
		    <td class="blue">��������:</td>
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
		    <td class="blue">֤������:</td>
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
            <td class="blue">ר�����</td>
            <td>
			  <input name="spec_prepay" type="text" class="InputGrey" id="spec_prepay" size="30" value="<%=spec_prepay%>" readonly>
			</td>
			<td class="blue">�����ֽ����</td>
            <td>
			  <input name="other_prepay" type="text" class="InputGrey" id="other_prepay" size="30"  value="<%=other_prepay%>" readonly>
			</td>
          </tr>


		 <tr>
			<td class="blue">���ײʹ���</td>
            <td colspan="3" id="ipTd">
				<select  name="new_rate_code" class="button" onclick="getmidpromt();">
					<option value="">--��ѡ��--</option>
					<%for(int i = 0 ; i < newRateCodeStr.length ; i ++){%>
					<option value="<%=newRateCodeStr[i][0]%>"><%=newRateCodeStr[i][1]%></option>
					<%}%>
				</select>
				<font color="#FF0000">*</font>
			</td>
          </tr>

          <tr>
		    <td class="blue">���ֻ���</td>
            <td>
			   <input name="pay_phone_fee" type="text"  class="button" id="pay_phone_fee" value="0">
			</td>
			<td class="blue">������Ʒ��</td>
            <td>
			  <input name="pay_product_fee" type="text"  class="button" id="pay_product_fee" value="0">
			</td>
          </tr>
		  <tr>
		    <td class="blue">�ֻ�����</td>
            <td>
			   <input name="phone_type" type="text"  class="button" id="phone_type" maxlength="60">
			</td>
			<td class="blue">��Ʒ����</td>
            <td>
			  <input name=product_type" type="text"  class="button" id="product_type" maxlength="60">
			</td>
          </tr>
          <tr >
            <td class="blue">��ע</td>
            <td colspan="3" height="32">
             <input name="opNote" type="text" class="InputGrey" readOnly id="opNote" size="60" maxlength="60" value="" onFocus="setOpNote();">
            </td>
          </tr>
		  <tr>
            <td colspan="4">

            <div align="center">
                &nbsp;
				       <input name="next" id="next" type="button" class="b_foot"  value="��һ��" onClick="printCommit(this)" >
                &nbsp;
                <input name="reset" type="reset" class="b_foot value="���" >
                &nbsp;
                <input name="back" onClick="history.go(-1);" type="button" class="b_foot" value="����">
                &nbsp;

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
  <input type="hidden" name="beforeOpCode">
  <input type="hidden" name="pay_type">
  <input type="hidden" name="smcode_xyz">
  <input type="hidden" name="printAccept">


  <input type="hidden" name="print_note" value="<%=print_note%>"><!--��ӡ�������-->
   <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
