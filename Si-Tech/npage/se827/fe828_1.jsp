<%
/*************************************
* ��  ��: ����ҵ���ѯ e827
* ��  ��: version v1.0
* ������: si-tech
* ������: liujian @ 2012-05-03
**************************************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	//TODO ��û�����޶��������ͱ���ĺ���
	String opCode     = "e828";
    String opName     = "����ҵ�����";
	
    String workNo     = (String)session.getAttribute("workNo");
    String regionCode = (String)session.getAttribute("regCode");
    String workName = (String)session.getAttribute("workName");
    
    
  String dateStr = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
  
  String dateStr444 = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());

		String[] mon = new String[]{""};
		String bMon="";
	
    Calendar cal = Calendar.getInstance(Locale.getDefault());
		cal.set(Integer.parseInt(dateStr.substring(0,4)),(Integer.parseInt(dateStr.substring(5,7)) - 1),Integer.parseInt(dateStr.substring(8,10)));
		for(int i=0;i<=0;i++){
        if(i!=0){
          mon[i] = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(cal.getTime());
          cal.add(Calendar.MONTH,-1);
        }else{
          mon[i] = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(cal.getTime());
        }
    }      
    cal.add(Calendar.MONTH,-5);  
    bMon = new java.text.SimpleDateFormat("yyyy-MM-", Locale.getDefault()).format(cal.getTime())+"01";
	System.out.println("bMon~~~~"+bMon);
	  bMon=bMon+" 00:00:00";
	  
	  
  String dateStr22 = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());

		String[] mon22 = new String[]{""};
		String bMon22="";
	
    Calendar cal22 = Calendar.getInstance(Locale.getDefault());
		cal22.set(Integer.parseInt(dateStr22.substring(0,4)),(Integer.parseInt(dateStr22.substring(4,6)) - 1),Integer.parseInt(dateStr22.substring(6,8)));
		for(int i=0;i<=0;i++){
        if(i!=0){
          mon22[i] = new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(cal22.getTime());
          cal22.add(Calendar.MONTH,-1);
        }else{
          mon22[i] = new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(cal22.getTime());
        }
    }      
    cal22.add(Calendar.MONTH,-5);  
    bMon22 = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal22.getTime())+"01";
	System.out.println("bMon22~~~~"+bMon22);
	
	
	  

   		String bMon33="";
   	
      Calendar cal33 = Calendar.getInstance(Locale.getDefault());
   		cal33.set(Integer.parseInt(dateStr.substring(0,4)),(Integer.parseInt(dateStr.substring(5,7)) - 1),Integer.parseInt(dateStr.substring(8,10)));
     
       cal33.add(Calendar.DATE,-4);  
       System.out.println("cal33~~~~"+cal33.getTime());

       bMon33 = new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(cal33.getTime());
   	
   	   bMon33=bMon33+" 00:00:00";
   	   System.out.println("bMon33~~~~"+bMon33);
   	   
   	    	   
   	   		String bMon44="";
	   	
	      Calendar cal44 = Calendar.getInstance(Locale.getDefault());
	   		cal44.set(Integer.parseInt(dateStr.substring(0,4)),(Integer.parseInt(dateStr.substring(5,7)) - 1),Integer.parseInt(dateStr.substring(8,10)));
	     
	       cal44.add(Calendar.MONTH,-1);
	       cal44.add(Calendar.DATE,1);
	       System.out.println("cal44~~~~"+cal44.getTime());

	       bMon44 = new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(cal44.getTime());
	   	
	   	   bMon44=bMon44+" 00:00:00";
	   	   System.out.println("bMon44~~~~"+bMon44);


	  

		String dateStr1111 = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		
		 String dateStr8888 = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
		 String dateStr8888str =dateStr8888+"01000000";
		 
		 
		//����д���ֻ��ţ�����ʱȥ��
    //activePhone = "15046557789";
    
    String bp_name = "";
    String loginNoPass = (String)session.getAttribute("password");
    String ipAddrss = (String)session.getAttribute("ipAddr");
    String beizhussdese="����phoneNo=["+activePhone+"]���в�ѯ";
    String orgCode = (String) session.getAttribute("orgCode");
    String strRegionCode = orgCode.substring(0, 2);
%>

        
<wtc:service name="sUserCustInfo" outnum="100"  routerKey="region" routerValue="<%=strRegionCode%>">
			<wtc:param value="0" />
			<wtc:param value="01" />	
			<wtc:param value="2266" />	
			<wtc:param value="<%=workNo%>" />
			<wtc:param value="<%=loginNoPass%>" />
			<wtc:param value="<%=activePhone%>" />
			<wtc:param value="" />
			<wtc:param value="<%=ipAddrss%>" />
			<wtc:param value="<%=beizhussdese%>" />
</wtc:service>
<wtc:array id="baseArr" scope="end"/>
<%

    if(baseArr!=null&&baseArr.length>0){
    
    	if(baseArr[0][0].equals("00")) {
          bp_name = (baseArr[0][5]).trim();
      }
    }
%>


<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title><%=opName%></title>
    <script type="text/javascript" src="/npage/public/pubLightBox.js"></script>	
</head>
<script src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js" type="text/javascript"></script>
<script type=text/javascript>
  var e828_froms = ""; 
  $(function() {
    $('#shieldBusiTarget').val('0');
    $('input[name="shieldBusi"]').click(function(e){
        e.stopPropagation();
        
        var t = '';
        $('input[name="shieldBusi"]:checked').each(function(i, e){
            if (t == ''){
                t += $(this).val();
            }else {
                t += ',' + $(this).val();
            }
        });
        $('#shieldBusiTarget').val(t);
    });
    
    
    $('#shieldBusiTarget1').val('0');
    $('input[name="shieldBusi1"]').click(function(e){
        e.stopPropagation();
        
        var t = '';
        $('input[name="shieldBusi1"]:checked').each(function(i, e){
            if (t == ''){
                t += $(this).val();
            }else {
                t += ',' + $(this).val();
            }
        });
        $('#shieldBusiTarget1').val(t);
    });
    
    
    
  	 $('#busiType').change(function() {
  	 	var type = $('#busiType').val();
  	 	var opr_type = new Array();
  	 	if(type == '42') {
  	 		opr_type.push('<option value="001">�������û���ӻ�ȡ��</option>');
  	 	}else if(type == '57') {
  	 		opr_type.push('<option value="001">����������</option>');
  	 		opr_type.push('<option value="002">������ɾ��</option>');
  	 		opr_type.push('<option value="003">Ӫ����Ϣ����</option>');
  	 		opr_type.push('<option value="004">Ӫ����Ϣ����ȡ��</option>');
  	 		/*2014/08/06 9:39:24 gaopeng �����·�һ���ͷ�ʡ��ҵ��֧��ϵͳ2014��07��������ϸ���Ҫ���֪ͨ
  	 			���� ���������� ������ɾ��
  	 		*/
  	 		opr_type.push('<option value="005">����������</option>');
  	 		opr_type.push('<option value="006">������ɾ��</option>');
  	 	}else if(type == '82') {
  	 		opr_type.push('<option value="001">Ӫ���̲��ż��������</option>');
  	 		opr_type.push('<option value="002">����������/ɾ��</option>');
  	 		opr_type.push('<option value="003">����������/ɾ��</option>');
  	 	}else if(type == '72') {
  	 		opr_type.push('<option value="001">��/�������λ�ȡ������</option>');
  	 		opr_type.push('<option value="002">�����������������</option>');
  	 	}else if(type == '64') {
  	 	
  	 	}	else if(type == '95') {
    	 	opr_type.push('<option value="001">����������</option>');
    	 	opr_type.push('<option value="002">������ȡ��</option>');
    	 	/*2014/08/06 8:33:56 gaopeng �����·�һ���ͷ�ʡ��ҵ��֧��ϵͳ2014��07��������ϸ���Ҫ���֪ͨ
    	 		e828 �ֻ��������� ҵ�񲹷� �쳣��Ϊ�û����� �û�����״̬�ָ�
    	 	*/
    	 	opr_type.push('<option value="003">ҵ�񲹷�</option>');
    	 	opr_type.push('<option value="004">����������/ɾ��</option>');
    	 	opr_type.push('<option value="005">������־����״̬����</option>');
    	 	
    	 	opr_type.push('<option value="006">ͬ���˶�</option>');
    	 	opr_type.push('<option value="007">�˲�</option>');
    	 	
    	 	
    	 	//opr_type.push('<option value="008">��������������</option>');
    	 	//opr_type.push('<option value="009">����������ɾ��</option>');
		
  	 	}else if(type == '41') {
  	 		/*MobileMarket 2014/08/05 14:34:32 gaopeng �����·�һ���ͷ�ʡ��ҵ��֧��ϵͳ2014��07��������ϸ���Ҫ���֪ͨ*/
  	 		opr_type.push('<option value="001">MM��������������</option>');
  	 		opr_type.push('<option value="002">�û������޶�����</option>');
  	 		opr_type.push('<option value="003">�û�ͼ����֤������</option>');
  	 		
  	 	}	else if(type == '70') {
  	 		opr_type.push('<option value="001">���������</option>');
  	 		opr_type.push('<option value="002">���������</option>');
  	 	}	else if(type == '62') {
  	 		opr_type.push('<option value="001">Ӫ�����ʼ�����</option>');
  	 	}	else if(type == '54') {
  	 		opr_type.push('<option value="001">�͵�ͼ��Ӷ���������</option>');
  	 		opr_type.push('<option value="002">�͵�ͼɾ������������</option>');
  	 	}	else if(type == '130') {
  	 		opr_type.push('<option value="001">ҵ�����������</option>');
  	 		opr_type.push('<option value="002">ҵ�������ɾ��</option>');
  	 	}	else if(type == '121') {
  	 		opr_type.push('<option value="001">���������</option>');
  	 		opr_type.push('<option value="002">������ɾ��</option>');
  	 		opr_type.push('<option value="003">���������</option>');
  	 		opr_type.push('<option value="004">������ɾ��</option>');
			
  	 	}else if(type == '47') {
  	 		opr_type.push('<option value="001">���������</option>');
  	 		opr_type.push('<option value="002">������ɾ��</option>');
  	 	}	
  	 	
  	 	
  	 	$('#oprType').empty().append(opr_type.join(''));
  	 	//$('#oprType[@value="001"]').change();
  	 	/*2014/08/06 9:51:27 gaopeng  �޸�Ϊ�����б�ĵ�һ�иı� �����Ͳ���Լ�������뿪ʼ��001��*/
  	 	$("#oprType").eq(0).change();
  	 });
  	
  	 $("#busiType[@value='42']").change();
  	 
  	 
	 $('#oprType').change(function() {
	 	var busiType = $('#busiType').val();
		var oprType = $('#oprType').val();
		$('.tbody_form').css('display','none');	
	 	$('#d_' + busiType + '_' + oprType).css('display','block');	
	 });
	 
  	 $('#submitBtn').click(function() {
    		//1. ���ѡ���ҵ�����
    		var busiType = $('#busiType').val();
    		//2. ��ò�������
    		var oprType = $('#oprType').val();
    		//3. ��ȡform��
    		
    		if(!checkObj($('#d_' + busiType + '_' + oprType))){
    			return false;
    		}
    		
    		if(busiType == '95' && oprType == '001'){
    		    if ($('input[name="shieldBusi"]:checked').length <= 0){
    		        rdShowMessageDialog("������ѡ��һ�����ҵ��");
    		        return;
    		    }
    		}
    		
    		
    		var provCode ='451';
    		var phoneNo = $('#d_' + busiType + '_' + oprType + '_phone').val();
    		if(!phoneNo) {
    			phoneNo = '';	
    		}
    		var resultStr = getValue('d_' + busiType + '_' + oprType);
    		
    		var jsonstr='[';
    		
    		   $('#d_'+busiType+'_'+oprType+' tr').each(
    		    function(){
    		    	 if($(this).find("td:eq(0)").html()!=null && $(this).find("td:eq(0)").html()!="") {
							jsonstr=jsonstr+'{"key":"'+$(this).find("td:eq(0)").html()+'"';
							
							}
							if($(this).find("td:eq(1)").html()!=null && $(this).find("td:eq(1)").html()!="") {
								
								if($(this).find("td:eq(1) select").val()!=undefined) {
									jsonstr=jsonstr+',"value":"'+$(this).find("td:eq(1) select option:selected").text()+'"},';
								}
								if($(this).find("td:eq(1) input").val()!=undefined) {
									jsonstr=jsonstr+',"value":"'+$(this).find("td:eq(1) input").val()+'"},';
								}						
							
							}						
							
							 if($(this).find("td:eq(2)").html()!=null && $(this).find("td:eq(2)").html()!="") {
							 	jsonstr=jsonstr+'{"key":"'+$(this).find("td:eq(2)").html()+'"';
							}
							
								if($(this).find("td:eq(3)").html()!=null && $(this).find("td:eq(3)").html()!="") {
								
								if($(this).find("td:eq(3) select").val()!=undefined) {
									jsonstr=jsonstr+',"value":"'+$(this).find("td:eq(3) select option:selected").text()+'"},';
								}
								 
								if($(this).find("td:eq(3) input").val()!=undefined) {
									//alert($(this).find("td:eq(3) input").val());
									if($(this).find("td:eq(3) input").hasClass('ignore')) {
  								                       	
					         var tsss = '';
					        $(':checked').each(function () {
					            if (tsss == ''){
					                tsss += $(this).next().html();
					            }else {
					                tsss += ',' + $(this).next().html();
					            }
					        });
					            jsonstr=jsonstr+',"value":"'+tsss+'"},';
                             
									}else {
									jsonstr=jsonstr+',"value":"'+$(this).find("td:eq(3) input").val()+'"},';
									}
								}						
							
							}
							
						
            }
           );
           jsonstr=jsonstr.substring(0,(jsonstr.length-1));
           jsonstr=jsonstr+']';
           //alert(jsonstr);
           
           $('#jsontext').val(jsonstr);
           
    		
    		showLightBox();
    		var packet = new AJAXPacket("fe828_2.jsp","���ڻ�������Ϣ�����Ժ�......");
    		var _data = packet.data;
    		_data.add("busiType",busiType);
    		_data.add("oprType",oprType);
    		_data.add("phoneNo",phoneNo);
    		_data.add("opCode",'<%=opCode%>');
    		_data.add("provCode",provCode);
    		_data.add("infoStr",resultStr);
    		_data.add("jsonstr",jsonstr);
    		core.ajax.sendPacket(packet);
    		packet = null;
  	 });
  	 
  	 
  	 /* liujian ���� 2012-5-4 13:32:02 */
  	 $('#clearBtn').click(function() {
  	 
  	 window.location.href = "fe828_1.jsp?activePhone=<%=activePhone%>&opCode=<%=opCode%>&opName=<%=opName%>";
  	 
  	 	$('input[type="text"]').val('');
		$("select").each(function(){
			$(this).get(0).options[0].selected = true;  
		}); 
		$("#busiType[value=42]").change();
  	 });
  });
 
  function doProcess(package) {
  		var retCode = package.data.findValueByName("retcode");
		var retMsg = package.data.findValueByName("retmsg");
		if(retCode == "000000") {
				rdShowMessageDialog("�ύ�ɹ���");
		}else {
				rdShowMessageDialog("������룺" + retCode + "��������Ϣ��" + retMsg,0);
		}
		hideLightBox();
  }
  		
  //���this.id��id��tbody�ڵ�form����ֻ��input��select
   function getValue(id) {
    	var arr = new Array();
    	$('#' + id).find('td').each(function(i){
    		var $this = $(this);
    		$this.find('input').not('.ignore').each(function(){
    			arr.push($(this).val());
    		});
    		$this.find('select').each(function(){
    			arr.push($(this).val());
    		});
    	}); 
    	return arr.join('|');
  }
  function check() {
	
  }
  	
  function showBox() {
	showLightBox();
  }
	
  function hideBox() {
	hideLightBox();	
  }
