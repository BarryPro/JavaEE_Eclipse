<%
  /*
   * ����: �������ѳ��� i102
   * �汾: 1.0
   * ����: 2013/9/2
   * ����: wanghyd
   * ��Ȩ: si-tech
   * update:
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*" %>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);

 	String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");

  String loginNo = (String)session.getAttribute("workNo");
  String loginName = (String)session.getAttribute("workName");
  String powerCode= (String)session.getAttribute("powerCode");
  String orgCode = (String)session.getAttribute("orgCode");
  String ip_Addr = (String)session.getAttribute("ipAddr");
  String regionCode = orgCode.substring(0,2);
  String loginNoPass = (String)session.getAttribute("password");
  String groupId = (String)session.getAttribute("groupId");
  String regCode = (String)session.getAttribute("regCode");
  
  String retFlag="",retMsg="";
  String phoneNo = request.getParameter("activePhone");
  String backaccept= request.getParameter("backAccept");//������ˮ
  String userpass="";

%>

<wtc:service  name="sg976Qry" routerKey="phone" routerValue="<%=phoneNo%>" outnum="38"  retcode="errCode" retmsg="errMsg">	
	<wtc:param  value="<%=backaccept%>"/>
	<wtc:param  value="01"/>
	<wtc:param  value="<%=opCode%>"/>
	<wtc:param  value="<%=loginNo%>"/>
	<wtc:param  value="<%=loginNoPass%>"/>
	<wtc:param  value="<%=phoneNo%>"/>	
	<wtc:param  value="<%=userpass%>"/>	
</wtc:service>
<wtc:array id="retList" scope="end"/>
<%
 /*
		�ͻ����룬�ͻ��������ͻ���ַ��oOldMode����ǰ�ʷѣ�grpbig_flag��grpbig_name��sm_code��
		sm_name��Ƿ�ѣ�����Ԥ�棬֤�����ͣ�֤�����룬id_no��belong_code�����۴��룬�ֻ�Ʒ���ͺ�
		����������������ޣ��Ԥ�棬�·��ѣ��µ������ѣ�VIP��������״̬���ֻ�Ʒ�ƣ�
		�ֻ��ͺţ�IMIE��Ӫ�������ƣ������ʷѴ���,�ɷѺϼ�,����Ԥ��,�ֻ����ӷ�,�ֻ����ӷ���������
 */
  String us_pass="",bp_name="",bp_add="",ole_mode="",current_fee="",grpbig_flag="",grpbig_name="",sm_code="";
  String sm_name="",temp_buf="",prepay_fee="",cardId_type="",cardId_no="",id_no="",belong_code="",sale_code="",phone_typeno="";
  String mach_price="",consume_Term="",prepay_gift="",prepay_limit="",mon_baseFee="",vip="",run_name="",agent_code="";
  String phone_type="",IMEINo="",sale_name="",OfferID="",payType="",Response_time="",TerminalId="",Rrn="",RequestTime="",CashPay="",basefee="",mobileTVfee="",mobileTVterm="";
  if("000000".equals(errCode)){
    if(retList.length>0){
      us_pass =retList[0][0];
  	  bp_name = retList[0][1];	  
  	  bp_add = retList[0][2];
  	  ole_mode = retList[0][3];
  	  current_fee = retList[0][4];
  	  grpbig_flag = retList[0][5];
  	  grpbig_name = retList[0][6];
  	  sm_code = retList[0][7];
  	  sm_name =retList[0][8];  
  	  temp_buf =retList[0][9]; 
  	  prepay_fee =retList[0][10];   
  	  cardId_type =retList[0][11];   
  	  cardId_no = retList[0][12];
  	  id_no = retList[0][13];
  	  belong_code = retList[0][14];
  	  sale_code = retList[0][15]; 
  	  phone_typeno = retList[0][16];
  	  mach_price = retList[0][17]; 
  		consume_Term = retList[0][18];
  		prepay_gift = retList[0][19]; 
  		prepay_limit = retList[0][20]; 
  		mon_baseFee = retList[0][21]; 
  		vip = retList[0][22]; 
  		run_name = retList[0][23]; 
  		agent_code = retList[0][24]; 
  		phone_type = retList[0][25]; 
  		IMEINo = retList[0][26];
  		sale_name = retList[0][27]; 
  		OfferID = retList[0][28];
  		payType = retList[0][29]; 
  		Response_time = retList[0][30]; 
  		TerminalId = retList[0][31]; 
  		Rrn = retList[0][32]; 
  		RequestTime = retList[0][33];
  		CashPay  = retList[0][34];
  		basefee  = retList[0][35];
  		mobileTVfee= retList[0][36];      /* �ֻ����ӷ� */
  		mobileTVterm= retList[0][37];     /* �ֻ����ӷ��������� */	
  		

    }else{
      if(!retFlag.equals("1")){
  	   retFlag = "1";
  	   retMsg = "��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg��" + errMsg;
      }
%>
        <SCRIPT language="JavaScript">
        	rdShowMessageDialog("<%=retMsg%>",0);
          window.location.href="/npage/si101/fi101_login.jsp?activePhone=<%=phoneNo%>&opCode=i102&opName=<%=opName%>";
        </SCRIPT>
<%
    }
  }else{
    retMsg = errMsg;
%>
    <SCRIPT language="JavaScript">
    	rdShowMessageDialog("������룺<%=errCode%><br>������Ϣ��<%=retMsg%>",0);
      window.location.href="/npage/si101/fi101_login.jsp?activePhone=<%=phoneNo%>&opCode=i102&opName=<%=opName%>";
    </SCRIPT>
<%  
  }
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="printAccept"/>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=opName%></title>
<META content="no-cache" http-equiv="Pragma">
<META content="no-cache" http-equiv="Cache-Control">
<META content="0" 	     http-equiv="Expires" >
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<script type="text/javascript" src="../../npage/s3000/js/S3000.js"></script>
<script language="JavaScript" src="../../npage/s1400/pub.js"></script>
<script language="JavaScript">

