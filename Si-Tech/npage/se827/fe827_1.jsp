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


		response.setHeader("Pragma","No-Cache"); 
	  response.setHeader("Cache-Control","No-Cache");
	  response.setDateHeader("Expires", 0);
		
		String opCode     = "e827";

    String opName     = "����ҵ���ѯ";

    String j_year_w  = new java.text.SimpleDateFormat("yyyy").format(new java.util.Date());
    String j_month_w = new java.text.SimpleDateFormat("MM").format(new java.util.Date());

    String workNo     = (String)session.getAttribute("workNo");

    String regionCode = (String)session.getAttribute("regCode");
    
    String dateStr = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
    
    String dateStrgai = new java.text.SimpleDateFormat("yyyy-MM").format(new java.util.Date());

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
	  
	  bMon=dateStrgai+"-01 00:00:00";
	  
	  String dateStr22gai = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	  
	  
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
	
	bMon22 = dateStr22gai+"01";
	  

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
		
		
		String dateStr5555 = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());
		String dateStr6666 = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
		String datestrsmm=dateStr6666+"01000000";
		
		String dangtiankaishi = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date())+" 00:00:00";
		String datedangtiande = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date())+" 23:59:59";
		
		
		 String loginNoPass = (String)session.getAttribute("password");
		 String ipAddrss = (String)session.getAttribute("ipAddr");
		 String beizhussdese="����phoneNo=["+activePhone+"]���в�ѯ";
		 String bp_name="";
		 String sm_codes="";
		 String xingjis="04";
		 
		 
		 
		 Calendar cal_month_6 = Calendar.getInstance(Locale.getDefault());
		 
		 String date_month_0 = new java.text.SimpleDateFormat("yyyy-MM-01", Locale.getDefault()).format(cal_month_6.getTime());
		 String date_time_0_ = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(cal_month_6.getTime());
		 
		 cal_month_6.add(Calendar.MONTH,-2);  
		 String date_month_3 = new java.text.SimpleDateFormat("yyyy-MM-01", Locale.getDefault()).format(cal_month_6.getTime());
		 
		 cal_month_6.add(Calendar.MONTH,-3);  
		 String date_month_6 = new java.text.SimpleDateFormat("yyyy-MM-01", Locale.getDefault()).format(cal_month_6.getTime());
		 
		 System.out.println("-e827-------------date_time_0_-------------->"+date_time_0_);
		 System.out.println("-e827-------------date_month_0-------------->"+date_month_0);
		 System.out.println("-e827-------------date_month_3-------------->"+date_month_3);
		 System.out.println("-e827-------------date_month_6-------------->"+date_month_6);
		 
		 
%>

<wtc:service name="sUserCustInfo" outnum="100"  routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="0" />
			<wtc:param value="01" />	
			<wtc:param value="e827" />	
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
          sm_codes = (baseArr[0][38]).trim();
          
          if(sm_codes.equals("dn")) {
          sm_codes="02";
	        }else if(sm_codes.equals("gn")) {
	          sm_codes="01";
	        }else {
	        	sm_codes="03";
	        }
	        
	        
	        
          System.out.println("2266-------------------bp_name="+bp_name);
          System.out.println("2266-------------------sm_codes="+sm_codes);
          }
    }
    
    //����д���ֻ��ţ�����ʱȥ��
    //activePhone = "15046557789";
    
    %>

<html xmlns="http://www.w3.org/1999/xhtml">

<head>

    <title><%=opName%></title>
		<meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="Cache-Control" content="no-cache" />
		<meta http-equiv="expires" content="0" /> 
  	<script type="text/javascript" src="/npage/public/pubLightBox.js"></script>	

</head>
<script src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js" type="text/javascript"></script>


<script type=text/javascript>
    var e827_search_froms = ""; 

    var search_flag = false;

    //���� �ֻ���Ϸ-���Ѽ�¼��ѯ-��������

    function cntCode (code,name) {

		this.code = code;

		this.name = name;

	}

	//���� �ֻ���Ϸ-���Ѽ�¼��ѯ-��������

	function cntType (code,cc) {

		this.code = code;

		this.cc = cc;

	}

	//�����������ݶ�����������ݶ��������

	{

		var code_1_1 = new cntCode('101','�۷Ѽ�¼');

		var code_2_1 = new cntCode('201','ҵ��㲥��������');

		var code_2_2 = new cntCode('202','Ӫ���');

		var code_2_3 = new cntCode('203','ҵ��ʹ��');

		var code_3_1 = new cntCode('301','ҵ�񶩹�');

		var code_3_2 = new cntCode('302','ҵ���˶�');

		var code_4_1 = new cntCode('401','Ӫ��-��֪�鶨�ơ�ȡ������');

		var code_4_2 = new cntCode('402','Ӫ��-����/ʵ�ﷵ������');

		var code_4_3 = new cntCode('403','Ӫ��-����δ�Զ�ȡ��');

		var code_4_4 = new cntCode('404','Ӫ��-��Ӫ���涨/���̲���');

		var code_4_5 = new cntCode('405','Ӫ��-���������ƻ���ҵ��涨��һ��');

		var code_4_6 = new cntCode('406','����-���Ʋ��ɹ�');

		var code_4_7 = new cntCode('407','����-�޷�ȡ��ҵ��');

		var code_4_8 = new cntCode('408','ʹ��-������δ�յ����Ѷ���');

		var code_4_9 = new cntCode('409','ʹ��-���غ���ʵ����Ϸ����');

		var code_4_10 = new cntCode('410','ʹ��-ҵ���޷��������ʻ�վ�ڹ����޷�����ʹ��');

		var code_4_11 = new cntCode('411','ʹ��-����������ҵ���޷�ʹ��');

		var code_4_12 = new cntCode('412','ʹ��-�ͻ����޷��������ذ�װ');

		var code_4_13 = new cntCode('413','ʹ��-�Բ�Ʒ�涨/���̲���');

		var code_4_14 = new cntCode('414','ʹ��-ʹ�ò�����');

		var code_4_15 = new cntCode('415','�ʷ�-�ƷѴ���');

		var code_4_16 = new cntCode('416','�ʷ�-ȡ��ҵ������շ�');

		var code_4_17 = new cntCode('417','�ʷ�-�շѺ����������');

		var code_4_18 = new cntCode('418','�ʷ�-����ȡ��Ϣ��/������');

		

		var types = {};

		var codeArray1 = new Array();

		var codeArray2 = new Array();

		var codeArray3 = new Array();

		var codeArray4 = new Array();

		codeArray1.push(code_1_1);

		

		codeArray2.push(code_2_1);

		codeArray2.push(code_2_2);

		codeArray2.push(code_2_3);

		

		codeArray3.push(code_3_1);

		codeArray3.push(code_3_2);

		

		codeArray4.push(code_4_1);

		codeArray4.push(code_4_2);

		codeArray4.push(code_4_3);

		codeArray4.push(code_4_4);

		codeArray4.push(code_4_5);

		codeArray4.push(code_4_6);

		codeArray4.push(code_4_7);

		codeArray4.push(code_4_8);

		codeArray4.push(code_4_9);

		codeArray4.push(code_4_10);

		codeArray4.push(code_4_11);

		codeArray4.push(code_4_12);

		codeArray4.push(code_4_13);

		codeArray4.push(code_4_14);

		codeArray4.push(code_4_15);

		codeArray4.push(code_4_16);

		codeArray4.push(code_4_17);

		codeArray4.push(code_4_18);

		

		types.c1 = codeArray1;

		types.c2 = codeArray2;

		types.c3 = codeArray3;

		types.c4 = codeArray4;

	}	

  $(function() {

  	 $('#busiType').change(function() {

  	 	$('#validateDiv').css('display','none');

  	 	var type = $('#busiType').val();

  	 	var opr_type = new Array();

  	 	if(type == '42') {

  	 		opr_type.push('<option value="001">ҵ��������û���ѯ</option>');

  	 		opr_type.push('<option value="002">�Ķ���¼��ѯ</option>');

  	 		opr_type.push('<option value="003">�鼮��Ϣ��ѯ</option>');

  	 		opr_type.push('<option value="004">����ѯ</option>');

  	 		opr_type.push('<option value="005">���¼�¼��ѯ</option>');

  	 		opr_type.push('<option value="006">�㲥������ѯ</option>');

  	 		opr_type.push('<option value="007">�ְֳ󶨹�ϵ��ѯ</option>');
  	 		
  	 		opr_type.push('<option value="008">��ֵ��¼��ѯ</option>');
  	 		opr_type.push('<option value="009">���������в�ѯ</option>');

  	 	}else if(type == '57') {

  	 		opr_type.push('<option value="001">��������ѯ</option>');

  	 		opr_type.push('<option value="002">���Ѽ�¼��ѯ</option>');

  	 		opr_type.push('<option value="003">�ײͶ�����ϵ��ѯ</option>');

  	 		opr_type.push('<option value="004">�ײͶ�����¼��ѯ</option>');

  	 		opr_type.push('<option value="005">������ֵ��¼��ѯ</option>');

  	 		opr_type.push('<option value="006">��������ѯ</option>');
  	 		opr_type.push('<option value="007">ҵ�������Ϣ��ѯ</option>');
  	 		opr_type.push('<option value="008">Ӫ����Ϣ���β�ѯ</option>');
  	 		/*2014/08/05 14:05:26 gaopeng �����·�һ���ͷ�ʡ��ҵ��֧��ϵͳ2014��07��������ϸ���Ҫ���֪ͨ
  	 			�ֻ���Ϸ 
  	 			�û���Ϣ��ѯ ��������ѯ �˲��ѯ ʹ�ü�¼��ѯ
  	 		*/
  	 		opr_type.push('<option value="009">�û���Ϣ��ѯ</option>');
  	 		opr_type.push('<option value="010">��������ѯ</option>');
  	 		opr_type.push('<option value="011">�˲��ѯ</option>');
  	 		opr_type.push('<option value="012">ʹ�ü�¼��ѯ</option>');
  	 	}else if(type == '82') {
  	 		opr_type.push('<option value="001">Ӫ���̲��Ų�ѯ</option>');
  	 		opr_type.push('<option value="002">������Ϣ��ѯ</option>');
  	 		opr_type.push('<option value="003">�㲥������ѯ</option>');
  	 		opr_type.push('<option value="005">�쳣�����û���ѯ</option>');
  	 		opr_type.push('<option value="006">��������ѯ</option>');
  	 		/*2014/08/05 10:01:51 gaopeng �����·�һ���ͷ�ʡ��ҵ��֧��ϵͳ2014��07��������ϸ���Ҫ���֪ͨ
  	 			�ֻ���Ƶ ���� ʹ�ü�¼��ѯ ҵ���������ѯ
  	 		*/
  	 		opr_type.push('<option value="007">ʹ�ü�¼��ѯ</option>');
  	 		opr_type.push('<option value="008">��������ѯ</option>');
  	 		
  	 		opr_type.push('<option value="009">�û��˻���ѯ</option>');
  	 		opr_type.push('<option value="010">��ֵ��¼��ѯ</option>');
  	 		opr_type.push('<option value="011">���Ѽ�¼��ѯ</option>');
  	 		

  	 	}else if(type == '72') {
  	 		opr_type.push('<option value="001">��/���ź�������ѯ</option>');
  	 		opr_type.push('<option value="002">�㲥������ѯ</option>');
  	 		
  	 		opr_type.push('<option value="003">��Ա��ʷ������¼��ѯ</option>');
  	 		opr_type.push('<option value="004">������ʷ������¼��ѯ</option>');
  	 		opr_type.push('<option value="005">����������ʷ��¼��ѯ</option>');
  	 		opr_type.push('<option value="006">���嶩����ʷ��¼��ѯ</option>');
  	 		opr_type.push('<option value="007">����������������ѯ</option>');
  	 		opr_type.push('<option value="008">���������м�¼��ѯ</option>');
  	 		
  	 	}else if(type == '64') {

  	 		opr_type.push('<option value="001">�û��˻�����ѯ</option>');

  	 		opr_type.push('<option value="002">�ɻ��ѽ��ײ�ѯ</option>');

  	 		opr_type.push('<option value="003">���Ӿ��ѯ</option>');

  	 		opr_type.push('<option value="004">�û�������Ϣ�б��ѯ</option>');

  	 		opr_type.push('<option value="005">�û�������ϸ��Ϣ��ѯ</option>');

  	 		opr_type.push('<option value="006">�û���������ʷ��ѯ</option>');
  	 		
  	 		opr_type.push('<option value="007">������ϵ��ѯ</option>');
  	 		opr_type.push('<option value="008">�˻���ֵ��ѯ</option>');
  	 		opr_type.push('<option value="009">�Զ��仰�Ѳ�ѯ</option>');
  	 		opr_type.push('<option value="010">ʵ����֤�����ֻ��Ų�ѯ</option>');
  	 		opr_type.push('<option value="011">��������ϸ��ѯ</option>');
  	 	
  	 	}else if(type == '40') {
  	 		opr_type.push('<option value="001">���Ŷ�����Ϣ��ѯ</option>');
  	 		opr_type.push('<option value="002">����ȫ����־��ѯ</option>');
  	 		opr_type.push('<option value="003">������Կ������־��ѯ</option>');
  	 		opr_type.push('<option value="004">ҵ�񶩹���־��ѯ</option>');
  	 		opr_type.push('<option value="005">ҵ��ͨ��־��ѯ</option>');
  	 		opr_type.push('<option value="006">GBA��ʼ����־��ѯ</option>');
  	 		opr_type.push('<option value="007">SGҵ��������־��ѯ</option>');
  	 		opr_type.push('<option value="008">������Կ������־��ѯ</option>');
  	 		opr_type.push('<option value="009">������ϵ��־��ѯ</option>');
  	 		opr_type.push('<option value="010">������ϵ������־��ѯ</option>');
  	 		opr_type.push('<option value="011">�������¶�����¼��ѯ</option>');
  	 	}else if (type == '95'){
  	 	  opr_type.push('<option value="001">�㲥��¼��ѯ</option>');
  	 		opr_type.push('<option value="002">������Ϣ��ѯ</option>');
  	 		opr_type.push('<option value="003">��������ѯ</option>');
  	 		/*2014/08/05 8:56:31 gaopeng �����·�һ���ͷ�ʡ��ҵ��֧��ϵͳ2014��07��������ϸ���Ҫ���֪ͨ���������Žӿڣ� 
  	 			��ҵ�����Ϊ���乾������ʱ
  	 			
  	 		*/
  	 		/*�쳣��Ϊ�û���ѯ*/
  	 		opr_type.push('<option value="004">��������ѯ</option>');
  	 		/*�û�����״̬��ѯ*/
  	 		opr_type.push('<option value="005">������־����״̬��ѯ</option>');
  	 		opr_type.push('<option value="006">��������ѯ</option>');
  	 		opr_type.push('<option value="007">��ֵ��¼��ѯ</option>');
  	 		opr_type.push('<option value="008">�������Ѽ�¼��ѯ</option>');
  	 		opr_type.push('<option value="009">���Ҵ�����¼��ѯ</option>');
  	 		
  	 		opr_type.push('<option value="010">���¶�����ϵ��ʷ��¼��ѯ</option>');
  	 		opr_type.push('<option value="011">���Ѽ�¼��ѯ</option>');
  	 		opr_type.push('<option value="012">�û��˻���ѯ</option>');
  	 		
  	 		opr_type.push('<option value="013">���������в�ѯ</option>');
  	 		opr_type.push('<option value="014">�˲�</option>');

  	 	}else if (type == '70'){
  	 	  opr_type.push('<option value="001">ͨ���˻�֧����ʷ������ѯ</option>');
  	 	  opr_type.push('<option value="002">���������в�ѯ</option>');
  	 	  opr_type.push('<option value="003">��������ѯ</option>');
  	 	  opr_type.push('<option value="004">����ҵ���ѯ</option>');
  	 	}else if(type == '41') {
  	 		/*MobileMarket 2014/08/05 14:34:32 gaopeng �����·�һ���ͷ�ʡ��ҵ��֧��ϵͳ2014��07��������ϸ���Ҫ���֪ͨ*/
  	 		opr_type.push('<option value="001">MM������������ѯ</option>');
  	 		opr_type.push('<option value="002">MM������ϵ��ѯ</option>');
  	 		opr_type.push('<option value="003">�û������쳣��Ϊ�˲�</option>');
  	 		opr_type.push('<option value="004">�û�������������־��ѯ</option>');
  	 		opr_type.push('<option value="005">�û��켣��Ϊ�˲�</option>');
  	 		opr_type.push('<option value="006">�û������޶��ѯ</option>');
  	 		opr_type.push('<option value="007">�û�ͼ����֤���ѯ</option>');
  	 		
  	 	}else if(type == '99') {
  	 		/*MobileMarket 2014/08/05 14:34:32 gaopeng �����·�һ���ͷ�ʡ��ҵ��֧��ϵͳ2014��07��������ϸ���Ҫ���֪ͨ*/
  	 		opr_type.push('<option value="001">IVR�����¼��ѯ</option>');
  	 		opr_type.push('<option value="002">MDO������ϵ��ѯ</option>');
  	 	}else if(type == '62') {//139����
  	 		opr_type.push('<option value="001">139�����˺���Ϣ��ѯ</option>');
  	 		opr_type.push('<option value="002">Ӫ�����ʼ����β�ѯ</option>');
  	 	}else if(type == '54') {//�ֻ�����
  	 		opr_type.push('<option value="001">�͵�ͼ������ϵ������ѯ</option>');
  	 		opr_type.push('<option value="002">�͵�ͼ������ϵ״̬��ѯ</option>');
  	 		opr_type.push('<option value="003">�͵�ͼ������������ѯ</option>');
  	 	}else if(type == '130') {//12582
  	 		opr_type.push('<option value="001">������ʷ��ѯ</option>');
  	 		opr_type.push('<option value="002">���ݶ��ƹ�ϵ��ѯ</option>');
  	 		opr_type.push('<option value="003">�·���ʷ��¼��ѯ</option>');
  	 		opr_type.push('<option value="004">ҵ���������ѯ</option>');
  	 	}else if(type == '50') {//12580
  	 		opr_type.push('<option value="001">12580������ϵ��ѯ</option>');
  	 		opr_type.push('<option value="002">��ʷ��¼��ѯ</option>');
  	 		opr_type.push('<option value="003">�㲥��¼��ѯ</option>');
  	 	}else if(type == '121') {//12590
  	 		opr_type.push('<option value="001">�����¼��ѯ</option>');
  	 		opr_type.push('<option value="002">�ͻ���ҵ��ʹ�ò�ѯ</option>');
  	 		opr_type.push('<option value="003">�û����������в�ѯ</option>');
  	 		opr_type.push('<option value="004">��������ѯ</option>');
  	 		
  	 		opr_type.push('<option value="005">�������Ѽ�¼��ѯ</option>');
  	 		opr_type.push('<option value="006">����ҵ���ѯ</option>');
  	 		opr_type.push('<option value="007">��ʱ��ҵ���ѯ</option>');
  	 		opr_type.push('<option value="008">��������ѯ</option>');
  	 		
  	 	}else if(type == '47') {//12590
  	 		opr_type.push('<option value="001">���������в�ѯ</option>');
  	 		opr_type.push('<option value="002">MDO������ϵ��ѯ</option>');
  	 		opr_type.push('<option value="003">��������ѯ</option>');
  	 	}
  	 	
  	 	
  	 	$('#indictSeq').val("");
  	 	

  	 	$('#oprType').empty().append(opr_type.join(''));

		/*
  	 	if(type == '64') {

  	 		$('#oprType[@value="007"]').change();	

  	 	}else {

  	 		$('#oprType[@value="001"]').change();	

  	 	}
*/
  	 	$('#oprType').change();	

  	 	

  	 	//�����ѯ�����л�ҵ�����ʱ����ղ�ѯ����б�

  	 	if(search_flag) {

  	 		clearResultIframe();

  	 	}

  	 });

  	

  	 $("#busiType[@value='42']").change();

  	 

	 $('#oprType').change(function() {

	 	$('#validateDiv').css('display','none');

	 	var busiType = $('#busiType').val();

		var oprType = $('#oprType').val();

		$('.tbody_form').css('display','none');	
		//alert('#d_' + busiType + '_' + oprType);
	 	$('#d_' + busiType + '_' + oprType).css('display','block');	
	 	
	 	if(busiType=="99") {
	 	document.all.ivr_backEnd.disabled=false;
	 	}else {
	 	document.all.ivr_backEnd.disabled=true;
	 	}

	 	//�����ѯ�����л�ҵ�����ʱ����ղ�ѯ����б�

  	 	if(search_flag) {

  	 		clearResultIframe();

  	 	}

	 });

  	

  	 /*liujian �ֻ���Ϸ �������ͺ������������� 2012-5-4 14:23:20 */

  	 $('#d_57_002_type').change(function() {

		var d_type = $('#d_57_002_type').val();

		var d_cnt = new Array();

		for(var i=0,len=types['c'+d_type].length;i<len;i++) {

			var codeObj = types['c'+d_type];

			d_cnt.push('<option value=' + codeObj[i].code + '>' + codeObj[i].name + '</option>');

		}

		$('#d_57_002_connect').empty().append(d_cnt.join(''));

		//����select�Ŀ��

		$('#d_57_002_connect').css('width',"270px");	

	 });

	  

  $('#searchBtn').click(function() {
		//1. ���ѡ���ҵ�����
		var busiType = $('#busiType').val();

		//2. ��ò�������
		var oprType = $('#oprType').val();
		var qry_type = $('#qryType').val();
		if ( busiType == '42')
		{
			if ( oprType != '001' && qry_type == '')
			{
				
				rdShowMessageDialog("���ͱ���ѡ��!",0);
				return false;
			}
		}
		else
		{
			if (qry_type == '')
			{
				rdShowMessageDialog("���ͱ���ѡ��!",0);
				return false;	
			}
		}
		
		if ( $('#d_64_002_phone').val()=='' && $( 'd_64_002_payPhone' ).val()=='' )
		{
			rdShowMessageDialog('�ֻ��źͽɷ��ֻ��Ų���ͬʱΪ��',0);
			return false;
		}
		
		//3. ��ȡform��
		//new Function('getValue_' + busiType + '_' + oprType + '()')();

		if(!checkObj($('#d_' + busiType + '_' + oprType))){
			return false;
		}

		var beginDate = '';
		var endDate = '';
		var $begTime = $('#d_' + busiType + '_' + oprType + '_begTime');
		var $endTime = $('#d_' + busiType + '_' + oprType + '_endTime');
		
		var vType = $begTime.attr('v_type');
		if(($begTime.val() || $endTime.val()) && (vType == 'date_time' || vType == 'date')){
			if(compareDatesByType($begTime[0],$endTime[0],vType)==-1){
	   			rdShowMessageDialog("��ʼʱ�������ʽ����ȷ,����������!");
	   			$begTime.focus();
	  		  return false;
			}

			if(compareDatesByType($begTime[0],$endTime[0],vType)==-2){
         rdShowMessageDialog("����ʱ�������ʽ����ȷ,����������!");
         $endTime.focus();
         return false;
			}

			if(compareDatesByType($begTime[0],$endTime[0],vType)==1){
         rdShowMessageDialog("��ʼʱ��Ӧ���ڽ���ʱ��,����������!");
         $endTime.focus();
         return false;
			}

			//����ʱ�� ʱ���ѯ��Ȳ��ܳ���1��
			if((busiType == '57' && oprType!='004') || (busiType == '72' && oprType!='005')|| busiType == '82') {
				var beginT = $begTime.val();
				var endT = $endTime.val();
				var rb = beginT.replace(/\D/g, "");
				var re = endT.replace(/\D/g, "");
				if(rb && re && (parseFloat(re) - parseFloat(rb) > 10000000000)) {
					rdShowMessageDialog("��ʼʱ�������ʱ���Ȳ��ܳ���һ��,����������!");
	        $endTime.focus();
	        return false;
				}
			}
			
			//����ʱ�� ʱ���ѯ��Ȳ��ܳ���5��
			if(busiType == '40') {
				if (oprType != '001' && oprType != '011'){
					var beginT = $begTime.val();
					var endT = $endTime.val();
					var rb = beginT.replace(/-/g, "/");
					var re = endT.replace(/-/g, "/");
					var endDate = new Date(re);
					var begDate = new Date(rb);
					if(rb && re && (endDate.getTime() - begDate.getTime() > 5 * 24 * 60 * 60 * 1000)) {
						rdShowMessageDialog("��ʼʱ�������ʱ���Ȳ��ܳ���5��,����������!");
		        $endTime.focus();
		        return false;
					}
				}
			}
			
			//����ʱ�� ʱ���ѯ��Ȳ��ܳ���һ����
			if(busiType == '72' && oprType == '005') {
					var beginT = $begTime.val();
  				var endT = $endTime.val();
  				var rb = beginT.replace(/\D/g, "");
  				var re = endT.replace(/\D/g, "");
  				if(rb && re && (parseFloat(re) - parseFloat(rb) > 100000000)) {
  					rdShowMessageDialog("��ʼʱ�������ʱ���Ȳ��ܳ���һ����,����������!");
  	        $endTime.focus();
  	        return false;
  				}
			}
		}	

		var $phoneNo = $('#d_' + busiType + '_' + oprType + '_phone');
		/*
		if($phoneNo.attr('id') && !$.trim($phoneNo.val())) {
			rdShowMessageDialog("�ֻ����벻��Ϊ��");
			return false;	
		}
		*/

		if(busiType == '64' && oprType== '004') {
			if($.trim($('#d_64_004_phone').val())=='' && $.trim($('#d_64_004_byname').val())=='') {
				rdShowMessageDialog("�ֻ��źͱ�����������һ��!");
        $('#d_64_004_phone').focus();
        return false;
			}
		}
		
		if(busiType == '64' && oprType== '011') {
			if($.trim($('#d_64_011_pay_no').val())=='' && $.trim($('#d_64_011_pay_no_n').val())=='') {
				rdShowMessageDialog("֧������ͱ���ֵ�����������һ��!");
        return false;
			}
			
					var beginT =$.trim($('#d_64_011_begTime').val()) ;
  				var endT = $.trim($('#d_64_011_endTime').val());
			
        if(beginT.substring(0,4)==endT.substring(0,4)) {
            if(beginT.substring(4,6)==endT.substring(4,6)) {
						}else {
						rdShowMessageDialog("��ʼʱ�������ʱ���Ȳ��ܳ���һ����,����������!");
  	        return false;
						}
        }else {
          	rdShowMessageDialog("��ʼʱ�������ʱ���Ȳ��ܳ���һ����,����������!");
  	        return false;
        }
  				
		}
		
		
		var phoneNo = "";
		if(!$phoneNo.attr('id')) {
			phoneNo="";
		}else {
			phoneNo = $.trim($phoneNo.val());	
		}
		//showBox();
		var resultStr = getValue('d_' + busiType + '_' + oprType);
		//alert(resultStr);
		if(busiType == '64' && oprType== '007') {
			//busiType = '70';	
		}
		if(busiType == '99') {
			
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
           
           //$('#jsontext').val(jsonstr);
			
		document.resultIframe.location='fe827_frame_mdo.jsp?opCode=<%=opCode%>&phoneNo=' + phoneNo + '&busiType='+ busiType + '&oprType=' + oprType + '&infoStr=' + resultStr+'&bp_name=<%=bp_name%>&sm_codes=<%=sm_codes%>&xingjis=<%=xingjis%>&jsonstr='+jsonstr;	
		}else {
		document.resultIframe.location="fe827_frame.jsp?opCode=<%=opCode%>&phoneNo=" + phoneNo + "&busiType="+ busiType + "&oprType=" + oprType + "&infoStr=" + resultStr;
		}
		search_flag = true;
  });

  	 

  	 

  	 /* liujian ���� 2012-5-4 13:32:02 */

  	 $('#clearBtn').click(function() {
  	 
  	 window.location.href = "fe827_1.jsp?activePhone=<%=activePhone%>&opCode=<%=opCode%>&opName=<%=opName%>";

  	 	//$('input[type="text"]').val('');

		$("select").each(function(){

			//$(this).get(0).options[0].selected = true;  

		});

		$("#busiType[value=42]").change();

  	 //	window.frames["resultIframe"].clearTable();	

  	 });

 

  });

  		

  //���this.id��id��tbody�ڵ�form����ֻ��input��select

  function getValue(id) {

	var arr = new Array();

	$('#' + id).find('td').each(function(i){

		var $this = $(this);

		$this.find('input').each(function(){

			arr.push($(this).val());

		});

		$this.find('select').each(function(){

			arr.push($(this).val());

		});

	}); 

	return arr.join('|');

  }



  

