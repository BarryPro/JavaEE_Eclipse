<%
/********************
 version v2.0
������: si-tech
********************/
%>

<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="java.util.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%		
  String opCode = "1257";
	String opName = "�������";		 
  String loginNo = (String)session.getAttribute("workNo");
  String loginName = (String)session.getAttribute("workName");
  String powerCode= (String)session.getAttribute("powerCode");
  String orgCode = (String)session.getAttribute("orgCode");
  String ip_Addr = (String)session.getAttribute("ipAddr");
  String regionCode = orgCode.substring(0,2);
  String loginNoPass = (String)session.getAttribute("password");   
%>
<%
  String retFlag="",retMsg="";//�����ж�ҳ��ս���ʱ����ȷ��
/****************���ƶ�����õ����롢���������� ����������Ϣ����Ϣ s1257Init***********************/
  //SPubCallSvrImpl impl = new SPubCallSvrImpl();
  //ArrayList retList = new ArrayList();
  String[] paraAray1 = new String[4];
  String phoneNo = request.getParameter("srv_no");
  String flag = request.getParameter("flag");//1--����  2--ȡ��
  String passwordFromSer="";

  paraAray1[0] = phoneNo;		/* �ֻ�����   */ 
  paraAray1[1] = loginNo; 	/* ��������   */
  paraAray1[2] = orgCode;	/* ��������   */
  paraAray1[3] = "1257";	/* ��������   */
  for(int i=0; i<paraAray1.length; i++)
  {		
	if( paraAray1[i] == null )
	{
	  paraAray1[i] = "";
	}
  }
  //retList = impl.callFXService("s1257Init", paraAray1, "36","phone",phoneNo);
%>
<wtc:service name="s1257Init" routerKey="phone" routerValue="<%=phoneNo%>" outnum="38" retmsg="errMsg" retcode="errCode">
		<wtc:param value="<%=paraAray1[0]%>"/>
		<wtc:param value="<%=paraAray1[1]%>"/>
		<wtc:param value="<%=paraAray1[2]%>"/>
		<wtc:param value="<%=paraAray1[3]%>"/>			
</wtc:service>
<wtc:array id="tempArr" scope="end" />
<%
for(int i=0;i<tempArr.length;i++){
	for(int j=0;j<tempArr[i].length;j++){
		System.out.println("tempArr["+i+"]["+j+"]"+tempArr[i][j]);
	}
}
  String  bp_name="",sm_code="",family_code="",rate_code="",op_type="2",bigCust_flag="",sm_name="",rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="",prepay_fee="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="",group_type_code="",group_type_name="",imain_stream="",next_main_stream="",hand_fee="",favorcode="",card_no="",prepay_act_fee="",prepay_year_fee="",begin_time="",end_time="",leave_fee="",before_rate_code="",before_rate_name="",pay_type="",old_accept="",contract_no="",print_note="";
	System.out.println("######################ZHANGHONGA->errCode"+errCode);
  if(!errCode.equals("000000"))
  {
	if(!retFlag.equals("1"))
	{
	   retFlag = "1";
	   retMsg = "s1257Init��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg: " + errMsg;
    }    
  }else if(!(tempArr == null))
  {
	if (errCode.equals("0")||errCode.equals("000000") ){
	    bp_name = tempArr[0][3];//��������
	    bp_add = tempArr[0][4];//�ͻ���ַ
	    passwordFromSer = tempArr[0][2];//����
	    sm_code = tempArr[0][11];//ҵ�����
	    sm_name = tempArr[0][12];//ҵ���������
	    hand_fee = tempArr[0][13];//������
	    favorcode = tempArr[0][14];//�Żݴ���
	    rate_code = tempArr[0][5];//�ʷѴ���
	    rate_name = tempArr[0][6];//�ʷ�����
	    next_rate_code = tempArr[0][7];//�����ʷѴ���
	    next_rate_name = tempArr[0][8];//�����ʷ�����
	    bigCust_flag = tempArr[0][9];//��ͻ���־
	    bigCust_name = tempArr[0][10];//��ͻ�����
	    lack_fee = tempArr[0][15];//��Ƿ��
	    prepay_fee = tempArr[0][16];//��Ԥ��
	    cardId_type = tempArr[0][17];//֤������
	    cardId_no = tempArr[0][18];//֤������
	    cust_id = tempArr[0][19];//�ͻ�id
	    cust_belong_code = tempArr[0][20];//�ͻ�����id
	    group_type_code = tempArr[0][21];//���ſͻ�����
	    group_type_name = tempArr[0][22];//���ſͻ���������
	    imain_stream = tempArr[0][23];//��ǰ�ʷѿ�ͨ��ˮ
	    next_main_stream = tempArr[0][24];//ԤԼ�ʷѿ�ͨ��ˮ
	    prepay_year_fee = tempArr[0][25];//������
	    prepay_act_fee = tempArr[0][26];//ʵ�ɽ��  
	    begin_time = tempArr[0][27];//��ʼʱ��
	    end_time = tempArr[0][28];//����ʱ��
	    before_rate_code = tempArr[0][29];//�������ǰ�ʷѴ���
	    before_rate_name = tempArr[0][30];//�������ǰ�ʷ�����
	    leave_fee = tempArr[0][32];//ʣ����
	    pay_type = tempArr[0][33];//���ѷ�ʽ
	    old_accept = tempArr[0][34];//������ˮ
	    contract_no = tempArr[0][35];//����ר���˻�
	    print_note = tempArr[0][25];//��������
	}else{
		if(!retFlag.equals("1"))
	    {
	      retFlag = "1";
	      retMsg = "s1257Init��ѯ���������Ϣʧ��!<br>errCode:"+errCode+"<br>errMsg:" + errMsg;
        } 	
	}
  }