<!--
  function frmCfm(){
					posSubmitForm();		
  }
    /* ningtn add for pos start @ 20100430 */
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
	/* ningtn add for pos start @ 20100430 */
 //***
 function printCommit()
 {
  getAfterPrompt();

  document.frm.iAddStr.value="<%=sale_code%>|<%=agent_code%>|<%=phone_typeno%>|<%=mobileTVfee%>|<%=prepay_gift%>|<%=prepay_limit%>|<%=mon_baseFee%>|<%=mach_price%>|<%=consume_Term%>|<%=OfferID%>|<%=IMEINo%>||<%=mobileTVfee%>|";
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
	var op_Code="i102" ;                   			 		//��������
	var phoneNo="<%=phoneNo%>";                  	 		//�ͻ��绰

	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
	path+="&mode_code="+mode_code+
		"&fav_code="+fav_code+"&area_code="+area_code+
		"&opCode="+op_Code+"&sysAccept="+sysAccept+
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
	//opr_info+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		cust_info+="�ͻ�������" +document.all.cust_name.value+"|";
		cust_info+="�ֻ����룺"+document.all.phoneNo.value+"|";
		cust_info+="֤�����룺" +document.all.cardId_no.value+"|";
		cust_info+="�ͻ���ַ��"+document.all.cust_addr.value+"|";
	
	opr_info+="�û�Ʒ�ƣ�"+document.all.sm_name.value+"    ����ҵ��<%=opName%>"+"|";
  opr_info+="ҵ����ˮ��"+document.all.login_accept.value+"|";
  opr_info+="�ֻ��ͺţ�"+document.all.phone_type.value+"    IMEI�룺"+document.all.IMEINo.value+"|";
  	note_info1+="��ע��"+document.all.opNote.value+"|";

  retInfo=strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
  return retInfo;
}


//-->
</script>
</head>
<body>
<form name="frm" method="post" action="fi102_cfm.jsp" onload="init()">
	<%@ include file="/npage/include/header.jsp" %>
