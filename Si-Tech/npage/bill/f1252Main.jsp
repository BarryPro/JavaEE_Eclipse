<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����: ��ܰ��ͥȡ��1252
   * �汾: 1.0
   * ����: 2008/12/24
   * ����: leimd
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>

<%
	String opCode="1252";
	String opName="��ܰ��ͥȡ��";
	String phoneNo = (String)request.getParameter("activePhone");
	String loginNo =(String)session.getAttribute("workNo");    		         //����
	String loginName =(String)session.getAttribute("workName");               //��������
	String[][]  favInfo = (String[][])session.getAttribute("favInfo");		//�Ż�Ȩ����Ϣ
	String regionCode = (String)session.getAttribute("regCode");
	String orgCode =(String)session.getAttribute("orgCode");				//�������루�������룩
%>

<%
  	String retFlag="";				//����Ƿ�У��ʧ�ܵı�־����Ϣ
/****************���ƶ�����õ����롢������������ܰ��ͥ�������Ϣ s1251Init***********************/
	String[] paraAray1 = new String[4];
	String main_card = request.getParameter("srv_no");
	String passwordFromSer="";

	paraAray1[0] = main_card;		/* �ֻ�����   */
	paraAray1[1] = loginNo; 	/* ��������   */
	paraAray1[2] = orgCode;	/* ��������   */
	paraAray1[3] = "1252";	/* ��������   */
	for(int i=0; i<paraAray1.length; i++)
	{
		if( paraAray1[i] == null )
		{
	  		paraAray1[i] = "";
		}
	}

%>
	<wtc:service name="s1251Init" routerKey="region" routerValue="<%=regionCode%>" outnum="36" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=paraAray1[0]%>"/>
		<wtc:param value="<%=paraAray1[1]%>"/>
		<wtc:param value="<%=paraAray1[2]%>"/>
		<wtc:param value="<%=paraAray1[3]%>"/>
	</wtc:service>
	<wtc:array id="tempArr" scope="end"/>
	<wtc:array id="familyCodeArr" start="29" length="1" scope="end"/>
	<wtc:array id="otherCodeArr" start="30" length="1" scope="end"/>
	<wtc:array id="cardTypeArr" start="31" length="1" scope="end"/>
	<wtc:array id="beginTimeArr" start="32" length="1" scope="end"/>
	<wtc:array id="endTimeArr" start="33" length="1" scope="end"/>
	<wtc:array id="opTimeArr" start="34" length="1" scope="end"/>
	<wtc:array id="newRateCodeArr" start="35" length="1" scope="end"/>

<%

	String  bp_name="",sm_code="",family_code="",rate_code="",op_type="2",bigCust_flag="",sm_name="",rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="",prepay_fee="",print_note="",cardId_no="",bp_add="";
	String otherCardFlag = "" ;							//����
	String mainDisabledFlag="";
	/**
	String[][] familyCodeArr= new String[][]{};			//��ͥ����
	String[][] otherCodeArr= new String[][]{};			//��������
	String[][] cardTypeArr= new String[][]{};			//������
	String[][] beginTimeArr= new String[][]{};			//��ʼʱ��
	String[][] endTimeArr= new String[][]{};			//����ʱ��
	String[][] opTimeArr= new String[][]{};				//����ʱ��
	String[][] newRateCodeArr= new String[][]{};		//��ܰ��ͥ�ʷѴ���
	**/
	String errCode = retCode ;
	String errMsg = retMsg ;

	if(tempArr == null)
	{
		if(!retFlag.equals("1"))
		{
			retFlag="1";
			retMsg="s1251Init��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg: " + errMsg ;
		}
	}else if(!(tempArr == null))
	{
		if (errCode.equals("000000")  ){
			bp_name = tempArr[0][3];						//��������
			passwordFromSer = tempArr[0][2];				//����
			sm_code = tempArr[0][11];						//ҵ�����
			cardId_no = tempArr[0][19];						//֤������
			bp_add = tempArr[0][4];							//�ͻ���ַ
			sm_name = tempArr[0][12];						//ҵ���������
			rate_code = tempArr[0][5];						//�ʷѴ���
			rate_name = tempArr[0][6];						//�ʷ�����
			next_rate_code = tempArr[0][7];					//�����ʷѴ���
			next_rate_name = tempArr[0][8];					//�����ʷ�����
			bigCust_flag = tempArr[0][9];					//��ͻ���־
			bigCust_name = tempArr[0][10];					//��ͻ�����
			lack_fee = tempArr[0][15];						//��Ƿ��
			prepay_fee = tempArr[0][16];					//��Ԥ��
			print_note = tempArr[0][27];					//��������
			family_code = tempArr[0][29];
			//�ж��Ƿ���������¼
			if(familyCodeArr==null || familyCodeArr.length==0 || familyCodeArr[0][0].equals("")){
				if(!retFlag.equals("1"))
				{
					retFlag="1";
					retMsg="�ú���û�ж�Ӧ��������Ϣ!";
				}
			}else if(familyCodeArr.length>1){
				otherCardFlag = "1";//�ж��Ƿ���ڸ���
			}
		}else{
			if(!retFlag.equals("1"))
			{
				retFlag="1";
				retMsg="s1251Init��ѯ���������Ϣʧ��!"+errMsg;
			}

		}
	}