//********************�õ�ӪҵԱȨ�ޣ��˶����룬�������Ż�Ȩ��*****************************//   
   //�Ż���Ϣ
  String[][] favInfo = (String[][])session.getAttribute("favInfo");   //���ݸ�ʽΪString[0][0]---String[n][0]
  boolean pwrf = false;//a272 ��������֤
  String handFee_Favourable = "readonly";        //a230  ������
  int infoLen = favInfo.length;
  String tempStr = "";
  for(int i=0;i<infoLen;i++)
  {
    tempStr = (favInfo[i][0]).trim();
    if(tempStr.compareTo("a272") == 0)
    {
      pwrf = true;
    }
	if(tempStr.compareTo(favorcode) == 0)
    {
      handFee_Favourable = "";
    }
  }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title><%=opName%></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script type="text/javascript" src="../../npage/s3000/js/S3000.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/npage/s1400/pub.js"></script>
 
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
  	//getMidPrompt("10442","<%=rate_code%>","old_rate");
  	//getMidPrompt("10442","<%=next_rate_code%>","new_rate");
  } 
  
  //***
  function frmCfm(){
 	frm.submit();
	return true;
  }
  //***//У��
  function check(){
	var now_rate_code = "<%=rate_code%>";
    var next_rate_code = "<%=next_rate_code%>";
	var before_rate_code = "<%=before_rate_code%>";
    if(now_rate_code==next_rate_code && now_rate_code==before_rate_code){
	  rdShowMessageDialog("��ǰ�ʷѡ������ʷѡ�����ǰ�ʷ����߲�����ȫ��ͬ����ȷ��!");
	  return false;
	}
	return true;
  }

  //�����һ����ťʱ,Ϊ��һ��ҳ����֯����
  function setParaForNext(){
    var iOpCode = "1257";//iOpCode    pay_type|year_fee|ʵ��Ԥ���|���� 
	//iAddStr��ʽ pay_type|year_fee|prepay_fee|iOldAccept|iContractNo|iOpType  
	var iAddStr = "<%=pay_type%>" +"|" + document.frm.prepay_year_fee.value + "|" + "0" + "|" + "<%=old_accept%>" + "|" + "<%=contract_no%>" + "|" + "D";//iAddStr
	var belong_code = "<%=cust_belong_code%>"; //belong_code 
    var i2 =  "<%=cust_id%>"  ; //�ͻ�ID
    var i16 = "<%=rate_code+"--"+rate_name%>";//�����ײʹ��루�ϣ�
    var ip = "<%=before_rate_code%>";//�������ײʹ���(��)
    var i1 = document.frm.phoneNo.value;//  �ֻ�����
    var i4 = "<%=bp_name%>";//  �ͻ�����
    var i5 = "<%=bp_add%>";//  �ͻ���ַ
    var i6 = "<%=cardId_type%>";//   ֤������
    var i7 = "<%=cardId_no%>";//  ֤������
    var ipassword = ""; // ����
    var group_type = "<%=group_type_code+"--"+group_type_name%>";//���ſͻ����
    var ibig_cust = "<%=bigCust_flag+"--"+bigCust_name%>";// ��ͻ����
    var i18 =  "<%=next_rate_code + "--" + next_rate_name%>"; //�������ײͣ�
    var i19 =  "<%=hand_fee%>";//   ������
    var i20 =  "<%=hand_fee%>";  // ���������
    var i8 =   "<%=sm_code+"--"+sm_name%>";  //   ҵ��Ʒ��
    var do_note = document.frm.opNote.value;// �û���ע��
    var favorcode =  "<%=favorcode%>";  // �������Ż�Ȩ��
    var maincash_no = "<%=rate_code%>";//�����ײʹ��루�ϣ�
    var imain_stream = "<%=imain_stream%>"; //��ǰ���ʷѿ�ͨ��ˮ
    var next_main_stream = "<%=next_main_stream%>";//ԤԼ���ʷѿ�ͨ��ˮ	old_accept,contract_no
	var old_accept = "<%=old_accept%>";//������ˮ
	var contract_no = "<%=contract_no%>";//����ר���˻�

	/*var str = "iOpCode="+iOpCode+
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
				                      "&next_main_stream="+next_main_stream;
	
	alert(str);*/
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
	frm.action = "f1270_3_year.jsp";
  }

  function printCommit(subButton){
	controlButt(subButton);//��ʱ���ư�ť�Ŀ�����
	//У��
	if(!check()) return false;
	setOpNote();//Ϊ��ע��ֵ
	//Ϊ��һ��ҳ����֯���ݲ���
	setParaForNext();
    //�ύ��
    frmCfm();	
	return true;
  }
