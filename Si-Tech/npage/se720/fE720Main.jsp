<%
/*
 * ����: ��������-�����ƻ�
 * �汾: 1.0
 * ����: 2012/3/9 14:19:13
 * ����: zhangyan
 * ��Ȩ: si-tech
 * update:
*/
%>


<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
String	saleType	="49";
String	opCode		=request.getParameter("opCode");
String	opName		=request.getParameter("opName");
String	loginNo		=(String)session.getAttribute("workNo");
String	loginName	=(String)session.getAttribute("workName");
String	loginNoPass	=(String)session.getAttribute("password");
String	orgCode		=(String)session.getAttribute("orgCode");
String	regCode		=(String)session.getAttribute("regCode");
String	groupId		=(String)session.getAttribute("groupId");
String	phoneNo		=(String)request.getParameter("activePhone");

/* liujian ��ȫ�ӹ��޸� 2012-4-6 16:18:13 begin */
String op_strong_pwd = (String) session.getAttribute("password");
/* liujian ��ȫ�ӹ��޸� 2012-4-6 16:18:13 end */
%>	
<wtc:sequence	name="TlsPubSelCrm"	key="sMaxSysAccept"	
	routerKey="region" routerValue="<%=regCode%>"	id="loginAccept" />
<%	
/*��ȡƷ������*/	
String	sqlSelect1 = "SELECT UNIQUE a.brand_code, TRIM (b.brand_name) "
	+"FROM dphonesalecode a, schnresbrand b"
	+" WHERE a.region_code = :region_code  AND a.brand_code = b.brand_code"
	+" AND a.valid_flag = 'Y' AND a.sale_type = :sale_type";
String	srvParams1 = "region_code=" + regCode + ",sale_type=" + saleType;
%>
<wtc:service name="TlsPubSelCrm" outnum="2">
	<wtc:param value="<%=sqlSelect1%>"/>
	<wtc:param value="<%=srvParams1%>"/>
</wtc:service>
<wtc:array id="brandResult" scope="end"/>

<%
/*ȡ�ֻ��ͺ�*/
String sqlSelect2 = "select unique a.type_code,trim(b.res_name), b.brand_code "
	+"from dphoneSaleCode a,schnrescode_chnterm b	"
	+"where a.region_code=:region_code and  a.type_code=b.res_code "
	+"and a.brand_code=b.brand_code  and a.valid_flag='Y' and a.sale_type=:sale_type";
String srvParams2 = "region_code=" + regCode + ",sale_type=" + saleType;
%>		
<wtc:service name="TlsPubSelCrm" outnum="3">
	<wtc:param value="<%=sqlSelect2%>"/>
	<wtc:param value="<%=srvParams2%>"/>
</wtc:service>
<wtc:array id="resultType" scope="end"/>
	
<%
StringBuffer brandSb = new StringBuffer("");
brandSb.append("<option value ='-1'>��ѡ��</option>");
for(int i=0; i<brandResult.length; i++) {
	  brandSb.append("<option value ='").append(brandResult[i][0]).append("'>")
					 .append(brandResult[i][1])
					 .append("</option>");
}

/*ȡ�û���Ϣ*/
String	inputPrm[]	= new String[4];
inputPrm[0]			= phoneNo;
inputPrm[1]			= loginNo;
inputPrm[2]			= orgCode;
inputPrm[3]			= opCode;
%>
<wtc:service name="s126bInit" routerKey="phone" routerValue="<%=phoneNo%>" 
	retcode="retCode2" retmsg="retMsg2" outnum="29">
		<wtc:param value=""/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=op_strong_pwd%>"/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=inputPrm[2]%>"/>
