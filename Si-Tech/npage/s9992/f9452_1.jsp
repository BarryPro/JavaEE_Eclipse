<% 
  /*
   * ����: ������˻��ֽ��ֵ
�� * �汾: v1.00
�� * ����: 2010/02/24
�� * ����: dujl
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
   *  
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>

<html>
<META http-equiv=Content-Type content="text/html; charset=GBK">
<head>
<title>������˻��ֽ��ֵ</title>

<%
String opCode = "9452";
String opName = "������˻��ֽ��ֵ";

String work_no = (String) session.getAttribute("workNo");
String org_code = (String) session.getAttribute("orgCode");
String regionCode = org_code.substring(0, 2);

String phoneNo = WtcUtil.repNull(request.getParameter("srv_no"));
String cCPassWd = WtcUtil.repNull(request.getParameter("cCPassWd"));
String idCardType = WtcUtil.repNull(request.getParameter("idCardType"));
String idCardNum = WtcUtil.repNull(request.getParameter("idCardNum"));

String userStatus="";
String statusChgTime="";
String mPay="";
String homeProv="";

String printAccept="";
printAccept = getMaxAccept();

System.out.println("###########gaopengSeeLog############################phoneNo->" + phoneNo);
System.out.println("###########gaopengSeeLog############################cCPassWd->" + cCPassWd);
System.out.println("###########gaopengSeeLog############################idCardType->" + idCardType);
System.out.println("###########gaopengSeeLog############################idCardNum->" + idCardNum);
%>

<wtc:service name="s9452Init" routerKey="phone" routerValue="<%=phoneNo%>" retCode="initRetCode" retMsg="initRetMsg" outnum="6">
<wtc:param value="<%=work_no%>"/>
<wtc:param value="<%=phoneNo%>"/>
<wtc:param value="<%=opCode%>"/>
<wtc:param value="<%=cCPassWd%>"/>
<wtc:param value="<%=idCardType%>"/>
<wtc:param value="<%=idCardNum%>"/>
</wtc:service>
<wtc:array id="result" scope="end"/>

<%
System.out.println("gaopengSeeLog===========initRetCode=================="+initRetCode);
System.out.println("gaopengSeeLog===========initRetMsg==================="+initRetMsg);

System.out.println("gaopengSeeLog===========result[0][2]=================="+result[0][2]);
if(!(initRetCode.equals("000000")))
{
%>
	<script language=javascript>
		rdShowMessageDialog("������Ϣ��<%=initRetMsg%>");
		window.location="f9452_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	</script>
<%
	return;
}
if((result==null) || (!(result[0][0].equals("000000"))))
{
%>
	<script language=javascript>
		rdShowMessageDialog("������Ϣ��<%=result[0][1]%>");
		window.location="f9452_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	</script>
<%
	return;
}
if(result[0][2].equals("00"))
{
	userStatus="����";
}
else if(result[0][2].equals("01"))
{
	userStatus="����ͣ��";
}
else if(result[0][2].equals("02"))
{
	userStatus="ͣ��";
}
else if(result[0][2].equals("03"))
{
	userStatus="Ԥ����";
}
else if(result[0][2].equals("04"))
{
	userStatus="����";
}
else if(result[0][2].equals("05"))
{
	userStatus="����";
}
else if(result[0][2].equals("06"))
{
	userStatus="�ĺ�";
}
else if(result[0][2].equals("90"))
{
	userStatus="�������û�";
}
else if(result[0][2].equals("99"))
{
	userStatus="�˺��벻����";
}

if((result[0][2].equals("01")) || (result[0][2].equals("02")) || (result[0][2].equals("03")) || (result[0][2].equals("04")) || (result[0][2].equals("99")))
{
System.out.println("gaopengSeeLog=======11====result[0][2]=================="+result[0][2]);
%>
	<script language="JavaScript">
		rdShowMessageDialog("�û���ǰ״̬Ϊ<%=userStatus%>�������ֵ��");
		window.location.href="f9452_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	</script>
<%
	return;
}

statusChgTime=result[0][3];

if(result[0][4].equals("0"))
{
	mPay="��ͨ";
}
else if(result[0][4].equals("1"))
{
	mPay="δ��ͨ";
	
%>
	<script language=javascript>
		rdShowMessageDialog("���û�δ��ͨ�ֻ�֧�����˻����޷���ֵ��");
	</script>
<%
}

if(result[0][5].equals("471"))
{
	homeProv="���ɹ�";
}
else if(result[0][5].equals("100"))
{
	homeProv="����";
}
else if(result[0][5].equals("220"))
{
	homeProv="���";
}
else if(result[0][5].equals("531"))
{
	homeProv="ɽ��";
}
else if(result[0][5].equals("311"))
{
	homeProv="�ӱ�";
}
else if(result[0][5].equals("351"))
{
	homeProv="ɽ��";
}
else if(result[0][5].equals("551"))
{
	homeProv="����";
}
else if(result[0][5].equals("210"))
{
	homeProv="�Ϻ�";
}
else if(result[0][5].equals("250"))
{
	homeProv="����";
}
else if(result[0][5].equals("571"))
{
	homeProv="�㽭";
}
else if(result[0][5].equals("591"))
{
	homeProv="����";
}
else if(result[0][5].equals("898"))
{
	homeProv="����";
}
else if(result[0][5].equals("200"))
{
	homeProv="�㶫";
}
else if(result[0][5].equals("771"))
{
	homeProv="����";
}
else if(result[0][5].equals("971"))
{
	homeProv="�ຣ";
}
else if(result[0][5].equals("270"))
{
	homeProv="����";
}
else if(result[0][5].equals("731"))
{
	homeProv="����";
}
else if(result[0][5].equals("791"))
{
	homeProv="����";
}
else if(result[0][5].equals("371"))
{
	homeProv="����";
}
else if(result[0][5].equals("891"))
{
	homeProv="����";
}
else if(result[0][5].equals("280"))
{
	homeProv="�Ĵ�";
}
else if(result[0][5].equals("230"))
{
	homeProv="����";
}
else if(result[0][5].equals("290"))
{
	homeProv="����";
}
else if(result[0][5].equals("851"))
{
	homeProv="����";
}
else if(result[0][5].equals("871"))
{
	homeProv="����";
}
else if(result[0][5].equals("931"))
{
	homeProv="����";
}
else if(result[0][5].equals("951"))
{
	homeProv="����";
}
else if(result[0][5].equals("991"))
{
	homeProv="�½�";
}
else if(result[0][5].equals("431"))
{
	homeProv="����";
}
else if(result[0][5].equals("240"))
{
	homeProv="����";
}
else if(result[0][5].equals("451"))
{
	homeProv="������";
}
else if(result[0][5].equals("999"))
{
	homeProv="��������";
}
%>

<script language=javascript>
function printCommit()
{
	if(document.all.payMoney.value.trim()=="")
	{
		rdShowMessageDialog("�������ֵ��");
		return false;
	}
	if(document.all.homeProvCode.value.trim()=="")
	{
		rdShowMessageDialog("�������ʡ����Ϊ�գ�");
		return false;
	}
	
	var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes"); 
	if(typeof(ret)!="undefined")
	{
		if((ret=="confirm"))
		{
			if(rdShowConfirmDialog('ȷ�ϵ��������')==1)
			{
				doCfm();
			}
		}
		if(ret=="continueSub")
		{
			if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
			{
				doCfm();
			}
		}
	}
	else
	{
		if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
		{
			doCfm();
		}
	}
}

function doCfm()
{
	frm.submit();
}

function showPrtDlg(printType,DlgMessage,submitCfm)
{  //��ʾ��ӡ�Ի��� 
	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var pType="subprint";
	var billType="1";  
	var printStr = printInfo(printType);
   
	var mode_code=null;
	var fav_code=null;
	var area_code=null;
	
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage;
	path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept=<%=printAccept%>&phoneNo=<%=activePhone%>&submitCfm=" + submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	var ret=window.showModalDialog(path,printStr,prop);
	return ret;
}

function printInfo(printType)
{
     var cust_info="";
	 var opr_info="";
	 var note_info1="";
	 var note_info2="";
	 var note_info3="";
	 var note_info4="";
  
	 var retInfo = "";
	 
	cust_info+="�ֻ����룺   "+document.all.phoneNo.value+"|";
	cust_info+="�ͻ�������   ";
	
	opr_info+="������ˮ�� <%=printAccept%>"+"|";
	opr_info+="�������ݣ� �ֻ�����"+document.all.phoneNo.value+"������˻��ֽ��ֵ"+document.all.payMoney.value+"Ԫ"+"|";
	note_info1+="��ע��������˻��ֽ��ֵ"+"|";
  	
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
}

</script>

</head>
<body>
<form name="frm" method="POST" action="f9452Cfm.jsp">
<%@ include file="/npage/include/header.jsp" %>

<div class="title">
    <div id="title_zi">�û���Ϣ</div>
</div>
<table cellspacing="0">
	<tr>
		<td class="blue" width="15%" nowrap>�ֻ�����</td>
	    <td width="35%">
	    	<input class="InputGrey" type="text" name="phoneNo" id="phoneNo" value="<%=phoneNo%>" size="20" readonly>
	    </td>
	    <td class="blue" width="15%" nowrap>�û�����ʡ</td>
	    <td width="35%">
	    	<input class="InputGrey" type="text" name="homeProv" id="homeProv" value="<%=homeProv%>" size="20" readonly>
	    </td>
	</tr>
	<tr>
		<td class="blue" width="15%" nowrap>�û�״̬</td>
	    <td width="35%">
	    	<input class="InputGrey" type="text" name="userStatus" id="userStatus" value="<%=userStatus%>" size="20" readonly>
	    </td>
	    <td class="blue" width="15%" nowrap>�û�״̬���ʱ��</td>
	    <td width="35%">
	    	<input class="InputGrey" type="text" name="statusChgTime" id="statusChgTime" value="<%=statusChgTime%>" size="20" readonly>
	    </td>
	</tr>
	<tr>
	    <td class="blue" width="15%" nowrap>�Ƿ�ͨ�ֻ�֧��ҵ��</td>
	    <td width="35%">
	    	<input class="InputGrey" type="text" name="mPay" id="mPay" value="<%=mPay%>" size="20" readonly>
	    </td>
	    <td nowrap class="blue" width="15%">��ֵ���</td>
	    <td width="35%">
	    	<input class="button" type="text" name="payMoney" id="payMoney" size="20" maxlength="17">
	    </td>
	</tr>
    <tr>
        <td colspan="7" id="footer">
            <input class="b_foot" type="button" name="b_print" value="ȷ��&��ӡ" onClick="printCommit();">
            &nbsp;
            <input class="b_foot" type="button" name="b_clear" value="����" onClick="history.go(-1);">
        </td>
    </tr>
</table>
<input type="hidden" name="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" value="<%=opName%>">
<input type="hidden" name="loginAccept" value="<%=printAccept%>">
<input type="hidden" name="homeProvCode" value="<%=result[0][5]%>">

    <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>