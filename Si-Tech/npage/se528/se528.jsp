<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����: �Ա�����Լ�ƻ�
   * �汾: 1.0
   * ����: 2011/12/12
   * ����: liujian
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	response.setHeader("Pragma","No-Cache");
  response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0);
	String sale_type = "48";
	String loginNo = (String)session.getAttribute("workNo");
	String loginName = (String)session.getAttribute("workName");

	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = (String)session.getAttribute("regCode");
	String groupId = (String)session.getAttribute("groupId");
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	String iPhoneNo = activePhone;
	/* liujian ��ȫ�ӹ��޸� 2012-4-6 16:18:13 begin */
//String loginNoPass = (String)session.getAttribute("password");
	String op_strong_pwd = (String) session.getAttribute("password");
  /* liujian ��ȫ�ӹ��޸� 2012-4-6 16:18:13 end */
	//lj. �󶨲���
	String sql_select1 = "SELECT UNIQUE a.brand_code, TRIM (b.brand_name) FROM dphonesalecode a, schnresbrand b WHERE a.region_code = :region_code  AND a.brand_code = b.brand_code AND a.valid_flag = 'Y' AND a.sale_type = :sale_type";
	String srv_params1 = "region_code=" + regionCode + ",sale_type=" + sale_type;
	//��ȡƷ������
%>
	<wtc:service name="TlsPubSelCrm" outnum="2">
		<wtc:param value="<%=sql_select1%>"/>
		<wtc:param value="<%=srv_params1%>"/>
	</wtc:service>
	<wtc:array id="result_brand" scope="end"/>
<%
	StringBuffer brandSb = new StringBuffer("");
	brandSb.append("<option value ='-1'>��ѡ��</option>");
	for(int i=0; i<result_brand.length; i++) {
		  brandSb.append("<option value ='").append(result_brand[i][0]).append("'>")
						 .append(result_brand[i][1])
						 .append("</option>");
	}
	
	//��ȡ���е��ֻ��ͺ�
	//lj. �󶨲���
	String sql_select2 = "select unique a.type_code,trim(b.res_name), b.brand_code from dphoneSaleCode a,schnrescode_chnterm b  where a.region_code=:region_code and  a.type_code=b.res_code and a.brand_code=b.brand_code  and a.valid_flag='Y' and a.sale_type=:sale_type";
	String srv_params2 = "region_code=" + regionCode + ",sale_type=" + sale_type;
	
%>
	<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
			
	<wtc:service name="TlsPubSelCrm" outnum="3">
		<wtc:param value="<%=sql_select2%>"/>
		<wtc:param value="<%=srv_params2%>"/>
	</wtc:service>
	<wtc:array id="result_type" scope="end"/>


<%
	String  inputParsm[] = new String[4];
	inputParsm[0] = iPhoneNo;
	inputParsm[1] = loginNo;
	inputParsm[2] = orgCode;
	inputParsm[3] = opCode;
	System.out.println("----------orgCode=" + orgCode +"------------phoneNO === "+ iPhoneNo);
	System.out.println("----------loginNo=" + loginNo +"------------opCode === "+ opCode);
%>

  <wtc:service name="s126bInit" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="retCode2" retmsg="retMsg2" outnum="29">
		<wtc:param value=""/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=op_strong_pwd%>"/>
		<wtc:param value="<%=iPhoneNo%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=inputParsm[2]%>"/>
	</wtc:service>
	<wtc:array id="tempArr"  scope="end"/>
		
