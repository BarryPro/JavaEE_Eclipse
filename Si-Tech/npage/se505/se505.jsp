<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����: 
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
  //������
	String sale_type = "47";
	String loginNo = (String)session.getAttribute("workNo");
	String loginName = (String)session.getAttribute("workName");
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = (String)session.getAttribute("regCode");
	String groupId = (String)session.getAttribute("groupId");
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	String iPhoneNo = activePhone;
	//���Ӳ���������վԤԼ��ǰ̨����ningtn
	String banlitype =request.getParameter("banlitype");
	/* liujian ��ȫ�ӹ��޸� 2012-4-6 16:18:13 begin */
	//String loginNoPass = (String)session.getAttribute("password");
		String op_strong_pwd = (String) session.getAttribute("password");
	  /* liujian ��ȫ�ӹ��޸� 2012-4-6 16:18:13 end */
	//lj. �󶨲���
	String sql_select1 = "SELECT UNIQUE a.brand_code, TRIM (b.brand_name) FROM dphonesalecode a, schnresbrand b WHERE a.region_code = :region_code  AND a.brand_code = b.brand_code AND a.valid_flag = 'Y' AND a.sale_type = :sale_type";
	String srv_params1 = "region_code=" + regionCode + ",sale_type=" + sale_type;
	//
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
	var bankInstalArr = new Array();
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
					setFeeMark(false);
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
				//liujian add 
				$('#feeMark').change(function(e) {
					getMarkPoint();
					e.stopPropagation();
				});
				
		})
	/*************************����ֻ�����input��ֵ****************************/	
	function reset() {
		$('#prepay_limit').val('');
		$('#prepay_gift').val('');
		$('#consume_term').val('');
		$('#mon_base_fee').val('');
		$('#base_fee').val('');
		$('#sale_price').val('');
		$('#sale_price_source').val('');
		$('#active_term').val('');
		$('#sale_name').val('');
		$('#sale_name_span').text('');
	}
	/*************************�л��ͺţ�ajax���ص�Ӫ����������****************************/
	function getSaleWaysProcess(package) {
			var retCode = package.data.findValueByName("retcode");
			var retMsg = package.data.findValueByName("retmsg");
			var result = package.data.findValueByName("result");
			if(retCode == "000000") {
				setFeeMark(false);
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
				setFeeMark(false);
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
				setFeeMark(true);
				$('#prepay_limit').val(result.prepay_limit);
				$('#prepay_gift').val(result.prepay_gift);
				$('#consume_term').val(result.consume_term);
				$('#mon_base_fee').val(result.mon_base_fee);
				/***������base_fee**/
				var baseFee = result.base_fee;
				$('#base_fee').val(result.base_fee);
				/**�û��ɷѺϼ�(result.sale_price)**/
				var salePrice = result.sale_price;
				$('#sale_price').val(result.sale_price);
				$('#sale_price_source').val(result.sale_price);
				$('#active_term').val(result.active_term);
				$('#sale_name').val(result.sale_name);
				$('#i16').val($('#mode_sale').val());
				if(result.sale_name != null && result.sale_name != "") {
					$('#sale_name_span').text(result.sale_name + '--');
					$('#e505_sale_name').val(result.sale_name + '--');
				}
				$('#mon_prepay_limit').val(result.mon_prepay_limit);
				/*�ж��û��Ƿ����ʹ��POS�����ڸ��� ningtn*/
				$("#instalTd").hide();
				$("#installmentTd").hide();
				checkInstal(baseFee,salePrice);
			}else {
				rdShowMessageDialog("������룺" + retCode + "��������Ϣ��" + retMsg,0);
				return false;
			}
	}
	
	function checkInstal(vMachFee,vPrePay){
		/********
			�������
			vMachFee ������
			vPrePay �ɷѺϼ�
		*/
		/*����һ�½ɷѷ�ʽ�����ҳ�ʼ���ɷѷ�ʽ*/
		$("#payType").find("option:gt(2)").remove();
		$("#payType")[0].selectedIndex=0;
		var v_regionCode = "<%=regionCode%>";
		var selectSql = "Select to_char(bank_code),to_char(bank_name),to_char(bank_paytype),to_char(instal_numbers),to_char(income_ratios) FROM ssaleinstal WHERE machine_fee <= :vMachFee AND begine_fee<=:vPrePay AND end_fee>:vPrepay and region_code in('"+v_regionCode+"','99') and func_code='e505'";
		var params = "vMachFee=" + vMachFee + ",vPrePay=" + vPrePay+ ",vPrePay=" + vPrePay;
		var getInstal_Packet = new AJAXPacket("/npage/public/pubSelectBySql.jsp","����У�����Ժ�......");
		getInstal_Packet.data.add("selectSql",selectSql);
		getInstal_Packet.data.add("params",params);
		getInstal_Packet.data.add("wtcOutNum","5");
		core.ajax.sendPacket(getInstal_Packet,doQryInstalBack);
		getInstal_Packet = null;
	}
	function doQryInstalBack(packet){
		var retcode = packet.data.findValueByName("retcode");
		var retmsg = packet.data.findValueByName("retmsg");
		var result = packet.data.findValueByName("result");
		if(retcode == "000000"){
			if(result.length > 0){
				/*֤���п��Խ��з��ڸ��������*/
				bankInstalArr = result;
				/******
					ͬһ���еĿ�ʼ�������û���ص�
					��������ж���(����һ��)��Ϣһ���Ƕ������
				*/
				$.each(bankInstalArr,function(i,n){
					var optionInsertStr = "<option value='"+ n[2] +"'>"+n[1]+"���ÿ����ڸ���</option>";
					$("#payType").append(optionInsertStr);
				});
			}
		}
	}
	/*************************��֤IMEI****************************/
	function checkimeino() {
	 if($('#IMEINo').val().length == 0){
      rdShowMessageDialog("IMEI���벻��Ϊ�գ����������� !!");
      document.frm.IMEINo.focus();
      $('#next_step').attr('disabled','disabled');
	 	  return false;
     }
		var myPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/s1141/queryimei.jsp","����У��IMEI��Ϣ�����Ժ�......");
		myPacket.data.add("imei_no",$.trim($('#IMEINo').val()));
		myPacket.data.add("brand_code",$('#phone_brand').val());
		myPacket.data.add("style_code",$('#phone_type').val());
		myPacket.data.add("opcode",'<%=opCode%>');
		myPacket.data.add("retType","0");
		core.ajax.sendPacket(myPacket);
		myPacket=null;
	}
	
	// ��ò�����IMEI
	function doProcess(packet) {
	    var vRetPage=packet.data.findValueByName("rpc_page");
			var retType=packet.data.findValueByName("retType");
			var verifyType = packet.data.findValueByName("verifyType");
			if(retType=="0"){
				var  retResult=packet.data.findValueByName("retResult");
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
				}else{
						rdShowMessageDialog("IMEI�Ų����ڻ����Ѿ�ʹ�ã�");
						document.frm.next_step.disabled=true;
						return false;
				}
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
		//ƴ��һϵ�в���
		/*	
				phone_brand �ֻ�Ʒ��
				phone_type  �ֻ�����
				sale_ways   Ӫ������
				mode_sale    �����ʷ�
				prepay_limit������Ԥ�� (����)
				prepay_gift���Ԥ�� ���ܺͣ�
				consume_term��Ԥ���������ޣ��£�
				mon_base_fee���µ�������
				base_fee���û�������
				sale_price���û��ɷѺϼƣ�Ӧ�ս�
				active_term:������ޣ��£�
				sale_name���׶λ����
		*/
		if(!check(document.frm) ) {
			return false;
		}
		/*
			���ѡ����Ƿ��ڸ���Ļ�
			���ӷ��ڸ������������Ϣ����
		*/
		var payTypeVal = $("#payType").val();
		var instalNum = "";
		var instalIncome = "";
		if(payTypeVal != "0" && payTypeVal != "BX" && payTypeVal != "BY"){
			instalNum = $("input[@name='installmentList'][@checked]").val();
			instalIncome = $("input[@name='installmentList'][@checked]").attr("income");
		}
		 var str = $('#phone_brand').find('option:selected').text() + "|" +
					$('#phone_type').find('option:selected').text()   + "|" +
					$('#sale_ways').val()    + "|" +
					$('#mode_sale').val()    + "|" +
					$('#prepay_limit').val() + "|" +
					$('#prepay_gift').val()  + "|" +
					$('#consume_term').val() + "|" +
					$('#mon_base_fee').val() + "|" +
					$('#base_fee').val()     + "|" +
					$('#sale_price').val()   + "|" +
					$('#active_term').val()  + "|" +
					$('#sale_name').val()    + "|" +   
					$('#IMEINo').val()      + "|" + 
					$('#mon_prepay_limit').val() + "|" +
					$('#feeMark').val() + "|" +
					$('#pointMoney').val() +"|"+
					instalNum + "|" +
					instalIncome
					;
		$('#iAddStr').val(str);
		$('#ip').val($('#mode_sale').val());
		//"�û�"+document.all.phoneNo.value+"�����Լ�ƻ�����Ӫ������Ӫ�����룺"+$('#sale_ways').val()
		$('#do_note').val($('#op_note').val());
		frm.submit();
	}

	/*liujian 2012-7-26 13:51:44 add*/
	function getMarkPoint() {
		/*У��*/
		if(!checkElement(document.all.phoneNo)) return;
		if(!$('#phone_brand').val()) {
			rdShowMessageDialog("��ѡ���ֻ�Ʒ��!");
			$('#phone_brand').focus();
			return false;
		}
		if(!$('#phone_type').val()) {
			rdShowMessageDialog("��ѡ���ֻ��ͺ�!");
			$('#phone_type').focus();
			return false;
		}
		if(!$('#sale_ways').val()) {
			rdShowMessageDialog("��ѡ��Ӫ������!");
			$('#sale_ways').focus();
			return false;
		}	
		var fm =  $('#feeMark').val();
		if(isNaN(fm)) {
			rdShowMessageDialog("���ѻ��ֱ���������!");
			$('#feeMark').val("0");
			$('#feeMark').focus();
			return false;
		}
		/*ָ��Ajax����ҳ*/
		var packet = new AJAXPacket("fe505_ajax.jsp","���Ժ�...");
			
		/*��ajaxҳ�洫�ݲ���*/
		packet.data.add("opCode","<%=opCode%>" );
		packet.data.add("phoneNo",document.all.phoneNo.value );
		/*������*/
		packet.data.add("machPrice",$('#base_fee').val());
		/*���ѻ���*/
		packet.data.add("markPoint",  parseInt($('#feeMark').val() ,10));
		
		/*����ҳ��,��ָ���ص�����*/
		core.ajax.sendPacket(packet,setMarkPoint,false);
		packet=null;
	}
	
	/*liujian 2012-7-26 13:55:30 add*/
	function setMarkPoint(packet) {
		/*Prepay_Fee Ӧ�ս��*/
		var rtCode=packet.data.findValueByName("rtCode"); 	
		var rtMsg=packet.data.findValueByName("rtMsg"); 		
		if ( rtCode=="000000" ) {
			/*���ֶ�Ӧ��Ǯ��*/
			var	rstMarkQry	=packet.data.findValueByName("rstMarkQry"); 
			/*����ֵ*/
			$('#pointMoney').val(rstMarkQry);
			var ppFee=$('#sale_price_source').val();
			
			/*Ӧ�ս��-���ֶһ���Ǯ��*/
			ppFee=parseFloat(ppFee-rstMarkQry).toFixed(2);
			$('#sale_price').val(ppFee);
		}
		else {
			$('#feeMark').val('0');
			$('#pointMoney').val('0');
			$('#sale_price').val($('#sale_price_source').val());
			rdShowMessageDialog(rtCode+":"+rtMsg);
			return false;
		}
	}
	
	function setFeeMark(flag) {
		$('#feeMark').val('0');	
		if(flag) {
			$('#feeMark').removeClass("InputGrey").removeAttr('readonly');	
			
		}else {
			$('#feeMark').addClass("InputGrey").attr('readonly','readonly');		
		}
	}
	
	function changePayType(){
		var payTypeVal = $("#payType").val();
		if(payTypeVal != "0" && payTypeVal != "BX" && payTypeVal != "BY"){
			$.each(bankInstalArr,function(i,n){
				if(payTypeVal == n[2]){
					var tmpNumArr = n[3].substr(0,n[3].length-1).split("|");
					var tmpIncomeArr = n[4].substr(0,n[4].length-1).split("|");
					$("#installmentTd").empty();
					$.each(tmpNumArr,function(j,m){
						var tmpStr = "";
						if(j == 0){
							tmpStr = "<input type='radio' name='installmentList' value='"+m+"' income='"+tmpIncomeArr[j]+"' checked='checked'/>"+m+"��";
						}else{
							tmpStr = "<input type='radio' name='installmentList' value='"+m+"' income='"+tmpIncomeArr[j]+"'/>"+m+"��";
						}
						$("#installmentTd").append(tmpStr);
						$("#instalTd").show();
						$("#installmentTd").show();
					});
				}
			});
		}else{
			/*����*/
			$("#instalTd").hide();
			$("#installmentTd").hide();
		}
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
				<td class="blue">����Ԥ��</td>
				<td>
					<input name="prepay_limit" type="text" class="InputGrey" id="prepay_limit"  readonly />
					<input name="mon_prepay_limit" type="hidden" class="InputGrey" id="mon_prepay_limit"  readonly />
					<input name="mon_base_fee" type="hidden" class="InputGrey" id="mon_base_fee"  readonly />
				</td>
				<td class="blue">�Ԥ��</td>
				<td width="39%">
					<input class="InputGrey" type="text" name="prepay_gift" id="prepay_gift" readonly />
				</td>
			</tr>
			<tr>
				<td class="blue">Ԥ����������</td>
				<td width="39%">
					<input class="InputGrey" type="text" id="consume_term" name="consume_term" readonly />
				</td>			
			<!--
				<td class="blue">�µ�������</td>
				<td>
					<input name="mon_base_fee" type="text" class="InputGrey" id="mon_base_fee"  readonly />
				</td>
			-->
			
				<td class="blue">������</td>
				<td width="39%">
					<input class="InputGrey" type="text" id="base_fee" name="base_fee" readonly />
				</td>
			</tr>
			<tr>
				<td class="blue">�û��ɷѺϼ�</td>
				<td width="39%">
					<input class="InputGrey" type="text" id="sale_price" name="sale_price" readonly />
					<input class="InputGrey" type="hidden" id="sale_price_source" name="sale_price_source" readonly />
				</td>
			
				<td class="blue">�������</td>
				<td>
					<input name="active_term" type="text" class="InputGrey" id="active_term"  readonly />
					<input type="hidden" name="sale_name" id="sale_name" >
					<input type="hidden" name="e505_sale_name" id="e505_sale_name">
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
					<div align="left">���ѻ���</div>
				</td>
				<td>
					<input type="text" id="feeMark" name="feeMark" value="0" class="InputGrey" />
						<!-- onkeyup="this.value=this.value.replace(/[^\d]/g,'');"  onafterpaste="this.value=this.value.replace(/[^\d]/g,'')"-->
					<!--���ֶ�Ӧ��Ǯ��-->
					<input type="hidden" name="pointMoney" id="pointMoney" value="0">
				</td>
				
			</tr>
			<tr>
				<td class="blue">
					<div align="left">�ɷѷ�ʽ</div>
				</td>
				<td>
					<select name="payType" id="payType" onchange="changePayType()">
						<option value="0" checked>�ֽ�ɷ�</option>
						<option value="BX">��������POS���ɷ�</option>
						<option value="BY">��������POS���ɷ�</option>
					</select>
				</td>
				<td class="blue" id="instalTd" style="display:none;">
					����
				</td>
				<td id="installmentTd" style="display:none;">
				</td>	
			</tr>
			<tr>
				<td class="blue">������ע</td>
				<td colspan="3">
					<input name="op_note" type="text" size="80" id="op_note" value="" maxlength="60"/>
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
			<input type="hidden" name="return_page" value="/npage/se505/se505_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=iPhoneNo%>">
			<input type="hidden" name="sale_kind" value="">
			<input type="hidden" name="main_phoneno" value="">
			<input type="hidden" name="printAccept" value="<%=loginAccept%>">
			<input type="hidden" name="opName" value="<%=opName%>">
			<input type="hidden" name="banlitype" value="<%=banlitype%>">
			
</div>
		  <%@ include file="/npage/include/footer.jsp" %>
	</form>
	<%@ include file="/npage/public/posCCB.jsp" %>
	<%@ include file="/npage/public/posICBC.jsp" %>
</body>
</html>
