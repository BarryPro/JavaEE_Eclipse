<%
/********************
 
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa)2016-3-24 11:01:59------------------
 

 -------------------------��̨��Ա��wangzc��zuolf--------------------------------------------
 
********************/
%>
              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%
	String opCode        = WtcUtil.repNull(request.getParameter("opCode"));
  String opName        = WtcUtil.repNull(request.getParameter("opName"));
  
  String workNo    = (String)session.getAttribute("workNo");
  String password  = (String)session.getAttribute("password");
  String workName  = (String)session.getAttribute("workName");
  String orgCode   = (String)session.getAttribute("orgCode");
  String ipAddrss  = (String)session.getAttribute("ipAddr");
  String regionCode = (String)session.getAttribute("regCode");
	String currentDate = "";
	
	String param = "select to_char(sysdate,'yyyyMMdd HH24:mi:ss') as currentDate from dual";
%>
  <wtc:service name="TlsPubSelCrm" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=param%>" />
	</wtc:service>
	<wtc:array id="result_currentDate" scope="end"   />

<%	
	if(result_currentDate.length>0){
		currentDate = result_currentDate[0][0];
	}
	
	System.out.println("--hejwa------fm359_1.jsp----AAAAAAAAAAA-----Currentdate--AAAAAAAAAAA----------->"+currentDate);
	
	java.util.Calendar cal = java.util.Calendar.getInstance(); 
	cal.add(Calendar.MONTH, 1); 
	cal.set(Calendar.DATE, 1); 
	String n_month_Date = new java.text.SimpleDateFormat("yyyyMMdd 00:00:00").format(new java.util.Date(cal.getTimeInMillis()));
	String vChkFlag = "";
	String phoneNo_207 = "";
 
	System.out.println("--hejwa---------------currentDate------------->"+currentDate);
	
	String paraAray1[] = new String[8];
	
	paraAray1[0] = "";                                       //��ˮ
	paraAray1[1] = "01";                                     //��������
	paraAray1[2] = opCode;                                   //��������
	paraAray1[3] = (String)session.getAttribute("workNo");   //����
	paraAray1[4] = (String)session.getAttribute("password"); //��������
	paraAray1[5] = activePhone;                            //�û�����
	paraAray1[6] = "";       
	paraAray1[7] = "3";    
	
%> 
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAcceptl" /> 
		
  <wtc:service name="sm357Qry" outnum="12" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=paraAray1[0]%>" />
		<wtc:param value="<%=paraAray1[1]%>" />	
		<wtc:param value="<%=paraAray1[2]%>" />
		<wtc:param value="<%=paraAray1[3]%>" />
		<wtc:param value="<%=paraAray1[4]%>" />
		<wtc:param value="<%=paraAray1[5]%>" />
		<wtc:param value="<%=paraAray1[6]%>" />
		<wtc:param value="<%=paraAray1[7]%>" />	
	</wtc:service>
	<wtc:array id="result_t2" scope="end"  />
		
<%
	
	String j_ProdCode = "";
	String j_ProdName = "";
	String j_GearCode = "";
	String j_GearName = "";
	String j_group_id = "";
	
	String j_offer_flag = "";
	String j_offer_type = "";//G�������࣬D:�����ں���
	
	String j_EFF_DATE = "";
	String j_EXP_DATE = "";
	String sp_type = "";
	
	if("000000".equals(code)){
		if(result_t2.length>0){
			j_ProdCode = result_t2[0][1];
			j_ProdName = result_t2[0][0];
			j_GearCode = result_t2[0][3];
			j_GearName = result_t2[0][2];
			j_group_id = result_t2[0][4];
			j_offer_flag = result_t2[0][5];
			j_offer_type = result_t2[0][9];
			
			j_EFF_DATE = result_t2[0][7];
			j_EXP_DATE = result_t2[0][8];
			sp_type = result_t2[0][11];
			
		}
		
		System.out.println("--hejwa---------------j_offer_type------------->"+j_offer_type);
		if("D".equals(j_offer_type)){
%>
<SCRIPT language=JavaScript>
	location = "fm359_2.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhoneNo=<%=activePhone%>";
</SCRIPT>	
<%		
		}
 
	}else{
%>
<SCRIPT language=JavaScript>
	rdShowMessageDialog("sm357Qry����<%=code%>��<%=msg%>");
	removeCurrentTab();
</SCRIPT>
<%}

	//��ѯ����ӽ�ɫ
	String paraAray2[] = new String[11];
	paraAray2[0] = "";                                       //��ˮ
	paraAray2[1] = "01";                                     //��������
	paraAray2[2] = opCode;                                   //��������
	paraAray2[3] = (String)session.getAttribute("workNo");   //����
	paraAray2[4] = (String)session.getAttribute("password"); //��������
	paraAray2[5] = activePhone;                            //�û�����
	paraAray2[6] = "";       
	paraAray2[7] = "4";    	
	paraAray2[8] = j_ProdCode;    	
	paraAray2[9] = j_GearCode;    	
	paraAray2[10] = j_group_id;    	

%>


  <wtc:service name="sm357Qry" outnum="9" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=paraAray2[0]%>" />
		<wtc:param value="<%=paraAray2[1]%>" />	
		<wtc:param value="<%=paraAray2[2]%>" />
		<wtc:param value="<%=paraAray2[3]%>" />
		<wtc:param value="<%=paraAray2[4]%>" />
		<wtc:param value="<%=paraAray2[5]%>" />
		<wtc:param value="<%=paraAray2[6]%>" />
		<wtc:param value="<%=paraAray2[7]%>" />	
		<wtc:param value="<%=paraAray2[8]%>" />	
		<wtc:param value="<%=paraAray2[9]%>" />	
		<wtc:param value="<%=paraAray2[10]%>" />				
	</wtc:service>
	<wtc:array id="result_t3" scope="end"  />
		
<%
	//���ݵ�λ�����ѯ�ʷ�
		 String paraAray3[] = new String[8];
						paraAray3[0] = "";                                       //��ˮ
						paraAray3[1] = "01";                                     //��������
						paraAray3[2] = opCode;                                   //��������
						paraAray3[3] = (String)session.getAttribute("workNo");   //����
						paraAray3[4] = (String)session.getAttribute("password"); //��������
						paraAray3[5] = activePhone;                            //�û�����
						paraAray3[6] = "";       
						paraAray3[7] = j_GearCode;    	
%>
  <wtc:service name="sm358Qry" outnum="17" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=paraAray3[0]%>" />
		<wtc:param value="<%=paraAray3[1]%>" />	
		<wtc:param value="<%=paraAray3[2]%>" />
		<wtc:param value="<%=paraAray3[3]%>" />
		<wtc:param value="<%=paraAray3[4]%>" />
		<wtc:param value="<%=paraAray3[5]%>" />
		<wtc:param value="<%=paraAray3[6]%>" />
		<wtc:param value="<%=paraAray3[7]%>" />	
	</wtc:service>
	<wtc:array id="result_t4" scope="end"  />


<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<script language="javascript" type="text/javascript" src="/npage/public/json2.js"></script>	
<SCRIPT language=JavaScript>
var returnValue = "<%=sp_type%>";
var vChkFlag_j = "<%=vChkFlag%>";

var j_EFF_DATE = "";

//����ˢ��ҳ��
function reSetThis(){
	  location = location;	
}

