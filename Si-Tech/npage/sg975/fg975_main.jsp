<%
  /*
   * ����: Ԥ�湺��-��Լ g975
   * �汾: 1.0
   * ����: 2013/9/2
   * ����: diling
   * ��Ȩ: si-tech
   * update:
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	response.setHeader("Pragma","No-Cache");
  response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0);

	String sale_type = "54";
	String loginNo = (String)session.getAttribute("workNo");
	String loginName = (String)session.getAttribute("workName");
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = (String)session.getAttribute("regCode");
	String groupId = (String)session.getAttribute("groupId");
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	String iPhoneNo = activePhone;
	String op_strong_pwd = (String) session.getAttribute("password");
	//lj. �󶨲���
/*�ж��Ƿ���Ŀ��ͻ�*/
String sqlChkTerm = "  SELECT count(1)  "
	+" FROM DTERMTARGCUST T, DCUSTMSG T1  "
	+" WHERE SYSDATE BETWEEN BEGIN_TIME AND END_TIME  "
	+" AND T.ID_NO = T1.ID_NO  "
	+" AND T.REGION_CODE = :reg_code  "
	+" AND T1.PHONE_NO = :phone_no  ";
String sqlChkParas = "reg_code="+regionCode +" , phone_no="+iPhoneNo ;
String targFlag ="";
System.out.println( "zhangyan~~sqlChkTerm~" + sqlChkTerm );
%>
<wtc:service name="TlsPubSelCrm" outnum="1" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=sqlChkTerm%>"/>
		<wtc:param value="<%=sqlChkParas%>"/>
</wtc:service>
<wtc:array id="rst_targ" scope="end"/>
<%
targFlag = rst_targ[0][0];

/*�����Ŀ��ͻ�,��Ŀ��ͻ����õĻ����*/
String sBrandCode = "NO";
String sResCode = "NO";
if ( !targFlag.equals("0") )
{
	String sqlIsAll = "  SELECT T.BRAND_CODE , t.res_code "
		+" FROM DTERMTARGCUST T, DCUSTMSG T1  "
		+" WHERE SYSDATE BETWEEN BEGIN_TIME AND END_TIME  "
		+" AND T.ID_NO = T1.ID_NO  "
		+" AND T.REGION_CODE = :reg_code  "
		+" AND T1.PHONE_NO = :phone_no  ";
	String sqlParasIsAll = "reg_code="+regionCode +" , phone_no="+iPhoneNo ;
	System.out.println( "zhangyan~~sqlChkTerm~" + sqlChkTerm );
	%>
	<wtc:service name="TlsPubSelCrm" outnum="2" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=sqlIsAll%>"/>
		<wtc:param value="<%=sqlParasIsAll%>"/>
	</wtc:service>
	<wtc:array id="rst_isAll" scope="end"/>
	<%		
	System.out.println( "zhangyan~~~~rst_isAll"+rst_isAll.length );
	System.out.println( "zhangyan~~~~rst_isAll"+rst_isAll[0].length );
	sBrandCode = "";
	sResCode = "";
	
	for (int i = 0 ; i < rst_isAll.length; i ++)
	{
		sBrandCode += " '"+rst_isAll[i][0]+"' ,";
		sResCode += " '"+rst_isAll[i][1]+"' ,";
	}
	System.out.println("zhangyan``````````````"+sBrandCode.indexOf("all"));
	
	sBrandCode = sBrandCode.indexOf("all")==-1?sBrandCode : "all";
	sResCode = sResCode.indexOf("all")==-1?sResCode : "all";
	System.out.println("zhangyan sBrandCode===="+sBrandCode);
	System.out.println("zhangyan  sResCode===="+sResCode);
}

System.out.println( "zhangyan targFlag~~~"+ targFlag );

	String sql_select1 = "SELECT UNIQUE a.brand_code, TRIM (b.brand_name ),  price_save "
		+" FROM dphonesalecode a, schnresbrand b "
		+" WHERE a.region_code = :region_code  "
		+" AND a.brand_code = b.brand_code AND a.valid_flag = 'Y' "
		+" AND a.sale_type = :sale_type ";
	if ( sBrandCode.equals("all") ) /*ȫ���Ŀ��ͻ� , ���Կ���ȫ��Ŀ��ͻ�����*/
	{
		sql_select1 += " AND A.PRICE_SAVE = '1'";
	}
	else if ( sBrandCode.equals("NO") ) /*��Ŀ��ͻ� , ���Կ�����Ŀ��ͻ���ȫ������*/
	{
		sql_select1 += " AND A.PRICE_SAVE = '0'";
	}
	else /*ָ�����Ŀ��ͻ� , ���Կ���ָ��Ŀ��ͻ�����, �ͷ�ָ��Ŀ��ͻ�����*/
	{
		sql_select1 += "   AND ((A.PRICE_SAVE = '1' AND A.BRAND_CODE in ( " 
			+ sBrandCode.substring( 0 , sBrandCode.length() -1 )+" ) ) OR "
			+"(A.PRICE_SAVE = '0' AND A.BRAND_CODE not in ( " 
			+sBrandCode.substring( 0 , sBrandCode.length() -1 )+"  ) )  )";
	}
	
	String srv_params1 = "region_code=" + regionCode + ",sale_type=" + sale_type;
