<%
/********************
 
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa)2016-3-4 15:52:06------------------
 

 -------------------------��̨��Ա��wangzc��zuolf--------------------------------------------
 
********************/
%>
              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@page import="java.util.Date"%>

<%
	String opCode        = WtcUtil.repNull(request.getParameter("opCode"));
  String opName        = WtcUtil.repNull(request.getParameter("opName"));
  String activePhoneNo = WtcUtil.repNull(request.getParameter("activePhoneNo"));
  String phoneNo_207   = WtcUtil.repNull(request.getParameter("phoneNo_207"));
  String vChkFlag   = WtcUtil.repNull(request.getParameter("vChkFlag"));
  
  String workNo    = (String)session.getAttribute("workNo");
  String password  = (String)session.getAttribute("password");
  String workName  = (String)session.getAttribute("workName");
  String orgCode   = (String)session.getAttribute("orgCode");
  String ipAddrss  = (String)session.getAttribute("ipAddr");
  String regionCode = (String)session.getAttribute("regCode");
  
	java.util.Calendar cal = java.util.Calendar.getInstance(); 
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
	System.out.println("--hejwa----fm357_5.jsp------AAAAAAAAAAA-----Currentdate--AAAAAAAAAAA----------->"+currentDate);
		
	cal.add(Calendar.MONTH, 1); 
	cal.set(Calendar.DATE, 1); 
	String n_month_Date = new java.text.SimpleDateFormat("yyyyMMdd HH:mm:ss").format(new java.util.Date(cal.getTimeInMillis()));
	String n_month_Date1 = new java.text.SimpleDateFormat("yyyyMMdd 00:00:00").format(new java.util.Date(cal.getTimeInMillis()));
	
	String paraAray[] = new String[8];
	paraAray[0] = "";                                       //��ˮ
	paraAray[1] = "01";                                     //��������
	paraAray[2] = opCode;                                   //��������
	paraAray[3] = (String)session.getAttribute("workNo");   //����
	paraAray[4] = (String)session.getAttribute("password"); //��������
	paraAray[5] = activePhoneNo;                            //�û�����
	paraAray[6] = "";       
	paraAray[7] = "3";    
	
	System.out.println("---hejwa----------------phoneNo_207------------------"+phoneNo_207);
	System.out.println("---hejwa----------------activePhoneNo------------------"+activePhoneNo);
%> 
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAcceptl" /> 
		
  <wtc:service name="sm357Qry" outnum="10" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=paraAray[0]%>" />
		<wtc:param value="<%=paraAray[1]%>" />	
		<wtc:param value="<%=paraAray[2]%>" />
		<wtc:param value="<%=paraAray[3]%>" />
		<wtc:param value="<%=paraAray[4]%>" />
		<wtc:param value="<%=paraAray[5]%>" />
		<wtc:param value="<%=paraAray[6]%>" />
		<wtc:param value="<%=paraAray[7]%>" />	
	</wtc:service>
	<wtc:array id="result_t2" scope="end"  />
		
<%
	
	
	String j_ProdCode = "";
	String j_ProdName = "";
	String j_GearCode = "";
	String j_GearName = "";
	String j_group_id = "";
	String j_order_marked="";
	String j_eff_date="";
	String j_exp_date="";
	
	String j_prod_flag = "";
	
	System.out.println("hejwa--------------currentDate-------------->"+currentDate);
		
	if("000000".equals(code)){
		if(result_t2.length>0){
			j_ProdCode = result_t2[0][1];
			j_ProdName = result_t2[0][0];
			j_GearCode = result_t2[0][3];
			j_GearName = result_t2[0][2];
			j_group_id = result_t2[0][4];
			j_order_marked = result_t2[0][6];//1,δ����;2�Ѷ��� 
			j_eff_date = result_t2[0][7];
			j_exp_date = result_t2[0][8];
			j_prod_flag = result_t2[0][9];
		}
		if(j_eff_date.equals("2")){
			Date dt1 = new java.text.SimpleDateFormat("yyyyMMdd HH:mm:ss").parse(currentDate);
			Date dt2 = new java.text.SimpleDateFormat("yyyyMMdd HH:mm:ss").parse(j_eff_date.equals("")?currentDate:j_eff_date);
		 	
			if(dt1.getTime()>dt2.getTime()){
				j_eff_date=currentDate;
			}
		}
		
	}else{
%>
<SCRIPT language=JavaScript>
	rdShowMessageDialog("sm357CheckУ�����<%=code%>��<%=msg%>");
	removeCurrentTab();
</SCRIPT>
<%		
	}
	System.out.println("hejwa--------------currentDate-------------->"+currentDate);
	System.out.println("hejwa--------------j_eff_date--------------->"+j_eff_date);
	
	String paraAray1[] = new String[11];
	paraAray1[0] = "";                                       //��ˮ
	paraAray1[1] = "01";                                     //��������
	paraAray1[2] = opCode;                                   //��������
	paraAray1[3] = (String)session.getAttribute("workNo");   //����
	paraAray1[4] = (String)session.getAttribute("password"); //��������
	paraAray1[5] = activePhoneNo;                            //�û�����
	paraAray1[6] = "";       
	paraAray1[7] = "4";    	
	paraAray1[8] = j_ProdCode;    	
	paraAray1[9] = j_GearCode;    	
	paraAray1[10] = j_group_id;    	