function check_offer(bt){
	var j_t_v_CodeValue     = $(bt).attr("v_CodeValue");
	var j_t_v_ClssName      = $(bt).attr("v_ClssName");
	var j_t_v_BPopedomCode  = $(bt).attr("v_BPopedomCode");
	
	
	var c_flag = false;
	var temp_v_OfferName = "";
	$("#offer_table").find("input[type='checkbox']").each(function(){
		var e_CodeValue     = $(this).attr("v_CodeValue");
		var e_BPopedomCode  = $(this).attr("v_BPopedomCode");
		
		if($(this).is(":checked")&&j_t_v_CodeValue==e_CodeValue&&e_BPopedomCode!=j_t_v_BPopedomCode){//�˷�������ѡ�еģ������Լ�
			temp_v_OfferName = $(this).attr("v_OfferName");
			c_flag = true;
			return false;
		}
	});
	
	if(c_flag){
		rdShowMessageDialog(j_t_v_ClssName+"��������ѡ��"+temp_v_OfferName+"��");
		$(bt).removeAttr("checked");
	}
}

function show_offer_det(outClssName,offer_name,offer_desc,offer_sum){
	  var h     = 400;
    var w     = 880;
    var t     = screen.availHeight/2-h/2;
    var l     = screen.availWidth/2-w/2;
    var prop  = "dialogHeight:"+h+"px;dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
    var tpath = "/npage/sm358/fm358_2.jsp"+
    												"?outClssName="+outClssName+//
    												"&offer_name="+offer_name+//
    												"&offer_desc="+offer_desc+
    												"&offer_sum="+offer_sum+
    												"&opCode=<%=opCode%>"+
    												"&opName=<%=opName%>";
    var ret   = window.showModalDialog(tpath,"",prop);
}

function go_check_OfferSum(){
   var packet = new AJAXPacket("fm358_3.jsp","���Ժ�...");
        packet.data.add("opCode","<%=opCode%>");//
        packet.data.add("phoneNo","<%=activePhone%>");//
        packet.data.add("inPrePayFee",$("#span_OfferSum").text().trim());//
    core.ajax.sendPacket(packet,do_check_OfferSum);
    packet =null;
}
//��ѯ�ͻ�������Ϣ�ص�
function do_check_OfferSum(packet){
    var error_code = packet.data.findValueByName("code");//���ش���
    var error_msg =  packet.data.findValueByName("msg");//������Ϣ

    if(error_code=="000000"){//�����ɹ�
      rdShowMessageDialog("Ԥ��У��ɹ�",2);
      $("#btn_check_OfferSum").attr("disabled","disabled");
    }else{//���÷���ʧ��
    	rdShowMessageDialog("Ԥ��У��ʧ�ܣ�"+error_code+"��"+error_msg,0);
    }
}
 

function cen_radio_all(bt){
	$(bt).parent().parent().find("input[type='radio']").removeAttr("checked");
	if("N"==$("#offer_table").find("input[type='radio'][v_ClssName='ħ�ٺ�']").attr("v_IsOrder")){
		if($(bt).parent().parent().find("input[type='radio']").attr("v_ClssName")=="ħ�ٺ�"){
			$("tr[name='mobaihegroup']").hide();
		}
	}
	
	//�ǲ���12�����ڰ���� ֻ�г���12���� �ſ���ȡ��
	if("Y"==$(bt).parent().parent().find("input[type='radio'][v_ClssName='ħ�ٺ�']").attr("v_IsOrder")){
		var j_v_EffDate = $("#offer_table").find("input[type='radio'][v_ClssName='ħ�ٺ�']").attr("v_EffDate");
		var currentDate = "<%=currentDate%>".substring(0,8);
		
		if(j_v_EffDate.length>8){
			j_v_EffDate = j_v_EffDate.substring(0,8);
			
			var date1 = parseInt(j_v_EffDate.substring(0,4)) * 12 + parseInt(j_v_EffDate.substring(4,6));
			var date2 = parseInt(currentDate.substring(0,4)) * 12 + parseInt(currentDate.substring(4,6));
			//alert("j_v_EffDate = "+j_v_EffDate+"\ncurrentDate = "+currentDate);
			
			/* if(Math.abs(date2 - date1)<12){
				rdShowMessageDialog("ħ�ٺ�ֻ�г���12���²ſ���ȡ��");
				$("#offer_table").find("input[type='radio'][v_ClssName='ħ�ٺ�']").attr("checked","checked");
			} */
			
		}
		
	}
}



