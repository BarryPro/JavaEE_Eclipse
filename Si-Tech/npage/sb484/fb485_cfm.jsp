<%
    /********************
     version v2.0
     ������: si-tech
     *
     *create:wanghfa@2010-9-6 TD�̻����¹���
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<html>
<head>
<title>TD�̻����¹���</title>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<%
	//��һ���ֲ���������sB485Cfm��������
	String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
	String workNo = (String)session.getAttribute("workNo");
	String noPass = (String)session.getAttribute("password");
	String addStr = WtcUtil.repStr(request.getParameter("addStr"), "");
	String opNote = WtcUtil.repStr(request.getParameter("opNote"), "��");
	String ipAddr = (String)session.getAttribute("ipAddr");
	String saleType = WtcUtil.repStr(request.getParameter("saleType"), "");
	String backAccept = WtcUtil.repStr(request.getParameter("backAccept"), "");
	//String oStopTime = WtcUtil.repStr(request.getParameter("oStopTime"), "");
	String oldOpCode = WtcUtil.repStr(request.getParameter("oldOpCode"), "");
	String payType = WtcUtil.repStr(request.getParameter("payTypeT"), "");
	
	//�ڶ����ֲ�������Ʊ��ӡ����
	String custName = WtcUtil.repStr(request.getParameter("custName"), "");
	String custAddr = WtcUtil.repStr(request.getParameter("custAddr"), "");
	String salePrice = WtcUtil.repStr(request.getParameter("Sale_Price1"), request.getParameter("Sale_Price2"));
	String baseFee = WtcUtil.repStr(request.getParameter("Base_Fee"), "");
	String baseFee2 = WtcUtil.repStr(request.getParameter("Base_Fee2"), "");	//7671��Ʊ
	String freeFee = WtcUtil.repStr(request.getParameter("Free_fee"), "");
	String brandName = WtcUtil.repStr(request.getParameter("brandName"), "");
	String phoneTypeName = WtcUtil.repStr(request.getParameter("phoneTypeName"), "");
	String workName = (String)session.getAttribute("workName");
	String imeiCode = WtcUtil.repStr(request.getParameter("imeiCode"), "");
	String opName = WtcUtil.repStr((String)request.getParameter("opName"), "");
	String idNo = WtcUtil.repStr((String)request.getParameter("idNo"), "");
	System.out.println("===wanghfa===" + opCode + opName);
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone" routerValue="<%=activePhone%>" id="loginAccept"/>
<%
	System.out.println("==============wanghfa=====sB485Cfm=====0==== loginAccept = " + loginAccept);
	System.out.println("==============wanghfa=====sB485Cfm=====1==== opCode = " + opCode);
	System.out.println("==============wanghfa=====sB485Cfm=====2==== workNo = " + workNo);
	System.out.println("==============wanghfa=====sB485Cfm=====3==== activePhone = " + activePhone);
	System.out.println("==============wanghfa=====sB485Cfm=====4==== ���� = 01");
	System.out.println("==============wanghfa=====sB485Cfm=====5==== noPass = " + noPass);
	System.out.println("==============wanghfa=====sB485Cfm=====6==== �û����� = \"\"");
	System.out.println("==============wanghfa=====sB485Cfm=====7==== addStr = " + addStr);
	System.out.println("==============wanghfa=====sB485Cfm=====8==== opNote = " + opNote);
	System.out.println("==============wanghfa=====sB485Cfm=====9==== ipAddr = " + ipAddr);
	System.out.println("==============wanghfa=====sB485Cfm====10==== saleType = " + saleType);
	System.out.println("==============wanghfa=====sB485Cfm====11==== backAccept = " + backAccept);
	System.out.println("==============wanghfa=====sB485Cfm====12==== payType = " + payType);

%>
	<wtc:service name="sB485Cfm" routerKey="phone" routerValue="<%=activePhone%>" retcode="retCode1" retmsg="retMsg1" outnum="2">			
		<wtc:param value="<%=loginAccept%>"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=activePhone%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=noPass%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=addStr%>"/>
		<wtc:param value="<%=opNote%>"/>
		<wtc:param value="<%=ipAddr%>"/>
		<wtc:param value="<%=saleType%>"/>
		<wtc:param value="<%=backAccept%>"/>
		<wtc:param value="<%=payType%>"/>
	</wtc:service>
	<wtc:array id="result1"  scope="end"/>
<%
	System.out.println("========wanghfa========= sB485Cfm: " + retCode1 + " " + retMsg1);
	
	if (retCode1.equals("000000")) {
		for (int i = 0; i < result1.length; i ++) {
			for (int j = 0; j < result1[i].length; j ++) {
				System.out.println("==========wanghfa==================== result["+i+"]["+j+"] = " + result1[i][j]);
			}
		}
		String chinaFee = "";
%>
		<wtc:service name="sToChinaFee" routerKey="phone" routerValue="<%=activePhone%>" outnum="3" >
			<wtc:param value="<%=salePrice%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>
<%
		if(chinaFeeArr!=null&&chinaFeeArr.length>0) {
			chinaFee = chinaFeeArr[0][2];
		}
%>
		<script language="javascript">
			rdShowMessageDialog("�����ɹ�����ӡ��Ʊ......", 2);
			
			var infoStr="";
			infoStr+="<%=workNo%>  <%=loginAccept%>"+"       <%=opName%>"+"|";
			infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//����
			infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
			infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
			infoStr+='<%=custName%>'+"|";//�û�����
			infoStr+=""+"|";//��ͬ����
			infoStr+='<%=activePhone%>'+"|";//�ƶ�����
			infoStr+="<%=custAddr%>"+"|";//�û���ַ
			infoStr+=""+"|";
			
			infoStr+="<%=chinaFee%>"+"|";//�ϼƽ��(��д)
			infoStr+="<%=salePrice%>"+"|";//Сд
			
<%
			if (!"7671".equals(oldOpCode)) {
%>
				infoStr += "����ϼƣ�" + '<%=salePrice%>' + "Ԫ��������" + '<%=baseFee%>' + "Ԫ��";
				if(parseInt("<%=freeFee%>") > 0) {
					infoStr+="������"+"<%=freeFee%>"+"Ԫ��";
				}
<%
			} else {
%>
				infoStr += "����ϼƣ�" + "<%=salePrice%>" + "Ԫ�����̻�������" + "<%=baseFee2%>"
					+ "Ԫ���ֻ�������" + parseInt("<%=baseFee2%>");
<%
			}
%>
			
			infoStr+="TD�̻���"+'<%=brandName%><%=phoneTypeName%>'+"��IMEI�ţ�"+'<%=imeiCode%>'+"|";
			infoStr+="<%=workName%>"+"|";//��Ʊ��
			infoStr+=" "+"|";//�տ���
			var dirtPage="";
			
			//location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/sb484/fb484.jsp?activePhone=<%=activePhone%>%26opCode=<%=opCode%>%26opName=<%=opName%>";
			location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=<%=opCode%>&loginAccept=<%=loginAccept%>&dirtPage=/npage/sb484/fb484.jsp?activePhone=<%=activePhone%>%26opCode=<%=opCode%>%26opName=<%=opName%>";
		</script>
<%
	}

	String myOpBeginTime = new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date());
	System.out.println("%%%%b485%%%����ͳһ�Ӵ���ʼ%%%%%%%%");
	String url = "/npage/contact/upCnttInfo.jsp?opCode=" + opCode + "&opName=" + opName + "&workNo="
		+ workNo + "&retCodeForCntt=" + retCode1 + "&loginAccept=" + loginAccept + "&pageActivePhone="
		+ activePhone + "&contactType=user&contactId=" + idNo + "&retMsgForCntt=" + retMsg1
		+ "&opBeginTime=" + myOpBeginTime;
	System.out.println("url = " + url);
%>
	<jsp:include page="<%=url%>" flush="true" />
<%	
	System.out.println("%%%%b485%%%����ͳһ�Ӵ�����%%%%%%%%");
	
	if (!retCode1.equals("000000")) {
%>
		<script language="JavaScript">
			rdShowMessageDialog("sB485Cfm��������룺<%=retCode1%>��������Ϣ��<%=retMsg1%>", 0);
			window.location = "fb484.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=activePhone%>";
		</script>
<%
	}
%>

</head>
<body>

</body>
</html>
