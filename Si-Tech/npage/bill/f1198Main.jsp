<%
/********************
 version v2.0
������: si-tech
********************/
%>
<%
/********************
 version v2.0
������: si-tech
********************/
%>
<%
  response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>	
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%		
  String opCode = "1198";
  String opName = "�����������ײ���ǩ����";
  
  String loginNo = (String)session.getAttribute("workNo");
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = (String)session.getAttribute("regCode");
%>
<%
  String retFlag="",retMsg="";//�����ж�ҳ��ս���ʱ����ȷ��
/****************���ƶ�����õ����롢���������� ����Ϣ s1198InitEx***********************/
  //SPubCallSvrImpl impl = new SPubCallSvrImpl();
  //ArrayList retList = new ArrayList();
  String[] paraAray1 = new String[4];
  String phoneNo = request.getParameter("srv_no");
  String returnPage = request.getParameter("returnPage");
  String passwordFromSer="";
  
  paraAray1[0] = phoneNo;		/* �ֻ�����   */ 
  paraAray1[1] = loginNo; 	    /* ��������   */
  paraAray1[2] = orgCode;	    /* ��������   */
  paraAray1[3] = "1198";	    /* ��������   */
  for(int i=0; i<paraAray1.length; i++)
  {		
	if( paraAray1[i] == null )
	{
	  paraAray1[i] = "";
	}
  }
  //retList = impl.callFXService("s1198InitEx", paraAray1, "33","phone",phoneNo);
%>
  <wtc:service name="s1198Init" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="33" >
	<wtc:param value="<%=paraAray1[0]%>"/>
    <wtc:param value="<%=paraAray1[1]%>"/>
	<wtc:param value="<%=paraAray1[2]%>"/>
	<wtc:param value="<%=paraAray1[3]%>"/>
  </wtc:service>
  <wtc:array id="tempArr" scope="end"/>
<%
  String  bp_name="",sm_code="",family_code="",rate_code="",bigCust_flag="",sm_name="",rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="",prepay_fee="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="",group_type_code="",group_type_name="",imain_stream="",next_main_stream="",hand_fee="",favorcode="",card_no="", order_code="", should_fee="",  consume_term="",  mon_base_fee="",  new_rate_code="",new_rate_name="",print_note="";
  //String[][] tempArr= new String[][]{};
  String errCode = retCode1;
  String errMsg = retMsg1;
  System.out.println("errCode========="+errCode);
  System.out.println("errMsg========="+errMsg);
  if(tempArr[0][1] == null)
  {
	if(!retFlag.equals("1"))
	{
	   retFlag = "1";
	   retMsg = "s1198InitEx��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
    }    
  }else if(!(tempArr[0][1] == null))
  {
	if (errCode.equals("000000")){
	 
	    bp_name = tempArr[0][3];//��������
	
	    bp_add = tempArr[0][4];//�ͻ���ַ
	 
	    passwordFromSer = tempArr[0][2];//����
	  
	    sm_code = tempArr[0][11];//ҵ�����
	 
	    sm_name = tempArr[0][0];//ҵ���������
	 
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
	
	    should_fee = tempArr[0][25];//Ԥ�����
	 
	    mon_base_fee = tempArr[0][26];//�µ�������
	 
	    order_code = tempArr[0][27];//��������
	 
	    new_rate_code = tempArr[0][28];//���ײʹ���
	 
	    new_rate_name = tempArr[0][29];//���ײ�����
	 
	    consume_term = tempArr[0][30];//����ʱ��
	  
	    print_note = tempArr[0][32];//��������
	 
	}else{
		if(!retFlag.equals("1"))
		{
		   retFlag = "1";
	       retMsg = "s1198Init��ѯ���������Ϣʧ��!<br>errCode: " + errCode + "<br>errMsg: " + errMsg;
		}
	}
  }