/*

  function listQry() {

  		var groupNo = $('#groupNo').val();

			var beginNo = $('#beginNo').val();

  		var endNo = $('#endNo').val();

  		document.middle.location="fe767_2.jsp?opCode=<%=opCode%>&groupNo="+ groupNo + "&beginNo=" + beginNo + "&endNo=" + endNo;

  }

 */ 

  function showIfTable() {

  	window.frames["resultIframe"].showTable();	

  }

  

	function check() {

		

	}

  	

	function showBox() {

		showLightBox();

	}

	

	function hideBox() {

		hideLightBox();	

	}

	

	function clearResultIframe() {

		window.frames["resultIframe"].clearTable();	

	}

	

	function setByName() {

		if($('#d_64_004_phone').val())	{

			if(!$('#d_64_004_byname').val())	{

					$('#d_64_004_byname').val($('#d_64_004_phone').val())

			}

		}

	}

//�Ƚ�ʱ���С

function compareDatesByType(obj1,obj2,type)

{

	var date1=obj1.value;

	var dateformat1 = '';

	var date2= obj2.value;

	var dateformat2 = '';

	if(type == 'date_time') {

		dateformat1	= 'yyyy-MM-dd HH:mm:ss';

		dateformat2	= 'yyyy-MM-dd HH:mm:ss';

	}else if(type == 'date') {

		dateformat1	= 'yyyyMMdd';

		dateformat2	= 'yyyyMMdd';	

	}

	var d1=getDateFromFormat(date1,dateformat1);

	var d2=getDateFromFormat(date2,dateformat2);

	if (d1==0 )

		return -1;

	else if(d2==0)

		return -2;

	else if (d1 > d2)

		return 1;

	return 0;

}


	function goBackEnd(){//��ѯ֮����ѡ�������Ĳ�ѯ���ͺ����ܽ��й鵵δ�޸Ļ���
	
	var indictSeq_token = $('#indictSeq').val();
	
		if(indictSeq_token==""){
			  		rdShowMessageDialog("���Ȳ�ѯ�����ٹ鵵��");
  	        return false;
		}else{
		
		var busiType = $('#busiType').val();
		var oprType = $('#oprType').val();		
		
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
		     var resultStrss = getValue('d_' + busiType + '_' + oprType);
		     $('#resultStrss').val(resultStrss);
		
				document.frm.action = "fe827_1_backEnd.jsp";
   			document.frm.submit();
		}
	}
	
	function guanbis() {
	
	 	var busiType = $('#busiType').val();
	 	
	 	if(busiType=="99") {
	
	var indictSeq_token = $('#indictSeq').val();
	
		if(indictSeq_token==""){
			removeCurrentTab();
		}else{
		
		var busiType = $('#busiType').val();
		var oprType = $('#oprType').val();		
		
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
		
		    $('#guidangflag').val("1");
				document.frm.action = "fe827_1_backEnd.jsp";
   			document.frm.submit();
		}
	
		 	}else {
	removeCurrentTab();
	 	}
	
	
	}

</script>



<body>

<form name="frm" action="fe827_2.jsp" method="post" >