%>

  <wtc:service name="sm357Qry" outnum="10" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=paraAray1[0]%>" />
		<wtc:param value="<%=paraAray1[1]%>" />	
		<wtc:param value="<%=paraAray1[2]%>" />
		<wtc:param value="<%=paraAray1[3]%>" />
		<wtc:param value="<%=paraAray1[4]%>" />
		<wtc:param value="<%=paraAray1[5]%>" />
		<wtc:param value="<%=paraAray1[6]%>" />
		<wtc:param value="<%=paraAray1[7]%>" />	
		<wtc:param value="<%=paraAray1[8]%>" />	
		<wtc:param value="<%=paraAray1[9]%>" />	
		<wtc:param value="<%=paraAray1[10]%>" />				
	</wtc:service>
	<wtc:array id="result_t3" scope="end"  />


<%
		 String paraAray3[] = new String[8];
						paraAray3[0] = "";                                       //��ˮ
						paraAray3[1] = "01";                                     //��������
						paraAray3[2] = opCode;                                   //��������
						paraAray3[3] = (String)session.getAttribute("workNo");   //����
						paraAray3[4] = (String)session.getAttribute("password"); //��������
						paraAray3[5] = activePhoneNo;                            //�û�����
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
		
<%

String out_8_isN = "";
String JT032_isN = "";
String JT023_isN = "";


System.out.println("--------hhhh----result_t4----->"+result_t4.length);

for(int i=0; i<result_t4.length;i++)	{

System.out.println("--------hhhh----result_t4["+i+"][4]--------------->"+result_t4[i][4]);
			if(
					"JT030".equals(result_t4[i][4])
				||"JT049".equals(result_t4[i][4])
				||"JT058".equals(result_t4[i][4])
				||"JT068".equals(result_t4[i][4])
				||"JT078".equals(result_t4[i][4])
				||"JT139".equals(result_t4[i][4])
				){
				out_8_isN = result_t4[i][9];
				
				System.out.println("--------hhhh----out_8_isN--------------->"+out_8_isN);
			}
	
	
		if(
				"JT032".equals(result_t4[i][4])
			||"JT051".equals(result_t4[i][4])
			||"JT060".equals(result_t4[i][4])
			||"JT070".equals(result_t4[i][4])
			||"JT080".equals(result_t4[i][4])
			){
			JT032_isN = result_t4[i][9];
				System.out.println("--------hhhh----JT032_isN--------------->"+JT032_isN);
		}
		
		
			if(
				"JT023".equals(result_t4[i][4])
			||"JT032".equals(result_t4[i][4])
			||"JT035".equals(result_t4[i][4])
			||"JT040".equals(result_t4[i][4])
			){
			JT023_isN = result_t4[i][9];
		}

}

