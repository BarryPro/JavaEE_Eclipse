<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
   /*
   * ����:�������ֻ�Ʊ֧��
   * �汾: 1.0
   * ����: 2009/8/14
   * ����: dujl
   * ��Ȩ: si-tech
   */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*"%>
<%@ page import="com.sitech.boss.util.page.*"%>
<%@ include file="../../npage/public/fPubPrintNote.jsp" %>
		
<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
 
	String opCode = "6946";
	String opName = "�������ֻ�Ʊ֧��";
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String workNo = (String)session.getAttribute("workNo");

	

	String printAccept = request.getParameter("printAccept");
	String payType = request.getParameter("set_tlement");
	String getType = request.getParameter("getType");
	String mobileNo = request.getParameter("mobileNo");
	String phoneNo = request.getParameter("phoneNo");
	String custName = request.getParameter("custName");
	String idType = request.getParameter("idType");
	String idCard = request.getParameter("idCard");
	String custAddress = request.getParameter("custAddress");
	String postCode = request.getParameter("postCode");
	String oprNumb = request.getParameter("opr_numb");
	String tktType = request.getParameter("tkt_type_array");
	String tktSum = request.getParameter("tkt_sum_array");
	String tktDate = request.getParameter("tkt_date_array");
	String payFee = request.getParameter("pay_fee1");
	String commitType = request.getParameter("commit_type");
	String svoucher = request.getParameter("s_voucher");
	String[] tktTypeList = tktType.split("[|]");
	String[] tktSumList = tktSum.split("[|]");
	String[] tktDateList = tktDate.split("[|]");
	String orderCode = "";
	Map errType = new HashMap();
	errType.put("00","�ɹ�");
	errType.put("01","δԤ��");
	errType.put("02","������");
	errType.put("03","����Դ���ͷţ�������Ԥ��");
	errType.put("04","�޴˽���");
	errType.put("98","�ط��ڲ�����");
	errType.put("99","δ֪����");
	
	System.out.println(printAccept);	
	StringBuffer  insql = new StringBuffer();

	insql.append("select tickettype_code,tickettype_name ");
	insql.append(" from sticketcode ");
	insql.append(" where use_flag='Y' and biz_type='01' ");
	insql.append(" order by tickettype_code  ");
	System.out.println("insql====="+insql);
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
<wtc:sql><%=insql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="roleDetailData" scope="end" />
<%@ include file="/npage/include/footer.jsp" %>
<% 		
	if(!(retCode1.equals("000000"))){
%>
		<script language="javascript">
	 	rdShowMessageDialog("��ѯƱ������ʧ�ܣ�" + "[<%=retCode1%>]"+ "<%=retMsg1%>");	
	 	removeCurrentTab();
		</script>
<%		
		return;				 			
	}
	Map tktTypeName = new HashMap();
	for(int j = 0; j < roleDetailData.length; j++)
	{
		tktTypeName.put(roleDetailData[j][0],roleDetailData[j][1]);
	}
	
	insql = new StringBuffer();
	insql.append("select idtype_name ");
	insql.append(" from sidcardcode ");
	insql.append(" where use_flag='Y' and biz_type='01' and idtype_code='" + idType+"'");
	insql.append(" order by idtype_code  ");
	System.out.println("insql====="+insql);
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="1">
<wtc:sql><%=insql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="idtypearray" scope="end" />
<%
	if(!(retCode2.equals("000000"))){
%>
		<script language="javascript">
	 	rdShowMessageDialog("��ѯ֤������ʧ�ܣ�" + "[<%=retCode2%>]"+ "<%=retMsg2%>");	
	 	removeCurrentTab();
		</script>
<%		
		return;
	}
	
	String inputParsm[] = new String[19];
	inputParsm[0] = workNo;
	inputParsm[1] = opCode;
	inputParsm[2] = oprNumb;
	inputParsm[3] = commitType;	//0-�½��� 1-��������
	inputParsm[4] = payFee;	
	inputParsm[5] = payType;
	inputParsm[6] = mobileNo;
	inputParsm[7] = phoneNo;
	inputParsm[8] = custName;
	inputParsm[9] = idType;
	inputParsm[10] = idCard;
	inputParsm[11] = custAddress;
	inputParsm[12] = postCode;
	inputParsm[13] = tktType;	
	inputParsm[14] = tktSum;
	inputParsm[15] = tktDate;
	inputParsm[16] = printAccept;
	inputParsm[17] = svoucher;
	inputParsm[18] = getType;
%>

   <wtc:service name="s6946Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg" outnum="5">			
	<wtc:param value="<%=inputParsm[0]%>"/>
	<wtc:param value="<%=inputParsm[1]%>"/>
	<wtc:param value="<%=inputParsm[2]%>"/>
	<wtc:param value="<%=inputParsm[3]%>"/>
	<wtc:param value="<%=inputParsm[4]%>"/>
	<wtc:param value="<%=inputParsm[5]%>"/>
	<wtc:param value="<%=inputParsm[6]%>"/>
	<wtc:param value="<%=inputParsm[7]%>"/>
	<wtc:param value="<%=inputParsm[8]%>"/>
	<wtc:param value="<%=inputParsm[9]%>"/>
	<wtc:param value="<%=inputParsm[10]%>"/>
	<wtc:param value="<%=inputParsm[11]%>"/>
	<wtc:param value="<%=inputParsm[12]%>"/>
	<wtc:param value="<%=inputParsm[13]%>"/>
	<wtc:param value="<%=inputParsm[14]%>"/>
	<wtc:param value="<%=inputParsm[15]%>"/>
	<wtc:param value="<%=inputParsm[16]%>"/>
	<wtc:param value="<%=inputParsm[17]%>"/>
	<wtc:param value="<%=inputParsm[18]%>"/>
	</wtc:service>
	<wtc:array id="tempArr" scope="end"/>