function go_cfm(){
	
	var t_flag     = false;
	var t_ClssName = "";
	$("#offer_table tr:gt(0)").each(function(){
		var t_OfferFlag = $(this).attr("v_OfferFlag");
		if("0"==t_OfferFlag){
			if($(this).find("input[type='radio']:checked").size()==0){
				t_flag     = true;
				t_ClssName = $(this).find("td:eq(0)").text().trim();
				return false;
			}
		}
	});
	
	var submitFlag=false;
	if(!$("tr[name='mobaihegroup']").is(":hidden")){
		if(!subFlag){
			rdShowMessageDialog("imeiУ��û��ͨ���������ύ!");
			submitFlag=true;
		}
		
 
		
	}
	if(submitFlag){
		return false;
	}
	
	
	if(t_flag){
		rdShowMessageDialog("����["+t_ClssName+"]����ѡ��һ���ʷ�");
		return;
	}
 
		var DEPOSIT_FEE = "";
		if(!$("tr[name='mobaihegroup']").is(":hidden")){
			if(typeof($("#mobaiheyajin").val())!="undefined"){
				DEPOSIT_FEE = $("#mobaiheyajin").val().trim();
			}
			
			if(is_show_mobaihe!="Y"){
				DEPOSIT_FEE = "0";
			}
		}
		var OPR_INFO_json = {
												"PHONE_NO":"<%=activePhone%>",
								        "OP_CODE": "<%=opCode%>",
								        "LOGIN_NO": "<%=workNo%>",
								        "LOGIN_ACCEPT": "<%=sysAcceptl%>",
								        "BACK_ACCEPT": "",
								        "OPR_TIME": "<%=currentDate%>",
								        "PROD_CODE":"<%=j_ProdCode%>",//��Ʒ����
        								"PROD_CODE_DW":"<%=j_GearCode%>",//��λ����
        								"OP_NOTE":"��ͥ��Ʒ���",//������ע
        								"GROUP_ID":"<%=j_group_id%>",
        								"PROD_CODE_NDW":"<%=j_GearCode%>",
        								"SP_TYPE":returnValue,
        								"DEPOSIT_FEE":DEPOSIT_FEE
											};


		//����ӽ�ɫ����־λΪY��ƴһ����¼
		var BASELINE_INFO_json = [];
		
		$("#old_mem_table tr:gt(0)").each(function(){
			
			
			if($(this).find("td:eq(6)").text().trim()=="Y"){//�±�7�ı�־λ
				var t_BASELINE_INFO_json = {
					 			"OPERATE_TYPE": "1",
                "HOME_PHONE": "<%=phoneNo_207%>",
                "MASTER_PHONE": "<%=activePhone%>",
                "MEMBER_PHONE": $(this).find("td:eq(0)").text().trim(),
                "GROUP_ID": "<%=j_group_id%>",
                "EFF_DATE": "",
                "EXP_DATE": $(this).find("td:eq(4)").text().trim()
									 
				};
				BASELINE_INFO_json.push(t_BASELINE_INFO_json);
			}
		});
		
		
		var ADD_OFFER_LIST_json  = [];
    var SP_OFFER_LIST_json   = [];
    
    var LOGINOPR_json = [];
    var MAIN_OFFER_LIST_json = [];
		
		var temp_json = {"PHONE_NO":"<%=activePhone%>"};
    LOGINOPR_json.push(temp_json);
    
    var count_change = 0;
    var sp_offer_flag = false;
    
		$("#offer_table").find("input[type='radio']").each(function(){
			if($(this).is(":checked")){//����ѡ�еĵ�ѡ��
				
				var t_v_CodeName = $(this).attr("v_CodeName");//ƴ�ڵ������
				
				var t_PHONE_NO = "";
				
				//һ����ɫ��ʶ�� �ý�ɫ��ʶȥ��������б����ҵ���Ӧ��ɫ�ĺ���
					var t_v_CodeId = $(this).attr("v_CodeId");
					$("#old_mem_table tr:gt(0)").each(function(){
						var e_role_code = $(this).find("td:eq(1)").text().trim();
						if(t_v_CodeId==e_role_code){
							t_PHONE_NO = $(this).find("td:eq(0)").text().trim();
							return false;
						}
					});
				
				
				var offer_id_t   = $(this).attr("v_BPopedomCode");
		 		var t_v_IsOrder  = $(this).attr("v_IsOrder");//�Ƿ�ΪĬ��ѡ�б�־λ
		 		
				if(t_v_IsOrder=="Y"){//Ĭ��ѡ�л���ѡ�еģ����仯
					
				}else{//�ҵ�������Ĭ��ѡ�е�offeridƴ�˶��ڵ�
					
					var old_offer_id = $(this).parent().find("input[type='radio'][v_IsOrder='Y']").attr("v_BPopedomCode");
					//3�����ͽڵ㣬��Ҫ�ж�
					if(t_v_CodeName=="ADD_OFFER_LIST"){
						
						//����
						var t_temp_json={
										"OPERATE_TYPE": "I",
		                "PHONE_NO": t_PHONE_NO,
		                "EFF_DATE": "<%=n_month_Date%>",
		                "EXP_DATE": "20500101 00:00:00",
		                "OFFER_ID": offer_id_t
						};
						
						ADD_OFFER_LIST_json.push(t_temp_json);
						
						//ȡ��
						if(typeof(old_offer_id)!="undefined"&&old_offer_id!=""&&old_offer_id!="undefined"){
							var t_temp_json={
										"OPERATE_TYPE": "U",
		                "PHONE_NO": t_PHONE_NO,
		                "EFF_DATE": "",
		                "EXP_DATE": "<%=n_month_Date%>",
		                "OFFER_ID": old_offer_id
							};
							
							ADD_OFFER_LIST_json.push(t_temp_json);
						}
						 
						
					}else if(t_v_CodeName=="MAIN_OFFER_LIST"){
						var t_temp_json={
		                "PHONE_NO": t_PHONE_NO,
		                "EFF_DATE": "<%=n_month_Date%>",
		                "EXP_DATE": "20500101 00:00:00",
		                "OFFER_ID": $(this).attr("v_BPopedomCode")
						};
						
						MAIN_OFFER_LIST_json.push(t_temp_json);
					}else if(t_v_CodeName=="SP_OFFER_LIST"){
						 
						$("#old_mem_table").find("td[name='rolename']").each(function(i){
							
							if($(this).text()=="�����Ա"){
								CFM_LOGIN=$("#old_mem_table").find("td[name='phonenumber']").eq(i).text();
							}
						});

						//������Ĭ��δѡ�в�����
						//�ҵ�ħ�ٺϵ�ѡ��
						var mbh_v_IsOrder = $("#offer_table").find("input[type='radio'][v_ClssName='ħ�ٺ�']").attr("v_IsOrder");
						
						var SPID = "";
						var BIZCODE = "";
						var STBID = "";
						var ADDRESS = "";
						var CFM_LOGIN="";
						
						
						if("1"==J_count_result){
							SPID    = "";
							BIZCODE = "";
							STBID   = "";
	    				}else{
							if(mbh_v_IsOrder=="N"){
								 SPID=$("#sp_id").val().trim();
								 BIZCODE=$("#biz_code").val().trim();
								 STBID=$("#stb_id").val().trim();
								
								if(SPID==""){
									rdShowMessageDialog("��ѡ����ҵ����!");
									sp_offer_flag=true;
								}
								else if(BIZCODE==""){
									rdShowMessageDialog("��ѡ��ҵ�����!");
									sp_offer_flag=true;
								}
								else if(STBID==""||STBID.length<15){
									rdShowMessageDialog("IMEI�벻��Ϊ��,��Ϊ15λ!");
									sp_offer_flag=true;
								}
							}
						}
						
						
						
						$("#old_mem_table").find("td[name='rolename']").each(function(i){
							if($(this).text()=="�����Ա"){
								CFM_LOGIN=$("#old_mem_table").find("td[name='phonenumber']").eq(i).text();
							}
						});
						var t_temp_json={
										 "OPERATE_TYPE": "I",//I�������� U�����˶�
			                "MEMBER_PHONE": t_PHONE_NO,//��Ա����
			                "MASTER_PHONE":"<%=activePhone%>",//�����˺���
			                "OFFER_ID": $(this).attr("v_BPopedomCode"),//�ʷѴ���
			                "EFF_DATE": "<%=currentDate%>",
			                "EXP_DATE": "20500101 00:00:00",
			                "SPID":SPID,//��ҵ����
			                "BIZCODE":BIZCODE,//ҵ�����
			                "STBID":STBID,//������ID
			                "CFM_LOGIN":CFM_LOGIN//����˺�
						};					
						SP_OFFER_LIST_json.push(t_temp_json);
					
						 //ȡ��
						if(typeof(old_offer_id)!="undefined"&&old_offer_id!=""&&old_offer_id!="undefined"){
								var t_temp_json={
											 "OPERATE_TYPE": "U",//I�������� U�����˶�
				                "MEMBER_PHONE": t_PHONE_NO,//��Ա����
				                "MASTER_PHONE":"<%=activePhone%>",//�����˺���
				                "OFFER_ID": old_offer_id,//�ʷѴ���
				                "EFF_DATE": "",
				                "EXP_DATE": "<%=n_month_Date%>"
							};					
							SP_OFFER_LIST_json.push(t_temp_json);
						}
					 
					}
					count_change ++;
				}
				
			}
		});
		
		
		//һ����ȫȡ�����������
		$("#offer_table tr:gt(0)").each(function(){
				var checkradio_num = $(this).find("input[type='radio'][checked]").size();
				if(checkradio_num==0){//����û�е�ѡ��ѡ��
					//����Ĭ��ѡ�е�
					var old_radio_obj = $(this).find("input[type='radio'][v_IsOrder='Y']");
						
					if(old_radio_obj==null||old_radio_obj.size()==0){
						
					}else{
						var t_v_CodeName  = old_radio_obj.attr("v_CodeName");//ƴ�ڵ������
						var old_offer_id  = old_radio_obj.attr("v_BPopedomCode");
						var t_PHONE_NO = "";
						//һ����ɫ��ʶ�� �ý�ɫ��ʶȥ��������б����ҵ���Ӧ��ɫ�ĺ���
						var t_v_CodeId = old_radio_obj.attr("v_CodeId");
						$("#old_mem_table tr:gt(0)").each(function(){
							var e_role_code = $(this).find("td:eq(1)").text().trim();
							if(t_v_CodeId==e_role_code){
								t_PHONE_NO = $(this).find("td:eq(0)").text().trim();
								return false;
							}
						});
						
						
						
						//3�����ͽڵ㣬��Ҫ�ж�
						if(t_v_CodeName=="ADD_OFFER_LIST"){
								var t_temp_json={
											"OPERATE_TYPE": "U",
			                "PHONE_NO": t_PHONE_NO,
			                "EFF_DATE": "",
			                "EXP_DATE": "<%=n_month_Date%>",
			                "OFFER_ID": old_offer_id
								};
								ADD_OFFER_LIST_json.push(t_temp_json);
							 
							
						}else if(t_v_CodeName=="MAIN_OFFER_LIST"){
							var t_temp_json={
			                "PHONE_NO": t_PHONE_NO,
			                "EFF_DATE": "<%=n_month_Date%>",
			                "EXP_DATE": "20500101 00:00:00",
			                "OFFER_ID": old_offer_id
							};
							MAIN_OFFER_LIST_json.push(t_temp_json);
						}else if(t_v_CodeName=="SP_OFFER_LIST"){
							 
							var CFM_LOGIN="";
							$("#old_mem_table").find("td[name='rolename']").each(function(i){
								if($(this).text()=="�����Ա"){
									CFM_LOGIN=$("#old_mem_table").find("td[name='phonenumber']").eq(i).text();
								}
							}); 
							
									var t_temp_json={
												 "OPERATE_TYPE": "U",//I�������� U�����˶�
					                "MEMBER_PHONE": t_PHONE_NO,//��Ա����
					                "MASTER_PHONE":"<%=activePhone%>",//�����˺���
					                "OFFER_ID": old_offer_id,//�ʷѴ���
					                "EFF_DATE": "",
					                "EXP_DATE": "<%=n_month_Date%>",
					                "CFM_LOGIN": CFM_LOGIN
									};					
								SP_OFFER_LIST_json.push(t_temp_json);
						}
						
						count_change ++;
					}
				}
		});
		
    
    if(count_change==0){
    		rdShowMessageDialog("�ʷ�δ�����仯");
    		return;
    }

		if(sp_offer_flag){
			return false;
		}
    
		var BUSI_INFO_json={
			"LOGINOPR":LOGINOPR_json
		};
		
		if(MAIN_OFFER_LIST_json.length > 0){
			BUSI_INFO_json["MAIN_OFFER_LIST"]=MAIN_OFFER_LIST_json;
		}
		
		if(ADD_OFFER_LIST_json.length > 0){
			BUSI_INFO_json["ADD_OFFER_LIST"]=ADD_OFFER_LIST_json;
		}
		
		if(SP_OFFER_LIST_json!=""){
			BUSI_INFO_json["SP_OFFER_LIST"]=SP_OFFER_LIST_json;
		}
		if(BASELINE_INFO_json.length>0){
			BUSI_INFO_json["BASELINE_INFO"]=BASELINE_INFO_json;
		}
	 
					
		var in_json_obj = {
												"OPR_INFO":OPR_INFO_json,
												"BUSI_INFO":BUSI_INFO_json
											};
	
	//ƴ���json
		var in_JSONText = JSON.stringify(in_json_obj,function(key,value){
													return value;
											});
				
				
		//alert(in_JSONText);	


	 showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
	 if(!$("tr[name='mobaihegroup']").is(":hidden")){
	 		sm359_show_Bill_Prt();
	 	}
   if(rdShowConfirmDialog("ȷ��Ҫ�ύ��Ϣ��")!=1) return;


		var packet = new AJAXPacket("/npage/sm357/fm357_3.jsp","���Ժ�...");
	      packet.data.add("opCode","<%=opCode%>");// 
	      packet.data.add("phoneNo","<%=activePhone%>");//�ֻ���
	      packet.data.add("sysAcceptl","<%=sysAcceptl%>");//��ˮ
	      packet.data.add("in_JSONText",in_JSONText);//
    core.ajax.sendPacket(packet,do_cfm);
    packet =null;
    
}
function do_cfm(packet){
		var error_code = packet.data.findValueByName("code");//���ش���
    var error_msg =  packet.data.findValueByName("msg");//������Ϣ

    if(error_code=="000000"){//�����ɹ�
    		rdShowMessageDialog("�����ɹ�",2);
	      removeCurrentTab();
    }else{//���÷���ʧ��
    	rdShowMessageDialog(error_code+":"+error_msg);
	    return;
   }
}