%>
<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<script language="javascript" type="text/javascript" src="/npage/public/json2.js"></script>	
<SCRIPT language=JavaScript>

	
//����ˢ��ҳ��
function reSetThis(){
	  location = location;	
}

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
	    if("2"==inQryType){//��ѯ��ɫ
	    	$("#table_RoleCode tr:gt(0)").remove();
	    	
	    	var in_html = "";
	    	
	    	var JTFX_disabled = "";
	    	var is8N_disabled = "";
	    	var JT032_disabled = "";
	    	var JT023_disabled = "";
	    	
	    	for(var i=0;i<retArray.length;i++){
	    		var disabled_flag = "";
	    		if(parseInt(retArray[i][5])>=parseInt(retArray[i][3])){
	    				disabled_flag = "disabled";
	    		}else{
	    				disabled_flag = "";
	    		}

	    		if("JTFX"=="<%=j_ProdCode%>"&&"21096"==retArray[i][1]&&"<%=j_order_marked%>"=="1"	){//�û�
		    		JTFX_disabled = "disabled";
		    	}else{
		    		JTFX_disabled = "";
		    	}


					if(("JTFX"=="<%=j_ProdCode%>"||"JTHB"=="<%=j_ProdCode%>")&&"21096"==retArray[i][1]&&"<%=out_8_isN%>"=="N"	){//�û�
						is8N_disabled	 = "disabled";		    		
			 		}else{
		    		is8N_disabled = "";
		    	}


					if("JTFX"=="<%=j_ProdCode%>"&&"21095"==retArray[i][1]&&"<%=JT032_isN%>"=="N"	){//�û�
						JT032_disabled	 = "disabled";		    		
			 		}else{
		    		JT032_disabled = "";
		    	}
		    	
		    	if("JTHX"=="<%=j_ProdCode%>"&&"21095"==retArray[i][1]&&"<%=JT023_isN%>"=="N"	){//�û�
						JT023_disabled	 = "disabled";		    		
			 		}else{
		    		JT023_disabled = "";
					}
		    						
		    						
		    	if("<%=j_GearCode%>"=="D022"){
		    		is8N_disabled = "";
		    	}					
		    	
		    	 
		    	
	    		in_html += "<tr>"+
	    							 "<td>"+retArray[i][0]+"</td>"+
	    							 "<td style='display:none'>"+retArray[i][1]+"</td>"+
	    							 "<td>"+retArray[i][2]+"</td>"+
	    							 "<td>"+retArray[i][3]+"</td>"+
	    							 "<td style='display:none'>"+retArray[i][4]+"</td>"+
	    							 "<td v_att_num='"+retArray[i][5]+"'>"+retArray[i][5]+"</td>"+
	    							 "<td style='display:none'>"+retArray[i][6]+"</td>"+
	    							 "<td><input type='button' class='b_text' value='���' onclick='add_role_mem(this)' "+disabled_flag+"   "+JTFX_disabled+"  "+is8N_disabled+ " "+JT032_disabled+" "+JT023_disabled+" /></td>"+
	    							 "</tr>";
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
		
		
		$("#op_type").val("i");//��־λΪ���
		$("#operRoleId").val(role_code);
		$("#operRolename").val(role_name);
		$("#inCheckFlag").val(inCheckFlag);
		
		$("#op_6_flag").val(trObj.find("td:eq(6)").text().trim());
		
		
		$("#role_name_span").text(role_name+"-");
		
		$("#phoneNo").val("");
		$("#phoneNo").removeAttr("readOnly");
		$("#phoneNo").removeClass("InputGrey");
		$("#pwdContent").show();
		$("#sel_kd_flag").hide();
		
		if("21098"==role_code){//������
			$("#pwdContent").hide();
			$("#phoneNo").val("<%=activePhoneNo%>");
		}
		
		if("21097"==role_code){//���
			$("#sel_kd_flag").show();
		}
		
		if("21099"==role_code){// 207����
				$("#phoneNo").val("<%=phoneNo_207%>");
				$("#phoneNo").attr("readOnly","readOnly");
				$("#phoneNo").addClass("InputGrey");
		}
		

		$("#opr_info").show();
}


function close_mem(i){
	
	if($("#phoneNo_upd").val()!=""&&i!=1){//����ĺ��벻Ϊ���ǵ�������ť
		$("#btn_del_mem").removeAttr("disabled");
	 	$("#btn_upd_mem").removeAttr("disabled");
	}
	
	$("#phoneNo").val("");
	$("#pwdContent").show();
	$("#opr_info").hide();
	$("#operRoleId").val("");
	$("#op_type").val("");
	
	$("#operRolename").val("");
	$("#phoneNo_upd").val("");
	$("#shengxiaoshijian").val("");
	
	$("#inCheckFlag").val("");
	$("#op_6_flag").val("");
	
	
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
	
	
	//�ж��ֻ����Ƿ��Ѿ�������ӽ�ɫ�б�
	$("#old_mem_table tr:gt(0)").each(function(){
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
		
	if($("#operRoleId").val()=="21098"){//�����ˣ�����ҪУ������
		add_to_memtable();
		
	}else{
	
		
		var userPsw = $("input[name='phonePwd']").val();
		if(userPsw == ""){
			rdShowMessageDialog("�������ֻ�����");
			return false;
		}
		
		var checkPwd_Packet = new AJAXPacket("/npage/public/pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
				checkPwd_Packet.data.add("custType","01");				//01:�ֻ����� 02 �ͻ�����У�� 03�ʻ�����У��
				checkPwd_Packet.data.add("phoneNo",$("#phoneNo").val());	//�ƶ�����,�ͻ�id,�ʻ�id
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
	    	packet.data.add("phoneNo",$("#phoneNo").val());//�ֻ��� 
	    	packet.data.add("activePhone","<%=activePhoneNo%>");//
	    	
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
    		var op_type="";
    		var phoneNo_td = "";
    		var del_funcname = "";
    		if($("#op_type").val()=="i"){
    			op_type = "���";
    			phoneNo_td = $("#phoneNo").val();
    			del_funcname = "delete_mem(this)";
    		}else if($("#op_type").val()=="u"){
    			op_type = "���";
    			phoneNo_td = $("#phoneNo_upd").val() +"->"+$("#phoneNo").val();
    			del_funcname = "d_tr_del_mem(this)";
    		}
    		
    		
    		var tr_html = "<tr>"+
								"<td>"+phoneNo_td+"</td>"+
								"<td style='display:none'>"+$("#operRoleId").val()+"</td>"+
								"<td>"+$("#operRolename").val()+"</td>"+
								"<td>"+op_type+"</td>"+
								"<td><input type='button' value='ɾ��' class='b_text' onclick='"+del_funcname+"' /></td>"+
								"<td style='display:none'>"+$("#op_type").val()+"</td>"+//��־λ �˶�����ӡ����
								"<td style='display:none'>"+$("#shengxiaoshijian").val()+"</td>"+//��Чʱ��
								"<td style='display:none'>"+$("#op_6_flag").val()+"</td>"+
								"</tr>";
					$("#table_Role_result").append(tr_html);
					
					//ˢ�¼�ͥ��ɫ��Ϣ���������������Ӱ�ť�û�
					ref_table_RoleCode();
					
					close_mem(1);
    }else{//���÷���ʧ��
    	rdShowMessageDialog(error_code+":"+error_msg);
	    return;
    }
}

function ref_table_RoleCode(){
	var role_re_array = new Array();//�洢�Ѿ���ӵĽ�ɫ����
	$("#table_Role_result tr:gt(0)").each(function(){
		var td_flag = $(this).find("td:eq(5)").text().trim();
		if(td_flag=="i"){
			role_re_array.push($(this).find("td:eq(1)").text().trim());
		}
	});
	
		$("#table_RoleCode tr:gt(0)").each(function (){
			var rolename = $(this).find("td:eq(0)").text().trim();
			
			var temp_count = 0;
			var roleCode = $(this).find("td:eq(1)").text().trim();
			
			//������ӵĽ�ɫ������Ѱ�ҵ�ǰ�еĽ�ɫ���룬�ҵ�һ������1
			for(var i=0;i<role_re_array.length;i++){
				if(roleCode==role_re_array[i]){
					temp_count ++;
				}
			}
			
			//�������������
			$(this).find("td:eq(5)").text((parseInt($(this).find("td:eq(5)").attr("v_att_num"))+parseInt(temp_count)));
			//�������
			var max_num = $(this).find("td:eq(3)").text().trim();
			
			
			//����������������ӵ�������ͬ���û���Ӱ�ť
			if(((parseInt($(this).find("td:eq(5)").attr("v_att_num"))+parseInt(temp_count)))==max_num){
				$(this).find("td:last").find("input").attr("disabled","disabled");
			}else{
				//ɾ����ʱ��С���������
				$(this).find("td:last").find("input").removeAttr("disabled");
			}
		
	});
}

function delete_mem(bt){
	if(rdShowConfirmDialog('ȷ��ɾ����¼��')!=1) return;
	$(bt).parent().parent().remove();
	$("#btn_del_mem").removeAttr("disabled");
	$("#btn_upd_mem").removeAttr("disabled");
	ref_table_RoleCode();
}


function del_mem(bt){
	
		$(bt).parent().parent().find("td:eq(5)").find("input").attr("disabled","disabled");
	    		var tr_html = "<tr>"+
								"<td>"+$(bt).parent().parent().find("td:eq(0)").text().trim()+"</td>"+
								"<td style='display:none'>"+$(bt).parent().parent().find("td:eq(1)").text().trim()+"</td>"+
								"<td>"+$(bt).parent().parent().find("td:eq(2)").text().trim()+"</td>"+
								"<td>�˶�</td>"+
								"<td><input type='button' value='ɾ��' class='b_text' onclick='d_tr_del_mem(this)' /></td>"+
								"<td style='display:none'>d</td>"+//��־λ �˶�����ӡ����
								"<td style='display:none'>"+$(bt).parent().parent().find("td:eq(3)").text().trim()+"</td>"+//��Чʱ�� 
								"<td style='display:none'>"+$(bt).parent().parent().find("td:eq(6)").text().trim()+"</td>"+//
								"</tr>";
					$("#table_Role_result").append(tr_html);
}

function d_tr_del_mem(bt){
		if(rdShowConfirmDialog('ȷ��ɾ����¼��')!=1) return;
	 $(bt).parent().parent().remove();
	 var phoneNo_td = $(bt).parent().parent().find("td:eq(0)").text().trim();
	 if(phoneNo_td.length>11){
	 			phoneNo_td = phoneNo_td.substring(0,11);
	 }
	 $("#old_mem_table tr:gt(0)").each(function(){
	 		var phoneNo_td_each = $(this).find("td:eq(0)").text().trim();
	 		
	 		if(phoneNo_td_each==phoneNo_td){
	 			$(this).find("td:eq(5)").find("input").removeAttr("disabled");
	 			return false;
	 		}
	 });
}


function upd_mem(bt){
		
		$(bt).parent().parent().find("td:eq(5)").find("input").attr("disabled","disabled");
	 
		var trObj = $(bt).parent().parent();
		var role_code = trObj.find("td:eq(1)").text().trim();
		var role_name = trObj.find("td:eq(2)").text().trim();
		var phoneNo_upd = trObj.find("td:eq(0)").text().trim();
		var shengxiao = trObj.find("td:eq(3)").text().trim();
		
		var inCheckFlag = trObj.find("td:eq(5)").text().trim();
		
		$("#op_type").val("u");//��־λΪ���
		$("#operRoleId").val(role_code);
		$("#operRolename").val(role_name);
		$("#phoneNo_upd").val(phoneNo_upd);
		$("#shengxiaoshijian").val(shengxiao);
		
		$("#inCheckFlag").val(inCheckFlag);
		
		
		$("#op_6_flag").val(trObj.find("td:eq(6)").text().trim());
		
		
		$("#role_name_span").text("���"+role_name+"-");
		
		$("#phoneNo").val("");
		$("#phoneNo").removeAttr("readOnly");
		$("#phoneNo").removeClass("InputGrey");
		$("#pwdContent").show();
		$("#sel_kd_flag").hide();
		
		$("#opr_info").show();
		
}

function go_cfm(){
	
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
	
	if($("#table_Role_result tr:gt(0)").size()==0){
		rdShowMessageDialog("������Ա�б�");
		return;
	}
	
	 showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes"); 
   if(rdShowConfirmDialog("ȷ��Ҫ�ύ��Ϣ��")!=1) return;

		//var in_json = "{    \"OPR_INFO\": {        \"PHONE_NO\": \"123456\",        \"OP_CODE\": \"\",        \"LOGIN_NO\": \"\",        \"LOGIN_ACCEPT\": \"\",        \"BACK_ACCEPT\": \"\",        \"OPR_TIME\": \"\"    },    \"BUSI_INFO\": {        \"MAIN_OFFER_LIST\": [            {                \"PHONE_NO\": \"\",                \"EFF_TYPE\": \"\",                \"OFFER_ID\": \"\"            }        ],        \"ADD_OFFER_LIST\": [            {                \"PHONE_NO\": \"11111\",                \"EFF_TYPE\": \"\",                \"OFFER_ID\": \"\",                \"OPERATE_TYPE\": \"\"            },            {                \"PHONE_NO\": \"22222\",                \"EFF_TYPE\": \"\",                \"OFFER_ID\": \"\",                \"OPERATE_TYPE\": \"\"            }        ],        \"SP_OFFER_LIST\": [            {                \"PHONE_NO\": \"\",                \"EFF_TYPE\": \"\",                \"OFFER_ID\": \"\",                \"OPERATE_TYPE\": \"\"            }        ],        \"GROUP_INFO_LIST\": [            {                \"OPERATE_TYPE\": \"I\",                \"PHONE_NO\": \"123\",                \"GROUP_ID\": \"1111111\",                \"EFF_DATE\": \"yyyymmdd hh24:mi:ss\",                \"EXP_DATE\": \"yyyymmdd hh24:mi:ss\",                \"MEMBER_ROLE_ID\": \"\",                \"MEMBER_TYPE_ID\": \"\"            },            {                \"OPERATE_TYPE\": \"I\",                \"PHONE_NO\": \"456\",                \"GROUP_ID\": \"111111\",                \"EFF_DATE\": \"yyyymmdd hh24:mi:ss\",                \"EXP_DATE\": \"yyyymmdd hh24:mi:ss\",                \"MEMBER_ROLE_ID\": \"\",                \"MEMBER_TYPE_ID\": \"\"            }        ]    }}";
		//ƴ���json
		var OPR_INFO_json = {
													"PHONE_NO":"<%=activePhoneNo%>",
									        "OP_CODE": "<%=opCode%>",
									        "LOGIN_NO": "<%=workNo%>",
									        "LOGIN_ACCEPT": "<%=sysAcceptl%>",
									        "BACK_ACCEPT": "",
									        "OPR_TIME": "<%=currentDate%>",
									        "OP_NOTE":"��ͥ�û����Ա��ϵ����",
									        "CHK_FLAG":"<%=vChkFlag%>",
									        "PROD_CODE":"<%=j_ProdCode%>",
                					"PROD_CODE_DW":"<%=j_GearCode%>",
                					"GROUP_ID":"<%=j_group_id%>"
												};
		
		var HOME_PHONE="";
		var MASTER_PHONE="";
		$("td[name='rolenames']").each(function (i){
			if($(this).text()=="207��ͥ�û�"){
				HOME_PHONE=$("td[name='rolephones']").eq(i).text();
			}
			if($(this).text()=="������"){
				MASTER_PHONE=$("td[name='rolephones']").eq(i).text();
			}
		});
		
		var LOGINOPR_json = [];
		
		var temp_json = {"PHONE_NO":"<%=activePhoneNo%>"};
    LOGINOPR_json.push(temp_json);
    
    
		var GROUP_INSTANCE_MEMBER_LIST = [];
		var BASELINE_INFO_LIST = [];
		
		 						
     $("#table_Role_result tr:gt(0)").each(function(){
     			var td_flag = $(this).find("td:eq(5)").text().trim();
     			var phoneNo = $(this).find("td:eq(0)").text().trim();
     			var role_id = $(this).find("td:eq(1)").text().trim();
     			var role_name = $(this).find("td:eq(2)").text().trim();
     				
     			//alert("td_flag = "+td_flag+"\nphoneNo = "+phoneNo+"\nrole_id = "+role_id+"\nrole_name = role_name");
     			
     			
     			
     			if(td_flag=="i"){
     				var temp_member_json = 		{
                    "MEMBER_OPERATE_TYPE": "I",
                    "PHONE_NO": $(this).find("td:eq(0)").text().trim(),
                    "GROUP_ID": "<%=j_group_id%>",
                  	"EFF_DATE": "<%=currentDate%>",
                		"EXP_DATE": "20500101 00:00:00",
                    "MEMBER_ROLE_ID":$(this).find("td:eq(1)").text().trim(),
                    "MEMBER_TYPE_ID": "4",
                    "MEMBER_TYPE":"PH",
                    "MEMBER_DESC":$(this).find("td:eq(2)").text().trim()
			      };		
			          GROUP_INSTANCE_MEMBER_LIST.push(temp_member_json);
			          if(<%=j_order_marked%>==2&&"<%=j_prod_flag%>"=="D"&&"Y"==$(this).find("td:eq(7)").text().trim()){
			          	var temp_baseline_json = 		{
                    "OPERATE_TYPE": "1",
                    "HOME_PHONE": HOME_PHONE,
                    "MASTER_PHONE": MASTER_PHONE,
                    "MEMBER_PHONE": $(this).find("td:eq(0)").text().trim(),
                    "GROUP_ID": "<%=j_group_id%>",
                  	"EFF_DATE": "<%=currentDate%>",
                		"EXP_DATE": "20500101 00:00:00"
			          	};
			          	BASELINE_INFO_LIST.push(temp_baseline_json);
			          }
          
     			}
     			
     			if(td_flag=="d"){
     				
     				var temp_member_json = 		{
                    "MEMBER_OPERATE_TYPE": "U",
                    "PHONE_NO": $(this).find("td:eq(0)").text().trim(),
                    "GROUP_ID": "<%=j_group_id%>",
                  	"EFF_DATE": $(this).find("td:eq(6)").text().trim(),
                		"EXP_DATE": "<%=n_month_Date1%>",
                    "MEMBER_ROLE_ID":$(this).find("td:eq(1)").text().trim(),
                    "MEMBER_TYPE_ID": "4",
                    "MEMBER_TYPE":"PH",
                    "MEMBER_DESC":$(this).find("td:eq(2)").text().trim()
			      };		
			      
			      if("<%=j_order_marked%>"=="1"){	
			      	temp_member_json.EXP_DATE = "<%=currentDate%>";
			      }
	          GROUP_INSTANCE_MEMBER_LIST.push(temp_member_json);
	          
	          
	          if(<%=j_order_marked%>==2&&"<%=j_prod_flag%>"=="D"&&"Y"==$(this).find("td:eq(7)").text().trim()){
	          	var temp_baseline_json = 		{
                "OPERATE_TYPE": "2",
                "HOME_PHONE": HOME_PHONE,
                "MASTER_PHONE": MASTER_PHONE,
                "MEMBER_PHONE": $(this).find("td:eq(0)").text().trim(),
                "GROUP_ID": "<%=j_group_id%>",
              	"EFF_DATE": "",
            		"EXP_DATE": "<%=n_month_Date1%>"
	          	};
	          	BASELINE_INFO_LIST.push(temp_baseline_json);
	          }
     			}
     			
     			if(td_flag=="u"){//���ƴ2����һ���˶�һ������
     				
     				var phoneNo_arr = phoneNo.split("->");
     				
     				var temp_member_json = 		{
                    "MEMBER_OPERATE_TYPE": "I",
                    "PHONE_NO": phoneNo_arr[1],
                    "GROUP_ID": "<%=j_group_id%>",
                  	"EFF_DATE": "<%=currentDate%>",
                		"EXP_DATE": "20500101 00:00:00",
                    "MEMBER_ROLE_ID":$(this).find("td:eq(1)").text().trim(),
                    "MEMBER_TYPE_ID": "4",
                    "MEMBER_TYPE":"PH",
                    "MEMBER_DESC":$(this).find("td:eq(2)").text().trim()
			      };	
			      
			      if("<%=j_order_marked%>"=="2"){	
			      	temp_member_json.EFF_DATE="<%=n_month_Date%>".substring(0,8);
			      }
			          GROUP_INSTANCE_MEMBER_LIST.push(temp_member_json);
			          if(<%=j_order_marked%>==2&&"<%=j_prod_flag%>"=="D"&&"Y"==$(this).find("td:eq(7)").text().trim()){
			         		var temp_baseline_json = 		{
                    "OPERATE_TYPE": "1",
                    "HOME_PHONE": HOME_PHONE,
                    "MASTER_PHONE": MASTER_PHONE,
                    "MEMBER_PHONE": phoneNo_arr[1],
                    "GROUP_ID": "<%=j_group_id%>",
                  	"EFF_DATE": "<%=n_month_Date1%>",
                		"EXP_DATE": "20500101 00:00:00"
				          };
				          BASELINE_INFO_LIST.push(temp_baseline_json);
			          }
			          var temp_member_json = 		{
                    "MEMBER_OPERATE_TYPE": "U",
                    "PHONE_NO":  phoneNo_arr[0],
                    "GROUP_ID": "<%=j_group_id%>",
                  	"EFF_DATE": $(this).find("td:eq(6)").text().trim(),
                		"EXP_DATE": "<%=n_month_Date1%>",
                    "MEMBER_ROLE_ID":$(this).find("td:eq(1)").text().trim(),
                    "MEMBER_TYPE_ID": "4",
                    "MEMBER_TYPE":"PH",
                    "MEMBER_DESC":$(this).find("td:eq(2)").text().trim()
			          };		
			          
			          if("<%=j_order_marked%>"=="1"){	
					      	temp_member_json.EXP_DATE = "<%=currentDate%>";
					      }
					      
			          GROUP_INSTANCE_MEMBER_LIST.push(temp_member_json);
			          if(<%=j_order_marked%>==2&&"<%=j_prod_flag%>"=="D"&&"Y"==$(this).find("td:eq(7)").text().trim()){
			          	var temp_baseline_json = 		{
		                "OPERATE_TYPE": "2",
		                "HOME_PHONE": HOME_PHONE,
		                "MASTER_PHONE": MASTER_PHONE,
		                "MEMBER_PHONE": phoneNo_arr[0],
		                "GROUP_ID": "<%=j_group_id%>",
		              	"EFF_DATE": "<%=currentDate%>",
		            		"EXP_DATE": "<%=n_month_Date1%>"
			          	};
			          	BASELINE_INFO_LIST.push(temp_baseline_json);
			          }
     			}
     			
     			if(td_flag=="u"){
     				var phoneNo_arr = phoneNo.split("->");
	     			var temp_json = {"PHONE_NO":phoneNo_arr[0]};
	    			LOGINOPR_json.push(temp_json);
	    			
	    			var temp_json = {"PHONE_NO":phoneNo_arr[1]};
	    			LOGINOPR_json.push(temp_json);
	    			
    			}else{
    				var temp_json = {"PHONE_NO":$(this).find("td:eq(0)").text().trim()};
	    			LOGINOPR_json.push(temp_json);
    			}
					
			});           
		
		
		
		var BUSI_INFO_json={};
		
	 BUSI_INFO_json = {
				"GROUP_INFO":{
					"GROUP_INSTANCE_MEMBER_LIST":GROUP_INSTANCE_MEMBER_LIST
				},
				"LOGINOPR":LOGINOPR_json
				} 
		
		if(BASELINE_INFO_LIST.length>0){
			BUSI_INFO_json["BASELINE_INFO"]=BASELINE_INFO_LIST;
		}
					          
		var in_json_obj = {
												"OPR_INFO":OPR_INFO_json,
												"BUSI_INFO":BUSI_INFO_json
											};
		
		
		var in_JSONText = JSON.stringify(in_json_obj,function(key,value){
													return value;
											});
											
								
		var packet = new AJAXPacket("fm357_3.jsp","���Ժ�...");
	      packet.data.add("opCode","<%=opCode%>");// 
	      packet.data.add("phoneNo","<%=activePhoneNo%>");//�ֻ���
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
      var phoneNo="<%=activePhoneNo%>";                  //�ͻ��绰
      
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
      
      cust_info+="�ֻ����룺   "+"<%=activePhoneNo%>"+"|";
      cust_info+="�ͻ�������   "+$("#prt_cust_name").val()+"|";
      
      opr_info += "ҵ������ʱ�䣺" + '<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>' + 
      						"    �û�Ʒ�ƣ�"+$("#prt_cust_bran").val()+"|";
      						
      opr_info += "ҵ��������ƣ���ͥ�û����Ա��ϵ����    ������ˮ: "+"<%=sysAcceptl%>" +"|";
      opr_info += "��ͥ�������룺<%=activePhoneNo%>"+"|";
      
      
      var temp_phone_no1 = "";
      var temp_phone_no2 = "";
      
      
      $("#table_Role_result tr:gt(0)").each(function(){
     			var td_flag = $(this).find("td:eq(5)").text().trim();
     			var phone_no = $(this).find("td:eq(0)").text().trim();
     			
     			if(td_flag=="i"){
          	temp_phone_no1 += phone_no+"��"	;
     			}
     			
     			if(td_flag=="d"){
     				temp_phone_no2 += phone_no+"��"	;
     			}
     			
     			if(td_flag=="u"){
     				var phoneNo_arr = phone_no.split("->");
     				temp_phone_no1 += phoneNo_arr[1]+"��"	;
     				temp_phone_no2 += phoneNo_arr[0]+"��"	;
    			}
					
			});       
			
			if(temp_phone_no1.length>0){
				temp_phone_no1 = temp_phone_no1.substring(0,temp_phone_no1.length-1);
			}
			if(temp_phone_no2.length>0){
				temp_phone_no2 = temp_phone_no2.substring(0,temp_phone_no2.length-1);
			}
			
			opr_info += "����������ͥ��Ա���룺";
			opr_info   += temp_phone_no1+"|";
			
			opr_info += "����ɾ����ͥ��Ա���룺";
			opr_info   += temp_phone_no2+"|";
			
      note_info1 += "������ͥ��Ʒǰ��������Ա������Ч��ɾ����Ա������Ч"+"|";
      note_info1 += "������ͥ��Ʒ��������Ա������Ч��ɾ����Ա������Ч"+"|";

      
      retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
      retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
      return retInfo;
    }

function go_get_prt_info(){
		var packet = new AJAXPacket("fm357_7.jsp","���Ժ�...");
	      packet.data.add("opCode","<%=opCode%>");// 
	      packet.data.add("phoneNo","<%=activePhoneNo%>");//�ֻ���
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
	go_ajax_sm357Qry("2","","<%=j_GearCode%>","<%=activePhoneNo%>");
	
	if("<%=j_ProdCode%>"=="JTFX"){
		//rdShowMessageDialog("�ͼҷ����ͥ��Ʒ����ǰ�����������ֻ���Ա���");
		$("#tr_JTFX_hit").show();
	}else{
		$("#tr_JTFX_hit").hide();
	}
});
</SCRIPT>
</HEAD>	
<BODY>
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
		  	<%=j_ProdName%>
		  </td>
 
	    <td class="blue" width="20%">��Ʒ��λ</td>
		  <td width="30%">
			   <%=j_GearName%>
		  </td>
	</tr>
	<tr>
		<td class="blue">Ⱥ��</td>
		<td colspan="3">
			<%=j_group_id%>
		</td>
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
					<input type="hidden" id="phoneNo_upd" name="phoneNo_upd" />
					<input type="hidden" id="op_type" name="op_type" />
					<input type="hidden" id="op_6_flag" name="op_6_flag" />
					<input type="hidden" id="shengxiaoshijian" name="shengxiaoshijian" />
					
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
					<input type="button" class="b_foot" value="ȡ��"          onclick="close_mem(0)"           />
				</td>
			</tr>
		</table>
</div>

<div class="title"><div id="title_zi">����ӽ�ɫ</div></div>
<table cellSpacing="0"  id="old_mem_table">
	<tr>
		<th width="25%">�ֻ�����</th>
		<th style="display:none">��ɫ����</th>
		<th width="20%">��ɫ����</th>
		<th width="20%">��Чʱ��</th>
		<th width="20%">ʧЧʱ��</th>
		<th>����</th>
	</tr>
<%

for(int i=0;i<result_t3.length;i++){
	
	System.out.println(result_t3[i][6]+"----hm357------------result_t3["+i+"][4]------------->"+result_t3[i][4]);
	String JTFX_disabled1 = "";
	/*
	if("JTFX".equals(j_ProdCode)&&"Y".equals(JT032_isN)){
		JTFX_disabled1 = "disabled";
	}else{
		JTFX_disabled1 = "";
	}
	*/
%>
<tr>
	<td name="rolephones"><%=result_t3[i][0]%></td>
	<td style="display:none"><%=result_t3[i][6]%></td>
	<td name="rolenames"><%=result_t3[i][1]%></td>
	<td><%=result_t3[i][2]%></td>
	<td><%=result_t3[i][3]%></td>
	
	<td  style="display:none"><%=result_t3[i][9]%></td>
	<td  style="display:none"><%=result_t3[i][7]%></td>

	<td>
		<%if("Y".equals(result_t3[i][4])){%>
			<input type="button" class="b_text" id="btn_del_mem<%=i%>" <%=JTFX_disabled1%>  value="�˶�" onclick="del_mem(this)"/>
		<%}else{%>
			<input type="button" class="b_text" value="�˶�" disabled />
		<%}%>
		<%if("Y".equals(result_t3[i][5])){%>
			<input type="button" class="b_text" id="btn_upd_mem<%=i%>" value="���" onclick="upd_mem(this)"/>
		<%}else{%>
			<input type="button" class="b_text" value="���" disabled />
		<%}%>
	</td>
</tr>
<%
}
%>
</table>

<div class="title"><div id="title_zi">�����б�</div></div>
<table cellSpacing="0" id="table_Role_result">
	<tr>
		<th width="45%">�ֻ�����</th>
		<th width="20%">��ɫ����</th>
		<th width="20%">��������</th>
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
</BODY>
</HTML>