/******Ϊ��ע��ֵ********/
function setOpNote(){
	if(document.frm.opNote.value=="")
	{
	  document.frm.opNote.value = "����;"+document.frm.phoneNo.value+";��ǰ:<%=rate_code%>;����ǰ:<%=before_rate_code%>"; 
	}
	return true;
}

//-->
</script>

</head>
<body>
<form name="frm" method="post">
<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">�ͻ���Ϣ</div>
	</div>
      <table cellspacing="0"  >
		  <tr>
		    <td class="blue">�ֻ�����</td>
            <td>
			  <input name="phoneNo" type="text" Class="InputGrey" id="phoneNo" value="<%=phoneNo%>" readonly> 
			</td> 
		    <td class="blue">��������</td>
            <td>
			  <input name="bp_name" type="text" Class="InputGrey" id="bp_name" value="<%=bp_name%>" readonly>			  
			</td>           
          </tr>
          <tr> 
		    <td class="blue">ҵ������</td>
            <td>
			  <input name="sm_name" type="text" Class="InputGrey" id="sm_name" value="<%=sm_code + "--" + sm_name%>" readonly>
			</td>
            <td class="blue">��ͻ���־</td>
            <td>
			<input name="bigCust_flag" type="text" Class="InputGrey" id="bigCust_flag" value="<%=bigCust_flag+"--"+bigCust_name%>" readonly>
			</td>            
          </tr>
          <tr> 
            <td  class="blue" >��ǰ���ײ�</td>
            <td id="old_rate">
			  <input name="rate_name" type="text" Class="InputGrey" id="rate_name" size="30" value="<%=rate_code+"--"+rate_name%>" readonly>
			</td>
			<td  class="blue" >�������ײ�</td>
            <td id="new_rate">
			  <input name="next_rate_name" type="text" Class="InputGrey" id="next_rate_name" size="30"  value="<%=next_rate_code+"--"+next_rate_name%>" readonly >
			</td>             
          </tr>
		  <tr> 
            <td class="blue">δ���ʻ���</td>
            <td>
			  <input name="lack_fee" type="text" Class="InputGrey" id="lack_fee" value="<%=lack_fee%>" readonly >
            </td>
            <td class="blue">��Ԥ��</td>
            <td>
			  <input name="prepay_fee" type="text" Class="InputGrey" id="prepay_fee" value="<%=prepay_fee%>" readonly>
			</td>
          </tr>
		  <tr>
            <td class="blue">��ʼʱ��</td>
            <td>
			   <input name="begin_time" type="text" Class="InputGrey" id="begin_time" value="<%=begin_time%>"  readonly>
			</td>
			<td class="blue">����ʱ��</td>
            <td>
			  <input name="end_time" type="text" Class="InputGrey" id="end_time" value="<%=end_time%>" readonly>
			</td> 
          </tr>		  
		  <tr>
            <td class="blue">������</td>
            <td>
			   <input name="prepay_year_fee" type="text" Class="InputGrey" id="prepay_year_fee"  value="<%=prepay_year_fee%>"  readonly>
			</td>
			<td>&nbsp;</td>
            <td>&nbsp; </td> 
          </tr>	
		  <tr>
            <td class="blue">����ǰ�ʷ�</td>
            <td>
			   <input name="before_rate_code" type="text" Class="InputGrey" id="before_rate_code" size="30" value="<%=before_rate_code + "--" + before_rate_name%>"  readonly>
			</td>
			<td class="blue">ʣ����</td>
            <td>
			  <input name="leave_fee" type="text" Class="InputGrey" id="leave_fee" value="<%=leave_fee%>" readonly>
			</td> 
          </tr>	
          <tr> 
            <td class="blue">��ע</td>
            <td colspan="3" height="32">
             <input name="opNote" type="text" id="opNote" size="60" maxlength="60" class="InputGrey" readonly> 
            </td>
          </tr>
		  <tr> 
            <td colspan="4"> <div align="center"> 
                &nbsp; 
				<input name="next" id="next" type="button" class="b_foot"   value="��һ��" onClick="printCommit(this)">
                &nbsp; 
                <input name="reset" type="reset" class="b_foot" value="���" >
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
  <input type="hidden" name="new_rate_code">

  <input type="hidden" name="print_note" value="<%=print_note%>">
  <%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>