</script>

<body>
<form name="frm" action="fe828_2.jsp" method="post" >
<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
		<input type="hidden" value=""  id="opCode" name="opCode" />
		<input type="hidden" value=""  id="opName" name="opName" />
		<input type="hidden" value=""  id="jsontext" name="jsontext" />
		<div>
				<table cellspacing=0>
				    <tr>
				        <td class='blue' width="15%">ҵ�����</td>
				        <td width="35%">
				        	<select id="busiType">
				        		
				        		<option value="42">�乾�Ķ�</option>
				        		<option value="57">�乾��Ϸ</option>
				        <!--	<option value="64">�ֻ�֧��</option> -->
					        	<option value="72">�乾����</option>
					        	<option value="95">�乾����</option>
								<option value="82">�乾��Ƶ</option>
								<option value="41">MobileMarket</option>
								
								<option value="70">ͨ���˻�֧��</option>
								<option value="62">139����</option>
								<option value="54">�ֻ�����</option>
								<option value="130">12582����</option>
								<option value="121">12590������־ҵ��</option>
								<option value="47">׿��MDO</option>
								
							</select>
				        </td>
				        <td class='blue' width="15%">��������</td>
				        <td width="35%">
				        	<select id="oprType">
							</select>
				        </td>
				    </tr>    
				    <!-- �ֻ��Ķ�42--���������������-->
				    <tbody id="d_42_001" class="tbody_form" >
				   		<tr>
					        <td class='blue'>�û��ֻ�����</td>
					        <td>
								<input type="text" value="<%=activePhone%>" name="d_42_001_phone" id="d_42_001_phone" readonly class="InputGrey"  v_must ='1' maxlength="11" 
									onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')"
									onblur = "checkElement(this)"/>
								<font class="orange">*</font>
					        </td>
					        <td class='blue'>����</td>
					        <td>
								<select>
									<option value="0">����</option>
									<option value="1">����</option>
									<option value="2">Wap Push</option>
									<option value="3">ͼ����֤��</option>
									<option value="4">�����������û�</option>
								</select>
					        </td>
					    </tr>
					    <tr>
					    	<td class='blue'>��������</td>
					        <td>
								<select>
									<option value="0">ȡ��</option>
									<option value="1">���</option>
								</select>
					        </td>
					        <td class='blue'>����������</td>
					        <td>
								    <input type="text" value="<%=workName%>" maxlength="30" onblur="checkElement(this)"/>
					        </td>
					    </tr>
					    <tr>
					    	<td class='blue'>������ID</td>
					        <td>
								<input type="text" value="<%=workNo%>" maxlength="10" onblur = "checkElement(this)"/>
					        </td>
					        <td class='blue'>ʡ��ID</td>
					        <td>
								<input type="hidden" value="451" maxlength="20" class="InputGrey" readonly /><span>������</span>
					        </td>
					    </tr>
					</tbody>
					
					<!-- �ֻ���Ϸ57--����������-->
					<tbody id="d_57_001" class="tbody_form" style="display:none">
				   		<tr>
					        <td class='blue'>�û��ֻ�����</td>
					        <td>
								<input type="text" value="<%=activePhone%>" name="d_57_001_phone" id="d_57_001_phone"  readonly class="InputGrey"  v_must ='1' maxlength="11" 
									onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')"
									onblur = "checkElement(this)"/>
									<font class="orange">*</font>
					        </td>
					        <td class='blue'>��������</td>
					        <td>
					        	<select>
					        		<option value="1">��ֹ����ҵ��Ʒ�</option>
								</select>
							</td>
					    </tr>
					    <tr>
					        <td class='blue'>��������Դ</td>
					        <td>
								<select>
											<option value="2">�ͷ�</option>
					        		<option value="1">BOC</option>					        		
					        		<option value="3">CPID</option>
								</select>
					        </td>
					        <td class='blue'>��������ӷ�ʽ</td>
					        <td>
										<select>
													<option value="1">�û�����Ҫ�����</option>
							        		<option value="2">���û�����Ҫ�����</option>					        		
										</select>
					        </td>
					        
					    </tr>
					</tbody> 
					
					<!-- �ֻ���Ϸ--������ɾ��-->
					<tbody id="d_57_002" class="tbody_form" style="display:none">
				   		<tr>
					        <td class='blue'>�û��ֻ�����</td>
					        <td>
								<input type="text" name="d_57_002_phone" id="d_57_002_phone" value="<%=activePhone%>"  readonly class="InputGrey" v_must ='1' 
								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
								onafterpaste="this.value=this.value.replace(/\D/g,'')"
								onblur = "checkElement(this)"/>
								<font class="orange">*</font>
								
					        </td>
					        <td class='blue'></td>
					        <td>
					        </td>
					    </tr>
					</tbody> 	
					
					<!-- �ֻ���Ϸ--Ӫ����Ϣ����-->
					<tbody id="d_57_003" class="tbody_form" style="display:none">
			   		<tr>
			        <td class='blue'>�û��ֻ�����</td>
			        <td>
								<input type="text" name="d_57_003_phone" id="d_57_003_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1' 
								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
								onafterpaste="this.value=this.value.replace(/\D/g,'')"
								onblur = "checkElement(this)"/>
								<font class="orange">*</font>
			        </td>
			        
			        <td class='blue'>������Դ</td>
			        <td>
			          <select name="d_57_003_resource">
			            <option value="2">�û�Ͷ��</option>
			            <option value="0">δ֪</option>
			            <option value="1">��������</option>
			            <option value="3">���з���</option>
			          </select>
			        </td>
				    </tr>
				    
				    <tr>
				      <td class="blue">���η�Χ</td>
				      <td colspan="3">
				        <select name="d_57_003_range">
			            <option value="0">���ζ���/push</option>
			            <option value="1">���β���</option>
			            <option value="2">���ζ��źͲ���</option>
			          </select>
			        </td>
				    </tr>
					</tbody> 	
					
					<!-- �ֻ���Ϸ--Ӫ����Ϣ����ȡ��-->
					<tbody id="d_57_004" class="tbody_form" style="display:none">
			   		<tr>
			        <td class='blue'>�û��ֻ�����</td>
			        <td>
								<input type="text" name="d_57_004_phone" id="d_57_004_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1' 
								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
								onafterpaste="this.value=this.value.replace(/\D/g,'')"
								onblur = "checkElement(this)"/>
								<font class="orange">*</font>
			        </td>
			        
			        <td class='blue'>���η�Χ</td>
			        <td>
			          <select name="d_57_004_range">
			            <option value="0">���ζ���/push</option>
			            <option value="1">���β���</option>
			            <option value="2">���ζ��źͲ���</option>
			          </select>
			        </td>
				    </tr>
					</tbody>
					
					<!-- 2014/08/06 9:40:22 gaopeng �ֻ���Ϸ--����������-->
					<tbody id="d_57_005" class="tbody_form" style="display:none">
			   		<tr>
			        <td class='blue'>�û��ֻ�����</td>
			        <td>
								<input type="text" name="d_57_005_phone" id="d_57_005_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1' 
								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
								onafterpaste="this.value=this.value.replace(/\D/g,'')"
								onblur = "checkElement(this)"/>
								<font class="orange">*</font>
			        </td>
			        
			        <td class='blue'>��������Դ</td>
			        <td>
			          <select name="d_57_005_range">
			          	<option value="2">�ͷ�</option>
			            <option value="1">BOC</option>			            
			            <option value="3">CPID(ָ�ض��������ύ�ĺ������û�)</option>
			          </select>
			        </td>
				    </tr>
					</tbody>
					
					<!-- 2014/08/06 9:40:22 gaopeng �ֻ���Ϸ--����������-->
					<tbody id="d_57_006" class="tbody_form" style="display:none">
			   		<tr>
			        <td class='blue'>�û��ֻ�����</td>
			        <td colspan="3">
								<input type="text" name="d_57_006_phone" id="d_57_006_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1' 
								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
								onafterpaste="this.value=this.value.replace(/\D/g,'')"
								onblur = "checkElement(this)"/>
								<font class="orange">*</font>
			        </td>
				    </tr>
					</tbody>
					
					<!-- ��������72--������������־��ѯ-->
					<tbody id="d_72_001" class="tbody_form" style="display:none">
						<tr>
					        <td class='blue'>�û��ֻ�����</td>
					        <td>
								<input type="text" name="d_72_001_phone" id="d_72_001_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1' 
								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
								onafterpaste="this.value=this.value.replace(/\D/g,'')"
								onblur = "checkElement(this)"/>
								<font class="orange">*</font>
					        </td>
					        <td class='blue'>��������</td>
					        <td>
					        	<select>
					        		<option value="2">���������</option>
					        		<option value="3">������ɾ��</option>
					        	</select>
					        </td>
					    </tr>
					    <tr>
					        <td class='blue'>����������</td>
					        <td colspan="3">
					        	<select>
					        		<option value="0">ȫ�ֺ�����</option>
					        		<option value="1">Ӫ��������</option>
					        	</select>
					        </td>
					    </tr>
					</tbody>
					
					<!-- ��������72--�����������������-->
					<tbody id="d_72_002" class="tbody_form" style="display:none">
						<tr>
			        <td class='blue'>�û��ֻ�����</td>
			        <td>
  							<input type="text" name="d_72_002_phone" id="d_72_002_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1' 
    							maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
    							onafterpaste="this.value=this.value.replace(/\D/g,'')"
    							onblur = "checkElement(this)"/>
  							<font class="orange">*</font>
			        </td>
			        <td class='blue'>ʡ��</td>
			        <td>
			          <input type="hidden" value="451" class="InputGrey" readonly /><span>������</span>
			        </td>
				    </tr>
					    
				    <tr>
			        <td class='blue'>������Ա</td>
			        <td colspan="3">
  							<input type="text" maxlength="40"  onblur = "checkElement(this)" maxlength="32"  value="<%=workNo%>"
  							  v_must ='1'  onblur = "checkElement(this)"/><font class="orange">*</font>
				      </td>
				    </tr>
					</tbody>
					
					<!-- �ֻ���Ƶ82--���������������-->
					<tbody id="d_82_001" class="tbody_form" style="display:none">
				   		<tr>
					        <td class='blue'>�û��ֻ�����</td>
					        <td>
								<input type="text" value="<%=activePhone%>" name="d_82_001_phone" id="d_82_001_phone"  readonly class="InputGrey"  v_must ='1' maxlength="11" 
								onkeyup="this.value=this.value.replace(/\D/g,'')" 
								onafterpaste="this.value=this.value.replace(/\D/g,'')"
								onblur = "checkElement(this)"/>
								<font class="orange">*</font>
					        </td>
					        <td class='blue'>������ҵ��</td>
					        <td>
								<select>
									<option value="1">����ҵ��</option>
									<option value="2">����ҵ��</option>
									<option value="3">WAPҵ��</option>
								</select>
					        </td>
					    </tr>
					    <tr>
					    	<td class='blue'>��������</td>
					        <td>
								<select>
									<option value="0">����</option>
									<option value="1">����</option>
								</select>
					        </td>
					        <td class='blue'>����������</td>
					        <td>
								<input type="text" value="<%=workName%>" maxlength="30" v_must ='1' 
									onblur = "checkElement(this)"/>
								<font class="orange">*</font>
					        </td>
					    </tr>
					    <tr>
					    	<td class='blue'>������ID</td>
					        <td>
								<input type="text" value="<%=workNo%>" maxlength="10" v_must ='1' 
									onblur = "checkElement(this)"/>
								<font class="orange">*</font>
					        </td>
					        <td class='blue'>ʡ��ID</td>
					        <td>
								<input type="hidden" value="451" maxlength="15" class="InputGrey" readonly/><span>������</span>
					        </td>
					    </tr>
					</tbody>
					
					<!-- �ֻ���Ƶ82--ͼ����֤���û����-->
					<tbody id="d_82_002" class="tbody_form" style="display:none">
			   		<tr>
			        <td class='blue'>�û��ֻ�����</td>
			        <td>
								<input type="text" value="<%=activePhone%>"  name="d_82_002_phone" id="d_82_002_phone"  readonly class="InputGrey"  v_must ='1' maxlength="11" 
								onkeyup="this.value=this.value.replace(/\D/g,'')" 
								onafterpaste="this.value=this.value.replace(/\D/g,'')"
								onblur = "checkElement(this)"/>
								<font class="orange">*</font>
			        </td>
			        
			        <td class='blue'>ͼ����֤�������Ч��</td>
			        <td>
								<select>
									<option value="1">һ����</option>
									<option value="3">������</option>
									<option value="12">ʮ������</option>
									<option value="120">����</option>
								</select>
				        </td>
				    </tr>
				    
				    <tr>
			        <td class='blue'>����������</td>
				      <td>
							  <input type="text" value="<%=workName%>" maxlength="30" v_must ='1' 
								onblur = "checkElement(this)"/>
							  <font class="orange">*</font>
				      </td>
				      
				      <td class='blue'>������ID</td>
					    <td>
								<input type="text" value="<%=workNo%>" maxlength="10" v_must ='1' 
									onblur = "checkElement(this)"/>
								<font class="orange">*</font>
					    </td>
				    </tr>
				    
				    <tr>
			        <td class='blue'>ʡ��ID</td>
			        <td>
							  <input type="hidden" value="451" maxlength="15" class="InputGrey" readonly/><span>������</span>
				      </td>
				      	<!--2014/08/06 9:31:51 gaopeng �����·�һ���ͷ�ʡ��ҵ��֧��ϵͳ2014��07��������ϸ���Ҫ���֪ͨ
					 �ֻ���Ƶ82--�����������-->
				      <td class='blue'>��������</td>
					    <td>
								<select name="">
									<option value="1">���</option>
									<option value="2">ȡ��</option>
								</select>
					    </td>
				    </tr>
					</tbody>
					
					<!--2014/08/06 9:31:51 gaopeng �����·�һ���ͷ�ʡ��ҵ��֧��ϵͳ2014��07��������ϸ���Ҫ���֪ͨ
					 �ֻ���Ƶ82--ҵ���������Ӻ�ȡ��-->
					<tbody id="d_82_003" class="tbody_form" style="display:none">
			   		<tr>
			        <td class='blue'>�û��ֻ�����</td>
			        <td>
								<input type="text" value="<%=activePhone%>"  name="d_82_003_phone" id="d_82_003_phone"  readonly class="InputGrey"  v_must ='1' maxlength="11" 
								onkeyup="this.value=this.value.replace(/\D/g,'')" 
								onafterpaste="this.value=this.value.replace(/\D/g,'')"
								onblur = "checkElement(this)"/>
								<font class="orange">*</font>
			        </td>
			        
			        <td class='blue'>��������Ч��</td>
			        <td>
								<select>
									<option value="1">һ����</option>
									<option value="3">������</option>
									<option value="12">ʮ������</option>
									<option value="120">����</option>
								</select>
				        </td>
				    </tr>
				    
				    <tr>
			        <td class='blue'>����������</td>
				      <td>
							  <input type="text" value="<%=workName%>" maxlength="30" v_must ='1' 
								onblur = "checkElement(this)"/>
							  <font class="orange">*</font>
				      </td>
				      
				      <td class='blue'>������ID</td>
					    <td>
								<input type="text" value="<%=workNo%>" maxlength="10" v_must ='1' 
									onblur = "checkElement(this)"/>
								<font class="orange">*</font>
					    </td>
				    </tr>
				    
				    <tr>
			        <td class='blue'>ʡ��ID</td>
			        <td>
							  <input type="hidden" value="451" maxlength="15" class="InputGrey" readonly/><span>������</span>
				      </td>
				      <td class='blue'>��������</td>
					    <td>
								<select name="">
									<option value="1">���</option>
									<option value="2">ȡ��</option>
								</select>
					    </td>
				    </tr>
					</tbody>
					
					<!-- �ֻ�����95--����������-->
					<tbody id="d_95_001" class="tbody_form" style="display:none">
			   		<tr>
			        <td class='blue'>�û��ֻ�����</td>
			        <td>
								<input type="text" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1' maxlength="11"  name="d_95_001_phone" id="d_95_001_phone"
  								onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
								<font class="orange">*</font>
			        </td>
			        
			        <td class='blue'>��������</td>
			        <td>
								<input type="radio" class="ignore" name="shieldBusi" value="1"><span>����</span>
								<input type="radio" class="ignore" name="shieldBusi" value="2"><span>����</span>
								<input type="radio" class="ignore" name="shieldBusi" value="3"><span>���Ų���</span>
								<input type="radio" class="ignore" name="shieldBusi" value="4"><span>Wap Push</span>
								<input type="radio" class="ignore" name="shieldBusi" value="5"><span>��������</span>
								<input type="radio" class="ignore" name="shieldBusi" value="7"><span>������־�����ţ�</span>
								
								<input type="radio" class="ignore" name="shieldBusi" value="8"><span>������־�����ţ�</span>
								<input type="radio" class="ignore" name="shieldBusi" value="9"><span>���˲���</span>
								<input type="radio" class="ignore" name="shieldBusi" value="21"><span>���Ƶ㲥</span>
								<input type="radio" class="ignore" name="shieldBusi" value="22"><span>���ư���</span>
								<input type="radio" class="ignore" name="shieldBusi" value="23"><span>������������</span>
								<input type="radio" class="ignore" name="shieldBusi" value="24"><span>���ƻ����ۼ�</span>
								<input type="radio" class="ignore" name="shieldBusi" value="25"><span>���ƹ�������</span>
								<input type="radio" class="ignore" name="shieldBusi" value="26"><span>���Ƹ��˲���</span>

								<input type="hidden" id="shieldBusiTarget" value="">
				      </td>
				    </tr>
				    
				    
					</tbody>
					
					<!-- �ֻ�����95--������ȡ��-->
					<tbody id="d_95_002" class="tbody_form" style="display:none">
			   		<tr>
			        <td class='blue'>�û��ֻ�����</td>
			        <td>
								<input type="text" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1' maxlength="11"  name="d_95_002_phone" id="d_95_002_phone"
  								onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
								<font class="orange">*</font>
			        </td>
			        
			        <td class='blue'>��������</td>
			        <td>
								<input type="radio" class="ignore" name="shieldBusi1" value="1"><span>����</span>
								<input type="radio" class="ignore" name="shieldBusi1" value="2"><span>����</span>
								<input type="radio" class="ignore" name="shieldBusi1" value="3"><span>���Ų���</span>
								<input type="radio" class="ignore" name="shieldBusi1" value="4"><span>Wap Push</span>
								<input type="radio" class="ignore" name="shieldBusi1" value="7"><span>������־�����ţ�</span>
								<input type="radio" class="ignore" name="shieldBusi1" value="8"><span>������־�����ţ�</span>
								<input type="radio" class="ignore" name="shieldBusi1" value="9"><span>���˲���</span>
								<input type="radio" class="ignore" name="shieldBusi1" value="21"><span>���Ƶ㲥</span>
								<input type="radio" class="ignore" name="shieldBusi1" value="22"><span>���ư���</span>
								<input type="radio" class="ignore" name="shieldBusi1" value="23"><span>������������</span>
								<input type="radio" class="ignore" name="shieldBusi1" value="24"><span>���ƻ����ۼ�</span>
								<input type="radio" class="ignore" name="shieldBusi1" value="25"><span>���ƹ�������</span>
								<input type="radio" class="ignore" name="shieldBusi1" value="26"><span>���Ƹ��˲���</span>

								<input type="hidden" id="shieldBusiTarget1" value="">
				      </td>
				    </tr>
					</tbody>
					
					<!--2014/08/05 8:59:23 gaopeng �����·�һ���ͷ�ʡ��ҵ��֧��ϵͳ2014��07��������ϸ���Ҫ���֪ͨ���������Žӿڣ�
					 �ֻ����� ҵ�񲹷� 95 006 
					 -->
					<tbody id="d_95_003" class="tbody_form" style="display:none">
					  <tr>
			        <td class='blue'>�û��ֻ�����</td>
			        <td>
								<input type="text" name="d_95_003_phone" id="d_95_003_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must="1"
									maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')" 
									onblur = "checkElement(this)"/>
							  <font class="orange">*</font>
					    </td>
					    <td class='blue'>ҵ��ID</td>
					    <td>
					    	<select name="d_95_003_opId" id="d_95_003_opId">
					    		<option value="0" selected>ÿ��һЦ</option>	
					    		<option value="1">��������</option>	
					    		<option value="2">�պ�����</option>	
					    		<option value="3">ʱ�����������</option>	
					    		<option value="4">�������������</option>	
					    		<option value="5">�պ����������</option>	
					    		<option value="6">ÿ��һЦ�����</option>	
					    		<option value="7">������Ե�����飩</option>	
					    		<option value="8">ѧ��������飩</option>	
					    		<option value="9">������ի�����飩</option>	
					    		<option value="10">����̳�����飩</option>	
					    		<option value="11">��̸���������飩</option>	
					    		<option value="12">Ӣ�����������飩</option>	
					    		<option value="13">������Ե</option>	
					    		<option value="14">ѧ������</option>	
					    		<option value="15">����̳</option>	
					    		<option value="16">������ѧ</option>	
					    		<option value="17">��̸����</option>	
					    		<option value="18">Ӣ������</option>	
					    		<option value="19">������ʷ�����飩</option>	
					    		<option value="20">������ʷ</option>	
					    		<option value="21">�ֻ�������־-������ѧ</option>	
					    		<option value="22">���ź�����壨���£�</option>	
					    	</select>	
					    </td>
			    	</tr>
			    	<tr>
			        <td class='blue'>����ʱ��</td>
			        <td colspan="3">
								<input name="d_95_003_opTime" type="text" id="d_95_003_opTime" v_must ='1' 
					        		onclick="WdatePicker({el:'d_95_003_opTime',startDate:'%y%M%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"
											v_type="date" value="<%=dateStr22%>"  maxlength="19" onblur = "checkElement(this)"/>
					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_95_003_opTime',startDate:'%y%M%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyymmdd)*</font>	
					    </td>
					  </tr>
					</tbody>
					
					<!--2014/08/05 8:59:23 gaopeng �����·�һ���ͷ�ʡ��ҵ��֧��ϵͳ2014��07��������ϸ���Ҫ���֪ͨ���������Žӿڣ�
					 �ֻ����� �쳣��Ϊ�û����� 95 007 
					 -->
					<tbody id="d_95_004" class="tbody_form" style="display:none">
					  <tr>
			        <td class='blue'>�û��ֻ�����</td>
			        <td>
								<input type="text" name="d_95_004_phone" id="d_95_004_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must="1"
									maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')" 
									onblur = "checkElement(this)"/>
							  <font class="orange">*</font>
					    </td>
					    <td class='blue'>������ʽ</td>
					    <td>
					    	<select name="d_95_004_opId" id="d_95_004_opId">
					    		<option value="0" selected>����</option>	
					    		<option value="1">ɾ��</option>	
					    		<option value="2">����</option>	
					    	</select>	
					    </td>
			    	</tr>
					</tbody>
					
					<!--2014/08/05 8:59:23 gaopeng �����·�һ���ͷ�ʡ��ҵ��֧��ϵͳ2014��07��������ϸ���Ҫ���֪ͨ���������Žӿڣ�
					 �ֻ����� �û�����״̬�ָ� 95 008
					 -->
					<tbody id="d_95_005" class="tbody_form" style="display:none">
					  <tr>
			        <td class='blue'>�û��ֻ�����</td>
			        <td colspan="3">
								<input type="text" name="d_95_005_phone" id="d_95_005_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must="1"
									maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')" 
									onblur = "checkElement(this)"/>
							  <font class="orange">*</font>
					    </td>
			    	</tr>
					</tbody>

					
					<!-- MobileMarket-- e828 MM�������������� 41_003-->
					<tbody id="d_41_001" class="tbody_form" style="display:none">
				   		<tr>
				        <td class='blue'>�û��ֻ�����</td>
				        <td >
  								<input type="text" name="d_41_001_phone" id="d_41_001_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1' 
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
				        </td>
				        <td class='blue'>������ʶ</td>
				        <td >
  								<select name = "d_41_001_optype" id="d_41_001_optype">
  									<option value="1">���������</option>
  									<option value="2">ȡ��������</option>
  								</select>
					        	<font class="orange">*</font>
				        </td>
					    </tr>
					     <tr>
									<td class='blue'>��ʼʱ��</td>
					        <td colspan="3">
					        	<input name="d_41_001_begTime" type="text" id="d_41_001_begTime" v_must ='0'  value="<%=dateStr8888str%>"
					        		onclick="WdatePicker({el:'d_41_001_begTime',startDate:'%y%M%d',dateFmt:'yyyyMMddHHmmss',alwaysUseStartDate:true})"
											v_type="dateTime" value=""  maxlength="19" onblur = "checkElement(this)"/>
					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_41_001_begTime',startDate:'%y%M%d',dateFmt:'yyyyMMddHHmmss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyymmddhh24miss)*</font>
					        </td>
					     </tr>
					</tbody>
					
					
					<!-- MobileMarket--002	�û������޶����� 41_002-->
					
					<tbody id=d_41_002 class="tbody_form" style="display:none">
					<tr>
						<td class='blue'>��Ϣ����</td>
			        <td >
								<input type="text" name="d_41_002_type" id="d_41_002_type" value="CCSetMSDNLimitReq" maxlength="50"
								 readOnly  />
					    </td>			
					    
					    <td class='blue'>�汾</td>
			        <td >
								<input type="text" name="d_41_002_version" id="d_41_002_version" value="1.0.0" maxlength="50"
								 readOnly  />
					    </td>	
					   </tr>
					    <tr>
						<td class='blue'>�û��ֻ�����</td>
			        <td colspan="3">
								<input type="text" name="d_41_002_phone" id="d_41_002_phone" value="<%=activePhone%>" maxlength="50"
								 readOnly  />
					    </td>			
					    
					   </tr>
					   
					   	<td class='blue'>���޶�</td>
			        <td >
								<input type="text" name="d_41_002_day" id="d_41_002_day" v_type="0_9"  onblur = "checkElement(this)"  value="" maxlength="20"   />
					    </td>			
					    
					    <td class='blue'>���޶�</td>
			        <td >
								<input type="text" name="d_41_002_month" id="d_41_002_month" v_type="0_9"  onblur = "checkElement(this)" value="" maxlength="20"  />
					    </td>	
					   </tr>
					 </tbody>  
					   
					<!-- MobileMarket-- 003	�û�ͼ����֤������ 41_003-->
					<tbody id=d_41_003 class="tbody_form" style="display:none">
					<tr>
						<td class='blue'>��Ϣ����</td>
			        <td >
								<input type="text" name="d_41_003_type" id="d_41_003_type" value="CCSetGraphicsVerificationReq" maxlength="50"
								 readOnly  />
					    </td>			
					    
					    <td class='blue'>�汾</td>
			        <td >
								<input type="text" name="d_41_003_version" id="d_41_003_version" value="1.0.0" maxlength="50"
								 readOnly  />
					    </td>	
					   </tr>
					    <tr>
						<td class='blue'>�û��ֻ�����</td>
			        <td >
								<input type="text" name="d_41_003_phone" id="d_41_003_phone" value="<%=activePhone%>" maxlength="50"
								 readOnly  />
					    </td>			
					    
					 
					    <td class='blue'>��ʾ��־</td>
			        <td >
								<select name="d_41_003_flag" id="d_41_003_flag">
									<option value="0">����ʾ</option>
									<option value="1">��ʾ</option>
								</select>
					    </td>	
					   </tr>
					 </tbody>
					
					
						<!-- 95 �乾����-- 	006	ͬ���˶�  -->
						<tbody id=d_95_006 class="tbody_form" style="display:none">
					<tr>
						<td class='blue'>�û��ֻ�����/�����ʺ�</td>
			        <td >
								<input type="text" name="d_95_006_phone" id="d_95_006_phone" value="<%=activePhone%>" maxlength="50"
								 readOnly  />
								 <font class="orange">*</font>
					    </td>			
					    
					    <td class='blue'>��ƷID</td>
			        <td >
								<input type="text" name="d_95_006_pid" id="d_95_006_pid" value="" maxlength="25"  v_must="1"  />
								<font class="orange">*</font>
					    </td>	
					   </tr>
					    <tr>
						<td class='blue'>����ʱ��</td>
			        <td colspan="3">
								<input name="d_95_006_endTime" type="text" id="d_95_006_endTime" value="<%=dateStr%>"
								onclick="WdatePicker({el:'d_95_006_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:false})"
								v_must ='1' maxlength="19"  onblur = "checkElement(this)"/>
  										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_95_006_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:false})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					    </td>			
					   </tr>
					 </tbody>
					
						
						<!-- 95 �乾����-- 	007	�˲�  -->
										<tbody id=d_95_007 class="tbody_form" style="display:none">
					<tr>
						<td class='blue'>�û��ֻ�����/�����ʺ�</td>
			        <td >
								<input type="text" name="d_95_007_phone" id="d_95_007_phone" value="<%=activePhone%>" maxlength="50"
								 readOnly  />
								 <font class="orange">*</font>
					    </td>			
					    
					    <td class='blue'>��ƷID</td>
			        <td >
								<input type="text" name="d_95_007_pid" id="d_95_007_pid" value="" maxlength="25"  v_must="1"  />
								<font class="orange">*</font>
					    </td>	
					   </tr>
					    <tr>
						<td class='blue'>����ʱ��</td>
			        <td colspan="3">
								<input name="d_95_007_endTime" type="text" id="d_95_007_endTime" value="<%=dateStr%>"
								onclick="WdatePicker({el:'d_95_007_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:false})"
								v_must ='1' maxlength="19"  onblur = "checkElement(this)"/>
  										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_95_007_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:false})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					    </td>			
					   </tr>
					 </tbody>
						<!-- 95 �乾����--  008	��������������  -->
						<tbody id=d_95_008 class="tbody_form" style="display:none">
							<tr>
						<td class='blue'>�û��ֻ�����</td>
			        <td >
								<input type="text" name="d_95_008_phone" id="d_95_008_phone" value="<%=activePhone%>" maxlength="50"
								 readOnly  />
								 <font class="orange">*</font>
					    </td>			
					    
					    <td class='blue'>&nbsp;</td>
			        <td >
			        	&nbsp;
					    </td>	
					   </tr>
					    <tr>
					<tr>
						<td class='blue'>���������嵥</td>
			        <td >
								<textarea type="text" name="d_95_008_list" id="d_95_008_list"   ></textarea>
									
									
								 <font class="orange">*</font>
					    </td>		
					    <td colspan="2">
					    	ÿһ��Ӧ�������û��ֻ����룬��������<br>
					    	��������:<br>
					    	���ν��գ�1���� 2���� 3���Ų��� 4Wap Push 5�������� 7������־�����ţ���8������־�����ţ���9���˲�����<br>
								�������ƣ�21���Ƶ㲥��22���ư��¡�23�����������ѡ�24���ƻ����ۼơ�25���ƹ������ҡ�26���Ƹ��˲�����<br>

					    </td>	
					   </tr>
					 </tbody>
						
						<!-- 95 �乾����-- 	009	����������ɾ��  -->
							<tbody id=d_95_009 class="tbody_form" style="display:none">
								<tr>
						<td class='blue'>�û��ֻ�����</td>
			        <td >
								<input type="text" name="d_95_009_phone" id="d_95_009_phone" value="<%=activePhone%>" maxlength="50"
								 readOnly  />
								 <font class="orange">*</font>
					    </td>			
					    
					    <td class='blue'>&nbsp;</td>
			        <td >
			        	&nbsp;
					    </td>	
					   </tr>
					    <tr>
					<tr>
						<td class='blue'>����ɾ���嵥</td>
			        <td >
								<textarea type="text" name="d_95_009_list" id="d_95_009_list"   ></textarea>
									
									
								 <font class="orange">*</font>
					    </td>		
					    <td colspan="2">
					    	ÿһ��Ӧ�������û��ֻ����룬��������<br>
					    	��������:<br>
					    	���ν��գ�1���� 2���� 3���Ų��� 4Wap Push 5�������� 7������־�����ţ���8������־�����ţ���9���˲�����<br>
								�������ƣ�21���Ƶ㲥��22���ư��¡�23�����������ѡ�24���ƻ����ۼơ�25���ƹ������ҡ�26���Ƹ��˲�����<br>

					    </td>	
					   </tr>
					 </tbody>
											
					
						<!-- 121 12590������־ҵ��-- 	002	������ɾ��  -->
						<tbody id=d_121_002 class="tbody_form" style="display:none">
					<tr>
						<td class='blue'>�û��ֻ�����</td>
			        <td >
								<input type="text" name="d_121_002_phone" id="d_121_002_phone" value="<%=activePhone%>" maxlength="50"
								 readOnly  />
								 <font class="orange">*</font>
					    </td>			
					    
					    <td class='blue'>ʡ��</td>
			        <td >
								<input type="text" name="d_121_002_s" id="d_121_002_s" value="451" readOnly v_must="1"  />
								<font class="orange">*</font>
					    </td>	
					   </tr>
					    <tr>
						<td class='blue'>����������</td>
			        <td >
								<select name="d_121_002_type"  id="d_121_002_type">
  								<option value="1">����ҵ�������</option>
  								<option value="2">�ͻ���ҵ�������</option>
  								<option value="3">����ҵ�������</option>
  							</select>
					    </td>			
					    <td class='blue'>������Ա</td>
			        <td>
  							<input type="text" maxlength="40"  onblur = "checkElement(this)" maxlength="32"  value="<%=workNo%>"
  							  v_must ='1'  onblur = "checkElement(this)"/><font class="orange">*</font>
				      </td>
					   </tr>
					 </tbody>					