//********************�õ�ӪҵԱȨ�ޣ��˶����룬�������Ż�Ȩ��*****************************//
	int infoLen = favInfo.length;
	String tempStr = "";								//�Ż���Ϣ
	for(int i=0;i<infoLen;i++)
	{
		tempStr = (favInfo[i][0]).trim();
	}
	String printAccept="";								/****�õ���ӡ��ˮ****/
	printAccept = getMaxAccept();

	//******************�õ�����������***************************//
	String sqlNewRateCode2  = "";  						//�ʷѴ���
	//sqlNewRateCode2  = "select a.mode_code, a.mode_code||'--'||b.mode_name from sRegionNormal a, sBillModeCode b where a.region_code=b.region_code and a.mode_code=b.mode_code and a.region_code='" + orgCode.substring(0,2) + "'";
	sqlNewRateCode2  = "select a.mode_code, a.mode_code||'--'||b.offer_name from sRegionNormal a, product_offer b where  to_char(a.mode_code)=b.offer_id and a.region_code='" + orgCode.substring(0,2) + "'";

%>
	<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="2" retCode="retCode2" retMsg="retMsg2">
   		<wtc:sql><%=sqlNewRateCode2%></wtc:sql>
    </wtc:pubselect>
   	<wtc:array id="newRateCodeStr2" scope="end" />
<%
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>��ܰ��ͥȡ�� </title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<script language="JavaScript" src="<%=request.getContextPath()%>/npage/s1400/pub.js"></script>
<script language="JavaScript">
    //���У��ʧ�ܣ��򷵻���һ����
	<%if(retFlag.equals("1")){%>
	 rdShowMessageDialog("<%= retMsg %>");
	 history.go(-1);
	<%}%>
