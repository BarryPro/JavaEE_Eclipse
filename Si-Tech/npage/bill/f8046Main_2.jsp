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
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%

  String loginNo = (String)session.getAttribute("workNo");
  String loginName =  (String)session.getAttribute("workName");
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = (String)session.getAttribute("regCode");
  String printAccept = getMaxAccept();

%>
<%
  String retFlag="",retMsg="";//�����ж�ҳ��ս���ʱ����ȷ��

  String saleName = request.getParameter("saleName");

/****************���ƶ�����\Ӫ�������͵õ����롢���������� ����Ϣ s804601Init***********************/
  //SPubCallSvrImpl impl = new SPubCallSvrImpl();
  //ArrayList retList = new ArrayList();
  String[] paraAray1 = new String[5];
  String saleType = request.getParameter("saleType");
  String phoneNo = request.getParameter("srv_no");
  String passwordFromSer="";
  String yhje="";

  paraAray1[0] = phoneNo;		    /* �ֻ�����   */
  paraAray1[1] = loginNo; 	    /* ��������   */
  paraAray1[2] = orgCode;	      /* ��������   */
  paraAray1[3] = "8046";	      /* ��������   */
  paraAray1[4] = saleType;		  /* Ӫ�������� */

  for(int i=0; i<paraAray1.length; i++)
  {
	if( paraAray1[i] == null )
	{
	  paraAray1[i] = "";
	}
  }
  //retList = impl.callFXService("s804601Init", paraAray1, "33","phone",phoneNo);
  String  bp_name="",sm_code="",rate_code="",bigCust_flag="",sm_name="",rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",spec_prepay="",other_prepay="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="",group_type_code="",group_type_name="",imain_stream="",next_main_stream="",hand_fee="",favorcode="",card_no="", order_code="", should_fee="",  consume_term="",  mon_base_fee="",  new_rate_code="",new_rate_name="",print_note="";
  String  breach_fee="",year_fee="";
  String  loginAccept = "";
  //String[][] tempArr= new String[][]{};
  %>
  
  	<wtc:service name="s804601Init" outnum="33" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
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
	   retMsg = "s804601Init��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
    	}    
  }else if(!(retList == null))
  {
	if (errCode.equals("000000") )
	{   bp_name = retList[0][3];//��������
	    bp_add = retList[0][4];//�ͻ���ַ
	    passwordFromSer = retList[0][2];//����
	    sm_code = retList[0][11];//ҵ�����
	    sm_name = retList[0][12];//ҵ���������
	    hand_fee = retList[0][13];//������
	    favorcode = retList[0][14];//�Żݴ���
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
	    consume_term = retList[0][30];//����ʱ��
	    print_note = retList[0][32];//��������
	 	}else{
		if(!retFlag.equals("1"))
		{
		   retFlag = "1";
	       retMsg = "s804601Init��ѯ���������Ϣʧ��!<br>errCode: " + errCode + "<br>errMsg: " + errMsg;
		}
	     }
  }
if (saleType.equals("38"))
{
%>
	<wtc:service name="se720Select" outnum="2" 
			retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=phoneNo%>" />
	</wtc:service> 
	<wtc:array id="arrMoney" scope="end" />
	<%
	if(arrMoney.length == 0)
	{

		System.out.println("zhangyan~~~errCode~"+code1+"~~~~~~msg1~~"+msg1+"~~~~~~~~~~~~~~");
		 	%>
		rdShowMessageDialog("��ѯ�Żݽ��Ϊ��!errCode: " +"<%=code1%>" + "errMsg:" + "<%=msg1%>" , 1);
	<%}   
	else
	{
		yhje=arrMoney[0][0];
	}
}
%>


	
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>


