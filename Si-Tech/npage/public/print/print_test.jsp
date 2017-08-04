
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
		op.prodInfo="固定电话（新装）^0|电话号码：（010）5850184，^1|装机地址：北京市西城区金融街31 号，^2";
		op.zfInfo="e8-2 套餐：月使用费98 元，超出套餐约定内容的部分＃＃＃＃用按标准资费收取。新装电话一次性材料费：230 元";
		op.ffInfo="帐号编号：ZHBH1234456|付费人：王xx^2|付费方式：现金付费^2|新装电话一次性材料费在第一月费用一同^2";
		op.bzInfo="e8 套餐生效时间";
		var amount="20"//受理金额

		printDetail(document.frm.phone.value,"",op,ot,"N",amount);
		//document.frm.accept.value=ret;
	}

	function test11(){//发票
		var phoneNo='13776210323';
		var custName="高达";
		var amount="651243.4";
		var opType="（操作类型）";
		var detail="";
		var accept="11234556765432";
		var city="太原";
		detail+="余额431：100"+"|";
		detail+="余额221：200"+"|";
		detail+="余额113：300"+"|";
		detail+="余额123：600"+"|";
		detail+="余额111：400"+"|";
		detail+="余额f13：900"+"|";


		var custOrderId="2009010112345";//定单号
		a=printDetailBill(phoneNo,custOrderId,custName,opType,amount,city,accept,detail);
		document.frm.accept.value=a;
	}
	function test20(){
		pubPrintDetail(document.frm.phone.value,"<%=custOrderId%>");
	}

	function test111_1(){//合并打印
		pubPrintDetail(document.frm.phone.value,document.frm.oi.value);
	}

	function test30(){//合并存储
		var ot=new otherInfo();;
		var op=new opInfo();
		op.opContent="停机"+document.frm.aabbcc.value;
		op.orderArrayId=document.frm.oai.value;
		op.prodInfo="固定电话（新装）^n|电话号码：（010）5850184，^1|装机地址：北京市西城区金融街31 号，^2";
		op.zfInfo="e8-2 套餐：月使用费98 元，超出套餐约定内容的部分费用按标准资费收取。新装电话一次性材料费：230 元";
		op.ffInfo="帐号编号：ZHBH1234456|付费人：王xx^1|付费方式：现金付费^1|新装电话一次性材料费在第一月费用一同^2";
		op.bzInfo="e8 套餐生效时间";
		var amount="30";
		printDetail(document.frm.phone.value,"",op,ot,"Y",30);
		//document.frm.accept.value=ret;
	}


	function test100(){
		var phone="13776210323";
		var accept=document.frm.accept.value;
		var serverOrderId="2009010112345";//定单号
		rePrintBill(phone,accept,serverOrderId);
	}
	function deletefail(){
		var opCode="1104";
		var orderArrayId='12121212';
		deleteFail(document.frm.accept.value,orderArrayId,opCode);
		//参数1：流水号（调用printDetail返回的流水号）,参数2：定单子项ID，参数3：操作代码
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
	<div class="title"><div class="text">基本信息</div></div>
		PhoneNo:<input type="txt" name="phone" value="13033152201"><br>
		Accept:<input type="text" name="accept"><br>
		orderId：<input type="text" name="oi" value="1111"><br>
		orderArrayId：<input type="text" name="oai" value="test">
		标识：<input type="text" name="aabbcc" value="">
	</div>

	<div id="operation_button" style="height:200px;">
		<input class="b_foot_long" type="button" value="单打" onclick="test10()">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<input class="b_foot_long" type="button" value="合打存储" onclick="test30()">
		<input class="b_foot_long" type="button" value="合并打印" onclick="test111_1()">

		<input class="b_foot_long" type="button" value="发票" onclick="test11()">
		<input class="b_foot_long" type="button" value="补打" onclick=""><br>
		<input class="b_foot_long" type="button" value="调用失败" onclick="deletefail()">

	</div>

		<%@ include file="/npage/include/footer.jsp" %>
	</form>
</div>
</body>
</html>