</wtc:service>
<wtc:array id="tempArr"  scope="end"/>
<%
String	bp_name			="";
String	sm_code			="";
String	family_code		="";
String	rate_code		="";
String	bigCust_flag	="";
String	sm_name			="";
String	rate_name		="";
String	bigCust_name	="";
String	next_rate_code	="";
String	next_rate_name	="";
String	lack_fee		="";
String	prepay_fee		="";
String	bp_add			="";
String	cardId_type		="";
String	cardId_no		="";
String	cust_id			="";
String	cust_belong_code="";
String	group_type_code	="";
String	group_type_name	="";
String	imain_stream	="";
String	next_main_stream="";
String	hand_fee		="";
String	favorcode		="";
String	card_no			="";
String	print_note		="";
String	contract_flag	="";
String	high_flag		="";
String	passwordFromSer	="";
String	retFlag			="";
String	errCode			="";
String	errMsg			="";
if(tempArr.length==0)
{
	retFlag = "1";
	retMsg = "��ѯ���������ϢΪ��!";
}
else	if(retCode2.equals("000000") && tempArr.length>0)
{
	bp_name			=tempArr[0][3];		//��������
	bp_add			=tempArr[0][4];		//�ͻ���ַ
	passwordFromSer	=tempArr[0][2];		//����
	sm_code			=tempArr[0][11];	//ҵ�����
	sm_name			=tempArr[0][12];	//ҵ���������
	hand_fee		=tempArr[0][13];	//������
	favorcode		=tempArr[0][14];	//�Żݴ���
	rate_code		=tempArr[0][5];		//�ʷѴ���
	rate_name		=tempArr[0][6];		//�ʷ�����
	next_rate_code	=tempArr[0][7];		//�����ʷѴ���
	next_rate_name	=tempArr[0][8];		//�����ʷ�����
	bigCust_flag	=tempArr[0][9];		//��ͻ���־
	bigCust_name	=tempArr[0][10];	//��ͻ�����
	lack_fee		=tempArr[0][15];	//��Ƿ��
	prepay_fee		=tempArr[0][16];	//��Ԥ��
	cardId_type		=tempArr[0][17];	//֤������
	cardId_no		=tempArr[0][18];	//֤������
	cust_id			=tempArr[0][19];	//�ͻ�id
	cust_belong_code=tempArr[0][20];	//�ͻ�����id
	group_type_code	=tempArr[0][21];	//���ſͻ�����
	group_type_name	=tempArr[0][22];	//���ſͻ���������
	imain_stream	=tempArr[0][23];	//��ǰ�ʷѿ�ͨ��ˮ
	next_main_stream=tempArr[0][24];	//ԤԼ�ʷѿ�ͨ��ˮ
	print_note		=tempArr[0][25];	//�������
	contract_flag	=tempArr[0][27];	//�Ƿ������˻�
	high_flag		=tempArr[0][28];	//�Ƿ��и߶��û�	
}
else
{
%>
	<script language="JavaScript">
		rdShowMessageDialog("<%=retCode2%>:<%=retMsg2%>",0);
		history.go(-1);
	</script>
<%
}
/*���ʷ�����*/
String sqlSelect3 = "select offer_name from product_offer where offer_id =:rate_code";
String srvParams3 = "rate_code=" + rate_code;
%>
<wtc:service	name="TlsPubSelCrm"	outnum="1"
	retmsg="msg1"	retcode="code1"	routerKey="region"	routerValue="<%=regCode%>">
	<wtc:param value="<%=sqlSelect3%>"/>
	<wtc:param value="<%=srvParams3%>"/>
</wtc:service>
<wtc:array id="resultOfferName" scope="end"/>
<%
if(!code1.equals("000000")&&!code1.equals("0"))
{%>
	<script language="JavaScript">
		rdShowMessageDialog("<%=code1%>:<%=msg1%>",0);
		history.go(-1);
	</script>
<%
}
else
{
	if(resultOfferName.length>0&&resultOfferName[0][0]!=null)
	{
		rate_name = resultOfferName[0][0];
	}
	else
	{%>
		<script language="JavaScript">
			rdShowMessageDialog("�ʷ�����Ϊ�գ�",0);
			history.go(-1);
		</script>
  	<%
  	}
}%>

