<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>

<%
	String opCode = request.getParameter("opFlag");
  String opName = "����Ʒͳһ����ԤԼ�Ǽ�";

  String loginNo = (String)session.getAttribute("workNo");
  String ip_Addr = request.getRemoteAddr();
  String loginNoPass = (String)session.getAttribute("password");
  String loginName = (String)session.getAttribute("workName");
  String orgCode = (String)session.getAttribute("orgCode");
  String strRegionCode = orgCode.substring(0,2);
  String IccId = "";
  String cust_address = "";
  String loginname = loginName;

  String retFlag="";
  String f7515QueryRetMsg="";//�����ж�ҳ��ս���ʱ����ȷ��

  String strPhoneNo = request.getParameter("phone_no");
  String strAwardCode = request.getParameter("queryaward");

  String strUserPasswd = "";//�û�����
  String bp_name = "";
  String passwordFromSer = "";
	
%>
		<!-- 2013/07/23 14:12:23 gaopeng ����BOSSϵͳ��ѯ�ͻ�������ع����Ż�������  -->
  	<wtc:service name="sUserCustInfo" routerKey="regionCode" routerValue="<%=strRegionCode%>" retcode="errCodeGetCust" retmsg="errMsgGetCust"  outnum="41" >
      <wtc:param value="0"/>
      <wtc:param value="01"/>
      <wtc:param value="6842"/>
      <wtc:param value="<%=loginNo%>"/>
      <wtc:param value="<%=loginNoPass%>"/>
      <wtc:param value="<%=strPhoneNo%>"/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value="����phone_no:[<%=strPhoneNo%>]���в�ѯ"/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
  	</wtc:service>
    
		<wtc:array id="resultGetCust" scope="end" >
		</wtc:array>
<%
	 if(resultGetCust!=null&&resultGetCust.length>0){
          bp_name = (resultGetCust[0][5]).trim();
          IccId = (resultGetCust[0][13]).trim();
          cust_address = (resultGetCust[0][11]).trim();
          passwordFromSer = (resultGetCust[0][40]).trim();
          System.out.println("gaopeng@@@@@@@@@bp_name="+bp_name);
          System.out.println("gaopeng@@@@@@@@@IccId="+IccId);
          System.out.println("gaopeng@@@@@@@@@cust_address="+cust_address);
          System.out.println("gaopeng@@@@@@@@@passwordFromSer="+passwordFromSer);
    }

  if (bp_name.equals("")){
		retFlag = "1";
	  f7515QueryRetMsg = "�û����������ϢΪ�ջ򲻴���!<br>";
 	}
	System.out.println("((((((()))))="+request.getParameter("queryaward"));
	String[] paraAray = new String[7];
	paraAray[0] = strPhoneNo;		/* �ֻ�����*/
  paraAray[1] = opCode; 			/* ��������*/
  paraAray[2] = loginNo; 			/* ��������   */
  paraAray[3] = loginNoPass; 	/* ������������   */
  paraAray[4] = request.getParameter("queryaward"); /*��Ʒ��� (ssaleprojecttype#type_code)*/
  paraAray[5] = request.getParameter("detailcode"); /*Ӫ��������*/
  paraAray[6] = request.getParameter("grade_code"); /*�ȼ�����*/

  for(int i=0; i<paraAray.length; i++){System.out.println("ԤԼ�Ǽ���Σ�"+paraAray[i]);}
%>
 	<wtc:service name="s6842Sel" routerKey="phone" routerValue="<%=strPhoneNo%>" outnum="17" >
	<wtc:param value="<%=paraAray[0]%>"/>
	<wtc:param value="<%=paraAray[1]%>"/>
	<wtc:param value="<%=paraAray[2]%>"/>
	<wtc:param value="<%=paraAray[3]%>"/>
	<wtc:param value="<%=paraAray[4]%>"/>
	<wtc:param value="<%=paraAray[5]%>"/>
	<wtc:param value="<%=paraAray[6]%>"/>
	</wtc:service>
	<wtc:array id="s7515InitArr" scope="end"/>