<!--
  //����Ӧ��ȫ�ֵı���
  var SUCC_CODE	= "0";   			//�Լ�Ӧ�ó�����
  var ERROR_CODE  = "1";			//�Լ�Ӧ�ó�����
  var YE_SUCC_CODE = "0000";		//����Ӫҵϵͳ������޸�

  function frmCfm(){
	  frm.submit();
	  return true;
  }
  //***//У��one
  function checkOne(){
	var flag = 0;
	var card_type,phoneNo ;
	var radio1 = document.getElementsByName("phoneNo");
	for(var i=0;i<radio1.length;i++){
	  if(radio1[i].checked){
	    flag = 1;
		phoneNo = oneTokSelf(radio1[i].value,"~",1);			//������
		card_type = oneTokSelf(radio1[i].value,"~",2);			//������
		document.frm.phoneNoForPrt.value=phoneNo;
		document.frm.cardTypeForPrt.value=card_type;
	  }
	}
	if(flag==0){
	  rdShowMessageDialog("��ѡ��Ҫȡ���ĺ���!");
	  return false;
	}else
	{
	  if(card_type=="1")
	  {
	    if(document.frm.new_rate_code2.value=="")
		{
		  rdShowMessageDialog("��ѡ�����ײʹ���!");
		  document.frm.new_rate_code2.focus();
	      return false;
		}
	  }
	}
	return true;
  }

  function printCommitOne(subButton){
	controlButt(subButton);						//��ʱ���ư�ť�Ŀ�����
	if(!checkOne()) return false;				//У��
	setOpNote();								//Ϊ��ע��ֵ
	document.frm.action="f1252Confirm.jsp";
    //��ӡ�������ύ��
    var ret = showPrtdlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
    if(typeof(ret)!="undefined")
    {
      if((ret=="confirm"))
      {
        if(rdShowConfirmDialog('ȷ�ϵ����������ȷ��,���ύ����ҵ��!')==1)
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

  function showPrtdlg(printType,DlgMessage,submitCfm)
  {  //��ʾ��ӡ�Ի���
     var h=180;
     var w=350;
     var t=screen.availHeight/2-h/2;
     var l=screen.availWidth/2-w/2;

     var pType="subprint";             				 //��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
	 var billType="1";              				 //Ʊ�����ͣ�1���������2��Ʊ��3�վ�
	 var sysAccept ="<%=printAccept%>";              //��ˮ��
	 var printStr = printInfo(printType);			 //����printinfo()���صĴ�ӡ����
	 var mode_code=null;           //�ʷѴ���
	 var fav_code=null;                				 //�ط�����
	 var area_code=null;             				 //С������
	 var opCode="1252" ;                   			 //��������
	 var phoneNo="<%=phoneNo%>";                  	 //�ͻ��绰

     var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	 var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
     var path = path+"&mode_code="+mode_code+
			"&fav_code="+fav_code+"&area_code="+area_code+
			"&opCode=<%=opCode%>&sysAccept="+sysAccept+
			"&phoneNo="+document.frm.main_card.value+
			"&submitCfm="+submitCfm+"&pType="+
			pType+"&billType="+billType+ "&printInfo=" + printStr;
     var ret=window.showModalDialog(path,printStr,prop);
     return ret;
  }

  function printInfo(printType)
  {
		var cust_info="";  //�ͻ���Ϣ
		var opr_info="";   //������Ϣ
		var note_info1=""; //��ע1
		var note_info2=""; //��ע2
		var note_info3=""; //��ע3
		var note_info4=""; //��ע4
		var retInfo = "";  //��ӡ����

	  var exeDate = "<%=new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(new java.util.Date())%>";//�õ�ִ��ʱ��
	  var card_type_name;//����������
      if(document.frm.cardTypeForPrt.value=="0")
	  {
		  card_type_name = "0--����";
	  }else if(document.frm.cardTypeForPrt.value=="1")
	  {
		  card_type_name = "1--��һ����";
	  }if(document.frm.cardTypeForPrt.value=="2")
	  {
		  card_type_name = "2--��������";
	  }

//    retInfo+='<%=loginNo%>   <%=loginName%>'+"|";
//	  retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	  cust_info+="�ֻ����룺"+document.frm.main_card.value+"|";
	  cust_info+="�ͻ�������" +document.frm.bp_name.value+"|";
	  cust_info+="֤�����룺"+"<%=cardId_no%>"+"|";
	  cust_info+="�ͻ���ַ��"+"<%=bp_add%>"+"|";

	  opr_info+="�û�Ʒ��:"+"<%=sm_name%>"+"  ����ҵ����ܰ��ͥ����ȡ��"+"  ������ˮ:"+"<%=printAccept%>"+"|";
	  opr_info+="��������:"+document.frm.main_card.value+"   ����������"+document.frm.bp_name.value+"|";
	  if(document.frm.cardTypeForPrt.value=="0"){
	  		opr_info+=" "+"|";
	  }else if(document.frm.cardTypeForPrt.value=="1"){
	  		opr_info+="��һ��������:"+document.frm.phoneNoForPrt.value+"   ��һ����ִ���ʷ�"+document.frm.new_rate_code2.options[document.frm.new_rate_code2.selectedIndex].text+"|";
	  }else {
	 		 opr_info+="�����������룺"+document.frm.phoneNoForPrt.value+"|";
	  }
	  opr_info+="��Чʱ�䣺"+exeDate+"|";

	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  return retInfo;
  }

  function oneTokSelf(str,tok,loc)
  {
	    var temStr=str;
		var temLoc;
		var temLen;
	    for(ii=0;ii<loc-1;ii++)
		{
			temLen=temStr.length;
			temLoc=temStr.indexOf(tok);
			temStr=temStr.substring(temLoc+1,temLen);
	 	}
		if(temStr.indexOf(tok)==-1)
		  	return temStr;
		else
	      	return temStr.substring(0,temStr.indexOf(tok));
  }

  /*���ݿ����Ͷ�̬�ı��еĿɼ���*/
  function controlByCardType(str)
  {
    var card_type = oneTokSelf(str,"~",2);//������
	var phoneNo = oneTokSelf(str,"~",1);//������
	document.frm.phoneNoForPrt.value=phoneNo;
    document.frm.cardTypeForPrt.value=card_type;
	if(card_type=="1")
	{
		document.all.newRateCode2tr.style.display="";
	}else
	{
	    document.all.newRateCode2tr.style.display="none";
	}
	return true;
  }
/******Ϊ��ע��ֵ********/
function setOpNote(){
    if(document.frm.opNote.value=="")
	{  document.frm.opNote.value = "��ܰȡ��;����:"+document.frm.cardTypeForPrt.value+";����:"+document.frm.main_card.value+" ;ȡ��:"+document.frm.phoneNoForPrt.value;
	}
	return true;
}
//-->
//������ʾ
function controlFlagCodeTdView(){
	getMidPrompt("10442",codeChg($('#new_rate_code2').val()),"ipTd");
}
</script>

</head>
<body>
<form name="frm" method="post">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">�ͻ���Ϣ</div>
	</div>
<table cellspacing="0">
	<tr>
		<td class="blue">��������</td>
		<td><font color="red"> &nbsp;&nbsp;ȡ��</font></td>
		<td class="blue">��������</td>
		<td>
			<input name="main_card" type="text" id="main_card" value="<%=main_card%>" class="InputGrey" readonly >
		</td>
	</tr>
	<tr >
		<td class="blue">��ͥ����</td>
		<td>
			<input name="family_code" type="text" id="family_code" value="<%=family_code%>" class="InputGrey" readonly >
		</td>
		<td class="blue">ҵ������</td>
		<td>
			<input name="sm_name" type="text" id="sm_name" value="<%=sm_code + "--" + sm_name%>" class="InputGrey" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">��ǰ���ײ�</td>
		<td>
			<input name="rate_name" type="text" id="rate_name" size="30" value="<%=rate_code+"--"+rate_name%>" class="InputGrey" readonly>
		</td>
		<td class="blue">�������ײ�</td>
		<td>
			<input name="next_rate_name" type="text" id="next_rate_name" size="30"  value="<%=next_rate_code+"--"+next_rate_name%>" class="InputGrey" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">��������</td>
		<td>
			<input name="bp_name" type="text" id="bp_name" value="<%=bp_name%>" class="InputGrey" readonly>
		</td>
		<td class="blue">��ͻ���־</td>
		<td>
			<input name="bigCust_flag" type="text" id="bigCust_flag" value="<%=bigCust_flag+"--"+bigCust_name%>" class="InputGrey" readonly>
		</td>
	</tr>
	<tr>
	<td class="blue">��Ƿ��</td>
	<td>
		<input name="lack_fee" type="text" id="lack_fee" value="<%=lack_fee%>" class="InputGrey" readonly >
	</td>
	<td class="blue">��Ԥ��</td>
	<td>
		<input name="prepay_fee" type="text" id="prepay_fee" value="<%=prepay_fee%>" class="InputGrey" readonly>
	</td>
	</tr>
	<tr id="newRateCode2tr" style="display:none">
		<td class="blue">���ײʹ���</td>
		<td id="ipTd">
			<select id="new_rate_code2"  name="new_rate_code2" class="button" onChange="controlFlagCodeTdView()">
				<option value="">--��ѡ��--</option>
				<%for(int i = 0 ; i < newRateCodeStr2.length ; i ++){%>
				<option value="<%=newRateCodeStr2[i][0]%>"><%=newRateCodeStr2[i][1]%></option>
				<%}%>
			</select>
			<font color="orange">*</font>
		</td>
		<td> </td>
		<td> </td>
	</tr>
	<tr>
		<td height="32" class="blue">��ע</td>
		<td colspan="3" height="32">
			<input name="opNote" type="text" id="opNote" size="60" maxlength="60" onFocus="setOpNote();" class="InputGrey" readOnly>
		</td>
	</tr>
</table>

</div>
<div id="Operation_Table">
<div class="title">
	<div id="title_zi">ѡ������</div>
</div>

<table cellSpacing="0">
	<tr align="middle">
		<th align=center>ѡ��</th>
		<th align=center>������</th>
		<th align=center>������</th>
		<th align=center>��ʼʱ��</th>
		<th align=center>����ʱ��</th>
		<th align=center>����ʱ��</th>
	</tr>
<%
	for(int j=0;j<otherCodeArr.length;j++){
		if(cardTypeArr[j][0].equals("0") && otherCardFlag.equals("1")){
			mainDisabledFlag = "disabled";
		}else{
			mainDisabledFlag = "";
		}
	%>
		<tr>
		<td align="center">
			<input type="radio" name="phoneNo" value="<%=otherCodeArr[j][0]+"~"+cardTypeArr[j][0]+"~"+newRateCodeArr[j][0]%>" <%=mainDisabledFlag%> onClick="controlByCardType(this.value)">
		</td>
		<%if(cardTypeArr[j][0].equals("0")){%>
		<td align="center">����</td>
		<%}else if(cardTypeArr[j][0].equals("1")){%>
	 	<td align="center">��һ����</td>
		<%}else if(cardTypeArr[j][0].equals("2")){%>
		<td align="center">��������</td>
		<%}else{%>
		<td align="center"><%=cardTypeArr[j][0]%></td>
		<%}%>
		<td align="center"><%=otherCodeArr[j][0]%></td>
		<td align="center"><%=beginTimeArr[j][0]%></td>
		<td align="center"><%=endTimeArr[j][0]%></td>
		<td align="center"><%=opTimeArr[j][0]%></td>
		</tr>
	<%
  }
%>
</table>

<table cellSpacing="0">
	<tr>
		<td colspan="4" align="center">
			<input name="confirm" id="confirm" type="button" class="b_foot"  value="ȷ��&��ӡ" onClick="printCommitOne(this)">
			&nbsp;
			<input name="reset" type="reset" class="b_foot" value="���" >
			&nbsp;
			<input name="back" onClick="history.go(-1);" type="button" class="b_foot" value="����">
			&nbsp;
		</td>
	</tr>
</table>
	<input type="hidden" name="phoneNoForPrt" ><!--Ҫȡ�����ֻ�����,���ڴ�ӡ-->
	<input type="hidden" name="cardTypeForPrt" ><!--Ҫȡ���Ŀ�����,���ڴ�ӡ-->
	<input type="hidden" name="printAccept" value="<%=printAccept%>"><!--��ӡ��ˮ-->
	 <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>