<!-- 121 12590������־ҵ��-- 	003	���������  -->
<tbody id=d_121_003 class="tbody_form" style="display:none">
					<tr>
						<td class='blue'>�û��ֻ�����</td>
			        <td >
								<input type="text" name="d_121_003_phone" id="d_121_003_phone" value="<%=activePhone%>" maxlength="50"
								 readOnly  />
								 <font class="orange">*</font>
					    </td>			
					    
					    <td class='blue'>ʡ��</td>
			        <td >
								<input type="text" name="d_121_003_s" id="d_121_003_s" value="451" readOnly v_must="1"  />
								<font class="orange">*</font>
					    </td>	
					   </tr>
					    <tr>

					    <td class='blue'>��ʼʱ��</td>
			        <td>
			        	<input name="d_121_003_begTime" type="text" id="d_121_003_begTime" value="<%=bMon%>"
			        	onclick="WdatePicker({el:'d_121_003_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
			        	v_must ='1' maxlength="19"   onblur = "checkElement(this)"/>
			        	 			<img id = "imgCustStart"
											onclick="WdatePicker({el:'d_121_003_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
			        </td>
			        <td class='blue'>����ʱ��</td>
			        <td>
								<input name="d_121_003_endTime" type="text" id="d_121_003_endTime" value="<%=bMon%>"
								onclick="WdatePicker({el:'d_121_003_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:false})"
								v_must ='1' maxlength="19"  onblur = "checkElement(this)"/>
  										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_121_003_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:false})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					    </td>
					  </tr>
					    <tr>
					 
					    <td class='blue'>������Ա</td>
			        <td colspan="3">
  							<input type="text" maxlength="40"  onblur = "checkElement(this)" maxlength="32"  value="<%=workNo%>"
  							  v_must ='1'  onblur = "checkElement(this)"/><font class="orange">*</font>
				      </td>
					   </tr>
					 </tbody>	