<script language="JavaScript">

  <%if(retFlag.equals("1")){%>
    rdShowMessageDialog("<%=retMsg%>");
    history.go(-1);
  <%}%>
	window.onload=function()
  {
  		if("<%=saleType%>"=="37") {
  			 $('#pay_phone_fee').addClass("InputGrey").attr('readonly','readonly');
  		}
  }

  function frmCfm()
  {
 	frm.submit();
	return true;
  }
  //***//У��
  function check()
  {
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

/*--------------------------������У�麯��--------------------------*/

function checknum(obj1,obj2)
{
    var num2 = parseFloat(obj2.value);
    var num1 = parseFloat(obj1.value);

    if(num2<num1)
    {
        var themsg = "'" + obj1.v_name + "'���ô���'" + obj2.value + "'���������룡";
        rdShowMessageDialog(themsg,0);
        obj1.focus();
        return false;
    }
    return true;
}

  function printCommit()
  {
	//У��
	setOpNote();//Ϊ��ע��ֵ
	if(!check()) return false;
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

	var h=210;
	var w=400;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;

   var printStr = printInfo(printType);

   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";



     var pType="subprint";                  // ��ӡ����print ��ӡ subprint �ϲ���ӡ
     var billType="1";                      //  Ʊ������1���������2��Ʊ��3�վ�
     var sysAccept =<%=printAccept%>;       // ��ˮ��
     var printStr = printInfo(printType);   //����printinfo()���صĴ�ӡ����
     var mode_code=null;                    //�ʷѴ���
     var fav_code=null;                     //�ط�����
     var area_code=null;                    //С������
     var opCode =   "<%=opCode%>";                         //��������
     var phoneNo = <%=activePhone%>;                            //�ͻ��绰
     /* ningtn */
    var iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
		var accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" +$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();
     /* ningtn */

    var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm+"&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr;
		var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+document.frm.phoneNo.value+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);
}
function printInfo(printType)
{
	var pay_phone_fee = document.frm.pay_phone_fee.value;//���ֻ���
	var pay_product_fee = document.frm.pay_product_fee.value;//������Ʒ��
	var pay_fee = (parseFloat(pay_phone_fee) + parseFloat(pay_product_fee)) + "";

		var retInfo = "";
		var note_info1 = "";
		var note_info2 = "";
		var note_info3 = "";
		var note_info4 = "";
		var opr_info = "";
		var cust_info = "";


		cust_info+="�ֻ����룺"+<%=phoneNo%>+"|";
		cust_info+="�ͻ�������"+document.frm.bp_name.value+"|";
		cust_info+="֤�����룺"+"<%=cardId_no%>"+"|";
		cust_info+="�ͻ���ַ��"+'<%=bp_add%>'+"|";

		opr_info+="�û�Ʒ�ƣ�"+"<%=sm_name%>"+"      "+"����ҵ��:"+"Ӫ����ȡ��"+"|";
		opr_info+="������ˮ��"+"<%=printAccept%>"+"|";
		if("<%=saleType%>"=="38") 
		{
			opr_info+="�ͻ��轻�ɵĲ����Żݽ�"+"<%=yhje%>"+"|";			
		}
		else
		{
			opr_info+="�ͻ��轻�ɵĲ��ֻ��������Ʒ��ϼƣ�"+pay_fee+"|";
		}
		/****************liujian ���Ӫ�������Ա�����Լ�ƻ����������������� begin********************/

		if("<%=saleType%>"=="37") {
			note_info1+="����Ԥ�滰����δ�������ǰ�������ظ������ҵ��ͬʱ���ܰ�������ǩԼ���ն�Ӫ��������ҵ����ǰ������ȡ������ΥԼ�涨��Ҫ��Ԥ�����۳������͵Ļ��ѣ�����ʣ��Ԥ����30%����ΥԼ��"+"|";
		}
		else if("<%=saleType%>"=="38") {
			note_info1+="�ڱ�ҵ����ǰ����ȡ�����������������Ҫ�˻�Ӫ�����ڼ�ȫ���Ѿ����ܵ���ͨ�ŷ����Żݣ���Ϊȡ��ҵ���ΥԼ��"+"|";
		}	
		else if("<%=saleType%>"=="39") {

		}	
		else {
	note_info1+="����Ԥ�滰����δ�������ǰ�������ظ������ҵ��ͬʱ���ܰ�������ǩԼ���ն�Ӫ��������ҵ����ǰ������ȡ������ΥԼ�涨�����Żݼ۹�����ֻ������ֻ�ԭ�۲���������ʣ��Ԥ����30%����ΥԼ��"+"|";
		}
		/****************liujian ���Ӫ�������Ա�����Լ�ƻ����������������� end********************/
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
  retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //�ѡ�#"�滻Ϊurl��ʽ

    return retInfo;


}


/******Ϊ��ע��ֵ********/
  function setOpNote()
  {
	if(document.frm.opNote.value=="")
	{
	  	document.frm.opNote.value = "<%=saleName%>ȡ��; �ֻ�����:<%=phoneNo%>";
	}
		return true;
  }

</script>


</head>


