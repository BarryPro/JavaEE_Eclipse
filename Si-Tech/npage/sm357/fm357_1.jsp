<%
/********************
 
-->>���������ˡ�ʱ�䡢ģ��Ĺ���
-------------------------����-----------�ξ�ΰ(hejwa)2016-2-19 14:10:11------------------

��������Ա������˳�������ֱ�ӵ��ò�ѯ����
չʾ��ͥ���г�Ա����������ͥ��ϵ������ֱ����ʾ�Ƿ�Ҫ�齨��ͥ��ϵ��ѡ���ֱ���˳���
ѡ���Ǻ�����齨��ͥ��ϵ���棬�ý�����Բ���e281���棬���÷����ѯ��Ʒ����ѯ��ɫ����Ϣ��
Ȼ������Ӳ���������ȷ�Ϸ������ҵ������

-------------------------��̨��Ա��wangzc��zuolf--------------------------------------------

********************/
%>
              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%
	String opCode    = WtcUtil.repNull(request.getParameter("opCode"));
  String opName    = WtcUtil.repNull(request.getParameter("opName"));
  
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
	
	System.out.println("--hejwa------fm357_1.jsp----AAAAAAAAAAA-----Currentdate--AAAAAAAAAAA----------->"+currentDate);
	
	String paraAray[] = new String[9];
	paraAray[0] = "";                                       //��ˮ
	paraAray[1] = "01";                                     //��������
	paraAray[2] = opCode;                                   //��������
	paraAray[3] = (String)session.getAttribute("workNo");   //����
	paraAray[4] = (String)session.getAttribute("password"); //��������
	paraAray[5] = activePhone;                                  //�û�����
	paraAray[6] = "";       
	paraAray[7] = "";  
	paraAray[8] = "";  
	
	String[][] result_sm357Qry = new String[][]{};
%> 
	<wtc:sequence name="sPubSelect" key="GROUPINTN_SEQ" routerKey="region" routerValue="<%=regionCode%>"  id="role_group_id" /> 
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAcceptl" /> 
		
  <wtc:service name="sm357Check" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=paraAray[0]%>" />
		<wtc:param value="<%=paraAray[1]%>" />	
		<wtc:param value="<%=paraAray[2]%>" />
		<wtc:param value="<%=paraAray[3]%>" />
		<wtc:param value="<%=paraAray[4]%>" />
		<wtc:param value="<%=paraAray[5]%>" />
		<wtc:param value="<%=paraAray[6]%>" />
		<wtc:param value="<%=paraAray[7]%>" />					
		<wtc:param value="<%=paraAray[8]%>" />			
	</wtc:service>
	<wtc:array id="result_t2" scope="end"  />
		
<%
	String vChkFlag = "";
	String phoneNo_207 = "";
	/*@outparam			vChkFlag	        ��֤��� Y/N N:��Ҫ������ͥ��ϵ*/
	if("000000".equals(code)){
		
		if(result_t2.length>0){
			vChkFlag    = result_t2[0][0];
			phoneNo_207 = result_t2[0][1];
		}
		
		if("Y".equals(vChkFlag)){
%>
<SCRIPT language=JavaScript>
	location="fm357_5.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhoneNo=<%=activePhone%>&phoneNo_207=<%=phoneNo_207%>&vChkFlag=<%=vChkFlag%>";
</SCRIPT>	
<%		
		}
	}else{
%>
<SCRIPT language=JavaScript>
	rdShowMessageDialog("sm357CheckУ�����<%=code%>��<%=msg%>");
	removeCurrentTab();
</SCRIPT>
<%		
	}
	
%>
<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<script language="javascript" type="text/javascript" src="/npage/public/json2.js"></script>	
<style type="text/css">
	body{ 
		margin: 0; 
		font-size: 12px; 
		line-height: 100%; 
		font-family: Arial, sans-serif; 
	} 
	.background { 
		display: block; 
		width: 100%; 
		height: 100%; 
		opacity: 0.4; 
		filter: alpha(opacity=40); 
		background:while; 
		position: absolute; 
		top: 0; 
		left: 0; 
		z-index: 2000; 
	} 
	.progressBar { 
		border: solid 2px #86A5AD; 
		background: white url(progressBar_m.gif) no-repeat 10px 10px; 
	} 
	.progressBar { 
		display: block; 
		width: 200px; 
		height: 100px; 
		position: fixed; 
		top: 50%; 
		left: 50%; 
		margin-left: -74px; 
		margin-top: -14px; 
		padding: 10px 10px 10px 50px; 
		text-align: left; 
		line-height: 27px; 
		font-weight: bold; 
		position: absolute; 
		z-index: 2001; 
	} 