<%@ include file="/npage/include/header.jsp" %>

		<div class="title">

			<div id="title_zi"><%=opName%></div>

		</div>

		<input type="hidden" value=""  id="opCode" name="opCode" />

		<input type="hidden" value=""  id="opName" name="opName" />
		
		<input type="hidden" value=""  id="indictSeq" name="indictSeq" />
	  <input type="hidden" value="<%=activePhone%>"  id="indictSeqphone" name="indictSeqphone" />	
	  <input type="hidden" value=""  id="jsontext" name="jsontext" />
	  <input type="hidden" value=""  id="resultStrss" name="resultStrss" />
	  <input type="hidden" value=""  id="guidangflag" name="guidangflag" />
	  

		<div>

				<table cellspacing=0>

				    <tr>

				        <td class='blue' width="15%">ҵ�����</td>

				        <td width="35%">

				        	<select id="busiType">

				        		<option value="42">�乾�Ķ�</option>

				        		<option value="57">�乾��Ϸ</option>

				        		<option value="64">�ֻ�֧��</option>

					        	<option value="72">�乾����</option>

										<option value="82">�乾��Ƶ</option>
										
										<option value="95">�乾����</option>
										<option value="70">ͨ���˻�֧��</option>
										<option value="41">MobileMarket</option>
										<option value="99">MDO��ѯ</option>
										
										<option value="62">139����</option>
										<option value="54">�ֻ�����</option>
										<option value="130">12582����</option>
										<option value="50">12580ҵ��</option>
										<option value="121">12590������־ҵ��</option>
										<option value="47">׿��MDO</option>
										
							</select>

				        </td>

				        <td class='blue' width="15%">��������</td>

				        <td  width="35%">

				        	<select id="oprType">

							</select>

				        </td>

				    </tr>    

				    <!-- �ֻ��Ķ�42--��������ѯ-->

				    <tbody id="d_42_001" class="tbody_form" >

				   		<tr>

					        <td class='blue'>�û��ֻ�����</td>

					        <td>

								<input type="text" name="d_42_001_phone" id="d_42_001_phone" value="<%=activePhone%>"  readonly  class="InputGrey"  v_must ='1' 

								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 

								onafterpaste="this.value=this.value.replace(/\D/g,'')"

								onblur = "checkElement(this)"/>

								<font class="orange">*</font>

					        </td>

					        <td class='blue'>����</td>

					        <td>

					        	<!--

								<input type="radio" name="d_42_001_type" id="d_42_001_type0" value="0" checked>����

								<input type="radio" name="d_42_001_type" id="d_42_001_type1" value="1">����

								<input type="radio" name="d_42_001_type" id="d_42_001_type2" value="2">Wap Push

								-->

								<select id = 'qry_type' name = 'qry_name'>
									<option value="0">����</option>

									<option value="1">����</option>

									<option value="2">Wap Push</option>
									
									<option value="3">ͼ����֤��</option>
									<option value="4">�����������û�</option>
									

								</select>

					        </td>

					    </tr>

					</tbody>

				    <!-- �ֻ��Ķ�--�Ķ���¼��ѯ-->

					<tbody id="d_42_002" class="tbody_form" style="display:none">

						<tr>

					        <td class='blue'>�û��ֻ�����</td>

					        <td>

								<input type="text" name="d_42_002_phone" id="d_42_002_phone" value="<%=activePhone%>"  readonly  class="InputGrey"  v_must ='1' 

								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 

								onafterpaste="this.value=this.value.replace(/\D/g,'')"

								onblur = "checkElement(this)"/>

					        	<font class="orange">*</font>

					        </td>

					        <td class='blue'>�Ķ���ʼʱ��</td>

					        <td>

					        	<input name="d_42_002_begTime" type="text" id="d_42_002_begTime" value="<%=bMon%>"  v_must ='1' 
										onclick="WdatePicker({el:'d_42_002_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
					        	maxlength="19"  v_type="date_time" onblur = "checkElement(this)"/>

					        	
					        		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_42_002_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					    </tr>

					    <tr>

					        <td class='blue'>�Ķ�����ʱ��</td>

					        <td>

								<input name="d_42_002_endTime" type="text" id="d_42_002_endTime" value="<%=mon[0]%>"  v_must ='1' 
								onclick="WdatePicker({el:'d_42_002_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
								maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

											<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_42_002_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					        <td class='blue'>�Ķ�;��</td>

					        <td>

					        	<select id="d_42_002_path">

					        		<option value="0">����</option>

					        		<option value="1">wap</option>

					        		<option value="2">www</option>

					        		<option value="3">������</option>

					        		<option value="4">�ͻ���</option>

					        		<option value="11">ƽ�����</option>

								</select>

					        </td>

					    </tr>

					    <tr>

					        <td class='blue'>��������</td>

					        <td>

								<select id="d_42_002_cntType">

									<option value="0">����</option>

					        		<option value="1">ͼ��</option>

					        		<option value="2">����</option>

					        		<option value="3">��־</option>

					        		<option value="5">����</option>

								</select>

					        </td>

					        <td class='blue'>����</td>

					        <td>

					        	<input name="d_42_002_book" type="text"  id="d_42_002_book" maxlength="300" value="" 

					        	  onblur = "checkElement(this)"/>

					        </td>

					    </tr>

					    <tr>

					        <td class='blue'>�½�����</td>

					        <td>

					        	<input name="d_42_002_chapter" type="text" id="d_42_002_chapter" maxlength="300" 

					        	value="" onblur = "checkElement(this)"/>

					        </td>

					        <td class='blue'></td>

					        <td></td>

					    </tr>

					</tbody>

					<!-- �ֻ��Ķ�--�鼮��Ϣ��ѯ-->

					<tbody id="d_42_003" class="tbody_form" style="display:none">

				   		<tr>

					        <td class='blue'>��������</td>

					        <td>

								<input type="text" name="d_42_003_book" id="d_42_003_book" value="" v_must ='1'

								maxlength="128" onblur = "checkElement(this)"/><font class="orange">*</font>

					        </td>

					        <td class='blue'>MCP����</td>

					        <td>

								<input type="text" name="d_42_003_mcp" id="d_42_003_mcp" value="" maxlength="100" 

								onblur = "checkElement(this)"/>

					        </td>

					    </tr>

					    <tr>

					        <td class='blue'>���ұ���</td>

					        <td>

								<input type="text" name="d_42_003_author" id="d_42_003_author" value="" 

								maxlength="40" onblur = "checkElement(this)"/>

					        </td>

					        <td class='blue'></td>

					        <td></td>

					    </tr>

					</tbody>

					<!-- �ֻ��Ķ�--����ѯ-->	

					<tbody id="d_42_004" class="tbody_form" style="display:none">

						<tr>

					        <td class='blue'>�û��ֻ�����</td>

					        <td colspan="3">

								<input type="text" name="d_42_004_phone" id="d_42_004_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1' 

								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 

								onafterpaste="this.value=this.value.replace(/\D/g,'')"

								onblur = "checkElement(this)"/>

					       		<font class="orange">*</font>

					        </td>



					    </tr>

					    <tr>

					        <td class='blue'>��ȯ��</td>

					        <td>

								<input type="text" name="d_42_004_book" id="d_42_004_book" 

							value="" maxlength="256" onblur = "checkElement(this)"/>

								

					        </td>

					        <td class='blue'>��ȯID</td>

					        <td>

								<input type="text" name="d_42_004_id" id="d_42_004_id" value="" 

								maxlength="10"  onblur = "checkElement(this)"/>

								

					        </td>

					    </tr>

						<tr>

					        <td class='blue'>�û����ѿ�ʼʱ��</td>

					        <td>

					        	<input name="d_42_004_begTime" type="text" id="d_42_004_begTime" value="<%=bMon%>"
										onclick="WdatePicker({el:'d_42_004_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					        	maxlength="19" v_type="date_time" onblur = "checkElement(this)" />

					        		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_42_004_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
											<font class="orange">(yyyy-mm-dd hh24:mi:ss)</font>

					        </td>

					        <td class='blue'>�û����ѽ���ʱ��</td>

					        <td>

								<input name="d_42_004_endTime" type="text" id="d_42_004_endTime" value="<%=mon[0]%>"
								onclick="WdatePicker({el:'d_42_004_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
								maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

											<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_42_004_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)</font>

					        </td>

					    </tr>

					</tbody>

					<!-- �ֻ��Ķ�--���¼�¼��ѯ-->

				    <tbody id="d_42_005" class="tbody_form" style="display:none">

				   		<tr>

					        <td class='blue'>�û��ֻ�����</td>

					        <td>

								<input type="text" name="d_42_005_phone" id="d_42_005_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1' 

								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 

								onafterpaste="this.value=this.value.replace(/\D/g,'')"

								onblur = "checkElement(this)"/>

					        	<font class="orange">*</font>

					        </td>

					        <td class='blue'></td>

					        <td></td>

					    </tr>

					</tbody> 

					<!-- �ֻ��Ķ�--�㲥������ѯ-->

					<tbody id="d_42_006" class="tbody_form" style="display:none">

						<tr>

					        <td class='blue'>�ֻ�����</td>

					        <td>

								<input type="text" name="d_42_006_phone" id="d_42_006_phone" value="<%=activePhone%>"  readonly  class="InputGrey"  v_must ='1' 

								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 

								onafterpaste="this.value=this.value.replace(/\D/g,'')"

								onblur = "checkElement(this)"/>

					        	<font class="orange">*</font>

					        </td>

					        <td class='blue'>����</td>

					        <td>

					        	<input name="d_42_006_book" type="text" id="d_42_006_book" value=""  

					        	maxlength="100" onblur = "checkElement(this)"/>

					        </td>

					    </tr>

					    <tr>

					        <td class='blue'>������ʼʱ��</td>

					        <td>

								<input name="d_42_006_begTime" type="text" id="d_42_006_begTime" value="<%=bMon%>"  v_must ='1' 
								onclick="WdatePicker({el:'d_42_006_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
								maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

											<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_42_006_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					        <td class='blue'>��������ʱ��</td>

					        <td>

								<input name="d_42_006_endTime" type="text" id="d_42_006_endTime" value="<%=mon[0]%>" v_must ='1' 
								onclick="WdatePicker({el:'d_42_006_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
								maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

											<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_42_006_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					    </tr>

					    <tr>

					        <td class='blue'>�Ʒѷ�ʽ</td>

					        <td>
								<select id="d_42_006_billing">

									<option value="0" selected>ȫ��</option>
									<option value="1">�����Ʒ�</option>
									<option value="2">���¼Ʒ�</option>
									<option value="3">��ǧ�ּƷ�</option>
									<option value="4">����</option>
									<option value="5">������</option>
									<option value="7">����</option>
									<option value="15">���</option>
								</select>

					        </td>

					        <td class='blue'>��������</td>

					        <td>

					        	<select id="d_42_006_content">

									<option value="0">����</option>

					        		<option value="1">ͼ��</option>

					        		<option value="2">����</option>

					        		<option value="3">��־</option>

					        		<option value="5">����</option>

								</select>

					        </td>

					    </tr>

					    <tr>

					        <td class='blue'>�Ƿ�����</td>

					        <td>

					        	<select id="d_42_006_send">

									<option value="-1" selected>ȫ��</option>

									<option value="1">��</option>

									<option value="0">��</option>

								</select>

					        </td>

					        <td class='blue'>����;��</td>

					        <td>

					        	<select id="d_42_006_path">
									<option value="0" selected>����</option>
									<option value="1" >wap</option>

									<option value="2">www</option>

									<option value="3">�ֳ��ն�</option>

									<option value="4">�ͻ������</option>

									<option value="5">�ͷ�</option>

									<option value="6">boss</option>

									<option value="7">����</option>

								</select>

							</td>

					    </tr>

					    <tr>

					    	<td class='blue'>�½�����</td>

					        <td>

								<input name="d_42_006_chapter" type="text" id="d_42_006_chapter" value=""  

								maxlength="100" onblur = "checkElement(this)"/>

					        </td>

					        <td class='blue'></td>

					        <td></td>

						</tr>

					</tbody>

					<!-- �ֻ��Ķ�--�ְֳ󶨹�ϵ��ѯ-->

				    <tbody id="d_42_007" class="tbody_form" style="display:none">

				   		<tr>

					        <td class='blue'>�Ʒѿ���</td>

					        <td>

								<input type="text" name="d_42_007_card" id="d_42_007_card" value="<%=activePhone%>"  readonly class="InputGrey" v_must ='1' 

								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 

								onafterpaste="this.value=this.value.replace(/\D/g,'')"

								onblur = "checkElement(this)"/>

					        	<font class="orange">*</font>

					        </td>

					        <td class='blue'></td>

					        <td></td>

					    </tr>

					</tbody> 

					<!-- �乾�Ķ�42--008	��ֵ��¼��ѯ-->

				    <tbody id="d_42_008" class="tbody_form" style="display:none">

				   	<tr>

					        <td class='blue'>�û��ֻ�����</td>

					        <td>

								<input type="text" name="d_42_008_phone" id="d_42_008_phone" value="<%=activePhone%>"  readonly  class="InputGrey"  v_must ='1' 

								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 

								onafterpaste="this.value=this.value.replace(/\D/g,'')"

								onblur = "checkElement(this)"/>

					        	<font class="orange">*</font>

					        </td>

					        <td class='blue'>&nbsp;</td>

					        <td class='blue'>&nbsp;</td>

					    </tr>

					    <tr>

					        <td class='blue'>��ֵ��ʼʱ��</td>

					        <td>

								<input name="d_42_008_begTime" type="text" id="d_42_008_begTime" value="<%=bMon%>"  v_must ='1' 
								onclick="WdatePicker({el:'d_42_008_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
								maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

											<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_42_008_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					        <td class='blue'>��ֵ����ʱ��</td>

					        <td>

								<input name="d_42_008_endTime" type="text" id="d_42_008_endTime" value="<%=mon[0]%>" v_must ='1' 
								onclick="WdatePicker({el:'d_42_008_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
								maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

											<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_42_008_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					    </tr>

	<tr>

					        
					        
					        <td class='blue'>��ֵ��ʽ</td>

					        <td>
					        	<select id="d_42_008_type" name="d_42_008_type">
					        		<option value="0">������ֵ</option>
					        		<option value="8">Appstore��ֵ</option>
					        		<option value="9">��ͨ��ֵ</option>
					        	</select>
					        </td>
								<td class='blue'>&nbsp;</td>

					        <td class='blue'>&nbsp;</td>
					    </tr>
					    
					    
					</tbody> 					


	<!-- ��12590������־ҵ��  121	005	�������Ѽ�¼��ѯ-->

				    <tbody id="d_121_005" class="tbody_form" style="display:none">

				   	<tr>

					        <td class='blue'>�û��ֻ�����</td>

					        <td colspan="3">

								<input type="text" name="d_121_005_phone" id="d_121_005_phone" value="<%=activePhone%>"  readonly  class="InputGrey"  v_must ='1' 
								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
								onafterpaste="this.value=this.value.replace(/\D/g,'')"
								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>

					        </td>


					    </tr>

					    <tr>

					        <td class='blue'>��ʼʱ��</td>

					        <td>

								<input name="d_121_005_begTime" type="text" id="d_121_005_begTime" value="<%=bMon%>"  v_must ='1' 
								onclick="WdatePicker({el:'d_121_005_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
								maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

											<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_121_005_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					        <td class='blue'>����ʱ��</td>

					        <td>

								<input name="d_121_005_endTime" type="text" id="d_121_005_endTime" value="<%=mon[0]%>" v_must ='1' 
								onclick="WdatePicker({el:'d_121_005_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
								maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

											<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_121_005_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					    </tr>

					</tbody> 		
					
	<!-- ��12590������־ҵ��  121	006	����ҵ���ѯ-->

				    <tbody id="d_121_006" class="tbody_form" style="display:none">

				   	<tr>

					        <td class='blue'>�û��ֻ�����</td>

					        <td colspan="3">

								<input type="text" name="d_121_006_phone" id="d_121_006_phone" value="<%=activePhone%>"  readonly  class="InputGrey"  v_must ='1' 
								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
								onafterpaste="this.value=this.value.replace(/\D/g,'')"
								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>

					        </td>


					    </tr>

					    <tr>

					        <td class='blue'>��ʼʱ��</td>

					        <td>

								<input name="d_121_006_begTime" type="text" id="d_121_006_begTime" value="<%=bMon%>"  v_must ='1' 
								onclick="WdatePicker({el:'d_121_006_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
								maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

											<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_121_006_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					        <td class='blue'>����ʱ��</td>

					        <td>

								<input name="d_121_006_endTime" type="text" id="d_121_006_endTime" value="<%=mon[0]%>" v_must ='1' 
								onclick="WdatePicker({el:'d_121_006_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
								maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

											<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_121_006_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					    </tr>

					</tbody> 						



	<!-- ��12590������־ҵ��  007	��ʱ��ҵ���ѯ-->

				    <tbody id="d_121_007" class="tbody_form" style="display:none">

				   	<tr>

					        <td class='blue'>�û��ֻ�����</td>

					        <td colspan="3">

								<input type="text" name="d_121_007_phone" id="d_121_007_phone" value="<%=activePhone%>"  readonly  class="InputGrey"  v_must ='1' 
								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
								onafterpaste="this.value=this.value.replace(/\D/g,'')"
								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>

					        </td>


					    </tr>

					    <tr>

					        <td class='blue'>��ʼʱ��</td>

					        <td>

								<input name="d_121_007_begTime" type="text" id="d_121_007_begTime" value="<%=bMon%>"  v_must ='1' 
								onclick="WdatePicker({el:'d_121_007_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
								maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

											<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_121_007_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					        <td class='blue'>����ʱ��</td>

					        <td>

								<input name="d_121_007_endTime" type="text" id="d_121_007_endTime" value="<%=mon[0]%>" v_must ='1' 
								onclick="WdatePicker({el:'d_121_007_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
								maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

											<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_121_007_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					    </tr>

					</tbody> 	
					<!-- ��12590������־ҵ��  008	��������ѯ-->

				    <tbody id="d_121_008" class="tbody_form" style="display:none">

				   	<tr>

					        <td class='blue'>�û��ֻ�����</td>

					        <td>

								<input type="text" name="d_121_008_phone" id="d_121_008_phone" value="<%=activePhone%>"  readonly  class="InputGrey"  v_must ='1' 
								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
								onafterpaste="this.value=this.value.replace(/\D/g,'')"
								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>

					        </td>


					    </tr>

					    

					</tbody> 	
															
					<!-- �ֻ���Ϸ42--009	���������в�ѯ-->
  			<tbody id="d_42_009" class="tbody_form" style="display:none">

				   	<tr>

					        <td class='blue'>�û��ֻ�����</td>

					        <td>

								<input type="text" name="d_42_009_phone" id="d_42_009_phone" value="<%=activePhone%>"  readonly  class="InputGrey"  v_must ='1' 

								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 

								onafterpaste="this.value=this.value.replace(/\D/g,'')"

								onblur = "checkElement(this)"/>

					        	<font class="orange">*</font>

					        </td>

					       <td class='blue'>&nbsp;</td>

					        <td class='blue'>&nbsp;</td>

					    </tr>

					    <tr>

					        <td class='blue'>���Ϳ�ʼʱ��</td>

					        <td>

								<input name="d_42_009_begTime" type="text" id="d_42_009_begTime" value="<%=bMon%>"  v_must ='1' 
								onclick="WdatePicker({el:'d_42_009_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
								maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

											<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_42_009_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					        <td class='blue'>���ͽ���ʱ��</td>

					        <td>

								<input name="d_42_009_endTime" type="text" id="d_42_009_endTime" value="<%=mon[0]%>" v_must ='1' 
								onclick="WdatePicker({el:'d_42_009_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
								maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

											<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_42_009_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					    </tr>
					    
					    
					    <tr>

					        
					        <td class='blue'>����</td>

					        <td>
					        	<select id="d_42_009_type" name="d_42_008_type">
					        		<option value="0">����</option>
					        		<option value="1">����</option>
					        		<option value="2">ȫ��</option>
					        	</select>
					        </td>
									<td class='blue'>&nbsp;</td>

					        <td class='blue'>&nbsp;</td>

					    </tr>
					    

					</tbody> 					
					
		<!-- 1��ҵ������������֡�����Ϊ���乾���֡���72--008	���������м�¼��ѯ-->
  			<tbody id="d_72_008" class="tbody_form" style="display:none">

				   	<tr>

					        <td class='blue'>�û��ֻ�����</td>

					        <td colspan="3">

								<input type="text" name="d_72_008_phone" id="d_72_008_phone" value="<%=activePhone%>"  readonly  class="InputGrey"  v_must ='1' 

								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 

								onafterpaste="this.value=this.value.replace(/\D/g,'')"

								onblur = "checkElement(this)"/>

					        	<font class="orange">*</font>

					        </td>

					       

					    </tr>

					    <tr>

					        <td class='blue'>��ʼʱ��</td>

					        <td>

								<input name="d_72_008_begTime" type="text" id="d_72_008_begTime" value="<%=bMon%>"  v_must ='1' 
								onclick="WdatePicker({el:'d_72_008_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
								maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

											<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_72_008_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					        <td class='blue'>����ʱ��</td>

					        <td>

								<input name="d_72_008_endTime" type="text" id="d_72_008_endTime" value="<%=mon[0]%>" v_must ='1' 
								onclick="WdatePicker({el:'d_72_008_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
								maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

											<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_72_008_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					    </tr>

					</tbody> 						

					<!-- �ֻ���Ϸ57--��������ѯ-->

					<tbody id="d_57_001" class="tbody_form" style="display:none">

				   		<tr>

					        <td class='blue'>�û��ֻ�����</td>

					        <td>

								<input type="text" name="d_57_001_phone" id="d_57_001_phone" value="<%=activePhone%>"  readonly  class="InputGrey"  v_must ='1' 

								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 

								onafterpaste="this.value=this.value.replace(/\D/g,'')"

								onblur = "checkElement(this)"/>

					        	<font class="orange">*</font>

					        </td>

					        <td class='blue'></td>

					        <td></td>

					    </tr>

					</tbody> 

					<!-- �ֻ���Ϸ--���Ѽ�¼��ѯ-->

					<tbody id="d_57_002" class="tbody_form" style="display:none">

				   		<tr>

					        <td class='blue'>�ֻ�����</td>

					        <td>

								<input type="text" name="d_57_002_phone" id="d_57_002_phone" value="<%=activePhone%>"  readonly  class="InputGrey"   

								v_must ='1' maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 

								onafterpaste="this.value=this.value.replace(/\D/g,'')"

								onblur = "checkElement(this)"/>

					        	<font class="orange">*</font>

					        </td>

					        <td class='blue'>��ʼ����</td>

					        <td>

					        	<input type="text" name="d_57_002_begTime" id="d_57_002_begTime" value="<%=bMon%>"  v_must ='1'
										onclick="WdatePicker({el:'d_57_002_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					        	maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_57_002_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					    </tr>

					    <tr>

					        <td class='blue'>��ֹ����</td>

					        <td>

								<input type="text" name="d_57_002_endTime" id="d_57_002_endTime" value="<%=mon[0]%>"  v_must ='1'
								onclick="WdatePicker({el:'d_57_002_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
								maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_57_002_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					        <td class='blue'>��������</td>

					        <td>

					        	<select id="d_57_002_type">

					        		<option value="1">��ѯ</option>

					        		<option value="2">��ѯ</option>

					        		<option value="3">����</option>

					        		<option value="4">Ͷ��</option>

								</select>

					        </td>

					    </tr>

					    <tr>

					    	<td class='blue'>��������</td>

					        <td>

					        	<select id="d_57_002_connect">

					        		<option value="101">�۷Ѽ�¼</option>

								</select>

					        </td>

					        <td class='blue'></td>

					        <td></td>

					    </tr>

					</tbody> 

					<!-- �ֻ���Ϸ--�ײͶ�����ϵ��ѯ-->

					<tbody id="d_57_003" class="tbody_form" style="display:none">

				   		<tr>

					        <td class='blue'>�ֻ�����</td>

					        <td>

								<input type="text" name="d_57_003_phone" id="d_57_003_phone" value="<%=activePhone%>"  readonly  class="InputGrey"  v_must ='1' 

								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 

								onafterpaste="this.value=this.value.replace(/\D/g,'')"

								onblur = "checkElement(this)"/>

					        	<font class="orange">*</font>

					        </td>

					        <td class='blue'></td><td></td>

					    </tr>

					    <tr>

					    	<td class='blue'>��ʼʱ��</td>

					        <td>

					        	<input name="d_57_003_begTime" type="text" id="d_57_003_begTime" value="<%=bMon%>"  
										onclick="WdatePicker({el:'d_57_003_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					        	v_must ='1' maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_57_003_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					        <td class='blue'>����ʱ��</td>

					        <td>

								<input name="d_57_003_endTime" type="text" id="d_57_003_endTime" value="<%=mon[0]%>"  
								onclick="WdatePicker({el:'d_57_003_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
								v_must ='1' maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_57_003_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					    </tr>

					</tbody>

					<!-- �ֻ���Ϸ--�ײͶ�����¼��ѯ-->

					<tbody id="d_57_004" class="tbody_form" style="display:none">

				   		<tr>

					        <td class='blue'>�ֻ�����</td>

					        <td>

								<input type="text" name="d_57_004_phone" id="d_57_004_phone" value="<%=activePhone%>"  readonly  class="InputGrey"  v_must ='1' 

								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 

								onafterpaste="this.value=this.value.replace(/\D/g,'')"

								onblur = "checkElement(this)"/>

					        	<font class="orange">*</font>

					        </td>

					        <td class='blue'></td><td></td>

					    </tr>

					    <tr>

					    	<td class='blue'>��ʼʱ��</td>

					        <td>

					        	<input name="d_57_004_begTime" type="text" id="d_57_004_begTime" value="<%=bMon%>"  v_must ='1'
										onclick="WdatePicker({el:'d_57_004_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					        	maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

					        		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_57_004_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					        <td class='blue'>����ʱ��</td>

					        <td>

								<input name="d_57_004_endTime" type="text" id="d_57_004_endTime" value="<%=mon[0]%>"   v_must ='1'
								onclick="WdatePicker({el:'d_57_004_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
								maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_57_004_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					    </tr>

					</tbody>	

					<!-- �ֻ���Ϸ--������ֵ��¼��ѯ-->

					<tbody id="d_57_005" class="tbody_form" style="display:none">

				   		<tr>

					        <td class='blue'>�ֻ�����</td>

					        <td>

								<input type="text" name="d_57_005_phone" id="d_57_005_phone" value="<%=activePhone%>"  readonly  class="InputGrey"  v_must ='1' 

								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 

								onafterpaste="this.value=this.value.replace(/\D/g,'')"

								onblur = "checkElement(this)"/>

					        	<font class="orange">*</font>

					        </td>

					        <td class='blue'></td><td></td>

					    </tr>

					    <tr>

					    	<td class='blue'>��ʼʱ��</td>

					        <td>

					        	<input name="d_57_005_begTime" type="text" id="d_57_005_begTime" value="<%=bMon%>"   v_must ='1'
										onclick="WdatePicker({el:'d_57_005_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					        	maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_57_005_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					        <td class='blue'>����ʱ��</td>

					        <td>

								<input name="d_57_005_endTime" type="text" id="d_57_005_endTime" value="<%=mon[0]%>"  v_must ='1'
								onclick="WdatePicker({el:'d_57_005_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
								maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_57_005_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					    </tr>

					</tbody>			

					<!-- �ֻ���Ϸ--��������ѯ-->

					<tbody id="d_57_006" class="tbody_form" style="display:none">

				   		<tr>

					        <td class='blue'>�ֻ�����</td>

					        <td>

								<input type="text" name="d_57_006_phone" id="d_57_006_phone" value="<%=activePhone%>"  readonly  class="InputGrey"  v_must ='1' 

								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 

								onafterpaste="this.value=this.value.replace(/\D/g,'')"

								onblur = "checkElement(this)"/>

								<font class="orange">*</font>

					        </td>

					        <td class='blue'></td><td></td>

					    </tr>

					</tbody>			

					<!-- �ֻ���Ϸ--ҵ�������Ϣ��ѯ-->

					<tbody id="d_57_007" class="tbody_form" style="display:none">

				   		<tr>

					        <td class='blue'>ҵ������</td>

					        <td>

								<input type="text" name="d_57_007_name" id="d_57_007_name" value=""

								maxlength="200" onblur = "checkElement(this)"/>

					        </td>

					        <td class='blue'>ҵ�����</td>

					        <td>

								<input type="text" name="d_57_007_code" id="d_57_007_code" value=""

								maxlength="12" onblur = "checkElement(this)"/>

					        </td>

					    </tr>

					    <tr>

					    	<td class='blue'>�ײ�����</td>

					    	<td class='blue'>

					    		<select id="d_57_007_type">

					        		<option value="0">ȫ��</option>

					        		<option value="1">�ײ�</option>

					        		<option value="2">���ײ�</option>

								</select>

					    	</td>

					    	<td class='blue'></td><td></td>

					    </tr>

					</tbody>	

					<!-- �ֻ���Ϸ--Ӫ����Ϣ���β�ѯ-->
					<tbody id="d_57_008" class="tbody_form" style="display:none">
				   		<tr>
				        <td class='blue'>�û��ֻ�����</td>
				        <td>
  								<input type="text" name="d_57_008_phone" id="d_57_008_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1' 
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
				        </td>
				        <td class='blue'></td>
				        <td></td>
					    </tr>
					</tbody>
					
					<!-- �ֻ���Ϸ--�û���Ϣ��ѯ 57_009-->
					<tbody id="d_57_009" class="tbody_form" style="display:none">
				   		<tr>
				        <td class='blue'>�û��ֻ�����</td>
				        <td>
  								<input type="text" name="d_57_009_phone" id="d_57_009_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1' 
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
				        </td>
				        <td class='blue'></td>
				        <td></td>
					    </tr>
					</tbody>
					
					<!-- �ֻ���Ϸ--��������ѯ 57_010-->
					<tbody id="d_57_010" class="tbody_form" style="display:none">
				   		<tr>
				        <td class='blue'>�û��ֻ�����</td>
				        <td>
  								<input type="text" name="d_57_010_phone" id="d_57_010_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1' 
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
				        </td>
				        <td class='blue'></td>
				        <td></td>
					    </tr>
					</tbody>
					
					<!-- �ֻ���Ϸ--�˲��ѯ 57_011-->
					<tbody id="d_57_011" class="tbody_form" style="display:none">
							<tr>
								<td class="blue">��������</td>
								<td>
									<input name="d_57_011_opTime" type="text" id="d_57_011_opTime" v_must ='1' 
					        		onclick="WdatePicker({el:'d_57_011_opTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"
											 value="<%=dateStr1111%>" readonly  maxlength="19" onblur = "checkElement(this)"/>
					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_57_011_opTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd)*</font>	
								</td>
								<td class="blue">ҵ�����</td>
								<td>
									<input type="text" name="d_57_011_opNum"	id="d_57_011_opNum" value="" v_must ='1' onblur = "checkElement(this)"/>
									<font class="orange">*</font>
								</td>
							</tr>
				   		<tr>
				        <td class='blue'>�û��ֻ�����</td>
				        <td colspan="3">
  								<input type="text" name="d_57_011_phone" id="d_57_011_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1' 
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
				        </td>
					    </tr>
					</tbody>
					
					<!-- �ֻ���Ϸ--ʹ�ü�¼��ѯ 57_012-->
					<tbody id="d_57_012" class="tbody_form" style="display:none">
							<tr>
								<td class="blue">��������</td>
								<td>
									<input name="d_57_012_opTime" type="text" id="d_57_012_opTime" v_must ='1' 
					        		onclick="WdatePicker({el:'d_57_012_opTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"
											readonly value="<%=dateStr1111%>"  maxlength="19" onblur = "checkElement(this)"/>
					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_57_012_opTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd)*</font>	
								</td>
								<td class="blue">ҵ�����</td>
								<td>
									<input type="text" name="d_57_012_opNum"	id="d_57_012_opNum" value=""  onblur = "checkElement(this)"/>
								 
								</td>
							</tr>
				   		<tr>
				        <td class='blue'>�û��ֻ�����</td>
				        <td colspan="3">
  								<input type="text" name="d_57_012_phone" id="d_57_012_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1' 
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
				        </td>
					    </tr>
					</tbody>

					<!-- �ֻ�֧�� ������ϵ��ѯ 64_007 -->
					<tbody id=d_64_007 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>�û��ֻ�����</td>
					      <td colspan="3">
								  <input type="text" name="d_64_007_phone" id="d_64_007_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					      </td>

					  </tr>
					</tbody>
					
					
					
					<!-- �ֻ�֧�� �˻���ֵ��ѯ 64_008 -->
					<tbody id=d_64_008 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>�û��ֻ�����</td>
					      <td>
								  <input type="text" name="d_64_008_phone" id="d_64_008_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					      </td>
					    <td class='blue'>�������</td>
			        <td>
  							<input name="d_64_008_order_no" type="text" id="d_64_008_order_no" value=""  v_must='0' />
							
					    </td>
					  </tr>
					  <tr>
					    <td class='blue'>�û�����</td>
			        <td>
  							<select name="d_64_008_cust_type"  id="d_64_008_cust_type">
  								<option value="0">�ֻ��û�</option>
  								<option value="1">�̻�</option>
  							</select>
								<font class="orange">*</font>
					    </td>
					    <td class='blue'>�˻�����</td>
			        <td>
  							 <select name="d_64_008_account_type"  id="d_64_008_account_type">
  							 	<option value="">��������</option>
  								<option value="1">�ֽ�</option>
  								<option value="2">��ֵ��</option>
  								<option value="3">�ƶ�����ȯ</option>
  								<option value="4">����</option>
  								<option value="5">�̻�����ȯ</option>
  								<option value="6">֧��ר��</option>
  								<option value="7">�Ͱ�ˢ��</option>
  							</select>
								<font class="orange">*</font>
					    </td>
					  </tr>
					  <tr>
					    <td class='blue'>��������</td>
			        <td>
  							<select name="d_64_008_order_type"  id="d_64_008_order_type">
  								<option value="A">����</option>
  								<option value="D">����</option>
  							</select>
								<font class="orange">*</font>
					    </td>
					    <td class='blue'>��������</td>
			        <td>
  							<input name="d_64_008_pay_type" type="text" id="d_64_008_pay_type" value=""  v_must='0' maxlength="10" />
								
					    </td>
					  </tr>
					  <tr>

					    <td class='blue'>��ʼʱ��</td>
			        <td>
										
								<input name="d_64_008_begTime" type="text" id="d_64_008_begTime" value="<%=bMon22%>"  
			        	onclick="WdatePicker({el:'d_64_008_begTime',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"
			        	v_must ='1' maxlength="8" v_type="date" onblur = "checkElement(this)"/>
			        	 			<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_64_008_begTime',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyymmdd)*</font>
										
			        </td>			        <td class='blue'>����ʱ��</td>
			        <td>
									
								<input name="d_64_008_endTime" type="text" id="d_64_008_endTime" value="<%=mon22[0]%>" v_must ='1' 
  							onclick="WdatePicker({el:'d_64_008_endTime',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"  
  							v_must ='1' maxlength="8" v_type="date" onblur = "checkElement(this)"/>
  										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_64_008_endTime',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyymmdd)*</font>
										
										
					    </td>
					  </tr>
					</tbody>				
					
					
					
										<!-- �ֻ�֧�� �Զ��仰�Ѳ�ѯ 64_009 -->
					<tbody id=d_64_009 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>�û��ֻ�����</td>
					      <td colspan="3">
								  <input type="text" name="d_64_009_phone" id="d_64_009_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					      </td>

					  </tr>
					</tbody>
					
					<!-- �ֻ�֧�� ʵ����֤�����ֻ��Ų�ѯ 64_010 -->
					<tbody id=d_64_010 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>�û����֤</td>
			        <td  colspan="3">
  							<input name="d_64_010_idiccid" type="text" id="d_64_010_idiccid" value=""  v_must='1' maxlength="20"/>
								<font class="orange">*</font>
					    </td>

					  </tr>
					</tbody>					
					
					
					<!-- �ֻ�֧�� ��������ϸ��ѯ 64_011 -->
					<tbody id=d_64_011 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>֧������</td>
			        <td>
  							<input name="d_64_011_pay_no" type="text" id="d_64_011_pay_no" value=""  v_must='0' />
								
					    </td>
					    <td class='blue'>����ֵ����</td>
			        <td>
  							<input name="d_64_011_pay_no_n" type="text" id="d_64_011_pay_no_n" value=""  v_must='0' />
								
					    </td>
					  </tr>
					  <tr>
					    <td class='blue'>��Ч��</td>
			        <td>
  							<select name="d_64_011_validate"  id="d_64_011_validate">
  								<option value="0">����</option>
  								<option value="1">90��</option>
  								<option value="2">180��</option>
  							</select>

								<font class="orange">*</font>
					    </td>
					    		    
					    
					    					    <td class='blue'>��ʼʱ��</td>
			        <td>
			        	
			        		<input name="d_64_011_begTime" type="text" id="d_64_011_begTime" value="<%=bMon22%>"  
			        	onclick="WdatePicker({el:'d_64_011_begTime',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"
			        	v_must ='1' maxlength="8" v_type="date" onblur = "checkElement(this)"/>
			        	 			<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_64_011_begTime',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
					 						
										<font class="orange">(yyyymmdd)*</font>
			        </td>	

					  </tr>
					  <tr>

		        <td class='blue'>����ʱ��</td>
			        <td>
									
								<input name="d_64_011_endTime" type="text" id="d_64_011_endTime" value="<%=mon22[0]%>" v_must ='1' 
  							onclick="WdatePicker({el:'d_64_011_endTime',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"  
  							v_must ='1' maxlength="8" v_type="date" onblur = "checkElement(this)"/>
  										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_64_011_endTime',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyymmdd)*</font>
										
										
					    </td>
					    
					    					    <td class='blue'>����������</td>
			        <td>
  							<select name="d_64_011_chn_type"  id="d_64_011_chn_type">
  								<option value="">ȫ��</option>
  								<option value="THD">�ⲿ������</option>
  								<option value="CNM">�ƶ���������</option>
  							</select>
								<font class="orange">*</font>
					    </td>
					    
					  </tr>
					</tbody>					
					
										<!--�ֻ�֧��64 --�û��˻�����ѯ-->
					<tbody id="d_64_001" class="tbody_form" style="display:none">
				   		<tr>
					      <td class='blue'>�û��ֻ�����</td>
					      <td colspan="3">
								  <input type="text" name="d_64_001_phone" id="d_64_001_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1' 
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					      </td>
					    </tr>
					</tbody>
					
					

					<!-- �ֻ�֧��64--�ɻ��ѽ��ײ�ѯ-->
					<tbody id="d_64_002" class="tbody_form" style="display:none">
						<tr>
					    <td class='blue'>֧���ֻ���</td>
					    <td>
								<input type="text" name="d_64_002_phone" id="d_64_002_phone"  value="<%=activePhone%>"  readonly class="InputGrey"  
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					    </td>
					    <td class='blue'>�ɷ��ֻ���</td>
			        <td>
  							<input type="text" name="d_64_002_payPhone" id="d_64_002_payPhone" value=""
  							maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  							onafterpaste="this.value=this.value.replace(/\D/g,'')"
  							onblur = "checkElement(this)"/>
				      </td>
					  </tr>

				    <tr>
			        <td class='blue'>��ѯ��ʼ����</td>
			        <td>
			        	<input name="d_64_002_begTime" type="text" id="d_64_002_begTime" value="<%=bMon22%>" v_must ='1'
			        	onclick="WdatePicker({el:'d_64_002_begTime',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"
			        	v_must ='1'  maxlength="8" v_type="date" onblur = "checkElement(this)"/>
			        	 			<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_64_002_begTime',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyymmdd)*</font>
			        </td>
			        
			        <td class='blue'>��ѯ��ֹ����</td>
			        <td>
  							<input name="d_64_002_endTime" type="text" id="d_64_002_endTime" value="<%=mon22[0]%>" v_must ='1' 
  							onclick="WdatePicker({el:'d_64_002_endTime',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"  
  							v_must ='1' maxlength="8" v_type="date" onblur = "checkElement(this)"/>
  										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_64_002_endTime',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyymmdd)*</font>
			        </td>
				    </tr>

				    <tr>
			        <td class='blue'>�ɷѽ��</td>
				      <td>
  							<input name="d_64_002_payFee" type="text" id="d_64_002_payFee" value=""
  							maxlength="11" onkeyup="this.value=this.value.replace(/-?\d+\.\d+/g,'')" 
  							onafterpaste="this.value=this.value.replace(/-?\d+\.\d+/g,'')"
  							onblur = "checkElement(this)"/>
				      </td>
				      <td class='blue'>�ɷ�����</td>
			        <td>
							  <select id="d_64_002_channel">
								  <option value="">ȫ��</option>
								  <option value="10086">�ƶ��Ż�</option>
								  <option value="139">139����</option>
								  <option value="ATM">�����ն�</option>
								  <option value="BOSS">Ӫҵ��</option>
								  <option value="CMPAY">������</option>
								  <option value="CALL">�ͷ����绰֧��ϵͳ</option>
								  <option value="SMS">����</option>
								  <option value="STK">SIM�����߰�</option>
								  <option value="WAP">����ͨѶ��</option>
								  <option value="SYS">�ֻ�֧��ϵͳƽ̨</option>
								  <option value="FETIO">����</option>
								  <option value="SP">ʡƽ̨</option>
								  <option value="NETAC">�����˻�</option>
								  <option value="NETBK">��������</option>
								  <option value="CAS">�ֻ��ͻ���</option>
								  <option value="SMSBH">ʡBOSS����Ӫҵ��</option>
								  <option value="IVRBH">ʡBOSS����Ӫҵ��</option>
								  <option value="FEIX1">�ƶ����Žɻ���</option>
								  <option value="AHCP">�����ƶ��ֻ�֧������</option>
								  <option value="QSYS">ȫ������</option>
								  <option value="MS24">�����ƶ��̳�</option>
								  <option value="MMSMS">����ȯ���ڳ仰��</option>
								  <option value="MOP">����ƽ̨</option>
							  </select>
			        </td>
				    </tr>
					</tbody>
					
					<!-- �ֻ�֧��64--����ȯ��ѯ-->
					<tbody id="d_64_003" class="tbody_form" style="display:none">
						<tr>
			        <td class='blue'>�ֻ���</td>
			        <td>
  							<input type="text" name="d_64_003_phone" id="d_64_003_phone" value="<%=activePhone%>"  readonly  class="InputGrey" 
  							  v_must ='1' maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')" 
  								onblur = "checkElement(this)"/>
  								<font class="orange">*</font>
					    </td>
					    <td class='blue'>��ѯ��ʼ����</td>
			        <td>
			        	<input name="d_64_003_begTime" type="text" id="d_64_003_begTime" value="<%=bMon22%>"  
			        	onclick="WdatePicker({el:'d_64_003_begTime',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"
			        	v_must ='1' maxlength="8" v_type="date" onblur = "checkElement(this)"/>
			        	 			<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_64_003_begTime',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyymmdd)*</font>
			        </td>
					  </tr>

					  <tr>
			        <td class='blue'>��ѯ��ֹ����</td>
			        <td>
								<input name="d_64_003_endTime" type="text" id="d_64_003_endTime" value="<%=mon22[0]%>" 
								onclick="WdatePicker({el:'d_64_003_endTime',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"   
								v_must ='1' maxlength="8" v_type="date" onblur = "checkElement(this)"/>
  										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_64_003_endTime',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyymmdd)*</font>
					    </td>
					    <td class='blue'>Ӫ����������</td>
			        <td>
  							<select id="d_64_003_tool">
  								<option value="">ȫѡ</option>
  								<option value="0">�����</option>
			        		<option value="1">��ͨ����ȯ</option>
			        		<option value="2">���ֵ���ȯ</option>
			        		<option value="3">�ۿ۵���ȯ</option>
							  </select>
				      </td>
					  </tr>

				    <tr>
				      <td class='blue'>��������</td>
				      <td colspan="3">
							  <select id="d_64_003_trade">
  								<option value="0">����</option>
			        		<option value="1">����</option>
			        		<option value="2">ת��</option>
			        		<option value="3">����</option>
							  </select>
				      </td>
				    </tr>
					</tbody>

					<!-- �ֻ�֧��64--�û�������Ϣ�б��ѯ-->
					<tbody id="d_64_004" class="tbody_form" style="display:none">
						<tr>
			        <td class='blue'>�ֻ���</td>
			        <td>
								<input type="text" name="d_64_004_phone" id="d_64_004_phone" value="<%=activePhone%>"  readonly  class="InputGrey" 
									v_must ='1'  maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')"
									onblur = "checkElement(this);setByName();"/>
								<font class="orange">*</font>
					    </td>
					    
					    <td class='blue'>��ѯ��ʼ����</td>
			        <td>
				        	<input name="d_64_004_begTime" type="text" id="d_64_004_begTime" value="<%=bMon22%>"  
				        	onclick="WdatePicker({el:'d_64_004_begTime',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"
				        	v_must ='1' maxlength="8" v_type="date" onblur = "checkElement(this)"/>
				        			<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_64_004_begTime',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyymmdd)*</font>
				      </td>
					  </tr>
					  
				    <tr>
			        <td class='blue'>��ѯ��ֹ����</td>
			        <td>
							<input name="d_64_004_endTime" type="text" id="d_64_004_endTime" value="<%=mon22[0]%>"  
							onclick="WdatePicker({el:'d_64_004_endTime',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"  
    						v_must ='1' maxlength="8" v_type="date" onblur = "checkElement(this)"/>
  										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_64_004_endTime',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyymmdd)*</font>
				      </td>
				      
				      <td class='blue'>֧������</td>
			        <td>
  							<select id="d_64_004_pay">
  							  <option value="">ȫ��</option>
  								<option value="S">ֱ��֧��</option>
  								<option value="L">Ԥ��Ȩ֧��</option>
  								<option value="C">����֧��</option>
  		        		<option value="B">B2CԤ��Ȩ֧��</option>
  		        		<option value="W">����Э��֧��</option>
  		        		<option value="U">������Э��֧��</option>
  							</select>
  						</td>
				    </tr>
					</tbody>

					<!-- �ֻ�֧��64--�û�������ϸ��Ϣ��ѯ-->
					<tbody id="d_64_005" class="tbody_form" style="display:none">
						<tr>
			        <td class='blue'>�̻����</td>
			        <td>
								<input type="text" name="d_64_005_no" id="d_64_005_no" value="" maxlength="50" 
									v_must ='1' onblur = "checkElement(this)"/>
								<font class="orange">*</font>
			        </td>
			        
			        <td class='blue'>������</td>
			        <td>
								<input type="text" name="d_64_005_order" id="d_64_005_order" value="" maxlength="50"
								v_must='1' onblur="checkElement(this)"/>
								<font class="orange">*</font>
					    </td>
				    </tr>

				    <tr>
			        <td class='blue'>�¶�����</td>
			        <td colspan="3">
			        	<input name="d_64_005_date" type="text" id="d_64_005_date" value="<%=mon22[0]%>" v_must ='1' 
			        	onclick="WdatePicker({el:'d_64_005_date',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"
  			        	maxlength="8" v_type="date" onblur = "checkElement(this)"/>
			        	 			<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_64_005_date',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyymmdd)*</font>
			        </td>
					  </tr>
					</tbody>

					<!-- �ֻ�֧��64--�û���������ʷ��ѯ-->
					<tbody id="d_64_006" class="tbody_form" style="display:none">
						<tr>
			        <td class='blue'>�ֻ���</td>
			        <td>
								<input type="text" name="d_64_006_phone" id="d_64_006_phone" value="<%=activePhone%>"  readonly  class="InputGrey"  v_must ='1' 
									maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')" 
									onblur = "checkElement(this)"/>
				        	<font class="orange">*</font>
				      </td>
				      
				      <td class='blue'>�˻�����</td>
			        <td>
  							<select id="d_64_006_type">
  								<option value="">ȫ��</option>
  								<option value="M">�ֻ�֧�����˻�</option>
				        	<option value="S">�ֻ�֧�����˻�</option>
							  </select>
			        </td>
					  </tr>

				    <tr>
			        <td class='blue'>������ʼ����</td>
			        <td colspan="3">
			        	<input name="d_64_006_date" type="text" id="d_64_006_date" value="<%=mon22[0]%>" v_must ='1' 
			        	onclick="WdatePicker({el:'d_64_006_date',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})" 
			        	maxlength="8" v_type="date" onblur = "checkElement(this)"/>
			        				<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_64_006_date',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyymmdd)*</font>
			        </td>
					  </tr>
					</tbody>
					
	

			
					
					
					
					
					<!-- �ֻ�֧�� ������ϵ��ѯ 64_007 -->
					<tbody id=d_64_007 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>�û��ֻ�����</td>
			        <td>
  							<input name="d_64_007_hone" type="text" id="d_64_007_String" value=""  v_must='1' />
								<font class="orange">*</font>
					    </td>

					  </tr>
					</tbody>
					
					
					
					
					
					
					<!-- ��������72--������������־��ѯ-->
					<tbody id="d_72_001" class="tbody_form" style="display:none">

						<tr>

					        <td class='blue'>�ֻ���</td>

					        <td>

								<input type="text" name="d_72_001_phone" id="d_72_001_phone" value="<%=activePhone%>"  readonly  class="InputGrey"  v_must ='1' 

								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 

								onafterpaste="this.value=this.value.replace(/\D/g,'')" 

								onblur = "checkElement(this)"/>

					        	<font class="orange">*</font>

					        </td>

					        <td class='blue'></td>

					        <td></td>

					    </tr>

					</tbody>
					
					<!--��������72--�㲥��¼��ѯ-->
					
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

					        <td class='blue'>��ʼʱ��</td>
					        <td>
					        	<input name="d_72_002_begTime" type="text" id="d_72_002_begTime" value="<%=bMon%>"  
	                  onclick="WdatePicker({el:'d_72_002_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"					        	
					        	maxlength="19" v_must="1" v_type="date_time" onblur = "checkElement(this)"/>
					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_72_002_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					        </td>
					    </tr>
					    
					    <tr>
					        <td class='blue'>����ʱ��</td>
					        <td>
								<input name="d_72_002_endTime" type="text" id="d_72_002_endTime" value="<%=mon[0]%>"  
								onclick="WdatePicker({el:'d_72_002_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
								maxlength="19" v_must="1" v_type="date_time" onblur = "checkElement(this)"/>

										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_72_002_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					        <td class='blue'>��Ʒ����</td>

					        <td>

								<select id="d_72_002_type">

									<option value="RING">����</option>

					        		<option value="FULL_MUSIC">��������</option>

					        		<option value="SST">������</option>

								</select>

					        </td>

						</tr>

					</tbody>
                    
          <!--��������72--��Ա��ʷ������¼��ѯ-->
					<tbody id="d_72_003" class="tbody_form" style="display:none">
						<tr>
			        <td class='blue'>�û��ֻ�����</td>
			        <td>
  							<input type="text" name="d_72_003_phone" id="d_72_003_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1' 
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
  				      <font class="orange">*</font>
			        </td>

			        <td class='blue'>��ʼʱ��</td>
			        <td>
			        	<input name="d_72_003_begTime" type="text" id="d_72_003_begTime" value="<%=bMon%>"  
			        	onclick="WdatePicker({el:'d_72_003_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
			        	maxlength="19" v_must="1" v_type="date_time" onblur = "checkElement(this)"/>
					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_72_003_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
			        </td>
				    </tr>
					    
					  <tr>
			        <td class='blue'>����ʱ��</td>
			        <td colspan="3">
								<input name="d_72_003_endTime" type="text" id="d_72_003_endTime" value="<%=mon[0]%>"  
								onclick="WdatePicker({el:'d_72_003_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
								maxlength="19" v_must="1" v_type="date_time" onblur = "checkElement(this)"/>
										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_72_003_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					    </td>
						</tr>
					</tbody>
                    
                    <!--��������72--������ʷ������¼��ѯ-->
					<tbody id="d_72_004" class="tbody_form" style="display:none">
						<tr>
			        <td class='blue'>�û��ֻ�����</td>
			        <td>
							  <input type="text" name="d_72_004_phone" id="d_72_004_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1' 
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
				        	<font class="orange">*</font>
				      </td>

			        <td class='blue'>��ʼʱ��</td>
			        <td>
			        	<input name="d_72_004_begTime" type="text" id="d_72_004_begTime" value="<%=bMon%>"  
			        	onclick="WdatePicker({el:'d_72_004_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
			        	maxlength="19" v_must="1" v_type="date_time" onblur = "checkElement(this)"/>
					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_72_004_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
			        </td>
				    </tr>
					    
				    <tr>
			        <td class='blue'>����ʱ��</td>
			        <td colspan="3">
  							<input name="d_72_004_endTime" type="text" id="d_72_004_endTime" value="<%=mon[0]%>"  
  							onclick="WdatePicker({el:'d_72_004_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
  							maxlength="19" v_must="1" v_type="date_time" onblur = "checkElement(this)"/>
										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_72_004_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
				      </td>
						</tr>
					</tbody>
					
					<!--��������72--����������ʷ��¼��ѯ-->
					<tbody id="d_72_005" class="tbody_form" style="display:none">
						<tr>
			        <td class='blue'>�û��ֻ�����</td>
			        <td>
							<input type="text" name="d_72_005_phone" id="d_72_005_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1' 
								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
								onafterpaste="this.value=this.value.replace(/\D/g,'')"
								onblur = "checkElement(this)"/>
				        	<font class="orange">*</font>
				        </td>

				        <td class='blue'>��ʼʱ��</td>
				        <td>
				        	<input name="d_72_005_begTime" type="text" id="d_72_005_begTime" value="<%=bMon%>"  
				        	onclick="WdatePicker({el:'d_72_005_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
				        	maxlength="19" v_must="1" v_type="date_time" onblur = "checkElement(this)"/>
					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_72_005_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
				        </td>
				    </tr>
				    
				    <tr>
				        <td class='blue'>����ʱ��</td>
				        <td colspan="3">
							<input name="d_72_005_endTime" type="text" id="d_72_005_endTime" value="<%=mon[0]%>"  
							onclick="WdatePicker({el:'d_72_005_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
							maxlength="19" v_must="1" v_type="date_time" onblur = "checkElement(this)"/>
										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_72_005_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
				        </td>
						</tr>
					</tbody>
					
					<!--��������72--���嶩����ʷ��¼��ѯ-->
					<tbody id="d_72_006" class="tbody_form" style="display:none">
						<tr>
					        <td class='blue'>�û��ֻ�����</td>
					        <td>
								<input type="text" name="d_72_006_phone" id="d_72_006_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1' 
									maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')"
									onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					        </td>

					        <td class='blue'>��ʼʱ��</td>
					        <td>
					        	<input name="d_72_006_begTime" type="text" id="d_72_006_begTime" value="<%=bMon%>"  
					        	onclick="WdatePicker({el:'d_72_006_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					        	maxlength="19" v_must="1" v_type="date_time" onblur = "checkElement(this)"/>
					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_72_006_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					        </td>
					    </tr>
					    
					    <tr>
					        <td class='blue'>����ʱ��</td>
					        <td colspan="3">
								<input name="d_72_006_endTime" type="text" id="d_72_006_endTime" value="<%=mon[0]%>"  
								onclick="WdatePicker({el:'d_72_006_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
								maxlength="19" v_must="1" v_type="date_time" onblur = "checkElement(this)"/>
										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_72_006_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					        </td>
						</tr>
					</tbody>
                    
                    
                    <!--��������72--����������������ѯ-->
					<tbody id="d_72_007" class="tbody_form" style="display:none">
						<tr>
			        <td class='blue'>�û��ֻ�����</td>
			        <td colspan="3">
								<input type="text" name="d_72_007_phone" id="d_72_007_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1' 
									maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')"
									onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					        </td>
					    </tr>
					</tbody>
					
					<!-- �ֻ���Ƶ82--��������ѯ-->

					<tbody id="d_82_001" class="tbody_form" style="display:none">

						<tr>

					        <td class='blue'>�ֻ���</td>

					        <td>

								<input type="text" name="d_82_001_phone" id="d_82_001_phone" value="<%=activePhone%>"  readonly  class="InputGrey"  v_must ='1'

									 maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 

									 onafterpaste="this.value=this.value.replace(/\D/g,'')"

									 onblur = "checkElement(this)"/>

					        	<font class="orange">*</font>

					        </td>

					        <td class='blue'></td>

					        <td></td>

					    </tr>

					</tbody>

					<!--�ֻ���Ƶ82--��ʷ������ѯ-->

					<tbody id="d_82_002" class="tbody_form" style="display:none">

						<tr>

					        <td class='blue'>�û��ֻ�����</td>

					        <td>

								<input type="text" name="d_82_002_phone" id="d_82_002_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'

								 maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 

								 onafterpaste="this.value=this.value.replace(/\D/g,'')"

								 onblur = "checkElement(this)"/>

					        	<font class="orange">*</font>

					        </td>

					        <td class='blue'>��ʼʱ��</td>

					        <td>

					        	<input name="d_82_002_begTime" type="text" id="d_82_002_begTime" v_must ='1' 
										onclick="WdatePicker({el:'d_82_002_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					        		v_type="date_time" value="<%=bMon%>"  maxlength="19" onblur = "checkElement(this)"/>

					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_82_002_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					    </tr>

					    <tr>

					        <td class='blue'>����ʱ��</td>

					        <td>

								<input name="d_82_002_endTime" type="text" id="d_82_002_endTime" v_must ='1' 
								onclick="WdatePicker({el:'d_82_002_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
									value="<%=mon[0]%>" v_type="date_time" maxlength="19" onblur = "checkElement(this)"/>

										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_82_002_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					        <td class='blue'>��ѯ��������</td>

					        <td>

					        	<select id="d_82_002_type">

									<option value="1">���ղ�ѯ</option>

					        		<option value="2">��ʷ��ѯ</option>

								</select>

							</td>

						</tr>

					</tbody>

					<!--�ֻ���Ƶ82--�㲥��¼��ѯ-->

					<tbody id="d_82_003" class="tbody_form" style="display:none">

						<tr>

					        <td class='blue'>�û��ֻ�����</td>

					        <td>

								<input type="text" name="d_82_003_phone" id="d_82_003_phone" value="<%=activePhone%>"  readonly  class="InputGrey"  

								v_must ='1' maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 

								onafterpaste="this.value=this.value.replace(/\D/g,'')" 

								onblur = "checkElement(this)"/>

					        	<font class="orange">*</font>

					        </td>

					        <td class='blue'>��ʼʱ��</td>

					        <td>

					        	<input name="d_82_003_begTime" type="text" id="d_82_003_begTime" value="<%=bMon%>" 
										onclick="WdatePicker({el:'d_82_003_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					        		v_must ='1' v_type="date_time"  maxlength="19" onblur = "checkElement(this)"/>

					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_82_003_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					    </tr>

					    <tr>

					        <td class='blue'>����ʱ��</td>

					        <td>

								<input name="d_82_003_endTime" type="text" id="d_82_003_endTime" v_must ='1' 
								onclick="WdatePicker({el:'d_82_003_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
									v_type="date_time" value="<%=mon[0]%>"  maxlength="19" onblur = "checkElement(this)"/>

										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_82_003_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					        <td class='blue'>�Ʒ�����</td>

					        <td>

					        	<select id="d_82_003_type">

					        		<option value="0">����</option>
					        		<option value="1">����</option>
					        		<option value="7">���</option>
					        		<option value="13">����</option>
					        		<option value="15">�����</option>
											<option value="16">ƽ̨���²�Ʒ</option>

								</select>

							</td>

						</tr>

					</tbody>

					<!-- �ֻ���Ƶ82--������Ͳ�ѯ-->

					<tbody id="d_82_004" class="tbody_form" style="display:none">

						<tr>

					        <td class='blue'>�ֻ���</td>

					        <td>

								<input type="text" name="d_82_004_phone" id="d_82_004_phone" value="<%=activePhone%>"  readonly  class="InputGrey"  

									v_must ='1' maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 

									onafterpaste="this.value=this.value.replace(/\D/g,'')" 

									onblur = "checkElement(this)"/>

					        	<font class="orange">*</font>

					        </td>

					        <td class='blue'></td>

					        <td></td>

					    </tr>

					</tbody>
						
				    <!-- �ֻ���Ƶ82--�쳣�����û���ѯ-->
					<tbody id="d_82_005" class="tbody_form" style="display:none">
					    <tr>
				        <td class='blue'>�û��ֻ�����</td>
				        <td>
  								<input type="text" name="d_82_005_phone" id="d_82_005_phone" value="<%=activePhone%>"  readonly  class="InputGrey" 
  									v_must ='1' maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  									onafterpaste="this.value=this.value.replace(/\D/g,'')" 
  									onblur = "checkElement(this)"/>
  					        	<font class="orange">*</font>
				        </td>
				        <td class='blue'></td>
				        <td></td>
					    </tr>
					</tbody>
					
					<!-- �ֻ���Ƶ82--ͼ����֤���û���ѯ-->
					<tbody id="d_82_006" class="tbody_form" style="display:none">
					    <tr>
				        <td class='blue'>�û��ֻ�����</td>
				        <td>
  								<input type="text" name="d_82_006_phone" id="d_82_006_phone" value="<%=activePhone%>"  readonly  class="InputGrey" 
  									v_must ='1' maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  									onafterpaste="this.value=this.value.replace(/\D/g,'')" 
  									onblur = "checkElement(this)"/>
  					        	<font class="orange">*</font>
				        </td>
				       
				      </tr>
					</tbody>
					<!-- 2014/08/05 10:04:14 gaopeng �����·�һ���ͷ�ʡ��ҵ��֧��ϵͳ2014��07��������ϸ���Ҫ���֪ͨ
						ʹ�ü�¼��ѯ
					 -->
					<tbody id="d_82_007" class="tbody_form" style="display:none">
							<tr>
					      <td class='blue'>�û��ֻ�����</td>
					      <td colspan="3">
									<input type="text" name="d_82_007_phone" id="d_82_007_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
										 maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
										 onafterpaste="this.value=this.value.replace(/\D/g,'')"
										 onblur = "checkElement(this)"/>
					       	<font class="orange">*</font>
					       </td>
					    </tr>
					    <tr>
									<td class='blue'>��ʼʱ��</td>
					        <td>
					        	<input name="d_82_007_begTime" type="text" id="d_82_007_begTime" v_must ='1' 
					        		onclick="WdatePicker({el:'d_82_007_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
											v_type="date_time" value="<%=bMon%>"  maxlength="19" onblur = "checkElement(this)"/>
					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_82_007_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					        </td>
					        
					        <td class='blue'>����ʱ��</td>
					        <td>
										<input name="d_82_007_endTime" type="text" id="d_82_007_endTime" v_must ='1' 
											onclick="WdatePicker({el:'d_82_007_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
											value="<%=mon[0]%>" v_type="date_time" maxlength="19" onblur = "checkElement(this)"/>
										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_82_007_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					       </td>
					     </tr>
					   </tbody>
					<!-- 2014/08/05 10:04:14 gaopeng �����·�һ���ͷ�ʡ��ҵ��֧��ϵͳ2014��07��������ϸ���Ҫ���֪ͨ
						ҵ���������ѯ
					 -->
					<tbody id="d_82_008" class="tbody_form" style="display:none">
							<tr>
					      <td class='blue'>�û��ֻ�����</td>
					      <td colspan="3">
									<input type="text" name="d_82_008_phone" id="d_82_008_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
										 maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
										 onafterpaste="this.value=this.value.replace(/\D/g,'')"
										 onblur = "checkElement(this)"/>
					       	<font class="orange">*</font>
					       </td>
					    </tr>
					   </tbody>
					   
					   
  	 		
  	 		<!-- �ֻ���Ƶ82--<option value="009">�û��˻���ѯ</option>-->
  	 		
					<tbody id="d_82_009" class="tbody_form" style="display:none">
							<tr>
					      <td class='blue'>�û��˺�</td>
					      <td  >
									<input type="text" name="d_82_009_phone" id="d_82_009_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
										 maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
										 onafterpaste="this.value=this.value.replace(/\D/g,'')"
										 onblur = "checkElement(this)"/>
					       	<font class="orange">*</font>
					       </td>
					    </tr>
					     
					   </tbody>   
					   <!-- �ֻ���Ƶ82--<option value="010">��ֵ��¼��ѯ</option>-->
					<tbody id="d_82_010" class="tbody_form" style="display:none">
							<tr>
					      <td class='blue'>�û��˺�</td>
					      <td  >
									<input type="text" name="d_82_010_phone" id="d_82_010_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
										 maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
										 onafterpaste="this.value=this.value.replace(/\D/g,'')"
										 onblur = "checkElement(this)"/>
					       	<font class="orange">*</font>
					       </td>
					       
					       <td class='blue'>&nbsp;</td>
					      <td >
								 &nbsp;
									 
									 
					       </td>
					    </tr>
					      <tr>
									<td class='blue'>��ʼʱ��</td>
					        <td>
					        	<input name="d_82_010_begTime" type="text" id="d_82_010_begTime" v_must ='1' 
					        		onclick="WdatePicker({el:'d_82_010_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
											v_type="date_time" value="<%=bMon%>"  maxlength="19" onblur = "checkElement(this)"/>
					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_82_010_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					        </td>
					        
					        <td class='blue'>����ʱ��</td>
					        <td>
										<input name="d_82_010_endTime" type="text" id="d_82_010_endTime" v_must ='1' 
											onclick="WdatePicker({el:'d_82_010_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
											value="<%=mon[0]%>" v_type="date_time" maxlength="19" onblur = "checkElement(this)"/>
										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_82_010_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					       </td>
					     </tr>
					   </tbody>   					   
					   
  	 					<!-- �ֻ���Ƶ82--<option value="011">���Ѽ�¼��ѯ</option>-->
					   <tbody id="d_82_011" class="tbody_form" style="display:none">
							<tr>
					      <td class='blue'>�û��ֻ�����</td>
					      <td  colspan="3">
									<input type="text" name="d_82_011_phone" id="d_82_011_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
										 maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
										 onafterpaste="this.value=this.value.replace(/\D/g,'')"
										 onblur = "checkElement(this)"/>
					       	<font class="orange">*</font>
					       </td>
					       
					        
					    </tr>
					      <tr>
									<td class='blue'>��ʼʱ��</td>
					        <td>
					        	<input name="d_82_011_begTime" type="text" id="d_82_011_begTime" v_must ='1' 
					        		onclick="WdatePicker({el:'d_82_011_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
											v_type="date_time" value="<%=bMon%>"  maxlength="19" onblur = "checkElement(this)"/>
					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_82_011_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					        </td>
					        
					        <td class='blue'>����ʱ��</td>
					        <td>
										<input name="d_82_011_endTime" type="text" id="d_82_011_endTime" v_must ='1' 
											onclick="WdatePicker({el:'d_82_011_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
											value="<%=mon[0]%>" v_type="date_time" maxlength="19" onblur = "checkElement(this)"/>
										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_82_011_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					       </td>
					     </tr>
					     
					     <tr>
					      <td class='blue'>�Ʒ�����</td>
					      <td  colspan="3">
								 	<select id="d_82_011_type">


					        		<option value="0">����</option>
					        		<option value="1">����</option>
					        		<option value="7">���</option>
					        		<option value="13">����</option>
					        		<option value="15">�����</option>
											<option value="16">ƽ̨���²�Ʒ</option>
								</select>
					       	<font class="orange">*</font>
					       </td>
					    </tr>
					   </tbody>   					   
					   
					 <!-- ������ 159 001	�û�������������������¼��ѯ-->
					   <tbody id="d_159_001" class="tbody_form" style="display:none">
							<tr>
					      <td class='blue'>�û��ֻ�����</td>
					      <td >
									<input type="text" name="d_159_001_phone" id="d_159_001_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
										 maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
										 onafterpaste="this.value=this.value.replace(/\D/g,'')"
										 onblur = "checkElement(this)"/>
					       	<font class="orange">*</font>
					       </td>
					        <td class='blue'>ҵ�����͹ؼ���</td>
					         <td>
					    <input type="text" name="d_159_001_msgid" id="d_159_001_msgid" value="10020010"  readonly class="InputGrey"  />
										  </td>
										</tr>
					   </tbody>    
					   
					 <!-- ������ 159 	002	������״̬���̲�ѯ-->
					   <tbody id="d_159_002" class="tbody_form" style="display:none">
							<tr>
					      <td class='blue'>�û��ֻ�����</td>
					      <td  >
									<input type="text" name="d_159_002_phone" id="d_159_002_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
										 maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
										 onafterpaste="this.value=this.value.replace(/\D/g,'')"
										 onblur = "checkElement(this)"/>
					       	<font class="orange">*</font>
					       </td>
					        <td class='blue'>ҵ�����͹ؼ���</td>
					        <td>
					    <input type="text" name="d_159_002_msgid" id="d_159_002_msgid" value="10020011"  readonly class="InputGrey"  />
										   </td>
										</tr>
										
										<tr>
					      
					        		<td class='blue'>������</td>
					        		<td colspan="3">
					    					<input type="text" name="d_159_002_order_no" id="d_159_002_order_no" value=""     />
										  </td>
										</tr>
					   </tbody>    
					   
					   					   
					   
					<!-- �ֻ�����40--1���Ŷ�����Ϣ��ѯ-->
					<tbody id="d_40_001" class="tbody_form" style="display:none">
					  <tr>
			        <td class='blue'>�ֻ���</td>
			        <td>
								<input type="text" name="d_40_001_phone" id="d_40_001_phone" value="<%=activePhone%>"  readonly  class="InputGrey" 
									v_must ='1' maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')" 
									onblur = "checkElement(this)"/>
					      <font class="orange">*</font>
					    </td>
					    <td class='blue'></td>
				      <td></td>
				    </tr>
					</tbody>
					
					<!-- �ֻ�����40--2����ȫ����־��ѯ-->
					<tbody id="d_40_002" class="tbody_form" style="display:none">
					  <tr>
			        <td class='blue'>�ֻ���</td>
			        <td>
								<input type="text" name="d_40_002_phone" id="d_40_002_phone" value="<%=activePhone%>"  readonly  class="InputGrey" 
									v_must ='1' maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')" 
									onblur = "checkElement(this)"/>
					      <font class="orange">*</font>
					    </td>
					    <td class='blue'>��ѯ��ʼ����</td>
			        <td>
			        	<input name="d_40_002_begTime" type="text" id="d_40_002_begTime" value="<%=bMon33%>" 
			        	onclick="WdatePicker({el:'d_40_002_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
			        	v_must ='1'  maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>
					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_40_002_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
			        </td>
			    	</tr>
			    	<tr>
			        <td class='blue'>��ѯ��ֹ����</td>
			        <td>
								<input name="d_40_002_endTime" type="text" id="d_40_002_endTime" value="<%=mon[0]%>"  
								onclick="WdatePicker({el:'d_40_002_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
									v_must ='1' maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>
										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_40_002_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					    </td>
					    <td></td>
					    <td></td>
					  </tr>
					</tbody>
					
					<!-- �ֻ�����40--������Կ������־��ѯ-->
					<tbody id="d_40_003" class="tbody_form" style="display:none">
					  <tr>
			        <td class='blue'>�ֻ���</td>
			        <td>
								<input type="text" name="d_40_003_phone" id="d_40_003_phone" value="<%=activePhone%>"  readonly  class="InputGrey" 
									v_must ='1' maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')" 
									onblur = "checkElement(this)"/>
					      <font class="orange">*</font>
					    </td>
					    <td class='blue'>��ѯ��ʼ����</td>
			        <td>
			        	<input name="d_40_003_begTime" type="text" id="d_40_003_begTime" value="<%=bMon33%>" 
			        	onclick="WdatePicker({el:'d_40_003_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
			        	v_must ='1'  maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>
					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_40_003_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
			        </td>
			    	</tr>
			    	<tr>
			        <td class='blue'>��ѯ��ֹ����</td>
			        <td>
								<input name="d_40_003_endTime" type="text" id="d_40_003_endTime" value="<%=mon[0]%>"  
								onclick="WdatePicker({el:'d_40_003_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
									v_must ='1' maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>
										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_40_003_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					    </td>
					    <td class='blue'>��������</td>
					    <td>
								<select id="d_40_003_trade" name="d_40_003_trade">
									<option value="003">������Կ����</option>
			        		<option value="004">ҵ�񶩹�</option>
			        		<option value="005">ҵ��ͨ</option>
			        		<option value="006">GBA��ʼ��</option>
			        		<option value="007">SGҵ������</option>
			        		<option value="008">������Կ����</option>
			        		<option value="009">������ϵ</option>
			        		<option value="010">������ϵ����</option>
			        		<option value="010">������ϵ������־��ѯ</option>
			        		<option value="011">�������¶�����¼��ѯ</option>
								</select>
							</td>
					  </tr>
					</tbody>
					
					<!-- �ֻ�����40--ҵ�񶩹���־��ѯ-->
					<tbody id="d_40_004" class="tbody_form" style="display:none">
					  <tr>
			        <td class='blue'>�ֻ���</td>
			        <td>
								<input type="text" name="d_40_004_phone" id="d_40_004_phone" value="<%=activePhone%>"  readonly  class="InputGrey" 
									v_must ='1' maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')" 
									onblur = "checkElement(this)"/>
					      <font class="orange">*</font>
					    </td>
					    <td class='blue'>��ѯ��ʼ����</td>
			        <td>
			        	<input name="d_40_004_begTime" type="text" id="d_40_004_begTime" value="<%=bMon33%>" 
			        		onclick="WdatePicker({el:'d_40_004_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
			        	v_must ='1'  maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>
					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_40_004_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
			        </td>
			    	</tr>
			    	<tr>
			        <td class='blue'>��ѯ��ֹ����</td>
			        <td>
								<input name="d_40_004_endTime" type="text" id="d_40_004_endTime" value="<%=mon[0]%>"  
								onclick="WdatePicker({el:'d_40_004_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
									v_must ='1' maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>
										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_40_004_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					    </td>
					    <td class='blue'>��������</td>
					    <td>
								<select id="d_40_004_trade" name="d_40_004_trade">
									<option value="003">������Կ����</option>
			        		<option value="004">ҵ�񶩹�</option>
			        		<option value="005">ҵ��ͨ</option>
			        		<option value="006">GBA��ʼ��</option>
			        		<option value="007">SGҵ������</option>
			        		<option value="008">������Կ����</option>
			        		<option value="009">������ϵ</option>
			        		<option value="010">������ϵ����</option>
			        		<option value="010">������ϵ������־��ѯ</option>
			        		<option value="011">�������¶�����¼��ѯ</option>
								</select>
							</td>
					  </tr>
					</tbody>
					
					<!-- �ֻ�����40--ҵ��ͨ��־��ѯ-->
					<tbody id="d_40_005" class="tbody_form" style="display:none">
					  <tr>
			        <td class='blue'>�ֻ���</td>
			        <td>
								<input type="text" name="d_40_005_phone" id="d_40_005_phone" value="<%=activePhone%>"  readonly  class="InputGrey" 
									v_must ='1' maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')" 
									onblur = "checkElement(this)"/>
					      <font class="orange">*</font>
					    </td>
					    <td class='blue'>��ѯ��ʼ����</td>
			        <td>
			        	<input name="d_40_005_begTime" type="text" id="d_40_005_begTime" value="<%=bMon33%>" 
			        	onclick="WdatePicker({el:'d_40_005_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
			        	v_must ='1'  maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>
					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_40_005_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
			        </td>
			    	</tr>
			    	<tr>
			        <td class='blue'>��ѯ��ֹ����</td>
			        <td>
								<input name="d_40_005_endTime" type="text" id="d_40_005_endTime" value="<%=mon[0]%>"  
								onclick="WdatePicker({el:'d_40_005_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
									v_must ='1' maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>
										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_40_005_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					    </td>
					    <td class='blue'>��������</td>
					    <td>
								<select id="d_40_005_trade" name="d_40_005_trade">
									<option value="003">������Կ����</option>
			        		<option value="004">ҵ�񶩹�</option>
			        		<option value="005">ҵ��ͨ</option>
			        		<option value="006">GBA��ʼ��</option>
			        		<option value="007">SGҵ������</option>
			        		<option value="008">������Կ����</option>
			        		<option value="009">������ϵ</option>
			        		<option value="010">������ϵ����</option>
			        		<option value="010">������ϵ������־��ѯ</option>
			        		<option value="011">�������¶�����¼��ѯ</option>
								</select>
							</td>
					  </tr>
					</tbody>
					
					<!-- �ֻ�����40--6GBA��ʼ����־��ѯ-->
					<tbody id="d_40_006" class="tbody_form" style="display:none">
					  <tr>
			        <td class='blue'>�ֻ���</td>
			        <td>
								<input type="text" name="d_40_006_phone" id="d_40_006_phone" value="<%=activePhone%>"  readonly  class="InputGrey" 
									v_must ='1' maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')" 
									onblur = "checkElement(this)"/>
					      <font class="orange">*</font>
					    </td>
					    <td class='blue'>��ѯ��ʼ����</td>
			        <td>
			        	<input name="d_40_006_begTime" type="text" id="d_40_006_begTime" value="<%=bMon33%>" 
			        	onclick="WdatePicker({el:'d_40_006_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
			        	v_must ='1'  maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>
					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_40_006_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
			        </td>
			    	</tr>
			    	<tr>
			        <td class='blue'>��ѯ��ֹ����</td>
			        <td>
								<input name="d_40_006_endTime" type="text" id="d_40_006_endTime" value="<%=mon[0]%>"  
								onclick="WdatePicker({el:'d_40_006_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
									v_must ='1' maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>
										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_40_006_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					    </td>
					    <td class='blue'>��������</td>
					    <td>
								<select id="d_40_006_trade" name="d_40_006_trade">
									<option value="003">������Կ����</option>
			        		<option value="004">ҵ�񶩹�</option>
			        		<option value="005">ҵ��ͨ</option>
			        		<option value="006">GBA��ʼ��</option>
			        		<option value="007">SGҵ������</option>
			        		<option value="008">������Կ����</option>
			        		<option value="009">������ϵ</option>
			        		<option value="010">������ϵ����</option>
			        		<option value="010">������ϵ������־��ѯ</option>
			        		<option value="011">�������¶�����¼��ѯ</option>
								</select>
							</td>
					  </tr>
					</tbody>
					
					<!-- �ֻ�����40--7SGҵ�����غ���־��ѯ-->
					<tbody id="d_40_007" class="tbody_form" style="display:none">
					  <tr>
			        <td class='blue'>�ֻ���</td>
			        <td>
								<input type="text" name="d_40_007_phone" id="d_40_007_phone" value="<%=activePhone%>"  readonly  class="InputGrey" 
									v_must ='1' maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')" 
									onblur = "checkElement(this)"/>
					      <font class="orange">*</font>
					    </td>
					    <td class='blue'>��ѯ��ʼ����</td>
			        <td>
			        	<input name="d_40_007_begTime" type="text" id="d_40_007_begTime" value="<%=bMon33%>" 
			        	onclick="WdatePicker({el:'d_40_007_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
			        	v_must ='1'  maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>
					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_40_007_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
			        </td>
			    	</tr>
			    	<tr>
			        <td class='blue'>��ѯ��ֹ����</td>
			        <td>
								<input name="d_40_007_endTime" type="text" id="d_40_007_endTime" value="<%=mon[0]%>"  
								onclick="WdatePicker({el:'d_40_007_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
									v_must ='1' maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>
										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_40_007_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					    </td>
					    <td class='blue'>��������</td>
					    <td>
								<select id="d_40_007_trade" name="d_40_007_trade">
									<option value="003">������Կ����</option>
			        		<option value="004">ҵ�񶩹�</option>
			        		<option value="005">ҵ��ͨ</option>
			        		<option value="006">GBA��ʼ��</option>
			        		<option value="007">SGҵ������</option>
			        		<option value="008">������Կ����</option>
			        		<option value="009">������ϵ</option>
			        		<option value="010">������ϵ����</option>
			        		<option value="010">������ϵ������־��ѯ</option>
			        		<option value="011">�������¶�����¼��ѯ</option>
								</select>
							</td>
					  </tr>
					</tbody>
					
					<!-- �ֻ�����40--8������Կ������־��ѯ-->
					<tbody id="d_40_008" class="tbody_form" style="display:none">
					  <tr>
			        <td class='blue'>�ֻ���</td>
			        <td>
								<input type="text" name="d_40_008_phone" id="d_40_008_phone" value="<%=activePhone%>"  readonly  class="InputGrey" 
									v_must ='1' maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')" 
									onblur = "checkElement(this)"/>
					      <font class="orange">*</font>
					    </td>
					    <td class='blue'>��ѯ��ʼ����</td>
			        <td>
			        	<input name="d_40_008_begTime" type="text" id="d_40_008_begTime" value="<%=bMon33%>" 
			        	onclick="WdatePicker({el:'d_40_008_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
			        	v_must ='1'  maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>
					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_40_008_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
			        </td>
			    	</tr>
			    	<tr>
			        <td class='blue'>��ѯ��ֹ����</td>
			        <td>
								<input name="d_40_008_endTime" type="text" id="d_40_008_endTime" value="<%=mon[0]%>"  
								onclick="WdatePicker({el:'d_40_008_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
									v_must ='1' maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>
										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_40_008_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					    </td>
					    <td class='blue'>��������</td>
					    <td>
								<select id="d_40_008_trade" name="d_40_008_trade">
									<option value="003">������Կ����</option>
			        		<option value="004">ҵ�񶩹�</option>
			        		<option value="005">ҵ��ͨ</option>
			        		<option value="006">GBA��ʼ��</option>
			        		<option value="007">SGҵ������</option>
			        		<option value="008">������Կ����</option>
			        		<option value="009">������ϵ</option>
			        		<option value="010">������ϵ����</option>
			        		<option value="010">������ϵ������־��ѯ</option>
			        		<option value="011">�������¶�����¼��ѯ</option>
								</select>
								</td>
					  </tr>
					</tbody>
					
					<!-- �ֻ�����40--9������ϵ��־��ѯ-->
					<tbody id="d_40_009" class="tbody_form" style="display:none">
					  <tr>
			        <td class='blue'>�ֻ���</td>
			        <td>
								<input type="text" name="d_40_009_phone" id="d_40_009_phone" value="<%=activePhone%>"  readonly  class="InputGrey" 
									v_must ='1' maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')" 
									onblur = "checkElement(this)"/>
					      <font class="orange">*</font>
					    </td>
					    <td class='blue'>��ѯ��ʼ����</td>
			        <td>
			        	<input name="d_40_009_begTime" type="text" id="d_40_009_begTime" value="<%=bMon33%>" 
			        	onclick="WdatePicker({el:'d_40_009_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
			        	v_must ='1'  maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>
					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_40_009_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
			        </td>
			    	</tr>
			    	<tr>
			        <td class='blue'>��ѯ��ֹ����</td>
			        <td>
								<input name="d_40_009_endTime" type="text" id="d_40_009_endTime" value="<%=mon[0]%>"  
								onclick="WdatePicker({el:'d_40_009_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
									v_must ='1' maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>
										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_40_009_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					    </td>
					    <td class='blue'>��������</td>
					    <td>
								<select id="d_40_009_trade" name="d_40_009_trade">
									<option value="003">������Կ����</option>
			        		<option value="004">ҵ�񶩹�</option>
			        		<option value="005">ҵ��ͨ</option>
			        		<option value="006">GBA��ʼ��</option>
			        		<option value="007">SGҵ������</option>
			        		<option value="008">������Կ����</option>
			        		<option value="009">������ϵ</option>
			        		<option value="010">������ϵ����</option>
			        		<option value="010">������ϵ������־��ѯ</option>
			        		<option value="011">�������¶�����¼��ѯ</option>
								</select>
								</td>
					  </tr>
					</tbody>
					
					<!-- �ֻ�����40--10������ϵ������־��ѯ-->
					<tbody id="d_40_010" class="tbody_form" style="display:none">
					  <tr>
			        <td class='blue'>�ֻ���</td>
			        <td>
								<input type="text" name="d_40_010_phone" id="d_40_010_phone" value="<%=activePhone%>"  readonly  class="InputGrey" 
									v_must ='1' maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')" 
									onblur = "checkElement(this)"/>
					      <font class="orange">*</font>
					    </td>
					    <td class='blue'>��ѯ��ʼ����</td>
			        <td>
			        	<input name="d_40_010_begTime" type="text" id="d_40_010_begTime" value="<%=bMon33%>" 
			        	onclick="WdatePicker({el:'d_40_010_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
			        	v_must ='1'  maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>
					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_40_010_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
			        </td>
			    	</tr>
			    	<tr>
			        <td class='blue'>��ѯ��ֹ����</td>
			        <td>
								<input name="d_40_010_endTime" type="text" id="d_40_010_endTime" value="<%=mon[0]%>"  
								onclick="WdatePicker({el:'d_40_010_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
									v_must ='1' maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>
										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_40_010_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					    </td>
					    <td class='blue'>��������</td>
					    <td>
								<select id="d_40_010_trade" name="d_40_010_trade">
									<option value="003">������Կ����</option>
			        		<option value="004">ҵ�񶩹�</option>
			        		<option value="005">ҵ��ͨ</option>
			        		<option value="006">GBA��ʼ��</option>
			        		<option value="007">SGҵ������</option>
			        		<option value="008">������Կ����</option>
			        		<option value="009">������ϵ</option>
			        		<option value="010">������ϵ����</option>
			        		<option value="010">������ϵ������־��ѯ</option>
			        		<option value="011">�������¶�����¼��ѯ</option>
								</select>
							</td>
					  </tr>
					</tbody>
					
					<!-- �ֻ�����40--11�������¶�����¼��ѯ-->
					<tbody id="d_40_011" class="tbody_form" style="display:none">
					  <tr>
			        <td class='blue'>�ֻ���</td>
			        <td>
								<input type="text" name="d_40_011_phone" id="d_40_011_phone" value="<%=activePhone%>"  readonly  class="InputGrey" 
									v_must ='1' maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')" 
									onblur = "checkElement(this)"/>
					      <font class="orange">*</font>
					    </td>
					    <td></td>
			        <td></td>
			    	</tr>
					</tbody>
					
					<!-- �乾���� �㲥��¼��ѯ 95 001 -->
					<tbody id="d_95_001" class="tbody_form" style="display:none">
					  <tr>
			        <td class='blue'>�û�����</td>
			        <td>
								<input type="text" name="d_95_001_phone" id="d_95_001_phone" value="<%=activePhone%>"  readonly  class="InputGrey" 
									v_must ='1' maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')" 
									onblur = "checkElement(this)"/>
					      <font class="orange">*</font>
					    </td>
					    
					    <td class='blue'>��ʼʱ��</td>
			        <td>
			        	<input name="d_95_001_begTime" type="text" id="d_95_001_begTime" value="<%=bMon%>" 
			        	onclick="WdatePicker({el:'d_95_001_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
			        	v_must ='1' maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>
					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_95_001_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
			        </td>
			    	</tr>
			    	
			    	<tr>
			        <td class='blue'>����ʱ��</td>
			        <td colspan="3">
								<input name="d_95_001_endTime" type="text" id="d_95_001_endTime" value="<%=mon[0]%>"  
								onclick="WdatePicker({el:'d_95_001_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
								  v_must ='1' maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>
										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_95_001_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					    </td>
					  </tr>
					</tbody>
					
					<!-- �乾���� ���¼�¼��ѯ 95 002 -->
					<tbody id="d_95_002" class="tbody_form" style="display:none">
					  <tr>
			        <td class='blue'>�û�����</td>
			        <td>
								<input type="text" name="d_95_002_phone" id="d_95_002_phone" value="<%=activePhone%>"  readonly  class="InputGrey" 
									v_must ='1' maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')" 
									onblur = "checkElement(this)"/>
									<font class="orange">*</font>
					    </td>
					    
					    <td class='blue'>��ʼʱ��</td>
			        <td>
			        	<input name="d_95_002_begTime" type="text" id="d_95_002_begTime" value="<%=bMon%>" 
			        	onclick="WdatePicker({el:'d_95_002_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
			        	v_must ='1' maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>
					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_95_002_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
			        </td>
			    	</tr>
			    	
			    	<tr>
			        <td class='blue'>����ʱ��</td>
			        <td colspan="3">
								<input name="d_95_002_endTime" type="text" id="d_95_002_endTime" value="<%=mon[0]%>"  
								onclick="WdatePicker({el:'d_95_002_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
								  v_must ='1' maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>
										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_95_002_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					    </td>
					  </tr>
					</tbody>
					
					<!-- �乾���� ��������ѯ 95 003 -->
					<tbody id="d_95_003" class="tbody_form" style="display:none">
					  <tr>
			        <td class='blue'>�û�����</td>
			        <td>
								<input type="text" name="d_95_003_phone" id="d_95_003_phone" value="<%=activePhone%>"  readonly  class="InputGrey"  v_must="1"
									maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')" 
									onblur = "checkElement(this)"/>
							  <font class="orange">*</font>
					    </td>
					    
					    <td class='blue'>��������</td>
			        <td>
			        	
			        	<select name="d_95_003_type" id="d_95_003_type" >
			        		<option value="1">����</option>
			        		<option value="2">����</option>
			        		<option value="3">���Ų���</option>
			        		<option value="4">Wap Push</option>
			        		<option value="5">��������</option>
			        		<option value="7">������־�����ţ�</option>
			        		<option value="8">������־�����ţ�</option>
			        		<option value="9">���˲���</option>
			        		<option value="21">���Ƶ㲥</option>
			        		<option value="22">���ư���</option>
			        		<option value="23">������������</option>
			        		<option value="24">���ƻ����ۼ�</option>
			        		<option value="25">���ƹ�������</option>
			        		<option value="26">���Ƹ��˲���</option>
			        	</select>
					    </td>
					    
			    	</tr>
					</tbody>
					
					<!--2014/08/05 8:59:23 gaopeng �����·�һ���ͷ�ʡ��ҵ��֧��ϵͳ2014��07��������ϸ���Ҫ���֪ͨ���������Žӿڣ�
					 �乾���� �쳣��Ϊ�û���ѯ 95 004 
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
			    	</tr>
					</tbody>
					
					<!--2014/08/05 8:59:23 gaopeng �����·�һ���ͷ�ʡ��ҵ��֧��ϵͳ2014��07��������ϸ���Ҫ���֪ͨ���������Žӿڣ�
					 �乾���� �û�����״̬��ѯ 95 005 
					 -->
					<tbody id="d_95_005" class="tbody_form" style="display:none">
					  <tr>
			        <td class='blue'>�û��ֻ�����</td>
			        <td>
								<input type="text" name="d_95_005_phone" id="d_95_005_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must="1"
									maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')" 
									onblur = "checkElement(this)"/>
							  <font class="orange">*</font>
					    </td>
			    	</tr>
					</tbody>
					
					
					<!-- ��������ѯ -->
					<tbody id="d_95_006" class="tbody_form" style="display:none">
						
									    	<tr>
			        <td class='blue'>�û�����</td>
			        <td  colspan="3">
								<input type="text" name="d_95_006_phone" id="d_95_006_phone" value="<%=activePhone%>"  readonly  class="InputGrey" 
									v_must ='1' maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')" 
									onblur = "checkElement(this)"/>
									<font class="orange">*</font>
					    </td>
					    </tr>
					    
					  <tr>
			       
					    
					    <td class='blue'>��ѯ���</td>
			        <td>
			        	<input name="d_95_006_year" type="text" id="d_95_006_year" value="<%=j_year_w%>" maxlength="4" v_must='1' />
					       		 
										<font class="orange">(yyyy)*</font>
			        </td>
			        
			         <td class='blue'>��ѯ�·�</td>
			        <td>
								<select name="d_95_006_month" type="text" id="d_95_006_month" >
									<option <%if("01".equals(j_month_w)) out.print("selected");%> value="01">01</option>
									<option <%if("02".equals(j_month_w)) out.print("selected");%> value="02">02</option>
									<option <%if("03".equals(j_month_w)) out.print("selected");%> value="03">03</option>
									<option <%if("04".equals(j_month_w)) out.print("selected");%> value="04">04</option>
									<option <%if("05".equals(j_month_w)) out.print("selected");%> value="05">05</option>
									<option <%if("06".equals(j_month_w)) out.print("selected");%> value="06">06</option>
									<option <%if("07".equals(j_month_w)) out.print("selected");%> value="07">07</option>
									<option <%if("08".equals(j_month_w)) out.print("selected");%> value="08">08</option>
									<option <%if("09".equals(j_month_w)) out.print("selected");%> value="09">09</option>
									<option <%if("10".equals(j_month_w)) out.print("selected");%> value="10">10</option>
									<option <%if("11".equals(j_month_w)) out.print("selected");%> value="11">11</option>
									<option <%if("12".equals(j_month_w)) out.print("selected");%> value="12">12</option>
							  </select>
								<font class="orange">(mm)*</font>
					    </td>
					  </tr>
			    	
			    	

					</tbody>
	
	
	
	<!--��ֵ��¼��ѯ				-->
					<tbody id="d_95_007" class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>�û��ʺ�</td>
			        <td>
			        	<input name="d_95_007_account" type="text" id="d_95_007_account" value=""  v_must='1' />
					       		 
										<font class="orange">*</font>
			        </td>
			        
			        <td class='blue'>�ʺ�����</td>
			        <td>
			        	<select name="d_95_007_accounttype" type="text" id="d_95_007_accounttype"  />
					       	<option  value="0">�ֻ�����</option>
									<option  value="1">����</option>
							  </select>
										<font class="orange">*</font>
			        </td>
					  </tr>
					  <tr>
			    		<td class='blue'>��ʼʱ��</td>
			        <td>
			        	<input name="d_95_007_begTime" type="text" id="d_95_007_begTime"  value="<%=date_month_3%>"
			        	onclick="WdatePicker({el:'d_95_007_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"
			        	v_must ='1' maxlength="19"   onblur = "checkElement(this)"/>
					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_95_007_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd)*</font>
			        </td>
			    	
			        <td class='blue'>����ʱ��</td>
			        <td >
								<input name="d_95_007_endTime" type="text" id="d_95_007_endTime" value="<%=date_month_0%>"  
								onclick="WdatePicker({el:'d_95_007_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:false})" 
								  v_must ='1' maxlength="19"  onblur = "checkElement(this)"/>
										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_95_007_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:false})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd)*</font>
					    </td>
					  </tr>
			     
					</tbody>
					
					
					<!-- �乾���� �������Ѽ�¼��ѯ 95_008 -->
					<tbody id=d_95_008 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>�û��ʺ�</td>
			        <td>
  							<input name="d_95_008_account" type="text" id="d_95_008_account" value=""  v_must='1' />
								<font class="orange">*</font>
					    </td>
					    <td class='blue'>�ʺ�����</td>
			        <td>
  							<select name="d_95_008_accounttype" type="text" id="d_95_008_accounttype"  />
					       	<option  value="0">�ֻ�����</option>
									<option  value="1">����</option>
							  </select>
								<font class="orange">*</font>
					    </td>
					  </tr>
					  <tr>

					    <td class='blue'>��ʼʱ��</td>
			        <td>
			        	<input name="d_95_008_begTime" type="text" id="d_95_008_begTime"   value="<%=date_month_3+" 00:00:00"%>"
			        	onclick="WdatePicker({el:'d_95_008_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"
			        	v_must ='1' maxlength="19"   onblur = "checkElement(this)"/>
			        	 			<img id = "imgCustStart"
											onclick="WdatePicker({el:'d_95_008_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd)*</font>
			        </td>			        <td class='blue'>����ʱ��</td>
			        <td>
								<input name="d_95_008_endTime" type="text" id="d_95_008_endTime" value="<%=date_time_0_%>"
								onclick="WdatePicker({el:'d_95_008_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:false})"
								v_must ='1' maxlength="19"  onblur = "checkElement(this)"/>
  										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_95_008_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:false})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd)*</font>
					    </td>
					  </tr>
					</tbody>
					
					
				<!-- �乾���� ���Ҵ�����¼��ѯ 95_009 -->
					<tbody id=d_95_009 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>�û��ʺ�</td>
			        <td>
  							<input name="d_95_009_account" type="text" id="d_95_009_account" value=""  v_must='1' />
								<font class="orange">*</font>
					    </td>
					    <td class='blue'>�ʺ�����</td>
			        <td>
  							<select name="d_95_009_accounttype" type="text" id="d_95_009_accounttype"  />
					       	<option  value="0">�ֻ�����</option>
									<option  value="1">����</option>
							  </select>
								<font class="orange">*</font>
					    </td>
					  </tr>
					  <tr>

					    <td class='blue'>��ʼʱ��</td>
			        <td>
			        	<input name="d_95_009_begTime" type="text" id="d_95_009_begTime"   value="<%=date_month_3+" 00:00:00"%>"
			        	onclick="WdatePicker({el:'d_95_009_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"
			        	v_must ='1' maxlength="19"   onblur = "checkElement(this)"/>
			        	 			<img id = "imgCustStart"
											onclick="WdatePicker({el:'d_95_009_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd)*</font>
			        </td>			        <td class='blue'>����ʱ��</td>
			        <td>
								<input name="d_95_009_endTime" type="text" id="d_95_009_endTime" value="<%=date_time_0_%>"
								onclick="WdatePicker({el:'d_95_009_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:false})"
								v_must ='1' maxlength="19"  onblur = "checkElement(this)"/>
  										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_95_009_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:false})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd)*</font>
					    </td>
					  </tr>
					</tbody>
					
					
					
					<!-- �乾���� ���¶�����ϵ��ʷ��¼��ѯ 95_010 -->
					<tbody id=d_95_010 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>�û��ֻ�����/�����ʺ�</td>
			        <td>
  							<input type="text" name="d_95_010_phone" id="d_95_010_phone" value="<%=activePhone%>"  readonly  class="InputGrey"  v_must="1"
									maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')" 
									onblur = "checkElement(this)"/>
							  <font class="orange">*</font>
					    </td>
					    <td >&nbsp;</td>
			        <td>
  							&nbsp;
					    </td>
					  </tr>
					  <tr>

					    <td class='blue'>��ʼʱ��</td>
			        <td>
			 
	<input name="d_95_010_begTime" type="text" id="d_95_010_begTime" value="<%=mon[0]%>" v_must="1"  
								onclick="WdatePicker({el:'d_95_010_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
								  maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>
										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_95_010_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
										
																				
			        </td>			        <td class='blue'>����ʱ��</td>
			        <td>
				
													 
	<input name="d_95_010_endTime" type="text" id="d_95_010_endTime" value="<%=mon[0]%>" v_must="1"  
								onclick="WdatePicker({el:'d_95_010_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
								  maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>
										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_95_010_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
										
					    </td>
					  </tr>
					</tbody>
					
					<!-- �乾���� 011	���Ѽ�¼��ѯ  -->
					<tbody id=d_95_011 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>�û��ֻ�����/�����ʺ�</td>
			        <td>
  							<input type="text" name="d_95_011_phone" id="d_95_011_phone" value="<%=activePhone%>"  readonly  class="InputGrey"  v_must="1"
									maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')" 
									onblur = "checkElement(this)"/>
							  <font class="orange">*</font>
					    </td>
					    <td >&nbsp;</td>
			        <td>
  							&nbsp;
					    </td>
					  </tr>
					  <tr>

					    <td class='blue'>��ʼʱ��</td>
			        <td>
			      
						<input name="d_95_011_begTime" type="text" id="d_95_011_begTime" value="<%=mon[0]%>" v_must="1"  
								onclick="WdatePicker({el:'d_95_011_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
								  maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>
										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_95_011_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
										
																				
			        </td>			        <td class='blue'>����ʱ��</td>
			        <td>
							
										    
						<input name="d_95_011_endTime" type="text" id="d_95_011_endTime" value="<%=mon[0]%>" v_must="1"  
								onclick="WdatePicker({el:'d_95_011_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
								  maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>
										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_95_011_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
										
					    </td>
					  </tr>
					  <tr>
					  <td class='blue'>�շ����</td>
				        <td >
  								<select name = "d_95_011_billinfo" id="d_95_011_billinfo">
  									<option value="0">��ѯ����ѵ�</option>
  									<option value="1">��ѯ��ѵ�</option>
  									<option value="2">��ѯ��Ѻ��շѵ�</option>
  								</select>
				        </td>
				        
				         <td class='blue'>֧����ʽ</td>
				        <td >
  								<select name = "d_95_011_paytype" id="d_95_011_paytype">
  									<option value="0">ȫ��</option>
  									<option value="1">�ֽ�</option>
  									<option value="2">����</option>
  									<option value="2">ҵ����ƽ̨֧�������ƶ���</option>
  									<option value="2">�乾֧����֧�������ƶ���</option>
  								</select>
				        </td>
					  </tr>
					</tbody>
					
					
					<!-- �乾���� 012	�û��˻���ѯ   -->
					<tbody id=d_95_012 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>�û��ֻ�����/�����ʺ�</td>
			        <td>
  							<input type="text" name="d_95_012_phone" id="d_95_012_phone" value="<%=activePhone%>"  readonly  class="InputGrey"  v_must="1"
									maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')" 
									onblur = "checkElement(this)"/>
							  <font class="orange">*</font>
					    </td>
					    <td >&nbsp;</td>
			        <td>
  							&nbsp;
					    </td>
					  </tr>
					  <tr>
					</tbody>
					
					
										
					<!-- �乾���� 013	���������в�ѯ   -->
					<tbody id=d_95_013 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>�û��ֻ�����/�����ʺ�</td>
			        <td>
  							<input type="text" name="d_95_013_phone" id="d_95_013_phone" value="<%=activePhone%>"  readonly  class="InputGrey"  v_must="1"
									maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')" 
									onblur = "checkElement(this)"/>
							  <font class="orange">*</font>
					    </td>
					    <td >&nbsp;</td>
			        <td>
  							&nbsp;
					    </td>
					  </tr>
					  <tr>

					    <td class='blue'>��ʼʱ��</td>
			        <td>
			        	<input name="d_95_013_begTime" type="text" id="d_95_011_begTime"   value="<%=date_month_3+" 00:00:00"%>"
			        	onclick="WdatePicker({el:'d_95_013_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
			        	v_must ='1' maxlength="19"   onblur = "checkElement(this)"/>
			        	 			<img id = "imgCustStart"
											onclick="WdatePicker({el:'d_95_013_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd)*</font>
			        </td>			        <td class='blue'>����ʱ��</td>
			        <td>
								<input name="d_95_013_endTime" type="text" id="d_95_013_endTime" value="<%=date_time_0_%>"
								onclick="WdatePicker({el:'d_95_013_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:false})"
								v_must ='1' maxlength="19"  onblur = "checkElement(this)"/>
  										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_95_013_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:false})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd)*</font>
					    </td>
					  </tr>
					  <tr>
					  <td class='blue'>��/����</td>
				        <td >
  								<select name = "d_95_013_issx" id="d_95_013_issx">
  									<option value="0">ȫ��</option>
  									<option value="1">����</option>
  									<option value="2">����</option>
  								</select>
				        </td>
				        
				         <td class='blue'>�����</td>
				        <td >
  									<input type="text" name="d_95_013_inno" id="d_95_013_inno" value="" v_must ='1' />
				        </td>
					  </tr>
					</tbody>
					
					
					
					<!-- �乾���� 	014	�˲�   -->
					<tbody id=d_95_014 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>�û��ֻ�����/�����ʺ�</td>
			        <td>
  							<input type="text" name="d_95_014_phone" id="d_95_014_phone" value="<%=activePhone%>"  readonly  class="InputGrey"  v_must="1"
									maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')" 
									onblur = "checkElement(this)"/>
							  <font class="orange">*</font>
					    </td>
					     <td class='blue'>ҵ��/����ID</td>
			        <td>
			        	<input type="text" name="d_95_014_busiId" id="d_95_014_busiId" value="" v_must="1"
									maxlength="25"  
									 
									onblur = "checkElement(this)"/>
			        	
										<font class="orange">*</font>
			        </td>			        
					  </tr>
					  <tr>

					    	        
			        <td class='blue'>����ʱ��</td>
			        <td>
							 
										<input name="d_95_014_salTime" type="text" id="d_95_014_salTime" value="<%=mon[0]%>" v_must="1"  
								onclick="WdatePicker({el:'d_95_014_salTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
								  maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>
										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_95_014_salTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
										
					    </td>
					    
					    <td class='blue'>BOSSID</td>
			        <td>
			        	<input type="text" name="d_95_014_bossId" id="d_95_014_bossId" value="" v_must="1"
									maxlength="100"  
									 
									onblur = "checkElement(this)"/>
							  <font class="orange">*</font>
			        </td>		
					  </tr>
					  
					</tbody>					
					
					
					<!-- ͨ���˻�֧����ʷ������ѯ 70 001 -->
					<tbody id="d_70_001" class="tbody_form" style="display:none">
					  <tr>
			        <td class='blue'>�û�����</td>
			        <td>
								<input type="text" name="d_70_001_phone" id="d_70_001_phone" value="<%=activePhone%>"  readonly  class="InputGrey"  v_must="1"
									maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')" 
									onblur = "checkElement(this)"/>
							  <font class="orange">*</font>
					    </td>
					    
					    <td class='blue'>��ʼʱ��</td>
			        <td>
			        	<input name="d_70_001_begTime" type="text" id="d_70_001_begTime" value="<%=bMon%>" v_must="1"
			        	onclick="WdatePicker({el:'d_70_001_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
			        	maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>
					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_70_001_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
			        </td>
			    	</tr>
			    	
			    	<tr>
			        <td class='blue'>����ʱ��</td>
			        <td colspan="3">
								<input name="d_70_001_endTime" type="text" id="d_70_001_endTime" value="<%=mon[0]%>" v_must="1"  
								onclick="WdatePicker({el:'d_70_001_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
								  maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>
										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_70_001_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					    </td>
					  </tr>
					</tbody>
					
					
					<!-- ͨ���˻�֧�� ���������в�ѯ 70_002 -->
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

					    <td class='blue'>��ʼʱ��</td>
			        <td>
			        	<input name="d_70_002_begTime" type="text" id="d_70_002_begTime" value="<%=dateStr1111%>"
			        	onclick="WdatePicker({el:'d_70_002_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"
			        	v_must ='1' maxlength="19"   onblur = "checkElement(this)"/>
			        	 			<img id = "imgCustStart"
											onclick="WdatePicker({el:'d_70_002_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd)*</font>
			        </td>					  </tr>
					  <tr>
			        <td class='blue'>����ʱ��</td>
			        <td>
								<input name="d_70_002_endTime" type="text" id="d_70_002_endTime" value="<%=dateStr1111%>"
								onclick="WdatePicker({el:'d_70_002_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:false})"
								v_must ='1' maxlength="19"  onblur = "checkElement(this)"/>
  										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_70_002_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:false})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd)*</font>
					    </td>
					  </tr>
					</tbody>
					
					<!-- ͨ���˻�֧�� ��������ѯ 70_003 -->
					<tbody id=d_70_003 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>�û��ֻ�����</td>
					      <td>
								  <input type="text" name="d_70_003_phone" id="d_70_003_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					      </td>
					  </tr>
					</tbody>
										<!-- ͨ���˻�֧�� ����ҵ���ѯ 70_004 -->
					<tbody id=d_70_004 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>�û��ֻ�����</td>
					      <td colspan="3">
								  <input type="text" name="d_70_004_phone" id="d_70_004_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					      </td>
 						</tr>
					  <tr>
					    <td class='blue'>��ʼʱ��</td>
			        <td>
			        	<input name="d_70_004_begTime" type="text" id="d_70_004_begTime" value="<%=dateStr1111%>"
			        	onclick="WdatePicker({el:'d_70_004_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"
			        	v_must ='1' maxlength="19"   onblur = "checkElement(this)"/>
			        	 			<img id = "imgCustStart"
											onclick="WdatePicker({el:'d_70_004_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd)*</font>
			        </td>					  
			     
			        <td class='blue'>����ʱ��</td>
			        <td>
								<input name="d_70_004_endTime" type="text" id="d_70_004_endTime" value="<%=dateStr1111%>"
								onclick="WdatePicker({el:'d_70_004_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:false})"
								v_must ='1' maxlength="19"  onblur = "checkElement(this)"/>
  										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_70_004_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:false})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd)*</font>
					    </td>
					  </tr>
					</tbody>
					
					<!-- MobileMarket--MM������������ѯ 41_001-->
					<tbody id="d_41_001" class="tbody_form" style="display:none">
							
				   		<tr>
				        <td class='blue'>�û��ֻ�����</td>
				        <td colspan="3">
  								<input type="text" name="d_41_001_phone" id="d_41_001_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1' 
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
				        </td>
					    </tr>
					</tbody>
					
					<!-- MobileMarket--MM������ϵ��ѯ 41_002-->
					<tbody id="d_41_002" class="tbody_form" style="display:none">
				   		<tr>
				        <td class='blue'>�û��ֻ�����</td>
				        <td >
  								<input type="text" name="d_41_002_phone" id="d_41_002_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1' 
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
				        </td>
				        <td class='blue'>ҵ������</td>
				        <td >
  								<select name = "d_41_002_optype" id="d_41_002_optype">
  									<option value="">-��ѡ��-</option>
  									<option value="0">��ͨȫ��ҵ��</option>
  									<option value="1">��ͨ�㲥��ҵ��(����)</option>
  									<option value="2">��ͨ������ҵ��(����)</option>
  									<option value="10">Ӧ����ȫ��ҵ��</option>
  									<option value="11">Ӧ���ڵ㲥��ҵ�񣨰��Σ�</option>
  									<option value="12">Ӧ���ڶ�����ҵ�񣨰��£�</option>
  								</select>
				        </td>
					    </tr>
					    <tr>
					    	<td class="blue">��ҵ����</td>
					    	<td colspan="3">
					    		<input type="text" name="d_41_002_comNum" id="d_41_002_comNum" value="" v_must ='0' />
					    	</td>
					    </tr>
					     <tr>
									<td class='blue'>��ʼʱ��</td>
					        <td>
					        	<input name="d_41_002_begTime" type="text" id="d_41_002_begTime" v_must ='1' value="<%=datestrsmm%>"
					        		onclick="WdatePicker({el:'d_41_002_begTime',startDate:'%y%M%d',dateFmt:'yyyyMMddHHmmss',alwaysUseStartDate:true})"
											v_type="dateTime" value=""  maxlength="19" onblur = "checkElement(this)"/>
					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_41_002_begTime',startDate:'%y%M%d',dateFmt:'yyyyMMddHHmmss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyymmddhh24miss)*</font>
					        </td>
					        
					        <td class='blue'>����ʱ��</td>
					        <td>
										<input name="d_41_002_endTime" type="text" id="d_41_002_endTime" v_must ='1'  value="<%=dateStr5555%>"
											onclick="WdatePicker({el:'d_41_002_endTime',startDate:'%y%M%d',dateFmt:'yyyyMMddHHmmss',alwaysUseStartDate:true})" 
											value="" v_type="dateTime" maxlength="19" onblur = "checkElement(this)"/>
										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_41_002_endTime',startDate:'%y%M%d',dateFmt:'yyyyMMddHHmmss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyymmddhh24miss)*</font>
					       </td>
					     </tr>
					</tbody>
					
					
					<!-- MobileMarket--�û������쳣��Ϊ�˲� 41_003 -->
						<tbody id="d_41_003" class="tbody_form" style="display:none">
				   		
					     <tr>
									<td class='blue'>��ѯʱ��Σ���ʼ��</td>
					        <td>
										
									<input type="text" name="d_41_003_begTime" id="d_41_003_begTime" value="<%=dangtiankaishi%>"  v_must ='1'
										onclick="WdatePicker({el:'d_41_003_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					        	maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_41_003_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
										
										
					        </td>
					        
					        <td class='blue'>��ѯʱ��Σ�������</td>
					        <td>										
									<input type="text" name="d_41_003_endTime" id="d_41_003_endTime" value="<%=datedangtiande%>"  v_must ='1'
								onclick="WdatePicker({el:'d_41_003_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
								maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_41_003_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
										
										
					       </td>
					     </tr>
					     
					     <tr>
				        <td class='blue'>�û��ֻ�����</td>
				        <td >
  								<input type="text" name="d_41_003_phone" id="d_41_003_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1' 
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
				        </td>
				        <td class='blue'>Ӧ������</td>
				        <td >
  								<input type="text" name="d_41_003_appname" id="d_41_003_appname" value="" v_must ='0' />
				        </td>
					    </tr>
					     
					</tbody>
					
					
					
						<!-- MobileMarket--�û�������������־��ѯ 41_004 -->
						<tbody id="d_41_004" class="tbody_form" style="display:none">
				   		
					     <tr>
									<td class='blue'>��ѯ�·�</td>
					        <td>
										
										<input type="text" name="d_41_004_month" id="d_41_004_month" value="<%=dangtiankaishi%>"  v_must ='1'
										onclick="WdatePicker({el:'d_41_004_month',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					        	maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_41_004_month',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
										
					        </td>
					        
					        <td class='blue'>�û��ֻ�����</td>
				        <td >
  								<input type="text" name="d_41_004_phone" id="d_41_004_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1' 
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
				        </td>
					     </tr>
					     
					</tbody>
					
											<!-- MobileMarket--�û��켣��Ϊ�˲� 41_005 -->
						<tbody id="d_41_005" class="tbody_form" style="display:none">
							
						<td class='blue'>������</td>
			        <td colspan="3">
								<input type="text" name="d_41_005_order" id="d_41_005_order" value="" maxlength="50"
								v_must='1' onblur="checkElement(this)"/>
								<font class="orange">*</font>
					    </td>			   		
					     
					</tbody>
					
					<!-- MobileMarket--�û������޶��ѯ 41_006 -->
					<tbody id="d_41_006" class="tbody_form" style="display:none">
						<tr>
						<td class='blue'>��Ϣ����</td>
			        <td >
								<input type="text" name="d_41_006_type" id="d_41_006_type" value="CCQryMSDNLimitReq" maxlength="50"
								 readOnly  />
					    </td>			
					    
					    <td class='blue'>�汾</td>
			        <td >
								<input type="text" name="d_41_006_version" id="d_41_006_version" value="1.0.0" maxlength="50"
								 readOnly  />
					    </td>	
					   </tr>
					    <tr>
						<td class='blue'>�û��ֻ�����</td>
			        <td colspan="3">
								<input type="text" name="d_41_006_phone" id="d_41_006_phone" value="<%=activePhone%>" maxlength="50"
								 readOnly  />
					    </td>			
					    
					   </tr>
					</tbody>
					
					<!-- MobileMarket--�û�ͼ����֤���ѯ 41_007 -->
					<tbody id="d_41_007" class="tbody_form" style="display:none">
						<tr>
						<td class='blue'>��Ϣ����</td>
			        <td >
								<input type="text" name="d_41_007_type" id="d_41_007_type" value="CCQryGraphicsVerificationReq" maxlength="50"
								 readOnly  />
					    </td>			
					    
					    <td class='blue'>�汾</td>
			        <td >
								<input type="text" name="d_41_007_version" id="d_41_007_version" value="1.0.0" maxlength="50"
								 readOnly  />
					    </td>	
					   </tr>
					    <tr>
						<td class='blue'>�û��ֻ�����</td>
			        <td colspan="3">
								<input type="text" name="d_41_007_phone" id="d_41_007_phone" value="<%=activePhone%>" maxlength="50"
								 readOnly  />
					    </td>			
					    
					   </tr>
					</tbody>
					
					<!-- mdo--IVR�����¼��ѯ-->

					<tbody id="d_99_001" class="tbody_form" style="display:none">

				   		<tr>

					        <td class='blue'>�ֻ�����</td>

					        <td colspan="3">

								<input type="text" name="d_99_001_phone" id="d_99_001_phone" value="<%=activePhone%>"  readonly  class="InputGrey"   

								v_must ='1' maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 

								onafterpaste="this.value=this.value.replace(/\D/g,'')"

								onblur = "checkElement(this)"/>

					        	<font class="orange">*</font>

					        </td>



					    </tr>

					    <tr>
					    			 <td class='blue'>��ʼʱ��</td>

					        <td>

					        	<input type="text" name="d_99_001_begTime" id="d_99_001_begTime" value="<%=date_month_6+" 00:00:00"%>"  v_must ='1'
										onclick="WdatePicker({el:'d_99_001_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					        	maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_99_001_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					        <td class='blue'>����ʱ��</td>

					        <td>

								<input type="text" name="d_99_001_endTime" id="d_99_001_endTime" value="<%=date_time_0_%>"  v_must ='1'
								onclick="WdatePicker({el:'d_99_001_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
								maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_99_001_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>



					    </tr>


					</tbody> 
					
									<!-- mdo--MDO������ϵ��ѯ-->

					<tbody id="d_99_002" class="tbody_form" style="display:none">

				   		<tr>

					        <td class='blue'>�ֻ�����</td>

					        <td>

								<input type="text" name="d_99_002_phone" id="d_99_002_phone" value="<%=activePhone%>"  readonly  class="InputGrey"   

								v_must ='1' maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 

								onafterpaste="this.value=this.value.replace(/\D/g,'')"

								onblur = "checkElement(this)"/>

					        	<font class="orange">*</font>

					        </td>
					        
					        <td class='blue'>��������</td>

					        <td>

					        	<select id="d_99_002_type">
						      		<option value="0">׿��ȫ��</option>
						      		<option value="1">׿������</option>
						      		<option value="2">׿������</option>
						      		<option value="3">����ȫ��</option>	
								</select>

					        </td>


					    </tr>

					    <tr>
					    	
					    	 <td class='blue'>��ʼʱ��</td>

					        <td>

					        	<input type="text" name="d_99_002_begTime" id="d_99_002_begTime" value="<%=date_month_6+" 00:00:00"%>"  v_must ='1'
										onclick="WdatePicker({el:'d_99_002_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					        	maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_99_002_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					        <td class='blue'>����ʱ��</td>

					        <td>

								<input type="text" name="d_99_002_endTime" id="d_99_002_endTime" value="<%=date_time_0_%>"  v_must ='1'
								onclick="WdatePicker({el:'d_99_002_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
								maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_99_002_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>



					    </tr>


					</tbody> 
					
					
					<!-- 139���� 139�����˺���Ϣ��ѯ 62_001 -->
					<tbody id=d_62_001 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>�����˺�</td>
			        <td>
  							<input name="d_62_001_email" type="text" id="d_62_001_email" value=""  v_must='1' />
								<font class="orange">*</font>�û��ֻ�����/ͨ��֤/�������֮һ
					    </td>
					  </tr>
					</tbody>
					<!-- 139���� Ӫ�����ʼ����β�ѯ 62_002 -->
					<tbody id=d_62_002 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>�ֻ�����</td>
					      <td>
								  <input type="text" name="d_62_002_phone" id="d_62_002_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					      </td>

					  </tr>
					</tbody>					
					<!-- �ֻ����� �͵�ͼ������ϵ������ѯ 54_001 -->
					<tbody id=d_54_001 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>�û��ֻ�����</td>
					      <td colspan="3">
								  <input type="text" name="d_54_001_phone" id="d_54_001_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					      </td>
						</tr>
					  <tr>
					    <td class='blue'>��ʼʱ��</td>
			        <td>
			        	<input name="d_54_001_begTime" type="text" id="d_54_001_begTime" value="<%=bMon%>"
			        	onclick="WdatePicker({el:'d_54_001_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
			        	v_must ='1' maxlength="19"   onblur = "checkElement(this)"/>
			        	 			<img id = "imgCustStart"
											onclick="WdatePicker({el:'d_54_001_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
			        </td>
					  
			        <td class='blue'>����ʱ��</td>
			        <td>
								<input name="d_54_001_endTime" type="text" id="d_54_001_endTime" value="<%=bMon%>"
								onclick="WdatePicker({el:'d_54_001_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:false})"
								v_must ='1' maxlength="19"  onblur = "checkElement(this)"/>
  										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_54_001_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:false})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					    </td>

					  </tr>
					</tbody>					
					<!-- �ֻ����� �͵�ͼ������ϵ״̬��ѯ 54_002 -->
					<tbody id=d_54_002 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>�û��ֻ�����</td>
					      <td colspan="3">
								  <input type="text" name="d_54_002_phone" id="d_54_002_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					      </td>
						</tr>
					  <tr>
					    <td class='blue'>��ʼʱ��</td>
			        <td>
			        	<input name="d_54_002_begTime" type="text" id="d_54_002_begTime" value="<%=bMon%>"
			        	onclick="WdatePicker({el:'d_54_002_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
			        	v_must ='1' maxlength="19"   onblur = "checkElement(this)"/>
			        	 			<img id = "imgCustStart"
											onclick="WdatePicker({el:'d_54_002_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
			        </td>
					  
			        <td class='blue'>����ʱ��</td>
			        <td>
								<input name="d_54_002_endTime" type="text" id="d_54_002_endTime" value="<%=bMon%>"
								onclick="WdatePicker({el:'d_54_002_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:false})"
								v_must ='1' maxlength="19"  onblur = "checkElement(this)"/>
  										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_54_002_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:false})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					    </td>

					  </tr>
					</tbody>					
					<!-- �ֻ����� �͵�ͼ������������ѯ 54_003 -->
					<tbody id=d_54_003 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>�û��ֻ�����</td>
					      <td>
								  <input type="text" name="d_54_003_phone" id="d_54_003_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					      </td>
					    <td class='blue'>����</td>
			        <td>
  							<select  name="d_54_003_String"  id="d_54_003_String" >
  								<option value="0">����������</option>
  							</select>
								<font class="orange">*</font>
					    </td>

					  </tr>
					</tbody>					
					
					<!-- 12582ҵ�� ������ʷ��ѯ 130_001 -->
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

					  </tr>
					</tbody>					
					<!-- 12582ҵ�� ���ݶ��ƹ�ϵ��ѯ 130_002 -->
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

					  </tr>
					</tbody>					
					<!-- 12582ҵ�� �·���ʷ��¼��ѯ 130_003 -->
					<tbody id=d_130_003 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>�û��ֻ�����</td>
					      <td>
								  <input type="text" name="d_130_003_phone" id="d_130_003_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					      </td>

					  </tr>
					</tbody>					
					<!-- 12582ҵ�� ҵ���������ѯ 130_004 -->
					<tbody id=d_130_004 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>�û��ֻ�����</td>
					      <td>
								  <input type="text" name="d_130_004_phone" id="d_130_004_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					      </td>

					  </tr>
					</tbody>					
					<!-- 12580ҵ�� 12580������ϵ��ѯ 50_001 -->
					<tbody id=d_50_001 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>�û��ֻ�����</td>
					      <td>
								  <input type="text" name="d_50_001_phone" id="d_50_001_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					      </td>

					  </tr>
					</tbody>
					<!-- 12580ҵ�� ��ʷ��¼��ѯ 50_002 -->
					<tbody id=d_50_002 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>�û��ֻ�����</td>
					      <td>
								  <input type="text" name="d_50_002_phone" id="d_50_002_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					      </td>
					    <td class='blue'>ҵ������</td>
			        <td>
  							<input name="d_50_002_businame" type="text" id="d_50_002_businame" value=""  v_must='1' />
								<font class="orange">*</font>
					    </td>
					  </tr>
					  <tr>
					    <td class='blue'>��������</td>
			        <td>
  							<select name="d_50_002_optype"  id="d_50_002_optype">
  								<option value="0">����</option>
  								<option value="1">�˶�</option>
  							</select>

								<font class="orange">*</font>
					    </td>
					    <td class='blue'>ҵ������</td>
			        <td>
  							<select name="d_50_002_busichn"  id="d_50_002_busichn">
  								<option value="0">��ϯ</option>
  								<option value="1">����</option>
  								<option value="2">BOSS</option>
  								<option value="3">�ͻ�������</option>
  								<option value="4">SIM������</option>
  								<option value="5WAP">����</option>
  								<option value="6">��������</option>
  								<option value="7">����������</option>
  							</select>
								<font class="orange">*</font>
					    </td>

					  </tr>
					</tbody>					
					<!-- 12580ҵ�� �㲥��¼��ѯ 50_003 -->
					<!-- 12580ҵ�� �㲥��¼��ѯ 50_003 -->
					<tbody id=d_50_003 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>�û��ֻ�����</td>
					      <td>
								  <input type="text" name="d_50_003_phone" id="d_50_003_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					      </td>
					    <td class='blue'>ҵ������</td>
			        <td>
  							<input name="d_50_003_String" type="text" id="d_50_003_String" value=""  v_must='1' />
								<font class="orange">*</font>
					    </td>
					  </tr>
					  <tr>
			        <td class='blue'>����ʱ��</td>
			        <td colspan="3">
								<input name="d_50_003_dateTime" type="text" id="d_50_003_dateTime" value="<%=dateStr1111%>"
								onclick="WdatePicker({el:'d_50_003_dateTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:false})"
								v_must ='1' maxlength="19"  onblur = "checkElement(this)"/>
  										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_50_003_dateTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:false})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd)*</font>
					    </td>

					  </tr>
					</tbody>
					<!-- 12590ϵͳƽ̨ �����¼��ѯ 121_001 -->
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
					    <td class='blue'>ҵ������</td>
			        <td>
  							<input name="d_121_001_busiinno" type="text" id="d_121_001_busiinno" value=""   />
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
					</tbody>					
					
					<!-- 12590ϵͳƽ̨ �ͻ���ҵ��ʹ�ò�ѯ 121_002 -->
					<tbody id=d_121_002 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>�û��ֻ�����</td>
					      <td colspan="3">
								  <input type="text" name="d_121_002_phone" id="d_121_002_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					      </td>
					  </tr>
					  <tr>
					    <td class='blue'>��ʼʱ��</td>
			        <td>
			        	<input name="d_121_002_begTime" type="text" id="d_121_002_begTime" value="<%=bMon%>"
			        	onclick="WdatePicker({el:'d_121_002_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
			        	v_must ='1' maxlength="19"   onblur = "checkElement(this)"/>
			        	 			<img id = "imgCustStart"
											onclick="WdatePicker({el:'d_121_002_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
			        </td>

			        <td class='blue'>����ʱ��</td>
			        <td>
								<input name="d_121_002_endTime" type="text" id="d_121_002_endTime" value="<%=bMon%>"
								onclick="WdatePicker({el:'d_121_002_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:false})"
								v_must ='1' maxlength="19"  onblur = "checkElement(this)"/>
  										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_121_002_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:false})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					    </td>

					  </tr>
					</tbody>					
					<!-- 12590ϵͳƽ̨ �û����������в�ѯ 121_003 -->
					<tbody id=d_121_003 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>�û��ֻ�����</td>
					      <td colspan="3">
								  <input type="text" name="d_121_003_phone" id="d_121_003_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
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
					</tbody>										
					<!-- 12590ϵͳƽ̨ ��������ѯ 121_004 -->
					<tbody id=d_121_004 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>�û��ֻ�����</td>
					      <td>
								  <input type="text" name="d_121_004_phone" id="d_121_004_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					      </td>
					    <td class='blue'>����������</td>
			        <td>
  							<select name="d_121_004_blacklisttype"  id="d_121_004_blacklisttype">
  								<option value="1">����ҵ�������</option>
  								<option value="2">�ͻ���ҵ�������</option>
  								<option value="3">����ҵ�������</option>
  							</select>

								<font class="orange">*</font>
					    </td>

					  </tr>
					</tbody>		
					
					
					<!-- ׿��mdo���������� 47_001 -->
					<tbody id=d_47_001 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>�û��ֻ�����</td>
					      <td colspan="3">
								  <input type="text" name="d_47_001_phone" id="d_47_001_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					      </td>
					  </tr>
					  <tr>
					    <td class='blue'>��ʼʱ��</td>
			        <td>
			        	<input name="d_47_001_begTime" type="text" id="d_47_001_begTime" value="<%=date_month_6+" 00:00:00"%>"
			        	onclick="WdatePicker({el:'d_47_001_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
			        	v_must ='1' maxlength="19"   onblur = "checkElement(this)"/>
			        	 			<img id = "imgCustStart"
											onclick="WdatePicker({el:'d_47_001_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
			        </td>

			        <td class='blue'>����ʱ��</td>
			        <td>
								<input name="d_47_001_endTime" type="text" id="d_47_001_endTime" value="<%=date_time_0_%>"
								onclick="WdatePicker({el:'d_47_001_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:false})"
								v_must ='1' maxlength="19"  onblur = "checkElement(this)"/>
  										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_47_001_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:false})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					    </td>

					  </tr>
					</tbody>					
					<!-- ׿��mdo������ϵ��ѯ 47_002 -->
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
					  <tr>
					    <td class='blue'>��ʼʱ��</td>
			        <td>
			        	<input name="d_47_002_begTime" type="text" id="d_47_002_begTime"  value="<%=date_month_6+" 00:00:00"%>"
			        	onclick="WdatePicker({el:'d_47_002_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
			        	v_must ='1' maxlength="19"   onblur = "checkElement(this)"/>
			        	 			<img id = "imgCustStart"
											onclick="WdatePicker({el:'d_47_002_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
			        </td>
			        <td class='blue'>����ʱ��</td>
			        <td>
								<input name="d_47_002_endTime" type="text" id="d_47_002_endTime" value="<%=date_time_0_%>"
								onclick="WdatePicker({el:'d_47_002_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:false})"
								v_must ='1' maxlength="19"  onblur = "checkElement(this)"/>
  										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_47_002_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:false})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					    </td>

					  </tr>
					  
					       <tr>
					  				<td class='blue'>��ѯ����</td>
					        <td colspan="3">

					        	<select id="d_47_002_type">
						      		<option value="0">׿��ȫ��</option>
						      		<option value="1">׿������</option>
						      		<option value="2">׿������</option>
						      		<option value="3">����ȫ��</option>	
								</select>

					        </td>
					   </tr>
					        
					</tbody>										
					<!-- ׿��mdo������ϵ��ѯ 47_003 -->
					<tbody id=d_47_003 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>�û��ֻ�����</td>
					      <td colspan="3">
								  <input type="text" name="d_47_003_phone" id="d_47_003_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					      </td>

					  </tr>
					</tbody>			
					
					
			    <tr id='footer'>
			        <td colspan='4'>
			        	  
			            <input type="button"  id="searchBtn" class='b_foot' value="��ѯ" name="search" />		            
			            <input type="button"  id="clearBtn" class='b_foot' value="����" name="clear" />
			            <input type="button" class="b_foot" id="close" name="close" value="�ر�" onclick="guanbis()"/>
			            <input type="button" id="ivr_backEnd"  name="ivr_backEnd" class="b_foot"  value="�鵵" onClick="goBackEnd();" disabled >	
			            <!--
			            <input type="button" id="ivr_backEnd_temp"  name="ivr_backEnd_temp" class="b_foot"  value="�鵵_��������" onClick="goBackEnd_temp();" >	
			            -->
			        </td>
			    </tr>
				</table>
		</div>

		<IFRAME frameBorder=0 id="resultIframe" name="resultIframe" style="HEIGHT: 400px; overflow-y:auto;WIDTH: 100%; Z-INDEX: 1">
		</IFRAME>
		<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