<html xmlns="http://www.w3.org/1999/xhtml">
<body>
<head>
<title><%=opName%></title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>		
<script>
		$(function() {		
			/*************************��ʼ�������Ϣ*****************************/
			$('#oCustName').val('<%=bp_name%>');
			$('#oSmName').val('<%=sm_name%>');
			$('#oModeName').val('<%=rate_name%>');
			$('#oPrepayFee').val('<%=prepay_fee%>');
			$('#oMarkPoint').val('<%=print_note%>');
			//�����ֻ�Ʒ�Ƶ������б�
			$('#phone_brand').append("<%=brandSb.toString()%>");
			//����ֻ��ͺŶ���
			/*
			 *��������
			[
				brandCode1:{code1:name1,code2:name2}
		    brandCode2:{code1:name1,code2:name2}
		  ]
				*/
			var phone_types = [];
			<%
			 for(int i=0;i<resultType.length;i++) {
			%>
					if(typeof phone_types[<%= resultType[i][2]%>] == 'undefined') {
						phone_types[<%= resultType[i][2]%>] = {};
					}
					var typeObj = phone_types[<%= resultType[i][2]%>];
					typeObj['<%= resultType[i][0]%>'] = '<%= resultType[i][1]%>'
			<% 		
			 }
			%>
			/*************************�л��ֻ�Ʒ��*****************************/
			$('#phone_brand').change(function() {
					//����ֻ�Ʒ��
					var brand = $('#phone_brand').val();
					//���������óɿ�
					$("#phone_type").empty();
					$("#sale_ways").empty();
					$("#mode_sale").empty();
					if(brand == -1 || brand == '-1'){
						reset();
						return;
					}
					
					$("#phone_type").append('<option value ="-1">��ѡ��</option>');
					$.each(phone_types[brand],function(n,ele){
								$("<option value="+n+">"+ele+"</option>").appendTo($("#phone_type"));
					});
				});
				
				/*************************�л��ͺţ���Ҫ����̨������*****************************/
				$('#phone_type').change(function() {
						//����ֻ�Ʒ��
						var typeCode = $('#phone_type').val();
						//��Ӫ�������������ʷѳɿ�
						$("#sale_ways").empty();
						$("#mode_sale").empty();
						if(typeCode == -1 || typeCode == '-1'){
							reset();
							return;
						}
					
						$('#p3').val($('#phone_type').val());
						 var packet = new AJAXPacket("fE720Ajax.jsp","���ڻ�������Ϣ�����Ժ�......");
						 var _data = packet.data;
						 _data.add("sale_type","<%=saleType%>");
						 _data.add("brand_code",$('#phone_brand').val());
						 _data.add("type_code",typeCode);
						 _data.add("method","apply_getSaleWays");
						 core.ajax.sendPacket(packet,getSaleWaysProcess);
						 packet = null;
				});
				
				/*************************�л�Ӫ����������Ҫ����̨������****************************/
				$('#sale_ways').change(function() {
						var sale_code = $('#sale_ways').val();
						//���������óɿ�
						$("#mode_sale").empty();
						if(sale_code == -1 || sale_code == '-1'){
							reset();
							return;
						}
						 var packet = new AJAXPacket("fE720Ajax.jsp","���ڻ�������Ϣ�����Ժ�......");
						 var _data = packet.data;
						 _data.add("sale_type","<%=saleType%>");
						 _data.add("sale_code",sale_code);
						 _data.add("method","apply_getModeSale");
						 core.ajax.sendPacket(packet,getModeSaleProcess);
						 packet = null;
				});
				
				/*************************�л������ʷѣ���Ҫ����̨������****************************/
				$('#mode_sale').change(function() {
						var sale_code = $('#sale_ways').val();
						var mode_sale = $('#mode_sale').val();
						if(mode_sale == -1 || mode_sale == '-1'){
							reset();
							return;
						}
						 $('#new_Mode_Name').val($('#mode_sale').find("option:selected").text());
						 var packet = new AJAXPacket("fE720Ajax.jsp","���ڻ�������Ϣ�����Ժ�......");
						 var _data = packet.data;
						 _data.add("sale_type","<%=saleType%>");
						 _data.add("sale_code",sale_code);
						 _data.add("mode_code",mode_sale);
						 _data.add("method","apply_getPayInfo");
						 core.ajax.sendPacket(packet,getPayInfoProcess);
						 packet = null;
				});
				
				//Ĭ������£�����֤IMEI�룬���ܵ���ύ��ť
				$('#next_step').attr('disabled','disabled');
				/*************************�ύ��ťע���¼�****************************/
				$('#next_step').click(function() {
				//	printCommit();
					frmCfm();	
				})
				/*************************�����ťע���¼�****************************/
				$('#reset_btn').click(function() {
						$('#phone_brand').val("-1");
						$('#phone_brand').change();
						$('#phoneOther').val('');
						$('#IMEINo').val('');
				})
				
		})
	/*************************����ֻ�����input��ֵ****************************/	
	function reset() {
		$('#prepay_limit').val(''); //����Ԥ��
		$('#cashPay').val(''); //����Ԥ��
		$('#prepay_gift').val('');  //�Ԥ��
		$('#mon_base_fee').val(''); //������Ԥ���
		$('#consume_term').val(''); //ҵ����Ч��
		$('#active_term').val('');  //�������
		$('#sale_price').val('');   //�û��ɷѺϼ�
		$('#sale_name').val('');
		$('#free_fee').val('');
		$('#base_fee').val('');
		$('#sale_name_span').text('');
	}
	/*************************�л��ͺţ�ajax���ص�Ӫ����������****************************/
	function getSaleWaysProcess(package) {
			var retCode = package.data.findValueByName("retcode");
			var retMsg = package.data.findValueByName("retmsg");
			var result = package.data.findValueByName("result");
			if(retCode == "000000") {
				//���Ӫ����������
				var txt = '<option value="-1" >--��ѡ��--</option>';
				for(var i=0,len=result.length;i<len;i++) {
					txt += '<option value="' + result[i].code + '">';
					txt +=     result[i].name;
					txt += '</option>'
				}
				$('#sale_ways').append(txt);
			}else {
				rdShowMessageDialog("������룺" + retCode + "��������Ϣ��" + retMsg,0);
				return false;
			}
	}
	/*************************�л�Ӫ��������ajax���ص������ʷ�����****************************/
	function getModeSaleProcess(package) {
	  	var retCode = package.data.findValueByName("retcode");
			var retMsg = package.data.findValueByName("retmsg");
			var result = package.data.findValueByName("result");
			if(retCode == "000000") {
				//���Ӫ����������
				var txt = '<option value="-1" >--��ѡ��--</option>';
				for(var i=0,len=result.length;i<len;i++) {
					txt += '<option value="' + result[i].code + '">';
					txt +=     result[i].name;
					txt += '</option>'
				}
				$('#mode_sale').append(txt);
			}else {
				rdShowMessageDialog("������룺" + retCode + "��������Ϣ��" + retMsg,0);
				return false;
			}
	}
	/*************************�л������ʷѣ�ajax���ص��ֻ���������****************************/
	function getPayInfoProcess(package) {
			var retCode = package.data.findValueByName("retcode");
			var retMsg = package.data.findValueByName("retmsg");
			var result = package.data.findValueByName("result");
			if(retCode == "000000") {
				$('#prepay_limit').val(result.prepay_limit); //����Ԥ��
				$('#cashPay').val(result.prepay_limit); //Ӧ�ս��=����Ԥ��
				$('#prepay_gift').val(result.prepay_gift);   //�Ԥ��
				$('#mon_base_fee').val(result.mon_base_fee); //������Ԥ���
				$('#consume_term').val(result.consume_term); //ҵ����Ч��
				$('#free_fee').val(result.free_fee); //
				$('#base_fee').val(result.base_fee); //
				$('#active_term').val(result.active_term);   //�������
				$('#sale_price').val(result.sale_price);     //�û��ɷѺϼ�
				$('#i16').val($('#mode_sale').val());
				if(result.sale_name != null && result.sale_name != "") {
					$('#sale_name_span').text(result.sale_name + '--');
					$('#sale_name').val(result.sale_name + '--');
				}
			 $('#mon_prepay_limit').val(result.mon_prepay_limit);
			}else {
				rdShowMessageDialog("������룺" + retCode + "��������Ϣ��" + retMsg,0);
				return false;
			}
	}
	
	/*************************��֤IMEI****************************/
	function checkimeino() {
		if($('#IMEINo').val().length == 0)
		{
			rdShowMessageDialog("IMEI���벻��Ϊ�գ����������� !!");
			document.fE720MainForm.IMEINo.focus();
			$('#next_step').attr('disabled','disabled');
			return false;
		}else if($('#IMEINo').val().length != 15) {
			rdShowMessageDialog("IMEI����ӦΪ15λ������������ !!");
			document.fE720MainForm.IMEINo.focus();
			$('#next_step').attr('disabled','disabled');
			return false;
		}
		else if(!new RegExp(/^[0-9]{15}$/).test($.trim($('#IMEINo').val())))
		{
			rdShowMessageDialog("IMEI����ӦΪ15λ���֣����������� !!");
			document.fE720MainForm.IMEINo.focus();
			$('#next_step').attr('disabled','disabled');
			return false;
		}

		var packet = new AJAXPacket("<%=request.getContextPath()%>/npage/se720/fE720Ajax.jsp","����У��IMEI��Ϣ�����Ժ�......");
		packet.data.add("method",'apply_checkIMEI');
		packet.data.add("imei_no",$.trim($('#IMEINo').val()));
		packet.data.add("brand_code",$('#phone_brand').val());
		packet.data.add("type_code",$('#phone_type').val());
		core.ajax.sendPacket(packet);

		packet=null;
	}
	
	// ��ò�����IMEI
	function doProcess(packet) {
		var  retResult=packet.data.findValueByName("retcode");
		if(retResult == "000000"){
				rdShowMessageDialog("IMEI��У��ɹ���",2);
				$('#next_step').removeAttr('disabled');
				$('#IMEINo').attr('readonly','readonly');
				return ;

		}else if(retResult == "000001"){
				rdShowMessageDialog("IMEI��У��ɹ�2��",2);
				document.fE720MainForm.next_step.disabled=false;
				document.fE720MainForm.IMEINo.readOnly = true;
				return ;

		}else if(retResult == "000003"){
				rdShowMessageDialog("IMEI�Ų���ӪҵԱ����Ӫҵ����IMEI����ҵ�������Ͳ�����");
				document.fE720MainForm.next_step.disabled=true;
				return false;
		}else if(retResult == "000004"){
				rdShowMessageDialog("��IMEI���Ѿ�������������ٴΰ���");
				document.fE720MainForm.next_step.disabled=true;
				return false;
		}else{
				rdShowMessageDialog("IMEI�Ų����ڻ����Ѿ�ʹ�ã�");
				document.fE720MainForm.next_step.disabled=true;
				return false;
		}
 }
 
  function viewConfirm(){
		if(document.fE720MainForm.IMEINo.value==""){
			document.fE720MainForm.next_step.disabled=true;
		}
	}
	
	function check() {
		var phone_brand = $('#phone_brand').val();
		var phone_type = $('#phone_type').val();
		var sale_ways = $('#sale_ways').val();
		var mode_sale = $('#mode_sale').val();
		if(phone_brand == -1) {
			rdShowMessageDialog("��ѡ���ֻ�Ʒ�ƣ�");
			return false;	
		}else if(phone_type == -1) {
			rdShowMessageDialog("��ѡ���ֻ����ͣ�");
			return false;	
		}else if(sale_ways == -1) {
			rdShowMessageDialog("��ѡ��Ӫ��������");
			return false;	
		}else if(mode_sale == -1) {
			rdShowMessageDialog("��ѡ�������ʷѣ�");
			return false;	
		}
		return true;
	}
	
	