<body>
<form name="frm" action = "f8046Cfm.jsp" method="post"    >
<%@ include file="/npage/include/header.jsp" %> 
	<div class="title">
		<div id="title_zi">Ӫ����ȡ��</div>
	</div>
      <table cellspacing="0" >
		  <tr>
		    <td class="blue">�ֻ�����</td>
            <td>
			  <input name="phoneNo" type="text"   id="phoneNo" value="<%=phoneNo%>"  Class="InputGrey" readonly>
			</td>
		    <td class="blue">��������</td>
            <td>
			  <input name="bp_name" type="text"   id="bp_name" value="<%=bp_name%>"  Class="InputGrey" readonly>
			</td>
          </tr>
          <tr >
		    <td class="blue">ҵ��Ʒ��:</td>
            <td>
			  <input name="sm_name" type="text"   id="sm_name" value="<%=sm_code + "--" + sm_name%>"  Class="InputGrey" readonly>
			</td>
            <td class="blue">��ͻ���־</td>
            <td>
			<input name="bigCust_flag" type="text"   id="bigCust_flag" value="<%=bigCust_flag+"--"+bigCust_name%>"  Class="InputGrey" readonly>
			</td>
          </tr>
		  <tr >
		    <td class="blue">֤������:</td>
            <td>
			  <input name="cardId_type" type="text"   id="cardId_type" value="<%=cardId_type%>"   Class="InputGrey" readonly>
			</td>
            <td class="blue">֤������</td>
            <td>
			<input name="cardId_no" type="text"   id="cardId_no" value="<%=cardId_no%>"  Class="InputGrey" readonly>
			</td>
          </tr>
          <tr >
            <td class="blue">ר�����</td>
            <td>
			  <input name="spec_prepay" type="text"   id="spec_prepay" size="30" value="<%=spec_prepay%>"  Class="InputGrey" readonly>
			  <input name="rate_name" type="hidden"   id="rate_name" size="30" value="<%=rate_code+"--"+rate_name%>"  Class="InputGrey" readonly>
			  <input name="next_rate_name" type="hidden"   id="next_rate_name" size="30"  value="<%=next_rate_code+"--"+next_rate_name%>"  Class="InputGrey" readonly>
			</td>
			<td class="blue">�����ֽ����</td>
            <td>
			  <input name="other_prepay" type="text"   id="other_prepay" size="30"  value="<%=other_prepay%>"  Class="InputGrey" readonly>
			</td>
          </tr>
           <tr >
		    <td class="blue">���ֻ���</td>
            <td>
			   <input name="pay_phone_fee" type="text"    id="pay_phone_fee" value="0">
			</td>
			<td class="blue">������Ʒ��</td>
            <td>
			  <input name="pay_product_fee" type="text"    id="pay_product_fee" value="0">
			</td>
          </tr>
		  <tr >
		    <td class="blue">�ֻ�����</td>
            <td>
			   <input name="phone_type" type="text"    id="phone_type" maxlength="60">
			</td>
			<td class="blue">��Ʒ����</td>
            <td>
			  <input name="product_type" type="text"   id="product_type" maxlength="60"><!--huangrong �޸� ����f8046Cfm.jsp��ò�����Ʒ���͵�ֵ 2011-1-10-->
			</td>
          </tr>
          <tr  >
            <td class="blue">��ע</td>
            <td colspan="3" height="32">
             <input name="opNote" type="text"   id="opNote" size="60" maxlength="60" value="" onFocus="setOpNote();">
            </td>
          </tr>
		  <tr >
<jsp:include page="/npage/public/hwReadCustCard.jsp">
	<jsp:param name="hwAccept" value="<%=printAccept%>"  />
	<jsp:param name="showBody" value="01"  />
</jsp:include>
            <td colspan="4" > <div align="center">
                &nbsp;
			       	<input name="next" id="next" type="button" class="b_foot"   value="ȷ��&��ӡ" onClick="printCommit()" >
                &nbsp;
                <input name="reset" type="reset" class="b_foot"  value="���" >
                &nbsp;
                <input name="back" onClick="history.go(-1);" type="button" class="b_foot"  value="����">
                &nbsp;

				</div>
			</td>
          </tr>
      </table>

  <input type="hidden" name="iOpCode" value="<%=paraAray1[3]%>">
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
  <input type="hidden" name="loginAccept" value="<%=loginAccept%>">
  <input type="hidden" name="printAccept" value="<%=printAccept%>">
  <input type="hidden" name="saleType" value="<%=saleType%>">

  <input type="hidden" name="print_note" value="<%=print_note%>"><!--��ӡ�������-->
  <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
<%@ include file="/npage/public/hwObject.jsp" %> 
</html>

<script language="javascript">

</script>
