<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����: Ԥ�����ֻ������ѹ�������� 8043
   * �汾: 1.0
   * ����: 2009/2/6
   * ����: leimd
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%
  	String opCode="8043";
	String opName="Ԥ�����ֻ������ѹ��������";
	String loginNo = (String)session.getAttribute("workNo");					//��������
	String orgCode = (String)session.getAttribute("orgCode");					//��������
	String regionCode = (String)session.getAttribute("regCode");				//����

	/****�õ���ӡ��ˮ****/
	String printAccept="";
	printAccept = getMaxAccept();
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="loginAccept"/>
<%
  	String  retFlag="",retMsg="";
	String  bp_name="",sm_code="",family_code="",rate_code="",bigCust_flag="",sm_name="";
	String  rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="";
	String  total_prepay="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="";
	String  group_type_code="",group_type_name="",imain_stream="",next_main_stream="",hand_fee="";
	String  favorcode="",card_no="",print_note="";
	String  gift_code="",gift_grade="",gift_name="";
	String  base_fee="",free_fee="";
	String  mark_subtract="",consume_term="",mon_base_fee="",prepay_fee="";
	String  oSecondPhone="",oSecondName="",oModeCodeSm="",oBlackCode="";
  /**** ningtn add for pos start ****/
  String  payType="",Response_time="",TerminalId="",Rrn="",Request_time="";
  /**** ningtn add for pos end ****/
  	String iPhoneNo = request.getParameter("srv_no");
  	String iLoginNoAccept = request.getParameter("backaccept");
  	String iOpCode = request.getParameter("opcode");
//  	String[][] tempArr= new String[][]{};
	String  inputParsm [] = new String[5];
	inputParsm[0] = iPhoneNo;
	inputParsm[1] = loginNo;
	inputParsm[2] = orgCode;
	inputParsm[3] = iOpCode;
	inputParsm[4] = iLoginNoAccept;
	System.out.println("phoneNO === "+ iPhoneNo);

	String sqlStr = "select res_info from wawarddata where flag = 'Y' and phone_no = '"+iPhoneNo+"'"+
		    " and login_accept="+iLoginNoAccept ;

//  ArrayList retArray = co.sPubSelect("1",sqlStr);
%>
	<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="1" retcode="retCode2" retmsg="retMsg2">
		<wtc:sql><%=sqlStr%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result" scope="end" />
<%
  if(result != null && result.length > 0)
  {
	  String awardName = result[0][0];

	  System.out.println("awardName2="+awardName);
	  if(!awardName.equals("")){
%>
	  <script language="JavaScript" >

	  rdShowMessageDialog("���û����ڴ���Ʒͳһ�����н���<%=awardName%>�콱������д���Ʒͳһ������������ȷ����Ʒ���");
		location='f8044_login.jsp';
		</script>
<%
		}
  }

//  ArrayList retList = new ArrayList();
//  retList = co.callFXService("s8043Init", inputParsm, "41","phone",iPhoneNo);
%>
	<wtc:service name="s8043Init" routerKey="region" routerValue="<%=regionCode%>" outnum="46" retcode="retCode1" retmsg="retMsg1">
		<wtc:param value="<%=inputParsm[0]%>"/>
		<wtc:param value="<%=inputParsm[1]%>"/>
		<wtc:param value="<%=inputParsm[2]%>"/>
		<wtc:param value="<%=inputParsm[3]%>"/>
		<wtc:param value="<%=inputParsm[4]%>"/>
	</wtc:service>
	<wtc:array id="tempArr" scope="end"/>