function frmCfm() {
		//ƴ��һϵ�в���
		/*
		if(!forInt(document.fE720MainForm.phoneOther)){
			rdShowMessageDialog("������������!",0);
			return false;
		};*/
		
		
		
		 var str =$('#sale_ways').val()    + "|" + /*iSaleCode|*/
			$('#phone_brand').find('option:selected').text() + "|" + /*iBrandName|*/
			$('#phone_type').find('option:selected').text()  + "|" + /*iTypeName|*/
			$('#prepay_limit').val() + "|" + 	/*�ɷѽ��*/
			 "0|" +   /*iBaseFee*/
			$('#consume_term').val() + "|" + 	/*��Լ����*/
			$('#free_fee').val()   + "|" +  	/*�Ż��ܽ��|*/
			$('#active_term').val()  + "|" +	/*	|�������*/
			$('#base_fee').val() +"|"+ 			/*|�Żݱ���*/
			$('#phoneOther').val() + "|" +  
			$('#IMEINo').val()       + "|" ;	
		
		$('#iAddStr').val(str);

		$('#ip').val($('#mode_sale').val());
		$('#do_note').val($('#op_note').val());
		fE720MainForm.submit();
}
	</script>
</head>
<form name="fE720MainForm" method="POST" action ="../bill/f1270_3.jsp">
<%@ include file="/npage/include/header.jsp" %>
<div id="opr">
<div class="title">
	<div id="title_zi"><%=opName%></div>