function showPrtDlg(printType,DlgMessage,submitCfm){  //��ʾ��ӡ�Ի��� 
  var h=180;
  var w=350;
  var t=screen.availHeight/2-h/2;
  var l=screen.availWidth/2-w/2;		   	   
  var pType="subprint";             				 	//��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
  var billType="1";              				 			  //Ʊ�����ͣ�1���������2��Ʊ��3�վ�
  var sysAccept =<%=sysAcceptl%>;             	//��ˮ��
    var printStr = printInfo(printType);
  
	                      //����printinfo()���صĴ�ӡ����
  var mode_code=null;           							  //�ʷѴ���
  var fav_code=null;                				 		//�ط�����
  var area_code=null;             				 		  //С������
  var opCode="<%=opCode%>" ;                   			 	//��������
  var phoneNo="<%=activePhone%>";                  //�ͻ��绰
  
  var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
  var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
  path+="&mode_code="+mode_code+
  	"&fav_code="+fav_code+"&area_code="+area_code+
  	"&opCode=<%=opCode%>&sysAccept="+sysAccept+
  	"&phoneNo="+phoneNo+
  	"&submitCfm="+submitCfm+"&pType="+
  	pType+"&billType="+billType+ "&printInfo=" + printStr;
  var ret=window.showModalDialog(path,printStr,prop);
  return ret;
}				

    
    function printInfo(printType){
    	if("<%=j_ProdCode%>"=="JTRH"){
    		return printInfo_JTRH();
    	}else if("<%=j_ProdCode%>"=="JTDX"){
    		return printInfo_JTDX();
    	}else if("<%=j_ProdCode%>"=="JTHB"){
    		return printInfo_JTHB();
    	}else if("<%=j_ProdCode%>"=="JTHA"){
    	
    		return printInfo_JTHA();
    	}
    }

    
    function printInfo_JTHA(printType){
    	go_get_prt_info();
      var cust_info="";
      var opr_info="";
      var note_info1="";
      var note_info2="";
      var note_info3="";
      var note_info4="";
      var retInfo = "";
      
      cust_info+="�ֻ����룺   "+"<%=activePhone%>"+"|";
      cust_info+="�ͻ�������   "+$("#prt_cust_name").val()+"|";
      
      opr_info += "ҵ������ʱ�䣺" + '<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>' + 
      						"    �û�Ʒ�ƣ�"+$("#prt_cust_bran").val()+"|";
      						
      opr_info += "����ҵ�����ƣ���ͥA�ƻ�    ������ˮ: "+"<%=sysAcceptl%>" +"|";
      
      note_info1 += "�ʷ�������"+"|";
	 

	 
			$("#offer_table").find("input[type='radio']").each(function(){
				if($(this).is(":checked")){
					
					var offer_id_temp = $(this).attr("v_BPopedomCode");
 
							
						if("57572"==offer_id_temp){
							note_info1 += "���ѳɹ�����10Ԫ�����ܰ����ײ�24Сʱ����Ч��ÿ�³�Ա�ɹ������ײ��ڵ������������ܼ�ͥ����ʡ���ƶ���������500�ף���Ա�䱾��ͨ�������Ż�500���ӣ��������Ӳ�����4����ͥ��Ա��2������ÿ����һ����10Ԫ���ܷѣ���"+"|";
						}
						
						if("52837"==offer_id_temp){
							note_info1 += "���ѳɹ�����IMS�̻�ҵ������10Ԫ/�£�����200�����л����л�0.1Ԫ/���ӣ���;0.15Ԫ/����,���ͥ��Ա�以����ѡ�"+"|";
						}
						
						if("57570"==offer_id_temp){
							note_info1 += "���ѳɹ�����10Ԫ1Gʡ���������Ͱ����ײ�24Сʱ����Ч�����¿������Ӱ���10�Ρ� "+"|";
						}
					 
					 
				}
			});  	
			

		  note_info1 += "|";
		  
		  


      retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
      retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
      return retInfo;
    }


    
    function printInfo_JTHB(printType){
    	go_get_prt_info();
      var cust_info="";
      var opr_info="";
      var note_info1="";
      var note_info2="";
      var note_info3="";
      var note_info4="";
      var retInfo = "";
      
      cust_info+="�ֻ����룺   "+"<%=activePhone%>"+"|";
      cust_info+="�ͻ�������   "+$("#prt_cust_name").val()+"|";
      
      opr_info += "ҵ������ʱ�䣺" + '<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>' + 
      						"    �û�Ʒ�ƣ�"+$("#prt_cust_bran").val()+"|";
      						
      opr_info += "����ҵ�����ƣ���ͥB�ƻ�    ������ˮ: "+"<%=sysAcceptl%>" +"|";
      
      note_info1 += "�ʷ�������"+"|";
	 


      note_info1 += "���Ѷ����й��ƶ���ͥB�ƻ��ײͣ�";
 
			var temp_note_info1 = "";
			$("#offer_table").find("input[type='radio']").each(function(){
				if($(this).is(":checked")){//����ѡ�еĵ�ѡ��
					var t_v_OfferDesc = $(this).attr("v_OfferDesc");
					if(typeof(t_v_OfferDesc)!="undefined"&&t_v_OfferDesc!=""&&t_v_OfferDesc!="undefined"){
						temp_note_info1 += t_v_OfferDesc+"��";
					}
				}
			});      

	 
			note_info1 += temp_note_info1;
			note_info1 += "��ѡ��ħ�ٺ�ҵ���ײ���Ч�ڼ䣬�����ħ�ٺ�ʵ�ʿ���ʱ���Կ����װ����ɹ�Ϊ׼��������Ԥ���240Ԫ��һ���ڰ��¾�̯����������ʱ��Ϊÿ�³���"+"|";
      
      
      
      	 
			$("#offer_table").find("input[type='radio']").each(function(){
				if($(this).is(":checked")){
						var offer_id_temp = $(this).attr("v_BPopedomCode");
 
						if("57572"==offer_id_temp){
							note_info1 += "���ѳɹ�����10Ԫ�����ܰ����ײ�24Сʱ����Ч��ÿ�³�Ա�ɹ������ײ��ڵ������������ܼ�ͥ����ʡ���ƶ���������500�ף���Ա�䱾��ͨ�������Ż�500���ӣ��������Ӳ�����4����ͥ��Ա��2������ÿ����һ����10Ԫ���ܷѣ���|";
						}
						
						
						if("52837"==offer_id_temp){
							note_info1 += "���ѳɹ�����IMS�̻�ҵ������10Ԫ/�£�����200�����л����л�0.1Ԫ/���ӣ���;0.15Ԫ/����,���ͥ��Ա�以����ѡ�|";
						}
					 
				}
			});  	
			

		 
      note_info2 += "��ע��|";
      note_info2 += "1�����°����Ʒ����󣬵��²���������ͥ��ɢ��|";
      if(returnValue=="Y"){
    	  note_info2 += "2���絥���˶�ħ�ٺ�ҵ��ħ�ٺ��˶�����������Ч��|";
      }
      else{
    	  note_info2 += "2���絥���˶�ħ�ٺ�ҵ���˶����ڵ������һ���20����Ч��|";
      }

      retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
      retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
      return retInfo;
    }


    
	//��ӡģ��idΪ��
    function printInfo_JTRH(printType){
    	go_get_prt_info();
      var cust_info="";
      var opr_info="";
      var note_info1="";
      var note_info2="";
      var note_info3="";
      var note_info4="";
      var retInfo = "";
      
      cust_info+="�ֻ����룺   "+"<%=activePhone%>"+"|";
      cust_info+="�ͻ�������   "+$("#prt_cust_name").val()+"|";
      
      opr_info += "ҵ������ʱ�䣺" + '<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>' + 
      						"    �û�Ʒ�ƣ�"+$("#prt_cust_bran").val()+"|";
      						
      opr_info += "����ҵ�����ƣ��ͼ�ͥ�����ײͱ��    ������ˮ: "+"<%=sysAcceptl%>" +"|";
      
			note_info1 += "�ʷ�������"+"|";
			
			var temp_note_info1 = "";
			var temp_v_OfferSum = 0;
			var is_mbh_flag = "";//�Ƿ�ħ�ٺ�

			note_info1 += "���ѱ���й��ƶ��ͼ�ͥ�����ײ����ݣ��������1����Ч���������ʹ�÷�";
			
			var temp_note_info1 = "";
			$("#offer_table").find("input[type='radio']").each(function(){
				if($(this).is(":checked")){//����ѡ�еĵ�ѡ��
					if("ħ�ٺ�"==$(this).attr("v_ClssName")){
						is_mbh_flag = "ħ�ٺͻ���������ҵ��";//����Ϊһ�仰
					}
					var v_OfferSum = $(this).attr("v_OfferSum");
					temp_v_OfferSum = temp_v_OfferSum + parseInt(v_OfferSum);
					
					var t_v_OfferDesc = $(this).attr("v_OfferDesc");
					if(typeof(t_v_OfferDesc)!="undefined"&&t_v_OfferDesc!=""&&t_v_OfferDesc!="undefined"){
						temp_note_info1 += t_v_OfferDesc+"��";
					}
					
				}
			}); 
			note_info1 += temp_v_OfferSum+"Ԫ����";
			note_info1 += temp_note_info1;
      note_info1 += "�����װ���°�ʵ��ʹ�������շѣ����ײ�������ƶ���������0.29Ԫ/M��ʡ�ڳ�������һ��������0.1Ԫ/���ӣ�ʡ�ڽ�����ѣ�ʡ��������й���˫���շ�0.3Ԫ/���ӣ������۰�̨�����������Ӳ�����6����ͥ��Ա��3������ÿ����һ����5Ԫ���ܷѣ��������ձ�׼�ʷ���ȡ��|";    
      
      
			note_info1 +="��ע��|";    
			note_info1 +="1�����°����Ʒ����󣬵��²���������ͥ��ɢ��|";    
			if(returnValue=="Y"){
				note_info1 += "2���絥���˶�ħ�ٺ�ҵ��ħ�ٺ��˶�����������Ч��|";
			}
			else{
				note_info1 += "2���絥���˶�ħ�ٺ�ҵ���˶����ڵ������һ���20����Ч��|";
			}

			note_info2 += "|";
			note_info2 += "��ͥ�ײͺ�Լ��Ϊ12���£����ں������ߵ����Զ�˳��ԭ�ײ͡� |";
			      
      retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
      retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
      return retInfo;
    }