<%
	String errCode = retCode1;
	String errMsg = retMsg1;

  if(tempArr == null)
  {
	   retFlag = "1";
	   retMsg = "s8043InitEx��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
  }
  else
  {
	  if (errCode.equals("000000")&tempArr.length>0 ){
		    bp_name = tempArr[0][3];           			//��������
		    bp_add = tempArr[0][4];            			//�ͻ���ַ
		    sm_code = tempArr[0][11];         			//ҵ�����
		    sm_name = tempArr[0][12];        			//ҵ���������
		    hand_fee = tempArr[0][13];      			//������
		    favorcode = tempArr[0][14];     			//�Żݴ���
		    rate_code = tempArr[0][5];     				//�ʷѴ���
		    rate_name = tempArr[0][6];    				//�ʷ�����
		    next_rate_code = tempArr[0][7];				//�����ʷѴ���
		    next_rate_name = tempArr[0][8];				//�����ʷ�����
		    bigCust_flag = tempArr[0][9];				//��ͻ���־
		    bigCust_name = tempArr[0][10];				//��ͻ�����
		    lack_fee = tempArr[0][15];					//��Ƿ��
		    total_prepay = tempArr[0][16];				//��Ԥ��
		    cardId_type = tempArr[0][17];				//֤������
		    cardId_no = tempArr[0][18];					//֤������
		    cust_id = tempArr[0][19];					//�ͻ�id
		    cust_belong_code = tempArr[0][20];			//�ͻ�����id
		    group_type_code = tempArr[0][21];			//���ſͻ�����
	    	group_type_name = tempArr[0][22];			//���ſͻ���������
	    	imain_stream = tempArr[0][23];				//��ǰ�ʷѿ�ͨ��ˮ
	    	next_main_stream = tempArr[0][24];			//ԤԼ�ʷѿ�ͨ��ˮ
	    	oSecondPhone = tempArr[0][25];				//��������
	    	gift_code = tempArr[0][26];					//Ӫ������
	    	gift_name = tempArr[0][27];					//��������
	    	oSecondName= tempArr[0][28];				//������
	    	base_fee = tempArr[0][29];					//����Ԥ��
	    	free_fee = tempArr[0][30];					//����Ԥ��
	    	mark_subtract = tempArr[0][31];				//�ۼ�����
	    	consume_term = tempArr[0][32];				//��������
	    	mon_base_fee = tempArr[0][33];				//�µ���
	    	prepay_fee = tempArr[0][34];				//Ԥ���ܽ��
	    	print_note = tempArr[0][37];				//����
	    	oBlackCode = tempArr[0][39];				//����
	    	oModeCodeSm = tempArr[0][40];				//����
	    	
  			/*** ningtn add for pos start ***/	   	 
				payType       = tempArr[0][41].trim();
				Response_time = tempArr[0][42].trim();
				TerminalId    = tempArr[0][43].trim();
				Rrn           = tempArr[0][44].trim();
				Request_time  = tempArr[0][45].trim();
				System.out.println("--------------------------payType-----------------"+payType);
				System.out.println("--------------------------Response_time-----------"+Response_time);
				System.out.println("--------------------------TerminalId--------------"+TerminalId);
				System.out.println("--------------------------Rrn---------------------"+Rrn);
				System.out.println("--------------------------Request_time------------"+Request_time);
				/*** ningtn add for pos end ***/
	 }
	  else{%>
	 <script language="JavaScript">
<!--
  	rdShowMessageDialog("������룺<%=errCode%>������Ϣ��<%=errMsg%>",0);
  	 history.go(-1);
  	//-->
  </script>
<%	 }
	}
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Ԥ�����ֻ������ѹ��������</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language="JavaScript">
<!--
  //��ӡʹ�ñ���
  var modedxpay ="";
  var goodbz    ="";
  var bdbz      ="";
  var bdts      ="";
  var exeDate   ="";
  onload=function()
  {
  	document.all.phoneNo.focus();
   	self.status="";
   }

  function frmCfm()
  {
         if(!checkElement(document.all.phoneNo)) return;
         document.frm.iAddStr.value=document.frm.backaccept.value+"|"+document.frm.Gift_Code.value+"|"+document.frm.Prepay_Fee.value+"|"+
	                        document.frm.Base_Fee.value+"|"+document.frm.Free_Fee.value+"|"+
	                        document.frm.Mark_Subtract.value+"|"+document.frm.Consume_Term.value+"|"+document.frm.Mon_Base_Fee.value+"|"+
	                        document.frm.Gift_Name.value+"|"+document.frm.oSecondPhone.value+"|"+document.frm.oSecondName.value+"|"+
	                        document.frm.oblack_code.value+" "+document.frm.omodecode_sm.value+"|";
	// alert(document.frm.iAddStr.value);
		            frm.submit();

  }
