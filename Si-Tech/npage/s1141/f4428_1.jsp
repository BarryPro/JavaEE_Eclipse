<%
/********************
 version v2.0
 ������: si-tech
 update 
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
    response.setHeader("Pragma","No-cache");
    response.setHeader("Cache-Control","no-cache");
    response.setDateHeader("Expires", 0);
	    
	String printAccept="";
	printAccept = getMaxAccept();

	//String opCode = "4288";
	//String opName = "���еش���Уӭ������������";
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	
	String phoneNo = WtcUtil.repNull(request.getParameter("phone_no"));
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String workNo = (String)session.getAttribute("workNo");
	
%>	
<wtc:service name="s4428Init" routerKey="phone" retCode="initRetCode" retMsg="initRetMsg" routerValue="<%=phoneNo%>" outnum="11">
<wtc:param value="<%=phoneNo%>"/>
<wtc:param value="<%=workNo%>"/>
<wtc:param value="<%=orgCode%>"/>
<wtc:param value="<%=opCode%>"/>
</wtc:service>
<wtc:array id="initStr" scope="end"/>
<%
	if(!(initRetCode.equals("000000")))
	{
%>
		<script language="javascript">
	 	rdShowMessageDialog("��ѯʧ�ܣ�" + "<%=initRetMsg%>",0);	
	 	window.location="f4428_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
		</script>
<%
		return;
	}

%>
<HEAD>

<script language="JavaScript">
<!--

onload=function()
{
  	var opCode = "<%=opCode%>";
  	if(opCode=="4429")
  	{
		document.all.tongzhi_no.disabled=true;
		document.all.shen.style.display="none";
		document.all.chong.style.display="";
  	}
  	else if(opCode=="4428")
  	{
  		document.all.chong.style.display="none";
		document.all.shen.style.display="";
  	}
}
function getBytesLength(str) 
{
	return str.replace(/[^\x00-\xff]/gi, "--").length; 
}

function printCommit()
{
	var opCode = "<%=opCode%>";
	if(opCode=="4428")
  	{
		if(document.all.tongzhi_no.value=="")
		{
			 rdShowMessageDialog("֪ͨ���Ų���Ϊ��!");
		     document.frm.tongzhi_no.focus();
		     return false;
		}
	}
	if(getBytesLength(document.all.opNote.value.trim()) > 60)
	{
		rdShowMessageDialog("��ע��������60��Ӣ���ַ���32�������ַ�!",1);
		return;
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
	 
	cust_info+="�ֻ����룺   "+document.all.phone_no.value+"|";
	cust_info+="�ͻ�������   "+document.all.cust_name.value+"|";
	
	opr_info+="ҵ������: 09���������ͻ���"+"|";
	opr_info+="�ͻ�Ʒ�ƣ�"+document.all.sm_code.value+"|";
	note_info1+="��ע����ӭ���μӹ��ƶ������еش�09��У�������������ѡ�����������������ɵ�Ԥ���Ϊ100Ԫ��������50Ԫ�����Կ������������ͣ�10Ԫ/��,��������5���¡����������������ѻ��2���£����������£��ڲ��ܽ����ʷѱ�����Ҳ���ͬʱ����������������Ӫ�����"+"|";
  	
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
}

function doCfm()
{
	//getAfterPrompt();
	if(document.frm.op_code.value == 4428)
	{
		document.frm.action="f4428Cfm.jsp";
	}
	if(document.frm.op_code.value == 4429)
	{
		document.frm.action="f4429Cfm.jsp";
	}
	document.frm.submit();
}

function doCfm1()
{
	//getAfterPrompt();
	document.frm.action="f4429Cfm.jsp";
	document.frm.submit();
}

-->
</script>

<title>���еش���Уӭ������������</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
</head>
<BODY>
<form action="f4428Cfm.jsp" method="post" name="frm">
<%@ include file="/npage/include/header.jsp" %>     	
<div class="title">
	<div id="title_zi"><%=opName%></div>
</div>
	<input type="hidden" name="op_code" id="op_code" value="<%=opCode%>">
	<input type="hidden" name="op_name" id="op_name" value="<%=opName%>">
	<table cellspacing="0" >
    <tr> 
        <td class=blue>��������</td>
        <td ><%=opName%></td>
        <td class=blue>֪ͨ����</td>
        <td >
            <input name="tongzhi_no" value="" type="text" class="text" v_must=1  id="tongzhi_no" maxlength="6" > 	
        </td>
    </tr>
    <tr> 
        <td class=blue>�ֻ�����</td>
        <td>
        	<input name="phone_no" value="<%=phoneNo%>" type="text" class="InputGrey" v_must=1 readonly id="phone_no" maxlength="20" size="40"> 
   		</td>
   		<td class=blue>�û�ID</td>
        <td>
        	<input name="id_no" value="<%=initStr[0][2]%>" type="text" class="InputGrey" v_must=1 readonly id="id_no" maxlength="20" size="40"> 
   		</td>
   	</tr>
   	<tr>
        <td class=blue>�ͻ�����</td>
        <td>
            <input name="cust_name" value="<%=initStr[0][3]%>" type="text" class="InputGrey" v_must=1 readonly id="cust_name" maxlength="20" size="40"> 
        </td>
        <td class=blue>�ͻ���ַ</td>
        <td>
            <input name="cust_add" value="<%=initStr[0][4]%>" type="text" class="InputGrey" v_must=1 readonly id="cust_add" maxlength="20" size="40"> 
        </td>
  	<tr>
  		<td class=blue>ҵ��Ʒ��</td>
        <td>
            <input name="sm_code" value="<%=initStr[0][6]%>" type="text" class="InputGrey" v_must=1 readonly id="sm_code" maxlength="20" > 
        </td>
    	<td class=blue>����״̬</td>
        <td>
            <input name="run_type" value="<%=initStr[0][5]%>" type="text" class="InputGrey" v_must=1 readonly id="run_type" maxlength="20" > 
        </td>
    </tr>
    <tr>         
        <td class=blue>֤������</td>
        <td>
            <input name="idName" value="<%=initStr[0][8]%>" type="text" class="InputGrey" v_must=1 readonly id="idName" maxlength="20" > 
        </td>
        <td class=blue>֤������</td>
        <td>
            <input name="idIccid" value="<%=initStr[0][7]%>" type="text" class="InputGrey" v_must=1 readonly id="idIccid" maxlength="20" > 
        </td>
    </tr>
    <tr>  
    	<td class=blue>����ҵ��</td>
        <td>
            <input name="user_type" value="���еش���������" type="text" class="InputGrey" v_must=1 readonly id="user_type" maxlength="20" > 	
        </td>
        <td class=blue>������ˮ</td>
        <td>
            <input name="login_accept" value="<%=printAccept%>" type="text" class="InputGrey" v_must=1 readonly id="login_accept" maxlength="20" > 	
        </td>
    </tr>
    <tr>
    	<td class=blue>��ע</td>
        <td colspan="3">
            <input name="opNote" type="text"  id="opNote" size="60" maxlength="60" value="�ֻ���<%=phoneNo%>���ж��еش���Уӭ������������<%=opCode.equals("4428") ? "����" : "����"%>" > 
        </td>
    </tr>
    <tr id="shen"> 
        <td colspan="4" align="center" id="footer">
            <input name="confirm" type="button" class="b_foot" index="2" value="ȷ��&��ӡ" onClick="printCommit()"  >&nbsp;
            <input name="back" onClick="history.go(-1)" type="button" class="b_foot" value="����">
        </td>
    </tr>
    <tr id="chong"> 
        <td colspan="4" align="center" id="footer">
            <input name="confirm1" type="button" class="b_foot" index="2" value="ȷ��" onClick="doCfm1()"  >&nbsp;
            <input name="back1" onClick="history.go(-1)" type="button" class="b_foot" value="����">
        </td>
    </tr>
</table>
       <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</BODY>
</HTML>