System.out.println( "zhangyan~~sql_select1~" + sql_select1 );
System.out.println( "zhangyan~~srv_params1~" + srv_params1 );
	//��ȡƷ������
%>
	<wtc:service name="TlsPubSelCrm" outnum="3">
		<wtc:param value="<%=sql_select1%>"/>
		<wtc:param value="<%=srv_params1%>"/>
	</wtc:service>
	<wtc:array id="result_brand" scope="end"/>
<%
	StringBuffer brandSb = new StringBuffer("");
	brandSb.append("<option value ='-1' >��ѡ��</option>");
	for(int i=0; i<result_brand.length; i++) {
		  brandSb.append("<option value ='").append(result_brand[i][0]).append("' price_save = '"+result_brand[i][2]+"'  >")
						 .append(result_brand[i][1])
						 .append("</option>");
	}
	
	//��ȡ���е��ֻ��ͺ�
	//lj. �󶨲���
	String sql_select2 = "select unique a.type_code,trim( b.res_name ), b.brand_code , a.price_save"
	+" from dphoneSaleCode a,schnrescode_chnterm b  "
	+" where a.region_code=:region_code and  a.type_code=b.res_code and "
	+" a.brand_code=b.brand_code  and a.valid_flag='Y' " 
	+" and a.sale_type=:sale_type  ";
	
	if ( sResCode.equals("all") ) /*ȫ���Ŀ��ͻ� , ���Կ���ȫ��Ŀ��ͻ�����*/
	{
		sql_select2 += " AND A.PRICE_SAVE = '1'";
	}
	else if ( sResCode.equals("NO") ) /*��Ŀ��ͻ� , ���Կ�����Ŀ��ͻ���ȫ������*/
	{
		sql_select2 += " AND A.PRICE_SAVE = '0'";
	}
	else /*ָ�����Ŀ��ͻ� , ���Կ���ָ��Ŀ��ͻ�����, �ͷ�ָ��Ŀ��ͻ�����*/
	{
		sql_select2 += "   AND ((A.PRICE_SAVE = '1' AND A.type_code in ( "
			+sResCode.substring( 0 , sResCode.length() -1 )+" ) ) OR "
			+"(A.PRICE_SAVE = '0' AND A.type_code not in ( "
			+sResCode.substring( 0 , sResCode.length() -1 )+"  ) ))";			
	}	
	String srv_params2 = "region_code=" + regionCode + ",sale_type=" + sale_type;	
	System.out.println( "zhangyan~~sql_select2~" + sql_select2 );
	System.out.println( "zhangyan~~srv_params2~" + srv_params2 );
	
%>
	<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
			
	<wtc:service name="TlsPubSelCrm" outnum="3">
		<wtc:param value="<%=sql_select2%>"/>
		<wtc:param value="<%=srv_params2%>"/>
	</wtc:service>
	<wtc:array id="result_type" scope="end"/>

<%
  String  inParams [] = new String[2];
  inParams[0] = "select a.offer_id ,a.offer_name "
                 +" from product_offer a,region b,dloginmsg c "
                 +" where a.offer_attr_type ='ZDFL' "
                 +" and a.offer_id = b.offer_id "
                 +" and b.group_id in(select parent_group_id from dchngroupinfo d where c.group_id = d.group_id) "
                 +" and c.login_no =:loginno "
                 +" and c.power_right>= b.right_limit "
                 +" and a.exp_date>sysdate "
                 +" and a.eff_date<sysdate "
                 +" and a.offer_type=40 ";
  inParams[1] = "loginno="+loginNo;
  System.out.println( "zhangyan~~~" + inParams[0]);
%>
  <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2"> 
    <wtc:param value="<%=inParams[0]%>"/>
    <wtc:param value="<%=inParams[1]%>"/> 
  </wtc:service>  
  <wtc:array id="result_limitOfferInfo"  scope="end"/>
<%
  	StringBuffer limitFeeSb = new StringBuffer("");
  	limitFeeSb.append("<option value ='-1'>��ѡ��</option>");
  	if("000000".equals(retCode1)){
  	  if(result_limitOfferInfo.length>0){
      	for(int i=0; i<result_limitOfferInfo.length; i++) {
      		  limitFeeSb.append("<option value ='").append(result_limitOfferInfo[i][0]).append("'>")
      						 .append(result_limitOfferInfo[i][0]+"--"+result_limitOfferInfo[i][1])
      						 .append("</option>");
      	}
  	  }
  	}
  	
%>
<%
	String  inputParsm[] = new String[4];
	inputParsm[0] = iPhoneNo;
	inputParsm[1] = loginNo;
	inputParsm[2] = orgCode;
	inputParsm[3] = opCode;
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
	   retMsg = "s126bInit��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg��" + errMsg;
%>
        <SCRIPT language="JavaScript">
        	rdShowMessageDialog("<%=retMsg%>",0);
          window.location.href="/npage/sg975/fg975_login.jsp?activePhone=<%=iPhoneNo%>&opCode=g975&opName=<%=opName%>";
        </SCRIPT>