<%
 	int errCode = retCode==""?999999:Integer.parseInt(retCode);
  String errMsg = retMsg;

  if(s7515InitArr == null)
  {
	  retFlag = "1";
	  f7515QueryRetMsg = "s6842Sel��ѯ���������ϢΪ��!<br>" + "errCode: " + errCode + "<br>errMsg: " +  errMsg;
  }else if (errCode != 0){
	  	retFlag = "1";
	    f7515QueryRetMsg = "s6842Sel��ѯ�û�����Ʒͳһ������Ϣʧ��!<br>" + "errCode: " + errCode + "<br>errMsg: " +  errMsg;
 	}
%>
	 <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone" routerValue="<%=strPhoneNo%>" id="sLoginAccept"/>
<%
		/****�õ���ӡ��ˮ****/
		String printAccept="";
  	printAccept = sLoginAccept;
  	String cnttActivePhone = strPhoneNo;
%>
<html>
<head>
<%@ include file="../../npage/s6842/head_2266_javascript.htm" %>
<title><%=opName%></title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<script language="JavaScript">
  <%if(retFlag.equals("1")){%>
    rdShowMessageDialog("<%=f7515QueryRetMsg%>");
    window.location.href="f6842.jsp?activePhone=<%=strPhoneNo%>";
  <%}%>


onload=function()
{
	//if((<%=paraAray[4]%>=="01")&&(<%=paraAray[5]%>=="2520")){document.all.opNote.readOnly = false;	}
}

 function changradio(j)
 {
 	for(var i=0;i<<%=s7515InitArr.length%>;i++){
 		document.getElementById('query'+i).disabled=true;
 	}
 		document.getElementById('query'+j).disabled=false;
 		document.all.hownum.value = j;
		document.all.confirm.disabled = false;
 }

//У���Ƿ�ѡ���콱��¼
function checkIfSelect()
{
	var radio1 = document.getElementsByName("radio1");
	var flag = 0;
	for(var i=0; i<radio1.length; i++)
	{
		if(radio1[i].checked)
		{
			var vFlag = document.getElementById('register'+i).value; //YԤԼ�Ǽǹ�
			if (vFlag=="Y")
			{
				rdShowConfirmDialog("����Ʒ�ѵǼǹ�!");
				return false;
			}
			flag=1;
			break;
		}
	}
	if(flag==0)
	{
		rdShowConfirmDialog("��ѡ��һ���콱��¼!");
		return false;
	}
	return true;
}

function printCommit()
{
	getAfterPrompt();
	document.all.confirm.disabled = true;
	var k = document.all.hownum.value;

	with(document.frm){

		if(!(checkIfSelect())) return false;

	  var varPrintInfo = '<%=loginName%>'+"|"
    +document.frm.phoneNo.value.trim()+"|"
    +document.frm.bp_name.value.trim()+"|"
  	+document.frm.IccId.value.trim()+"|"
  	+document.frm.cust_address.value.trim()+"|"
  	+'<%=opCode%>'+"|"
  	+document.frm.printAccept.value.trim()+"|"
  	+document.getElementById('ResName'+k).value.trim()+"|"
  	+document.frm.opNote.value.trim()+"|"
  	+document.frm.ressum.value.trim()+"|"
  	+document.frm.printPackageCont.value.trim()+"|";

	  //��ӡ�������ύ��
	  var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes",varPrintInfo);
  	if(typeof(ret)!="undefined")
  	{
  		if((ret=="confirm") && (rdShowConfirmDialog('ȷ�ϵ����������ȷ��,���ύ����ҵ��!')==1))
  		{
		    	frmCfm('1');
			}
	  	if(ret=="continueSub" && (rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1))
	  	{
		    	frmCfm('0');
			}
		}else if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){
	  	frmCfm('0');
    }else{
    	return true;
    }
	}
}