</div>
<table cellspacing="0">
	<tr>
		<td class="blue">�ֻ�����</td>
		<td>
			<input	class="InputGrey"	type="text"	name="phoneNo"
				id="phoneNo"	value="<%=activePhone%>"	readonly />
		</td>
		<td class="blue">��������</td>
		<td>
			<input	class="InputGrey"	type="text"	name="oCustName"
				id="oCustName"	value="<%=bp_name%>"	readonly />
		</td>
	</tr>	
	<tr>
		<td class="blue">ҵ��Ʒ��</td>
		<td>		
			<input	class="InputGrey"	type="text"	name="oSmName"
				id="oSmName"	value="<%=sm_name%>"	readonly />
		</td>
		<td class="blue">�ʷ�����</td>
		<td>
			<input	class="InputGrey"	type="text"	name="oModeName"
				id="oModeName"	value="<%=rate_name%>"	readonly />
		</td>
	</tr>	
	<tr>
		<td class="blue">�ʺ�Ԥ��</td>
		<td>		
			<input	class="InputGrey"	type="text"	name="oPrepayFee"
				id="oPrepayFee"	value="<%=prepay_fee%>"	readonly />		
		</td>
		<td class="blue">��ǰ����</td>
		<td>		
			<input	class="InputGrey"	type="text"	name="oMarkPoint"
				id="oMarkPoint"	value="<%=print_note%>"	readonly />			
		</td>
	</tr>	
	
	<tr> 
		<td class="blue">�ֻ�Ʒ��</td>
		<td> 
			<select id="phone_brand">
			</select>
		</td>
		<td class="blue">�ֻ����� </td>
		<td> 
			<select id="phone_type">				
			</select>
		</td>
	</tr>  
	<tr> 
		<td class="blue">Ӫ������</td>
		<td> 
			<select id="sale_ways">
			</select>
		</td>
		<td class="blue">�����ʷ� </td>
		<td> 
			<select id="mode_sale">
			</select>
		</td>
	</tr> 	
	
	
	<tr>
		<td class="blue">�������</td>
		<td>
			<input name="active_term" type="text" class="InputGrey" 
				id="active_term"  readonly />
			<input type="hidden" name="sale_name" id="sale_name" >		
		</td>
		<td class="blue">IMEI��</td>
		<td>
			<input name="IMEINo" id="IMEINo" class="button" type="text" 
				v_type="0_9" v_name="IMEI��"  maxlength=15 value="" 
				onblur="viewConfirm()">
			<input name="checkimei" class="b_text" type="button" 
			value="У��" onclick="checkimeino()" >
			<font color="orange">*</font>		
		</td>
	</tr>
	<tr>
		<td class="blue">�ֽ�Ԥ��</td>
		<td>		
			<input name="prepay_limit" type="text" 
				class="InputGrey" id="prepay_limit"  readonly />
			<input name="mon_prepay_limit" type="hidden" 
				class="InputGrey" id="mon_prepay_limit"  readonly />
		</td>
		<td class="blue">��Լ����</td>
		<td>
			<input class="InputGrey" type="text" id="consume_term" 
				name="consume_term" readonly />		
		</td>
	</tr>		
	<tr>
		<td class="blue">���Żݶ��</td>
		<td>		
			<input class="InputGrey" type="text" id="free_fee" 
				name="free_fee" readonly />	
		</td>
		<td class="blue">�Żݱ���(%)</td>
		<td>		
			<input class="InputGrey" type="text" id="base_fee" 
				name="base_fee" readonly />	
		</td>
	</tr>				
	<tr>
	  <%/*%>
		<td class="blue"> �����ֻ���</td>
		<td >			
			<input class="" type="text" id="phoneOther" 
				name="phoneOther"  maxlength=11 />(��ͨ/�����ֻ�����)			
		</td>
		<%*/%>
		<td class="blue"> Ӧ�ս��</td>
		<td colspan="3">			
			<input  class="InputGrey"  type="text" id="cashPay" 
				name="cashPay"  />	
		  <input type="hidden" id="phoneOther" name="phoneOther" value="" />		
		</td>
	</tr>		
	<tr>
        <td class="blue">
					<div align="left">�ɷѷ�ʽ</div>
				</td>
				<td colspan ="3">
					<select name="payType" >
						<option value="0" checked>�ֽ�ɷ�</option>
						<option value="BX">��������POS���ɷ�</option>
						<option value="BY">��������POS���ɷ�</option>
					</select>
				</td>
	</tr>	
	<tr>
		<td class="blue">������ע</td>
		<td colspan="3">
			<input name="op_note" type="text" size="80" v_maxlength=60 id="op_note" 
				value="��������-�����ƻ�" />
		</td>
	</tr>
	<tr> 
		<td colspan="4" align="center" id="footer"> 
			<input class="b_foot" type=button name="next_step" 
				id="next_step" value="��һ��">    
			<input class="b_foot" type=button name="reset_btn" 
				id="reset_btn" value="���"">
			<input class="b_foot" type=button name="closeBtn" value="�ر�" 
				onClick="removeCurrentTab();">
		</td>
	</tr>