%>
<head>
<title>�����������ײ���ǩ����</title>
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
	var now_rate_code = "<%=rate_code%>";
    var next_rate_code = "<%=next_rate_code%>";
	var new_rate_code = document.frm.new_rate_code.value;
    

	return true;
  }

  //�����һ����ťʱ,Ϊ��һ��ҳ����֯����
  function setParaForNext(){ 
    var iOpCode = "1198";//iOpCode
	//iAddStr��ʽ �������� ����Ԥ�� �� �� �� ��������
	var iAddStr =  document.frm.order_code.value + "|" + document.frm.should_fee.value + "|" +  document.frm.mon_base_fee.value + "|" + document.frm.consume_term.value + "|" ; //iAddStr
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
    var i18 =  "<%=next_rate_code + "--" + next_rate_name%>"; //�������ײͣ�
    var i19 =  "<%=hand_fee%>";//   ������
    var i20 =  "<%=hand_fee%>";  // ���������
    var i8 =   "<%=sm_code+"--"+sm_name%>";  //   ҵ��Ʒ��
    var do_note = document.frm.opNote.value;// �û���ע��
    var favorcode =  "<%=favorcode%>";  // �������Ż�Ȩ��
    var maincash_no = "<%=rate_code%>";//�����ײʹ��루�ϣ�
    var imain_stream = "<%=imain_stream%>"; //��ǰ���ʷѿ�ͨ��ˮ
    var next_main_stream = "<%=next_main_stream%>";//ԤԼ���ʷѿ�ͨ��ˮ	
	var beforeOpCode = "1200";//����ʱ���Ͷ�Ӧ����ҵ���opCode
/*
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
	
	alert(str); */
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
	frm.action = "f1270_3.jsp";
  }

  function printCommit(subButton){
  	getAfterPrompt();
	//controlButt(subButton);//��ʱ���ư�ť�Ŀ�����
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
		if ("<%=regionCode%>"=="03")
			document.frm.opNote.value = "����ҵ�������ǩ����;"+document.frm.order_code.value; 
		else
			document.frm.opNote.value = "������ǩ����;"+document.frm.phoneNo.value+";"+document.frm.order_code.value; 
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
			<div id="title_zi">�����������ײ���ǩ����</div>
		</div>        

      <table>
		  <tr>
		    <td class="blue">�ֻ�����</td>
            <td>
			  <input name="phoneNo" type="text" class="InputGrey" id="phoneNo" value="<%=phoneNo%>" readonly> 
			</td> 
		    <td class="blue">��������</td>
            <td width="34%">
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
		    <td class="blue">֤������</td>
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
			  <input name="rate_name" type="text" class="InputGrey" id="rate_name" value="<%=rate_code+"--"+rate_name%>" readonly>
			</td>
			<td class="blue">�������ײ�</td>
            <td>
			  <input name="next_rate_name" type="text" class="InputGrey" id="next_rate_name" value="<%=next_rate_code+"--"+next_rate_name%>" readonly>
			</td>             
          </tr>
		  <tr> 
            <td class="blue">δ���ʻ���</td>
            <td>
			  <input name="lack_fee" type="text" class="InputGrey" id="lack_fee" value="<%=lack_fee%>" readonly >
            </td>
            <td class="blue">����Ԥ��</td>
            <td>
			  <input name="prepay_fee" type="text" class="InputGrey" id="prepay_fee" value="<%=prepay_fee%>" readonly>
			</td>
          </tr>
		  <tr>
			<td class="blue">��������</td>
            <td colspan="3">
			   <input name="order_code" type="text" class="InputGrey" id="order_code" value="<%=order_code%>" readonly>
			</td> 			
          </tr>
		  <tr>
		    <td class="blue">Ԥ���</td>
            <td>
			   <input name="should_fee" type="text" class="InputGrey" id="should_fee" value="<%=should_fee%>" readonly>
			</td>
			<td class="blue">��������</td>
            <td>
			  <input name="consume_term" type="text" class="InputGrey" id="consume_term" value="<%=consume_term%>" readonly>
			</td>  
          </tr>
		  <tr> 
            <td class="blue">�µ���</td>
            <td>
			  <input name="mon_base_fee" type="text" class="InputGrey" id="mon_base_fee" value="<%=mon_base_fee%>"   readonly>
			</td>
			<td class="blue">���ײʹ���</td>
            <td>
			  <input name="new_rate_code_1" type="text" class="InputGrey" id="new_rate_code_1" value="<%=new_rate_code + "--" + new_rate_name%>"   readonly>
			</td>            
          </tr>
          <tr style="display:none"> 
            <td  class="blue">��ע</td>
            <td colspan="3">
             <input name="opNote" type="text" class="button" id="opNote" size="60" maxlength="60" value="" onFocus="setOpNote();"> 
            </td>
          </tr>
		  <tr> 
            <td colspan="4"> <div align="center">              
				<input name="next" id="next" type="button" class="b_foot"   value="��һ��" onClick="printCommit(this)" >             
                <input name="reset" type="reset" class="b_foot" value="���" >             
                <input name="back"  type="button" class="b_foot" value="����" onClick="history.go(-1);">             
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
  <input type="hidden" name="new_rate_code" value="<%=new_rate_code%>">
  <input type="hidden" name="pay_type">
  <input type="hidden" name="return_page" value="<%=returnPage%>">	
  <input type="hidden" name="print_note" value="<%=print_note%>"><!--��ӡ�������-->
  <%@ include file="/npage/include/footer.jsp" %>   
</form>
</body>
</html>