<%
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
	    print_note = tempArr[0][25];//��ǰ����
	    contract_flag = tempArr[0][27];//�Ƿ������˻�
	    high_flag = tempArr[0][28];//�Ƿ��и߶��û�
	 }else{%>
		<script language="JavaScript">
			rdShowMessageDialog("���÷���s126bInit����������룺<%=errCode%>��������Ϣ��<%=errMsg%>",0);
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
	if(!code1.equals("000000")&&!code1.equals("0")){%>
		<script language="JavaScript">
			rdShowMessageDialog("��ѯ�ʷ����Ƴ���������룺<%=code1%>��������Ϣ��<%=msg1%>",0);
			history.go(-1);
		</script>
	<%}
	else
	{
		if( resultOffer_name.length>0&&resultOffer_name[0][0]!=null)
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
    var sign = false;
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
			//���õ����ʷѵ������б�
			$('#limit_fee').append("<%=limitFeeSb.toString()%>");
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
					$("#mode_sale").empty();
					reset();
					$('#contract_time').val("-1");
					$('#limit_fee').val("-1");

					$("#phone_type").append('<option value ="-1">��ѡ��</option>');
					$.each(phone_types[brand],function(n,ele){
            $("<option value="+n+"  >"+ele+"</option>").appendTo($("#phone_type"));
					});
				});
				
				/*************************�л��ͺţ���Ҫ����̨������*****************************/
				/* 
			   *  begin  diling update for �ն˺��ʷѷ���Ĳ������� @2013/9/19
			   */
				$('#phone_type').change(function() {
				   //��ѯĿ���û������Ƿ�����������
				   var phoneBrand = $('#phone_brand').val();
				   var phoneType = $('#phone_type').val();
				   var packet = new AJAXPacket("ajax_checkTableDeployed.jsp","���ڻ�������Ϣ�����Ժ�......");
					 var _data = packet.data;
					 _data.add("phoneBrand",phoneBrand);
					 _data.add("phoneType",phoneType);
					 core.ajax.sendPacket(packet,doCheckTableDeployed);
					 packet = null;
				});
				
				function doCheckTableDeployed(package) {
      		var retCode = package.data.findValueByName("retCode");
      		var retMsg = package.data.findValueByName("retMsg");
      		var checkDeployFlay = package.data.findValueByName("checkDeployFlay");//Ŀ���û����Ƿ������ñ�ʶ Y ������ N û����
      		var phoneBrand = $('#phone_brand').val();
				  var phoneType = $('#phone_type').val();
      		if(retCode == "000000") {
      			getParameters();
      			//if(checkDeployFlay=="Y"){ //�������ã���ôֻ�б��е�Ŀ���û����ܰ������û�������������������ݣ���ô���������˶����԰���
              //alert("�����ã�");
              /*
              var packet = new AJAXPacket("ajax_checkGoalUser.jsp","���ڻ�������Ϣ�����Ժ�......");
              var _data = packet.data;
              _data.add("phoneBrand",phoneBrand);
              _data.add("phoneType",phoneType);
              _data.add("iPhoneNo","<%=iPhoneNo%>");
              core.ajax.sendPacket(packet,doCheckGoalUser);
              packet = null;*/
      			//getParameters();
      			//}else{
      			//  //alert("û���ã���������");
      			//  getParameters();
      			//}
      		}else {
      			rdShowMessageDialog("������룺" + retCode + "��������Ϣ��" + retMsg,0);
      			$("#phone_type").val("-1");
      			return false;
      		}
      	}
      	
      	function doCheckGoalUser(package){
      	  var retCode = package.data.findValueByName("retCode");
      		var retMsg = package.data.findValueByName("retMsg");
      		var checkGoalUserFlay = package.data.findValueByName("checkGoalUserFlay");//�����Ƿ����Ŀ���û���ʶ Y ���� N ������
      		if(retCode == "000000") {
      			if(checkGoalUserFlay=="Y"){ //���д��ڴ�Ŀ���û������԰���
      			  //alert("���ڣ�");
              getParameters();
      			}else{//���в����ڣ����ܰ���
      			  //alert("�����ڣ����ܰ���");
      			  rdShowMessageDialog("�û���Ŀ��ͻ������������������ѡ��",1);
      			  $("#phone_type").val("-1");
      			  return false;
      			}
      		}else {
      			rdShowMessageDialog("������룺" + retCode + "��������Ϣ��" + retMsg,0);
      			$("#phone_type").val("-1");
      			return false;
      		}
      	}
      	
      	/* 
         *  end  diling update for �ն˺��ʷѷ���Ĳ������� @2013/9/19
         */
      	
      	/***************** ��ú�Լ�۸��Żݱ�����Ӫ�������롢�ɹ��۸�Ȳ��� ***********************/
      	function getParameters(){
      	  //����ֻ�����
					var typeCode = $('#phone_type').val();
					reset();
					$('#contract_time').val("-1");
					$('#limit_fee').val("-1");

					$('#p3').val($('#phone_type').val());
					/*��ȡ��ز���*/
					 var packet = new AJAXPacket("ajax_getPriceAndPrepay.jsp","���ڻ�������Ϣ�����Ժ�......");
					 var _data = packet.data;
					 _data.add("sale_type","<%=sale_type%>");
					 _data.add("type_code",typeCode);
					 _data.add("targFlag",  $("#targFlag").val());
					 _data.add("sResCode",  $("#sResCode").val());
					 core.ajax.sendPacket(packet,getSaleWaysProcess);
					 packet = null;
      	}
				/*************************�л��ͺţ�ajax���ص�Ӫ����������****************************/
      	function getSaleWaysProcess(package) {
      		var retCode = package.data.findValueByName("retCode");
      		var retMsg = package.data.findValueByName("retMsg");
      		var sale_price = package.data.findValueByName("sale_price");//��Լ�۸�
      		sale_price = parseFloat(sale_price).toFixed(0);
      		var privilege_scale = package.data.findValueByName("prepay_limit");//�Żݱ���

      		var sale_code = package.data.findValueByName("sale_code");//Ӫ��������
      		var cost_price = package.data.findValueByName("cost_price");//�ɹ��۸�
      		if(retCode == "000000") {
      			$("#contract_fee_hidd").val(sale_price);
      			$("#privilege_scale_Hidd").val(privilege_scale);
      			$("#sale_code_Hidd").val(sale_code);
      			$("#cost_price_Hidd").val(cost_price);
      		}else {
      			rdShowMessageDialog("������룺" + retCode + "��������Ϣ��" + retMsg,0);
      			return false;
      		}
      	}
				/*************************�л���Լ���ޣ�У�������Ƿ�ѡ��ȫ�� ******************************/
				$('#contract_time').change(function() {
				    var contract_time = $('#contract_time').val();
						if($('#phone_brand').val()=="-1"){
						  rdShowMessageDialog("��ѡ���ֻ�Ʒ��!");
        			$('#phone_brand').focus();
        			$('#contract_time').val("-1");
        			return false;
						}
						if($('#phone_type').val()=="-1"){
						  rdShowMessageDialog("��ѡ���ֻ�����!");
        			$('#phone_type').focus();
        			$('#contract_time').val("-1");
        			return false;
						}
					  reset();
					  $('#limit_fee').val("-1");
				});
				
				/************************* �л������ʷѣ�У�������Ƿ�ѡ��ȫ��  ************************/
				$('#limit_fee').change(function() {
						var limit_fee = $("#limit_fee").val();
						
						if($('#phone_brand').val()=="-1"){
						  rdShowMessageDialog("��ѡ���ֻ�Ʒ��!");
        			$('#phone_brand').focus();
        			$('#limit_fee').val("-1");
        			return false;
						}
						if($('#phone_type').val()=="-1"){
						  rdShowMessageDialog("��ѡ���ֻ�����!");
        			$('#phone_type').focus();
        			$('#limit_fee').val("-1");
        			return false;
						}
						if($('#contract_time').val()=="-1"){
						  rdShowMessageDialog("��ѡ���Լ�۸�!");
        			$('#contract_time').focus();
        			$('#limit_fee').val("-1");
        			return false;
						}
      			if(limit_fee=="-1"||limit_fee==-1){//��ѡ��
      			  reset();
							return;
      			}else{ //��ȡ�����ʷѵ�����
      			  var packet = new AJAXPacket("ajax_getMonBaseFee.jsp","���ڻ�������Ϣ�����Ժ�......");
              var _data = packet.data;
              _data.add("limit_fee",limit_fee);
              core.ajax.sendPacket(packet,doGetMonBaseFee);
              packet = null;
      			}
				});
				
				function doGetMonBaseFee(package){
          var retCode = package.data.findValueByName("retCode");
          var retMsg = package.data.findValueByName("retMsg");
          var monBaseFee = package.data.findValueByName("monBaseFee");//�����ʷѵ�����

          var contract_fee_hidd = $("#contract_fee_hidd").val();//��Լ�۸�
					var privilege_scale_Hidd = $("#privilege_scale_Hidd").val();//�Żݱ���
		
					var contract_time = $("#contract_time").val();//��Լ����
          var prepay_limit = ""; //����Ԥ��
          var base_fee = ""; //������
          var sale_price = "";//Ӧ�ս��
          if(retCode == "000000") {
            $("#monBaseFee_hidd").val(parseFloat(monBaseFee).toFixed(0));
            $("#contract_fee").val(contract_fee_hidd);
            //����Ԥ��=�����ʷѵ�����*�Żݱ���*��������(��Լ����)
            //alert(monBaseFee+"*"+privilege_scale_Hidd+"*"+contract_time);
            //prepay_limit = parseFloat(monBaseFee*privilege_scale_Hidd*contract_time/100).toFixed(2);
            prepay_limit = parseFloat(parseFloat(monBaseFee*privilege_scale_Hidd/100).toFixed(0)*contract_time);//�г���ȷ�ϣ���ȡ������*��Լ����
            //������=Ӧ�ս��-����Ԥ��
            //�������Ԥ��<=��Լ�۸�ʱ��Ӧ�����ȡ��Լ�ۣ�������=��Լ��-����Ԥ�棻
			//alert ("prepay_limit==="+prepay_limit);
			//alert ("contract_fee_hidd==="+contract_fee_hidd);
            if(parseFloat(prepay_limit)<parseFloat(contract_fee_hidd)||parseFloat(prepay_limit)==parseFloat(contract_fee_hidd)){ 
              sign = false;
              sale_price = parseFloat(contract_fee_hidd).toFixed(0);
              base_fee = parseFloat(contract_fee_hidd) - parseFloat(prepay_limit);    
            }else{ //�������Ԥ��>��Լ��ʱ�� Ӧ�����ȡ����Ԥ�棬������=����Ԥ��-����Ԥ�棻
              sign = true;
              rdShowMessageDialog("�޷�����������ѡ���նˡ����߻��Լ�ڡ�");
              return;
              sale_price = parseFloat(prepay_limit).toFixed(0);
              base_fee = parseFloat(prepay_limit) - parseFloat(prepay_limit);
            }
            $("#prepay_limit").val(prepay_limit);
            $("#sale_price").val(sale_price);
            $("#base_fee").val(base_fee.toFixed(0));
          }else {
            rdShowMessageDialog("������룺" + retCode + "��������Ϣ��" + retMsg,0);
            return false;
          }
				}
				
				//Ĭ������£�����֤IMEI�룬���ܵ���ύ��ť
				$('#next_step').attr('disabled','disabled');
				/*************************�ύ��ťע���¼�****************************/
				$('#next_step').click(function() {
					printCommit();	
				})
				/*************************�����ťע���¼�****************************/
				$('#reset_btn').click(function() {
						$('#phone_brand').val("-1");
						$('#limit_fee').val("-1");
						$('#contract_time').val("-1");
						$('#phone_brand').change();
						$('#IMEINo').val('');
				});
		});
	/*************************����ֻ�����input��ֵ****************************/	
	function reset() {
		$('#sale_name_span').text('');
		$('#contract_fee').val('');
    $('#prepay_limit').val('');
    $('#base_fee').val('');		
    $('#sale_price').val('');
	}

	/*************************��֤IMEI****************************/
	function checkimeino() {
	 if($('#IMEINo').val().length == 0){
      rdShowMessageDialog("IMEI���벻��Ϊ�գ����������� !!");
      document.frm.IMEINo.focus();
      $('#next_step').attr('disabled','disabled');
	 	  return false;
     }
    var flag = check();
    if(!flag){
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
						rdShowMessageDialog("IMEI��У��ɹ�!��",2);
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
		var limit_fee = $('#limit_fee').val();
		var contract_time = $("#contract_time").val();
		if(phone_brand == -1) {
			rdShowMessageDialog("��ѡ���ֻ�Ʒ�ƣ�");
			return false;	
		}else if(phone_type == -1) {
			rdShowMessageDialog("��ѡ���ֻ����ͣ�");
			return false;	
		}else if(contract_time == -1){
		  rdShowMessageDialog("��ѡ���Լ���ޣ�");
			return false;	
		}else if(limit_fee == -1) {
		  rdShowMessageDialog("��ѡ������ʷѣ�");
			return false;
		}
		return true;
	}
	
	
	function printCommit() {
		//ƴ��һϵ�в���
		/*	
		    sale_code_Hidd               Ӫ��������
				phone_brand                  �ֻ�Ʒ��
				phone_type                   �ֻ�����
				sale_price                   Ӧ�ս��
				  0                          �Ԥ��
				prepay_limit/contract_time   ÿ�·������=����Ԥ��/��ͬ����
				monBaseFee_hidd��            �µ�������
				base_fee - 0                 ������-���ֶ�Ӧ��Ǯ��
				contract_time                ��ͬ����
				limit_fee                    �ʷѴ���
				IMEINo                       IMEI��
				cost_price_Hidd-base_fee     �ɱ�����= �ɹ��۸�-������
				  0                          �ֻ����ӷ���������
				prepay_limit                 ����Ԥ��  
		*/
		if (sign){//����Ԥ��>��Լ��
		    rdShowMessageDialog("�޷�����������ѡ���նˡ����߻��Լ�ڡ�");
		    return;
		}
		
		if(!check(document.frm) ) {
			return false;
		}
		getAfterPrompt();
		var retMonFee = parseFloat($('#prepay_limit').val())/parseFloat($('#contract_time').val());
		$("#retMonFee_hidd").val(retMonFee);
		var costFee = parseFloat($("#cost_price_Hidd").val())-parseFloat($("#base_fee").val());//�ɱ�����
		var str=
			$("#sale_code_Hidd").val()+"|"
			+$('#phone_brand').find('option:selected').text()+"|"
			+$('#phone_type').find('option:selected').text()+"|"
			+$('#sale_price').val()+"|"
			+""+"|"
			+parseFloat(retMonFee).toFixed(0)+"|"
			+$('#monBaseFee_hidd').val()+"|"
			+parseFloat($('#base_fee').val()).toFixed(0)+"|"
			+$('#contract_time').val()+"|"
			+$("#limit_fee").val()+"|"
			+$('#IMEINo').val()+"|"
			+parseFloat(costFee).toFixed(0)+"|"
			+""+"|"
			+parseFloat($('#prepay_limit').val()).toFixed(0)+"|";
		$('#iAddStr').val(str);
		document.frm.p3.value = $('#phone_type').find('option:selected').text();
		if($('#phone_brand').val()=="-1"){
		  rdShowMessageDialog("��ѡ���ֻ�Ʒ��!");
			$('#phone_brand').focus();
			$('#limit_fee').val("-1");
			return false;
		}
		if($('#phone_type').val()=="-1"){
		  rdShowMessageDialog("��ѡ���ֻ�����!");
			$('#phone_type').focus();
			$('#limit_fee').val("-1");
			return false;
		}
		if($('#contract_time').val()=="-1"){
		  rdShowMessageDialog("��ѡ���Լ�۸�!");
			$('#contract_time').focus();
			$('#limit_fee').val("-1");
			return false;
		}
		
		if($('#limit_fee').val()=="-1"){
		  rdShowMessageDialog("��ѡ������ʷ�!");
			$('#contract_time').focus();
			$('#limit_fee').val("-1");
			return false;
		}
		
		if (document.all.IMEINo.value.length == 0) {
      rdShowMessageDialog("IMEI���벻��Ϊ�գ����������� !!");
      document.all.IMEINo.focus();
      document.all.next_step.disabled = true;
	 		return false;
     }
     
     var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
    if(typeof(ret)!="undefined"){ 
      if((ret=="confirm")){
        if(rdShowConfirmDialog('ȷ�ϵ��������')==1){
  	      frmCfm();
        }
  	  }
    	if(ret=="continueSub"){
        if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){
  	      frmCfm();
        }
    	}
    }else{
      if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){
        frmCfm();
      }
    }
	}
	
	function showPrtDlg(printType,DlgMessage,submitCfm)
  {  //��ʾ��ӡ�Ի���
     var h=180;
     var w=350;
     var t=screen.availHeight/2-h/2;
     var l=screen.availWidth/2-w/2;
  
    var pType="subprint";             				 	//��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
  	var billType="1";              				 			  //Ʊ�����ͣ�1���������2��Ʊ��3�վ�
  	var sysAccept =<%=loginAccept%>;             	//��ˮ��
  	var printStr = printInfo(printType);			 		//����printinfo()���صĴ�ӡ����
  	var mode_code=null;           							  //�ʷѴ���
  	var fav_code=null;                				 		//�ط�����
  	var area_code=null;             				 		  //С������
  	var opCode="g975" ;                   			 	//��������
  	var phoneNo="<%=activePhone%>";               //�ͻ��绰
  	var iccidInfoStr = "";
  	var accInfoStr = "";
  		iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
  		accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" 
  			+$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();		
  
      var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
      var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
      path+="&mode_code="+mode_code+"&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr+
  			"&fav_code="+fav_code+"&area_code="+area_code+
  			"&opCode="+opCode+"&sysAccept="+sysAccept+
  			"&phoneNo="+document.frm.phoneNo.value+
  			"&submitCfm="+submitCfm+"&pType="+
  			pType+"&billType="+billType+ "&printInfo=" + printStr;
       var ret=window.showModalDialog(path,printStr,prop);
       return ret;
  }
  
  function printInfo(printType)
  {
  	var cust_info="";  				//�ͻ���Ϣ
  	var opr_info="";   				//������Ϣ
  	var note_info1=""; 				//��ע1
  	var note_info2=""; 				//��ע2
  	var note_info3=""; 				//��ע3
  	var note_info4=""; 				//��ע4
  	var retInfo = "";  				//��ӡ����

  	var _retMonFee_hidd = parseFloat($("#retMonFee_hidd").val()).toFixed(0);
  	
  	//opr_info+='<%=loginNo%>'+' '+'<%=loginName%>'+"|";
  	//opr_info+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
  	cust_info+="�ֻ����룺"+document.all.phoneNo.value+"|";
  	cust_info+="�ͻ�������"+document.all.oCustName.value+"|";
  
  	retInfo+=" "+"|";
  	retInfo+=" "+"|";
  	retInfo+=" "+"|";
  	retInfo+=" "+"|";
  	retInfo+=" "+"|";
  	retInfo+=" "+"|";
  	opr_info+="�û�Ʒ�ƣ�"+document.all.oSmName.value+"    ����ҵ��<%=opName%>"+"|";
    opr_info+="ҵ����ˮ��"+document.all.printAccept.value+"|";
    opr_info+="�ֻ��ͺţ�"+$('#phone_type').find('option:selected').text()+"    IMEI�룺"+$("#IMEINo").val()+"|";
  	opr_info+="�ɷѺϼƣ�"+$('#sale_price').val()+"Ԫ  ����Ԥ�滰��"+$("#prepay_limit").val()+"Ԫ��ÿ�·�����"+_retMonFee_hidd+"Ԫ���µ������ѣ�"+$('#monBaseFee_hidd').val()+"Ԫ����Լ�ڣ�"+$("#contract_time").val()+"���¡�"+"|"; 
  
  	//note_info1+="��ע��"+document.all.do_note.value+"|";
  
  	retInfo+=" "+"|";
  	retInfo+=" "+"|";
  	retInfo+=" "+"|";
  	retInfo+=" "+"|";
  	retInfo+=" "+"|";
  	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
  	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
  }
  
  function frmCfm()
  {
  	  document.all.payType.value = document.all.payTypeSelect.value;
  		if(document.all.payType.value=="BX")
    	{
      		/*set �������*/
  				var transerial    = "000000000000";  	                    //����Ψһ�� ������ȡ��
  				var trantype      = "00";         //��������
  				var bMoney        = $('#sale_price').val(); 				//�ɷѽ��
  				if(bMoney.indexOf(".") == -1) bMoney=bMoney+"00";
  				var tranoper      = "<%=loginNo%>";                       //���ײ���Ա
  				var orgid         = "<%=groupId%>";                       //ӪҵԱ��������
  				var trannum       = "<%=activePhone%>";                      //�绰����
  				getSysDate();       /*ȡbossϵͳʱ��*/
  				var respstamp     = document.all.Request_time.value;      //�ύʱ��
  				var transerialold = "";																		//ԭ����Ψһ��,�ڽɷ�ʱ�����
  				var org_code      = "<%=orgCode%>";                       //ӪҵԱ����						
  				CCBCommon(transerial,trantype,bMoney,tranoper,orgid,trannum,respstamp,transerialold,org_code);
  				if(ccbTran=="succ") posSubmitForm();
    	}
  		else if(document.all.payType.value=="BY")
  		{
  				var transType     = "05";					/*�������� */         
  				var bMoney        = $('#sale_price').val();         /*���׽�� */
  				if(bMoney.indexOf(".") == -1) bMoney=bMoney+"00";         
  				var response_time = "";                								 		/*ԭ�������� */				
  				var rrn           = "";                           				/*ԭ����ϵͳ������ */ 
  				var instNum       = "";                                   /*���ڸ������� */     
  				var terminalId    = "";                    								/*ԭ�����ն˺� */			
  				getSysDate();       																			//ȡbossϵͳʱ��                                            
  				var request_time  = document.all.Request_time.value;      /*�����ύ���� */     
  				var workno        = "<%=loginNo%>";                        /*���ײ���Ա */       
  				var orgCode       = "<%=orgCode%>";                       /*ӪҵԱ���� */       
  				var groupId       = "<%=groupId%>";                       /*ӪҵԱ�������� */   
  				var phoneNo       = "<%=activePhone%>";                       /*���׽ɷѺ� */       
  				var toBeUpdate    = "";						                        /*Ԥ���ֶ� */         
  				var posFlag = ICBCCommon(transType,bMoney,response_time,rrn,instNum,terminalId,request_time,workno,orgCode,groupId,phoneNo,toBeUpdate);									
  				if(icbcTran=="succ") posSubmitForm();
  		}else{
  				posSubmitForm();
  		}
  }
  
  function posSubmitForm(){
		frm.submit();
		return true;
	}
  
  function getSysDate()
	{
		var myPacket = new AJAXPacket("../public/pos_getSysDate.jsp","���ڻ��ϵͳʱ�䣬���Ժ�......");
		myPacket.data.add("verifyType","getSysDate");
		core.ajax.sendPacket(myPacket,doSetStsDate);
		myPacket = null;
	}
	function doSetStsDate(packet){
		var verifyType = packet.data.findValueByName("verifyType");
		var sysDate = packet.data.findValueByName("sysDate");
		if(verifyType=="getSysDate"){
			document.all.Request_time.value = sysDate;
			return false;
		}
	}
	function padLeft(str, pad, count)
	{
			while(str.length<count)
			str=pad+str;
			return str;
	}
	function getCardNoPingBi(cardno)
	{
			var cardnopingbi = cardno.substr(0,6);
			for(i=0;i<cardno.length-10;i++)
			{
				cardnopingbi=cardnopingbi+"*";
			}
			cardnopingbi=cardnopingbi+cardno.substr(cardno.length-4,4);
			return cardnopingbi;
	}