</style>
<SCRIPT language=JavaScript>

var vChkFlag_j = "<%=vChkFlag%>";
var phone_207 = "<%=phoneNo_207%>";

//����ˢ��ҳ��
function reSetThis(){
	  location = location;	
}
function showBar(){
	$("#background").show();
	$("#progressBar").show();
}
function closeBar(){
	$("#background").hide();
	$("#progressBar").hide();
}
$(document).ready(function(){
	if("Y"==vChkFlag_j){
		//�Ѿ�������ͥ
	}else if("N"==vChkFlag_j){
	//	if(rdShowConfirmDialog('���û���δ�齨��ͥ��ϵ���Ƿ�Ҫ����?')!=1) {
		//	removeCurrentTab();
		//}else{
		
			//У����񷵻صĽ��Ϊ���ֻ���Ϊ�ɴ�����ͥ��
			go_ajax_sm357Qry("0","","","<%=activePhone%>");
			
		//}
	}
});

function go_ajax_sm357Qry(inQryType,inProdCode,inGearCode,phone_no){
 
	var packet = new AJAXPacket("fm357_2.jsp","���Ժ�...");
      packet.data.add("opCode","<%=opCode%>");// 
      packet.data.add("phoneNo",phone_no);//�ֻ���
      packet.data.add("inQryType",inQryType);//
      packet.data.add("inProdCode",inProdCode);//
      packet.data.add("inGearCode",inGearCode);//
    core.ajax.sendPacket(packet,do_ajax_sm357Qry);
    packet =null;
}
function do_ajax_sm357Qry(packet){
		var error_code = packet.data.findValueByName("code");//���ش���
    var error_msg =  packet.data.findValueByName("msg");//������Ϣ

    if(error_code=="000000"){//�����ɹ�
    	var inQryType  = packet.data.findValueByName("inQryType");
    	
      var retArray   = packet.data.findValueByName("retArray");	
	    if("0"==inQryType){//��ѯ��Ʒ����
	    	$("#sel_ProdCode option:gt(0)").remove();
	    	for(var i=0;i<retArray.length;i++){
	    		$("#sel_ProdCode").append("<option value='"+retArray[i][1]+"'>"+retArray[i][0]+"</option>");
	    	}
	    }
	    
	    if("1"==inQryType){//��ѯ��Ʒ��λ
	    	$("#sel_GearCode option:gt(0)").remove();
	    	for(var i=0;i<retArray.length;i++){
	    		$("#sel_GearCode").append("<option value='"+retArray[i][1]+"'>"+retArray[i][0]+"</option>");
	    	}
	    }
	    
	    if("2"==inQryType){//��ѯ��ɫ
	    	var JTFX_disabled = "";
	    	
	    	$("#table_RoleCode tr:gt(0)").remove();
	    	var in_html = "";
	    	for(var i=0;i<retArray.length;i++){
	    		
	    		if(("JTFX"==$("#sel_ProdCode").val()||"JTHB"==$("#sel_ProdCode").val())&&"21096"==retArray[i][1]){
	    			
		    		JTFX_disabled = "disabled";
		    	}else{
		    		JTFX_disabled = "";
		    	}
	    		
					if($("#sel_GearCode").val()=="D022"){
						JTFX_disabled = "";
					}	    		
	    		
	    		//JTHB ��ʱ�� D040 -D048 ����ֱ�������ͨ��Ա
	    		
	    		if(
	    			$("#sel_GearCode").val()=="D041"||
	    			$("#sel_GearCode").val()=="D042"||
	    			$("#sel_GearCode").val()=="D043"||
	    			$("#sel_GearCode").val()=="D044"||
	    			$("#sel_GearCode").val()=="D045"||
	    			$("#sel_GearCode").val()=="D046"||
	    			$("#sel_GearCode").val()=="D047"||
	    			$("#sel_GearCode").val()=="D048"
	    		){
						JTFX_disabled = "";
					}	
					
					
	    		in_html += "<tr>"+
	    							 "<td>"+retArray[i][0]+"</td>"+
	    							 "<td style='display:none'>"+retArray[i][1]+"</td>"+
	    							 "<td>"+retArray[i][2]+"</td>"+
	    							 "<td>"+retArray[i][3]+"</td>"+
	    							 "<td style='display:none'>"+retArray[i][4]+"</td>"+
	    							 "<td>0</td>"+
	    							 "<td><input type='button' class='b_text' value='���' onclick='add_role_mem(this)' "+JTFX_disabled+" />";
	    							 if(retArray[i][0]=="207��ͥ�û�"){
	    								 in_html += "<input type='button' class='b_text' value='��ͥ����' onclick='addFamily(this)'/></td></tr>";
	    							 }
	    							 else{
	    								 in_html += "</td></tr>";
	    							 }
	    							 
	    	}
	    	$("#table_RoleCode").append(in_html);
	    }
	    
    }else{//���÷���ʧ��
    	rdShowMessageDialog(error_code+":"+error_msg);
	    return;
    }
}