function printInfo_JTDX(printType){
    	go_get_prt_info();
      var cust_info="";
      var opr_info="";
      var note_info1="";
      var note_info2="";
      var note_info3="";
      var note_info4="";
      var retInfo = "";
      
      cust_info+="�ֻ����룺   "+"<%=activePhone%>"+"|";
      cust_info+="�ͻ�������   "+$("#prt_cust_name").val()+"|";
      
      opr_info += "ҵ������ʱ�䣺" + '<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>' + 
      						"    �û�Ʒ�ƣ�"+$("#prt_cust_bran").val()+"|";
      						
      opr_info += "����ҵ�����ƣ���ͥ���������Ż�    ������ˮ: "+"<%=sysAcceptl%>" +"|";
      
      
      var is_mbh_flag = "";//�Ƿ�ħ�ٺ�
			var m_num_count = 0;//��ͥ��Ա����Ϊ
			var m_phone_no  = "";//��Ա�ֻ�����
			
			$("#old_mem_table tr:gt(0)").each(function(){
				if($(this).find("td:eq(2)").text().trim()=="��ͨ��Ա"){
					m_num_count ++ ;
					m_phone_no += $(this).find("td:eq(0)").text().trim()+"��";
				}
			});
			
			if(m_phone_no.length>0){
				m_phone_no = m_phone_no.substring(0,m_phone_no.length-1);
			}
			
      $("#offer_table").find("input[type='radio']").each(function(){
				if($(this).is(":checked")){//����ѡ�еĵ�ѡ��
					
					if("ħ�ٺ�"==$(this).attr("v_ClssName")){
						is_mbh_flag = "ħ�ٺͻ���������ҵ��";//����Ϊһ�仰
					}
					
					var t_v_OfferDesc = $(this).attr("v_OfferDesc");
					
					if(typeof(t_v_OfferDesc)!="undefined"&&t_v_OfferDesc!=""&&t_v_OfferDesc!="undefined"){
						temp_note_info1 += t_v_OfferDesc+"��";
					}
					
				}
			}); 
			
			if(temp_note_info1.length>0){
				temp_note_info1 = temp_note_info1.substring(0,temp_note_info1.length-1);
			}
			note_info1 += "�ʷ�������"+"|";
			note_info1 += "���ѱ����ͥ���������Żݵ��ߣ���ǰ��ͥ��Ա����Ϊ"+m_num_count+"�ˣ���Ա�ֻ�����ֱ�Ϊ"+m_phone_no+"��";
			note_info1 += temp_note_info1+" "+is_mbh_flag;
			note_info1 += "|";
			
			note_info1 +="��ע��|";    
			note_info1 +="1�����°����Ʒ����󣬵��²���������ͥ��ɢ��|";    
			note_info1 +="2���������߱���󣬲�����ħ�ٺ�ҵ������������ħ�ٺͽ��ڵ������һ���20���Զ��˶���|";   
			

			note_info2 += "|";
			note_info2 += "��ͥ�ײͺ�Լ��Ϊ12���£����ں������ߵ����Զ�˳��ԭ�ײ͡� |";
			
      retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
      retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
      return retInfo;
    }
    
    