<!-- 121 12590������־ҵ��-- 	004	������ɾ��  -->
<tbody id=d_121_004 class="tbody_form" style="display:none">
					<tr>
						<td class='blue'>�û��ֻ�����</td>
			        <td >
								<input type="text" name="d_121_004_phone" id="d_121_004_phone" value="<%=activePhone%>" maxlength="50"
								 readOnly  />
								 <font class="orange">*</font>
					    </td>			
					    
					    <td class='blue'>ʡ��</td>
			        <td >
								<input type="text" name="d_121_002_s" id="d_121_002_s" value="451" readOnly v_must="1"  />
								<font class="orange">*</font>
					    </td>	
					   </tr>
					    
					    <tr>
					 
					    <td class='blue'>������Ա</td>
			        <td colspan="3">
  							<input type="text" maxlength="40"  onblur = "checkElement(this)" maxlength="32"  value="<%=workNo%>"
  							  v_must ='1'  onblur = "checkElement(this)"/><font class="orange">*</font>
				      </td>
					   </tr>
					 </tbody>	

					<!-- ͨ���˻�֧�� ���������1 70_001 -->
					<tbody id=d_70_001 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>�û��ֻ�����</td>
					      <td>
								  <input type="text" name="d_70_001_phone" id="d_70_001_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					      </td>
					    <td class='blue'>���ԭ��</td>
			        <td>
  							<select name="d_70_001_addres"  id="d_70_001_addres">
  								<option value="7">�û�Ҫ������ͨ���˻�����</option>
  								<option value="8">�ƶ�Ҫ������ͨ���˻�����</option>
  							</select>
								<font class="orange">*</font>
					    </td>

					  </tr>
					</tbody>
	 					<!-- ͨ���˻�֧�� ���������1 70_002 -->
					<tbody id=d_70_002 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>�û��ֻ�����</td>
					      <td>
								  <input type="text" name="d_70_002_phone" id="d_70_002_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					      </td>
					    <td class='blue'>���ԭ��</td>
			        <td>
  							<input name="d_70_002_remres" type="text" id="d_70_002_remres" value=""  v_must='1' />
								<font class="orange">*</font>
					    </td>

					  </tr>
					</tbody>
					
					
					<!-- 139���� Ӫ�����ʼ����� 62_001 -->
					<tbody id=d_62_001 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>�û�����</td>
			        <td>
  							<input name="d_62_001_custlive" type="text" id="d_62_001_custlive" value="3"  v_must='1' />
								<font class="orange">*</font>
					    </td>
					    <td class='blue'>�û�������˾</td>
			        <td>
  							<input name="d_62_001_custcomp" type="text" id="d_62_001_custcomp" value="�������ƶ�"  v_must='1' />
								<font class="orange">*</font>
					    </td>
					  </tr>
					  <tr>
					    <td class='blue'>�û���������</td>
			        <td>
  							<input name="d_62_001_custgroup" type="text" id="d_62_001_custgroup" value="�ͷ�"  v_must='1' />
								<font class="orange">*</font>
					    </td>
					    <td class='blue'>�Ƽ�������</td>
			        <td>
  							<input name="d_62_001_t_name" type="text" id="d_62_001_t_name" value="<%=workNo%>"  v_must='1' />
								<font class="orange">*</font>
					    </td>
					  </tr>
					  <tr>
					    <td class='blue'>�û�����</td>
			        <td>
  							<input name="d_62_001_custname" type="text" id="d_62_001_custname" value="<%=bp_name%>"  v_must='1' />
								<font class="orange">*</font>
					    </td>
					    <td class='blue'>˵����ע</td>
			        <td>
  							<input name="d_62_001_opmemo" type="text" id="d_62_001_opmemo" value="�ͻ�Ҫ��"  v_must='1' />
								<font class="orange">*</font>
					    </td>
					  </tr>
					  <tr>
					    <td class='blue'>�ֻ�����</td>
					      <td colspan="3">
								  <input type="text" name="d_62_001_phone" id="d_62_001_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					      </td>

					  </tr>
					</tbody>					
					
					
					<!-- �ֻ����� �͵�ͼ��Ӷ��������� 54_001 -->
					<tbody id=d_54_001 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>�û��ֻ�����</td>
					      <td>
								  <input type="text" name="d_54_001_phone" id="d_54_001_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					      </td>
					    <td class='blue'>����</td>
			        <td>
  							<select name="d_54_001_type"  id="d_54_001_type">
  								<option value="0">����������</option>
  							</select>
								<font class="orange">*</font>
					    </td>

					  </tr>
					</tbody>					
					<!-- �ֻ����� �͵�ͼɾ������������ 54_002 -->
					<tbody id=d_54_002 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>�û��ֻ�����</td>
					      <td>
								  <input type="text" name="d_54_002_phone" id="d_54_002_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					      </td>
					    <td class='blue'>����</td>
			        <td>
  							<select name="d_54_002_type"  id="d_54_002_type">
  								<option value="0">����������</option>
  							</select>
								<font class="orange">*</font>
					    </td>

					  </tr>
					</tbody>					
					<!-- 12582ҵ�� ҵ����������� 130_001 -->
					<tbody id=d_130_001 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>�û��ֻ�����</td>
					      <td>
								  <input type="text" name="d_130_001_phone" id="d_130_001_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					      </td>
					    <td class='blue'>��������</td>
			        <td>
  							<select name="d_130_001_type"  id="d_130_001_type">
  								<option value="0">��ʾȫ��</option>
  								<option value="1">��ʾ����</option>
  								<option value="2">��ʾ����</option>
  							</select>

								<font class="orange">*</font>
					    </td>
					  </tr>
					  <tr>
					    <td class='blue'>���ԭ��</td>
			        <td>
  							<input name="d_130_001_addres" type="text" id="d_130_001_addres" value="10086"  v_must='1' />
								<font class="orange">*</font>
					    </td>
					    <td class='blue'>����Ա</td>
			        <td>
  							<input name="d_130_001_oprworkno" type="text" id="d_130_001_oprworkno" value="<%=workNo%>"  v_must='1' />
								<font class="orange">*������-��������ʽ</font>
					    </td>
					  </tr>
					  <tr>
					    <td class='blue'>���β�Ʒ����</td>
			        <td colspan="3">
  							<input name="d_130_001_prodcode" type="text" id="d_130_001_prodcode" value=""  v_must='0' />
								<font class="orange">��Ʒ�����д</font>
					    </td>

					  </tr>
					</tbody>					
					<!-- 12582ҵ�� ҵ�������ɾ�� 130_002 -->
					<tbody id=d_130_002 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>�û��ֻ�����</td>
					      <td>
								  <input type="text" name="d_130_002_phone" id="d_130_002_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					      </td>
					    <td class='blue'>��������</td>
			        <td>
  							<select name="d_130_002_type"  id="d_130_002_type">
  								<option value="0">��ʾȫ��</option>
  								<option value="1">��ʾ����</option>
  								<option value="2">��ʾ����</option>
  							</select>
								<font class="orange">*</font>
					    </td>
					  </tr>
					  <tr>
					    <td class='blue'>ɾ��ԭ��</td>
			        <td>
  							<input name="d_130_002_delres" type="text" id="d_130_002_delres" value="10086"  v_must='1' />
								<font class="orange">*</font>
					    </td>
					    <td class='blue'>����Ա</td>
			        <td>
  							<input name="d_130_002_oprworkno" type="text" id="d_130_002_oprworkno" value="<%=workNo%>"  v_must='1' />
								<font class="orange">*������-��������ʽ</font>
					    </td>
					  </tr>
					  <tr>
					    <td class='blue'>���β�Ʒ����</td>
			        <td>
  							<input name="d_130_002_prodcode" type="text" id="d_130_002_prodcode" value=""  v_must='0' />
								<font class="orange">��Ʒ�����д</font>
					    </td>

					  </tr>
					</tbody>					
					
					<!-- 12590ϵͳƽ̨ ���������11 121_001 -->
					<tbody id=d_121_001 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>�û��ֻ�����</td>
					      <td>
								  <input type="text" name="d_121_001_phone" id="d_121_001_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					      </td>
					    <td class='blue'>ʡ��</td>
			        <td>
  							<input name="d_121_001_String" type="text" id="d_121_001_String" value="451"  v_must='1'  readonly class="InputGrey"  />
								<font class="orange">*</font>
					    </td>
					  </tr>
					  <tr>

					    <td class='blue'>��ʼʱ��</td>
			        <td>
			        	<input name="d_121_001_begTime" type="text" id="d_121_001_begTime" value="<%=bMon%>"
			        	onclick="WdatePicker({el:'d_121_001_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
			        	v_must ='1' maxlength="19"   onblur = "checkElement(this)"/>
			        	 			<img id = "imgCustStart"
											onclick="WdatePicker({el:'d_121_001_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
			        </td>
			        <td class='blue'>����ʱ��</td>
			        <td>
								<input name="d_121_001_endTime" type="text" id="d_121_001_endTime" value="<%=bMon%>"
								onclick="WdatePicker({el:'d_121_001_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:false})"
								v_must ='1' maxlength="19"  onblur = "checkElement(this)"/>
  										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_121_001_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:false})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					    </td>
					  </tr>
					  <tr>
					    <td class='blue'>����������</td>
			        <td>
  							<select name="d_121_001_String"  id="d_121_001_String">
  								<option value="1">����ҵ�������</option>
  								<option value=" 2">�ͻ���ҵ�������</option>
  								<option value="3">����ҵ�������</option>
  							</select>
								<font class="orange">*</font>
					    </td>
					    <td class='blue'>������Ա</td>
			        <td>
  							<input name="d_121_001_String" type="text" id="d_121_001_String" value=""  v_must='1' />
								<font class="orange">*������-��������ʽ</font>
					    </td>

					  </tr>
					</tbody>					
					
						<!-- ׿��mdo ���������11 47_001 -->
					<tbody id=d_47_001 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>�û��ֻ�����</td>
					      <td >
								  <input type="text" name="d_47_001_phone" id="d_47_001_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					      </td>

					    <td class='blue'>������ֹʱ��</td>
			        <td>
									<input name="d_47_001_opTime" type="text" id="d_47_001_opTime" v_must ='1' 
					        		onclick="WdatePicker({el:'d_47_001_opTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"
											 value="2050-01-01" readonly  maxlength="19" onblur = "checkElement(this)"/>
					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_47_001_opTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd)*</font>	
			        </td>
			        
					  </tr>
					  <tr>
					    <td class='blue'>������Ա</td>
			        <td colspan="3">
  							<input name="d_47_001_String" type="text" id="d_121_001_String" value="<%=workNo%>"  v_must='1' maxlength="50"/>
								<font class="orange">*������-��������ʽ</font>
					    </td>

					  </tr>
					</tbody>
					
									<!-- ׿��mdo ������ɾ��11 47_002 -->
					<tbody id=d_47_002 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>�û��ֻ�����</td>
					      <td colspan="3">
								  <input type="text" name="d_47_002_phone" id="d_47_002_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					      </td>
					  </tr>
					</tbody>		
					
					
										
			    <tr id='footer'>
			        <td colspan='4'>
			            <input type="button"  id="submitBtn" class='b_foot' value="ִ��" name="submitBtn" />
			            <input type="button"  id="clearBtn" class='b_foot' value="����" name="clear" />
			            <input type="button" class="b_foot" id="close" name="close" value="�ر�" onclick="removeCurrentTab()"/>
			        </td>
			    </tr>
				</table>
		</div>
		
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