//��Ӱ�ť
function add_role_mem(bt){
		if(!$("#opr_info").is(":hidden")){
			rdShowMessageDialog("���ȱ���������");
			return;
		}
	
		var trObj = $(bt).parent().parent();
		var role_code = trObj.find("td:eq(1)").text().trim();
		var role_name = trObj.find("td:eq(0)").text().trim();
		
		var inCheckFlag = trObj.find("td:eq(4)").text().trim();//��ɫУ���ʶ
		
		
		$("#operRoleId").val(role_code);
		$("#operRolename").val(role_name);
		$("#inCheckFlag").val(inCheckFlag);
		
		
		$("#role_name_span").text(role_name+"-");
		
		$("#phoneNo").val("");
		$("#phoneNo").removeAttr("readOnly");
		$("#phoneNo").removeClass("InputGrey");
		$("#pwdContent").show();
		$("#sel_kd_flag").hide();
		
		if("21098"==role_code){//������
			$("#pwdContent").hide();
			$("#phoneNo").val("<%=activePhone%>");
			$("#phoneNo").attr("readOnly","readOnly");
			$("#phoneNo").addClass("InputGrey");
		}
		
		if("21097"==role_code){//���
			$("#sel_kd_flag").show();
		}
		
		if("21099"==role_code){// 207����
				$("#pwdContent").hide();
				$("#phoneNo").val(phone_207);
				$("#phoneNo").attr("readOnly","readOnly");
				$("#phoneNo").addClass("InputGrey");
		}
		
		$("#opr_info").show();
}

function addFamily(obj){
	$(obj).attr("disabled","disabled");
//	showBar();
	var myPacket = new AJAXPacket("fm357_8.jsp","���ڴ�����ͥ�����Ժ�......");
	myPacket.data.add("iLoginAccept","0");
	myPacket.data.add("iChnSource","01");
	myPacket.data.add("iOpCode","g629");	
	myPacket.data.add("iLoginNo","<%=workNo%>");
	myPacket.data.add("iLoginPwd","<%=password%>");
	myPacket.data.add("iPhoneNo","<%=activePhone%>");					//����
	myPacket.data.add("iUserPwd","");		//����
	core.ajax.sendPacket(myPacket, do_addFamily);
}
function do_addFamily(packet) {
	var code = packet.data.findValueByName("code");
	var msg = packet.data.findValueByName("msg");
	if (code=="000000") {
		var phone207 = packet.data.findValueByName("phone207");
		setFamilyNum(phone207);
		rdShowMessageDialog("��ͥ�ͻ������ɹ�!");
	}else{
		rdShowMessageDialog(msg);
	}
}

function setFamilyNum(phone207){
	phone_207=phone207;
	vChkFlag="N";
}