//Ԥ�滻�ֻ������ѹ��������
function printInfo()
{
	 var cust_info="";
	 var opr_info="";
	 var note_info1="";
	 var note_info2="";
	 var note_info3="";
	 var note_info4="";
	  var begin_time='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

	    var retInfo = "";
	    /********������Ϣ��**********/
      cust_info+="�ͻ�������" +document.all.i4.value+"|";
      cust_info+="�ֻ����룺"+document.all.phoneNo.value+"|";
      cust_info+="�ͻ���ַ��"+document.all.i5.value+"|";
      cust_info+="֤�����룺"+document.all.i7.value+"|";
      cust_info+="�������ƣ�"+document.all.oSecondName.value+"|";
      cust_info+="�������룺"+document.all.oSecondPhone.value+"|";
      /********������**********/
      opr_info+="ҵ�����ͣ�Ԥ�����ֻ������ѹ��������"+"|";
      if(goodbz=="Y"){
      opr_info+="ҵ����ˮ��"+"<%=printAccept%>"+"       �������ѽ�"+modedxpay+"Ԫ"+"|";
      }else{
      opr_info+="ҵ����ˮ��"+"<%=printAccept%>"+"|";
      }
      opr_info+="���������ʷѣ�"+"<%=next_rate_code%>"+"|";
      opr_info+="�ֻ��ͺţ�"+document.all.Gift_Name.value+"|";
      opr_info+="�˿�ϼƣ�"+document.all.Prepay_Fee.value+"Ԫ��������Ԥ�滰�ѣ�"+document.all.Base_Fee.value+"Ԫ������Ԥ�滰��"+document.all.Free_Fee.value+"Ԫ��"+"|";
      /*******��ע��**********/
	  	if(bdbz=="Y"){
      	note_info1+=bdts+"|";
      }else{
	  	note_info1+=" "+"|";
	  	}
	  /**********������*********
      if(document.all.modestr.value.length>0){
      note_info1+="���ʷ���Чʱ����ȡ���Ŀ�ѡ�ʷ�:"+document.all.modestr.value+"|";
      }else{
      note_info1+=" "+"|";
      }
      */
        if(goodbz=="Y"){
			note_info1+="��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��"+"|";
		}
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	    return retInfo;
}
function showPrtDlg(printType,DlgMessage,submitCfm)
{  //��ʾ��ӡ�Ի���

	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;

	var printStr = printInfo();
	var old_code = "<%=rate_code%>"; //���ʷѴ���
	var new_code = "<%=next_rate_code%>"; //���ʷѴ���
	var pType="subprint";              // ��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
	var billType="1";               //  Ʊ�����ͣ�1���������2��Ʊ��3�վ�
	var sysAccept="<%=printAccept%>";               // ��ˮ��
	var mode_code=codeChg(new_code)+"~";               //�ʷѴ���
	var fav_code=null;                 //�ط�����
	var area_code=null;             //С������
	var opCode="1270";                   //��������
	var phoneNo=document.all.i1.value;                  //�ͻ��绰
     var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
      var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
	  path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+document.all.phoneNo.value+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;

	 var ret=window.showModalDialog(path,printStr,prop);
     return ret;
}

//-->
</script>

</head>