function go_get_prt_info(){
		var packet = new AJAXPacket("/npage/sm357/fm357_7.jsp","���Ժ�...");
	      packet.data.add("opCode","<%=opCode%>");// 
	      packet.data.add("phoneNo","<%=activePhone%>");//�ֻ���
	      packet.data.add("inProdCode","");//
	      packet.data.add("inGearCode","");//
    core.ajax.sendPacket(packet,do_get_prt_info);
    packet =null;	
}

function do_get_prt_info(packet){
		var error_code = packet.data.findValueByName("code");//���ش���
    var error_msg =  packet.data.findValueByName("msg");//������Ϣ

    if(error_code=="000000"){//�����ɹ�
    	$("#prt_cust_name").val(packet.data.findValueByName("prt_cust_name"));
    	$("#prt_cust_bran").val(packet.data.findValueByName("prt_cust_bran"));
    	$("#prt_note_into").val(packet.data.findValueByName("prt_note_into"));
    }
}

    
$(document).ready(function(){
	$("tr[name='mobaihegroup']").hide();
	if("N"==$("#offer_table").find("input[type='radio'][v_ClssName='ħ�ٺ�']").attr("v_IsOrder")){
		$("input[type='radio']").click(function (){
			if($(this).attr("v_ClssName")=="ħ�ٺ�"){
			 $("tr[name='mobaihegroup']").show();
			}
		});
	}
	
	//�ҵ�����13λΪN����������Ĭ��ѡ��	
$("#offer_table input[type='radio'][v_is_show='N']").each(function(){
	$(this).attr("checked","checked");
	$(this).parent().parent().hide();
});


var mbh_obj = $("#offer_table").find("input[type='radio'][v_ClssName='ħ�ٺ�']");
$(mbh_obj).click(function(){
	if(mbh_obj.attr("v_IsOrder")!="Y"){// ����ħ�ٺ�û��ѡ��  Ȼ�󶩹�ʱ�ж� ��ͥ��Ʒ��Ч�ĵ��²ſ��Ե����ڼ�ͥ�а���
			var j_EFF_DATE_j = "";
			if("<%=j_EFF_DATE%>".length>8){
				j_EFF_DATE_j = "<%=j_EFF_DATE%>".substring(0,6);
			}
			
			<%-- if(j_EFF_DATE_j!="<%=currentDate%>".substring(0,6)){
				rdShowMessageDialog("��ͥ��Ʒ��Ч�ĵ��²ſ��Ե����ڼ�ͥ�а���");
				mbh_obj.removeAttr("checked");
				$("tr[name='mobaihegroup']").hide();
			} --%>
			
	}
});



$("#offer_table tr:gt(0)").each(function(){
	//��2��Ĭ��ѡ�е�
	if($(this).find("input[type='radio'][v_IsOrder='Y']").size()>1){
		//�ûҴ���
		$(this).find("input").attr("disabled","disabled");
		//ѡ������״̬��A��
		$(this).find("input[type='radio'][v_offer_status='A']").attr("checked","checked");
		
	}
});


	$("input[type='radio']").click(function (){
		if($(this).parent().parent().find("td:eq(0)").text().trim()=="ħ�ٺ�"){
			go_check_DDSMPORDERMSG();
		}
		
	})


});