function frmCfm(val){
		var j = document.all.hownum.value;
		document.all.projectCodeI.value = document.getElementById('projectCode'+j).value;
		document.all.gradeCodeI.value   = document.getElementById('gradeCode'+j).value;
		document.all.packageCodeI.value = document.getElementById('packageCode'+j).value;
		document.all.winAcceptI.value   = document.getElementById('winAccept'+j).value;
		document.all.actionCodeI.value  = document.getElementById('actionCode'+j).value;

		document.all.printcount.value=val;
    document.frm.action = "f6842Cfm.jsp";
    document.frm.submit();
    return true;
}

function getItem(projectCode,num,gradeCode,packetCode)
{
    var prop="dialogHeight:600px; dialogWidth:750px; dialogLeft:400px; dialogTop:400px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
    var opcode = document.all.opcode.value;

    //��ѯ��Ʒ�б�
    var ret = window.showModalDialog("./f6842_getItem.jsp?packetCode="+packetCode+"&projectCode="+projectCode+"&phoneno=<%=strPhoneNo%>&num="+num+"&opcode="+opcode+"&gradeCode="+gradeCode,"",prop);
    if(ret!=undefined){
    	//�ڼ���%����%����%����%������
    	var arr = ret.split("%");
    	var lineNum = arr[0];
    	document.getElementById('packageCode'+lineNum).value = arr[4];
    	document.getElementById("ResName"+lineNum).value     = arr[1];
    }
}
</script>
</head>


<body>
<form name="frm" method="post">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
    <div id="title_zi">�û���Ϣ</div>
</div>
<table cellspacing="0">
    <tr>
        <td class="blue">�ֻ�����</td>
        <td>
            <input name="phoneNo" class="InputGrey" type="text" id="phoneNo" value="<%=strPhoneNo%>" readonly>
        <td class="blue">�ͻ�����</td>
        <td>
            <input name="bp_name" class="InputGrey" type="text" id="bp_name" size="60" value="<%=bp_name%>" readonly>
        </td>
    </tr>
</table>
<table cellspacing="0">
    <tr>
        <td class="blue">���֤��</td>
        <td>
            <input name="IccId" class="InputGrey" type="text" id="IccId" value="<%=IccId%>" readonly>
        </td>
        <td class="blue">�ͻ���ַ</td>
        <td>
            <input name="cust_address" class="InputGrey" type="text" id="cust_address" size="60" value="<%=cust_address%>" readonly>
        </td>
    </tr>