<table cellspacing="0">
	<tr>
		<td class="blue">�ֻ�����</td>
		<td class="blue" colspan="3"><input name="phoneNo" value="<%=phoneNo%>" type="text" class="InputGrey" v_must=1 readonly id="phoneNo" maxlength="20" ></td>
	</tr>
	<tr>
		<td class="blue">�ͻ�����</td>
		<td>
			<input name="cust_name" value="<%=bp_name%>" type="text" class="InputGrey" v_must=1 readonly id="cust_name" maxlength="20" >
			<font color="orange">*</font>
		</td>
		<td class="blue">�ͻ���ַ</td>
		<td>
			<input name="cust_addr" value="<%=bp_add%>" type="text" class="InputGrey" v_must=1 readonly id="cust_addr" maxlength="20" size="40">
			<font color="orange">*</font>
		</td>
	</tr>
	<tr>
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
	<tr>
		<td class="blue">ҵ��Ʒ��</td>
		<td>
			<input name="sm_name" value="<%=sm_name%>" type="text" class="InputGrey" v_must=1 readonly id="sm_name" maxlength="20" >
			<font color="orange">*</font>
		</td>
		<td class="blue">����״̬</td>
		<td>
			<input name="run_type" value="<%=run_name%>" type="text" class="InputGrey" v_must=1 readonly id="run_type" maxlength="20" >
			<font color="orange">*</font>
		</td>
	</tr>
	<tr>
		<td class="blue">VIP����</td>
		<td>
			<input name="vip" value="<%=vip%>" type="text" class="InputGrey" v_must=1 readonly id="vip" maxlength="20" >
			<font color="orange">*</font>
		</td>
		<td class="blue">����Ԥ��</td>
		<td>
			<input name="prepay_fee" value="<%=prepay_fee%>" type="text" class="InputGrey" v_must=1 readonly id="prepay_fee" maxlength="20" >
			<font color="orange">*</font>
		</td>
	</tr>

	<tr>
		<td class="blue">�ֻ��ͺ�</td>
		<td >
			<input name="phone_typess" type="text"  class="InputGrey" id="phone_typess" value="<%=phone_type%>" readonly >
			<font color="orange">*</font>
		</td>
		
				<td class="blue">���ͻ���</td>
		<td >
			<input name="giveFee" type="text"  class="InputGrey" id="giveFee" value="<%=mobileTVfee%>" readonly >
			<font color="orange">*</font>
		</td>

	</tr>
	<tr>
		<td class="blue">��ע</td>
		<td colspan="3">
			<input name="opNote" type="text"  id="opNote" size="60" maxlength="60" value="" >
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
		<input type="hidden" name="opCode" value="<%=opCode%>">
		<input type="hidden" name="opName" value="<%=opName%>">
		<input type="hidden" name="login_accept" value="<%=printAccept%>">
		<input type="hidden" name="backaccept" value="<%=backaccept%>">
		<input type="hidden" name="sale_code" value="<%=sale_code%>" >
		<input type="hidden" name="agent_code" value="<%=agent_code%>" >
		<input type="hidden" name="CashPay" value="<%=CashPay%>" >
		<input type="hidden" name="mon_baseFee" value="<%=mon_baseFee%>" >
		<input type="hidden" name="prepay_limit" value="<%=prepay_limit%>" >		
		<input type="hidden" name="prepay_gift" value="<%=prepay_gift%>" >				
		<input type="hidden" name="consume_Term" value="<%=consume_Term%>" >		
		<input type="hidden" name="sm_code" value="<%=sm_code%>" >		
		<input type="hidden" name="IMEINo" value="<%=IMEINo%>" >		
		<input type="hidden" name="iAddStr" value="" >		
		<input type="hidden" name="phone_typeno" value="<%=phone_typeno%>" >	
		<input type="hidden" name="phone_type" value="<%=phone_type%>" >		
		<input type="hidden" name="OfferID" value="<%=OfferID%>" >
		<input type="hidden" name="PhoneFree_Fee" id="PhoneFree_Fee" value="<%=mobileTVfee%>" >		
		<input type="hidden" name="Active_Term" id="Active_Term" value="<%=mobileTVterm%>" >	

	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