var J_count_result="";
function go_check_DDSMPORDERMSG(){
		var packet = new AJAXPacket("/npage/sm358/fm358_5.jsp","���Ժ�...");
	      packet.data.add("phoneNo","<%=activePhone%>");//�ֻ���
    core.ajax.sendPacket(packet,do_check_DDSMPORDERMSG);
    packet =null;
}
function do_check_DDSMPORDERMSG(packet){
		var error_code = packet.data.findValueByName("code");//���ش���
    var error_msg  =  packet.data.findValueByName("msg");//������Ϣ

    if(error_code=="000000"){//�����ɹ�
    	J_count_result = packet.data.findValueByName("count_result");//������Ϣ
    	if("1"==J_count_result){
    		if("<%=j_ProdCode%>"=="JTRH"){
    			rdShowMessageDialog("�û��Ѿ�����ħ�ٺͣ��������ٶ���");
    			$("input[type='radio']").click(function (){
						if($(this).attr("v_ClssName")=="ħ�ٺ�"){
							$(this).removeAttr("checked");
						}
					})
    		}
    		if("<%=j_ProdCode%>"=="JTDX"){
    		}
    		$("tr[name='mobaihegroup']").hide();
    		returnValue="N";
    	}else{
    		$("tr[name='mobaihegroup']").show();
    		subFlag = false;
			$("#jiaoyanButton").attr("disabled","");
			$("#stb_id").attr("readonly","");
			$("#stb_id").val("");
    	}
    }
}

var subFlag=false;
function go_stb_id(){
	if(!$("#jiaoyanButton").is(":disabled")){
		$("#jiaoyanButton").attr("disabled","disabled");
		$("#stb_id").attr("readonly","readonly");
		// readonly="readonly"
	}
	var packet = new AJAXPacket("/npage/sm358/fm358_6.jsp","���Ժ�...");
	packet.data.add("opCode","<%=opCode%>");
	packet.data.add("phoneNo","<%=activePhone%>");//�ֻ���
    packet.data.add("stb_id",$("#stb_id").val());//
    core.ajax.sendPacket(packet,do_stb_id);
    packet =null;
}
var is_show_mobaihe = "";
function do_stb_id(packet){
	subFlag=false;
	var error_code = packet.data.findValueByName("code");//���ش���
    var error_msg =  packet.data.findValueByName("msg");//������Ϣ

    if(error_code=="000000"){//�����ɹ�
    	subFlag=true;
    	returnValue=packet.data.findValueByName("returnValue");
    	    	is_show_mobaihe = packet.data.findValueByName("returnValue");
    	if(is_show_mobaihe=="Y"){
    		$("#td_mobaihe1").show();
    		$("#td_mobaihe2").show();
    	}else{
    		$("#td_mobaihe1").hide();
    		$("#td_mobaihe2").hide();
    	}
    	rdShowMessageDialog("IMEI��У��ɹ�!");
    }else{//���÷���ʧ��
    	subFlag = false;
    	rdShowMessageDialog(error_code+":"+error_msg);
    	if($("#jiaoyanButton").is(":disabled")){
    		$("#jiaoyanButton").attr("disabled","");
    		$("#stb_id").attr("readonly","");
    	}
	    return;
   }
}

//��ӡ��Ʊ
function sm359_show_Bill_Prt(){
			var jf_money = "";
			if(is_show_mobaihe=="Y"){
				jf_money = $("#mobaiheyajin").val();
			}else{
				jf_money = "0";
			}
			var  billArgsObj = new Object();
			$(billArgsObj).attr("10001","<%=workNo%>");     //����
			$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10005",$("#prt_cust_name").val());   //�ͻ�����
			$(billArgsObj).attr("10006","��ͥ��Ʒ���-ħ�ٺ�Ѻ��");    //ҵ�����
			
			$(billArgsObj).attr("10008","<%=activePhone%>");    //�û�����
			$(billArgsObj).attr("10015",jf_money);   //���η�Ʊ���
			$(billArgsObj).attr("10016",jf_money);   //��д���ϼ�
			$(billArgsObj).attr("10017","*");        //���νɷѣ��ֽ�
			/*10028 10029 ����ӡ*/
		  	$(billArgsObj).attr("10028","");   //�����Ӫ������ƣ�
			$(billArgsObj).attr("10029","");	 //Ӫ������	
			$(billArgsObj).attr("10030","<%=sysAcceptl%>");   //��ˮ�ţ�--ҵ����ˮ
			$(billArgsObj).attr("10036","m358");   //��������
			/**/

			
			/*�ͺŲ���*/
			$(billArgsObj).attr("10061","");	       //�ͺ�
			$(billArgsObj).attr("10062","");	//˰��
			$(billArgsObj).attr("10063","");	//˰��	   
	    	$(billArgsObj).attr("10071","6");	//
	 		$(billArgsObj).attr("10076",0);
 			
 			$(billArgsObj).attr("10083", ""); //֤������
 			$(billArgsObj).attr("10084", ""); //֤������
 			$(billArgsObj).attr("10086", "�𾴵Ŀͻ�����������ҵ���˶���ȡ������ֹҵ��ʹ�õĲ���ʱ����Я�����վݡ���Ч���֤��������ҵ��ʱ����ħ�ٺ��ն˵��ƶ�ָ������Ӫҵ������Ѻ���˻�������"); //��ע
 			$(billArgsObj).attr("10065", ""); //����˺�
 			$(billArgsObj).attr("10087", $("#stb_id").val()); //imei����
 			
			$(billArgsObj).attr("10041", "ħ�ٺ��ն�Ѻ�����");           //Ʒ�����
			$(billArgsObj).attr("10042","̨");                   //��λ
			$(billArgsObj).attr("10043","1");	                   //����
			$(billArgsObj).attr("10044",jf_money);	                //����
			
 			$(billArgsObj).attr("10085", "zsj"); //���������ȡ��ʽ ֻ������ӡ�վݵĿ�
 			$(billArgsObj).attr("10072","1"); //1--������Ʊ  2--�����෢Ʊ  2--�˷��෢Ʊ

 			$(billArgsObj).attr("10088","m358"); //�վ�ģ��
 			
 			
			var h=210;
			var w=400;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
			//var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=" + "ȷʵҪ���з�Ʊ��ӡ��";
			
						//��Ʊ��Ŀ�޸�Ϊ��·��
			$(billArgsObj).attr("11213","REC");  //�°淢Ʊ����Ʊ�ݱ�־λ��Ĭ�Ͽ�λ��Ʊ REC == ֻ�� ��ӡֽ���վ�
			var path = "/npage/public/billPrtNew/Bill_ELE_Prt.jsp?dlgMsg=" + "ȷʵҪ���з�Ʊ��ӡ��";

			var loginAccept = "<%=sysAcceptl%>";
			var path = path +"&loginAccept="+loginAccept+"&opCode=m358&submitCfm=submitCfm";
			var ret = window.showModalDialog(path,billArgsObj,prop);		

}

</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action="" method="post"> 
<input type="hidden" id="prt_cust_name" name="prt_cust_name" value="" />
<input type="hidden" id="prt_cust_bran" name="prt_cust_bran" value="" />
<input type="hidden" id="prt_note_into" name="prt_note_into" value="" />		
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi">ѡ���ƷG</div></div>


<table cellSpacing="0">
	<tr>
	    <td class="blue" width="25%">��ͥ��Ʒ��</td>
		  <td width="25%">
		  	<%=j_ProdName%>
		  </td>
 
	    <td class="blue" width="25%">��Ʒ��λ��</td>
		  <td width="25%">
			   <%=j_GearName%>
		  </td>
	</tr>
	<tr>
		<td class="blue">Ⱥ�飺</td>
		<td colspan="3">
			<%=j_group_id%>
		</td>
	</tr>
</table>

