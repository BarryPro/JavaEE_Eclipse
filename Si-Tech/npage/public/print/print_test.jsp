
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/common/qcommon/print_include.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>demo</title>
</head>

<%
	String custOrderId="0";

%>

<script type="text/javascript">

	function setLoginAccept(retVal){
		document.frm.accept.value=retVal;
		alert("goNext");
	}

	function test10(){
		var ot=new otherInfo();
		//ot.countNum="1";
		var op=new opInfo();
		op.opContent="abc";
		op.orderArrayId="12121212";
		op.prodInfo="�̶��绰����װ��^0|�绰���룺��010��5850184��^1|װ����ַ�����������������ڽ�31 �ţ�^2";
		op.zfInfo="e8-2 �ײͣ���ʹ�÷�98 Ԫ�������ײ�Լ�����ݵĲ��֣��������ð���׼�ʷ���ȡ����װ�绰һ���Բ��Ϸѣ�230 Ԫ";
		op.ffInfo="�ʺű�ţ�ZHBH1234456|�����ˣ���xx^2|���ѷ�ʽ���ֽ𸶷�^2|��װ�绰һ���Բ��Ϸ��ڵ�һ�·���һͬ^2";
		op.bzInfo="e8 �ײ���Чʱ��";
		var amount="20"//������

		printDetail(document.frm.phone.value,"",op,ot,"N",amount);
		//document.frm.accept.value=ret;
	}

	function test11(){//��Ʊ
		var phoneNo='13776210323';
		var custName="�ߴ�";
		var amount="651243.4";
		var opType="���������ͣ�";
		var detail="";
		var accept="11234556765432";
		var city="̫ԭ";
		detail+="���431��100"+"|";
		detail+="���221��200"+"|";
		detail+="���113��300"+"|";
		detail+="���123��600"+"|";
		detail+="���111��400"+"|";
		detail+="���f13��900"+"|";


		var custOrderId="2009010112345";//������
		a=printDetailBill(phoneNo,custOrderId,custName,opType,amount,city,accept,detail);
		document.frm.accept.value=a;
	}
	function test20(){
		pubPrintDetail(document.frm.phone.value,"<%=custOrderId%>");
	}

	function test111_1(){//�ϲ���ӡ
		pubPrintDetail(document.frm.phone.value,document.frm.oi.value);
	}

	function test30(){//�ϲ��洢
		var ot=new otherInfo();;
		var op=new opInfo();
		op.opContent="ͣ��"+document.frm.aabbcc.value;
		op.orderArrayId=document.frm.oai.value;
		op.prodInfo="�̶��绰����װ��^n|�绰���룺��010��5850184��^1|װ����ַ�����������������ڽ�31 �ţ�^2";
		op.zfInfo="e8-2 �ײͣ���ʹ�÷�98 Ԫ�������ײ�Լ�����ݵĲ��ַ��ð���׼�ʷ���ȡ����װ�绰һ���Բ��Ϸѣ�230 Ԫ";
		op.ffInfo="�ʺű�ţ�ZHBH1234456|�����ˣ���xx^1|���ѷ�ʽ���ֽ𸶷�^1|��װ�绰һ���Բ��Ϸ��ڵ�һ�·���һͬ^2";
		op.bzInfo="e8 �ײ���Чʱ��";
		var amount="30";
		printDetail(document.frm.phone.value,"",op,ot,"Y",30);
		//document.frm.accept.value=ret;
	}


	function test100(){
		var phone="13776210323";
		var accept=document.frm.accept.value;
		var serverOrderId="2009010112345";//������
		rePrintBill(phone,accept,serverOrderId);
	}
	function deletefail(){
		var opCode="1104";
		var orderArrayId='12121212';
		deleteFail(document.frm.accept.value,orderArrayId,opCode);
		//����1����ˮ�ţ�����printDetail���ص���ˮ�ţ�,����2����������ID������3����������
	}

function doProcess(packet){
	alert("done");
}
</script>

<body>
<div id="operation">
	<FORM method="post" name="frm" action="*.jsp">
 	<%@ include file="/npage/include/header.jsp" %>
 	<div id="operation_table">
	<div class="title"><div class="text">������Ϣ</div></div>
		PhoneNo:<input type="txt" name="phone" value="13033152201"><br>
		Accept:<input type="text" name="accept"><br>
		orderId��<input type="text" name="oi" value="1111"><br>
		orderArrayId��<input type="text" name="oai" value="test">
		��ʶ��<input type="text" name="aabbcc" value="">
	</div>

	<div id="operation_button" style="height:200px;">
		<input class="b_foot_long" type="button" value="����" onclick="test10()">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<input class="b_foot_long" type="button" value="�ϴ�洢" onclick="test30()">
		<input class="b_foot_long" type="button" value="�ϲ���ӡ" onclick="test111_1()">

		<input class="b_foot_long" type="button" value="��Ʊ" onclick="test11()">
		<input class="b_foot_long" type="button" value="����" onclick=""><br>
		<input class="b_foot_long" type="button" value="����ʧ��" onclick="deletefail()">

	</div>

		<%@ include file="/npage/include/footer.jsp" %>
	</form>
</div>
</body>
</html>