<%
	System.out.println("----------liujian--------errCode2=" + retCode2);
  String errCode = retCode2;
  String errMsg = retMsg2;
  String  retFlag="";
  String  bp_name="",sm_code="",family_code="",rate_code="",bigCust_flag="",sm_name="";
  String  rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="";
  String  prepay_fee="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="";
  String  group_type_code="",group_type_name="",imain_stream="",next_main_stream="",hand_fee="";
  String  favorcode="",card_no="",print_note="",contract_flag="",high_flag="",passwordFromSer="";
  if(tempArr.length==0)
  {
	   retFlag = "1";
	   retMsg = "s126bInit��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
  }
  else if(errCode.equals("000000") && tempArr.length>0)
  {

	    bp_name = tempArr[0][3];           //��������

	    bp_add = tempArr[0][4];            //�ͻ���ַ

	    passwordFromSer = tempArr[0][2];  //����

	    sm_code = tempArr[0][11];         //ҵ�����

	    sm_name = tempArr[0][12];        //ҵ���������

	    hand_fee = tempArr[0][13];      //������

	    favorcode = tempArr[0][14];     //�Żݴ���

	    rate_code = tempArr[0][5];      //�ʷѴ���

	    rate_name = tempArr[0][6];     //�ʷ�����

	    next_rate_code = tempArr[0][7];//�����ʷѴ���

	    next_rate_name = tempArr[0][8];//�����ʷ�����

	    bigCust_flag = tempArr[0][9];//��ͻ���־

	    bigCust_name = tempArr[0][10];//��ͻ�����

	    lack_fee = tempArr[0][15];//��Ƿ��

	    prepay_fee = tempArr[0][16];//��Ԥ��

	    cardId_type = tempArr[0][17];//֤������

	    cardId_no = tempArr[0][18];//֤������

	    cust_id = tempArr[0][19];//�ͻ�id

	    cust_belong_code = tempArr[0][20];//�ͻ�����id

	    group_type_code = tempArr[0][21];//���ſͻ�����

	    group_type_name = tempArr[0][22];//���ſͻ���������

	    imain_stream = tempArr[0][23];//��ǰ�ʷѿ�ͨ��ˮ

	    next_main_stream = tempArr[0][24];//ԤԼ�ʷѿ�ͨ��ˮ

	    print_note = tempArr[0][25];//�������

	    contract_flag = tempArr[0][27];//�Ƿ������˻�

	    high_flag = tempArr[0][28];//�Ƿ��и߶��û�
	    
	    
	    for(int m = 0 ; m<tempArr[0].length; m++){
	    	System.out.println("------lj-------tempArr[" + m + "]--------" + tempArr[0][m]);
	    }

	 }else{%>
		<script language="JavaScript">
			rdShowMessageDialog("������룺<%=errCode%>��������Ϣ��<%=errMsg%>",0);
			history.go(-1);
		</script>
<%	 
	}
%>

<%
//******************��ѯ�ʷ�����***************************//
	//lj. �󶨲���
	String sql_select3 = "select offer_name from product_offer where offer_id =:rate_code";
	String srv_params3 = "rate_code=" + rate_code;
%>
<wtc:service name="TlsPubSelCrm" outnum="1" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=sql_select3%>"/>
		<wtc:param value="<%=srv_params3%>"/>
</wtc:service>
<wtc:array id="resultOffer_name" scope="end"/>
<%
  System.out.println("resultOffer_name"+resultOffer_name); 
	if(!code1.equals("000000")&&!code1.equals("0")){%>
		<script language="JavaScript">
			rdShowMessageDialog("��ѯ�ʷ����Ƴ���������룺<%=code1%>��������Ϣ��<%=msg1%>",0);
			history.go(-1);
		</script>
	<%}
	else
	{
		if(resultOffer_name.length>0&&resultOffer_name[0][0]!=null)
		{
			rate_name = resultOffer_name[0][0];
		}
	  else
  	{%>
  	<script language="JavaScript">
			rdShowMessageDialog("�ʷ�����Ϊ�գ�",0);
			history.go(-1);
		</script>
  	<%
  	}
	}
%>