</table>
 </div>
 <div id="Operation_Table">
	<div class="title">
		<div id="title_zi">������ϸ</div>
	</div>
	<TABLE cellSpacing="0">
   	<TBODY>
		  <tr align="center">
	  		<th>ѡ��</td>
	  		<th>��ѯ</td>
			  <th>��Ʒ���</th>
			  <th>Ӫ��������</th>
			  <th>����</th>
			  <th>��Ʒ����</th>
			  <th>��ȡ��־</th>
			  <th>�н�����</th>
			  <th>������ˮ</th>
			  <th>�콱����</th>
			  <th>�콱����</th>
		  </tr>
  <%
  		String tbclass="";
		  for(int j=0;j<s7515InitArr.length;j++){
		  	tbclass = (j%2==0) ? "Grey" : "";
		  	if("Y".equals(s7515InitArr[j][10])){ continue; } //��Ϊ��ά��Ӫ����������ʾ
		  	/*���� Ӫ�������� �ȼ����� ���� ��Ʒ���� ��ȡ��־ �н����� ������ˮ �콱���� �콱���� ��ά���־λ Ӫ�������� �ȼ����� ������ ԤԼ��־*/
   %>
			<tr align="center">
				<td class="<%=tbclass%>"><input type="radio"  name="radio1" onClick = "changradio('<%=j%>')" value="<%=j%>"></td>
				<td class="<%=tbclass%>"><input name="query<%=j%>" type="button" class="b_text" disabled onClick="if(checkIfSelect()) getItem('<%=s7515InitArr[j][11]%>','<%=j%>','<%=s7515InitArr[j][12]%>','<%=s7515InitArr[j][13]%>')" value=��ѯ></TD>
				<td class="<%=tbclass%>"><%=s7515InitArr[j][1]%>&nbsp;</TD>
				<td class="<%=tbclass%>"><%=s7515InitArr[j][2]%>&nbsp;</TD>
				<td class="<%=tbclass%>"><%=s7515InitArr[j][3]%>&nbsp;</TD>
				<td class="<%=tbclass%>" ><input class="InputGrey" name="ResName<%=j%>" value="<%=s7515InitArr[j][4]%>" readonly>&nbsp;</td>
				<td class="<%=tbclass%>"><%="N".equals(s7515InitArr[j][5])?"δ��ȡ":"����ȡ"%>&nbsp;</TD>
				<td class="<%=tbclass%>"><%=s7515InitArr[j][6]%>&nbsp;</TD>
				<td class="<%=tbclass%>"><%=s7515InitArr[j][7]%>&nbsp;</TD>
				<td class="<%=tbclass%>"><%=s7515InitArr[j][8]%>&nbsp;</TD>
				<td class="<%=tbclass%>"><%=s7515InitArr[j][9]%>&nbsp;</TD>

				<input name="validQrcode<%=j%>" type="hidden" value="<%=s7515InitArr[j][10]%>">
				<input name="projectCode<%=j%>" type="hidden" value="<%=s7515InitArr[j][11]%>">
				<input name="gradeCode<%=j%>"   type="hidden" value="<%=s7515InitArr[j][12]%>">
				<input name="packageCode<%=j%>" type="hidden" value="<%=s7515InitArr[j][13]%>">
				<input name="register<%=j%>"    type="hidden" value="<%=s7515InitArr[j][14]%>">
				<input name="winAccept<%=j%>"   type="hidden" value="<%=s7515InitArr[j][15]%>">
				<input name="actionCode<%=j%>"  type="hidden" value="<%=s7515InitArr[j][16]%>">
			</tr>
	<%
		}
	%>
 		</TBODY>
	</TABLE>


  <table cellspacing="0">
    <tr>
    	<td colspan="4" id="footer">
				<div align="center">
				<input name="confirm" class="b_foot" id="confirm" type="button"  value="ȷ��&��ӡ" onClick="printCommit()" >&nbsp;
				<input name="back" class="b_foot" onClick="window.location.href='f6842.jsp?activePhone=<%=strPhoneNo%>'" type="button" value="����">&nbsp;
				</div>
			</td>
   	</tr>
	</TABLE>
 <%@ include file="/npage/include/footer.jsp" %>
 <input type="hidden" name="cust_info"><!--important-->
 <input type="hidden" name="smName">   <!--important-->
 <input type="hidden" name="opr_info"> <!--important-->
 <input type="hidden" name="note_info1">
 <input type="hidden" name="note_info2">
 <input type="hidden" name="note_info3">
 <input type="hidden" name="note_info4">

 <input type="hidden" name="hownum">
 <input type="hidden" name="projectCodeI">
 <input type="hidden" name="gradeCodeI">
 <input type="hidden" name="packageCodeI">
 <input type="hidden" name="winAcceptI">
 <input type="hidden" name="actionCodeI">

<input type="hidden" name="opcode" value="<%=opCode%>">
<input type="hidden" name="ressum" value="">
<input type="hidden" name="printAccept" value="<%=printAccept%>">
<input type="hidden" name="printPackageCont" value="">
<input type="hidden" name="printcount">

<input type="hidden" name="phone_no" value="<%=strPhoneNo%>">
<input type="hidden" name="opNote">


</form>
</body>
</html>