function go_sel_GearCode(){
	if($("#sel_ProdCode").val()=="JTFX"){
		//rdShowMessageDialog("�ͼҷ����ͥ��Ʒ����ǰ�����������ֻ���Ա���");
		$("#tr_JTFX_hit").show();
	}else{
		$("#tr_JTFX_hit").hide();
	}
	if($("#sel_ProdCode").val()!=""){
		go_ajax_sm357Qry("1",$("#sel_ProdCode").val(),"","<%=activePhone%>");
		$("#table_Role_result tr:gt(0)").remove();
		$("#table_RoleCode tr:gt(0)").remove();
		
	}
}
function go_sel_RoleCode(){
	if($("#sel_GearCode").val()!=""){
		go_ajax_sm357Qry("2","",$("#sel_GearCode").val(),"<%=activePhone%>");
		$("#table_Role_result tr:gt(0)").remove();
	}
	if($("#sel_GearCode").val()=="D022"){
			$("#tr_JTFX_hit").hide();
	}
}

function close_mem(){
	$("#phoneNo").val("");
	$("#pwdContent").show();
	$("#opr_info").hide();
	$("#operRoleId").val("");
	$("#operRolename").val("");
	$("#inCheckFlag").val("");
	$("#role_name_span").text("");
	
	$("input[name='phonePwd']").val("");
	$("#sel_kd_flag").hide();
}