</table>
</div>

<!--���²�����Ϊ��f1270_3.jsp������Ĳ���
	i2:�ͻ�ID
	i16:��ǰ���ײʹ���
	ip:�������ײʹ���
	belong_code:belong_code
	print_note:��������
	iAddStr:

	i1:�ֻ�����
	i4:�ͻ�����
	i5:�ͻ���ַ
	i6:֤������
	i7:֤������
	i8:ҵ��Ʒ��

	ipassword:����
	group_type:���ſͻ����
	ibig_cust:��ͻ����
	do_note:�û���ע
	favorcode:�������Ż�Ȩ��
	maincash_no:�����ײʹ��루�ϣ�
	imain_stream:��ǰ���ʷѿ�ͨ��ˮ
	next_main_stream:ԤԼ���ʷѿ�ͨ��ˮ

	i18:�������ײ�
	i19:������
	i20:���������
	-->
	<input type="hidden" name="i2" value="<%=cust_id%>"> <!-- �ͻ�id -->
	<input type="hidden" name="i16" value="<%=rate_code%>"> <!-- �ʷѴ��� -->
	<input type="hidden" name="iOpCode" value="<%=opCode%>"> <!-- opCode -->
	<input type="hidden" name="ip" id="ip" value=""> <!-- �����ʷ� -->
	<input type="hidden" name="belong_code" value="<%=cust_belong_code%>"> <!-- �ͻ�����id-->
	<input type="hidden" name="print_note" value="<%=print_note%>"> <!--�����л�ȡ �������-->
	<input type="hidden" name="iAddStr"  id="iAddStr" value="">
	
	<input type="hidden" name="i1" value="<%=activePhone%>"> <!--phoneNo -->
	<input type="hidden" name="i4" value="<%=bp_name%>"> <!-- �������� -->
	<input type="hidden" name="i5" value="<%=bp_add%>"> <!-- ������ַ -->
	<input type="hidden" name="i6" value="<%=cardId_type%>"> <!-- ֤������ -->
	<input type="hidden" name="i7" value="<%=cardId_no%>"> <!-- ֤������ -->
	<input type="hidden" name="i8" value="<%=sm_code%>--<%=sm_name%>"> <!--������ ??�����opCode �� opName? -->
	<input type="hidden" name="i9" value="<%=contract_flag%>"> <!--������ �Ƿ������˻�-->
	
	
	<input type="hidden" name="ipassword" value="">
	<input type="hidden" name="group_type" value="<%=group_type_code%>--<%=group_type_name%>">
	<input type="hidden" name="ibig_cust" value="<%=bigCust_flag%>--<%=bigCust_name%>">
	<input type="hidden" name="do_note" id="do_note" value="">
	<input type="hidden" name="favorcode" value="<%=favorcode%>">
	<input type="hidden" name="maincash_no" value="<%=rate_code%>">
	<input type="hidden" name="imain_stream" value="<%=imain_stream%>">
	<input type="hidden" name="next_main_stream" value="<%=next_main_stream%>">
	
	<input type="hidden" name="i18" value="<%=next_rate_code%>--<%=next_rate_name%>">
	<input type="hidden" name="i19" value="<%=hand_fee%>">
	<input type="hidden" name="i20" value="<%=hand_fee%>">
	<input type="hidden" name="cus_pass" value=""> <!-- �Ƿ���Բ��ô�ֵ -->
	
	<input type="hidden" name="mode_type" value="">
	<input type="hidden" name="new_Mode_Name" id="new_Mode_Name" value="">
	<input type="hidden" name="return_page" value="/npage/se720/fE720Login.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>">
	<input type="hidden" name="sale_kind" value="">
	<input type="hidden" name="main_phoneno" value="">
	<input type="hidden" name="printAccept" value="<%=loginAccept%>">
	<input type="hidden" name="opName" value="<%=opName%>">
<%@ include file="/npage/include/footer.jsp" %>
</form>
	
</body>
</html>