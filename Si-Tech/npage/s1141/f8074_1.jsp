<%
/********************
version v2.0
������: si-tech
update:anln@2009-02-24 ҳ�����,�޸���ʽ
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
	String opCode = request.getParameter("opcode");
	String opName = (String)request.getParameter("opName");		
	String loginNo = (String)session.getAttribute("workNo");
	String loginName = (String)session.getAttribute("workName");
	String regionCode= (String)session.getAttribute("regCode");
	String loginPwd    = (String)session.getAttribute("password");
%>
<%
	String retFlag="",retMsg=""; 	
  	String[] paraAray1 = new String[3];
  	String phoneNo = request.getParameter("srv_no");
  	String opcode = request.getParameter("opcode");  	
  	String passwordFromSer="";

 	paraAray1[0] = phoneNo;		/* �ֻ�����   */
  	paraAray1[1] = opcode; 	    /* ��������   */
  	paraAray1[2] = loginNo;	    /* ��������   */

	for(int i=0; i<paraAray1.length; i++)
	{
		if( paraAray1[i] == null )
		{
		  paraAray1[i] = "";
		
		}
	}


 	//retList = impl.callFXService("s1141Qry", paraAray1, "14","phone",phoneNo);
 %>
 	<wtc:service name="s1141Qry" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="14" >
			
		<wtc:param value=" "/>
		<wtc:param value="01"/>		
		<wtc:param value="<%=paraAray1[1]%>"/>
		<wtc:param value="<%=paraAray1[2]%>"/>
		<wtc:param value="<%=loginPwd%>"/>										
		<wtc:param value="<%=paraAray1[0]%>"/>
		<wtc:param value=""/>		
				
	</wtc:service>
	<wtc:array id="retList" scope="end"/>
 <%
  	String  bp_name="",bp_add="",cardId_type="",cardId_no="",sm_code="",region_name="",run_name="",vip="",posint="",prepay_fee="";
  	String[][] tempArr= new String[][]{};
	String errCode = retCode1;
	String errMsg = retMsg1;
  if(retList == null)
  {
	if(!retFlag.equals("1"))
	{		
	   retFlag = "1";
	   retMsg = "s1141Qry��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
    }
  }
  else
  {
  	
	if(!errCode.equals("000000") ){%>
		<script language="JavaScript">
			alert("������룺<%=errCode%>��������Ϣ��<%=errMsg%>",0);
			history.go(-1);
		</script>
	<%}
	else
	{
		tempArr=retList;
	  	//tempArr = (String[][])retList.get(2);
	  if(tempArr!=null&&tempArr.length>0){
	    	bp_name = tempArr[0][2];//��������
	    	System.out.println(bp_name);	
	  	//tempArr = (String[][])retList.get(3);
	    	bp_add = tempArr[0][3];//�ͻ���ַ	
	  	//tempArr = (String[][])retList.get(4);	
	    	cardId_type = tempArr[0][4];//֤������	
	  	//tempArr = (String[][])retList.get(5);	 
	    	cardId_no = tempArr[0][5];//֤������	 
	  	//tempArr = (String[][])retList.get(6);	
	    	sm_code = tempArr[0][6];//ҵ��Ʒ��	 
	  	//tempArr = (String[][])retList.get(7);	  
	    	region_name = tempArr[0][7];//������	
	  	//tempArr = (String[][])retList.get(8);	  
	    	run_name = tempArr[0][8];//��ǰ״̬
	 	//tempArr = (String[][])retList.get(9);	 
	    	vip = tempArr[0][9];//�֣ɣм���	 
	 	//tempArr = (String[][])retList.get(10);	 
	    	posint = tempArr[0][10];//��ǰ����	 
	  	//tempArr = (String[][])retList.get(11);	
	    	prepay_fee = tempArr[0][11];//����Ԥ��	 
	  	//tempArr = (String[][])retList.get(13);	  
	    	passwordFromSer = tempArr[0][13];  //����
	  }
	}
  }

%>
<%
	String printAccept="";
	printAccept = getMaxAccept();
%>

<html>
<head>
<title>Ԥ�滰���ͱʼǱ�</title>
<script type="text/javascript" src="/npage/s3000/js/S3000.js"></script>
<script language="JavaScript" src="/npage/s1400/pub.js"></script>
<script language="JavaScript">
<!--
	//����Ӧ��ȫ�ֵı���
	var SUCC_CODE	= "0";   		//�Լ�Ӧ�ó�����
	var ERROR_CODE  = "1";			//�Լ�Ӧ�ó�����
	var YE_SUCC_CODE = "0000";		//����Ӫҵϵͳ������޸�
	


