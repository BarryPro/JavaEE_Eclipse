<%
/********************
 version v2.0
 ������: si-tech
 ����: dujl
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%

%>
<html>
<head>
<title>sp��ֵҵ���ײͳ���</title>
<%
	
	String opCode="9897";
	String opName="sp��ֵҵ���ײͳ���";
	String loginNo = (String)session.getAttribute("workNo");
	String loginName = (String)session.getAttribute("workName");
	String regionCode = (String)session.getAttribute("regCode");

	String phoneNo =(String)request.getParameter("srv_no");	//�ֻ�����
	String backaccept = request.getParameter("backaccept");
	System.out.println("phoneNo="+phoneNo);
	System.out.println("backaccept="+backaccept);
    
    String retMsg3="";
    
    String  inputParsm [] = new String[4];
	inputParsm[0] = phoneNo;
	inputParsm[1] = loginNo;
	inputParsm[2] = backaccept;
	inputParsm[3] = opCode;
    
    String prtSql="select to_char(sMaxSysAccept.nextval) from dual";
    
%>
<wtc:service name="s9897Init" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg1" outnum="10">
	<wtc:param value="<%=inputParsm[0]%>"/>
	<wtc:param value="<%=inputParsm[1]%>"/>
	<wtc:param value="<%=inputParsm[2]%>"/>
	<wtc:param value="<%=inputParsm[3]%>"/>
</wtc:service>
<wtc:array id="tempArr" scope="end"/>

<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="printAccept"/>

<%
String errCode = retCode;
String errMsg = retMsg1;

System.out.println("errCode="+errCode);
System.out.println("errMsg ="+errMsg);

if(tempArr.length==0)
{
   retMsg3 = "s9897Init��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
}
else if(!(errCode.equals("000000")))
{
%>
	<script language="javascript">
	 	rdShowMessageDialog("������룺<%=errCode%>��������Ϣ��<%=errMsg%>");
	 	removeCurrentTab();
	</script>
<%
}
%>

</script>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language=javascript>
function frmCfm()
{
	frm.submit();
	return true;
}

function printCommit()
{
	getAfterPrompt();
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
	var opCode="2293" ;                   			 		//��������
	var phoneNo="<%=phoneNo%>";                  	 		//�ͻ��绰

	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
	path+="&mode_code="+mode_code+
		"&fav_code="+fav_code+"&area_code="+area_code+
		"&opCode=<%=opCode%>&sysAccept="+sysAccept+
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

	opr_info+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	cust_info+="�ֻ����룺"+document.all.phone_no.value+"|";
	cust_info+="�ͻ�������"+document.all.cust_name.value+"|";

	opr_info+="�������ݣ�sp��ֵҵ���ײͳ���"+"|";
  	opr_info+="ҵ����ˮ��"+document.all.login_accept.value+"|";
  	note_info1+="��ע��sp��ֵҵ���ײͳ���"+"|";
	
    retInfo=strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
    return retInfo;	
}

</script>
</head>
<body>
<form name="frm" method="post" action="f9897Cfm.jsp">
	<%@ include file="/npage/include/header.jsp" %>
<table cellspacing="0">
	<tr>
		<td class="blue">��������</td>
		<td class="blue" colspan="3"><b>sp��ֵҵ���ײͳ���</b></td>
	</tr>
	<tr>
		<td class="blue">�ֻ�����</td>
		<td>
			<input name="phone_no" value="<%=phoneNo%>" type="text" class="InputGrey" v_must=1 readonly id="phone_no" maxlength="20">
		</td>
		<td class="blue">�ͻ�����</td>
		<td>
			<input name="cust_name" value="<%=tempArr[0][2]%>" type="text" class="InputGrey" v_must=1 readonly id="cust_name" maxlength="20" >
		</td>
	</tr>
	<tr>
		<td class="blue">Ӫ�����������</td>
		<td >
			<input name="type_name" type="text" class="InputGrey" id="type_name" value="<%=tempArr[0][4]%>" readonly>
		</td>
		<td class="blue">Ӫ��������</td>
		<td>
			<input name="sale_name" type="text"  class="InputGrey" id="sale_name" value="<%=tempArr[0][6]%>" readonly>
		</td>
	</tr>
	<tr class="blue">
		<td class="blue">Ԥ�滰�ѽ�Ԫ��</td>
		<td>
			<input name="prepay_pay" type="text"  class="InputGrey" id="prepay_pay" value="<%=tempArr[0][7]%>" readonly>
		</td>
		<td class="blue">����ʱ�����£�</td>
		<td colspan="3">
			<input name="consume_term" type="text"  class="InputGrey" id="consume_term" value="<%=tempArr[0][8]%>" readonly>
		</td>
	</tr>
	<tr>
		<td colspan="4" align="center" id="footer"> 
			<input name="confirm" type="button" class="b_foot" index="2" value="ȷ��&��ӡ" onClick="printCommit()">
			&nbsp;
			<input name="reset" type="reset" class="b_foot" onClick="history.go(-1);" value="����" >
			&nbsp;
			<input name="back" onClick="removeCurrentTab()" type="button" class="b_foot" value="�ر�">
			&nbsp; 
		</td>
	</tr>
</table>
    <input type="hidden" name="work_no" value="<%=loginName%>">
	<input type="hidden" name="opCode" value="<%=opCode%>">
    <input type="hidden" name="login_accept" value="<%=printAccept%>">
	<input type="hidden" name="backaccept" value="<%=backaccept%>">
	<input type="hidden" name="sale_type" value="<%=tempArr[0][3]%>">
	<input type="hidden" name="sale_code" value="<%=tempArr[0][5]%>">
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>