<html xmlns="http://www.w3.org/1999/xhtml">
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
			 for(int i=0;i<result_type.length;i++) {
			%>
					if(typeof phone_types[<%= result_type[i][2]%>] == 'undefined') {
						phone_types[<%= result_type[i][2]%>] = {};
					}
					var typeObj = phone_types[<%= result_type[i][2]%>];
					typeObj['<%= result_type[i][0]%>'] = '<%= result_type[i][1]%>'
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
					var flagCodeObj = $("#flagCode");
					flagCodeObj.empty();
					var consObj = flagCodeObj.parent().parent().find("td:gt(1)");
					consObj.hide();
					$("#offerAttrFlag").val("");
					$("#flag_code").val("");
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
						var flagCodeObj = $("#flagCode");
						flagCodeObj.empty();
						var consObj = flagCodeObj.parent().parent().find("td:gt(1)");
						consObj.hide();
						$("#offerAttrFlag").val("");
						$("#flag_code").val("");
						if(typeCode == -1 || typeCode == '-1'){
							reset();
							return;
						}
						$('#p3').val($('#phone_type').val());
						 var packet = new AJAXPacket("srv.jsp","���ڻ�������Ϣ�����Ժ�......");
						 var _data = packet.data;
						 _data.add("sale_type","<%=sale_type%>");
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
						var flagCodeObj = $("#flagCode");
						flagCodeObj.empty();
						var consObj = flagCodeObj.parent().parent().find("td:gt(1)");
						consObj.hide();
						$("#offerAttrFlag").val("");
						$("#flag_code").val("");
						if(sale_code == -1 || sale_code == '-1'){
							reset();
							return;
						}
						 var packet = new AJAXPacket("srv.jsp","���ڻ�������Ϣ�����Ժ�......");
						 var _data = packet.data;
						 _data.add("sale_type","<%=sale_type%>");
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
						 var packet = new AJAXPacket("srv.jsp","���ڻ�������Ϣ�����Ժ�......");
						 var _data = packet.data;
						 _data.add("sale_type","<%=sale_type%>");
						 _data.add("sale_code",sale_code);
						 _data.add("mode_code",mode_sale);
						 _data.add("method","apply_getPayInfo");
						 core.ajax.sendPacket(packet,getPayInfoProcess);
						 packet = null;
				});
				/********************** ѡ��С�� *******************************/
				$("#flagCode").change(function(){
					var flag_code = $("#flagCode").val();
					if(typeof(flag_code) != "undefined" && flag_code != "undefined" && flag_code != "normal"){
						$("#flag_code").val(flag_code);
					}
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
						$('#IMEINo').val('');
				})
				
		})
	/*************************����ֻ�����input��ֵ****************************/	
	function reset() {
		$('#prepay_limit').val(''); //����Ԥ��
		$('#prepay_gift').val('');  //�Ԥ��
		$('#mon_base_fee').val(''); //������Ԥ���
		$('#consume_term').val(''); //ҵ����Ч��
		$('#active_term').val('');  //�������
		$('#sale_price').val('');   //�û��ɷѺϼ�
		$('#sale_name').val('');
		$('#sale_name_span').text('');
		var flagCodeObj = $("#flagCode");
		flagCodeObj.empty();
		var consObj = flagCodeObj.parent().parent().find("td:gt(1)");
		consObj.hide();
		$("#offerAttrFlag").val("");		
		$("#flag_code").val("");
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
			var offerAttrFlag = package.data.findValueByName("offerAttrFlag");
			var offerAttrResult = package.data.findValueByName("offerAttrResult");
			if(retCode == "000000") {
				$('#prepay_limit').val(result.prepay_limit); //����Ԥ��
				$('#prepay_gift').val(result.prepay_gift);   //�Ԥ��
				$('#mon_base_fee').val(result.mon_base_fee); //������Ԥ���
				$('#consume_term').val(result.consume_term); //ҵ����Ч��
				$('#active_term').val(result.active_term);   //�������
				$('#sale_price').val(result.sale_price);     //�û��ɷѺϼ�
				$('#i16').val($('#mode_sale').val());
				if(result.sale_name != null && result.sale_name != "") {
					$('#sale_name_span').text(result.sale_name + '--');
					$('#sale_name').val(result.sale_name + '--');
				}
			 $('#mon_prepay_limit').val(result.mon_prepay_limit);
			 var flagCodeObj = $("#flagCode");
			 flagCodeObj.empty();
			 flagCodeObj.append("<option value='normal'>--��ѡ��--</option>");
			 var consObj = flagCodeObj.parent().parent().find("td:gt(1)");
			 consObj.hide();
			 $("#offerAttrFlag").val(offerAttrFlag);
			 if(offerAttrFlag == "Y"){
			 		consObj.show();
					$.each(offerAttrResult,function(i,n){
						flagCodeObj.append("<option value='"+n[0]+"'>"+n[1]+"</option>");
					});
			 }else{
			 		
				}
			}else {
				rdShowMessageDialog("������룺" + retCode + "��������Ϣ��" + retMsg,0);
				return false;
			}
	}
	
	/*************************��֤IMEI****************************/
	function checkimeino() {
	 if($('#IMEINo').val().length == 0){
      rdShowMessageDialog("IMEI���벻��Ϊ�գ����������� !!");
      document.frm.IMEINo.focus();
      $('#next_step').attr('disabled','disabled');
	 	  return false;
    }else if($('#IMEINo').val().length != 15) {
    	rdShowMessageDialog("IMEI����ӦΪ15λ������������ !!");
      document.frm.IMEINo.focus();
      $('#next_step').attr('disabled','disabled');
	 	  return false;
    }else if(!new RegExp(/^[0-9]{15}$/).test($.trim($('#IMEINo').val()))){
    	rdShowMessageDialog("IMEI����ӦΪ15λ���֣����������� !!");
      document.frm.IMEINo.focus();
      $('#next_step').attr('disabled','disabled');
	 	  return false;
    }
     
		var packet = new AJAXPacket("<%=request.getContextPath()%>/npage/se528/srv.jsp","����У��IMEI��Ϣ�����Ժ�......");
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
				document.frm.next_step.disabled=false;
				document.frm.IMEINo.readOnly = true;
				return ;

		}else if(retResult == "000003"){
				rdShowMessageDialog("IMEI�Ų���ӪҵԱ����Ӫҵ����IMEI����ҵ�������Ͳ�����");
				document.frm.next_step.disabled=true;
				return false;
		}else if(retResult == "000004"){
				rdShowMessageDialog("��IMEI���Ѿ�������������ٴΰ���");
				document.frm.next_step.disabled=true;
				return false;
		}else{
				rdShowMessageDialog("IMEI�Ų����ڻ����Ѿ�ʹ�ã�");
				document.frm.next_step.disabled=true;
				return false;
		}
 }
 
  function viewConfirm(){
		if(document.frm.IMEINo.value==""){
			document.frm.next_step.disabled=true;
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
		/*У��*/
		var offerAttrFlag = $("#offerAttrFlag").val();
		if(offerAttrFlag == "Y"){
			var flagCodeObj = $("#flagCode");
			if(flagCodeObj.val() == "normal"){
				rdShowMessageDialog("��ѡ��С����");
				return false;	
			}
		}
		
		//ƴ��һϵ�в���
		//Ӫ������|Ʒ������|Ʒ���ͺţ��û��ɷѺϼƣ�����Ԥ����������ޣ��Ԥ���������ޣ����������0��imei��|�׶λ����|�µ�������
		 var str =$('#sale_ways').val()    + "|" +
							$('#phone_brand').find('option:selected').text() + "|" +
							$('#phone_type').find('option:selected').text()  + "|" +
							$('#sale_price').val()   + "|" +
							$('#prepay_limit').val() + "|" +
							$('#consume_term').val() + "|" +
							$('#prepay_gift').val()  + "|" +
							$('#active_term').val()  + "|" +
							$('#mon_base_fee').val() + "|" +  
							'0'                      + "|" + 
							$('#IMEINo').val()       + "|" + 
							$('#mon_prepay_limit').val() + "|" + 
							$('#sale_name').val(); 
		$('#iAddStr').val(str);
		$('#ip').val($('#mode_sale').val());
		$('#do_note').val($('#op_note').val());
		frm.submit();
}

</script>
</head>
<body>
  <form name="frm" method="post" action="../bill/f1270_3.jsp">
		<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
			<div id="title_zi"><span id="sale_name_span"></span><%=opName%></div>
		</div>
		<table cellspacing="0">
			<tr>
				<td class="blue">�ֻ�����</td>
				<td width="39%">
					<input class="InputGrey" type="text" v_must="1" v_type="mobphone" v_must=1 name="phoneNo" value="<%=activePhone%>" id="phoneNo" maxlength=11 index="3" readonly />
				</td>
				<td class="blue">��������</td>
				<td>
					<input name="oCustName" type="text" class="InputGrey" id="oCustName" value="<%=bp_name%>" readonly />
				</td>
			</tr>
			<tr>
				<td class="blue">ҵ��Ʒ��</td>
				<td width="39%">
					<input name="oSmName" type="text" class="InputGrey" id="oSmName" value="" readonly>
				</td>
				<td class="blue">�ʷ�����</td>
        <td>
					<input name="oModeName" type="text" class="InputGrey" id="oModeName" value="" readonly>
				</td>
				
			</tr>
			<tr>
				<td class="blue">�ʺ�Ԥ��</td>
				<td>
					<input name="oPrepayFee" type="text" class="InputGrey" id="oPrepayFee" value="" readonly>
				</td>
				<td class="blue">��ǰ����</td>
				<td>
					<input name="oMarkPoint" type="text" class="InputGrey" id="oMarkPoint" value="" readonly />
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
				<td colspan="3"> 
					<select id="sale_ways">
					</select>
				</td>
			</tr> 
			<tr>
				<td class="blue">�����ʷ� </td>
				<td> 
					<select id="mode_sale">
					</select>
				</td>
				<td class="blue" style="display:none;">С������</td>
				<td style="display:none;">
					<select id="flagCode">
					</select>
				</td>
			</tr>
			
			<tr>
				<td class="blue">����Ԥ��</td>
				<td>
					<input name="prepay_limit" type="text" class="InputGrey" id="prepay_limit"  readonly />
		    	<input name="mon_prepay_limit" type="hidden" class="InputGrey" id="mon_prepay_limit"  readonly />
				</td>
				<td class="blue">�Ԥ��</td>
				<td width="39%">
					<input class="InputGrey" type="text" name="prepay_gift" id="prepay_gift" readonly />
				</td>
			</tr>
			<tr>
				<td class="blue">������Ԥ���</td>
				<td width="39%">
					<input class="InputGrey" type="text" id="mon_base_fee" name="mon_base_fee" readonly />
				</td>	
				<td class="blue">ҵ����Ч��</td>
				<td width="39%">
					<input class="InputGrey" type="text" id="consume_term" name="consume_term" readonly />
				</td>			
			<tr>
				<td class="blue">�������</td>
				<td>
					<input name="active_term" type="text" class="InputGrey" id="active_term"  readonly />
					<input type="hidden" name="sale_name" id="sale_name" >
				</td>
				<td class="blue">�û��ɷѺϼ�</td>
				<td>
					<input name="sale_price" type="text" class="InputGrey" id="sale_price"  readonly />
				</td>
			</tr>
			<tr>
				<td class="blue">IMEI��</td>
        <td>
        	
					<input name="IMEINo" id="IMEINo" class="button" type="text" v_type="0_9" v_name="IMEI��"  maxlength=15 value="" onblur="viewConfirm()">
					<input name="checkimei" class="b_text" type="button" value="У��" onclick="checkimeino()" >
          	<font color="orange">*</font>
        </td>
        <td class="blue">
					<div align="left">�ɷѷ�ʽ</div>
				</td>
				<td>
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
					<input name="op_note" type="text" size="80" v_maxlength=60 id="op_note" value="�Ա�����Լ�ƻ�" />
				</td>
			</tr>
	<tr> 
		<td colspan="4" align="center" id="footer"> 
			<input class="b_foot" type=button name="next_step" id="next_step" value="��һ��" index="2">    
			<input class="b_foot" type=button name="reset_btn" id="reset_btn" value="���"">
			<input class="b_foot" type=button name=qryP value="�ر�" onClick="removeCurrentTab();">
		</td>
	</tr>
		 </table>
		 
		 <div name="licl" id="licl">

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
			<input type="hidden" name="return_page" value="/npage/se528/se528_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=iPhoneNo%>">
			<input type="hidden" name="sale_kind" value="">
			<input type="hidden" name="main_phoneno" value="">
			<input type="hidden" name="printAccept" value="<%=loginAccept%>">
			<input type="hidden" name="opName" value="<%=opName%>">
			<input type="hidden" name="offerAttrFlag" id="offerAttrFlag" value="">
			<input type="hidden" name="flag_code" id="flag_code" value="">
</div>
		  <%@ include file="/npage/include/footer.jsp" %>
	</form>
	<%@ include file="/npage/public/posCCB.jsp" %>
	<%@ include file="/npage/public/posICBC.jsp" %>
</body>
</html>
