<% 
  /*
   * ����: Ӫҵ������֧������
�� * �汾: v1.00
�� * ����: 2010/02/25
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
<title>Ӫҵ������֧������</title>

<%
	String opCode = "9454";
	String opName = "Ӫҵ������֧������";
	
	String work_no = (String) session.getAttribute("workNo");
	String org_code = (String) session.getAttribute("orgCode");
	String regionCode = org_code.substring(0, 2);
	
	String phoneNo = WtcUtil.repNull(request.getParameter("srv_no"));
	String idCardType = WtcUtil.repNull(request.getParameter("idCardType"));
	String idCardNum = WtcUtil.repNull(request.getParameter("idCardNum"));

	String printAccept="";
	printAccept = getMaxAccept();
	
	String returnMessage="";
	String returnCode="";

	String [] inputParam = new String [6] ;
	inputParam[0]="01";
	inputParam[1]=phoneNo;
	inputParam[2]="";
	inputParam[3]=idCardType;
	inputParam[4]=idCardNum;
	inputParam[5]=work_no;

	System.out.println("#######################################phoneNo->" + phoneNo);
	System.out.println("#######################################idCardType->" + idCardType);
	System.out.println("#######################################idCardNum->" + idCardNum);
%>

<wtc:service name="sPubCustCheck" routerKey="phone" routerValue="<%=phoneNo%>" retCode="initRetCode" retMsg="initRetMsg" outnum="5">
<wtc:param value="<%=inputParam[0]%>"/>
<wtc:param value="<%=inputParam[1]%>"/>
<wtc:param value="<%=inputParam[2]%>"/>
<wtc:param value="<%=inputParam[3]%>"/>
<wtc:param value="<%=inputParam[4]%>"/>
<wtc:param value="<%=inputParam[5]%>"/>
</wtc:service>
<wtc:array id="result" scope="end"/>

<%
	String custname="";
	String runcode="";
	String brand="";
	
	System.out.println("initRetCode=================="+initRetCode);
	System.out.println("initRetMsg==================="+initRetMsg);

if(!(initRetCode.equals("000000")))
{
%>
	<script language=javascript>
		rdShowMessageDialog("������Ϣ��<%=initRetMsg%>");
		window.location="f9454_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	</script>
<%
	return;
}
if((result != null) && (result.length > 0))
{
	custname=result[0][3];
	runcode=result[0][0];
	brand=result[0][2];
}

else
{
%>
	<script language=javascript>
		rdShowMessageDialog("�û���Ȩδͨ����");
		window.location="f9454_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	</script>
<%
	return;
}
%>

<script language=javascript>
function printCommit()
{
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
	cust_info+="�ͻ�������   "+document.all.custName.value+"|";
	
	opr_info+="������ˮ�� <%=printAccept%>"+"|";
	opr_info+="�������ݣ� �ֻ�����"+document.all.phoneNo.value+"Ӫҵ������֧������"+"|";
	note_info1+="��ע��Ӫҵ������֧������"+"|";
  	
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
}

</script>

</head>
<body>
<form name="frm" method="POST" action="f9454Cfm.jsp">
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
	    <td class="blue" width="15%" nowrap>�ͻ�����</td>
	    <td width="35%">
	    	<input class="InputGrey" type="text" name="custName" id="custName" value="<%=custname%>" size="20" readonly>
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

    <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>