<% 


	if(!(errCode.equals("000000"))){
%>
		<script language="javascript">
	 	rdShowMessageDialog("����ʧ�ܣ�" + "<%=errMsg%>",0);	
	 	window.location="f6946_1.jsp?opCode=6946&opName=�������ֻ�Ʊ֧��&opr_numb=<%=oprNumb%>&tkt_type=<%=tktType%>&tkt_sum=<%=tktSum%>&tkt_date=<%=tktDate%>&price=<%=payFee%>&commit_type=1";
		</script>
<%
		return;
	}
	else if(!(tempArr[0][0].equals("0000"))){
	
%>
		<script language="javascript">
		<%if(tempArr[0][0].equals("2998"))
		{%>
	 		rdShowMessageDialog("����ʧ�ܣ�" + "<%=tempArr[0][1].trim()%>",0);	
			rdShowMessageDialog("��������:" + "<%=null == errType.get(tempArr[0][4].trim()) ? "δ֪���ʹ���" : errType.get(tempArr[0][4].trim())%>",0);	
	 	<%
		}
		else
		{%>
			rdShowMessageDialog("����ʧ�ܣ�" + "<%=tempArr[0][1]%>",0);	
		<%}%>
		<%if(tempArr[0][0].equals("0102"))//��ʱ
		{%>
	 		window.location="f6946_1.jsp?opCode=6946&opName=�������ֻ�Ʊ֧��&opr_numb=<%=oprNumb%>&tkt_type=<%=tktType%>&tkt_sum=<%=tktSum%>&tkt_date=<%=tktDate%>&price=<%=payFee%>&commit_type=1";
		<%
		}
		else
		{%>
			window.location="f6946_1.jsp?opCode=6946&opName=�������ֻ�Ʊ֧��";
		<%}%>
	 	</script>
<%		
		return;
	}
	else
	{
		orderCode = tempArr[0][3];	
	}
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
<META content="no-cache" http-equiv="Pragma">
<META content="no-cache" http-equiv="Cache-Control">
<META content="0" 	     http-equiv="Expires" > 
<meta http-equiv="Content-Type" content="text/html; charset=GBK">

<script language="JavaScript">

<!--
onload=function()
{		
	printCommit();
}

function rpad(str,len,ch)
{
	
	var ret = str;
	var printlength = 0;	
	for(var i = 0; i < ret.length; i++)
	{
		if(ret.charCodeAt(i)>127 || ret.charCodeAt(i)==94)
			printlength += 2;
		else
			printlength += 1;
	}
	var t =0;
	while(printlength < len)
	{
		ret += ch;
		printlength++;
	}
	return ret;
}
	
function printCommit()
{
    getAfterPrompt();
 	rdShowMessageDialog("����ɹ��������ӡȷ�ϵ���",2);
	showPrtDlg("Detail","ȷʵҪ��ӡȷ�ϵ���","Yes");
	window.location="f6946_2.jsp?printAccept=<%=printAccept%>";
}
function showPrtDlg(printType,DlgMessage,submitCfm)
{
   var h=198;
   var w=400;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
   
   var pType="subprint";
   var billType="1";
   var sysAccept = "<%=printAccept%>";
   
   var mode_code = null;
   var fav_code = null;
   var area_code = null;
   
   var printStr = printInfo(printType);
   var phoneno = "<%=phoneNo%>";
   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
   var path = "Print.jsp?DlgMsg=" + DlgMessage;
   var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneno+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
   var ret=window.showModalDialog(path,printStr,prop);
   return ret;
  
}

function printInfo(printType)
{
  	var retInfo = "";
  	var cust_info="";
	var opr_info="";
	var note_info1="";
	var note_info2="";
	var note_info3="";
	var note_info4="";
	cust_info+="�ֻ����룺|";
	cust_info+="�ͻ�������|";

	opr_info+=rpad("�����ţ�<%=orderCode%>",30," ");                  
	opr_info+="����ʱ�䣺"+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:MM:ss", Locale.getDefault()).format(new java.util.Date())%>' + "|";
	opr_info+="������<%=custName%>|";
	opr_info+=rpad("��Ч֤�����ͣ�<%=idtypearray[0][0]%>",30," ");  
	opr_info+="��Ч֤�����룺<%=idCard%>|";
	opr_info+="�����<%=payFee%>Ԫ|";	
	opr_info+="   |";
	<%
		for(int i = 0 ;i < tktTypeList.length;i++)
		{
			%>
			opr_info+=rpad("����Ʊ���ࣺ<%=tktTypeName.get(tktTypeList[i])%>",30," ");
			opr_info+=rpad("���ڣ�<%=tktDateList[i].trim().equals("00000000") ? "-" : tktDateList[i]%>",20," ");
			opr_info+="������<%=tktSumList[i]%>|   |";
			<%
		}
	%>
		
	note_info1+="��ע���������ֻ�Ʊ֧��"+"|";
	note_info2+=" "+"|";                           
	note_info3+=" "+"|";
	note_info4+="|";
	
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
  	
    return retInfo;	
}


//-->
</script>

</head>
<body>
<form name="frm" method="post" action="">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi"></div>
</div>


<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>