//-->
</script>
</head>
<body>
  <form name="frm" method="post" action="fg975_cfm.jsp">
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
				<td class="blue">��Լ����</td>
				<td> 
					<select id="contract_time" name="contract_time">
					  <option value="-1" checked>��ѡ��</option>
            <option value="6">6</option>
						<option value="12">12</option>
						<option value="18">18</option>	
						<option value="24">24</option>							  
					</select>
				</td>
				<td class="blue">�����ʷ� </td>
				<td> 
					<select id="limit_fee" style="width:200px">
					</select>
				</td>
			</tr> 
			<tr>
			  <td class="blue">��Լ�۸�</td>
				<td width="39%">
					<input class="InputGrey" type="text" name="contract_fee" id="contract_fee" readonly />
				</td>
				<td class="blue">����Ԥ��</td>
				<td>
					<input name="prepay_limit" type="text" class="InputGrey" id="prepay_limit"  readonly />
					<input name="mon_prepay_limit" type="hidden" class="InputGrey" id="mon_prepay_limit"  readonly />
					<input name="mon_base_fee" type="hidden" class="InputGrey" id="mon_base_fee"  readonly />
				</td>
			</tr>
			<tr>
			  <td class="blue">������</td>
				<td width="39%">
					<input class="InputGrey" type="text" id="base_fee" name="base_fee" readonly />
				</td>
				<td class="blue">Ӧ�ս��</td>
				<td width="39%">
					<input class="InputGrey" type="text" id="sale_price" name="sale_price" readonly />
					<input class="InputGrey" type="hidden" id="sale_price_source" name="sale_price_source" readonly />
				</td>
			</tr>
			<tr>
				<td class="blue">IMEI��</td>
		        <td colspan="3">
					<input name="IMEINo" id="IMEINo" class="button" type="text" v_type="0_9" v_name="IMEI��"  maxlength=15 value="" onblur="viewConfirm()">
					<input name="checkimei" class="b_text" type="button" value="У��" onclick="checkimeino()" >
		          	<font color="orange">*</font>
		        </td>
			</tr>
						<TR id=showHideTr >
  			<TD class="blue">
  				<div align="left">����ʱ��</div>
        </TD>
  			<TD >
  				<input name="payTime" type="text" v_name="����ʱ��"  value="<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>">
  				(������)<font color="orange">*</font>
  			<TD class="blue">
  				<div align="left">����ʱ��</div>
  			</TD>
  			<TD >
  				<input name="repairLimit" v_type="date.month"  size="10" type="text" value="12" onblur="viewConfirm()">
  				(����)<font color="orange">*</font>
  			</TD>
      </TR>
			<tr>
				<td class="blue">
					<div align="left">�ɷѷ�ʽ</div>
				</td>
				<td colspan="3">
					<select name="payTypeSelect" id="payTypeSelect" >
						<option value="0" checked>�ֽ�ɷ�</option>
						<option value="BX">��������POS���ɷ�</option>
						<option value="BY">��������POS���ɷ�</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="blue">������ע</td>
				<td colspan="3">
					<input name="do_note" type="text" size="80" id="do_note" value="" maxlength="60"/>
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
			<input type="hidden" name="sale_kind" value="">
			<input type="hidden" name="main_phoneno" value="">
			<input type="hidden" name="printAccept" value="<%=loginAccept%>">
			<input type="hidden" name="opName" value="<%=opName%>">
			
			<input type="hidden" name="privilege_scale_Hidd" id="privilege_scale_Hidd" value="" />
			<input type="hidden" name="sale_code_Hidd" id="sale_code_Hidd" value="" />
			<input type="hidden" name="contract_fee_hidd" id="contract_fee_hidd" value="" />
			<input type="hidden" name="monBaseFee_hidd" id="monBaseFee_hidd" value="" />
			<input type="hidden" name="retMonFee_hidd" id="retMonFee_hidd" value="" />
			<input type="hidden" name="cost_price_Hidd" id="cost_price_Hidd" value="" />
			<input type="hidden" name="p3" id="p3" value=""><!--�ֻ��ͺ�-->
			<input type="hidden" name="opCode" value="<%=opCode%>">
			
			<!-- pos�� begin-->		
			<input type="hidden" name="payType"  value=""><!-- �ɷ����� payType=BX �ǽ��� payType=BY �ǹ��� -->			
			<input type="hidden" name="MerchantNameChs"  value=""><!-- �Ӵ˿�ʼ����Ϊ���в��� -->
			<input type="hidden" name="MerchantId"  value="">
			<input type="hidden" name="TerminalId"  value="">
			<input type="hidden" name="IssCode"  value="">
			<input type="hidden" name="AcqCode"  value="">
			<input type="hidden" name="CardNo"  value="">
			<input type="hidden" name="BatchNo"  value="">
			<input type="hidden" name="Response_time"  value="">
			<input type="hidden" name="Rrn"  value="">
			<input type="hidden" name="AuthNo"  value="">
			<input type="hidden" name="TraceNo"  value="">
			<input type="hidden" name="Request_time"  value="">
			<input type="hidden" name="CardNoPingBi"  value="">
			<input type="hidden" name="ExpDate"  value="">
			<input type="hidden" name="Remak"  value="">
			<input type="hidden" name="TC"  value="">
			<input type="hidden" id = "targFlag" name="targFlag"  value="<%=targFlag%>">
			<input type="hidden" id = "sBrandCode" name="sBrandCode"  value="<%=sBrandCode%>">
			<input type="hidden" id = "sResCode" name="sResCode"  value="<%=sResCode%>">
			<!-- pos�� end-->	
</div>
		  <%@ include file="/npage/include/footer.jsp" %>
	</form>
	<%@ include file="/npage/public/posCCB.jsp" %>
	<%@ include file="/npage/public/posICBC.jsp" %>
</body>
</html>
