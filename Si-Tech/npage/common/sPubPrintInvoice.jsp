<%
/*
����: ������Ʊ��ӡ����
�汾: 1.8.2
����: 2005/12/05
����: xiezw
��Ȩ: sitech

���:     
     GPARM32_0  , op_code         , ��������
	 GPARM32_1  , work_no         , ����
	 GPARM32_2  , maxAccept       , ��ˮ
	 GPARM32_3  , phoneNo         , �ֻ�����
	 GPARM32_4  , smName          , Ʒ������						
     GPARM32_5  , custName        , �ͻ�����
	 GPARM32_6  , tmpMoney        , ���Ѻϼ�
	 GPARM32_7  , innetFee        , ������
	 GPARM32_8  , simFee          , SIM����
	 GPARM32_9  , selectFee       , ѡ�ŷ�
     GPARM32_10 , insuranceFee    , ���շ�
	 GPARM32_11 , checkMachineFee , �����
	 GPARM32_12 , handFee         , ������
	 GPARM32_13 , machineFee      , ������
	 GPARM32_14 , otherFee        , ������
	 GPARM32_15 , totalPrepay     , Ԥ���
     GPARM32_16 , cashPay         , �ֽ�ʽ
	 GPARM32_17 , checkPay        , ֧Ʊ��ʽ
	 GPARM32_18 , systemNote      , ϵͳ��ע
	 GPARM32_19 , opNote          , �û���ע
*/
%>

<%@ page contentType="text/html; charset=GB2312"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.util.MoneyUtil"%>

<%
	String  in_op_code = request.getParameter("op_code");
	String  in_work_no = request.getParameter("work_no");	
	String  in_maxAccept = request.getParameter("maxAccept");
	String  in_phoneNo = request.getParameter("phoneNo");
	String  in_smName = request.getParameter("smName");
	String  in_custName = request.getParameter("custName");
	String  in_tmpMoney = request.getParameter("tmpMoney");
	String  in_innetFee = request.getParameter("innetFee");
	String  in_simFee = request.getParameter("simFee");
	String  in_selectFee = request.getParameter("selectFee");
	String  in_insuranceFee = request.getParameter("insuranceFee");
	String  in_checkMachineFee = request.getParameter("checkMachineFee");	
	String  in_handFee = request.getParameter("handFee");
	String  in_machineFee = request.getParameter("machineFee");
	String  in_otherFee = request.getParameter("otherFee");
	String  in_totalPrepay = request.getParameter("totalPrepay");
	String  in_cashPay = request.getParameter("cashPay");
	String  in_checkPay = request.getParameter("checkPay");
	String  in_systemNote = request.getParameter("systemNote");
	String  in_opNote = request.getParameter("opNote");

	String vOpTime = new java.text.SimpleDateFormat("yyyyMMdd HH:mm:ss").format(new java.util.Date());
	String vYear = vOpTime.substring(0,4);
	String vMonth = vOpTime.substring(4,6);
	String vDay = vOpTime.substring(6,8);
	String vHms = vOpTime.substring(9,17);

	MoneyUtil mon = new MoneyUtil();
%>

<html>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<script language="JavaScript" src="/js/common/redialog/redialog.js"></script>
<SCRIPT language="JavaScript">
function printInvoice() { 
    printctrl.Setup(0) ;
	printctrl.StartPrint();
	printctrl.PageStart();
	
	/* ��ӡ������ ��ˮ ���� */
    printctrl.Print(13,4,10,0,"<%=in_work_no%>              <%=in_maxAccept%>      <%=vYear%>   <%=vMonth%>     <%=vDay%>  <%=vHms%>");

	/* ��ӡ���ֻ����롢ҵ�����ơ��ͻ����� */
    printctrl.Print(13,6,10,0,"<%=in_phoneNo%>                    <%=in_smName%>                             <%=in_custName%>");
	
	/* ��ӡ����Сд��� */
	printctrl.Print(33,8,10,0,"   <%=mon.NumToRMBStr(Double.parseDouble(in_tmpMoney))%>                                      ��<%=in_tmpMoney%>");
	
	/* ��ӡ����Ʊ��ͷ */
    printctrl.Print(23,11,10,0,"����������ϸ��Ŀ");
	
	/* ��ӡ����ϸ������ */
	printctrl.Print(15,13,10,0,"�� �� �ѣ� <%=in_innetFee%>  SIM ����: <%=in_simFee%>");
    printctrl.Print(15,14,10,0,"�� �� ��:  <%=in_insuranceFee%>  �� �� ��: <%=in_checkMachineFee%>");
	printctrl.Print(15,15,10,0,"�� �� ��: <%=in_handFee%>  �� �� ��: <%=in_otherFee%>");
	printctrl.Print(15,16,10,0,"Ԥ �� ��: <%=in_totalPrepay%>");
	printctrl.Print(15,17,10,0,"�ֽ�ʽ: <%=in_cashPay%> ֧Ʊ��ʽ: <%=in_checkPay%>");
	
	/* ��ӡ����ע */
	printctrl.Print(15,22,10,0,"��    ע:  <%=in_systemNote%>");
    
	/* ��ӡ����Ʊ������Ϣ */
    <%
	   StringTokenizer st = new StringTokenizer(in_opNote, "#");
	   int countNumber = 22;
	   while(st.hasMoreTokens()) {
	      ++countNumber;
	%>
         printctrl.Print(15,<%=countNumber%>,10,0,"<%=String.valueOf(st.nextElement())%>");
	
	<% } %>
	
	printctrl.PageEnd() ;
	printctrl.StopPrint(); 
}

function ifprint() {
   printInvoice();
   window.close();
} 
</SCRIPT>

<body onload="ifprint()">
<OBJECT
classid="clsid:28EE9D9D-1A80-4BFF-B464-0E6B69E26B05"
codebase="/ocx/printatl.dll#version=1,0,0,1"
id="printctrl"
style="DISPLAY: none"
VIEWASTEXT
>
</OBJECT>

</body>
</html>