//***
 function getInfo_code()
 {
  	var regionCode = "<%=regionCode%>";

    var pageTitle = "Ӫ����ѡ��";
    var fieldName = "��������|��������|Ԥ����|���ʷѴ���|GPRS������|";//����������ʾ���С�����
    var sqlStr = "";
    	sqlStr = "SELECT   a.order_code, TRIM (a.order_name), a.prepay_fee, a.bind_mode,TO_CHAR (b.offer_attr_value) "+
				 "FROM sprepaycompute a, product_offer_attr b "+
				 "WHERE b.offer_attr_seq = '5070' AND a.region_code = '01' "+
				 "AND SYSDATE BETWEEN a.begin_time AND a.end_time "+
				 "AND a.bind_mode = TO_CHAR (b.offer_id) "+
				 "order by a.order_code";
    //alert("sqlStr="+sqlStr);
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "5|0|1|2|3|4|";//�����ֶ�
    var retToField = "order_code|order_name|pay_money|bind_mode|prepay_least|";//���ظ�ֵ����
    MySimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,50);
 }
function MySimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,dialogWidth)
{
    var path = "<%=request.getContextPath()%>/npage/public/fPubSimpSel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
    retInfo = window.showModalDialog(path,"","dialogWidth:"+dialogWidth);
    if(retInfo ==undefined)
    {   return false;   }
    var chPos_field = retToField.indexOf("|");
    var chPos_retStr;
    var valueStr;
    var obj;
    while(chPos_field > -1)
    {
        obj = retToField.substring(0,chPos_field);
        chPos_retInfo = retInfo.indexOf("|");
        valueStr = retInfo.substring(0,chPos_retInfo);
        document.all(obj).value = valueStr;
        retToField = retToField.substring(chPos_field + 1);
        retInfo = retInfo.substring(chPos_retInfo + 1);
        chPos_field = retToField.indexOf("|");

    }
	return true;
} 
function frmCfm(){
	frm.submit();
	return true;
}
 function printCommit()
 {
 	getAfterPrompt();
  //У��
  //if(!check(frm)) return false;
  with(document.frm){
    if(cust_name.value==""){
	  rdShowMessageDialog("����������!");
      cust_name.focus();
	  return false;
	}
	if (gprs_phone.value.length == 0) {
      rdShowMessageDialog("�����ݿ����벻��Ϊ�գ����������� !!");
      gprs_phone.focus();
	  return false;
     }
	if(parseFloat(prepay_fee.value) < parseFloat(pay_money.value))
	{
		rdShowMessageDialog("Ԥ����,��ɷѺ����°���!");
		return;
	}
	if(phone_no.value == gprs_phone.value)
	{
		rdShowMessageDialog("����ҵ�����Ͱ󶨺��벻����ͬ!");
		return;
	}
	prepay_all.value=parseFloat(pay_money.value)+parseFloat(prepay_least.value);
  }
	document.all.confirm.disabled=true;
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
{  	
	//��ʾ��ӡ�Ի���
	//��ʾ��ӡ�Ի��� 		
	var pType="subprint";                     // ��ӡ����print ��ӡ subprint �ϲ���ӡ
	var billType="1";                      //  Ʊ������1���������2��Ʊ��3�վ�
	var sysAccept ="<%=printAccept%>";                       // ��ˮ��
	var printStr = printInfo(printType);   //����printinfo()���صĴ�ӡ����
	var mode_code=null;                        //�ʷѴ���
	var fav_code=null;                         //�ط�����
	var area_code=null;                    //С������
	var opCode =   "<%=opcode%>";                         //��������
	var phoneNo = "<%=phoneNo%>";                           //�ͻ��绰		
	var h=162;
	var w=352;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 	   
	var path= "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
	var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	var ret=window.showModalDialog(path,printStr,prop);    	
}

function printInfo(printType)
{

	var month_fee ;
	var pay = document.all.pay_money.value;
	month_fee= Math.round(pay*100/12)/100;
	    
	var cust_info=""; //�ͻ���Ϣ
	var opr_info=""; //������Ϣ
	var retInfo = "";  //��ӡ����
	var note_info1=""; //��ע1
	var note_info2=""; //��ע2
	var note_info3=""; //��ע3
	var note_info4=""; //��ע4 
	
	cust_info+="�ͻ�������   "+document.all.cust_name.value+"|";
	cust_info+="�ֻ����룺   "+document.all.phone_no.value+"|";
	cust_info+="�ͻ���ַ��   "+document.all.cust_addr.value+"|";
	cust_info+="֤�����룺   "+document.all.cardId_no.value+"|";
	
	opr_info+="ҵ�����ͣ�Ԥ�滰���ͱʼǱ�"+"|";
	opr_info+="ҵ����ˮ��"+document.all.login_accept.value+"|";
	
	note_info1+="˵�����û�����"+document.all.prepay_all.value+"ԪԤ�����GPRS���������ѣ�ÿ�¿�ʹ��ʡ��700M��ʡ��300M GPRS����������"+"|";
	note_info2+="������CMWAP��CMNET������������0.005Ԫ/kb������ȡ�����굽�ں��Զ�תΪ��ͨ50Ԫ�����ʷѡ���"+"|";
	note_info3+="�ͱʼǱ�һ̨������,GPRS�����"+document.all.prepay_least.value+"Ԫ����"+document.all.pay_money.value+"ԪΪͨ����,������֮����,�������������,����δ�����Զ����ϡ�"+"|";	
	note_info4+="��ע��"+document.all.opNote.value+"|";
	
	retInfo= strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //�ѡ�#"�滻Ϊurl��ʽ
	return retInfo;	
}



//-->
</script>


</head>
<body>
<form name="frm" method="post" action="f8074Cfm.jsp" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>  
	<div class="title">
		<div id="title_zi">Ԥ�滰���ͱʼǱ�</div>
	</div> 
	<table cellspacing="0" >
		<tr>
			<td class="blue">��������</td>
			<td colspan="3">Ԥ�滰���ͱʼǱ�--����</td>
		</tr>
		<tr>
			<td class="blue">�ͻ�����</td>
			<td>
				<input name="cust_name" value="<%=bp_name%>" type="text"  v_must=1 readonly class="InputGrey" id="cust_name" maxlength="20" >
				<font class="orange">*</font>
			</td>
			<td  class="blue">�ͻ���ַ</td>
			<td nowrap>
				<input name="cust_addr" value="<%=bp_add%>" type="text"  v_must=1 readonly class="InputGrey" id="cust_addr" maxlength="30" >
				<font class="orange">*</font>
			</td>
		</tr>
		<tr>
			<td  class="blue">֤������</td>
			<td>
				<input name="cardId_type" value="<%=cardId_type%>" type="text"  v_must=1 readonly class="InputGrey" id="cardId_type" maxlength="20" >
				<font class="orange">*</font>
			</td>
			<td  class="blue">֤������</td>
			<td>
				<input name="cardId_no" value="<%=cardId_no%>" type="text"  v_must=1 readonly class="InputGrey" id="cardId_no" maxlength="20" >
				<font class="orange">*</font>
			</td>
           	</tr>
		<tr>
			<td  class="blue">ҵ��Ʒ��</td>
			<td>
				<input name="sm_code" value="<%=sm_code%>" type="text"  v_must=1 readonly class="InputGrey" id="sm_code" maxlength="20" >
				<font class="orange">*</font>	
			</td>
			<td  class="blue">����״̬</td>
			<td>
				<input name="run_type" value="<%=run_name%>" type="text"  v_must=1 readonly class="InputGrey" id="run_type" maxlength="20" >
				<font class="orange">*</font>
			</td>
		</tr>
		<tr>
			<td  class="blue">VIP����</td>
			<td>
				<input name="vip" value="<%=vip%>" type="text"  v_must=1 readonly class="InputGrey" id="vip" maxlength="20" >
				<font class="orange">*</font>
			</td>
			<td  class="blue">����Ԥ��</td>
			<td>
				<input name="prepay_fee" value="<%=prepay_fee%>" type="text"  v_must=1 readonly class="InputGrey" id="prepay_fee" maxlength="20" >
				<font class="orange">*</font>
			</td>
		</tr>
		<tr>
			<td  class="blue">Ԥ�滰��</td>
			<td>
              <input class="button"  type="text" name="pay_money" id="pay_money" v_name="Ԥ�滰��" readonly>
			  <input class="b_text" type="button" name="qry_mode" value="��ѯ" onClick="getInfo_code()" >
			</td>
			<td  class="blue">�����ݿ�����</td>
			<td>
				<input   type="text" size="12" name="gprs_phone" id="gprs_phone" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1   maxlength="11" index="0">
				<font class="orange">*</font>
			</td>
		</tr>		
		<tr>
			<td class="blue" >��ע</td>
			<td colspan="3" >
				<input name="opNote" type="text"  id="opNote" size="60" maxlength="60" value="Ԥ�滰���ͱʼǱ�" readonly class="InputGrey">
			</td>
		</tr>
	</table>
	<table cellspacing="0" >
		<tr>
			<td id="footer">
				<input name="confirm" type="button"  index="2" class="b_foot_long" value="ȷ��&��ӡ" onClick="printCommit()" >
				&nbsp;
				<input name="reset" type="reset" class="b_foot" value="���" >
				&nbsp;
				<input name="back" onClick="history.go(-1)" class="b_foot" type="button"  value="����">
				&nbsp;
			</td>
		</tr>
	</table>
 
	<input type="hidden" name="phone_no" value="<%=phoneNo%>">
	<input type="hidden" name="work_no" value="<%=loginName%>">
	<input type="hidden" name="opcode" value="<%=opcode%>">
	<input type="hidden" name="login_accept" value="<%=printAccept%>">
	<input type="hidden" name="card_dz" value="0" >
	<input type="hidden" name="sale_type" value="1" >
	<input type="hidden" name="used_point" value="0" >
	<input type="hidden" name="point_money" value="0" >
	<input type="hidden" name="order_code" >
	<input type="hidden" name="order_name" >
	<input type="hidden" name="bind_mode" >
	<input type="hidden" name="prepay_least" >
	<input type="hidden" name="prepay_all" >	
	<input type="hidden" name="opName" value="<%=opName%>">
	
	 <%@ include file="/npage/include/footer.jsp" %>   
</form>
</body>
</html>
