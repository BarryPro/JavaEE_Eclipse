<%
    /********************
     version v2.0
     ������: si-tech
     *
     *update:zhanghonga@2008-08-28 ҳ�����,�޸���ʽ
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>

<html>
<META http-equiv=Content-Type content="text/html; charset=GBK">
<head>
<title>�ط����</title>
<%
    String opCode = "9992";
    String opName = "�ֻ�֧�����˻�����";
    String loginPwd    = (String)session.getAttribute("password"); //��������
    String work_no = (String) session.getAttribute("workNo");
    String loginName = (String) session.getAttribute("workName");
    String org_code = (String) session.getAttribute("orgCode");
    String regionCode = org_code.substring(0, 2);
    String op_code = "9992";
    
    String printAccept="";
	printAccept = getMaxAccept();

    int srvStrIndex = 0;
    activePhone = WtcUtil.repNull(request.getParameter("activePhone"));
    String srv_no = WtcUtil.repNull(request.getParameter("srv_no"));
    System.out.println("#######################################srv_no->" + srv_no);

%>

<wtc:service name="s9992Init" routerKey="phone" retCode="initRetCode" retMsg="initRetMsg" routerValue="<%=srv_no%>" outnum="11">
		<wtc:param value=" "/>
		<wtc:param value="01"/>
		<wtc:param value="<%=op_code%>"/>
		<wtc:param value="<%=work_no%>"/>
		<wtc:param value="<%=loginPwd%>"/>
		<wtc:param value="<%=srv_no%>"/>
		<wtc:param value=" "/>
		<wtc:param value="<%=org_code%>"/>
</wtc:service>
<wtc:array id="initStr" scope="end"/>

<%
	System.out.println("retCoderetCoderetCode="+initRetCode);
	System.out.println("initRetMsginitRetMsginitRetMsg="+initRetMsg);
	if (!(initRetCode.equals("000000")))
	{
%>
		<script language=javascript>
        	rdShowMessageDialog("������Ϣ��<%=initRetMsg%>");
        	window.location="f9992_login.jsp?opCode=<%=op_code%>&activePhone=<%=srv_no%>"
			
        </script>
<%
		return;
	}
    if ((initStr==null)||(initStr.length==0))
    {
%>
        <script language=javascript>
        	rdShowMessageDialog("������Ϣ��<%=initStr[0][1]%>");
        	
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
	cust_info+="�ͻ���ַ��	 "+document.all.custAdress.value+"|";
	cust_info+="֤�����룺	 "+document.all.idIccid.value+"|";
	
	opr_info+="������ˮ�� <%=printAccept%>"+"|";
	opr_info+="�������ݣ� �ֻ�����"+document.all.phoneNo.value+"�ֻ�֧�����˻�����"+"|";
	note_info1+="��ע���ֻ�֧�����˻�����"+"|";
  	
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
}


</script>
</head>
<body>
<form name="frm" method="POST" action="f9992Cfm.jsp">
<%@ include file="/npage/include/header.jsp" %>

<div class="title">
    <div id="title_zi">�û���Ϣ</div>
</div>
<table cellspacing="0">
	<tr>
		<td class="blue" width="15%" nowrap>�ֻ�����</td>
	    <td nowrap colspan="2" width="35%"><%=srv_no%>
	    </td>
	    <td class="blue" width="15%" nowrap>�û�ID</td>
	    <td nowrap colspan="2"><%=initStr[0][2]%>
	    </td>
	</tr>
	<tr>
		<td class="blue" width="15%" nowrap>�ͻ�����</td>
	    <td nowrap colspan="2" width="35%"><%=initStr[0][3]%>
	    </td>
	    <td class="blue" width="15%" nowrap>�ͻ���ַ</td>
	    <td nowrap colspan="2"><%=initStr[0][4]%>
	    </td>
	</tr>
	<tr>
	    <td class="blue" width="15%" nowrap>��ǰ״̬</td>
	    <td nowrap colspan="2" width="35%"><%=initStr[0][5]%>
	    </td>
	    <td nowrap class="blue" width="15%">ҵ��Ʒ��</td>
	    <td nowrap colspan="2"><%=initStr[0][6]%>
	    </td>
	</tr>
	<tr>
	    <td class="blue" width="15%" nowrap>֤������</td>
	    <td nowrap colspan="2" width="35%"><%=initStr[0][8]%>
	    </td>
	    <td class="blue" width="15%" nowrap>֤������</td>
	    <td nowrap colspan="2"><%=initStr[0][7]%>
	    </td>
	</tr>
	<tr>
	    <td class="blue" width="15%" nowrap>��ǰǷ��</td>
	    <td nowrap colspan="2" width="35%"><%=initStr[0][9]%>
	    </td>
	    <td class="blue" width="15%" nowrap>��ǰԤ��</td>
	    <td nowrap colspan="2"><%=initStr[0][10]%>
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

<input type="hidden" name="opCode" value="<%=opCode%>" >
<input type="hidden" name="phoneNo" value="<%=srv_no%>" >
<input type="hidden" name="printAccept" value="<%=printAccept%>">
<input type="hidden" name="custId" value="<%=initStr[0][2]%>" >
<input type="hidden" name="custName" value="<%=initStr[0][3]%>" >
<input type="hidden" name="custAdress" value="<%=initStr[0][4]%>" >
<input type="hidden" name="runName" value="<%=initStr[0][5]%>" >
<input type="hidden" name="smName" value="<%=initStr[0][6]%>" >
<input type="hidden" name="idIccid" value="<%=initStr[0][7]%>" >
<input type="hidden" name="idName" value="<%=initStr[0][8]%>" >
<input type="hidden" name="totalOwe" value="<%=initStr[0][9]%>" >
<input type="hidden" name="prepay" value="<%=initStr[0][10]%>" >

    <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