<div class="title"><div id="title_zi">����ӽ�ɫ</div></div>
<table cellSpacing="0"  id="old_mem_table">
	<tr>
		<th width="25%" name="phonenumber">�ֻ�����</th>
		<th style="display:none">��ɫ����</th>
		<th width="25%" name="rolename">��ɫ����</th>
		<th width="25%">��Чʱ��</th>
		<th width="25%">ʧЧʱ��</th>
		<th style="display:none">��־λ����ʶ�Ƿ���Ҫ���ѣ�����Y�Ĵ�����Ҫ���ѣ���Ҫƴһ��PAY_INFO</th>
	</tr>
<%
for(int i=0;i<result_t3.length;i++){
%>
<tr>
	<td name="phonenumber"><%=result_t3[i][0]%></td>
	<td  style="display:none"><%=result_t3[i][6]%></td>
	<td name="rolename"><%=result_t3[i][1]%></td>
	<td><%=result_t3[i][2]%></td>
	<td><%=result_t3[i][3]%></td>
	<td  style="display:none" ><%=result_t3[i][8]%></td>
	<td  style="display:none" ><%=result_t3[i][7]%></td>
</tr>
<%
}
%>
</table>


<div class="title"><div id="title_zi">�ʷ��б�</div></div>
<table cellSpacing="0"  id="offer_table">
	 <tr>
		<th width="25%">�ʷѷ���</th>
		<th colspan='2'>�ʷ�����</th>
		<th width="25%">����</th>
	</tr>
<%
String ja_ClssName = "";
if(result_t4.length>0){
	ja_ClssName = result_t4[0][10];
	out.print("<tr v_OfferFlag='"+result_t4[0][11]+"'>");
	out.print("<td>"+result_t4[0][10]+"</td>");
	out.print("<td colspan='2'>");
}

for(int i=0;i<result_t4.length;i++){
	
	 
	
	
	String checked_str = "";
	
	if("Y".equals(result_t4[i][9])){
		checked_str = "checked";
	}
	
if(ja_ClssName.equals(result_t4[i][10])){//һ��
	
	//�Ƿ�ѡ��
	
%>

	<input  type="radio" name="offer_radio_<%=result_t4[i][4]%>"
														v_PopedomCode='<%=result_t4[i][0]%>' 
														v_CodeId='<%=result_t4[i][1]%>' 
														v_TopCodeId='<%=result_t4[i][2]%>' 
														v_CodeName='<%=result_t4[i][3]%>' 
														v_CodeValue='<%=result_t4[i][4]%>' 
														v_BPopedomCode='<%=result_t4[i][5]%>' 
														v_OfferName='<%=result_t4[i][6]%>' 
														v_OfferComments='<%=result_t4[i][7]%>' 
														v_OfferSum='<%=result_t4[i][8]%>' 
														v_IsOrder='<%=result_t4[i][9]%>' 
														v_ClssName='<%=result_t4[i][10]%>' 
														v_OfferFlag='<%=result_t4[i][11]%>' 
														v_OfferDesc='<%=result_t4[i][12]%>' 
														v_is_show='<%=result_t4[i][13]%>'
														v_EffDate='<%=result_t4[i][14]%>'
														v_offer_status='<%=result_t4[i][16]%>'
			<%=checked_str%>
	 />
	
	<a href="javascript:void(0)" onclick="show_offer_det('<%=result_t4[i][10]%>','<%=result_t4[i][6]%>','<%=result_t4[i][7]%>','<%=result_t4[i][8]%>')"><%=result_t4[i][6]%></a>

<%	
}else{
	out.print("</td>");
	out.print("<td><input type='button' value='ȡ��' class='b_text' onclick='cen_radio_all(this)' ></td>");
	out.print("</tr>");
	out.print("<tr v_OfferFlag='"+result_t4[i][11]+"'>");
	out.print("<td>"+result_t4[i][10]+"</td>");
	out.print("<td colspan='2'>");
%>
	<input  type="radio" name="offer_radio_<%=result_t4[i][4]%>"
														v_PopedomCode='<%=result_t4[i][0]%>' 
														v_CodeId='<%=result_t4[i][1]%>' 
														v_TopCodeId='<%=result_t4[i][2]%>' 
														v_CodeName='<%=result_t4[i][3]%>' 
														v_CodeValue='<%=result_t4[i][4]%>' 
														v_BPopedomCode='<%=result_t4[i][5]%>' 
														v_OfferName='<%=result_t4[i][6]%>' 
														v_OfferComments='<%=result_t4[i][7]%>' 
														v_OfferSum='<%=result_t4[i][8]%>' 
														v_IsOrder='<%=result_t4[i][9]%>' 
														v_ClssName='<%=result_t4[i][10]%>' 
														v_OfferFlag='<%=result_t4[i][11]%>' 
														v_OfferDesc='<%=result_t4[i][12]%>' 
														v_is_show='<%=result_t4[i][13]%>'
														v_EffDate='<%=result_t4[i][14]%>'
														v_offer_status='<%=result_t4[i][16]%>'
						<%=checked_str%>													
	 />
	
	<a href="javascript:void(0)" onclick="show_offer_det('<%=result_t4[i][10]%>','<%=result_t4[i][6]%>','<%=result_t4[i][7]%>','<%=result_t4[i][8]%>')"><%=result_t4[i][6]%></a>

<%	
	ja_ClssName = result_t4[i][10];
}
%>

	
<%
}

if(result_t4.length>0){
	out.print("</td>");
	out.print("<td><input type='button' value='ȡ��' class='b_text' onclick='cen_radio_all(this)' ></td>");
	out.print("</tr>");
}	
%>


 <tr name="mobaihegroup" style="display:none">
 	<td scope="col" width="10%">��ҵ����</td>
 	<td scope="col" width="40%">
	 	<select id="sp_id" name="sp_id">
	 		<option value="">-��ѡ��-</option>
	 		<option value="699213">δ������</option>
	 		<option value="699212">����ͨ</option>
	 	</select>
 	</td>
 	<td scope="col" width="10%">ҵ�����</td>
 	<td scope="col" width="40%">
 		<select id="biz_code" name="biz_code">
	 		<option value="20830000">20830000</option>
	 	</select>
 	</td>
 	
 	</tr>
 <tr name="mobaihegroup" style="display:none">
 	<!-- 003903FF00210070 -->
 	<td scope="col">IMEI��</td>
 	<td scope="col"><input type="text" id="stb_id" name="stb_id" size="40" value="" maxlength="32">
 	<input type="button" class='b_text' id="jiaoyanButton" value="У��" onclick="go_stb_id()"/>
 	</td>
 	<td scope="col" id="td_mobaihe1" style="display:none">ħ�ٺ�Ѻ��</td>
 	<td  id="td_mobaihe2" style="display:none">
 		
 		<input type="text" id="mobaiheyajin" name="mobaiheyajin" maxlength="3"  readOnly="readOnly" class="InputGrey" value="0" value="100" v_must="0" v_type="money"  onblur = "checkElement(this)"  />
 	</td>
 	</tr>

</table>

<table cellSpacing="0">
	<tr>
		<td><font class="orange">��ע��������������Ʒ�������������������ͥ��ɢҵ��</font> </td>
	</tr>
</table>
<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="ȷ��" onclick="go_cfm()"           />
	 		<input type="button" class="b_foot" value="����" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="�ر�" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>
<div id="messagediv"></div>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>