<body>
	<form name="frm" method="post" action="f1270_3.jsp" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>
		<input name="oSmCode" type="hidden" class="button" id="oSmCode" value="<%=sm_code%>">
		<input name="oModeCode" type="hidden" class="button" id="oModeCode" value="<%=rate_code%>">
		<input type="hidden" name="back_flag_code" value="">
		<input type="hidden" name="loginAccept" value="<%=loginAccept%>">
	<div class="title">
		<div id="title_zi">ҵ����ϸ</div>
	</div>
	<table cellspacing="0">
		<tr>
			<td class="blue">�ֻ�����</td>
            <td>
				<input class="InputGrey" type="text" v_must="1" v_type="mobphone" v_must=1 name="phoneNo" id="phoneNo" onBlur="if(this.value!=''){if(checkElement(document.all.phoneNo)==false){return false;}}" maxlength=11 index="3" value="<%=iPhoneNo%>" readonly >
			</td>
			<td class="blue">��������</td>
			<td width="39%">
				<input name="oCustName" type="text" class="InputGrey" id="oCustName" value="<%=bp_name%>" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">ҵ��Ʒ��</td>
            <td>
				<input name="oSmName" type="text" class="InputGrey" id="oSmName" value="<%=sm_name%>" readonly>
			</td>
            <td class="blue">�ʷ�����</td>
            <td>
				<input name="oModeName" type="text" class="InputGrey" id="oModeName" value="<%=rate_name%>" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">
				�ʺ�Ԥ��
			</td>
            <td>
				<input name="oPrepayFee" type="text" class="InputGrey" id="oPrepayFee" value="<%=total_prepay%>" readonly>
			</td>
            <td class="blue">
            	Ӫ������
            </td>
            <td>
            	<input type="text" name="Gift_Code" value="<%=gift_code%>" readonly class="InputGrey" >
							<input name="oMarkPoint" type="hidden"  id="oMarkPoint" value=""  >
			</td>
		</tr>
		<tr>
			<td class="blue">
				��������
			</td>
            <td>
				<input name="oSecondPhone" type="text"   id="oSecondPhone" value="<%=oSecondPhone%>" readonly  class="InputGrey" >
			</td>
            <td class="blue">
            	��������
            </td>
            <td>
            	<input type="text" name="oSecondName" value="<%=oSecondName%>"  readonly  class="InputGrey"  >
			</td>
		</tr>

		<tr>
			<input name="Gift_Grade" type="hidden" class="InputGrey" id="Gift_Grade" value="<%=gift_grade%>" readonly >
            <td class="blue">
            	����
            </td>
            <td>
				<input name="Gift_Name" type="text" class="InputGrey" id="Gift_Name" value="<%=gift_name%>" readonly>
			</td>
			<td class="blue">
				����Ԥ��
			</td>
            <td>
				<input name="Base_Fee" type="text" class="InputGrey" id="Base_Fee" readonly value="<%=base_fee%>">
			</td>
		</tr>


		<tr>
            <td class="blue">
            	����Ԥ��
            </td>
            <td>
				<input name="Free_Fee" type="text" class="InputGrey" id="Free_Fee"  value="<%=free_fee%>" readonly>
			</td>
			<td class="blue">
				�ۼ�����
			</td>
            <td>
				<input name="Mark_Subtract" type="text" class="InputGrey" id="Mark_Subtract"  value="<%=mark_subtract%>" readonly>
			</td>
		</tr>
		<tr>
            <td class="blue">
            	��������
            </td>
            <td>
            	<input name="Consume_Term" type="text" class="InputGrey" id="Consume_Term"  value="<%=consume_term%>" readonly>
			</td>
			<td class="blue">
				�����µ���
			</td>
            <td>
				<input name="Mon_Base_Fee" type="text" class="InputGrey" id="Mon_Base_Fee" value="<%=mon_base_fee%>" readonly>
			</td>
		</tr>
		<tr>
            <td class="blue">
            	Ԥ���ܽ��
            </td>
            <td colspan="3">
            	<input name="Prepay_Fee" type="text" class="InputGrey" id="Prepay_Fee" value="<%=prepay_fee%>" readonly>
			</td>
		</tr>
		<tr>
			<td colspan="4" align="center" id="footer">
                &nbsp;
				<input name="commit" id="commit" type="button" class="b_foot" value="��һ��" onClick="frmCfm();">
                &nbsp;
                <input name="reset" type="reset" class="b_foot" value="���" >
                &nbsp;
                <input name="close" onClick="removeCurrentTab();" type="button" class="b_foot" value="�ر�">
                &nbsp;
			</td>
		</tr>
	</table>

			<input type="hidden" name="iOpCode" value="8043">
			<input type="hidden" name="loginNo" value="<%=loginNo%>">
			<input type="hidden" name="orgCode" value="<%=orgCode%>">
			<input type="hidden" name="opName" value="<%=opName%>">
	    <!--���²�����Ϊ��f1270_3.jsp������Ĳ���
			i2:�ͻ�ID
			i16:��ǰ���ײʹ���
			ip:�������ײʹ���
			belong_code:belong_code
			print_note:��������

			i1:�ֻ�����
			i5:�ͻ���ַ
			i6:֤������
			i7:֤������
			i8:ҵ��Ʒ��

			ipassword:����
			group_type:���ſͻ����
			ibig_cust:��ͻ����
			do_note:�û���ע
			favorcode:�������Ż�Ȩ��
			maincash_no:�����ײʹ��루�ϣ�
			imain_stream:��ǰ���ʷѿ�ͨ��ˮ
			next_main_stream:ԤԼ���ʷѿ�ͨ��ˮ

			i18:�������ײ�
			i19:������
			i20:���������

			beforeOpCode:ԭҵ������op_code
			-->
			<input type="hidden" name="i2" value="<%=cust_id%>">
			<input type="hidden" name="i16"  value="<%=rate_code%>">
			<input type="hidden" name="ip" 	value="<%=next_rate_code%>">

			<input type="hidden" name="belong_code" value="<%=cust_belong_code%>">
			<input type="hidden" name="print_note" value="<%=print_note%>">
			<input type="hidden" name="iAddStr" value="">

			<input type="hidden" name="i1" value="<%=iPhoneNo%>">
			<input type="hidden" name="i4" value="<%=bp_name%>">			
			<input type="hidden" name="i5" value="<%=bp_add%>">
			<input type="hidden" name="i6" value="<%=cardId_type%>">
			<input type="hidden" name="i7" value="<%=cardId_no%>">
			<input type="hidden" name="i8" value="<%=sm_code%>--<%=sm_name%>">

			<input type="hidden" name="ipassword" value="">
			<input type="hidden" name="group_type" value="<%=group_type_code%>--<%=group_type_name%>">
			<input type="hidden" name="ibig_cust" value="<%=bigCust_flag%>--<%=bigCust_name%>">
			<input type="hidden" name="do_note" value="<%=iPhoneNo%>Ԥ�����ֻ����ѹ��������">
			<input type="hidden" name="favorcode" value="<%=favorcode%>">
			<input type="hidden" name="maincash_no" value="<%=rate_code%>">
			<input type="hidden" name="imain_stream" value="<%=iLoginNoAccept%>">
			<input type="hidden" name="next_main_stream" value="<%=next_main_stream%>">

			<input type="hidden" name="i18" value="<%=next_rate_code%>--<%=next_rate_name%>">
			<input type="hidden" name="i19" value="<%=hand_fee%>">
			<input type="hidden" name="i20" value="<%=hand_fee%>">

			<input type="hidden" name="beforeOpCode" value="8042">
			<input type="hidden" name="backaccept" value="<%=iLoginNoAccept%>">
			<input type="hidden" name="oblack_code" value="<%=oBlackCode%>">
			<input type="hidden" name="omodecode_sm" value="<%=oModeCodeSm%>">
			<input type="hidden" name="printAccept" value="<%=printAccept%>">
			<input type="hidden" name="return_page" value="/npage/bill/f8043_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>">
			<!-- ningtn add at 20100201 for POS�ɷ�����*****start*****-->
			<input type="hidden" name="payType" value="<%=payType%>" >
			<input type="hidden" name="Response_time" value="<%=Response_time%>" >
			<input type="hidden" name="TerminalId" value="<%=TerminalId%>" >
			<input type="hidden" name="Rrn" value="<%=Rrn%>" >
			<input type="hidden" name="Request_time" value="<%=Request_time%>" >
			<!-- ningtn add at 20100201 for POS�ɷ�����*****end*****-->
			<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
