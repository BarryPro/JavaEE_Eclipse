<%
/********************
 
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ2016-3-29 10:17:41------------------
 

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
	
	System.out.println("--hejwa------fm360_1.jsp----AAAAAAAAAAA-----Currentdate--AAAAAAAAAAA----------->"+currentDate);
		
	java.util.Calendar cal = java.util.Calendar.getInstance(); 
	cal.add(Calendar.MONTH, 1); 
	cal.set(Calendar.DATE, 1); 
	String n_month_Date = new java.text.SimpleDateFormat("yyyyMMdd 00:00:00").format(new java.util.Date(cal.getTimeInMillis()));


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
	
%> 
		
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
		
		if("N".equals(vChkFlag)){
%>
<SCRIPT language=JavaScript>
	rdShowMessageDialog("���û�δ������ͥ���뵽m357���д���");
	removeCurrentTab();
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
	
	String j_offer_flag  = "";
	String prod_eff_date = "";
	String prod_order_flag = "";
	String sp_type = "";
	
	if("000000".equals(code)){
		if(result_t2.length>0){
			j_ProdCode = result_t2[0][1];
			j_ProdName = result_t2[0][0];
			j_GearCode = result_t2[0][3];
			j_GearName = result_t2[0][2];
			j_group_id = result_t2[0][4];
			j_offer_flag    = result_t2[0][5];
			prod_order_flag = result_t2[0][6];
			prod_eff_date   = result_t2[0][7];
			sp_type = result_t2[0][11];
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
		 String paraAray4[] = new String[8];
						paraAray4[0] = "";                                       //��ˮ
						paraAray4[1] = "01";                                     //��������
						paraAray4[2] = opCode;                                   //��������
						paraAray4[3] = (String)session.getAttribute("workNo");   //����
						paraAray4[4] = (String)session.getAttribute("password"); //��������
						paraAray4[5] = activePhone;                            //�û�����
						paraAray4[6] = "";       
						paraAray4[7] = j_GearCode;    	
%>


  <wtc:service name="sm358Qry" outnum="17" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=paraAray4[0]%>" />
		<wtc:param value="<%=paraAray4[1]%>" />	
		<wtc:param value="<%=paraAray4[2]%>" />
		<wtc:param value="<%=paraAray4[3]%>" />
		<wtc:param value="<%=paraAray4[4]%>" />
		<wtc:param value="<%=paraAray4[5]%>" />
		<wtc:param value="<%=paraAray4[6]%>" />
		<wtc:param value="<%=paraAray4[7]%>" />	
	</wtc:service>
	<wtc:array id="result_t4" scope="end"  />
		
<%
if("1".equals(prod_order_flag)){
	n_month_Date = currentDate;
}
%>
<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<script language="javascript" type="text/javascript" src="/npage/public/json2.js"></script>	
<SCRIPT language=JavaScript>

var j_EFF_DATE = "";

//����ˢ��ҳ��
function reSetThis(){
	  location = location;	
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



function go_cfm(){
 
	
		var OPR_INFO_json = {
												"PHONE_NO":"<%=activePhone%>",
								        "OP_CODE": "<%=opCode%>",
								        "LOGIN_NO": "<%=workNo%>",
								        "LOGIN_ACCEPT": "<%=sysAcceptl%>",
								        "BACK_ACCEPT": "",
								        "OPR_TIME": "<%=currentDate%>",
								        "PROD_CODE":"<%=j_ProdCode%>",//��Ʒ����
        								"PROD_CODE_DW":"<%=j_GearCode%>",//��λ����
        								"OP_NOTE":"��ͥ����",//������ע
        								"GROUP_ID":"<%=j_group_id%>",
        								"BACK_ACCEPT": $("#loginAccept").val(),
        								"SP_TYPE":"<%=sp_type%>"
											};

			
		
		//����ӽ�ɫ����־λΪY��ƴһ����¼
		var PAY_INFO_json      = [];
		var BASELINE_INFO_json = [];
		
		$("#old_mem_table tr:gt(0)").each(function(){
			if($(this).find("td:eq(5)").text().trim()=="Y"){//�±�8�ı�־λ
				var t_PAY_INFO_json = {
									"OPERATE_TYPE": "U",
	                "MASTER_PHONE": "<%=activePhone%>",
	                "MEMBER_PHONE": $(this).find("td:eq(0)").text().trim(),
	                "EFF_DATE":"",
	                "EXP_DATE": "<%=n_month_Date%>"
				};
				PAY_INFO_json.push(t_PAY_INFO_json);
			}
			
			if($(this).find("td:eq(6)").text().trim()=="Y"){//�±�7�ı�־λ
				var t_BASELINE_INFO_json = {
					 			"OPERATE_TYPE": "2",
                "HOME_PHONE": "<%=phoneNo_207%>",
                "MASTER_PHONE": "<%=activePhone%>",
                "MEMBER_PHONE": $(this).find("td:eq(0)").text().trim(),
                "GROUP_ID": "<%=j_group_id%>",
                "EFF_DATE": "",
                "EXP_DATE": "<%=n_month_Date%>"
									 
				};
				BASELINE_INFO_json.push(t_BASELINE_INFO_json);
			}
		});
		
		
    var SP_OFFER_LIST_json   = [];
    
    var LOGINOPR_json = [];
		
		var temp_json = {"PHONE_NO":"<%=activePhone%>"};
    LOGINOPR_json.push(temp_json);
    
    
    $("#old_offer_table").find("input[type='hidden']").each(function(){
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
				
		 
				
				//3�����ͽڵ㣬��Ҫ�ж�
				if(t_v_CodeName=="SP_OFFER_LIST"){
					var CFM_LOGIN = "";
					$("#old_mem_table").find("td[name='rolename']").each(function(i){
							if($(this).text()=="�����Ա"){
								CFM_LOGIN=$("#old_mem_table").find("td[name='phonenumber']").eq(i).text();
							}
						});
					var t_temp_json={
									 "OPERATE_TYPE": "D",//I�������� U�����˶�
		                "MEMBER_PHONE": t_PHONE_NO,//��Ա����
		                "MASTER_PHONE":"<%=activePhone%>",//�����˺���
		                "OFFER_ID": $(this).attr("v_BPopedomCode"),//�ʷѴ���
		                "EFF_DATE": "",
		                "EXP_DATE": "<%=n_month_Date%>",
		                "CFM_LOGIN":CFM_LOGIN
					};					
					SP_OFFER_LIST_json.push(t_temp_json);
				}
    });
    

    
    
		var BUSI_INFO_json={};
		BUSI_INFO_json = {
					"PAY_INFO":PAY_INFO_json,
      		"FAM_INS_INFO":{
						"OPERATE_TYPE": "D",//��������  U�����޸�
						"GROUP_ID":"<%=j_group_id%>",//��ͥȺ��
						"STATE":"1",//Ĭ��2
						"PROD_EFF_DATE": "<%=prod_eff_date%>",//��Ʒ��Чʱ�� 
						"PROD_EXP_DATE": "<%=n_month_Date%>"
					},
					"LOGINOPR":LOGINOPR_json
					
			};
 

		
		
		if(SP_OFFER_LIST_json!=""){
			BUSI_INFO_json["SP_OFFER_LIST"]=SP_OFFER_LIST_json;
		}
		if(BASELINE_INFO_json.length>0){
			BUSI_INFO_json["BASELINE_INFO"]=BASELINE_INFO_json;
		}
		
		
		if("<%=j_offer_flag%>"=="Y"){
			BUSI_INFO_json["SPECIAL_FUND_INFO"]={
		    "OPERATE_TYPE": "D",//I����ר�� Uȡ��ר�� D����ר��
		    "SPECIAL_FUND_FEE": "",//ר����
		    "EFF_DATE": "",//ר�ʼʱ��
		    "EXP_DATE": "<%=n_month_Date%>"
			};
		}
					
		var in_json_obj = {
												"OPR_INFO":OPR_INFO_json,
												"BUSI_INFO":BUSI_INFO_json
											};
	
	//ƴ���json
		var in_JSONText = JSON.stringify(in_json_obj,function(key,value){
													return value;
											});
				
				
				
	  showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes"); 
   if(rdShowConfirmDialog("ȷ��Ҫ�ύ��Ϣ��")!=1) return;
		
	//	$("#messagediv").text(in_JSONText);
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
      						
      opr_info += "����ҵ�����ƣ���ͥ����    ������ˮ: "+"<%=sysAcceptl%>" +"|";
      
      
      note_info1 += "��ע��|";
    	
			
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
	
	$("#old_offer_table tr:gt(0)").each(function(){
		if($(this).find("td:eq(1)").text().trim()==""){
			$(this).hide();
		}
	});
	
	//�ҵ�����13λΪN����������Ĭ��ѡ��	
	$("#old_offer_table input[type='hidden'][v_is_show='N']").each(function(){
		$(this).attr("checked","checked");
		$(this).parent().parent().hide();
	});

});    




function go_check_accept(){
		if($("#loginAccept").val()==""){
			rdShowMessageDialog("�����������ˮ");
			return;
		}
   var packet = new AJAXPacket("fm361_2.jsp","���Ժ�...");
        packet.data.add("opCode","<%=opCode%>");//
        packet.data.add("phoneNo","<%=activePhone%>");//
        packet.data.add("loginAccept",$("#loginAccept").val().trim());//
    core.ajax.sendPacket(packet,do_check_accept);
    packet =null;
}
//��ѯ�ͻ�������Ϣ�ص�
function do_check_accept(packet){
    var error_code = packet.data.findValueByName("code");//���ش���
    var error_msg =  packet.data.findValueByName("msg");//������Ϣ

    if(error_code=="000000"){//�����ɹ�
      rdShowMessageDialog("У��ɹ�",2);
      $("#loginAccept").attr("disabled","disabled");
      $("#check_accept").attr("disabled","disabled");
      $("#submit").removeAttr("disabled");
    }else{//���÷���ʧ��
    	rdShowMessageDialog("У��ʧ�ܣ�"+error_code+"��"+error_msg,0);
    	$("#submit").attr("disabled","disabled");
    }
}


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



<div class="title"><div id="title_zi">�Ѷ����ʷ��б�</div></div>
<table cellSpacing="0"  id="old_offer_table">
	 <tr>
		<th width="25%">�ʷѷ���</th>
		<th >�ʷ�����</th>
	</tr>
<%
String ja_ClssName = "";
if(result_t4.length>0){
	ja_ClssName = result_t4[0][10];
	out.print("<tr v_OfferFlag='"+result_t4[0][11]+"'>");
	out.print("<td>"+result_t4[0][10]+"</td>");
	out.print("<td >");
}

for(int i=0;i<result_t4.length;i++){

if(ja_ClssName.equals(result_t4[i][10])){//һ��
if("Y".equals(result_t4[i][9])){
%>

	<input  type="hidden" name="offer_radio_<%=result_t4[i][4]%>"
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
														v_is_show='<%=result_t4[i][13]%>'
	 />
	
	<a href="javascript:void(0)" onclick="show_offer_det('<%=result_t4[i][10]%>','<%=result_t4[i][6]%>','<%=result_t4[i][7]%>','<%=result_t4[i][8]%>')"><%=result_t4[i][6]%></a>

<%
}	
}else{
	out.print("</td>");
	out.print("</tr>");
	out.print("<tr v_OfferFlag='"+result_t4[i][11]+"'>");
	out.print("<td>"+result_t4[i][10]+"</td>");
	out.print("<td >");
	if("Y".equals(result_t4[i][9])){
%>
	<input  type="hidden" name="offer_radio_<%=result_t4[i][4]%>"
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
														v_is_show='<%=result_t4[i][13]%>'
	 />
	
	<a href="javascript:void(0)" onclick="show_offer_det('<%=result_t4[i][10]%>','<%=result_t4[i][6]%>','<%=result_t4[i][7]%>','<%=result_t4[i][8]%>')"><%=result_t4[i][6]%></a>

<%	
}
	ja_ClssName = result_t4[i][10];
}
%>

	
<%
}

if(result_t4.length>0){
	out.print("</td>");
	out.print("</tr>");
}	
%>

</table>


<table cellSpacing="0">
	 <tr>
	 	<td class="blue" width="25%">
	 		������ˮ��
	 	</td>
	 	<td>
	 		<input type="text" name="loginAccept" id="loginAccept" maxlength="14" v_type="0_9" v_must="1"  onblur="checkElement(this)" />
	 		<input type="button" class="b_text" id="check_accept" value="У��" onclick="go_check_accept()" />
	 	</td>
	</tr>
</table>

<table cellSpacing="0">
	<tr>
	 	<td style="color:red" align="center">
	 		ħ�ٺ��豸��ȥ��(g836)Ѻ�𷵻�ҵ�񡱽��з���
	 	</td>
	</tr>
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="ȷ��" onclick="go_cfm()"   id="submit"  disabled      />
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