//У��&��ӳ�Ա ��ť
function check_and_add(){
	if($("#phoneNo").val()==""){
			rdShowMessageDialog("�������ֻ�����");
			return;
	}
	var phone_no_flag = false;
	//�ж��ֻ����Ƿ��Ѿ�������ӽ�ɫ�б�
	$("#table_Role_result tr:gt(0)").each(function(){
		var phone_no = $(this).find("td:eq(0)").text().trim();
		if(phone_no==$("#phoneNo").val().trim()){
				phone_no_flag = true;//�ҵ�������
				return false;
		}
	});	
	
	if(phone_no_flag){
			rdShowMessageDialog("���ֻ����Ѿ���������ӽ�ɫ�б�");
			return;
	}
		
	if($("#operRoleId").val()=="21098"||$("#operRoleId").val()=="21099"){//�����ˣ�207���룬����ҪУ������
		add_to_memtable();
		
	}else{
		var phoneNo_209 = "";
		
		if($("#operRoleId").val()=="21097"){//�����ȥ��ѯ��Ӧ209����
			var packet = new AJAXPacket("fm357_6.jsp","���Ժ�...");
		      packet.data.add("CFM_LOGIN",$("#phoneNo").val());//�ֻ���
		    core.ajax.sendPacket(packet,function(packet){
		    		var error_code = packet.data.findValueByName("code");//���ش���
    				var error_msg =  packet.data.findValueByName("msg");//������Ϣ
    					if (error_code != "000000") {
								/*  0ʧ��    */
								rdShowMessageDialog("��ѯʧ��");
							}else{
								/* 1�ɹ� */
								
								var retArray = packet.data.findValueByName("retArray");
								if(retArray.length>0){
									phoneNo_209 = retArray[0][0];		
								}
							}
		    	});
		    packet =null;
		    
		    if(""==phoneNo_209){
					rdShowMessageDialog("δ��ѯ����Ӧ209����");
					return;
				}
		}
		
		
		
		var userPsw = $("input[name='phonePwd']").val();
		if(userPsw == ""){
			rdShowMessageDialog("�������ֻ�����");
			return false;
		}
		
		var phoneNo_pwd_check = $("#phoneNo").val();
		if($("#operRoleId").val()=="21097"){//�����ȥ��ѯ��Ӧ209����
			phoneNo_pwd_check = phoneNo_209;
		}
		
		var checkPwd_Packet = new AJAXPacket("/npage/public/pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
				checkPwd_Packet.data.add("custType","01");				//01:�ֻ����� 02 �ͻ�����У�� 03�ʻ�����У��
				checkPwd_Packet.data.add("phoneNo",phoneNo_pwd_check);	//�ƶ�����,�ͻ�id,�ʻ�id
				checkPwd_Packet.data.add("custPaswd",userPsw);//�û�/�ͻ�/�ʻ�����
				checkPwd_Packet.data.add("idType","");				//en ����Ϊ���ģ�������� ����Ϊ����
				checkPwd_Packet.data.add("idNum","");					//����
				checkPwd_Packet.data.add("loginNo","<%=workNo%>");		//����
				core.ajax.sendPacket(checkPwd_Packet, doCheckPwd);
	}
				
}
function doCheckPwd(packet) {
		var retResult = packet.data.findValueByName("retResult");
		var msg = packet.data.findValueByName("msg");
		if (retResult != "000000") {
			/*  0ʧ��    */
			rdShowMessageDialog(msg);
		}else{
			/* 1�ɹ� */
			
			add_to_memtable();			
		}
}

//���һ�е�ҵ�������б�
function add_to_memtable(){
	//�ȵ���У��������
		var packet = new AJAXPacket("fm357_4.jsp","���Ժ�...");
	      packet.data.add("opCode","<%=opCode%>");//
	      packet.data.add("activePhone","<%=activePhone%>");//
	      packet.data.add("phoneNo",$("#phoneNo").val());//�ֻ���
	      packet.data.add("inCheckFlag",$("#inCheckFlag").val());//
	      if($("#operRoleId").val()=="21097"){
	      	packet.data.add("sel_kd_flag",$("#sel_kd_flag").val());//	
	      	packet.data.add("kd_phoneNo",$("#phoneNo").val());//	
	      }
	      
	    core.ajax.sendPacket(packet,do_add_to_memtable);
	    packet =null;
}

function do_add_to_memtable(packet){
		var error_code = packet.data.findValueByName("code");//���ش���
    var error_msg =  packet.data.findValueByName("msg");//������Ϣ

    if(error_code=="000000"){//�����ɹ�
    	
    		var tr_html = "<tr>"+
								"<td>"+$("#phoneNo").val()+"</td>"+
								"<td style='display:none'>"+$("#operRoleId").val()+"</td>"+
								"<td>"+$("#operRolename").val()+"</td>"+
								"<td><input type='button' value='ɾ��' class='b_text' onclick='delete_mem(this)' /></td>"+
								"</tr>";
	
					$("#table_Role_result").append(tr_html);
					
					//ˢ�¼�ͥ��ɫ��Ϣ���������������Ӱ�ť�û�
					ref_table_RoleCode();
					
					close_mem();
    }else{//���÷���ʧ��
    	rdShowMessageDialog(error_code+":"+error_msg);
	    return;
    }
}

function ref_table_RoleCode(){
	
	//�ȿ�����ӽ�ɫ�б����м��ֽ�ɫ
	var role_re_array = new Array();//�洢�Ѿ���ӵĽ�ɫ����
	$("#table_Role_result tr:gt(0)").each(function(){
		role_re_array.push($(this).find("td:eq(1)").text().trim());
	});
	
	$("#table_RoleCode tr:gt(0)").each(function (){
			var rolename = $(this).find("td:eq(0)").text().trim();
			
			var role_id_JTFX = $(this).find("td:eq(1)").text().trim();
			
		//alert("sel_ProdCode=["+$("#sel_ProdCode").val()+"]"+"\nrole_id_JTFX=["+role_id_JTFX+"]");
		
		  if(("JTFX"==$("#sel_ProdCode").val()||"JTHB"==$("#sel_ProdCode").val())&&"21096"==role_id_JTFX&&$("#sel_GearCode").val()!="D022"){
		  	
    	}else{
		    	
				var temp_count = 0;
				var roleCode = $(this).find("td:eq(1)").text().trim();
				//������ӵĽ�ɫ������Ѱ�ҵ�ǰ�еĽ�ɫ���룬�ҵ�һ������1
				for(var i=0;i<role_re_array.length;i++){
					if(roleCode==role_re_array[i]){
						temp_count ++;
					}
				}
				
				//�������������
				$(this).find("td:eq(5)").text(temp_count);
				//�������
				var max_num = $(this).find("td:eq(3)").text().trim();
				
				
				//����������������ӵ�������ͬ���û���Ӱ�ť
				if(temp_count==max_num){
					$(this).find("td:last").find("input").attr("disabled","disabled");
				}else{
					//ɾ����ʱ��С���������
					$(this).find("td:last").find("input").removeAttr("disabled");
				}
			}
	});
}

function delete_mem(bt){
	if(rdShowConfirmDialog('ȷ��ɾ����¼��')!=1) return;
	$(bt).parent().parent().remove();
	ref_table_RoleCode();
}


function go_cfm(){


	if($("#table_RoleCode tr:gt(0)").size()==0){
		rdShowMessageDialog("���ѯ��ͥ��ɫ");
		return;
	}
	
	var max_min_chenk = false;
	var temp_role_name = "";
	//��С���������У��
		$("#table_RoleCode tr:gt(0)").each(function (){
			var rolename = $(this).find("td:eq(0)").text().trim();
			//���������
			var add_num = $(this).find("td:eq(5)").text().trim();
			
			//�������
			var max_num = $(this).find("td:eq(3)").text().trim();
			//��С����
			var min_num = $(this).find("td:eq(2)").text().trim();
			
			if(parseInt(add_num)<parseInt(min_num)){
				max_min_chenk = true;
				temp_role_name = rolename;
				return false;
			}
	});
	
	if(max_min_chenk){
		rdShowMessageDialog(temp_role_name+"�Ľ�ɫ�������С����С����");
		return;
	}
	
	// showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes"); 
   if(rdShowConfirmDialog("ȷ��Ҫ�ύ��Ϣ��")!=1) return;
	   
	
		//var in_json = "{    \"OPR_INFO\": {        \"PHONE_NO\": \"123456\",        \"OP_CODE\": \"\",        \"LOGIN_NO\": \"\",        \"LOGIN_ACCEPT\": \"\",        \"BACK_ACCEPT\": \"\",        \"OPR_TIME\": \"\"    },    \"BUSI_INFO\": {        \"MAIN_OFFER_LIST\": [            {                \"PHONE_NO\": \"\",                \"EFF_TYPE\": \"\",                \"OFFER_ID\": \"\"            }        ],        \"ADD_OFFER_LIST\": [            {                \"PHONE_NO\": \"11111\",                \"EFF_TYPE\": \"\",                \"OFFER_ID\": \"\",                \"OPERATE_TYPE\": \"\"            },            {                \"PHONE_NO\": \"22222\",                \"EFF_TYPE\": \"\",                \"OFFER_ID\": \"\",                \"OPERATE_TYPE\": \"\"            }        ],        \"SP_OFFER_LIST\": [            {                \"PHONE_NO\": \"\",                \"EFF_TYPE\": \"\",                \"OFFER_ID\": \"\",                \"OPERATE_TYPE\": \"\"            }        ],        \"GROUP_INFO_LIST\": [            {                \"OPERATE_TYPE\": \"I\",                \"PHONE_NO\": \"123\",                \"GROUP_ID\": \"1111111\",                \"EFF_DATE\": \"yyyymmdd hh24:mi:ss\",                \"EXP_DATE\": \"yyyymmdd hh24:mi:ss\",                \"MEMBER_ROLE_ID\": \"\",                \"MEMBER_TYPE_ID\": \"\"            },            {                \"OPERATE_TYPE\": \"I\",                \"PHONE_NO\": \"456\",                \"GROUP_ID\": \"111111\",                \"EFF_DATE\": \"yyyymmdd hh24:mi:ss\",                \"EXP_DATE\": \"yyyymmdd hh24:mi:ss\",                \"MEMBER_ROLE_ID\": \"\",                \"MEMBER_TYPE_ID\": \"\"            }        ]    }}";
		//ƴ���json
		var OPR_INFO_json = {
													"PHONE_NO":"<%=activePhone%>",
									        "OP_CODE": "<%=opCode%>",
									        "LOGIN_NO": "<%=workNo%>",
									        "LOGIN_ACCEPT": "<%=sysAcceptl%>",
									        "BACK_ACCEPT": "",
									        "OPR_TIME": "<%=currentDate%>",
									        "OP_NOTE":"��ͥ�û����Ա��ϵ����",
									        "CHK_FLAG":"<%=vChkFlag%>",
									        "PROD_CODE":$("#sel_ProdCode").val(),
                					"PROD_CODE_DW":$("#sel_GearCode").val(),
                					"GROUP_ID":"<%=role_group_id%>"
												};
		
		var GROUP_INSTANCE_json = {
				 				"GROUP_OPERATE_TYPE": "I",
                "GROUP_ID": "<%=role_group_id%>",
                "EFF_DATE": "<%=currentDate%>",
                "EXP_DATE": "20500101 00:00:00",
                "GROUP_TYPE_ID": "24",
                "PROD_CODE":$("#sel_ProdCode").val(),
                "PROD_CODE_DW":$("#sel_GearCode").val(),
                "GROUP_DESC":$("#sel_ProdCode option:selected").text()
			};
			
		var GROUP_INSTANCE_MEMBER_LIST = [];
		var LOGINOPR_json = [];
		
     $("#table_Role_result tr:gt(0)").each(function(){
     			
     			//�����˺���ͨ��Ա��PH  ����û���KD ������봫XN  �ý����ɫ���жϾ���
     			var MEMBER_TYPE_temp = "";
     			if("21098"==$(this).find("td:eq(1)").text().trim()||"21096"==$(this).find("td:eq(1)").text().trim()){
     				MEMBER_TYPE_temp = "PH";
     			}
     			if("21097"==$(this).find("td:eq(1)").text().trim()){
     				MEMBER_TYPE_temp = "KD";
     			}
     			if("21099"==$(this).find("td:eq(1)").text().trim()){
     				MEMBER_TYPE_temp = "XN";
     			}
     			
					var temp_member_json = 		{
                    "MEMBER_OPERATE_TYPE": "I",
                    "PHONE_NO": $(this).find("td:eq(0)").text().trim(),
                    "GROUP_ID": "<%=role_group_id%>",
                  	"EFF_DATE": "<%=currentDate%>",
                		"EXP_DATE": "20500101 00:00:00",
                    "MEMBER_ROLE_ID":$(this).find("td:eq(1)").text().trim(),
                    "MEMBER_TYPE_ID": "4",
                    "MEMBER_TYPE":MEMBER_TYPE_temp,
                    "MEMBER_DESC":$(this).find("td:eq(2)").text().trim()
          };		
          
          var temp_json = {"PHONE_NO":$(this).find("td:eq(0)").text().trim()};
          LOGINOPR_json.push(temp_json);
          
          GROUP_INSTANCE_MEMBER_LIST.push(temp_member_json);
			});           
		
		
		
		var BUSI_INFO_json = {
					"GROUP_INFO":{
						"GROUP_INSTANCE":GROUP_INSTANCE_json,
						"GROUP_INSTANCE_MEMBER_LIST":GROUP_INSTANCE_MEMBER_LIST
					},
					"LOGINOPR":LOGINOPR_json
		};      
		
					          
		var in_json_obj = {
												"OPR_INFO":OPR_INFO_json,
												"BUSI_INFO":BUSI_INFO_json
											};
		
		
		var in_JSONText = JSON.stringify(in_json_obj,function(key,value){
													return value;
											});
				
				
		//alert(in_JSONText);	
		
		var packet = new AJAXPacket("fm357_3.jsp","���Ժ�...");
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
    		var returnFlag = rdShowMessageDialog("�����ɹ�!",2);
    		//alert(returnFlag);
    		//alert(returnFlag=="1");
    		if(returnFlag=="1"){
    			var path="/npage/sm358/fm358_1.jsp?opCode=m358&opName=��ͥ��Ʒ����&crmActiveOpCode=m358&activePhone=<%=activePhone%>&broadPhone=";
    			parent.addTab(false,"m358","��ͥ��Ʒ����",path);
    		}
    		//rdShowMessageDialog("�뵽m358������ͥ��Ʒ����!",1);
	     // removeCurrentTab();
    		parent.removeTab("m357");
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
		//��ӡģ��idΪ��
    function printInfo(printType){
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
      						
      opr_info += "ҵ��������ƣ���ͥ�û����Ա��ϵ����    ������ˮ: "+"<%=sysAcceptl%>" +"|";
      opr_info += "��ͥ�������룺<%=activePhone%>"+"|";
      
			opr_info += "����������ͥ��Ա���룺";
			var temp_phone_no = "";
      $("#table_Role_result tr:gt(0)").each(function(){
				var phone_no = $(this).find("td:eq(0)").text().trim();
				temp_phone_no += phone_no+"��"	;
			});	
			if(temp_phone_no.length>0){
				temp_phone_no = temp_phone_no.substring(0,temp_phone_no.length-1);
			}
			opr_info   += temp_phone_no+"|";
			
      note_info1 += "������ͥ��Ʒǰ��������Ա������Ч��ɾ����Ա������Ч"+"|";
      note_info1 += "������ͥ��Ʒ��������Ա������Ч��ɾ����Ա������Ч"+"|";
      
      retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
      retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
      return retInfo;
    }

function go_get_prt_info(){
		var packet = new AJAXPacket("fm357_7.jsp","���Ժ�...");
	      packet.data.add("opCode","<%=opCode%>");// 
	      packet.data.add("phoneNo","<%=activePhone%>");//�ֻ���
	      packet.data.add("inProdCode",$("#sel_ProdCode").val());//
	      packet.data.add("inGearCode",$("#sel_GearCode").val());//
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

</SCRIPT>
</HEAD>	
<BODY>
<div id="background" class="background" style="display: none; "></div> 
<div id="progressBar" class="progressBar" style="display: none; ">��ͥ�����У����Ժ�...</div>
<FORM name="msgFORM" action="" method="post"> 
<input type="hidden" id="prt_cust_name" name="prt_cust_name" value="" />
<input type="hidden" id="prt_cust_bran" name="prt_cust_bran" value="" />
<input type="hidden" id="prt_note_into" name="prt_note_into" value="" />

	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi">ѡ���Ʒ</div></div>


<table cellSpacing="0">
	<tr>
	    <td class="blue" width="20%">��ͥ��Ʒ</td>
		  <td width="30%">
			    <select id="sel_ProdCode" onchange="go_sel_GearCode()" >
			    	<option value="">--��ѡ��--</option>
			    </select>
		  </td>
 
	    <td class="blue" width="20%">��Ʒ��λ</td>
		  <td width="30%">
			    <select id="sel_GearCode" onchange="go_sel_RoleCode()" style="width:200px" >
			    	<option value="">--��ѡ��--</option>
			    </select>
		  </td>
	</tr>
	<tr>
		<td class="blue">Ⱥ��</td>
		<td>
			<input type="text" id="group_id" readonly class="InputGrey" value="<%=role_group_id%>" />
		</td>
		<td colspan="2"><b style="font: 20;color: red">�����ͥ��Ա��ϵǰ�����ȵ������ͥ��������ť</b></td>
	</tr>
	
	<tr id="tr_JTFX_hit" style="display:none">
			<td colspan="4">
				<font class="orange">�ͼҷ����ͥ��Ʒ����ǰ�����������ֻ���Ա���</font> 
			</td>	
	</tr>
</table>

<div class="title"><div id="title_zi">��ͥ��ɫ��Ϣ</div></div>
<table cellSpacing="0" id="table_RoleCode">
	<tr>
		<th width="25%">��ɫ����</th>
		<th style="display:none">��ɫ����</th>
		<th width="20%">��С����</th>
		<th width="20%">�������</th>
		<th width="20%">���������</th>
		<th>����</th>
	</tr>
</table>

<div id="opr_info" style="display:none">
<div class="title"><div id="title_zi">ҵ������</div></div>
	<table>
			<tr>
				<td class="blue" width="30%" id="chenynames"><span id="role_name_span"></span>��Ա�ֻ�����</td>
				<td width="30%">
					<input type="text" id="phoneNo" name="phoneNo"  />
					<input type="hidden" id="operRoleId" name="operRoleId" />
					<input type="hidden" id="operRolename" name="operRolename" />
					<input type="hidden" id="inCheckFlag" name="inCheckFlag" />
					<select id="sel_kd_flag" style="display:none" >
						<option value="N">δ����</>
						<option value="Y">����</>
					</select>
				</td>
				<td class="blue" width="10%">����</td>
				<td>
					<span id="pwdContent">
						<jsp:include page="/npage/common/pwd_1.jsp">
							<jsp:param name="width1" value="16%"/>
							<jsp:param name="width2" value="34%"/>
							<jsp:param name="pname" value="phonePwd"/>
							<jsp:param name="pwd" value=""/>
						</jsp:include>
					</span>
				</td>
			</tr>
			<tr>
				<td id="footer" colspan="4">
					<input type="button" class="b_foot" value="У��&��ӳ�Ա" onclick="check_and_add()"           />
					<input type="button" class="b_foot" value="ȡ��"          onclick="close_mem()"           />
				</td>
			</tr>
		</table>
</div>

<div class="title"><div id="title_zi">����ӽ�ɫ</div></div>
<table cellSpacing="0" id="table_Role_result">
	<tr>
		<th width="50%">�ֻ�����</th>
		<th width="30%">��ɫ</th>
		<th>����</th>
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

<%@ include file="/npage/include/footer.jsp" %>
<jsp:include page="/npage/common/pwd_comm.jsp"/>
</FORM>
<iframe id="addFamily" src="" width="100%" style="display:none "></iframe>

</BODY>
</HTML>